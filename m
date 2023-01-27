Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBC67DDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjA0Glq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjA0GkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79069B07;
        Thu, 26 Jan 2023 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UtsHETgm9NdBjm7zsfWKEYsqPPKnOaDFPcTAJNtRmaw=; b=oWT+ukmPS7MMQzr9rFsrW37Giv
        JeD8cOuz+wgTmhH3JHmFHWa9Ixv8/M9phEsM/H7e/BWq2uCq6ulgdWK8/BqYwr1xssOuTJqKtYK0q
        zh7F/GOlIJqt2F2ypsHVO9XUEDEy4mCOr0A3nquJvYg4OwXgDmAIKRgPLVYPpm/7C9qa2CFX0fuZ3
        pUP+31MBir9UTZJPAzD1+eATKx/4GkT6388e35LLfVlxq790CwZmqSmTt5BDxsPQ+LCGMahEx/9Z5
        nXLSvtz4qhym52KzX0+IuEKVGP9Aba49XQ9+gU3C4Ql2I7s/OqZV1h3huKFEenTLEQ7WvYj/Qw+bp
        gA4R6pjw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPH-00DM0u-HT; Fri, 27 Jan 2023 06:40:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 12/35] Documentation: input: correct spelling
Date:   Thu, 26 Jan 2023 22:39:42 -0800
Message-Id: <20230127064005.1558-13-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/input/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/input/devices/iforce-protocol.rst |    2 +-
 Documentation/input/multi-touch-protocol.rst    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/input/devices/iforce-protocol.rst b/Documentation/input/devices/iforce-protocol.rst
--- a/Documentation/input/devices/iforce-protocol.rst
+++ b/Documentation/input/devices/iforce-protocol.rst
@@ -49,7 +49,7 @@ OP DATA
 == ====
 
 The 2B, LEN and CS fields have disappeared, probably because USB handles
-frames and data corruption is handled or unsignificant.
+frames and data corruption is handled or insignificant.
 
 First, I describe effects that are sent by the device to the computer
 
diff -- a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
--- a/Documentation/input/multi-touch-protocol.rst
+++ b/Documentation/input/multi-touch-protocol.rst
@@ -383,7 +383,7 @@ Finger Tracking
 ---------------
 
 The process of finger tracking, i.e., to assign a unique trackingID to each
-initiated contact on the surface, is a Euclidian Bipartite Matching
+initiated contact on the surface, is a Euclidean Bipartite Matching
 problem.  At each event synchronization, the set of actual contacts is
 matched to the set of contacts from the previous synchronization. A full
 implementation can be found in [#f3]_.
