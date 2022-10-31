Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C97613B46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiJaQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiJaQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:26:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FD1276B;
        Mon, 31 Oct 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667233562; x=1698769562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tcPZBpWAoPb3fJeuZ0FofoSwD+Q2agXunSV1QbOjiq0=;
  b=PMZ+rghl0cNOpjfRbB/EHFxT9FsSETEdiueMcm8ypvKIM3UKlMWPA6hO
   8UooUE1+wFaqBzryMKdxDcpIVxw/jgKA4Jbc2p98+8hrEES60g2VZSD3t
   aNwhxZdmbvtqqDUGgBmtPF1Os5MyooCC43RTzuX6YBmbwKhTk+6dT2Pcb
   zHIQAfEpDVzBgWCxFVO7j43hUAPA80fBY9bHQVrJBPiS5oC/tzOaEJsUp
   JX27GcLcLwy6zCDKouU23/B9bQwr2QK6J9xQDlbcJ2vvfRS0ATxdpo/8+
   onFtDlUQ7oc69NhEymMw8+cvgia+m6Vnx23JZGQpmO44Po/fT2oSwzBwm
   A==;
X-IronPort-AV: E=Sophos;i="5.95,228,1661788800"; 
   d="scan'208";a="215498921"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2022 00:26:02 +0800
IronPort-SDR: TBXdjP0WM5mXHs9DFZaDwUQjGuflEsM33iAam/9OYI2QpUCKGAznddviDYDwPDNTyRXveXMvQA
 Bvnt/GZ4vy8CwkV0UuEvrSu+xYpyK2ollFWDGZU0gGT6foqkXSzVTuklSrFDV3LjGjKbMViVzq
 xkcL1YitZxooTCEJM9+Pa9ttZFj/hPoswBITSBhOuhdpf7jC4DAxUhf1n7lgS8xjHWgGbYJAiw
 EDQagRvnS9Vb1rxmNrOjS7ds22KeXJqMmwPIlmPrlrZwX4iWccqe/LvjoQGb96/23NA0sNhWpz
 jBc0f9o9VHGp3dKHEKtK9OER
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 08:39:34 -0700
IronPort-SDR: 0zaRbmorWNHzQsm8Dl9wwwb9ecVUtMNPO4Pd7F6nZsa3ilzX7PB4qlDaQrG/9v+PK33Cia/ALT
 Z8kLWlu/pqZdAS2QbgYMkAIcx1Obj1/EWrt9pzE0P2bdPecqJdgZy1NaViKsUT/Ap66kK4dNmT
 2FRUwJ/Ibn8Z1tTkM5nQJv/qbZnrsaoaKFZk9+fLRdn6ynLGGUhpNLQ4A6Hkkqg8DQHaORjqEV
 /31Y1uNdji1kTUrsHhT5DQ9QBFuOj/Wqk1vxstbUHSkugqSbtBhWxoiE9LIqmtEX7j79o8QIVm
 wJs=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2022 09:26:00 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Mon, 31 Oct 2022 18:25:23 +0200
Message-Id: <1667233524-13715-4-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index aa46292..9cc3abd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7386,7 +7386,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-						const u8 *desc_buf, int len)
+						const u8 *desc_buf)
 {
 	u32 icc_level = 0;
 
@@ -7444,8 +7444,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

