Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17958618D46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKDAis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKDAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:38:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDB1F9DA;
        Thu,  3 Nov 2022 17:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7/VDsmcUfW64igp3tr4bheqcBK30NchUj2FJa4I48w8=; b=as8dmT+6yUgYIooJWAeqrZR5wj
        p5EUlEz1SZEXRT/7vXxEZ8N8OtaSR5sbGQ8GLduey2Q1dBWQpwtkukL4eVWzinjuRI0iN5PTEfmwo
        /baWu/xE93wWGZaQvGqgtjGC0dDfO+uk5ZsGqrimb+27+LG2FFmKSCcIauHMDRKmetHjnz6CtpcIU
        8Y6FMqoZQxKuDsWROEEWaaOGRskPoiT2WbjlVx6SRJEjkPVeuVOUWc4fwreaz0lI9MYJ9gtdRx1+K
        OmYZJNeB3HrnxE4czmaEyj0X5HdYjZaosHnnr/ML57HcuAx2ZKVSEiz55MpyDBFPiCrc7sIWT6sCA
        YI5eXc3Q==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqkjN-006vdD-9E; Fri, 04 Nov 2022 00:38:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] debugfs: small Documentation cleaning
Date:   Thu,  3 Nov 2022 17:38:35 -0700
Message-Id: <20221104003835.29472-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
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

Fix punctuation in a parenthetical phrase.
Add 2 article adjectives and change one from "an" to "a".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 Documentation/filesystems/debugfs.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -155,8 +155,8 @@ any code which does so in the mainline.
 debugfs_create_blob() are read-only.
 
 If you want to dump a block of registers (something that happens quite
-often during development, even if little such code reaches mainline.
-Debugfs offers two functions: one to make a registers-only file, and
+often during development, even if little such code reaches mainline),
+debugfs offers two functions: one to make a registers-only file, and
 another to insert a register block in the middle of another sequential
 file::
 
@@ -183,7 +183,7 @@ The "base" argument may be 0, but you ma
 using __stringify, and a number of register names (macros) are actually
 byte offsets over a base for the register block.
 
-If you want to dump an u32 array in debugfs, you can create file with::
+If you want to dump a u32 array in debugfs, you can create a file with::
 
     struct debugfs_u32_array {
 	u32 *array;
@@ -197,7 +197,7 @@ If you want to dump an u32 array in debu
 The "array" argument wraps a pointer to the array's data and the number
 of its elements. Note: Once array is created its size can not be changed.
 
-There is a helper function to create device related seq_file::
+There is a helper function to create a device-related seq_file::
 
    void debugfs_create_devm_seqfile(struct device *dev,
 				const char *name,
