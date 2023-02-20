Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF869CB47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBTMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBTMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:47:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AFB26B2;
        Mon, 20 Feb 2023 04:47:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id na9-20020a17090b4c0900b0023058bbd7b2so1230130pjb.0;
        Mon, 20 Feb 2023 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlp+7fpFeHOdwpiHv1PnpGgqFl6+DvO/A7P2r7Vg5wM=;
        b=QoISZtRP4onmfzFkfiaiO7B+QT812k/qnfrliIUXk39vKRNo9ze4QQK0fYIEgH9ZU+
         wfPIzRScwTjHzzD53D9lv5KhOj9jihX3stcwDC2bGPVmdWYxi9r+fU5mfEZJudRB0M2J
         hLgcS5krMndUoK8FwiyfdV8VIOqKs1INYgdo8thZWwBka8f7TTSKg6RuYTIkXFXrT9xy
         qH/ZoDewxwUn0iy8gLhNnLV1da7ZNNTehIlmLtDZjwIHFW2/h+3aks4iuQAQlvTyNQrX
         UK/7MAd35sCrq80X7V9pJ+rpAku5dfZTH5MzSDnQe5seVoQi3XvSc/w2FjmbQP63oHN7
         W1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rlp+7fpFeHOdwpiHv1PnpGgqFl6+DvO/A7P2r7Vg5wM=;
        b=hVASyrIBDQItJ3cCpSad50nIjs9eX6/N35oIaq75MkBNRUd8TsN5bwmJJ3QZFtNnhj
         BNpx1DXgrR04fXBEMAL0w/eSMhLSXWFe2ppqd88MTmnjmuZGxlsn+GTqVRLz1LNJwno/
         sEVJs+OdJZNMLt8C0drlIHBaD58IFVrwC/+fyEmaH+87rkEkH+fV2b/9GuDomTyLEvEG
         riszO2VNUpXn5PUGac74StrW+eSVnc/VbZ7V95maINltuDpA8AqV4CUE5Rnw4jqa7tlo
         3qV5T9E+v1WOUl4S5H56EpGnOpIhnir/of6K7tZrNWV6q6gxuqgJl2xrm3Nfi55ymZqy
         T/8A==
X-Gm-Message-State: AO0yUKW27xbfw8twFZ2L6KPsP1J+qrPWfPlplsRbP60fRAvxcNjp0QrK
        taLe5eURW8Mhiym5LcUd4IPXmNRwZQ4=
X-Google-Smtp-Source: AK7set+sSj37syg4zbIanE+y2AbEfxkvnB8SWLgQJugSFotEyx8FSQ3SmJJ5HKerLxFAf86hB/BeOA==
X-Received: by 2002:a17:90b:3e86:b0:230:b53a:fa13 with SMTP id rj6-20020a17090b3e8600b00230b53afa13mr2737401pjb.44.1676897251810;
        Mon, 20 Feb 2023 04:47:31 -0800 (PST)
Received: from debian.me (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090ad49000b00234e6d2de3dsm1093078pju.11.2023.02.20.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:47:31 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E72611048BF; Mon, 20 Feb 2023 19:47:25 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] debugfs: drop inline constant formatting for ERR_PTR(-ERROR)
Date:   Mon, 20 Feb 2023 19:47:21 +0700
Message-Id: <20230220124721.11657-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=bagasdotme@gmail.com; h=from:subject; bh=OrnQooVxHrB/Bbw1qFZhqZCTvcpat2soHW4Jfe/P2JQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMmfsy8tu7e3J+ih0OJPc0+7yH5ScT1XfFYzM0ipqTP7In/Y Wu/3HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIsyvD/xwTTdHjRzj9thyU0lkfb3 RnSsjOz9P2f5iUKC244OnGIxyMDFMCNP0fq81VS3//7EaOCcOP7tvP286mGB9i19f3DHs7mR0A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warning when merging driver-core tree
for linux-next:

Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WARNING: Inline literal start-string without end-string.

The warning is due to inline constant formatting (``%CONST``) doesn't play
nice with complex-name constants like ERR_PTR(-ERROR).

Drop the formatting for that constant above to be consistent with similar
error constants and also to fix the above warning.

Link: https://lore.kernel.org/lkml/20230220163133.481e43d8@canb.auug.org.au/
Fixes: d3002468cb5d5d ("debugfs: update comment of debugfs_rename()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 58a35afb7c5d89..a7a6a0821605a8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -802,7 +802,7 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * exist for rename to succeed.
  *
  * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
+ * reflect renaming) if it succeeds. If an error occurs, ERR_PTR(-ERROR)
  * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be

base-commit: 9f467f6375afd3c7667dbabcfff35c22961e1c0b
-- 
An old man doll... just what I always wanted! - Clara

