Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0417690104
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBIHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBIHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9B40BEF;
        Wed,  8 Feb 2023 23:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xqejHlxmEgdf2qOVqDiEIshdX/dk1+H6pQPuc539E3M=; b=KEN8zbRZ7305zlW72s1UeKN2Ax
        F6w7+eRQ22cnhycEod/nTgPN+Td9IoCuPOLfBQIStMVO5Sy6abHM3rDXIRXVVU+q5z+MJQdT5/BAR
        QVgD/tW61fmGkTeGVmi795tJSech3wTPPFf5pqht+6reQCFR5MoV6bRzf9h6UqjpCItS/PWz4q1Tg
        wcXVngEG2k7CyVNRpQSZ8c9zSe/f5masdPKKSWItjq4Ns2jjtIxC8E95u9zlrUOlmpVqFCa6Xl+DM
        mprEr8XJ98FpjxcGNWwoKeLogdGOgJdrhaJStJg9sO8jmRNdI9qoAIbmIN7oSJpf6frHod8EAQmk5
        tMFtOyJw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18I-000LPt-N1; Thu, 09 Feb 2023 07:14:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 24/24] Documentation: xtensa: correct spelling
Date:   Wed,  8 Feb 2023 23:14:00 -0800
Message-Id: <20230209071400.31476-25-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/xtensa/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/xtensa/atomctl.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
--- a/Documentation/xtensa/atomctl.rst
+++ b/Documentation/xtensa/atomctl.rst
@@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use
 operations.
 
 For systems without an coherent cache controller, non-MX, we always
-use the memory controllers RCW, thought non-MX controlers likely
+use the memory controllers RCW, though non-MX controllers likely
 support the Internal Operation.
 
 CUSTOMER-WARNING:
