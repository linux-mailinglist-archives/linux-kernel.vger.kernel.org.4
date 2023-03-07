Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0826AD707
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCGF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCGF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:58:36 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CACC211C2;
        Mon,  6 Mar 2023 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=skQAH1wrki2jdU4ERbZ2RamtIdkAj73e5Wp+ZsDAZIU=;
        b=dQxOWeaWfuWlonSb7loPyvR9fpLIXetKzV8qre5rzqeGpb6E89FtwlkCtDWWcd
        pWv3xwOE6+x5/B4d0y+xoEjZbuPkoABP0YKw2h8niy1dz2H3IRivyyPCw+bKGWA3
        4DXv7PncwpTk30GMNtW3y4HDNQUnEW+U3ili+Q+J20x0o=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wAnl1Nd0gZkkjaPCQ--.38627S2;
        Tue, 07 Mar 2023 13:57:51 +0800 (CST)
From:   oushixiong <oushixiong1025@163.com>
To:     Bin Liu <bin.liu@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: [PATCH] mtk-jpegenc: Fix a compilation issue
Date:   Tue,  7 Mar 2023 13:57:48 +0800
Message-Id: <20230307055748.1836087-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnl1Nd0gZkkjaPCQ--.38627S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr17XF48Cr18CF1xZrWrXwb_yoW8JrWrpF
        Wak34vkrW8Grs0grWkJw17JF15Gw1fXFW7Wr17uw1Iq34fJw1xJr1jya4FvFZ2vrW7Cas3
        Jr10v34xGr4qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfL08UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBzggrD2I0XjhvrQAAsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: oushixiong <oushixiong@kylinos.cn>

‘mtk8195_jpegenc_drvdata’ defined but not used [-Werror=unused-variable]

Signed-off-by: oushixiong <oushixiong@kylinos.cn>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 969516a940ba..b875fc664150 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1846,6 +1846,7 @@ static const struct dev_pm_ops mtk_jpeg_pm_ops = {
 	SET_RUNTIME_PM_OPS(mtk_jpeg_pm_suspend, mtk_jpeg_pm_resume, NULL)
 };
 
+#if defined(CONFIG_OF)
 static const struct mtk_jpeg_variant mt8173_jpeg_drvdata = {
 	.clks = mt8173_jpeg_dec_clocks,
 	.num_clks = ARRAY_SIZE(mt8173_jpeg_dec_clocks),
@@ -1898,7 +1899,6 @@ static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
 	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpeg_match[] = {
 	{
 		.compatible = "mediatek,mt8173-jpgdec",
-- 
2.25.1

