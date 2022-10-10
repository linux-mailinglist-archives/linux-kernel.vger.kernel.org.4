Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8505F9E65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiJJMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiJJMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:10:53 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E21647D2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:10:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 9AEDA2B067AA;
        Mon, 10 Oct 2022 08:10:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 10 Oct 2022 08:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665403847; x=
        1665411047; bh=h6MDYVkUrCUpK3ETe9fcuN2TM8Pd074coaFYvzfkf3s=; b=X
        8TTYRqTCQS2QJhsYN7GvvAJRh7lJ7Anah3pR2RReFaL/R+5luKeopHOSW0w6nJCC
        wEDZF+lFROGCYFiFLWRbYuNAlFBotirqVeewpXjYbElZQ8E8k5KPJZDpxxL+8o7P
        m14oe5QNJyBDCN2UhEX41FSQ14j2V2TLtp7O9cFS9aS7GuDs/ejSz3oo9Entho4t
        gzrvbg4H8gRWrgpJLH0mg8UpA2HgJSvg5Wkf9tidJBKGGP8SFUy3Hzs1uHRVTjel
        2mgZhegx/CmyQOCuFz+Nw4kihKjUipqWx2JADrbKtx24XNa0J0gODEpgjc9r/9aX
        xUe3E87GwsKevIT7iqzbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665403847; x=
        1665411047; bh=h6MDYVkUrCUpK3ETe9fcuN2TM8Pd074coaFYvzfkf3s=; b=H
        PpyDxQ+0ZEygAo/SXVkKH7PGtx5TPR0HqlATUtyCUxdQdC3h8ctBbDzxmbHVjc+i
        nRH3i5GtxCMz2a8oTcpUscBfrrTgP/Dj8pVAlyWSnGakoXRBAmC9Fg6nxGMH2g4a
        wcw/ZS/oZyxaicAtMS5cohDJOr/37IIqrD1kdQg1kCPOgAkATaNedK/cJLfGDyXD
        XgHzYdCZ+yAQxJi0zFRJP7+rvjQ290H1l9hzZoa9hCwtp3Q6cFCsanyQ1ItdC3OE
        9mBzpBTAxmOCOG5NoebuKEHAaNR9sJUnU6WS/m/VD9vOf3jbdy8vtlcddHawV1Yh
        UK0qVaRdd2pRBHdt4bviA==
X-ME-Sender: <xms:xQtEY9ZqrX6ifLo6Uh1Pyk-C6WQKbR6hgrOtvLDxIYYHLxR6cqee6A>
    <xme:xQtEY0bdEBf3f3gAPzO4ZztjUZCBvdHAFBWPjOgj-vXHoNyowVTfwYGcMEai8OJkG
    7IVdpspdyTzVFMgRsM>
X-ME-Received: <xmr:xQtEY_9y46DdXsGqz3rxNTqtSbPjzoj6tuBxt3QrbtWfwpnhxYvw1gJ-Ma3V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:xQtEY7p8IERGoTKuQJ72GS68rLEkGr8D_8-OhO9De8DfkXIa5vCB2w>
    <xmx:xQtEY4r7n7X0UTKUO3laEFPGecThTwGQEAZFNiWKWRhvoTEhaQ-weg>
    <xmx:xQtEYxSyOiGzUuzutWeAtvZioN4TcrsBGPdorJiYKgwBDqZl6fV0lQ>
    <xmx:xwtEYwF-Dwf_OHKQz8Xh1M1zUNqYz1MchTlaPg-7bWhc07gzqysHGEKu99Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 08:10:44 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Samuel Holland <samuel@sholland.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=EF=BF=BD=EF=BF=BDnnes?= <noralf@tronnes.org>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v4 02/30] drm/tests: Order Kunit tests in Makefile
Date:   Mon, 10 Oct 2022 14:10:36 +0200
Message-Id: <166540374295.183315.10600855236256660249.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220728-rpi-analog-tv-properties-v4-2-60d38873f782@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v4-0-60d38873f782@cerno.tech> <20220728-rpi-analog-tv-properties-v4-2-60d38873f782@cerno.tech>
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

On Thu, 29 Sep 2022 18:30:56 +0200, Maxime Ripard wrote:
> Since we've recently added a ton of tests, the list starts to be a bit
> of a mess and creates unneeded conflicts.
> 
> Let's order it alphabetically.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
