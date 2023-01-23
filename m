Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DA1678AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjAWWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:22:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76BEFA1;
        Mon, 23 Jan 2023 14:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q9H134tWI2pNx3pa9snYV6BH92EqQ/eESHJ6jPlWggI=; b=uHVaZoY1KOYcgNeCTmBNBR6O3w
        ziB9fkVUMgWgFGGNyFhRvOWHR3YjYMCIR1bz4JL3CWSd09qx2tSfBxKorwvg9GMxSkJDRmQQYBiL9
        F3vX8zdr0W6YOMSHtxlgPCYP7O7+Wr/aXj4hwgjpfyyNiCH4uUaCH4JN0QZjiL238/2iWpH9XMK0c
        BIxqUh3nWHMJWAW/5pgZ7qSH0n4we1cyr5wBFMZZpvo6WOOeKqM6i7bkIyd9n2U7l7/cs9YkQPpIb
        78XqJTnUgnlyc15HQrVstNOjbLa/k8M4FZZOO2IPZEZrwFDcBfVkrx7aD10MmdcJINgBo5VyCh7DU
        8Hoy1RyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK5Cn-001hWj-Vv; Mon, 23 Jan 2023 22:22:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org
Cc:     a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        mcgrof@kernel.org, ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
Subject: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW contact for Qualcomm
Date:   Mon, 23 Jan 2023 14:22:20 -0800
Message-Id: <20230123222220.405622-1-mcgrof@kernel.org>
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

Emails to tsoni@codeaurora.org bounce from different systems I've used
and LinkedIn tells me he's now at Linaro since 2019. That's a 4 year
gap where embargo stuff goes to /dev/null for Qualcomm if the first
bounce happened in 2019, but I have no way of knowing when that account
was disactivated for sure.

Cc: David Collins <collinsd@codeaurora.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

David, should we apply this for now until you guys figure out a proper contact?

 Documentation/process/embargoed-hardware-issues.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index fbb754253cf7..bf06e0d45776 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -250,7 +250,6 @@ an involved disclosed party. The current ambassadors list:
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
-  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
   Samsung       Javier González <javier.gonz@samsung.com>
 
   Microsoft	James Morris <jamorris@linux.microsoft.com>
-- 
2.35.1

