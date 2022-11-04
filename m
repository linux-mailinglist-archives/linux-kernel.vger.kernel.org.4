Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16561A017
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiKDSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiKDSfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:35:37 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38B4731A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667586928; bh=0B53dwmxeG45YNVJ4Hk+8mn0kfMKjj9deNa9hc7yTfs=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Q2NuLmL/hfSwbeyuFz+iWBAaq68nrgoC1bD2s6wpXsRE64OVFSoLXo1VSpbdtg6ay
         Ol7ViECLDn7J3NnGNkf9essCyBDaGwU4VN3jxtmijoWSmaECaJxjyrLfrVFT5j7/34
         lDLsscIdjFmUNldKQaDsMVH+9QLu6wuLt2HN/aDY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 19:35:28 +0100 (CET)
X-EA-Auth: mgpYO5K4+REdUFPKKUYsnK0F2jW6dgwbxmTkgKC0MXpQOKCap7NNTWay5++oa438urRr3fiiYiRIkOADL6v0DdsQbIFDB4u5
Date:   Sat, 5 Nov 2022 00:05:23 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: Remove unused member variable
Message-ID: <1b22e45254f7b8cafbf5b78d1e02380295b9ab02.1667586648.git.drv@mailo.com>
References: <cover.1667586648.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667586648.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Member variable bBWIqkResultSaved of struct iqk_matrix_regs_setting is
declared but never used. Remove it.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index e16a769850c5..6891fa30c7f4 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -482,7 +482,6 @@ enum odm_type_alna_e { /* tag_ODM_TYPE_ALNA_Definition */
 struct iqk_matrix_regs_setting { /* _IQK_MATRIX_REGS_SETTING */
 	bool bIQKDone;
 	s32 Value[IQK_Matrix_REG_NUM];
-	bool bBWIqkResultSaved[3];
 };

 /* Remove PATHDIV_PARA struct to odm_PathDiv.h */
--
2.34.1



