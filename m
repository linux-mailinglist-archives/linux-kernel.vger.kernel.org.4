Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4495B6972F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBOA5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBOA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:57:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8E2BEE3;
        Tue, 14 Feb 2023 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PPu6OIyOMqF/ZcmFoHtDoinYfQ4Lxp1RRxh5EWluloQ=; b=EAOEZi3/xDvaWrd4Q5sRqNuI/m
        UqQr/xJPQyoX9lZub4J29jyxuzP8xqBMhvXLSoqbkZIT2+hWDK+BTPgoAJYfuzuLEZZqbCjjnS0Qv
        LL+cHNo3RUCLJclC78Tgn+/iVIKbjmOE5VlDcvlUbZRlGvLYe7MHPXdjHJ4hqUf7tOZWkEtYbS0M/
        ZbWReOC6FaGl/889SZAlJ2wJ1I7OwykMPIeozEvxtKvVfCVGwKOyLf24nNxt4Ek9IJkcfeGnFSqGf
        2uIWqSqpf8/9ds7L66WhxTxcqV6ufzwcY5aNqrhG199BTNZAWZhU+mPXEZDzlfeaOAaNR+6YBFjlD
        WrO0xP+g==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS66y-0046wd-8E; Wed, 15 Feb 2023 00:57:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] Documentation: front page: use recommended heading adornments
Date:   Tue, 14 Feb 2023 16:57:26 -0800
Message-Id: <20230215005726.27320-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Documentation front page to use the heading adornments
that are documented in doc-guide/sphinx.rst for document title and
chapters. I.e., convert most section headings to chapters.

This leaves "Indices and tables" as a chapter entry at the same level
as the other chapters.

The only visual difference from before to after is that the "Indices
and tables" heading is smaller and has more vertical whitespace
preceding it (although that may depend on the web browser being used).

Fixes: 0c7b4366f1ab ("docs: Rewrite the front page")
Fixes: bffac837f3a3 ("docs-rst: convert sh book to ReST")
Fixes: 8e2a46a40fa7 ("docs: move remaining stuff under Documentation/*.txt to Documentation/staging")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/index.rst |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff -- a/Documentation/index.rst b/Documentation/index.rst
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -2,6 +2,7 @@
 
 .. _linux_doc:
 
+==============================
 The Linux Kernel documentation
 ==============================
 
@@ -13,7 +14,7 @@ documentation are welcome; join the linu
 you want to help out.
 
 Working with the development community
---------------------------------------
+======================================
 
 The essential guides for interacting with the kernel's development
 community and getting your work upstream.
@@ -29,7 +30,7 @@ community and getting your work upstream
 
 
 Internal API manuals
---------------------
+====================
 
 Manuals for use by developers working to interface with the rest of the
 kernel.
@@ -43,7 +44,7 @@ kernel.
    Locking in the kernel <locking/index>
 
 Development tools and processes
--------------------------------
+===============================
 
 Various other manuals with useful information for all kernel developers.
 
@@ -62,7 +63,7 @@ Various other manuals with useful inform
 
 
 User-oriented documentation
----------------------------
+===========================
 
 The following manuals are written for *users* of the kernel — those who are
 trying to get it to work optimally on a given system and application
@@ -81,7 +82,7 @@ See also: the `Linux man pages <https://
 which are kept separately from the kernel's own documentation.
 
 Firmware-related documentation
-------------------------------
+==============================
 The following holds information on the kernel's expectations regarding the
 platform firmwares.
 
@@ -93,7 +94,7 @@ platform firmwares.
 
 
 Architecture-specific documentation
------------------------------------
+===================================
 
 .. toctree::
    :maxdepth: 2
@@ -102,7 +103,7 @@ Architecture-specific documentation
 
 
 Other documentation
--------------------
+===================
 
 There are several unsorted documents that don't seem to fit on other parts
 of the documentation body, or may require some adjustments and/or conversion
@@ -115,7 +116,7 @@ to ReStructured Text format, or are simp
 
 
 Translations
-------------
+============
 
 .. toctree::
    :maxdepth: 2
