Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3AD68CED3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBGFWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBGFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:22:51 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D992B126CC;
        Mon,  6 Feb 2023 21:22:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vb5hedm_1675747361;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vb5hedm_1675747361)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 13:22:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: qla2xxx: Remove the unused variable wwn
Date:   Tue,  7 Feb 2023 13:22:34 +0800
Message-Id: <20230207052234.24535-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable wwn is not effectively used, so delete it.

drivers/scsi/qla2xxx/qla_init.c:1657:6: warning: variable 'wwn' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3964
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index c5e73d5a26b1..1dbc1496ebed 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1654,7 +1654,6 @@ static void qla_chk_n2n_b4_login(struct scsi_qla_host *vha, fc_port_t *fcport)
 int qla24xx_fcport_handle_login(struct scsi_qla_host *vha, fc_port_t *fcport)
 {
 	u16 data[2];
-	u64 wwn;
 	u16 sec;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d8,
@@ -1694,7 +1693,6 @@ int qla24xx_fcport_handle_login(struct scsi_qla_host *vha, fc_port_t *fcport)
 
 	switch (fcport->disc_state) {
 	case DSC_DELETED:
-		wwn = wwn_to_u64(fcport->node_name);
 		switch (vha->hw->current_topology) {
 		case ISP_CFG_N:
 			if (fcport_is_smaller(fcport)) {
-- 
2.20.1.7.g153144c

