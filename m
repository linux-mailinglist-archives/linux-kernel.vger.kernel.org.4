Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7165E13C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAEADJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjAEACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:02:35 -0500
X-Greylist: delayed 1107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 16:02:34 PST
Received: from elsa (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370D24F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:02:34 -0800 (PST)
Received: from ben by elsa with local (Exim 4.96)
        (envelope-from <ben@fluff.org>)
        id 1pDDQT-002hIs-3D;
        Wed, 04 Jan 2023 23:44:05 +0000
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben-linux@fluff.org>, ben@simtec.co.uk
Subject: [PATCH] mailmap: add alias for Ben Dooks' old simtec address
Date:   Wed,  4 Jan 2023 23:44:05 +0000
Message-Id: <20230104234405.643105-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,PDS_RDNS_DYNAMIC_FP,RCVD_IN_SORBS_DUL,
        RDNS_DYNAMIC,SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ben@simtec.co.uk address may be still active, but not sure for how
long and I have not worked there for over ten years. Add my ususal
fluff.org email here.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Cc: ben@simtec.co.uk
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ccba4cf0d893..d1c2635ad394 100644
--- a/.mailmap
+++ b/.mailmap
@@ -67,6 +67,7 @@ Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang7@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
+Ben Dooks <ben-linux@fluff.org> <ben@simtec.co.uk>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
-- 
2.39.0

