Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AEF69010A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBIHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIHOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E941B59;
        Wed,  8 Feb 2023 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6J6Vi0RCPyxDfoC5MKQ9vw5ZM3fRcONntqTYKAAIxtY=; b=MvwvEZsirKM/I/dyhH+WFKvr4+
        FViBVyHS9zq6J3Klexs+0Hy3zOcjD6WezsmmhPNWeOagMsjtKQ6B4LRUm0exZbzPjh0MXoicb2R1p
        E3gQWIwuQjhjg0EnbJYH+BCK70jQmC4uda2dZ8QtfPMXiI0LqL7KjjTxnFFbv4ybr+1RpXNMR72eX
        mKccsJXVvDb/33c5pzdsIAsflLVXG3N3bIKiEb5kT6nXzNJGgQ/9r1l3kG1THPkkK71fXCACyJFG5
        5RIHfDVLWGDEaIiCF/7Xu00VHJatsjcsfuVOAuNIexKuw1k5AvVPnJJ268/OfO1UNd1w13ld83qHK
        so4B4ouQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18D-000LPt-Lt; Thu, 09 Feb 2023 07:14:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 12/24] Documentation: openrisc: correct spelling
Date:   Wed,  8 Feb 2023 23:13:48 -0800
Message-Id: <20230209071400.31476-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/openrisc/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/openrisc/openrisc_port.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -106,7 +106,7 @@ History
 	a much improved version with changes all around.
 
 10-04-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	alot of bugfixes all over.
+	a lot of bugfixes all over.
 	ethernet support, functional http and telnet servers.
 	running many standard linux apps.
 
@@ -114,7 +114,7 @@ History
 	port to 2.6.x
 
 30-11-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	lots of bugfixes and enhancments.
+	lots of bugfixes and enhancements.
 	added opencores framebuffer driver.
 
 09-10-2010    Jonas Bonn (jonas@southpole.se)
