Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F5667A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjALQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjALQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:22 -0500
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 08:12:41 PST
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C35F4B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:12:41 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.4.60])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id F1F3D22D64
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:33:43 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-nclp8 (unknown [10.110.115.59])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 435361FF2C;
        Thu, 12 Jan 2023 15:33:43 +0000 (UTC)
Received: from armadeus.com ([37.59.142.97])
        by ghost-submission-6684bf9d7b-nclp8 with ESMTPSA
        id Y7zJDVcowGNsBgEA+Oyw8g
        (envelope-from <sebastien.szymanski@armadeus.com>); Thu, 12 Jan 2023 15:33:43 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-97G0021cff9d63-2bf8-463c-96d1-a03284752c29,
                    62BD97EA99DFFB4B62E3774F9F19AD0763AB9DD0) smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.140.211.188
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] drm: panel: Set connector type for Armadeus ST0700 Adapt panel
Date:   Thu, 12 Jan 2023 16:30:30 +0100
Message-Id: <20230112153030.28567-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2906792088147848171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepffeufffgveeiffelteelgfetjeffueffuefhffeikefhkefghfejjeeufeduteegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Armadeus ST0700 Adapt is a DPI panel, set the connector type
accordingly.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8a3b685c2fcc..22c579d79d01 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -843,6 +843,7 @@ static const struct panel_desc armadeus_st0700_adapt = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct drm_display_mode auo_b101aw03_mode = {
-- 
2.38.2

