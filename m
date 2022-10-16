Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3366D6002F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJPS4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJPS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:56:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1620356CB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:56:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s20so14446477lfi.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9R5DRkDar97t7RGa7ZkHbwXUyJ5tEv/b58zZkFRpKIU=;
        b=UqSCa35znTFAW2XjpbRvdh7DaqZHpIJN6v4AXacEElZvxQlvD6nM1NZ8Ag4JRpl3yk
         tQA8VjWsFBR1wJX/Ss+CPqCol92EEvV5Raj+pM0cSuC99zTk0doGl7wmBnhKuxgF1Ygk
         fg/0fyZAwvrTzcQj7VkncMJ+fonMoDA4arz05pgdToty0rBiXkoKPedTqvwmaoXAbTg+
         v3woOrrTfXBCGMASf2KyRUme4mDbwgrtVNogi54B0uEQTGHlblMTfWTbB8IpJkPkXm6d
         e3JS1uHEJHUVESdK67TNOFvIWA7dgP90CYwGzpBFC03lpCGGnnp4EI/sbS04iqDtsz+L
         ezsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9R5DRkDar97t7RGa7ZkHbwXUyJ5tEv/b58zZkFRpKIU=;
        b=tiDojKijZMCIo+WuIbc/JJavbHbLkC9jSlEg7oyXaaJQsoxNv3Jr7ga+oNuvUw1QjO
         vYzFqk1V8ZgQVmON0qtVB/RfoG7eiH0aKp+sNUfGHGhC7mLqjcwQe1fx3HlT29WwKVR0
         aQgygbhRD+N6x0Pfr6baAkF3n6nhxqDCmZobJ3s5K1Iqx+nPP7GHx1BGFdv040edCOLO
         r85FdqqL4/UdGrwhnJGQWeuEgGNd3b3xk+3GTl3u9KGyPsTiR816HazqmApI8ql9tlQc
         zVp6FoFJynWCE0RhBpQ3kbM2ouWq/UwnNevViy2hmwRGYyONHljF2XVL/oCHLAV31Vgd
         +iBQ==
X-Gm-Message-State: ACrzQf2sPtRO1XO5kB5TmG+AUIR5yDcnhyYWvIX/H+SrFIBziMu9NsZf
        sKR8yZkPkUw72JMW/3jPSpk=
X-Google-Smtp-Source: AMsMyM5uYxB/6xJ5gGhOv3WAH6+V6GDD4KbrqZFfIThsPvWDKXTV721fShUokapp2H2agrxIAik1vw==
X-Received: by 2002:ac2:46da:0:b0:4a2:2963:71b0 with SMTP id p26-20020ac246da000000b004a2296371b0mr2564386lfo.600.1665946584951;
        Sun, 16 Oct 2022 11:56:24 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:64bb:87df:aad7:a9f0? ([2a02:a31a:a240:1700:64bb:87df:aad7:a9f0])
        by smtp.googlemail.com with ESMTPSA id p24-20020a2ea4d8000000b0026de7400f3bsm1237043ljm.5.2022.10.16.11.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 11:56:24 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <0f2beec2-ae8e-5579-f0b6-a73d9dae1af4@gmail.com>
Date:   Sun, 16 Oct 2022 20:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v5 20/22] drm/vc4: vec: Convert to the new TV mode
 property
Reply-To: kfyatek+publicgit@gmail.com, kfyatek+publicgit@gmail.com
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
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-20-d841cc64fe4b@cerno.tech>
 <c1949248-fb40-682c-492e-bafbd915cee3@gmail.com>
Content-Language: pl
In-Reply-To: <c1949248-fb40-682c-492e-bafbd915cee3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Urgh. I cannot send e-mails apparently today, as I removed the second half of
the previous message. Here goes:

> @@ -454,13 +563,6 @@ static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
>  					struct drm_connector_state *conn_state)
>  {
>  	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;

You could add here something like:

+	const struct vc4_vec_tv_mode *tv_mode =
+		vc4_vec_tv_mode_lookup(conn_state->tv.mode);
+
+	if (!tv_mode)
+		return -EINVAL;

This should explicitly make it impossible to enter the equivalent condition in
vc4_vec_encoder_enable() that causes the problem mentioned in the previous
e-mail.

This is probably basically impossible already, but I triggered that when testing
a follow-up change I'd like to post shortly.

> -	const struct vc4_vec_tv_mode *vec_mode;
> -
> -	vec_mode = &vc4_vec_tv_modes[conn_state->tv.legacy_mode];
> -
> -	if (conn_state->crtc &&
> -	    !drm_mode_equal(vec_mode->mode, &crtc_state->adjusted_mode))
> -		return -EINVAL;

If you're removing the reference mode, then I think you should at least add
checks that the crtc_clock is set to 13.5 MHz (it's otherwise ignored) and that
crtc_htotal is either 858 or 864 (using a switch over reference_mode->htotal as
I proposed in my comment to patch 19/22 would double as such check), as all
other values causes VEC to output garbage.

Best regards,
Mateusz Kwiatkowski

