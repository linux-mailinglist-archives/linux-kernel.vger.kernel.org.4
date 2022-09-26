Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218B45EA8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiIZOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiIZOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:38:42 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE46243
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=paSIeytrKVUKIdWtCr2iVXrX78NgEHAeJ/ebnvP/I5A=; b=DNnQx2i1Fsgi46OxyGTNlnrluZ
        1bcdQl6hc35k8Si8qWu33BIneSuLs7M/2RISFtmx55NX/kGpS+H/myA76uZC3ai7O6GP1Abwgu7g6
        Gm3wXS81BrRu2HPClJrAFG60fgL/cJCxyaosoT9G0711kDeWDv1DB3c1/kwhfguCyqwP6XAh1In2X
        k6kbTFaMQkJ3DqWc+jPhaBM/r2ncL+O1PkijQcCDCG1R1zCDlzJqtH7p11Y56Vn64OI32dv17x4id
        Ed9N5rdZ5of/7KpiKBR2U3XKzFXE7wZrH9zS+RYdOOl5s/NJNVqfBJOyug6R1j6QImo7z5oynyuS0
        K3IDPZLA==;
Received: from [2a01:799:961:d200:3946:6b45:3eef:d112] (port=51628)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ocnhy-0004vD-H1; Mon, 26 Sep 2022 14:59:38 +0200
Message-ID: <9e76a508-f469-a54d-ecd7-b5868ca99af4@tronnes.org>
Date:   Mon, 26 Sep 2022 14:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 09/33] drm/connector: Add TV standard property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-9-f733a0ed9f90@cerno.tech>
 <80138f62-faec-5f7e-a8bd-235318a4e4c2@tronnes.org>
 <20220926100131.o5xtslzcmez5z2r3@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220926100131.o5xtslzcmez5z2r3@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 26.09.2022 12.01, skrev Maxime Ripard:
> On Sat, Sep 24, 2022 at 05:52:29PM +0200, Noralf Trønnes wrote:
>> Den 22.09.2022 16.25, skrev Maxime Ripard:
>>> The TV mode property has been around for a while now to select and get the
>>> current TV mode output on an analog TV connector.
>>>
>>> Despite that property name being generic, its content isn't and has been
>>> driver-specific which makes it hard to build any generic behaviour on top
>>> of it, both in kernel and user-space.
>>>
>>> Let's create a new enum tv norm property, that can contain any of the
>>> analog TV standards currently supported by kernel drivers. Each driver can
>>> then pass in a bitmask of the modes it supports, and the property
>>> creation function will filter out the modes not supported.
>>>
>>> We'll then be able to phase out the older tv mode property.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>
>> Please can you add per patch changelogs, it's hard to review when I have
>> to recall what might have happened with each patch. If you do it drm
>> style and put in the commit message it should be easy enough to do.
> 
> I certainly don't want to start that discussion, but I'm really not a
> fan of that format either. I'll do it for that series if you prefer.
> 

The format isn't important, but especially a big series like this and
being weeks between each iteration it's difficult to follow and see
which review comments that you have chosen to implement and how. It's
almost a full review each time. Even if I see that I have acked/rewieved
a patch, if I don't remember, I have to go back to the previous version
and see if I had any comments and if you followed up on that.

>>> +/**
>>> + * enum drm_connector_tv_mode - Analog TV output mode
>>> + *
>>> + * This enum is used to indicate the TV output mode used on an analog TV
>>> + * connector.
>>> + *
>>> + * WARNING: The values of this enum is uABI since they're exposed in the
>>> + * "TV mode" connector property.
>>> + */
>>> +enum drm_connector_tv_mode {
>>> +	/**
>>> +	 * @DRM_MODE_TV_MODE_NONE: Placeholder to not default on one
>>> +	 * variant or the other when nothing is set.
>>> +	 */
>>> +	DRM_MODE_TV_MODE_NONE = 0,
>>
>> How is this supposed to be used?
> 
> It's not supposed to be used. It was a suggestion from Mateusz to avoid
> to default to any standard when we don't initialize something. I don't
> have any strong feeling about it, so I can drop it if you prefer.
> 

The confusing thing to me is that "None" is part of the property enum
list, so the idea is that it can end up in userspace if there's a driver
error? Hmm, that won't work since TV_MODE_NONE won't be part of the
bitmask that the driver sets. So userspace reading the property ends up
with a value for which there's no enum name to match.

So usespace should be trained to know that zero for this property is a
driver error? No, not a good idea.

I think to catch a bug like this drm_atomic_connector_get_property()
should check the tv.mode value and see if it's a legal enum value and if
not it has to just pick a legal one and print an error. But I'm not sure
it's worth it to catch a bug like this. And I don't see any other enum
properties being checked for validity either before being returned to
userspace.

Based on this reasoning I think you should drop the NONE value.

Noralf.
