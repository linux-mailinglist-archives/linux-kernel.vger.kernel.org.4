Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CD622D41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiKIONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKIONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:13:16 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1D11A0D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uieGFSRlWfEudDPWzmLqa4FntHsQ1l9cOOh88HONQ+I=; b=XSNoEIfzs5COdh7u2/RQYNh5SC
        gYIomJ7/I61w0V5mrGKK7L2CrQ3Ev26u7S8NOpeMVOdXI4B17U5eXuo3CAodWNX6nTbJfCagJMvv4
        Dq2yjLybIPLqy87sNXPPFnYuQu8vcZ8qYweBfe9Pawv0uAn8z1JhMK5HcEMSSKg5daPD3qv/t1kED
        48XyzrYBUTsNO5ABRfYUUeVbl9Wlr0tkQnn4UTGwve/OR/aOWmbHcqVaGPA/Kyk67Z0Uk2A53X4pG
        8Y8elO/1Byq0lJ5AL9fKkmpRHFYXXlG0QzsbhrrtylC3XWbrSJ7XkQ8ii+pw9jwXdKsNb4MSBVFK7
        mC7xLDFg==;
Received: from [2a01:799:95a:cb00:81e6:f8f5:7f80:f3bd] (port=60889)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oslm9-0004IU-Hy; Wed, 09 Nov 2022 15:09:57 +0100
Message-ID: <d44f5edb-52d4-851a-9746-5c4d49d603f4@tronnes.org>
Date:   Wed, 9 Nov 2022 15:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 15/23] drm/modes: Introduce more named modes
To:     Maxime Ripard <maxime@cerno.tech>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Dom Cobley <dom@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v7-0-7072a478c6b3@cerno.tech>
 <20220728-rpi-analog-tv-properties-v7-15-7072a478c6b3@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v7-15-7072a478c6b3@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 07.11.2022 15.16, skrev Maxime Ripard:
> Now that we can easily extend the named modes list, let's add a few more
> analog TV modes that were used in the wild, and some unit tests to make
> sure it works as intended.
> 
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
> index 49441cabdd9d..17c5b6108103 100644
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
> index fdfe9e20702e..b3820d25beca 100644
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

There are 4 named mode tests that are almost identical, should probably
use KUNIT_ARRAY_PARAM like in the parser tests.

This patchset has been going on for a long time now so it can be fixed
later if you don't want to do it now:

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>  static struct kunit_case drm_test_pick_cmdline_tests[] = {
>  	KUNIT_CASE(drm_test_pick_cmdline_res_1920_1080_60),
>  	KUNIT_CASE(drm_test_pick_cmdline_named_ntsc),
> +	KUNIT_CASE(drm_test_pick_cmdline_named_ntsc_j),
>  	KUNIT_CASE(drm_test_pick_cmdline_named_pal),
> +	KUNIT_CASE(drm_test_pick_cmdline_named_pal_m),
>  	{}
>  };
>  
> 
