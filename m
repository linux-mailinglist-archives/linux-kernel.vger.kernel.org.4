Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809974F465
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGKQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGKQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:06:22 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B9E7E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1689091568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CQ07KOad9rBrX25HAdPxBhuEPDkFzDLdIlc2phuivUw=;
  b=ULLcrm9X6+tEi2B+W+8aKR/Yt+q/hOyx7LQAv56I7B2Eg1SuoUQBBnSs
   Jgt63MFFuSEwqprWri7YK/dU8URNPI5g9hUal2M68itelvxUuKK0lI9Re
   W+ff3K4atFCIQ0gnUen+clQR+sIeB76BYVO+31rdnCz/9SBgv3fL8uSZK
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 115870688
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:TiNRL60c5KI7ha1NBfbD5dpxkn2cJEfYwER7XKvMYLTBsI5bp2YHz
 zYXDTuAOayMZGr0KNt0PNzl9R8AuMDXxodrSQBkpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gNnPKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfDSZP6
 qQoNRMxPlOMnsOJ7a68E/BCmZF2RCXrFNt3VnBIyDjYCbAtQIzZQrWM7thdtNsyrpkQR7CEP
 ZNfMGcxKk2aOHWjOX9OYH46tP2vnWK5dzRXpUiKrK4zy2PS0BZwwP7mN9+9ltmiHJwIzhnA+
 DKWl4j/Kg85EvO+7Bq6y3at2eXQsAz5cb0RPqLto5aGh3XMnzdOWXX6T2CTpfi/l177UdZYI
 E885CUjt+4x+VatQ927WAe3yFaAvxgBS59THvc85QWl1KXZ+UCaC3ICQzoHb8Yp3Oc/VTYt2
 3eKksnvCDgpvL79dJ6G3u7K93XoY3FTdDJcI3ZeFmPp/uUPvqk/yRPQFuZ+M5LlzdLsOA7d3
 zfTtQYh0uB7YdEw60mrwbzWq2vy9smREVVstlu/snGNtV0gOtP8D2C8wR2CtKsbct7EJrWUl
 CJc8/Vy+tziGn1keMalZOwWVI+k6P+eWNE3qQ4+RsJxn9hBFpPKQGyx3N2dDB0zWir8UWW1C
 HI/QCsIjHOpAFOkbLVsf6W6ANkwwK7rGLzND66EP4IXPsEpKFPepUmCgHJ8OEi0wCARfVwXY
 8/HIa5A815HYUiY8NZGb7hEiuJ6rszP7WjSWYr633yaPUm2PRaopUM+GALWNIgRtfrUyDg5B
 v4Db6NmPT0DCryhCsQWmKZPRW03wY8TXsiu8ZMPL7LYemKL2ggJUpfs/F/oQKQ994w9qwsC1
 ijVtpNwoLYnuUD6FA==
IronPort-HdrOrdr: A9a23:tr6XYKySOkBc2pY/vLFbKrPxC+gkLtp133Aq2lEZdPULSKylfp
 GV/cjziyWbtN9IYgBcpTnyAtj9fZq8z+8+3WB1B93SPzUO11HYV72KgbGSpwEIeBeOu9K1t5
 0QCZSWYeeYZTMW4amKgnjcLz9K+qjgzEncv5an854bd3ASV0gP1XYfNi+rVmlNACVWD5swE5
 SRouJBujqbYHwSKuirG3UfWODHhtvT0LbrewQPCRIL4BSHyWrA0s+0LzGomjMlFx9fy7Yr9m
 bI1yT/+6WYqvm+jjPMymPJ6JxSud35jv9OHtaFhMQ5IijlziyoeINicbufuy1dmpDi1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6xmxLY0I3EbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnR76+8PDW3hR5wqJSDsZ4K0uZk5kIM4jgYxq3MgiFYRuYdA99RfBmcIa+S
 9VfYfhDbhtAAqnhjvizxZSKZSXLwoO91G9MwY/k/3Q6iNRmn9hyUse2YgwolcsnahNEaVs1q
 D8KaJvm6hJTsgKKYRHJMlEb/eWJwX2ME/x2ET7GyW9KEjCAQOUl3b6jY9Fld2CadgGyoA/l4
 /GV04dvWkue1j2AcnLx5FT9AvRKV/NFAgF5/sukKSRgIeMMobDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7vmIXH1EYhE0gXiU90KQENuG/E9q5I+QRaDs8jLIorluqjSd+vSPqPkFXIhVnnkCn
 UOUTDvLIFL71ytWHX/nB/NMkmdMnDX7NZ1CuzX7uITwI8COslFtRUUk02w4oWRJThLosUNDT
 9DyXPc49aGTEWNjBT1Bj9SS2pg525ukcbdb08=
X-Talos-CUID: =?us-ascii?q?9a23=3ANNdYKGtdPU2Zx2LPf5zBR2cE6IspNXzClEfNAHP?=
 =?us-ascii?q?oSmlwaYK4VVjJ4Y17xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AJRVNTw3Arg2tLSRrqGbYl35nojUj/YeIJ2Eosao?=
 =?us-ascii?q?/v8jbPzNdFDW0szedXdpy?=
X-IronPort-AV: E=Sophos;i="6.01,196,1684814400"; 
   d="scan'208";a="115870688"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] blk-mq: Fix stall due to recursive flush plug
Date:   Tue, 11 Jul 2023 17:04:34 +0100
Message-ID: <20230711160434.248868-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen rare IO stalls as follows:

* blk_mq_plug_issue_direct() is entered with an mq_list containing two
requests.
* For the first request, it sets last == false and enters the driver's
queue_rq callback.
* The driver queue_rq callback indirectly calls schedule() which calls
blk_flush_plug().
* blk_flush_plug() handles the remaining request in the mq_list. mq_list
is now empty.
* The original call to queue_rq resumes (with last == false).
* The loop in blk_mq_plug_issue_direct() terminates because there are no
remaining requests in mq_list.

The IO is now stalled because the last request submitted to the driver
had last == false and there was no subsequent call to commit_rqs().

Fix this by returning early in blk_mq_flush_plug_list() if rq_count is 0
which it will be in the recursive case, rather than checking if the
mq_list is empty. At the same time, adjust one of the callers to skip
the mq_list empty check as it is not necessary.

Fixes: dc5fc361d891 ("block: attempt direct issue of plug list")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

I'm not 100% sure if I've got the correct Fixes commit.

 block/blk-core.c | 3 +--
 block/blk-mq.c   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 99d8b9812b18..90de50082146 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1144,8 +1144,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
 	 * Unconditionally flush out cached requests, even if the unplug
 	 * event came from schedule. Since we know hold references to the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d..d5a7f36e634f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2742,7 +2742,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request *rq;
 
-	if (rq_list_empty(plug->mq_list))
+	if (plug->rq_count == 0)
 		return;
 	plug->rq_count = 0;
 
-- 
2.39.3

