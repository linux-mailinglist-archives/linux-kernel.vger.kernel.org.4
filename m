Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C461FCD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiKGSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiKGSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:07:45 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066632C669
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3Bf+KcHaW9GVk8+e0qwYG7pDVa7qGqnwKbjfeHC+JJg=; b=J/2pe6qYb5J7p2zVDvNn2y2J2z
        nOUYFLV3uh28gG/8jdajK+ENWZXy4cnCy5f8yIZZisUtv8a6oX6QYsy6dTBPVZsawqeDDyWnLC5LZ
        Lj71hcQnXQcJRwdxn2RTEdxJB7vHLhBzj1s97uAqUGTKNH5ch8GbJlqF7VaVAu5245EbIPRx6HQk2
        KKaLpA1YjAAaRnHSFn3F0iCK/29HrLGAYo17Yxytus4J5ulx5hRzLSEj1SVWyRe7kMnmhOqWFlLQf
        A/UNuLiiTnbVG+/ePVNcCCZ3GhyHPJ36YAT63jSmGknUWy3cwAIIq0WuJ2NESE+CSNhVwzSAfbtqp
        Un8MhtCA==;
Received: from [2a01:799:95a:cb00:cca0:57ac:c55d:a485] (port=63947)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1os6TP-0001Dd-AZ; Mon, 07 Nov 2022 19:03:51 +0100
Message-ID: <262f0953-1e05-e68e-3e96-2ac2132a1e57@tronnes.org>
Date:   Mon, 7 Nov 2022 19:03:47 +0100
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
Content-Transfer-Encoding: 7bit
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

I'm now having second thoughts about the tv_mode commandline option. Can
we just add all the variants to this table and drop the tv_mode option?
IMO this will be more user friendly and less confusing.

The named modes needs to be documented in modedb.rst.

Noralf.

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
