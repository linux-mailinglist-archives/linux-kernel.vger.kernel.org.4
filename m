Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA78F5FDEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJMR3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJMR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:29:28 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BECC4596;
        Thu, 13 Oct 2022 10:29:27 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        by ms.lwn.net (Postfix) with ESMTPA id 39824FFC;
        Thu, 13 Oct 2022 17:29:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 39824FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665682167; bh=yEUeV9l6CZglnt5o/00jB7iEk3jA2YvcWBl1vs8MpVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQ/76cfqeiWt+/ntl+wRPAg76DOboVoSmkyfaVY10hUMrwYTj4zz6YzH7pc1f1G79
         6mxKHNb9ZnWKg8RlniJqOkNonY2Knvf65DYz7mFa8Wgw+XKOUO0q6+T/e7juPdtr3h
         OgI/ezspfV4xdzlgGI3BnNBCWCYhqA1ff+EQRvWYyJD/lBOL6vxm4Tah57qlgI0RLX
         IyRpSm+8xzlAv9sxEePE2/9YzB/tRQqopR6WDA9rV0LOM2YwW2Qwvb2kfyAFtZsKhY
         3qOe/zVIJZBkFA4fQSFmZQyAdPrXZsy7CLPZU3kG+32gXAQXFhwVJIweznzryQd7Yw
         ZkDvuZrK/VcTw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] docs: update sphinx.rst to reflect the default theme change
Date:   Thu, 13 Oct 2022 11:29:15 -0600
Message-Id: <20221013172918.846856-4-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013172918.846856-1-corbet@lwn.net>
References: <20221013172918.846856-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't default to Read The Docs anymore; update the docs to match.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index c708cec889af..23edb427e76f 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -147,11 +147,9 @@ section of ``make help``. The generated documentation is placed in
 format-specific subdirectories under ``Documentation/output``.
 
 To generate documentation, Sphinx (``sphinx-build``) must obviously be
-installed. For prettier HTML output, the Read the Docs Sphinx theme
-(``sphinx_rtd_theme``) is used if available. For PDF output you'll also need
-``XeLaTeX`` and ``convert(1)`` from ImageMagick
-(https://www.imagemagick.org).\ [#ink]_
-All of these are widely available and packaged in distributions.
+installed.  For PDF output you'll also need ``XeLaTeX`` and ``convert(1)``
+from ImageMagick (https://www.imagemagick.org).\ [#ink]_ All of these are
+widely available and packaged in distributions.
 
 To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
 variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
@@ -160,12 +158,8 @@ output.
 It is also possible to pass an extra DOCS_CSS overlay file, in order to customize
 the html layout, by using the ``DOCS_CSS`` make variable.
 
-By default, the build will try to use the Read the Docs sphinx theme:
-
-    https://github.com/readthedocs/sphinx_rtd_theme
-
-If the theme is not available, it will fall-back to the classic one.
-
+By default, the "Alabaster" theme is used to build the HTML documentation;
+this theme is bundled with Sphinx and need not be installed separately.
 The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
 
 There is another make variable ``SPHINXDIRS``, which is useful when test
-- 
2.37.2

