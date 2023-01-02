Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556CF65ADB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 08:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjABHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 02:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 02:23:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9AE4A;
        Sun,  1 Jan 2023 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uZkv46Z2Bqul59SdbhSz2/0kEiRL342ph/AKAU95GtQ=; b=ejVdKsdmRXa0S1PM+BSiBL1+G6
        Byu9a2nWdrSFKmSUZy4zFSwoknPjjH9BEDLtNzXElNS/p69cB+wONw2m6SEhNp2wQo+LH5e/9tz0e
        yJUJ38FVa3EdCupexLXILN1bQC49FVfP2nZ8RK6PGiNHwKUzTKL/eTamh8LNVIjnZ2xOobz2PaZJf
        7dGpbjIweoqNur9njT8IH+FsX9cjqs1R9WgaTEeC6b8xlEe8OCWfViFa0xJu1YaOrjpjwfLNXXln/
        wtDUpjGbEDHwZsyVn8L3M0aeuUUqWTHddO/nBhShSPuNV9wfAAymgACPzTzY5b2DUNfXgngkT82K9
        ylzy6qdw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCFAj-009Cjs-4J; Mon, 02 Jan 2023 07:23:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH] certs: system_keyring: fix kernel-doc warnings
Date:   Sun,  1 Jan 2023 23:23:48 -0800
Message-Id: <20230102072348.26425-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 kernel-doc warnings:

certs/system_keyring.c:45: warning: expecting prototype for restrict_link_to_builtin_trusted(). Prototype was for restrict_link_by_builtin_trusted() instead
certs/system_keyring.c:79: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Allocate a struct key_restriction for the "builtin and secondary trust"

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: keyrings@vger.kernel.org
---
 certs/system_keyring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/certs/system_keyring.c b/certs/system_keyring.c
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -33,7 +33,7 @@ extern __initconst const unsigned long s
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
@@ -75,7 +75,7 @@ int restrict_link_by_builtin_and_seconda
 					  secondary_trusted_keys);
 }
 
-/**
+/*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
