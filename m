Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07387695959
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjBNGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBNGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:41:17 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16471E2BD;
        Mon, 13 Feb 2023 22:40:59 -0800 (PST)
X-UUID: 820583598d9d482faa57c8e4fa60c22f-20230214
X-UUID: 820583598d9d482faa57c8e4fa60c22f-20230214
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <yijiangshan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 458980073; Tue, 14 Feb 2023 14:41:00 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 4E0ECE009413;
        Tue, 14 Feb 2023 14:40:55 +0800 (CST)
X-ns-mid: postfix-63EB2CF7-1129417
Received: from localhost.localdomain (unknown [172.20.125.154])
        by mail.kylinos.cn (NSMail) with ESMTPA id 603BAE009413;
        Tue, 14 Feb 2023 14:40:54 +0800 (CST)
From:   Jiangshan Yi <yijiangshan@kylinos.cn>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        13667453960@163.com, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] md/raid10: Fix typo in comment (replacment -> replacement)
Date:   Tue, 14 Feb 2023 14:40:13 +0800
Message-Id: <20230214064013.2373851-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace replacment with replacement.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/md/raid10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..7b264add0d52 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1626,7 +1626,7 @@ static void raid10_end_discard_request(struct bio *=
bio)
 		/*
 		 * raid10_remove_disk uses smp_mb to make sure rdev is set to
 		 * replacement before setting replacement to NULL. It can read
-		 * rdev first without barrier protect even replacment is NULL
+		 * rdev first without barrier protect even replacement is NULL
 		 */
 		smp_rmb();
 		rdev =3D conf->mirrors[dev].rdev;
--=20
2.27.0

