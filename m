Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B2606361
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJTOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJTOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:42:25 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E413729F;
        Thu, 20 Oct 2022 07:42:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666276943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xk0Uk+J+pVoMTHPZFbUY4tpbaiEtgAbphQcQ8hSyJIQ=;
        b=S39Khm//T4WQuI6477FAawK+z78sKoNdc1UZDPK7e1q969ZyhllvEDON2G47aumxO22ZUy
        P6cr7ce+t01H9w+U3t5bxfKvPsRfQAZnUYfs6lKmjiiQDnUAXVGR9eRIAQfTBgRQH6CkaI
        K6RwNCyOr+kylX1kqj5iiMFXmYSeJ7VajNhn6WSlb8s0EvFOwVxgQt/ffoSWYUiDbCg2mH
        2J+8AtlNMCbHLgFVWb/yTSYHx9evnR/N43FDOdjmro+oKuQuDs6F3PlheZBKfOIPqCRVav
        eoC+tW9i6ICkraJgXQZkfG6fxk/5x2RaRa1wMAKzVNTV/NVoOX9NrdSMrhgpCQ==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v3 1/2] docs/zh_CN: Add staging/index Chinese translation
Date:   Thu, 20 Oct 2022 22:42:13 +0800
Message-Id: <50ffa90ad6dacc321cedc194d30a029383a737a9.1666275798.git.me@lirui.org>
In-Reply-To: <cover.1666275798.git.me@lirui.org>
References: <cover.1666275798.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following files into Chinese:

- Documentation/staging/index.rst

Add it into the menu of zh_CN/index. Also fix one translation
in the zh_CN/index file.

Signed-off-by: Rui Li <me@lirui.org>
---
No change since v2

Changes since v1:
- Add xz into menu later
---
 Documentation/translations/zh_CN/index.rst    |  8 +++----
 .../translations/zh_CN/staging/index.rst      | 22 +++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/staging/index.rst

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index ec99ef5fe990..3d07b3149afe 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -124,13 +124,13 @@ TODOList:
 其他文档
 --------
 
-有几份未排序的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
+有几份未分类的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
 转换为reStructureText格式，也有可能太旧。
 
-TODOList:
-
-* staging/index
+.. toctree::
+   :maxdepth: 2
 
+   staging/index
 
 索引和表格
 ----------
diff --git a/Documentation/translations/zh_CN/staging/index.rst b/Documentation/translations/zh_CN/staging/index.rst
new file mode 100644
index 000000000000..e26603892a6f
--- /dev/null
+++ b/Documentation/translations/zh_CN/staging/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/staging/index.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+未分类文档
+==========
+
+TODOList:
+
+* crc32
+* lzo
+* remoteproc
+* rpmsg
+* speculation
+* static-keys
+* tee
+* xz
-- 
2.30.2

