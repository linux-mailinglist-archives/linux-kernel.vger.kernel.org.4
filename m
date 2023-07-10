Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C374CC26
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGJFXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJFWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:22:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F910CA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fA2ExLR8HvjUrqogKz4CKLqAWA1RuErFtm4KKLE9jNs=; b=wInQHh3pvBovCozPeGPCMLjlDB
        /eUevo++HVEfvWeVK5ucxM3axZWHyWzR0US11Ys9eR7K7/131pfBaDf8NfjocF4tfWLAYfY7o1rse
        wbrP9alrnVdobpxjs1Y3qgI/XieXtevMcBmiFnQPp/e9B1P083mZzBrzzL2CY/Dvfnzhd91eH+lEd
        x5OxlAFXWSaFXCVJYQGELtZmfhGQ46RVRcmuKXav7UxCQeBXwJRU+l6qFjZyaPwetPHkHj5Xwyyr2
        LmveSVtSFs4M4CySOJa81EiBF3dKpb2BxdbgVIo6s6RTYqf195H2GJbFBlilRdV5FXu6oxf8uxXes
        BeRLrIjg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjLv-00ASvi-1L;
        Mon, 10 Jul 2023 05:22:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] HWPOISON: offline support: fix spelling in Documentation/ABI/
Date:   Sun,  9 Jul 2023 22:22:23 -0700
Message-ID: <20230710052223.18254-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems as identified by codespell.

Fixes: facb6011f399 ("HWPOISON: Add soft page offline support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/ABI/testing/sysfs-memory-page-offline |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-memory-page-offline b/Documentation/ABI/testing/sysfs-memory-page-offline
--- a/Documentation/ABI/testing/sysfs-memory-page-offline
+++ b/Documentation/ABI/testing/sysfs-memory-page-offline
@@ -10,7 +10,7 @@ Description:
 		dropping it if possible. The kernel will then be placed
 		on the bad page list and never be reused.
 
-		The offlining is done in kernel specific granuality.
+		The offlining is done in kernel specific granularity.
 		Normally it's the base page size of the kernel, but
 		this might change.
 
@@ -35,7 +35,7 @@ Description:
 		to access this page assuming it's poisoned by the
 		hardware.
 
-		The offlining is done in kernel specific granuality.
+		The offlining is done in kernel specific granularity.
 		Normally it's the base page size of the kernel, but
 		this might change.
 
