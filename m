Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF86443D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiLFNBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiLFNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:01:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0AFD130
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:00:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id x22so5932856ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPt4+hNHEAygAYm/iIi7WWfY6gI8L5cWMRSUMDDponY=;
        b=bQCKAqQfljf1U+dmf1KTvgvajxOVvy8g4xkI4rqmjigYqgb9X1FMbQ8tIMdrKaz3P6
         rctDhvLQTL+2Q4qbe1stTd1+SPdOxXAgcDeFRdvGHLkC4LInwOCbzeVlXod0yH3gpiAr
         vrxak2zCWhjeVMx+yMy6Vdn5liiPfn/oxVrUaD/UkMpxYVrD+P6N7Bmf4smucUSd/rNo
         2Xehk9hDqq8zPpddbXzqRxYnWw1k/32h5/s3p9KEseBLmRGtDxdiNdZEEVps0v+qdwl4
         2j+wS2CBuRpXP4IWlQlBxw8lvGERcYYR6izUxZUShkdjLvgzgqcywwDgvqBhKLq7F29H
         Holg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPt4+hNHEAygAYm/iIi7WWfY6gI8L5cWMRSUMDDponY=;
        b=jFPaJySlamsEy9JT4K/6tcoaS+3IyK73n/GKx2P+/AbJUBCL9oo2E0i3Z4bbuasIdE
         tcsX9pdpKb6YAYWqcSu+yE9OjWnAyfmzty4afls/okf5VwoEYYlPQ/6Ad2nQp2S1rbol
         1jxatIZ8wa2I5Pe2DsUl6w5m1IckzCCsgaFEZVerUNQilRVf9P5JAh890QCelY1tmIDK
         /uOSVVJbXQrzGm0Nzz8GRSQprNH+qsoUZFuSL8fU1s14USLwfyJKbsnimIQv2IiunVSL
         Xn1VN9Qm58V+Qh3vVMXEeo7h0SSY/lY4Uyqxa3xzSVx8Iw+GTHx4+x7+PK4FfhpXJcKy
         96Dw==
X-Gm-Message-State: ANoB5pn9MCzldIdjS2m7PLt1F9ee7CftuLXza4YOGikY7468350CZ1uw
        24X3pmJX74Kjjf7tnvdKZ/o/PQ==
X-Google-Smtp-Source: AA0mqf4ZqirxuOZeT0doTihcv0ObkbVOPHk5CHTRLxdM1jLRtMbB2+TyECyb6JOuMmm8aMSm/aDMXQ==
X-Received: by 2002:a17:906:1585:b0:7ad:84c7:502d with SMTP id k5-20020a170906158500b007ad84c7502dmr58639319ejd.177.1670331652808;
        Tue, 06 Dec 2022 05:00:52 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:5e13:2125:2912:2c56? ([2a0e:41a:894f:0:5e13:2125:2912:2c56])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm7325471ejc.210.2022.12.06.05.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:00:52 -0800 (PST)
Message-ID: <9ec0204d-ca4c-afd9-33d6-1ebaaaf6b144@baylibre.com>
Date:   Tue, 6 Dec 2022 14:00:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/3] drm/tiny: ili9486: remove conflicting framebuffers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, neil.armstrong@linaro.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
 <20221116-s905x_spi_ili9486-v3-3-59c6b58cbfe3@baylibre.com>
 <14e5c4e4-30dd-8efd-81e4-d680664ab04a@linaro.org>
 <c460bbda-6e9d-24e8-eb73-2e7207958deb@suse.de>
From:   Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <c460bbda-6e9d-24e8-eb73-2e7207958deb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 10:52, Thomas Zimmermann wrote:

>> Conflicting framebuffer on the SPI display ? How is that possible ?
> 
> Calling drm_aperture_remove_framebuffers() is only required if the 
> graphics card may have been pre-initialized by the system, such as a 
> VGA-compatible card on a PC.
> 
> Could the SPI display have been initialized by the firmware? If not, the 
> call should be left out.

What's happening on this board is that the builtin simpledrm driver is 
creating fb0 backed by the framebuffer prepared by u-boot / grub, and 
this the framebuffer being used by fbcon at early boot.

When the ILI9486 DRM driver is probed later during boot a second 
framebuffer is created (fb1) and when fb0 is destroyed, fbcon still 
remains attached to a non-existent framebuffer, so the user is left in 
the dark.

What this patch is doing is that when the ILI driver is probed, fb0 is 
destroyed and a new DRM-backed fb0 is created by the ILI DRM driver that 
can be used by fbcon, so the user can correctly see the console on the 
SPI display.

Cheers,

-- 
Carlo Caione

