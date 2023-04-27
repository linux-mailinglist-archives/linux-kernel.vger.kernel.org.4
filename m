Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9016F03FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbjD0KNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbjD0KNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:13:14 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24592;
        Thu, 27 Apr 2023 03:13:13 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so38227155e9.1;
        Thu, 27 Apr 2023 03:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590392; x=1685182392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNNjiSHfVRruw15xW6omPfyhEqYHKH/kULEDX2tDZsQ=;
        b=f4IP2tOYvGDnS0Da4vpBB6t/kiwasxkka/o1ryupst73Dgx1JKZFNhWQvM1CFIysNq
         Ty8c5I0CN2kttKr7CErviY2L0hi5izMBlHeuESgCWWRbGJCMYE8SPwQLhlFw1ACSeLZy
         IALETImbvg2pIgdkRWOQqDZcr1BwtDAs+YzrT/reZRL6apTHq9Rxree7pa5WeVRS//LO
         SmqlBFiyaPbJQAa45k+S8ceNivqICqVCM4TzyfYc+0bRHKUvQaAQ6roJ5pOPAVzCUE8W
         jAak5kFW0ehSPb9Q89kVaNAcuh1R5z7VwY6RCiCPzSnFRfNao8+KQ0wuJvKv28RHVCYj
         SOCQ==
X-Gm-Message-State: AC+VfDxCimmwlxUEtEX7EOXZCkZ3nw0QhEb6e4mBvYd/gP3ujStHjlc5
        UwC/n0n2zOhs82GrAFldKNQ=
X-Google-Smtp-Source: ACHHUZ7aIJa5N0WpdlvrNTYsuiwwMvEobcFK1OeJOgnFINS3HviYYEdF0vVuLl48hyF+XtpJnZ2fSw==
X-Received: by 2002:a7b:c8d9:0:b0:3f1:94fe:65e0 with SMTP id f25-20020a7bc8d9000000b003f194fe65e0mr1073788wml.26.1682590391144;
        Thu, 27 Apr 2023 03:13:11 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c215300b003ee20b4b2dasm20825920wml.46.2023.04.27.03.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:13:10 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: redirect from old arch to the new one
Date:   Thu, 27 Apr 2023 13:12:39 +0300
Message-Id: <20230427101241.1273752-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a recent reorganization of 'CPU Architectures', the links to
the documentation from external resources were rendered invalid.
This is a common challenge when attempting to make changes
while maintaining backward compatibility. To address this issue,
a commit has been made which uses sphinx extension to seamlessly
redirect users from the old location of the page to the new one.


Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/conf.py                 | 8 +++++++-
 Documentation/sphinx/requirements.txt | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 37314afd1ac8..514bfe6a8166 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -55,7 +55,13 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat',
+              'sphinx_reredirects',
+]
+
+redirects = {
+     "arch.html": "arch/index.html",
+}
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..0b067e985edb 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+sphinx_reredirects
-- 
2.40.0

