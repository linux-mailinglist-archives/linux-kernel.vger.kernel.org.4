Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7D5BC431
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:21:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BD1FCCE;
        Mon, 19 Sep 2022 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663575671; x=1695111671;
  h=from:to:cc:subject:date:message-id;
  bh=deyOOXlYqnmDLE5BpLkNWI5st6/3bKZVJDo+6iqfkKk=;
  b=keo0uY7KA3ZgLPXOX48xHyYlDJEGAkGGeYl7XHEI0jYS/mG7UGkJGlEJ
   W8MXOULQAYhEljmUQuhUnQdUfNO3jO+oR2g4zQhAl/eF1IVxdIdr54Uhg
   RzKnE6mHO0Pu5GygNOyFmdwU1+o5HWVR+fWPEhKZyP0qAew1/Zj0+T82y
   ZLK1SSQauly8D10+vaTm3Iklk38LoT5Jzv5wb3w8Cf/r726BBrrKXrwE0
   ArncR2Z8Z9bZtQwAtc7Duq9Qi9GISNWAYrKNh8vc15pI9FRofwp+vZfgw
   o0TiOxYxBXjxsUPPwuf/2lpcQPfiYOtvjK3w7ERrRPgRKMMgMlGE0CXS+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,327,1654531200"; 
   d="scan'208";a="216867412"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 16:21:10 +0800
IronPort-SDR: I7UHmAF3TULBRMkxXUW6VXc0b2UYuJVeHPKH0eoBB3hjunrhjhplTRSrS/3h5/0QtM5ST6HuhJ
 2crA75jHLjs3JURr39wVyibRnDaxeU2+dhp29dJQIp3PIoKGMJennyCZ0UMVYI9jRcocw7SbdG
 2t2xlaBHos+PAMEzykV/Ykv6KDF9d/bGTb1o0JuQjYCqOBDBFdlNxTb1eMztx6ZNiYncyD5eCQ
 jkpBx9J1m2zFu5YGFl9XAUyBduwd6qOeX6M5dk2DtmChmWOAyiN7lYgORrydpMBV/1IDBBXJes
 8r4ePbjI+FaIHqRzITtsSMgA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 00:41:17 -0700
IronPort-SDR: xRCYHA67KaJSvBH7QQSzYbnz0wjqMhBvJKf6dX2OTIR5e7MBcQotLJTJ8N3842nEt47CTovFJF
 FLscJwsyIPwulocuS9znhSLKFa8b9JDXNiaTf+GvplKz8S1FXFJv9Egr9O6jlN5fTVKy01/Z+E
 p+6pBdX8mG2fvhWwM0foZJRp+zbypomv/aYfx3Mtquv+TjYl1gFCocQTqIxybSQSryGFxnr1cW
 VM3HI6vu5hiLjeiE9xttXyDWsm3dKtVoby5NxP/foE1omcw1WXWNnnpG8sgd6Y06aYcdY97IeI
 Mqk=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2022 01:21:08 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH] scsi: ufs: Remove redundant function definitions from ufshcd.h
Date:   Mon, 19 Sep 2022 11:21:04 +0300
Message-Id: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes Query-Request API functions declaration from
from include/ufs/ufshcd.h. Those declarations belongs solely to
ufs core privet header.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd-priv.h |  5 +++++
 include/ufs/ufshcd.h           | 19 +------------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d00dba1..f68ca33 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -42,6 +42,11 @@ static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
 static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
 #endif
 
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
+				  enum query_opcode opcode,
+				  enum desc_idn idn, u8 index,
+				  u8 selector,
+				  u8 *desc_buf, int *buf_len);
 int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 24c97e0..3647a71 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1176,24 +1176,7 @@ static inline int ufshcd_disable_host_tx_lcc(struct ufs_hba *hba)
 }
 
 /* Expose Query-Request API */
-int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
-				  enum query_opcode opcode,
-				  enum desc_idn idn, u8 index,
-				  u8 selector,
-				  u8 *desc_buf, int *buf_len);
-int ufshcd_read_desc_param(struct ufs_hba *hba,
-			   enum desc_idn desc_id,
-			   int desc_index,
-			   u8 param_offset,
-			   u8 *param_read_buf,
-			   u8 param_size);
-int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
-			    enum attr_idn idn, u8 index, u8 selector,
-			    u32 *attr_val);
-int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
-		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
-int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-	enum flag_idn idn, u8 index, bool *flag_res);
+
 
 void ufshcd_auto_hibern8_enable(struct ufs_hba *hba);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
-- 
2.7.4

