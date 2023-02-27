Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9126A3A46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0FJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0FJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:09:38 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C21BADF;
        Sun, 26 Feb 2023 21:09:34 -0800 (PST)
X-QQ-mid: bizesmtp91t1677474546tnx1hwml
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 27 Feb 2023 13:09:00 +0800 (CST)
X-QQ-SSF: 01400000002000I0Z000B00A0000000
X-QQ-FEAT: CR3LFp2JE4nh9Hz0vOzbBp/DnSzGhy/CrqreMsExWYLq53wGo40uFbRfs1ZR0
        wckWAS5Yt/bONMZ6MnraJRzqIxHfjfum7GG2XRXPQ+NKlx1ohhGmT0/5z5PziYe2rV7tcuJ
        t4kbH19x3rBJnSrY3JpPrLNWDdPnKIM+cLLpaoR/h4NohmITWpX1N7KaJP/I7FLpMRVIiFo
        K63jxe9E+kjjI3r7ygGjXk+5b4MI3Q7ipckrdPY0o1K5xaxM2rKHE4lr1zLI6FgbW9PjgTV
        /N556S+WtDpQ087UCugYagOE/eUe1FNxEs0KwnE/u7VOdi2MUkzqP+eRkZM4jgT/159SogO
        r8cconDsU/Vzx5jb7djpS38vRT0bgwpsM7zdyfBykKct8Q3Q7FZz/kL+tKh9NyQNsEe5r1Z
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     dmitry.torokhov@gmail.com, akpm@linux-foundation.org,
        glider@google.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] Input: libps2 - add support for lenovo xiaoxin keyboard
Date:   Mon, 27 Feb 2023 13:08:58 +0800
Message-Id: <20230227050858.21596-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified keyboard_ids in function ps2_is_keyboard_id
add 0x83 for Lenovo Xiaoxin keyboard

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/input/serio/libps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 3e19344eda93..84f366846cf8 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -156,6 +156,7 @@ bool ps2_is_keyboard_id(u8 id_byte)
 		0x5d,	/* Trust keyboard		*/
 		0x60,	/* NMB SGI keyboard, translated */
 		0x47,	/* NMB SGI keyboard		*/
+		0x83,	/* Lenovo Xiaoxin keyboard	*/
 	};
 
 	return memchr(keyboard_ids, id_byte, sizeof(keyboard_ids)) != NULL;
-- 
2.20.1

