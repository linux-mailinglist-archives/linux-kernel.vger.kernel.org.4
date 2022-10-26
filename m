Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8B60EACF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiJZVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiJZVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:25:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DF22B29
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:25:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b2so31502500lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwQzSxEYATvXw39X4hIfByL5axaSJ+hp0GX3dcFg9xE=;
        b=RpM/5T09Rkd7whH1lYSUsRaIYsLxkJ0RHNwjJCSxMK6DXCHNXTKvm/1fd6/rqZteFR
         Rx0Dd96ySW4Ipv/w5BooL5M2xPSrcjrb8u6NBcWH5FYSfZQAuMc7l+4tKtdhQ+GupunV
         QxDrwD5p/mLnrG+XlPTaY3Bs1cduAAinJEmPjaKEHtI6PU/jlh7sqgyaCKUUx4NHkvwe
         gQ7yfcspKa3yD8qwC59MMnhKCEbG5hH4oqDos1yN52iQjO8nTh3HigOQyXj7O5Dbi9ZV
         h8NZhnbLYWMt7sRrzSiuElVjYuCoOb7cJR9nec0Geq3YRRQA9H69XcMHraBJpty9UP+5
         LQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwQzSxEYATvXw39X4hIfByL5axaSJ+hp0GX3dcFg9xE=;
        b=hMo4QQq4pyQigw5fxrHKPoyYWVlgpYk4g72wRiebz8QYdUb3ifVKshdxt4XnQxR+Dk
         jzpQZY7w7AchyUhpPGDZwbLsbK4exi0o3iXgPB7nipKVED7Yr0N+D4rks1Gkz+bOzW2Y
         Y/ZMBgT5uSo8oqsKHNs9Er0OqhfjW7tFkcLvkNLPauJyslDqfnA9MvwN5mBDDMBwxvpt
         iO7l6ZXZ3MlLoB1wvYX1gC8jJ+6d2KaQBC5Kj+pa/xjzYylnSyeNmE2OR6mbKdehO/LO
         VCOipRNoC6l8B5jDAQ95wcyA1klqCLvgN2aex5dCuPFgFS9/PLWfhIkHAqTuPAOH624g
         kgWw==
X-Gm-Message-State: ACrzQf0JREMpVqNSwpMl9HyPDyTSl1rfPUsCLpVQLcfH43AZH63J6F4l
        MoeLTaiDV1G+wSMKm2/jddo=
X-Google-Smtp-Source: AMsMyM6ensEOd7HbTbNfYIT/f7EQdTyWIhqe5A2BIVTj3+ujPQdHszK3t50zI7jkiMDMZGau3DPaxg==
X-Received: by 2002:ac2:5b50:0:b0:4af:d01:63d0 with SMTP id i16-20020ac25b50000000b004af0d0163d0mr2786228lfp.596.1666819523402;
        Wed, 26 Oct 2022 14:25:23 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:c898:de98:30b3:a07? ([2a02:a31a:a240:1700:c898:de98:30b3:a07])
        by smtp.googlemail.com with ESMTPSA id p8-20020a2eba08000000b00277041268absm1070023lja.78.2022.10.26.14.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:25:22 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <1adf0b0b-3743-4b5a-9416-823b8bf903fa@gmail.com>
Date:   Wed, 26 Oct 2022 23:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v6 14/23] drm/modes: Properly generate a drm_display_mode
 from a named mode
To:     maxime@cerno.tech, Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Ben Skeggs <bskeggs@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-sunxi@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-14-e7792734108f@cerno.tech>
Content-Language: pl
In-Reply-To: <20220728-rpi-analog-tv-properties-v6-14-e7792734108f@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

> +static struct drm_display_mode *drm_named_mode(struct drm_device *dev,
> +					       struct drm_cmdline_mode *cmd)
> +{
> +	struct drm_display_mode *mode;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_named_modes); i++) {
> +		const struct drm_named_mode *named_mode = &drm_named_modes[i];
> +
> +		if (strcmp(cmd->name, named_mode->name))
> +			continue;
> +
> +		if (!named_mode->tv_mode)
> +			continue;
> +
> +		mode = drm_analog_tv_mode(dev,
> +					  named_mode->tv_mode,
> +					  named_mode->pixel_clock_khz * 1000,
> +					  named_mode->xres,
> +					  named_mode->yres,
> +					  named_mode->flags & DRM_MODE_FLAG_INTERLACE);
> +		if (!mode)
> +			return NULL;
> +
> +		return mode;
> +	}
> +
> +	return NULL;
> +}
> +

You didn't add tv_mode_specified to struct drm_named_mode, and left the
if (!named_mode->tv_mode) condition here. This will break on NTSC.

Best regards,
Mateusz Kwiatkowski

