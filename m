Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75661DBA5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiKEP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:27:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DA22515
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:27:28 -0700 (PDT)
X-QQ-mid: bizesmtp73t1667662032tnuqzpl8
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:27:10 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: pbrYO/Ho8RISYoAycHk+TYKNcHC8L7FsWwGMHASZQIM1+Wr3ob3cqW+fxCROs
        5JNj57boAvAK4tsB+bo3/LEC1Ie47vmhqZVI1c1XUnrHFGE2smjZcBLl2l0YfKMIPLKjOWR
        2nbXQ+QNBwrvS4s4wfMZ/Ux3i3mbzbXgb+WXhIXz721CYivk3yhcKUW0EZX0du907DxoCx3
        tGeErXe2B8MoSsExfVnN95whyJqe2Z05KAtb5yOWsWUjP+QJOvyE7FyigG4SwtoHFxuPS0l
        nKw6NUEozQHHYy7m9HywNOcBiKrwb7lg3OCkGMftnZi560qrAcqkpetX0AWW01KZOb+5q64
        hlMN6MsSBPx26XjkS+8nJMvzNeyWw==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tty: n_gsm: Delete unneeded semicolon
Date:   Sat,  5 Nov 2022 11:26:56 -0400
Message-Id: <20221105152656.4638-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the unneeded semicolon after curly braces.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..85438a3d89f1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1267,7 +1267,7 @@ static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
 		}
 		if (!sent)
 			break;
-	};
+	}
 
 	return ret;
 }
-- 
2.35.1

