Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9033C5EF21C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiI2JdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiI2Jcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2400147F32
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:32:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8913D5C007E;
        Thu, 29 Sep 2022 05:32:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Sep 2022 05:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664443930; x=1664530330; bh=fwRV9dogL7
        eDj5fyeF61H1sWa8fJ3t+2AuwaHFTys/k=; b=CFyLRRu3+4/YuEBmU/GlkQKlnB
        gsnXc9fAb2h0sfxKAQfR1VfRPUoOo6pxNIz4C1oKRHXrfFLjQpVAQBQCY1Wn3oJ4
        bMJLluuN1el4sQ6pzrcsUBQcmhtF0Hm9AbUsyUUGenICDgrB3lIyVzpQEPPURdaQ
        aembGk58o4DgeEfq+KTwm3JsiHwOIKVLjU+6hzjEHmAR7NOLr9pqnUuRmFI+Mp8B
        KDhNQvpg6jX+SV9jvrg8AjVwwIYE5MKa4cPEKERMnwC2Df2QRQsDaN8AZDRyJB3G
        pLFBaamzFDekRICfhm/Q+06k+3vU1qSz/4OPJtg9nIWLUTYUqUGPxBazUaMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664443930; x=1664530330; bh=fwRV9dogL7eDj
        5fyeF61H1sWa8fJ3t+2AuwaHFTys/k=; b=YX9PZzkYtTE2abIDCu03e+Ff/HQ2j
        ZPZGrBzNJ79txxR34Lx5poaW2GVEnJ9yRwszrTTdL9fdYholQja1cN5iPxjHzpMr
        m0Oht1mOQCSA/ERDfPiKu7apVm/PQUrLgR4wgcOCKgjTrc7R4ZuKeEvQk4w3iIZV
        Gb5O3EACRCkpsCOGoz2tZsw+67zYGAcmVFVWeIMzsYQdga2j6r7Zh8vli7eA3+Pl
        mneGLId4qYiLZwRt1QU2coEL+qn6TDyNSzsk0dnxXazp8/qrwXAU2ha+UynmebuV
        yJaM1k8qlt+k+Qt17z22deBSuUlRkCnYNGrfV9HiUfCInh3d6HuPMRM9w==
X-ME-Sender: <xms:GWY1YxXPuaam93O0mJjEUpmC1C2D-GWFyQAL1qmQMgvGvUd2FKzrsw>
    <xme:GWY1YxkmfFLmk8ZrvUb6eS0cPDG_cDkFR8vSNqPKHDKnNC1NXJnCFoz2hUvr8FuHa
    Fia_lGKDqoCLx6UVIs>
X-ME-Received: <xmr:GWY1Y9YGg21eKlwYGXCsSlfrPL8UNqfGHjJ2kt0X62yodiFAmQGi6nwPYZAZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepufggtgfghfffkffvvefosehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleeuveetteffvdevlefgffelgeduueefleevfedvudegheekfeekheejieek
    gedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GWY1Y0WZGX_PVrvj8-9sQrtR4Vbokim9Pnz-J6-f1A3YNB6T0SMN6g>
    <xmx:GWY1Y7kEenu83EsQrDBLTPQLZV43pIE1u4oJA5aQDWWPTdlH3ATdlg>
    <xmx:GWY1YxfVpHyB-xEpAoP6pkEWw8hDCv5mO4v16h9xNBhb5EFz4z4MkA>
    <xmx:GmY1Y0iVC-ndILv8AInZynZRkhyObWvw-vrXNSeyR_3RjwtvNAb8yg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 05:32:09 -0400 (EDT)
Subject: [PATCH 0/2] drm/vc4: hdmi: Fixes for the RaspberryPi 0-3 stalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIxjNWMC/w3LQQqEMAwAwK9IzgY0RdH9TW2zNVBiaegiiH/fHucwDxhXYYPP8EDln5hc2jGPA4
 TTa2KU2A00EU077ViLYBGHTUtuKXHEr9xsuMR1Zk8huM1B34c3xqN6DWf/2nJ+3z/TibRQbgAAAA==
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 29 Sep 2022 11:21:16 +0200
Message-Id: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=OwDaJ5tbgWppBohK0T47YkCsl+BbZZLYLyUwpOPSc38=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmmyb1HrhS8zjJa9OzMQrmUtYxHtBnYN4SxvjZU29L2s3RG
 1bEZHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiIpz7D/wjpX1ptBdFTft1f8MN8xr
 0XmzZ/jVe3e9J3Wj7I3nBy3FxGho57Dlt63siy1YR5dgnd+81stGzxc9U/W7gEg8+uS9ncygwA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a series addressing the current bug that has been reported for the
RaspberryPi3, where booting without an HDMI monitor attached and with vc4
compiled as a module will lead to a stuck system when the module is loaded.

This is due to the HSM clock not being initialized by anyone, and thus not
being functional once we start accessing the HDMI registers.

The first patch will fix this, and the second will make sure we avoid that
situation entirely in the future. This has been tested with 5.19.12. Earlier
versions might need a backport of 88110a9f6209 ("clk: bcm2835: fix
bcm2835_clock_choose_div").

Let me know what you think,
Maxime

To: Daniel Vetter <daniel@ffwll.ch>
To: David Airlie <airlied@linux.ie>
To: Emma Anholt <emma@anholt.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---
Maxime Ripard (2):
      drm/vc4: hdmi: Enforce the minimum rate at runtime_resume
      drm/vc4: hdmi: Check the HSM rate at runtime_resume

 drivers/gpu/drm/vc4/vc4_hdmi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
---
base-commit: 58df6af8cea3c5377c0220d9fb47cbf85a216f54
change-id: 20220929-rpi-pi3-unplugged-fixes-5d61ea2cc383

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
