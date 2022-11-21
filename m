Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC1632891
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiKUPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiKUPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:52 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50021275C;
        Mon, 21 Nov 2022 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669045604; x=1700581604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ppAPPKacSP3icl+8eBlb8o90BJjl+gGXwgHopEM8L4E=;
  b=nNalnZ+ED7F+24CJGOgO/9GE2cSx8tDl50/nVnh6/5WHFUBn3flsV7/I
   oq2+HrHuQjNwcYlyM+43dQfJkyWsuhpXE/8HnTGuanstsQrMNlv5fZmIr
   uBbXxuI9oVCNmN1wQlF56vy9spuu2/3IroxPDB7TrIqA38xOPqskBJvjm
   Z4o74Jg+pVW/GbRIJubS26sUSYqwqcu1yRSJZVAycw/rv7FKWMKTNP6Qd
   FnPRblDY5IDYFWrbEpfx3ouIc9HEViPHcO8l5c/A1JUo9Y6cKVtvhXLZN
   yWYVOurerPRpyQEJk3AwZ2x/RhpYiqXNRu9XopDzUPnoNukOQ4GCgjY0Z
   A==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="215054346"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 23:46:44 +0800
IronPort-SDR: F79L/rt3muDvXzZxYQSTFGpsbZARSYDp4m4Z7ksEPOEL1JGqUVS5JqyuJHgoHELxMoeYaQZtSA
 5q6yEbLbielUvL0fHEuK1JoAdWHRd4Ft/lNI+HS5GM7KlN+tJ/3P23S+XdmUtKnYZ4JrJByryU
 0AHXr/mv7I6syc7DEaYLBguyPQR0crLdUyY1rXuP3kUg9KsIPDsEXXKtIGZtwno+qJXZoXI68g
 oS8NZxhWS/D0yNa8Auj5c+JdXvXCAq7jgoG+YFau2jqR0ud1l9Y2xa7sMfnvcYPJfu77cYHiRC
 EIg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 06:59:49 -0800
IronPort-SDR: Wt+fqCqmMnTIdvV7BBHcyby2sLYPp5ADWYGOB80fhQSPnpevxHQld477puLcfdsXKCMNqA+GGS
 2CT8w78IZ/AI2z4znk9OnwR6fyhJdGNJgWWCIuziGBLQ6+Wp0SVUFpsiqhNeTqDAkGLLORHeEa
 Abyro7uL9OmZHin7yDS0M+iCNGF1fqPIXPEBDdpu5DhkpeoEEkBwbJ1R1W6WyKu1N6wKS9S4bI
 PalNuaeh+Y1ocZewrd7pR0Sf2shJ3kjAgxrdPWnS0b6k8JP1HW+2pUjIb9I6oXQyRWgzbqvVmn
 wW8=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2022 07:46:43 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v3 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Mon, 21 Nov 2022 17:46:29 +0200
Message-Id: <1669045590-26101-4-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7456aa2..604348f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7391,12 +7391,11 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
  * In case regulators are not initialized we'll return 0
  * @hba: per-adapter instance
  * @desc_buf: power descriptor buffer to extract ICC levels from.
- * @len: length of desc_buff
  *
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-						const u8 *desc_buf, int len)
+						const u8 *desc_buf)
 {
 	u32 icc_level = 0;
 
@@ -7454,8 +7453,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

