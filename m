Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C83639AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiK0MzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK0MzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:55:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DD8101DD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:55:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so13571783lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNtSDMmxyyg/RnqkxVaNCA/q87Lago8y46jn3l+OIL8=;
        b=TB2oC9sI0QlxmTMXR24HfLyCe/IrGrEEtdAD3t4Q7BJkD1rD7Nt1DoGimy3ExKMgKC
         oDLkLgsfZU6KMyrDTvwNpNFpgOnhKmTjefzpYwBxGDRtK9HpKIjFFfN7jMjWZD5Zci/L
         PlDbnnZ4qId1ORTjdTVxm6olFfL8Iaz2P99EfOZPeiU1usNkBouBvUQG1nda372ugHGJ
         IWQlj1Xs+9w6A7ScvyFL7ASnRvjlfgWhwHGJRdD4dnNDcW14+UO40dS0SbMd+XbavvEV
         Y1Fm7TNzNPNGA1bMIzTaoATsfePVylo3obKkw5egzvzAmChxliLk0Z1vz0Q2wcaZBJv5
         hVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNtSDMmxyyg/RnqkxVaNCA/q87Lago8y46jn3l+OIL8=;
        b=H1zul9fF+PI6+bfqiCBYmJ4HTnGIVz7OQNpTYI8ArN0VE95NHu5paVhT0xC7VbXI3C
         3Pc4goDRT0FmZ7p5ACVtudYgbKyLhJQ4yBO4YkMRFtsb0BspmMQpb1jqjKid21VkPY4M
         648ST6W+gOoie90lGgHJSm2oP8qNhldMJydxb8Ftj9QYM2IV7khjZApG7hnb24fj3SmL
         l26fbHL6jahVQIcNCHXTUtQKkf9b0r07e0wunMDxspmgeli2j3QxdyV4Di6C5vGSSaeX
         76+WRJYgxLQdoE3vN3uLTVyVc+xyyxmJiD4Stam8AfZwz5bjrN1R2pbOInXJiR1Rco0a
         N1Dg==
X-Gm-Message-State: ANoB5pkSwWb5p3UNw8TO1p0JLoEYHbLvOotT3ahtPzbkHuna5q2nE+yn
        VgF/IDvyNTCTnUe/tIl8qfL62A==
X-Google-Smtp-Source: AA0mqf5vkcsqW1cgwx05osYSsMYb12Kk7MQKcP6zoK5MiylsKBasnlgshtQOyd9870u9wM1k6ZalCQ==
X-Received: by 2002:ac2:5331:0:b0:4ab:35a8:2fa0 with SMTP id f17-20020ac25331000000b004ab35a82fa0mr13880098lfh.233.1669553714110;
        Sun, 27 Nov 2022 04:55:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b24-20020a196458000000b004949a8df775sm1290214lfj.33.2022.11.27.04.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 04:55:13 -0800 (PST)
Message-ID: <ab645c2e-92c9-6b83-8587-abe1a81f2a65@linaro.org>
Date:   Sun, 27 Nov 2022 13:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] dt-bindings: display: panel: mipi-dbi-spi: Add
 io-supply
Content-Language: en-US
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <affenull2345@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d8b00afb-8c60-fe9d-dad3-280a0e0254ef@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d8b00afb-8c60-fe9d-dad3-280a0e0254ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 19:02, Otto Pflüger wrote:
> Add the new io-supply property, which specifies the regulator for
> the I/O voltage supply on platforms where the panel panel power and
> I/O supplies are separate.
> 
> Signed-off-by: Otto Pflüger <affenull2345@gmail.com>
> ---
>   .../bindings/display/panel/panel-mipi-dbi-spi.yaml        | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git 
> a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
> b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> index d55bf12ecead..68cbdfab5438 100644
> --- 
> a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> +++ 
> b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> @@ -22,8 +22,9 @@ description: |
>     The standard defines the following interface signals for type C:
>     - Power:
>       - Vdd: Power supply for display module
> +      Called power-supply in this binding.
>       - Vddi: Logic level supply for interface signals
> -    Combined into one in this binding called: power-supply
> +      Called io-supply in this binding.

I have troubles understanding what is happening here and I am not sure
if this is result of corrupted patch or just diff is like that. Anyway
patch is not properly formatted, so you need to fix your setup.

Best regards,
Krzysztof

