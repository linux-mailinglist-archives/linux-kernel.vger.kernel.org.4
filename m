Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFE5F4A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJDUMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJDUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:12:37 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823E25EB6;
        Tue,  4 Oct 2022 13:12:36 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 63886385;
        Tue,  4 Oct 2022 20:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 63886385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664914356; bh=HMKtofhzkC0BbHU/AlRiFnMQhJNC5T93PGks81TP6Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0kXIj2yzH2+v28tH5gVYRUd/Sv+6Ui0NsS1sljjsm63BD8uTBNcSz8gBDlRk/Cnb
         bEvdmdUsuvikFO+WEl1hvunxECwT/DJUmkDlOY0qS4gQj9ZDQXWogZWKADSKwd4WaL
         aiGzKUbupO5l0T1/nQLSkXZTkpka+COuyp2527hcgIZKRq9++e9y3+zYRp180i+k8t
         TiY7FOs1YF+SlwRFAbaAaLIghZT5+9LU6qqmy/0Xwt0SxahDH446tz2kooNGS1Pkdh
         3N3neTzpv/tgJTCkxLD4NACY9sOX60SirXNMhF/g7qzXYpTqcF0elccgCCrY/3UvYv
         vi4m+oqH5G0Ng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/5] docs: update sphinx.rst to reflect the default theme change
Date:   Tue,  4 Oct 2022 14:12:20 -0600
Message-Id: <20221004201222.281845-4-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221004201222.281845-1-corbet@lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
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

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 1228b85f6f77..d71e0beb11f3 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -130,11 +130,9 @@ section of ``make help``. The generated documentation is placed in
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
@@ -143,12 +141,8 @@ output.
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

