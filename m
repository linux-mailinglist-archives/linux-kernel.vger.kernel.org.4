Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAB667DD90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjA0Gkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjA0GkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED4F6A306;
        Thu, 26 Jan 2023 22:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yfYvQGFmh+rPFmzhzrRsy391DygGY3YM4iFqKwYsxy0=; b=HyINyC8cCsAkg4bjMA4b9rAF+l
        1q9GDPaH5ueIuCyN3NSL1BSY5MHigwBMzTtuPXAxQLylszAsTH2dY9Pp9de8o3i0xbb2K4gVGdap3
        h9iPpHvDgJA5d9Hzx/CxZJfZOiL6nSFL40eqqMVi6WeogX8gV/4QwzfYPhnKH3/etgrXgntJnTYmL
        ZRgnyKByHil6TZTs34SzUWyoIVFxQ8VUfjoQi+424X/unHmupMKLY5tD0lQ0GS7nQBmnaLLMJASk5
        RJiERKMBR9ym6E25gF71dYjnYUOCkRJca02ZJ8nO6/Fop9eZLqxsHrEwLu5mCTJWCldpVm/F18tHl
        u8NRwuiA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPF-00DM0u-9c; Fri, 27 Jan 2023 06:40:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 09/35] Documentation: firmware-guide/acpi: correct spelling
Date:   Thu, 26 Jan 2023 22:39:39 -0800
Message-Id: <20230127064005.1558-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/firmware-guide/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/firmware-guide/acpi/acpi-lid.rst  |    2 +-
 Documentation/firmware-guide/acpi/namespace.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/firmware-guide/acpi/acpi-lid.rst b/Documentation/firmware-guide/acpi/acpi-lid.rst
--- a/Documentation/firmware-guide/acpi/acpi-lid.rst
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -34,7 +34,7 @@ state upon the last _LID evaluation. The
 _LID control method is evaluated during the runtime, the problem is its
 initial returning value. When the AML tables implement this control method
 with cached value, the initial returning value is likely not reliable.
-There are platforms always retun "closed" as initial lid state.
+There are platforms always return "closed" as initial lid state.
 
 Restrictions of the lid state change notifications
 ==================================================
diff -- a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
--- a/Documentation/firmware-guide/acpi/namespace.rst
+++ b/Documentation/firmware-guide/acpi/namespace.rst
@@ -31,7 +31,7 @@ Description Table).  The XSDT always poi
 Description Table) using its first entry, the data within the FADT
 includes various fixed-length entries that describe fixed ACPI features
 of the hardware.  The FADT contains a pointer to the DSDT
-(Differentiated System Descripition Table).  The XSDT also contains
+(Differentiated System Description Table).  The XSDT also contains
 entries pointing to possibly multiple SSDTs (Secondary System
 Description Table).
 
