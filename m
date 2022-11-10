Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15CE624E60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKJXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:22:22 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE35F84E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:22:19 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso3905159fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTsHZbpz3r5TSBiZ8Duso7cKW7h6bP2qiZJWu5aAceg=;
        b=gA80x5Inh8pnbYQCdkgl/+QGlxZR4kAiUKQYrH1GHLjqtoSHZQZaQ6KP+Xo32TXiKa
         70fnToNyrjJcQm0lWVDGsvJtk4dap4t3sHBTUVFN5u/2Q9brkuBPPTFq+EMeFiCqYiCm
         ILPhMos9wHca7Zu/KOhXPD8ck8dQ5Vu0MgFV+Hf8v4WZN3+RBH41DRvAEuXxw7Be1CsC
         icj+TJ7fRx2oEJfUDFn05lIKhG7SVlwbcEAbVcArVNQttE8w92AZ6LLr/SdWXaVLdU84
         ErctRB8iXQuFRsKivFBFNjyqFwlKjd9EdYcIYnRMaJ5c9WVzzRCsgq88gRLAvylqxh5+
         p4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTsHZbpz3r5TSBiZ8Duso7cKW7h6bP2qiZJWu5aAceg=;
        b=D2Jl7FUo408oikW8XqQ/eq0GT2O1T8O2vWOO31MA8+Jvz+/gQ0M58PbuP1FWJZBqJ5
         zxs43Gbp7PL9s6Y6BRKhXVwUEXYtR58zyeP+gSu+dHTBReHSQnUWHv+DZpZY6IDhFWlE
         zHKbWYM1Y7w+Bls+PMzegpZaSI2SKPi2PBlyoZx3cIq1whE8uw8FpWDvZr9WQUcwjxGr
         0twWY4UgIYaBoaNJvEHXxjSx6qzRFTMoeOf58Ftg6bXvc2F63QFFn6qQ5VKylFsLIGD6
         Zpzug3cvLnqS8KOeUqD2VtmbIP65s1/WYhh0v0lWAHrlejSpDD3yh+/u3KIs8OWtoOv6
         iOeQ==
X-Gm-Message-State: ACrzQf2QEaWfM/Ov7Duvii6klGAqR1QmVS0JyVyHO+TKyU7UDTs1dxjC
        iFeziUGZqk8ew9cFxI3uKsOmEg==
X-Google-Smtp-Source: AMsMyM4AP92chJNKRFJq0mHkoCSo8vs0uuTTJ15oRQLmlOVBcUQEYYqmZdvTpWjowK3JTlcJSJargw==
X-Received: by 2002:a05:6870:2e0e:b0:132:8335:64ba with SMTP id oi14-20020a0568702e0e00b00132833564bamr2475140oab.284.1668122538912;
        Thu, 10 Nov 2022 15:22:18 -0800 (PST)
Received: from ?IPV6:2804:14d:8084:84c6:fe26:c42d:aab9:fa8a? ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id 128-20020a4a0d86000000b004805b00b2cdsm283380oob.28.2022.11.10.15.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 15:22:18 -0800 (PST)
Message-ID: <cb0a7e11-da00-ee3c-bf51-c007d16550a7@usp.br>
Date:   Thu, 10 Nov 2022 20:22:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 16/24] drm/modes: Introduce more named modes
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20220728-rpi-analog-tv-properties-v8-0-09ce1466967c@cerno.tech>
 <20220728-rpi-analog-tv-properties-v8-16-09ce1466967c@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <20220728-rpi-analog-tv-properties-v8-16-09ce1466967c@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 11/10/22 08:07, Maxime Ripard wrote:
> Now that we can easily extend the named modes list, let's add a few more
> analog TV modes that were used in the wild, and some unit tests to make
> sure it works as intended.
> 
> Tested-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> Changes in v6:
> - Renamed the tests to follow DRM test naming convention
> 
> Changes in v5:
> - Switched to KUNIT_ASSERT_NOT_NULL
> ---
>  drivers/gpu/drm/drm_modes.c                     |  2 +
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 54 +++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index d3f0a3559812..855569a269b8 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2272,7 +2272,9 @@ struct drm_named_mode {
>  
>  static const struct drm_named_mode drm_named_modes[] = {
>  	NAMED_MODE("NTSC", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_NTSC),
> +	NAMED_MODE("NTSC-J", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_NTSC_J),
>  	NAMED_MODE("PAL", 13500, 720, 576, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_PAL),
> +	NAMED_MODE("PAL-M", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_PAL_M),
>  };
>  
>  static int drm_mode_parse_cmdline_named_mode(const char *name,
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index 768e8efb2f52..cf38e7cf0f08 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -133,6 +133,32 @@ static void drm_test_pick_cmdline_named_ntsc(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mode));
>  }
>  
> +static void drm_test_pick_cmdline_named_ntsc_j(struct kunit *test)
> +{
> +	struct drm_client_modeset_test_priv *priv = test->priv;
> +	struct drm_device *drm = priv->drm;
> +	struct drm_connector *connector = &priv->connector;
> +	struct drm_cmdline_mode *cmdline_mode = &connector->cmdline_mode;
> +	struct drm_display_mode *mode;
> +	const char *cmdline = "NTSC-J";
> +	int ret;
> +
> +	KUNIT_ASSERT_TRUE(test,
> +			  drm_mode_parse_command_line_for_connector(cmdline,
> +								    connector,
> +								    cmdline_mode));
> +
> +	mutex_lock(&drm->mode_config.mutex);
> +	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode = drm_connector_pick_cmdline_mode(connector);
> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +
> +	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mode));
> +}
> +
>  static void drm_test_pick_cmdline_named_pal(struct kunit *test)
>  {
>  	struct drm_client_modeset_test_priv *priv = test->priv;
> @@ -159,10 +185,38 @@ static void drm_test_pick_cmdline_named_pal(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_pal_576i(drm), mode));
>  }
>  
> +static void drm_test_pick_cmdline_named_pal_m(struct kunit *test)
> +{
> +	struct drm_client_modeset_test_priv *priv = test->priv;
> +	struct drm_device *drm = priv->drm;
> +	struct drm_connector *connector = &priv->connector;
> +	struct drm_cmdline_mode *cmdline_mode = &connector->cmdline_mode;
> +	struct drm_display_mode *mode;
> +	const char *cmdline = "PAL-M";
> +	int ret;
> +
> +	KUNIT_ASSERT_TRUE(test,
> +			  drm_mode_parse_command_line_for_connector(cmdline,
> +								    connector,
> +								    cmdline_mode));
> +
> +	mutex_lock(&drm->mode_config.mutex);
> +	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode = drm_connector_pick_cmdline_mode(connector);
> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +
> +	KUNIT_EXPECT_TRUE(test, drm_mode_equal(drm_mode_analog_ntsc_480i(drm), mode));
> +}
> +
>  static struct kunit_case drm_test_pick_cmdline_tests[] = {
>  	KUNIT_CASE(drm_test_pick_cmdline_res_1920_1080_60),
>  	KUNIT_CASE(drm_test_pick_cmdline_named_ntsc),
> +	KUNIT_CASE(drm_test_pick_cmdline_named_ntsc_j),
>  	KUNIT_CASE(drm_test_pick_cmdline_named_pal),
> +	KUNIT_CASE(drm_test_pick_cmdline_named_pal_m),

As the tests drm_test_pick_cmdline_named_ntsc,
drm_test_pick_cmdline_named_ntsc_j, drm_test_pick_cmdline_named_pal and
drm_test_pick_cmdline_named_pal_m follow a pretty similar structure, it
would be nice to parametrize those tests.

Best Regards,
- Maíra Canal


>  	{}
>  };
>  
> 
