Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE76620C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiKHJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiKHJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:38:27 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E662AC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gn2jtnurXeLoR+JBbYdWEKBeFwgIy7nQqvoCoWdGcMU=; b=Jm48u4quUIM9AnE2eAVOPXlszN
        dHIUCxlanP3myizyV6x9HL+VzqOJBcIng+jIcCrV+ZPLX2GL3s239g7CE2I26KDmGGx0zkpumAvjA
        EALkEKyh8Ho0vrR7//I1jF65jvIy8wwm/jayyESeeHlMso6Zu6yM2QoKn9j4hydIZxrtVraX1dJju
        ItknqiWPduNMuNnrVezLIeZgNrbbgi5Djw/QrHpTXb6ozVvWRQxu6EbXp+RHmjSdNmEqARyimQjcf
        DksOaOcw0fZ51OKSvj6zbrlcXCFUinsfBUGO2lO/rodVYogF86aGh3Q5y9/zFg8ENVbG/phX+5Kod
        UAKOOx1A==;
Received: from [2a01:799:95a:cb00:cca0:57ac:c55d:a485] (port=57639)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1osL3l-0008OX-8y; Tue, 08 Nov 2022 10:38:21 +0100
Message-ID: <ba532387-6329-c57a-1fa2-627b2cf40281@tronnes.org>
Date:   Tue, 8 Nov 2022 10:38:12 +0100
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
 <262f0953-1e05-e68e-3e96-2ac2132a1e57@tronnes.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <262f0953-1e05-e68e-3e96-2ac2132a1e57@tronnes.org>
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



Den 07.11.2022 19.03, skrev Noralf Trønnes:
> 
> 
> Den 07.11.2022 15.16, skrev Maxime Ripard:
>> Now that we can easily extend the named modes list, let's add a few more
>> analog TV modes that were used in the wild, and some unit tests to make
>> sure it works as intended.
>>
>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>
>> ---
>> Changes in v6:
>> - Renamed the tests to follow DRM test naming convention
>>
>> Changes in v5:
>> - Switched to KUNIT_ASSERT_NOT_NULL
>> ---
>>  drivers/gpu/drm/drm_modes.c                     |  2 +
>>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 54 +++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
>> index 49441cabdd9d..17c5b6108103 100644
>> --- a/drivers/gpu/drm/drm_modes.c
>> +++ b/drivers/gpu/drm/drm_modes.c
>> @@ -2272,7 +2272,9 @@ struct drm_named_mode {
>>  
>>  static const struct drm_named_mode drm_named_modes[] = {
>>  	NAMED_MODE("NTSC", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_NTSC),
>> +	NAMED_MODE("NTSC-J", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_NTSC_J),
>>  	NAMED_MODE("PAL", 13500, 720, 576, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_PAL),
>> +	NAMED_MODE("PAL-M", 13500, 720, 480, DRM_MODE_FLAG_INTERLACE, DRM_MODE_TV_MODE_PAL_M),
>>  };
> 
> I'm now having second thoughts about the tv_mode commandline option. Can
> we just add all the variants to this table and drop the tv_mode option?
> IMO this will be more user friendly and less confusing.
> 

One downside of this is that it's not possible to force connector status
when using named modes, but I think it would be better to have a force
option than a tv_mode option. A lot of userspace treats unknown status
as disconnected.

Anyone know if it's possible to set the connector status sysfs file
using a udev rule?

Noralf.
