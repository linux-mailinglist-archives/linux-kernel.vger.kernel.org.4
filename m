Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB17E6002C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJPSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJPSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:16:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867E4456F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:16:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j23so11556205lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=viplUm+By6s8XGYflV1jaRl8q/qb4f9y9KZgb4QOLdc=;
        b=mmnJBH4qc8H6AxaIiyfc2vzVCocrgGCP4ib4yJyyUtnrahrAqqBoHWVhpiMA2Z0OW5
         clJw0eZ5ImFHiphKJGDLJTJwrl5F5EZAB8AQSIvGjbloClAAQeXnYoMdHg/NyMaVmrrx
         45BTHjzh4BuqwfEA8zksbvlOlz7BSnrV4ReNMW3BvXD5/BdkOdy0eitwWx2u8k03lLKz
         u4xD5+hFv5grqx6LtotWs14ANU9Ev5Gf0+ICFYsqAftfjkrns9cCaltmHO+gJOc3vzza
         mTmL+c/PPP4rkIb4BK/mG7N8kfZwWPjUvRAs2jmM/ra5H3udWtZwmKbAMNIDsTFpsFp0
         IGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viplUm+By6s8XGYflV1jaRl8q/qb4f9y9KZgb4QOLdc=;
        b=55Mrgv4m80DCo90tvQzfiMByST43Zsy2CLdB6yPAqIa+kuEs4f/iT0I9PuA+0A3U8H
         sO806whakZ/t1u13tiXkgdYLhY+4KoiY/+hvd4zl3iFtcdfzyMb+MOqgMjP/0ZECWa54
         BfTkOUNVBJA0vsMVwB3iNmCjq3fRjlAKPtvXUAQAHthrEUnHGZAGdOcAqz0hPclesQEx
         BH4Oav5dxL9b54x6XH6/Ezu/eYe9l05l0D2S5PRBRK9SvsZiKgxrGikZRa7SCs7yrlPT
         lBRLEe+3RRDnkOyveQqefbalRNng0CryqBQLLP1PQeFLeFB3G87cWIYr5uuVMSOWAr8M
         1e0w==
X-Gm-Message-State: ACrzQf0SFZzetmTaWdOH0PWYBUh5PeNuuQgwoufAaDJSnIJWk/zJg9HT
        nH2cg8r/t/2LtsK6NnWzXnE=
X-Google-Smtp-Source: AMsMyM4pArN3BwjOOqgh65fdbAs3K1mXozFp1Q1IXi9e4aIE3VoeXv03ELNht5+KUG+fPNd+NUMejg==
X-Received: by 2002:a2e:91c8:0:b0:26e:977a:14b1 with SMTP id u8-20020a2e91c8000000b0026e977a14b1mr2876789ljg.379.1665944195109;
        Sun, 16 Oct 2022 11:16:35 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:64bb:87df:aad7:a9f0? ([2a02:a31a:a240:1700:64bb:87df:aad7:a9f0])
        by smtp.googlemail.com with ESMTPSA id p22-20020a2eba16000000b0026dffa29989sm1221591lja.23.2022.10.16.11.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 11:16:34 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <31759a06-ddd0-6b78-0e10-8e8754f394f9@gmail.com>
Date:   Sun, 16 Oct 2022 20:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v5 19/22] drm/vc4: vec: Check for VEC output constraints
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
Reply-To: kfyatek+publicgit@gmail.com
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-19-d841cc64fe4b@cerno.tech>
 <270c4a51-0a03-f048-46da-ab37900f8b91@gmail.com>
In-Reply-To: <270c4a51-0a03-f048-46da-ab37900f8b91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Sorry about the mess that happened to the previous message. I hope this one
will be delivered more cleanly.

W dniu 13.10.2022 o 15:19, Maxime Ripard pisze:
> From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
>
> The VEC can accept pretty much any relatively reasonable mode, but still
> has a bunch of constraints to meet.
>
> Let's create an atomic_check() implementation that will make sure we
> don't end up accepting a non-functional mode.
>
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_vec.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index 90e375a8a8f9..1fcb7baf874e 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -453,6 +453,7 @@ static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
>                      struct drm_crtc_state *crtc_state,
>                      struct drm_connector_state *conn_state)
>  {
> +    const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>      const struct vc4_vec_tv_mode *vec_mode;
>  
>      vec_mode = &vc4_vec_tv_modes[conn_state->tv.legacy_mode];
> @@ -461,6 +462,53 @@ static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
>          !drm_mode_equal(vec_mode->mode, &crtc_state->adjusted_mode))
>          return -EINVAL;
>  
> +    if (mode->crtc_hdisplay % 4)
> +        return -EINVAL;
> +
> +    if (!(mode->crtc_hsync_end - mode->crtc_hsync_start))
> +        return -EINVAL;
> +
> +    switch (mode->vtotal) {
> +    case 525:
> +        if (mode->crtc_vtotal > 262)
> +            return -EINVAL;
> +
> +        if (mode->crtc_vdisplay < 1 || mode->crtc_vdisplay > 253)
> +            return -EINVAL;
> +
> +        if (!(mode->crtc_vsync_start - mode->crtc_vdisplay))
> +            return -EINVAL;
> +
> +        if ((mode->crtc_vsync_end - mode->crtc_vsync_start) != 3)
> +            return -EINVAL;
> +
> +        if ((mode->crtc_vtotal - mode->crtc_vsync_end) < 4)
> +            return -EINVAL;
> +
> +        break;
> +
> +    case 625:
> +        if (mode->crtc_vtotal > 312)
> +            return -EINVAL;
> +
> +        if (mode->crtc_vdisplay < 1 || mode->crtc_vdisplay > 305)
> +            return -EINVAL;
> +
> +        if (!(mode->crtc_vsync_start - mode->crtc_vdisplay))
> +            return -EINVAL;
> +
> +        if ((mode->crtc_vsync_end - mode->crtc_vsync_start) != 3)
> +            return -EINVAL;
> +
> +        if ((mode->crtc_vtotal - mode->crtc_vsync_end) < 2)
> +            return -EINVAL;
> +
> +        break;
> +
> +    default:
> +        return -EINVAL;
> +    }
> +
>      return 0;
>  }
>  
>

In my original version of this function
(https://github.com/raspberrypi/linux/pull/4406/files) the switch is over
reference_mode->vtotal, not mode->vtotal. This was intended to explicitly allow
a different value of mode->vtotal, to support non-standard modes, such as "fake"
525 lines with SECAM encoding, or the progressive modes.

You're switching over mode->vtotal, which makes specifying those impossible.
I don't think we should limit the users like that.

We're removing reference_mode in patch 20/22, so adding a switch over
reference_mode->vtotal is probably not a good idea -- in that case I'd switch
over mode->htotal instead: 858 for "NTSC" and 864 for "PAL". This may seem a bit
weird, but any other value of htotal causes the VEC to output garbage anyway.

Best regards,
Mateusz Kwiatkowski
