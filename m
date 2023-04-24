Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F16ED365
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDXRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjDXRTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:19:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB92196
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:19:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso4032485b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682356739; x=1684948739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a38sU0BVWLQ44397c5Qn/dNcocAQ8ZH17k9el5DRSzA=;
        b=FAysqXWvfxHxpdw5VxbuKVZGy3vrZ+RvptRhxEhXV2MJl3v+wrRwW61C6LWwVOC60n
         peb9q1u7ScStJMIgximwh9Ca3z+YBFEkVoBkDeN/8bUaLlqUH3U5/FEnNBZY6vinLDic
         6Trs3rcEOIDBNejNOk6CFLb7o9NicmDD2aLbSTd/jFi67Mqkr/oZuscdBzVHWmDYq/b6
         NbVw53gXjBoVQlkXQDeTrWOQhEfgNM3wNe9gtVFwy30DIyP8/lo8CefJTyoJX94HN5if
         GdwMX/+dkZsy0OE1jqWckOgGkAwSmBIl89pYQqrBw5byU2wuDg9hNbgEjFoCg3nMKpKO
         XXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356739; x=1684948739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a38sU0BVWLQ44397c5Qn/dNcocAQ8ZH17k9el5DRSzA=;
        b=TkamqfWzEylAd5xujAILGmL8wpTOUs4XqM0W8euuqsPqC3gwzCBgqFVfTTfOSmLLR4
         6jdPL8lWn6UlR42tkf2V0AHLhzpfa+nlv0N3hI/mP/qZncFm/3rb4m1lUZFkqgDhheXK
         ZUVB1J2H71Yl/nq2Hu8vLIKIphcLsSkIVN+0mtrl3BLaZcF7s3qVnnw2zK4yDaInp3Dn
         u73TmQ4ienqFe/+JK0ElgqAseut+gCmlXdAZ1XNoLszx/c8GgZRbBWj3Gx/J1F4JfeUs
         sYZz6+JCP/P6DWA1E4ZV1HpBSaguOlJWPLOdJ/Jb3smDL1W42lTi7tBbAdU8dbgEAw5k
         c/AA==
X-Gm-Message-State: AAQBX9dmIV3+6fgzCNwVVG7mYiU3EthI8rPLdATN96mVGAFS/bacU4z7
        7Z704wRPuUNa/f2BvUs/RDbDRA==
X-Google-Smtp-Source: AKy350ZSafi65mIsC48pRVJ2RG+WH9jsRqiNEMuLHqe4lXLIlF8X4WXv8fO55smHDKDAU3EupyJc0g==
X-Received: by 2002:a05:6a00:1a01:b0:63b:89ba:fc9c with SMTP id g1-20020a056a001a0100b0063b89bafc9cmr18613973pfv.27.1682356739560;
        Mon, 24 Apr 2023 10:18:59 -0700 (PDT)
Received: from carnotaurus.. (c-73-252-184-87.hsd1.ca.comcast.net. [73.252.184.87])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b0063b7b811ce8sm7620177pff.205.2023.04.24.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:18:59 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH linux-doc v3] docs/doc-guide: Clarify how to write tables
Date:   Mon, 24 Apr 2023 10:18:50 -0700
Message-Id: <20230424171850.3612317-1-joe@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this commit, the kernel docs writing guide spent over a page
describing exactly how *not* to write tables into the kernel docs,
without providing a example about the desired format.

This patch provides a positive example first in the guide so that it's
harder to miss, then leaves the existing less desirable approach below
for contributors to follow if they have some stronger justification for
why to use that approach.

Signed-off-by: Joe Stringer <joe@isovalent.com>
---
v3: Fix grammar mistake
v2: Simplify recommendation for either simple or grid table syntax
    Remove example, link to rST user reference
---
 Documentation/doc-guide/sphinx.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 23edb427e76f..cd8ad7904491 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -313,9 +313,18 @@ the documentation build system will automatically turn a reference to
 function name exists.  If you see ``c:func:`` use in a kernel document,
 please feel free to remove it.
 
+Tables
+------
+
+ReStructuredText provides several options for table syntax. Kernel style for
+tables is to prefer *simple table* syntax or *grid table* syntax. See the
+`reStructuredText user reference for table syntax`_ for more details.
+
+.. _reStructuredText user reference for table syntax:
+   https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables
 
 list tables
------------
+~~~~~~~~~~~
 
 The list-table formats can be useful for tables that are not easily laid
 out in the usual Sphinx ASCII-art formats.  These formats are nearly
-- 
2.34.1

