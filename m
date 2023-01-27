Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89C67DDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjA0Glz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjA0GkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E446BBE8;
        Thu, 26 Jan 2023 22:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CVbOZ9LQVLayEZWJi1jNIc2kWaiJ4GNkAgdJuKmcsEI=; b=IgIotBxTNPRhE2x0oaO7/0fJLd
        RmQxEv4uTaULwOTK8UmYcSkZbZsZphgUhS10FoHGSRCa6oW9B4qw6dAqTqPvPFAQ8pFTH51UHLXF0
        yR4eZLm+PqwUEEemvKvvPSLmK5uBDlRGFHkeCg/YLUISS8YVeK7qNWY6X0TZojX91504Fqig0EtTi
        6qK0SaaIHUPv9wYdS3unADMOTjFeWRB4RsTPQcTxakKMKx3vqNyyOJkSQwvYJmLZCqTFNEqY1LCWN
        zz5Rj5xjD3IMjJ9FCdcsN/rRkjKwjPj5i4uNQzZhNXoBAA7rd9cLzFogg/W8Bj49Mh7Mc9h3kjO8g
        tZrM/wvg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPP-00DM0u-4t; Fri, 27 Jan 2023 06:40:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 28/35] Documentation: target: correct spelling
Date:   Thu, 26 Jan 2023 22:39:58 -0800
Message-Id: <20230127064005.1558-29-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/target/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/target/tcmu-design.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/target/tcmu-design.rst b/Documentation/target/tcmu-design.rst
--- a/Documentation/target/tcmu-design.rst
+++ b/Documentation/target/tcmu-design.rst
@@ -171,7 +171,7 @@ When the opcode is CMD, the entry in the
 tcmu_cmd_entry. Userspace finds the SCSI CDB (Command Data Block) via
 tcmu_cmd_entry.req.cdb_off. This is an offset from the start of the
 overall shared memory region, not the entry. The data in/out buffers
-are accessible via tht req.iov[] array. iov_cnt contains the number of
+are accessible via the req.iov[] array. iov_cnt contains the number of
 entries in iov[] needed to describe either the Data-In or Data-Out
 buffers. For bidirectional commands, iov_cnt specifies how many iovec
 entries cover the Data-Out area, and iov_bidi_cnt specifies how many
