Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D561F1A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKGLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:17:20 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CBFBCB8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FFI39mP8UtNKgOqsi2a6dT2sTXn4P75XgEouvE9p5L0=; b=TJlNny8m3SQR1E18mL8S98TVQJ
        1oMLGAbLNfa7jW+weTU/RpdeaudZeLqRm6kCaVOsswVSTJsZMlSx94JwUMDbx/pWcLkW0LURu+GtA
        gTd1n8X4PGBurLIJWx3ORA1yBMkeDAjMX3TjIVnJEd0jOx0eb52UD7NXCpQIf6FVS/x+64KYMWffm
        Pm6rATU2FGOE2zwcjsh8BNCdbjEeRZJ1pAWhZE5f/MwMJmMIAJ9rhn5bphtAwzBDB4kn2MTJI4shh
        aBdvTtiL6xN2cOyVs4gfyQ/DFbibjsDqSXt8FdTAcR/3oJimZzlUC04dsdv9CmpIKnSWk1NTNwAYl
        AdffaDjQ==;
Received: from [2a01:799:95a:cb00:fd97:29ff:d72a:349e] (port=49701)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1os07v-0005Xf-CP; Mon, 07 Nov 2022 12:17:15 +0100
Message-ID: <022d5c23-6387-55b5-615e-5c6aaa0dc86c@tronnes.org>
Date:   Mon, 7 Nov 2022 12:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 16/23] drm/probe-helper: Provide a TV get_modes helper
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mateusz Kwiatkowski <kfyatek@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
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
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, linux-sunxi@lists.linux.dev,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-16-e7792734108f@cerno.tech>
 <8d0eee22-50f5-5b0a-c1e6-c5f61dd5bbcd@gmail.com>
 <eb485588-2e7a-8455-7ec4-6a9649d2bef8@tronnes.org>
 <20221107100751.neijajfrazxloldp@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221107100751.neijajfrazxloldp@houat>
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



Den 07.11.2022 11.07, skrev Maxime Ripard:
> Hi Noralf,
> 
> On Sun, Nov 06, 2022 at 05:59:23PM +0100, Noralf Trønnes wrote:
>>
>>
>> Den 27.10.2022 00.02, skrev Mateusz Kwiatkowski:
>>> Hi Maxime,
>>>
>>> First of all, nice idea with the helper function that can be reused by different
>>> drivers. This is neat!
>>>
>>> But looking at this function, it feels a bit overcomplicated. You're creating
>>> the two modes, then checking which one is the default, then set the preferred
>>> one and possibly reorder them. Maybe it can be simplified somehow?
>>>
>>> Although when I tried to refactor it myself, I ended up with something that's
>>> not better at all. Maybe it needs to be complicated, after all :(
>>>
>>
>> I also thought that the function was complicated/difficult to read, in
>> particular the index stuff at the end, but I also failed in finding a
>> "better" solution, just a different one ;)
> 
> I think I like yours better still :)
> 
> Can I bring it into my series, with your authorship and SoB?
> 

Sure, no problem.

Noralf.
