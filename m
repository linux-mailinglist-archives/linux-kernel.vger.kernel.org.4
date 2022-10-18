Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5160234A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJREb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJREbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:31:51 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708D9E699;
        Mon, 17 Oct 2022 21:31:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666067502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNkLTBWKRr7ziif44CMcG6Xt4lqWvNg9BJRnMLOqhd4=;
        b=GSR9WTdB8V9lVJT32TYzyhovcSvogvH75l65aoQEdnX7f6pqQElGCgmycFT9HAoD77LSqS
        PGHrctomMWt0Qc3uVXCTaJJUz1QinCp/JQoJNGcGgGmpWHosGcfgrpWCPVZ00AtvAfY7fk
        uXqICng4smRy76VVSzpgL7yikhm0qpFOjInX7FQ5GUM6jCO3lKeCC6i5Igizo3ms0fiCX0
        U3lStPmQR/hHGjmGp/8RLLGN/+pYwB83C7PmoRJ79GwBfSvxC6cFeCIvqwieQSkx5zu9Ie
        u16Iwuzf0nhTgINzKOw4TD61sArzeu0iEun0tubJOeMK5auU2bXCEV44EMMkrQ==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH 2/2] docs/zh_CN: Add staging/index Chinese translation
Date:   Tue, 18 Oct 2022 12:31:06 +0800
Message-Id: <4ef47cfc6c85ad9c778af1f13761e8dd8e410ee8.1666067195.git.me@lirui.org>
In-Reply-To: <cover.1666067195.git.me@lirui.org>
References: <cover.1666067195.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/translations/zh_CN/index.rst    |  8 +++---
 .../translations/zh_CN/staging/index.rst      | 27 +++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
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
index 000000000000..7d074b34ac97
--- /dev/null
+++ b/Documentation/translations/zh_CN/staging/index.rst
@@ -0,0 +1,27 @@
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
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   xz
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

