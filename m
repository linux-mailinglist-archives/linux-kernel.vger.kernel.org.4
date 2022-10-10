Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3A5F9E83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiJJMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiJJMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:11:41 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D436CF4D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:11:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 086BC2B0652C;
        Mon, 10 Oct 2022 08:11:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 08:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665403891; x=
        1665411091; bh=vRm7+WmZAhRa5yrqCAa1OvaqLCpV3QJHnoFPD/kwJUk=; b=t
        7JHUYh3iY/qHO0nLu9pFFjSFd+EwQvae/pkjocSgxemsQ3hYmfDE8wELqxEWJ7eb
        YFLSulmjs64K36WZ9uvlrxbom8SELPS31g5zLFlMRqZJf6Wz2sMDOjS6CVkIEval
        Y7DunjkiD6j7EEM9MrDR78HxNDuhZQvChy0x3vY/7Gr7uFtGCMEz2teHxIRA8fx2
        nAp0w9g/2LYhk1DgoYCdc5/Z1CbcnzYBitmA7nxOn6RlbDIwk/jJ3+Nw7hxM2Mwz
        hcwEQD157OpreliBTiQVWIDovhD9tR7DMsXsR3Hmi7rvRiX0TVUT53i8alUQRHVN
        LWqR6V2PUfVU9zE6kE+iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665403891; x=
        1665411091; bh=vRm7+WmZAhRa5yrqCAa1OvaqLCpV3QJHnoFPD/kwJUk=; b=m
        tlnFNIV+gjVMYFpaC8R7BpdMXXlkfc0yHLhYYbc9JmzxX2VBtyoVe++rb2jrC/+L
        WZpGokwjLCZO3wSDxyPVI7MpVqp3YjNHROapvoDBePTXq0FNdZ45ehnAXDX59O6w
        E2fsSg8PpbFPDy/+qsVz++YHhbTIrdT9iH0R1i3bNgwoo+ASA80f053Gyk3CdjRy
        aOHwfJwyaYH/h007Tg9CW2R8tn3Qazp2K/6EUMaqTXMhbfVmR7ucy+1jxvqn4OmP
        rg+QdMXbq+t4TUBoCLeO6Syi6FHEJ4O0rAQV5gDeOBaduL2xpQqy2XPgnHx3pYEG
        x4PKn+DSbT3E9wq/Vi25Q==
X-ME-Sender: <xms:8wtEY2_CGNCUe2Co5AL-K-EtsTUKmFR7f9GZalRsm5std5o-GFS2Gg>
    <xme:8wtEY2ufhKGajwTv5nhJ6ZtWjCMdigpjE5LROdjTZOCkSqFAyhZeyRpPHW2sXTHii
    3YQIGChQxGce5qLkPA>
X-ME-Received: <xmr:8wtEY8BatqTCo5z8FEUJt2LLLBg4ieVs7thWOR6LS4qsGCzhK7LlMssFF3Au>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8wtEY-ePEGXpDC2-RABS_12V7gYliG9PwXfb2N16YEGqkCd22wefZQ>
    <xmx:8wtEY7OTjiCYJmRZZiPJ2IlssEB3RvBGBqzBmbwkmDPaxCwPURhWgg>
    <xmx:8wtEY4lRUtk5eMQT9Q9Ukn8nPKpDMXpt8jCBelgTkWHsaKuM15Op_w>
    <xmx:8wtEYyrnlJ5wf-dN0GgiMee_lrpgP7L6Ug0HCrJfdVIy55mdvyLX7GJxSJQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 08:11:30 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Karol Herbst <kherbst@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
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
Subject: Re: (subset) [PATCH v4 25/30] drm/vc4: vec: Fix definition of PAL-M mode
Date:   Mon, 10 Oct 2022 14:10:42 +0200
Message-Id: <166540374295.183315.18200738975920089518.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220728-rpi-analog-tv-properties-v4-25-60d38873f782@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v4-0-60d38873f782@cerno.tech> <20220728-rpi-analog-tv-properties-v4-25-60d38873f782@cerno.tech>
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

On Thu, 29 Sep 2022 18:31:19 +0200, Maxime Ripard wrote:
> From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> 
> PAL-M is a Brazilian analog TV standard that uses a PAL-style chroma
> subcarrier at 3.575611[888111] MHz on top of 525-line (480i60) timings.
> This commit makes the driver actually use the proper VEC preset for this
> mode instead of just changing PAL subcarrier frequency.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
