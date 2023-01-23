Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0530A678511
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjAWSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjAWSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:39:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBB22DC8;
        Mon, 23 Jan 2023 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GYeGWMkYLov4QK4pkK8lvvB+kYPg+vVKNOZaYmrHXbY=; b=hKBjTdmagqddwOXhL9SHigxZJ5
        3Gij3l2SPXkefz85Oh87vkxqVE/l/y03ca8YWVnqdFtP49vRmFv+d2GCUzf/qFDw7mNZxpn5ifRZe
        Il61AJ9blRyUOVoWoVdIU2iV6ehnOeWTiCJNnUlJpbhw1QCMH5edw2xCmfys0wFbakccOvW5vRiQd
        nMyZM7rDnn9WrBUXcZJGD3NNjOqwZqLt5Vi54BPOQipWRWoeRDwCpqCSpVbZFnlP1dF0cwLcxrp2j
        IoFvvRJeZ1R/sFiL3inNcE8cf5c56kc1bMJUHTw2Pf7YILmEJ35x+ue8QT6uqn+TyC6v101nvDpDf
        M5rIfUrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1jC-0012wu-JU; Mon, 23 Jan 2023 18:39:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org
Cc:     a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        mcgrof@kernel.org, ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: [PATCH] docs: embargoed-hardware-issues: add embargoed HW contact for Samsung
Date:   Mon, 23 Jan 2023 10:39:26 -0800
Message-Id: <20230123183926.249601-1-mcgrof@kernel.org>
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

