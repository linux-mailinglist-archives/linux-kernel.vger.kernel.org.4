Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26C667DDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjA0Gl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjA0Gk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C0744B3;
        Thu, 26 Jan 2023 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6dh7aWHknhvT7YnCrAt+9Vf5iTuPUEyxyA+6onCSC9k=; b=iwM5j4jEPbVyyH2LyQ7Yo8PpQ0
        e+RigeHLVLANngRQjO2du+1qNViqU4sSszIrz8Fn63Q1LZzWCABV3PR1Tp4rcE6qYREKbPy23OuC3
        J2+26DcQkzgevMbPPHhXB6pCUUz3YFCj4U3sxcCjrTBIRJrJ031oMCQCqpZ+spVdwdMCoOA7tIX+F
        S67o1rdTlSbfMe0P6yR1KlypCkPqGAS3hpZdNHKd15zk0z0LEmrn4ZNbD0dtTyEtn36nbYK4dHGgv
        3f7xpb7UjD/p/sNsfLFKs8ju9oTxHatH9IG942ffLpl7R7gOrvOVITBoMkUjMIHAAxDW+t30P02aM
        8AcdocTg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPQ-00DM0u-0C; Fri, 27 Jan 2023 06:40:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 30/35] Documentation: tools/rtla: correct spelling
Date:   Thu, 26 Jan 2023 22:40:00 -0800
Message-Id: <20230127064005.1558-31-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/tools/rtla/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/tools/rtla/rtla-timerlat-top.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -128,7 +128,7 @@ and then when the *timerlat* thread was
 then be used as the starting point of a more fine-grained analysis.
 
 Note that **rtla timerlat** was dispatched without changing *timerlat* tracer
-threads' priority. That is generally not needed because these threads hava
+threads' priority. That is generally not needed because these threads have
 priority *FIFO:95* by default, which is a common priority used by real-time
 kernel developers to analyze scheduling delays.
 
