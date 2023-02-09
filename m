Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4191C6900EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBIHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBIHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5283C28;
        Wed,  8 Feb 2023 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UtsHETgm9NdBjm7zsfWKEYsqPPKnOaDFPcTAJNtRmaw=; b=YAx/Dbsfg5N7XldJBq++JeNUyi
        CyTRbziiwzQzn+7Dw4TlAixoqnEKxGT0U885GsnWMl+MFydbkyBQ3GAE6lzRXLpyos51tvGrg51xq
        a8QDhEdKBcmDIGxJ/vaFNKpjXE+Lzu8eQVB9mjfi6PAwx+U4/QfYLtF7sg2PumtPLdMBrCvkwNIRs
        1XSoyWu0b2xLsuPRuNSQH/a7p6DcfSYwevw5qEiXH3F0mfmfVZzcT4ipO0CnrRzxKm5Pd0YHtjQaQ
        gVtidF7DUKw0vy0PcnL/8PAhvv9q00EkYIDbhf4gsp9ZuKEea0S7HSblNw5eE9Hgzb9pbJFZm6LVz
        TZqQD/tw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18B-000LPt-Ls; Thu, 09 Feb 2023 07:14:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 07/24] Documentation: input: correct spelling
Date:   Wed,  8 Feb 2023 23:13:43 -0800
Message-Id: <20230209071400.31476-8-rdunlap@infradead.org>
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
