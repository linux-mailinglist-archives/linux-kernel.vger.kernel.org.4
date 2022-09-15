Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5C5B9DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIOPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:01:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818F52E50
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:01:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso13181556wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+/YQUGKG79YoC7NHmR5xoM7tUa0JcBEoBM0TE1piCw0=;
        b=x7ObIcWspzpH54hkjhs8OwMGiLUcGWhOMmC0pBQFQxq3YZJYvi3YA73jiX+qH/6+OI
         JXl+M7Fo2u3nJG6fjPitWelyCyRJ3jXIGzZvVLEXokDA/EUQXCpwARal6i6RxJ97KYqo
         VKDeXw+aIS6Z2lbpU4e1sN1gsZbELUvuilkCg/W8iNXfqCAizIE6nlyfRODFXBZ6RypA
         0CfyWev+HCQb3ALaycsOzgjonb51SZHayj3nUov1w3e8Ub0I5OiYdymgHn5V1r5s2y4u
         PSsqubl72/uJRT1PsaXxcdXEnYsewWiCabI2Ank7nkkOCt8xm16/J2cfRF3Oo6BL7H5x
         dXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+/YQUGKG79YoC7NHmR5xoM7tUa0JcBEoBM0TE1piCw0=;
        b=2wihM6y1vmh2s24NCPHUXWoQcIsr0db9ldmc/+i+JphunLbQUYRQTk/l+TKK95Dkt7
         9JuBb9800tI8GbsjKg0THKA4rIwKmOOcAWBCMdYOFdjJPL20d0r5q8SwrVQU8NUyCwgO
         cdAGl98cBWM62SjYYnXUW5wuQN/vvfKByVtZnv+1MoQ+FblqW9lXDszqBxTRJioPpnri
         mtBk9iFutZffR+a2+cSlQs8S/0qtbBmnGEDEWI/4GSBppcFdhBERszPhb6kqQ+6nrL3X
         SMoa1BKUjx86VulaA0VNS4i9EEPFxiqi1mCpQi1ngmbQOb5qXiPTgNcK7RxLnNkW7SvM
         MQBg==
X-Gm-Message-State: ACrzQf1mcXXmQz7uq9ExDlpAjadDayQIuLjEgvqkoob7wiHNlK16FY2T
        Il0ZmVhVRIkBMZ2HpMVNXOtyoQ==
X-Google-Smtp-Source: AMsMyM6Doquqmik2Z+CTCB4I78Qh1NPhEmbjqCZB/XV48p5OywlUQjico/uVsTBXHXmBgg/gKsQW2w==
X-Received: by 2002:a1c:7412:0:b0:3b4:7a81:e7e4 with SMTP id p18-20020a1c7412000000b003b47a81e7e4mr148115wmc.15.1663254086507;
        Thu, 15 Sep 2022 08:01:26 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d694a000000b0021e51c039c5sm2825251wrw.80.2022.09.15.08.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:01:26 -0700 (PDT)
Message-ID: <69d4218e-5e85-098a-621a-e02b484285a8@linaro.org>
Date:   Thu, 15 Sep 2022 16:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
 Enterprise Edition
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220911040628.13774-1-cnsztl@gmail.com>
 <20220915022511.4267-1-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915022511.4267-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 03:25, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S
> Enterprise Edition.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
