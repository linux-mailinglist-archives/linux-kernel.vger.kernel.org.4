Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12EB68D4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjBGKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBGKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:42:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01BC170
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:42:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j25so9553038wrc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjQX5toyVmZyFFEDPSoSrTaqoGSIHeRpLwxYhtU6050=;
        b=UHX61DtMSMsDlTukE3lUUsvg7WmUUbdO41vBdM7YAVGyZyrIhDBvj3ZRGpgDwnN7CR
         ZAQc19T3RgcgNoKKVQDtKdtQ2wc4VM0SWJzjgTfFMq9T10FhyOcG09vbME5Xd/rgHDHD
         3HvNY+WFXm1YcmXykLH8Ztod4TkZYUcSuMW7sNoP9Sh591xJpRmFYJsPQr/1ciYdW8NI
         YDebVX59G7VmmV6PK9n/Wq1WBTxLY2VGqZbvMFjPIP+zpWto4bGIWgtytwyxwryHjT1R
         Pqwi6c1G7+HALb70TkQ2EaLZfd+VFoXehvx0ObbA0+iLcET6WR78ylGkf9m/8gg6PNFU
         ynJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjQX5toyVmZyFFEDPSoSrTaqoGSIHeRpLwxYhtU6050=;
        b=JqK7un/xbKamEANY6XidHNHlVvM5x6bcPORRRLT0cWNeNFt5DjsxuLtpNus1YsxCLj
         /EZ15uBNqUNTyit/XCB0SgdidEfiLEH3Xr9IGBQ3bvPNqhqiUIGWBa7UeqS4VVlf47Ie
         zTMd/Xv9q8smXcFGjozfK/vMBo9mShCP2SjBsy7bvHspz4OAekCK8p7fF8E9iHTUaccP
         jSOfFQdNVWv/glQFzvJlQUcPcsVPgdTAtcW9cG5X4Gg8ni4naZ7C0W41nJd2tUeeoJkQ
         Me7usdWIWaeBXtMUZnBOEg7QDY/qwdzF16qulEdtsGIqB6SSrJXYOf2Um8i4HP3TytRi
         yi/A==
X-Gm-Message-State: AO0yUKWIpFMMAxZ3QZ7EKdJYr+MCdhcZbp3XcmnYkcvtNNCMiLZUiLAO
        Te6aNSEO7w6LpCdol+mUZurEsA==
X-Google-Smtp-Source: AK7set8cj+1hsFTMCBGD6WhztYFclKHDVzs8N4JlHw+lhZTiXnlFlFe+TW8Mnp0zjORJwHU2fazPkQ==
X-Received: by 2002:a05:6000:985:b0:2c3:be89:7c38 with SMTP id by5-20020a056000098500b002c3be897c38mr11888335wrb.27.1675766541488;
        Tue, 07 Feb 2023 02:42:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d408d000000b002c3f42f3687sm1307866wrp.72.2023.02.07.02.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:42:21 -0800 (PST)
Message-ID: <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
Date:   Tue, 7 Feb 2023 11:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207104021.2842-3-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 11:40, Lucas Tanure wrote:
> Describe the properties used for shared boost
> configuration.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs35l41.yaml     | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> index 18fb471aa891..6f5f01bec6f1 100644
> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> @@ -85,11 +85,20 @@ properties:
>        boost-cap-microfarad.
>        External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
>        enable boost voltage.
> +      Shared boost allows two amplifiers to share a single boost circuit by
> +      communicating on the MDSYNC bus. The passive amplifier does not control
> +      the boost and receives data from the active amplifier. GPIO1 should be
> +      configured for Sync when shared boost is used. Shared boost is not
> +      compatible with External boost. Active amplifier requires
> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>        0 = Internal Boost
>        1 = External Boost
> +      2 = Reserved

How binding can be reserved? For what and why? Drop. 2 is shared active,
3 is shared passive.

Best regards,
Krzysztof

