Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34874CC27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGJFXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGJFXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:23:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61EE6F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lbxhtrgiPKn33PFldNZ/U5WipLliz2AKk1g8DMEfRmY=; b=2hJ1V+AX3Ty5/hnlaD0B43/Glf
        lAI3mxJq7ma6bGRH95Ar1slkisZzoALEOfJvVf1ibUR2lCGPR5AB7vd7a2VSJxHZqRFeNjMrVC/Jl
        7PXvCsM7FnV8yoJq85QNfpGu02+ZiAWJLbyxN7zDQ5mnM1cE3AsK0JpBh7c1TRWOm5XWBIzuHdKmg
        vPBtObKvvw86Ndt3zUVufSNdXn+sBAI8jANIEXPhkIXJzj64fe61dFCYfvOzdW0QkjcGKBuhJWy5M
        PUEb74Efu6XO5P+xmhxkoCKq6QisxC7XhFOZDlzOclGle+INbacwYqFbeBL7zE88apnkwjgd1oaBk
        diySGY+A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjMO-00ASyS-04;
        Mon, 10 Jul 2023 05:22:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Cody P Schafer <dev@codyps.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf Documentation: fix spelling in sysfs events interfaces
Date:   Sun,  9 Jul 2023 22:22:55 -0700
Message-ID: <20230710052255.25708-1-rdunlap@infradead.org>
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

Fixes: ed90a4466340 ("perf Documentation: sysfs events/ interfaces")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Cody P Schafer <dev@codyps.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-events |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -47,7 +47,7 @@ Description:	Per-pmu performance monitor
 		If a <term> is specified alone (without an assigned value), it
 		is implied that 0x1 is assigned to that <term>.
 
-		Examples (each of these lines would be in a seperate file):
+		Examples (each of these lines would be in a separate file):
 
 			event=0x2abc
 			event=0x423,inv,cmask=0x3
@@ -83,7 +83,7 @@ Description:	Perf event scaling factors
 
 		A string representing a floating point value expressed in
 		scientific notation to be multiplied by the event count
-		recieved from the kernel to match the unit specified in the
+		received from the kernel to match the unit specified in the
 		<event>.unit file.
 
 		Example:
