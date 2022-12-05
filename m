Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A56421DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLED2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLED2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:28:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488811C12;
        Sun,  4 Dec 2022 19:28:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so9643208plb.2;
        Sun, 04 Dec 2022 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aGo+i+m8PTeYib6ibdrGol3xYgP8haNnxpagY93JFI=;
        b=oXj9sWla4hcdB3GxJLMX2GYwUjM4tF1N6Xx5MLA6rX2SpNKf4tPhsTxYuKwx94gpAr
         xJciS7DcVxowNJ6tmlByARznFsdZ+I/2s8WofaMsiHeRVcluC9nGOItXbJHOBPi9Zd8E
         qC3gmEgiEmnYTnX3VR1vlMiiSSxVgC2PZRROKvvsKG9YuyvcX9opNxOQ8bbb3BQ1EHIl
         BysxjWcDLofkJrnAnMAMSuFH6/huvC3+nsCsK6Miw6R53GFAWCconFcwCsA2ofpCe0Qx
         YVcYqj9Y4qGplWCXw/36aD2aww68ps/StEhIQIjPnPCzmmTjiuhZd/kw3tXnlUlO+V9y
         xK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aGo+i+m8PTeYib6ibdrGol3xYgP8haNnxpagY93JFI=;
        b=176ARWpCLGCLutOSKK6sOoZz9pGgxLg9hHln7PBnZ3uS1C7Sg7CsElVT6s8NJIFLds
         cYr2mbRzQW7QHuoccQP23qBNa9ONQ971ZxSJJ+N15fFpfde5BgCxnt3lhrLheDHcnGsd
         4CX0PGS1FcQ4EYQ5msGQRBWzy2RfbrT3qS2liLmysam4CY8cy79JboReYJMcw2yKCzpg
         EdcKkyb8QmmzciXVR/Eo3o7lEDp+MKlp1u5BTMaf5i7t8EdojUH+b+5c4u7IoyOxcYqL
         4GJic57LTbNHLW+gYLVATMUyrjwLUS2XSi/lqy0pW2Te8BCWGdM525i13//BHzpowaDe
         DC+Q==
X-Gm-Message-State: ANoB5pnQXvcyf2mHybOuPMrGoODaLmYNJYtX/1yYB7yUr8p/w1kzH3uM
        maHWbV/v4SkYpcCfGAXcLGv36qdc9aE=
X-Google-Smtp-Source: AA0mqf4qHzOs01i/Bu1BPuVRLd86r0KM92oqcvKdh3zmJEA7hYvhOC3kC99Pkt5F7lar5pGmxKQWwg==
X-Received: by 2002:a17:902:9890:b0:189:9301:9c1d with SMTP id s16-20020a170902989000b0018993019c1dmr31564252plp.28.1670210925064;
        Sun, 04 Dec 2022 19:28:45 -0800 (PST)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0017a032d7ae4sm9358803pls.104.2022.12.04.19.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 19:28:44 -0800 (PST)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/zh_CN: Fix '.. only::' directive's expression
Date:   Mon,  5 Dec 2022 12:26:24 +0900
Message-Id: <20221205032622.8697-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit febe6c2f859e ("docs/zh_CN: Add translation
zh_CN/doc-guide/index.rst") translated ".. only::" directive too much.
Use the one as found in the original doc-guide/index.rst.

Fixes: febe6c2f859e ("docs/zh_CN: Add translation zh_CN/doc-guide/index.rst")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Wu XiangCheng <bobwxc@email.cn>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Alex Shi <alexs@kernel.org>
---
Hi,

I came across this error while grepping ".. only::" under Documentation/.

        Thanks, Akira
---
 Documentation/translations/zh_CN/doc-guide/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
index 5151953c196f..78c2e9a1697f 100644
--- a/Documentation/translations/zh_CN/doc-guide/index.rst
+++ b/Documentation/translations/zh_CN/doc-guide/index.rst
@@ -19,7 +19,7 @@
    contributing
    maintainer-profile
 
-.. only::  子项目与HTML
+.. only::  subproject and html
 
    目录
    ====

base-commit: f8e9e32f7d04336666d66893f2da1347dd8263b1
-- 
2.25.1

