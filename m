Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7560458E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiJSMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiJSMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:41:18 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EA1BF842;
        Wed, 19 Oct 2022 05:23:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666181577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prsMPQlFUjZf3npQTejTZi81JsFUNaBGuTGmrPp5+r8=;
        b=gHAEleqIr7vWxOqz5mTU72nPgVMFDAUqTsWIO786EAU5VaZyrrSL5kd61VSpwoeaD053eJ
        C6EVYjDpG15t2xVS00ggBZmP6k6tEse83PvIM5ERgWFCc1gWZkiX3k2FJgQnV+8n2espqV
        4JjreL2NgYdOZSju/QF4RfIl/aOb75sy7xxKe9Ie5DDT1PlGcSxxr0eoBNE5T6A2dBqcJP
        W6MRnXsSKoNwbJVtHXkYMyKfbEzaGiGe6s/wMIxlrJdSQGqgaUW1hZ6n14bYNOIx5ionz6
        Ptj7LXWRd77rbYJ8wC9pQSQXOxugxb0FPYLGwxR4gUqs1hKSp1+pb77Z9lC9hw==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v2 1/2] docs/zh_CN: Add staging/index Chinese translation
Date:   Wed, 19 Oct 2022 20:11:56 +0800
Message-Id: <1c72e7c95d0ad2f01e1787f87c49bba2ab3e899c.1666181295.git.me@lirui.org>
In-Reply-To: <cover.1666181295.git.me@lirui.org>
References: <cover.1666181295.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

