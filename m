Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764F625548
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiKKI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiKKI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:29:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A8E79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF1761EBB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C739BC433D6;
        Fri, 11 Nov 2022 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668155368;
        bh=IbKTOSMRuvpV8+oOxfdFXA1JqBMgz65cI7OeqnvELIk=;
        h=From:To:Cc:Subject:Date:From;
        b=STTRE6H/1T/mrvwgv3N6PQyijKtXpeAPGlTOng+Osur9C0CwbVaiO9InFBF7R7Q3H
         cisSqYm8zwxZjrgPdkHu/3VSAnLRnHNrwshrfC0Q4gA/tQ/ED9ht4sVr1+1GPB2nIS
         p7g8CUfJzAZgCJ4ZRZNK0KWSsg/DmZKHkLHX7Ug9hJNqNVXhVoIvz4VEf3ap6KxysS
         2F74FPN/SQg5I3IFmSms3bHZfD5+O0oTJ7jyfv0cjYngcD08dZxM09+trxaTGX5atV
         hPWd/ByQacSUXyxWZPM6NnJtQ53VW96zs2AIWEHqCM1UZ5Bu6cKVo25053IyiM+vNQ
         N40vxDESs3Law==
From:   matthias.bgg@kernel.org
To:     matthias.bgg@gmail.com, nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
Date:   Fri, 11 Nov 2022 09:29:12 +0100
Message-Id: <20221111082912.14557-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

For backward compatibility we add the deprecated compatible.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes since v1:
- fix drive data pointer

 drivers/soc/mediatek/mtk-mmsys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index ba2e79b26993b..f3431448e8431 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -303,6 +303,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8192-mmsys",
 		.data = &mt8192_mmsys_driver_data,
 	},
+	{	/* deprecated compatible */
+		.compatible = "mediatek,mt8195-mmsys",
+		.data = &mt8195_vdosys0_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8195-vdosys0",
 		.data = &mt8195_vdosys0_driver_data,
-- 
2.38.0

