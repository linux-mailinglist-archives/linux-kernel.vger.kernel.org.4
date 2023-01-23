Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884416789FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAWVxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:53:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBBD30B19;
        Mon, 23 Jan 2023 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JFC3UPEu1ezEy0l8JdNPemkkpO3xtgjSFVWDfLbQfJ8=; b=MBR3za1n6Rih4M3GbDca5HK2Jl
        sI8heeIIMUW5zxjhFuFk1QGhm6g1eQrFhSwwI5TG5EvL7y32nBDPOntYZWGTrGvXui+hK+555iWlH
        VUaxZ+jOhOfroeVOkPFLE+4GC71KYJrel4+qGWMHDowVzjP/4ZRaZDSosoC48Cx5C6P3F9okTqvTQ
        bgwEv9kG6G8NIB/eA6q3YYW45CqUTvFhG8U/45fTGv4vwCWJfBBkGITtvQ9FK+uok3w5d0QnB01cH
        EagrFqS/g3SPKHclp74ZcQ797fggvdar6ParkN8X5AUUHE1ZRLbasfOQtJWu0hugy4FHCg3xBXxyD
        PiMOwR/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK4kK-001bDK-FF; Mon, 23 Jan 2023 21:52:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org
Cc:     a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        mcgrof@kernel.org, ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: [PATCH v2] docs: embargoed-hardware-issues: add embargoed HW contact for Samsung
Date:   Mon, 23 Jan 2023 13:52:55 -0800
Message-Id: <20230123215255.381312-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After discussions internally at the company, Javier has been volunteered
and is willing to be the embargoed hardware contact for Samsung.

Cc: Javier González <javier.gonz@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof.c@samsung.com>
---

This v2 uses tabs as requested by Greg.

 Documentation/process/embargoed-hardware-issues.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index b6b4481e2474..fbb754253cf7 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Samsung       Javier González <javier.gonz@samsung.com>
 
   Microsoft	James Morris <jamorris@linux.microsoft.com>
   VMware
-- 
2.35.1

