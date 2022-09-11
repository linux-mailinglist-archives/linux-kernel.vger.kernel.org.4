Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DB5B4E6B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiIKLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIKLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:32:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D189F33E1C;
        Sun, 11 Sep 2022 04:32:03 -0700 (PDT)
X-QQ-mid: bizesmtp63t1662895911tw51spr2
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 11 Sep 2022 19:31:49 +0800 (CST)
X-QQ-SSF: 01000000000000E0G000B00A0000000
X-QQ-FEAT: 5SuXhcxe96lg37V9JdaSmKBOZI3CUI6DLycPup5sOb9x+Uk2CUQxaqjy37YuC
        AFYBiYcziFCaTDlHTtzH5DAUhGTsQsCaAtI5zOsr/Hs4TSUT3SK3s5vSyLSSO5zBTA+55Ou
        HRVjav8w0hsBFMrcdWf2R309bii587VjxyfBnBtcDwk5lS7nZXlcQQjYJ7l+oucEjubMFuE
        2n2ERQ8wYKT7GP0TvWacK7vdh3DJ7R/CgEH/AS1ovJ5iuHBMdfcO9QBfFpA+bbSo1kS1A4F
        ERZ/0M/r82tcw50WELer/lHTLKCoIu+ALmHQvUYVOeKeuPqbP3Uv4YfY/0cf395RKzuZt9k
        KlXwkqG+m0Bv2hQEtiDZNrBNBAk5o2ndLWrA8BL
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        GR-QLogic-Storage-Upstream@marvell.com, njavali@marvell.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: qla2xxx: fix repeated words in comments
Date:   Sun, 11 Sep 2022 19:31:43 +0800
Message-Id: <20220911113143.2649-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'not'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/qla2xxx/qla_dbg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 70482b55d240..3a34ec9f3048 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -356,7 +356,7 @@ ql_log_qp(uint32_t, struct qla_qpair *, int32_t, const char *fmt, ...);
 #define ql_dbg_vport	0x00040000 /* Virtual Port Debug */
 #define ql_dbg_buffer	0x00020000 /* For dumping the buffer/regs */
 #define ql_dbg_misc	0x00010000 /* For dumping everything that is not
-				    * not covered by upper categories
+				    * covered by upper categories
 				    */
 #define ql_dbg_verbose	0x00008000 /* More verbosity for each level
 				    * This is to be used with other levels where
-- 
2.36.1


