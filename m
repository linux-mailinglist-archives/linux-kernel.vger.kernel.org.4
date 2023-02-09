Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305D6900F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBIHOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BA76EBE;
        Wed,  8 Feb 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ov9sgtmaVVk76Nnibt+EsTt5whBz9yioDNjhR8t7vzM=; b=sotlfO2ckkITNtMuLW72f3/Oed
        FkjR9N20VHrFzd0sN42rLRcMpV/kIlKfI7aYuhMY7tXgpIVnQ6hdzvPwNPttm4M7zr3y/vDiCVjaM
        aUk3sUJttR686//8ozmIXp/BAnOuzbxBxMNfjSNfkmN8CTU6ypH4nt5lFmR1uq2Zyrhu7ijerAtYh
        U4ZfEqYxWoRi4sxIRcaZ+Irg7DPwrf94IEucLhOzwRDftx1vSqObd/F6yHlFEyrak+lFZrdhjNOVW
        V/3lZhi6gNF0ImlLJC6G1bydJSvVb4iEET4L4i3PfMEwuldWgDhm3dNNGF0zX0Koa1gmkr7PgwoRp
        Xzk41sTQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ189-000LPt-Tq; Thu, 09 Feb 2023 07:14:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 02/24] Documentation: block: correct spelling
Date:   Wed,  8 Feb 2023 23:13:38 -0800
Message-Id: <20230209071400.31476-3-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/block/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/block/data-integrity.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
--- a/Documentation/block/data-integrity.rst
+++ b/Documentation/block/data-integrity.rst
@@ -209,7 +209,7 @@ will require extra work due to the appli
       sector must be set, and the bio should have all data pages
       added.  It is up to the caller to ensure that the bio does not
       change while I/O is in progress.
-      Complete bio with error if prepare failed for some reson.
+      Complete bio with error if prepare failed for some reason.
 
 
 5.3 Passing Existing Integrity Metadata
