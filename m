Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF29619886
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKDNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKDNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:55:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1D2EF6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:55:19 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x15so3026839qtv.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehxmhy4tAHWSbEh2sXnHAvnOr4w5ROlpTnej7pSY4Yo=;
        b=lU0zC3tbM0FXmD8k7A44xszngijWaUONXo402a0cS3lUudSFyM2taMvV5UStaDpiDx
         baEbDMjidPA7BWF9jE62WRyzPDk8uhmV9X+I4u0U2Z/UME8LVoF+b0wfs/4Nen1B0TLY
         afqKR0dMHxU4QFlsuRvHWK1J7wZGzIy7TBL3aEQBaKlxU3iMWi5vf/fb9Qs9VhinoA/u
         gjZcFrdAGXGSAk4tmGkhVSMPHlzS0YgX+FhYksbKAla2ghmXqCqWY1/ajEyXRVN8t6fu
         pvTW3VKVFo79/+atGwDMki1z154MVHWvc2NmT81W8yxNBeumj7VAhWYuMCstjDyeSI8a
         eTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehxmhy4tAHWSbEh2sXnHAvnOr4w5ROlpTnej7pSY4Yo=;
        b=67qFaFXB36ZgKr3djEdKLNhCiReZEa2yEaQBHhCmnVxW3+t9JZ+XUZ4QnLanOFfwMC
         VFMExzZ/tOidO54UhPuH5rgpeumsrlcXCqxbCq9zZzqTyllmoce1WGq4GvvcoUSYBZ1i
         DCxTQZG3zMpgZW97CZAzEKPlKTYsj72Jf01Aog33VFIpSau0TCH+wrJim4F3izTy141e
         dpz3SGtYGTA8Jb8ZJzZ31pXqZ/EGm7KmOdwFo/5rhbrkUmYOygVVCU1mu8MZV1SmaGuB
         saRcRENgv6w+UxV6ftNfw9Ss48RbSf/SBYtfoUW/rYH5ZMlX4fZnuX4KH25oMfcjr8wm
         Su/Q==
X-Gm-Message-State: ACrzQf0SSTkWzH6GvakHKDX/ojLVARBdg0wmF48FNRiR/Da6eo1FQmWr
        rnLqEMfA/wJsw+6SLbi4OeBEr59FWG3Z9Q==
X-Google-Smtp-Source: AMsMyM5+1hK78x/ofuVGTwjjBFP8elpNO/eeZxBLGWTPbx72HYwMV4bQWa+zaKvjGkrEYrxR6C4yzw==
X-Received: by 2002:ac8:58cf:0:b0:3a5:6887:148f with SMTP id u15-20020ac858cf000000b003a56887148fmr2023265qta.606.1667570118348;
        Fri, 04 Nov 2022 06:55:18 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id 20-20020ac85954000000b003a4f435e381sm2560456qtz.18.2022.11.04.06.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:55:17 -0700 (PDT)
Message-ID: <8f026f38-ef09-788e-7bd8-45683b074075@linaro.org>
Date:   Fri, 4 Nov 2022 09:55:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: clock: exynosautov9: fix reference to
 CMU_FSYS1 mmc card clock
Content-Language: en-US
To:     Inbaraj <inbaraj.e@samsung.com>, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, chanho61.park@samsung.com
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pankaj.dubey@samsung.com
References: <CGME20221104085410epcas5p24d88f59001b739075e9e190e2c47841e@epcas5p2.samsung.com>
 <20221104090019.88387-1-inbaraj.e@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104090019.88387-1-inbaraj.e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 05:00, Inbaraj wrote:
> Fix reference to CMU_FSYS1 mmc card clock to gout clock instead of dout.
> 
> This fixes make dtbs_check warning as shown below:
> 
> arch/arm64/boot/dts/exynos/exynosautov9-sadk.dtb: clock-controller@17040000:
> clock-names:2: 'dout_clkcmu_fsys1_mmc_card' was expected
> From schema: /home/inbaraj/mainline/linux/Documentation/devicetree/
> bindings/clock/samsung,exynosautov9-clock.yaml

I don't understand:
1. Why bindings are wrong not DTSI?
2. What is "gout"? "dout" had a meaning as clock divider output.

> 
> Fixes: 4b6ec8d88623 ("dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1")
> Signed-off-by: Inbaraj <inbaraj.e@samsung.com>
> ---
>  .../devicetree/bindings/clock/samsung,exynosautov9-clock.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> index 2ab4642679c0..55c4f94a14d1 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> @@ -148,7 +148,7 @@ allOf:
>            items:
>              - const: oscclk
>              - const: dout_clkcmu_fsys1_bus
> -            - const: dout_clkcmu_fsys1_mmc_card
> +            - const: gout_clkcmu_fsys1_mmc_card
>              - const: dout_clkcmu_fsys1_usbdrd
>  
>    - if:

Best regards,
Krzysztof

