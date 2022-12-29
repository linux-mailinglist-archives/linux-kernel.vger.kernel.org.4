Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B70658D49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiL2NdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiL2Ncd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:32:33 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6CD6240;
        Thu, 29 Dec 2022 05:32:32 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B0825FF80F;
        Thu, 29 Dec 2022 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672320750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSihM6Wjt78AkZJ7cO7U2XtTCOIBs2Jh3yvc+KsQGxk=;
        b=N7howy8iMtRhbikukCOsHdZDGVDGD42jrWpgooTf/2YbD0IMI+0hGRCEJoCi/8SEpjH+Iv
        UolNxWaFxO0LzzBrTtZRVwhYhRRJauYuIm4PBOjBiSRattAkNioGNZeCOGV+qhFnY2+oOA
        zKE9I2uSGACQ+EZuDYsVG7xRqSSYnflFPGK5nwU5S+umBtsxQsbTpG+4qCXTOuy4NF21g8
        tQ2+eLAz/dOcplgnWeJSHSzHtZMM3t2Qj1mZId2JLP+U2+QXhWfn6uUinoXxR1nCRprILw
        aCePAM7v38sIHteoPV12S8R57E2TkXsy/Tj9j4jzTYa78zT4iUjvWuhKFAdsnA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v3 06/21] staging: media: tegra-video: fix typos in comment
Date:   Thu, 29 Dec 2022 14:31:50 +0100
Message-Id: <20221229133205.981397-7-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "skip" in "so we can *skip* the current channel" or it doesn't make
sense.

Also add articles where appropriate to fix English grammar.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 6aecdd28bd82..ae7adf640e76 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1762,10 +1762,10 @@ static int tegra_vi_graph_init(struct tegra_vi *vi)
 	 * Walk the links to parse the full graph. Each channel will have
 	 * one endpoint of the composite node. Start by parsing the
 	 * composite node and parse the remote entities in turn.
-	 * Each channel will register v4l2 async notifier to make the graph
-	 * independent between the channels so we can the current channel
+	 * Each channel will register a v4l2 async notifier to make the graph
+	 * independent between the channels so we can skip the current channel
 	 * in case of something wrong during graph parsing and continue with
-	 * next channels.
+	 * the next channels.
 	 */
 	list_for_each_entry(chan, &vi->vi_chans, list) {
 		struct fwnode_handle *ep, *remote;
-- 
2.34.1

