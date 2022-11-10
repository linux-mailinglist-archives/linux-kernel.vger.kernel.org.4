Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6506241DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKJMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:02:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B81B1D0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C4361262
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A55C433D6;
        Thu, 10 Nov 2022 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668081754;
        bh=7FTjqF2vypZO8iNUM0i1QVNi5EOess1TmlkVdrqkKf0=;
        h=From:To:Cc:Subject:Date:From;
        b=iMCysXRqDqc5O74eEFgu3MGtt4vIY6E17F0NyHH/h/AfmZWbreonUHFrMyhvnexxp
         gxXdtjA8nuekJ/i7xK0z6ObCmQZihRjaLpbRdqMTnln35dyDPbpxFg9khX5sYpxv9T
         QnmUqDmrIHh/WiCLp5Ac1oEP99fPGJGVD1n/M/bUoaN4pEyoZ2rxt2g2PNjxlJ7NKg
         I/R0E/B3rviUEu7om4KSLSyC+u2QDrCVSjguG+w6S6HzPHZ3NnUo7gmC71VTuwglnA
         GnaFw2QCFPvNud+orEYHLL/ER94NKzDIgDYXgFFCM6Kl6zMdORSNVnwromgu51Bjsh
         iYIKEaP8j0zaQ==
From:   matthias.bgg@kernel.org
To:     matthias.bgg@gmail.com, nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: mediatek: Add deprecated compatible to mmsys
Date:   Thu, 10 Nov 2022 13:02:22 +0100
Message-Id: <20221110120222.32297-1-matthias.bgg@kernel.org>
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
 drivers/soc/mediatek/mtk-mmsys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index ba2e79b26993b..47106f557c574 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -303,6 +303,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8192-mmsys",
 		.data = &mt8192_mmsys_driver_data,
 	},
+	{	/* deprecated compatible */
+		.compatible = "mediatek,mt8195-mmsys",
+		.data = &mt8195_mmsys_match_data,
+	},
 	{
 		.compatible = "mediatek,mt8195-vdosys0",
 		.data = &mt8195_vdosys0_driver_data,
-- 
2.38.0

