Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463A55B6A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiIMJYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiIMJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:24:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C1491D4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:24:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r66-20020a1c4445000000b003b494ffc00bso473746wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z1xC0W4hin+pRPCZPd6aCVe3bFPCOSbaavZwwbQ92NU=;
        b=ZLyA097rO7m9R29VVxGS1LQdv1f2llkfNYcNRH4q4rjcN7JpZJdACp+mS7jftrii++
         +MU3EPYiEqbb/qVL3lUCNFYkCZ2elppzjyydX8EGZ5EYdNuFpOlNUp61afI8POD5Obb1
         adhZ8WsmesMgTYKZl23dsU+FVN5VtXIaCaTF9/nYU/D7ZSV6PX1+Oxe4pgw2rHJwcC8A
         ajlt4rES0tJkgc76z7nQ4MBUUu2+3r+AKqSjmcL4AN7n16InMEylzjuUnX0NhtsGMpUv
         Ddam8Rs8HxWt6MfY25qVNsQhDJDFKnUIkB2qk9FN1OJZF/MInRRitvco9piM+PM7AE/t
         H85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z1xC0W4hin+pRPCZPd6aCVe3bFPCOSbaavZwwbQ92NU=;
        b=XviUVIGQjMUI/1xUN8qtwp37tMrH25trzFUB+Xy4mnU9ovhh6dg8VS/1yENQ0HcrfI
         p2N7dHCKAk2X0ELca+tUExi7/u/k1pPMb+AZwhm3ZPfWtDRkfrtXTbQrfBTbjBDOzGrN
         3LklXUYTJE1dAMmqHyn8R6c49XQW/PI/vdOmdQjl5k68mb+NhyeKRTULRpmOZW8cCxrr
         JBDheo2M7ytDTo11TT2D5DTw3OwM7pKxst+nZGP9bDkTcdqNhI29AT1pFwlvJU8ocv78
         FjwD7J7mbFF1V2W7TP3+Sd3maG0L6sEXd4pCm4KLQM/FFsjBK0pKxvbz7iBeHvIVgY21
         tgJg==
X-Gm-Message-State: ACgBeo1C5tApB90JkygokZ+Sldi+DmZvr9zf12RswWmW+LUVzMSiPEqY
        BgUbv9ryUFHUNqWdar6uInDKqA==
X-Google-Smtp-Source: AA6agR5yK7X1AzIN26S9Ej9ya717s4rcc2ki8vtmuLlhX2g9faSGqnSMoYXKIM5ANzadPOx+SIGnSQ==
X-Received: by 2002:a05:600c:4e8c:b0:3a6:11e:cc08 with SMTP id f12-20020a05600c4e8c00b003a6011ecc08mr1670850wmq.198.1663061041001;
        Tue, 13 Sep 2022 02:24:01 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b00228dcf471e8sm9739989wrq.56.2022.09.13.02.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:24:00 -0700 (PDT)
Message-ID: <41691499-0dfc-8ee7-f767-ba89ea8b320c@linaro.org>
Date:   Tue, 13 Sep 2022 11:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] dt-bindings: phy: ti: phy-gmii-sel: Cleanup
 example
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20220912085650.83263-1-s-vadapalli@ti.com>
 <20220912085650.83263-2-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912085650.83263-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 10:56, Siddharth Vadapalli wrote:
> Change node name in example from "phy-gmii-sel" to "phy", following the
> device-tree convention of using generic node names.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
