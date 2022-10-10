Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FD5F9E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiJJMLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiJJMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:11:10 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901A65561
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:11:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5AFDC2B06398;
        Mon, 10 Oct 2022 08:11:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 08:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665403862; x=
        1665411062; bh=DaOchJ9jz8E6sYZqHLcJ3bADUsZchCLmV8LJHufmPfk=; b=P
        pth+e40tTkdkMpHYH32Mz2oAXLX3mCnqDfm80TkrOETQU0iMY2fvQwS4edvrfb+G
        5+djx/eU8+yje0g2iai9MAKaCt2pTeQ6G+J3b9TV3QatC9Z+An7Ioi7iExtGn7Dy
        g6nDCSA99tlDfqR2c43E4Q6yNh0+Zp7dAxPc403OsoE+W+5ziuWoSX6+yP9ylFE1
        5UXvRbb6u8BWQCF+RIEhG47Qf37T3q60zkDJLe8yZbGs64satwY2Flmw+/FfisYz
        YI0i+86tNNx7KIbOs/UZCh7oorovNqHG28vSLuZiFkFRSphRosFdGBu090ltv+5c
        aZiZ328ZNoeZ2LQk/pDkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665403862; x=
        1665411062; bh=DaOchJ9jz8E6sYZqHLcJ3bADUsZchCLmV8LJHufmPfk=; b=c
        Ey4fhVGJDY+NEmjeo2OeAXOmmwsXJCumHniXEdKJKCJ6J7ytdETL8uKc0QvHwBfH
        D/SWN+H40FpOCo2KR6LKqefi4qzls3j1f8TZdAfI05dKEKmSKybvU8ZbsZaujpYg
        cIMcgKNoaQyrrMZe20yJKOJoIWlIfFvPxITgfDLQywEJ8kE6YF+qVSkCMZ+9pPTV
        cU+JQxk91fCZ3vjq0+gSE+BRcKVbvFPvLoUO9uzNI9fGeg4/wW+u14lKxgLyCuWO
        8F8+9pyWad20uEVBLnppbpMtGrnNtAPfmeo91X9kNXqtZQIQ1KWynjoVj+Gn84v+
        57IeORujLOJCEOzkmifCw==
X-ME-Sender: <xms:1AtEY3Nb6OBwUwRZjhHkQrCY_cmHS2H4qOpCX7ohRhamunr245wwrg>
    <xme:1AtEYx9eEtWXQwUsMHFA56PQ69LhQba3nzRk_TePIATkY_IhKWbL4MTqOwmOZ1xt8
    EJKaRdf6aXQzK681rk>
X-ME-Received: <xmr:1AtEY2RFVtc7nj22QLmO2SnPh8H7wmabnx8w8pjOKIg-19ubHKasvU0xmgyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:1AtEY7vPJid5561Iv_NxZIXIhiZZqXJRuKvhW6Vx_tRazYOHz8pTMQ>
    <xmx:1AtEY_c40HAb8TNdVsIpllkBj3zxBsQvp8CwfNuozqQKlGoKgSXQRA>
    <xmx:1AtEY33HcFJd60xZZnW8Gt6MzDHgXuhZcLzyy2XRXPZDn3xBFf8GXQ>
    <xmx:1gtEY25wF2MeHikuMOCBjVDer9DNAmp1vj-2A408JdSkckoSlA5o9oB0kkQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 08:11:00 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=EF=BF=BD=EF=BF=BDnnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v4 05/30] drm/connector: Rename subconnector state variable
Date:   Mon, 10 Oct 2022 14:10:38 +0200
Message-Id: <166540374295.183315.14551634440076043126.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220728-rpi-analog-tv-properties-v4-5-60d38873f782@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v4-0-60d38873f782@cerno.tech> <20220728-rpi-analog-tv-properties-v4-5-60d38873f782@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 18:30:59 +0200, Maxime Ripard wrote:
> There is two TV subconnector related properties registered by
> drm_mode_create_tv_properties(): subconnector and select subconnector.
> 
> While the select subconnector property is stored in the kernel by the
> drm_tv_connector_state structure, the subconnector property isn't stored
> anywhere.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
