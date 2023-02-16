Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC16698FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBPJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBPJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:27:51 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98B4A1D4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:27:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E00755C00EC;
        Thu, 16 Feb 2023 04:27:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Feb 2023 04:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676539664; x=
        1676626064; bh=jP9eT3Xwt+PHa6nYxYos+hxlaTDyJ+o8yJePB7G5N8k=; b=J
        EJbgvHpky9gM3V3RTD5L11bs6OC9JReSpFeLoUlyUfa7KfkQCdc+TunJEZaxGiEU
        LrT3mtukllbtH7FxCCDA4+ZGCHLOtk7ZuDZ+twSVNSADm1/LYomNAgdiOPGMAHuq
        j7itAmoXkSgYkYmpmEaomp5bYTCakcIJ8nXHeeBGLi5zVK4Pv3gN7rkPSOawnYbY
        5ZCUuljtH/SDFdOcnUjoHEF3NfmLr3r3wScNlGRYOH3o1STngmwnEm37Y/f75PeI
        143rf2I9PA82E1jZoJ3vi1eP9+vijP4tiN7mhmtrMfiGdHWqun0Uu5EYmEJ78ozn
        bSNSj0X8O83hQTT+iqP4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676539664; x=
        1676626064; bh=jP9eT3Xwt+PHa6nYxYos+hxlaTDyJ+o8yJePB7G5N8k=; b=A
        YmQya/unN7niV/Y+WB8YsoOJztg+KHoHJIawKR3W7gxXa3KxGWlqo7A6/74mH/3V
        dnYi2HxtdvQLRaObzkCB57O946GLmOEIFKxfpNDSlxsnEMtR2DG255QDPK3Y/hQm
        63b+IvyUSxdsA6NGbvbda14ixhGzj375W21Gz6uqt2NtVyi0eetruKvjau1zRMFS
        Ism26Pdc1BcMQgB46HvKqo99XXUMUxoFuMSZvUxQyIya/IgSwo2TVOQ0vFF+CclL
        rr0ne13+9q20L0WB9rZh/+Fce2MDRPlp5Mh0iVv+C3bFxcdczRqQW9kEMHTCfebL
        MPWhG/2UEEcA1sQoI8PAg==
X-ME-Sender: <xms:EPftY7YzcAAPMx-DuGx5cMcPHsq4U1yEWu9_dFe32zwhiert54lLfQ>
    <xme:EPftY6ak-cUyUfcNYkvVljoVP8c1dU-7jjGRhhkSYdKn-Bt5FUnagIwBOXqhoJ6vJ
    i0F4Txwp_qgoIgcbdM>
X-ME-Received: <xmr:EPftY9-WoElP0qrIaWm6tNQauJveSnV9qFl4rvujmFymuINpCn3wRtjD5BRiRtRMs8iT_mNShHf4IFQ-IUHPwBLYDnGDohw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleeifffgvdetjeejueejieehuedvteeigeehtefhhfeifeegleekudek
    teegueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:EPftYxoDZF3jErRmO3Oza01ZAMGNgu-yaPPTOqYxoVnMiT3coVzesQ>
    <xmx:EPftY2pymkIW15p6NUgkLyea39HqdDrBa6ZKHu7-kVILBCFeGE7bHg>
    <xmx:EPftY3SPLAWfe6dPEot72sGAFEH3cS10mX8tQO6Jua0tEkMGsBiZ6g>
    <xmx:EPftY0Y9GtGMubQWpAwClGr_QxdSwy7hpVaP6OCEPQtA6FHRYsINeQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 04:27:43 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
Subject: Re: [PATCH 0/4] drm/vc4: hdmi: Firmware clocks cleanup
Message-Id: <167653964791.480383.6636538561912185343.b4-ty@cerno.tech>
Date:   Thu, 16 Feb 2023 10:27:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 18:05:46 +0100, Maxime Ripard wrote:
> In order to accomodate the Pi0-3 using the clk-bcm2835 and the Pi4 using the
> clk-raspberrypi clock drivers for the HDMI clocks, we piled a number of
> workarounds over the years.
> 
> Since 6.2, we've switched the Pi0-3 to the clk-raspberrypi driver, so we can
> now remove those workarounds.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

