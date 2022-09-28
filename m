Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75C5ED62D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiI1Hev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiI1Hei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:34:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFEFAC53
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:34:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c7so13348177ljm.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Fnvc6r6j9p2Uw/maOlbdTsHQYeM4YFHUi6N23GCgfiE=;
        b=Trxrl5FOcBfTyPyqjdwgGv1onqzcBiIgrzeFGhQANno1ZAMGpy9Rnvi+Qn+QmLpLi+
         RB3E3B/Qrb9aE8NYowptIPSgui7tl/0Na0XhwjhnRa/YKqZKbbDinKZ90seqRCiGFLcC
         1F1BlEqXorjYS0bxSpTdGbH4YigFAbS4LFp74iKR9IZi3AVuO+mRK3IJDTj/2733ZX1Z
         AMca4V1uSeTuwPl592enNFfqTA22NtbZ5Sx3rNNXe6XOi2ox2yV8tjdN0/36VDUDLnyv
         Cimfhn+UuCIpIofe0/hXlxifR5l1DQ+PD0VaNU4OKpqUCXIgi1SCxEGrE8W7roDS9Xv6
         rZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Fnvc6r6j9p2Uw/maOlbdTsHQYeM4YFHUi6N23GCgfiE=;
        b=Jj89Y5yWpTejV3NUReOs9uHfJ6BN/E0osoGZdy4992l+qmA4Dn0mG9ClTuTDMITS6a
         C9h1AAB2CX+WTAoAx5oJpVocRbLDvA1tZ8tb+XaMepfUlaMbFytDEl060vAp/l7kdUUn
         9lm/kF+N9XekDD27+6nFPVMx6UvaoZCOXVr4t3mBEB3bmm8pbnhsjZRXGEIHJHcPKhXC
         XLzAlRNYzBJISWkYrg/WKoFNzALLYRZJZ5FYf3iEMicg698yXVCnYcxuAxPa/Mt2vwlx
         lLYIFOZkG6AomRDQInV89tz2AgVSdMdg3hOHfhrYkww8kW51SmT8cAZJ0gxX9clT+fHX
         Dogw==
X-Gm-Message-State: ACrzQf0g5qtEDndV5RAa0/V807NGhOw93jj4rDlUnRTCwjXADo9DKGzx
        p/oF20YGJbwkpmvb1tTrAAJM2A==
X-Google-Smtp-Source: AMsMyM7Uc4iRNgLZGgIceGXd9cHAFSN8cYdcmMGhloG1FMIuZ7RUyiFPSHFJVcBvHdjHiefjvibdVQ==
X-Received: by 2002:a05:651c:211:b0:26b:e743:b4b0 with SMTP id y17-20020a05651c021100b0026be743b4b0mr11252543ljn.527.1664350387148;
        Wed, 28 Sep 2022 00:33:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a5-20020ac25e65000000b00499b57032c1sm393141lfr.144.2022.09.28.00.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:33:06 -0700 (PDT)
Message-ID: <61b52536-ddd9-bf2f-5a06-f083a39c34b3@linaro.org>
Date:   Wed, 28 Sep 2022 09:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/13] dt-bindings: rockchip: Add Hardkernel ODROID-M1
 board
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh@kernel.org>
References: <20220926183727.1893566-1-aurelien@aurel32.net>
 <20220926183727.1893566-2-aurelien@aurel32.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926183727.1893566-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 20:37, Aurelien Jarno wrote:
> From: Dongjin Kim <tobetter@gmail.com>
> 
> Add device tree binding for Hardkernel ODROID-M1 board based on RK3568
> SoC.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 7811ba64149c..d25a8a0bb2b5 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -688,6 +688,11 @@ properties:
>            - const: rockchip,rk3568-bpi-r2pro
>            - const: rockchip,rk3568
>  
> +      - description: Rockchip RK3568 Hardkernel ODROID-M1

Description should be just "Hardkernel ODROID-M1" and then put in
alphabetical order - before to other Rockchip boards.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

