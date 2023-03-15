Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B196BAA00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCOHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjCOHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:51:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F27042E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so16021665edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeokvEPibBw1dtKXMKz1DicJtuhNSPOwJ85/tI0fwfY=;
        b=oNl++gM5NJ8CQ/Z61jUZfAoTVqLLDkVaBWNa4SQvni2sPKi1NfNIVb15Cm7VNZDsWn
         QyGkqJmbGU01B2FFCbk3UMGia52ZDzXU5LhKVWI8SAUp/yydbNgDWUsLwTcOjtRfAJ8W
         7zLQXW1YSoxlB9q3Ytt+HksBl4mRYSDmIvVWhaz9q5trUeWEZlHjp8tRNbjr5z0oYRPe
         tcczaB+5Nz4Ynl45XYEHpmQyyIZnk6WqfG1Po61hExMx2Ssz6ewZneSCtdW8bdoXThv1
         +lglgvZCkHVJgDw0mWuqdO+1QmrlbXjLFzyfUh4EGgmKE+APW2kn9Eijp2f6HKsf1MlB
         08fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeokvEPibBw1dtKXMKz1DicJtuhNSPOwJ85/tI0fwfY=;
        b=dsNpt7m59c15sD3vLvyNZ0f6ApGI9qE1jqdRlJJ/Qj2njvtb4Z55TlA75beGtByAUL
         NG7mhIbSNt71Ozc8pejqeRPaEEd644ldPZ/EvWcO6Js0ql1PTVMnEei8H9+sor8Bb3N0
         WEhmLTqovDgYqxqmOyG+eLTGHndt+V1sRGmN+Xc7F1wQ3VZh3dLcl/fIXxrsRw2/N5hJ
         G4m7nlgEhZd5FloBx9V6FbdJtrmVeiub0lzTu4x/ij6BJaMkdM940pcDhc3oYx6YTwRe
         Og8DcUoy3an+YFKtz6XNAvcinqJWjt72tRmxcmWI1ZUsFtBlIi+lY4IVB1446v4jz4zl
         QFLw==
X-Gm-Message-State: AO0yUKUUfDgsVnf1l5yi9xXaZBUn8DSw5khGv5hc/ofz32YhgXYE5MUT
        vtTK35Zg9FiWfcxAA3935Y/29g==
X-Google-Smtp-Source: AK7set+qmNZtdtBmvH0yeosxDbfNFSuKd060nB93RcgI/W2y+gDU4NP8ElyOmUG9FGix5RlxyCMfsA==
X-Received: by 2002:a05:6402:1018:b0:4fc:9a22:e0d2 with SMTP id c24-20020a056402101800b004fc9a22e0d2mr1680992edu.14.1678866661959;
        Wed, 15 Mar 2023 00:51:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id y97-20020a50bb6a000000b004c19f1891fasm1971476ede.59.2023.03.15.00.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:51:01 -0700 (PDT)
Message-ID: <0df6bbd1-eaa7-537e-8598-7e5ba89bb274@linaro.org>
Date:   Wed, 15 Mar 2023 08:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/7] dt-bindings: display: add rotation property to
 sitronix,st7789v
Content-Language: en-US
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230314115644.3775169-1-gerald.loacker@wolfvision.net>
 <20230314115644.3775169-7-gerald.loacker@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314115644.3775169-7-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 12:56, Gerald Loacker wrote:
> From: Michael Riesch <michael.riesch@wolfvision.net>
> 
> The sitronix-st7789v driver now considers the rotation property.
> Add the property to the documentation.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

