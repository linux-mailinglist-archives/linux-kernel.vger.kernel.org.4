Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39D2705342
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjEPQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjEPQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:09:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FCD041
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:08:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCae029111;
        Tue, 16 May 2023 11:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0NeDmDYR5mVb0sXj7lokIcwNiD3MIiyy9ewxIBZOeUo=;
 b=CJG1X+oA5jqftgZprA6nxVBqXiq705NNaF8esSbWzKVvFCWmmCRSi2yJ6jXAXuaSuG7Q
 CQ6yxGY8E2rhhrZp9fcultqAtUpZAF3Y/lPPfI3Nanf/LCO+RoUgqoMcIRy0amcLxejU
 lko6q+1DorRCyCSlPnZj3cqV7OQK/3NkuriX/XyzRHOzT+wKlqS6ptaPgFYHVddqZXRD
 /jVsoy/JfwNRfjUXklyM0y+6e5jpE5QDxeT4aHG1aZ+1IqOFmCEctk+K03C3DnATvLsC
 /pLc8cPN2FzTAPQQtUs9mLTnpgPpI52+J0Txrx2lKHITUHJhr56nhEcWFYyG4n2/xLKM IQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvnvm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:58 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 11:07:56 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 62E7FB38;
        Tue, 16 May 2023 16:07:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/5] debugfs: Remove kerneldoc that says debugfs_create_str() returns a value
Date:   Tue, 16 May 2023 17:07:50 +0100
Message-ID: <20230516160753.32317-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516160753.32317-1-rf@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: krTL3GHzXkYZlwi_we7-r2_1SiwQ9IqS
X-Proofpoint-ORIG-GUID: krTL3GHzXkYZlwi_we7-r2_1SiwQ9IqS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the lines of kerneldoc that say debugfs_create_str() returns a
struct dentry *. The function does not return a value.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 fs/debugfs/file.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 2c085ab4e800..0c039a3d9a42 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -943,15 +943,6 @@ static const struct file_operations fops_str_wo = {
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
- * be returned.
  */
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value)
-- 
2.30.2

