Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42063C3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiK2Pib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiK2PiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:38:23 -0500
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D2A91C8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:38:22 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 02Ozp6txJm9gv02PApWxO5; Tue, 29 Nov 2022 16:20:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669735218; bh=zTsu9YvjjwpwF7zSkRalIemgq9HBKFWhACD/LncT3zM=;
        h=From:To:Subject:Date:MIME-Version;
        b=EvoQWEPn6+aJ7OysISOue95GBqEH3etE/fPxXolkiY7Kmhwk++Wb9DGdIh+5Y4Wgn
         n4iEN4TXMtpeeFnvNL0nG3N0y5XlPpqinowcRLrbFwdCfqy5ctEGh5vBrVeFzdiuww
         u981UjGzk9dv5FbIz7OtNxKsnuWN/Rmth41Dz4k2/0LzNq8TvDddhbldxsrcNmaes0
         TA145W2IKxaPzYBxkLvrsv3N+u1Ny4kuOT/e/Bcggx5ktbw/poTudnjdAfvGbxmHqM
         PSEFZvhFZZ1L0YjHBeD9XstF/Cg0bL3ir3tJcKbR+0juZ8x2oAcMYxo0dodDbJmK9c
         8cDWRrTxrawqA==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 2/3] ads7846: always set last command to PWRDOWN
Date:   Tue, 29 Nov 2022 16:19:58 +0100
Message-Id: <20221129151959.26052-3-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129151959.26052-1-l.ellero@asem.it>
References: <20221129151959.26052-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAmA3u28NvvV4JGz2hpRmeIayrM1Psfe+/ROG4Pc5pcbewBBCWDiNDpCFeyPYwVYM80csFMbbKUZ3XJG/cmlxqQkfGE1tCpBO72NEMQqgs409Sl0IJe8
 WdKCYuFi7Cimg+x3BdKcXcV57LD0oMM5q4CQouGNwIvsBVD8U7pY6kzndCdQuTEHsGXt4byoe/LB41mNrwUGz35RgPTMb4H3WVlrJSetuS8u+E2jo0sZarZi
 c4KXesBtVAZWTH8TnHo1O+1ehgUpsXrNfrY0NKAWM1P6A1CCvDPKopS44bm3YdR8+GRCZqm6ASQ0KYaBfA6+2YJuQvmdwmtYN3VeRtOXI5IgOs1ibDFLwqnV
 +UuVkpmAAcIPV2TuP9yrRMo0BDQHhzMkS+79M14fUTWyA4GLqghnwdPmwf34RPItmIpdRozEyOe3U/1ZJAPGS0Xn+li5vLQLvOtUqpygp+as2j6fT3S4yETr
 T88OxdfG2xFhM8bvtwGJaJw/EBYltnV4Pwv3yTPdA9NvJz2J8SfCpaLO5F81NbXM9EV73+QLxzuv0Nv74bWfyh0a6Yeq8oX24ZlYMQ4mqUf693lvS5TyYFc0
 GIHuMUBsrUj+csjCHeqNyeur
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controllers that report pressure (e.g. ADS7846) use 5 commands and the
correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.

Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.

This patch fixes it.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 24605c40d039..9e15cdf6faa0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1066,6 +1066,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
 		unsigned int max_count;
 
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
 		if (ads7846_cmd_need_settle(cmd_idx))
 			max_count = packet->count + packet->count_skip;
 		else
@@ -1102,7 +1105,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 
 	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
+		u8 cmd;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
 
 		for (b = 0; b < l->count; b++)
 			packet->tx[l->offset + b].cmd = cmd;
-- 
2.25.1

