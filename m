Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E45F442E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJDNU6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJDNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:20:17 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CA13D07;
        Tue,  4 Oct 2022 06:20:11 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C4037462EE6;
        Tue,  4 Oct 2022 15:15:09 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B0C21460CCE;
        Tue,  4 Oct 2022 15:15:09 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 15:15:09 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 4 Oct 2022
 15:15:06 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Tue, 4 Oct 2022 15:15:06 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCHv2] mmc: core: fix race of queue reset and card removal
Thread-Topic: [PATCHv2] mmc: core: fix race of queue reset and card removal
Thread-Index: AdjX8vnmWSO+H9o1T5SYJhJVtR/27gAAAvCw
Date:   Tue, 4 Oct 2022 13:15:06 +0000
Message-ID: <e844eb3f4b1c4f1a94e235501294afaa@hyperstone.com>
References: <1a5810475d7a475db5e4e5130b8f455c@hyperstone.com>
In-Reply-To: <1a5810475d7a475db5e4e5130b8f455c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27180.007
X-TMASE-Result: 10--7.586600-10.000000
X-TMASE-MatchedRID: xIhOSkOSohXUL3YCMmnG4qk29rFswht+ZR+OFNkbtdrL584GsPTBR4/x
        1Ofbpz/fRt/dc/AJIZpkEJo9iTruXzmpL9mXE1+sHmtCXih7f9MxXH/dlhvLv60GJL2EV5pMxnU
        Xzyseixws96UccUHPK6hA84ZhaH5VMeIPuyyqyWyt3STmfbGX2dDEMPvvoocvIiqlmO0FgHumYO
        EKv2cEUZdhlAAXYT7MazVjfNhqisEwKOw87rpd8Qzi9ePw0R3QOA3W7N7dBgnfUY2boz4kpEIjI
        p4EpSqC6V+wThLTbQu12HagvbwDji/7QU2czuUNA9lly13c/gFHyz3bB5kG5zQM0/COoudwiE9R
        qXHGrIdAYdLFXr37Pi6ara/v51AdD7lLiXNUhrOeAiCmPx4NwGNn8XPiALIbGzlkwm0NFqgXeuQ
        CqIxleSAHAopEd76vx/5oftUh0TxWJoZHAnYjDjvYzElUipWsPBzW0U0cb8iiIr06VegyOA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: NULL-NULL-7-0-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess treat both versions more like RFCs.
V1 seems a bit nicer, v2 avoids the dangling mq->card, which I don't see an issue with but am easily convinced otherwise.
Both fix the issue for me.

-----Original Message-----
From: Christian Löhle <CLoehle@hyperstone.com> 
Sent: Dienstag, 4. Oktober 2022 15:14
To: ulf.hansson@linaro.org; Adrian Hunter <adrian.hunter@intel.com>; Linux MMC List <linux-mmc@vger.kernel.org>; linux-kernel@vger.kernel.org; Christian Löhle <CLoehle@hyperstone.com>
Cc: Avri Altman <Avri.Altman@wdc.com>
Subject: [PATCHv2] mmc: core: fix race of queue reset and card removal

If a recovery is active and the card is removed do not try to switch back partitions. Furthermore do not reference
mq->card which might be NULLed in the meantime.

This has been observed with recovery active with CQE.
[ 1083.510578] Unable to handle kernel NULL pointer dereference at virtual address 000000000000038c [ 1083.511362] Mem abort info:
[ 1083.511626]   ESR = 0x96000004
[ 1083.511912]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1083.512395]   SET = 0, FnV = 0
[ 1083.512681]   EA = 0, S1PTW = 0
[ 1083.512973]   FSC = 0x04: level 0 translation fault
[ 1083.513417] Data abort info:
[ 1083.513686]   ISV = 0, ISS = 0x00000004
[ 1083.514039]   CM = 0, WnR = 0
[ 1083.514318] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000a4c3000 [ 1083.514899] [000000000000038c] pgd=0000000000000000, p4d=0000000000000000 [ 1083.515854] Internal error: Oops: 96000004 [#1] SMP
[ 1083.516295] CPU: 0 PID: 153 Comm: kworker/0:2 Tainted: G        W         5.18.12-g925ff1d10c99-dirty #7
[ 1083.517127] Hardware name: Pine64 RockPro64 v2.1 (DT) [ 1083.517574] Workqueue: events mmc_mq_recovery_handler [ 1083.518032] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--) [ 1083.518645] pc : mmc_blk_reset+0x60/0x1ac [ 1083.519004] lr : mmc_blk_reset+0x38/0x1ac [ 1083.519361] sp : ffff8000100b3cd0 [ 1083.519654] x29: ffff8000100b3cd0 x28: 0000000000000000 x27: 0000000000000000 [ 1083.520288] x26: ffff80000b0ba000 x25: ffff0000f6e74805 x24: ffff000004c2fdc0 [ 1083.520922] x23: ffff000014950000 x22: ffff000004c2fc18 x21: ffff00000a33c000 [ 1083.521556] x20: 00000000ffffff85 x19: ffff000004c2fc00 x18: ffffffffffffffff [ 1083.522189] x17: ffff80000cd9b200 x16: ffff80000cd9b190 x15: 0000000000000006 [ 1083.522823] x14: 0000000000000000 x13: ffff80000b0c28f0 x12: 0000000000001707 [ 1083.523457] x11: 00000000000007ad x10: ffff80000c6c28f0 x9 : ffff80000b0c28f0 [ 1083.524090] x8 : 00000000fffbffff x7 : 0000000000000001 x6 : 0000000000000000 [ 1083.524723] x5 : 0000000000000000 x4 : ffff0000f6e62d30 x3 : 0000000000000000 [ 1083.525357] x2 : 0000000000000000 x1 : ffff00000b6e0000 x0 : 0000000000000000 [ 1083.525990] Call trace:
[ 1083.526209]  mmc_blk_reset+0x60/0x1ac [ 1083.526536]  mmc_blk_cqe_recovery+0x8c/0xd0 [ 1083.526908]  mmc_mq_recovery_handler+0xc4/0xd0 [ 1083.527303]  process_one_work+0x23c/0x3fc [ 1083.527663]  worker_thread+0x74/0x420 [ 1083.527990]  kthread+0xec/0xf0 [ 1083.528264]  ret_from_fork+0x10/0x20 [ 1083.528587] Code: d50323bf d65f03c0 f94352a0 f9404000 (b9438c01) [ 1083.529126] ---[ end trace 0000000000000000 ]---

[ 1431.677970] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000 [ 1431.678753] Mem abort info:
[ 1431.679017]   ESR = 0x96000004
[ 1431.679303]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1431.679786]   SET = 0, FnV = 0
[ 1431.680072]   EA = 0, S1PTW = 0
[ 1431.680366]   FSC = 0x04: level 0 translation fault
[ 1431.680810] Data abort info:
[ 1431.681080]   ISV = 0, ISS = 0x00000004
[ 1431.681432]   CM = 0, WnR = 0
[ 1431.681712] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000bb98000 [ 1431.682390] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000 [ 1431.683393] Internal error: Oops: 96000004 [#1] SMP [ 1431.683841] CPU: 0 PID: 19948 Comm: kworker/0:2 Not tainted 5.18.12-gf65532578f32-dirty #16 [ 1431.684576] Hardware name: Pine64 RockPro64 v2.1 (DT) [ 1431.685024] Workqueue: events mmc_mq_recovery_handler [ 1431.685487] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--) [ 1431.686100] pc : mmc_put_card+0x38/0x110 [ 1431.686453] lr : mmc_mq_recovery_handler+0x98/0xd0 [ 1431.686879] sp : ffff800015813cf0 [ 1431.687173] x29: ffff800015813cf0 x28: 0000000000000000 x27: 0000000000000000 [ 1431.687807] x26: ffff80000b0ba000 x25: ffff0000f6e74805 x24: ffff000013bd65c0 [ 1431.688441] x23: ffff000013b96120 x22: ffff000013bd6418 x21: 0000000000000000 [ 1431.689075] x20: ffff800008ed1c70 x19: ffff8000091767d8 x18: ffffffffffffffff [ 1431.689709] x17: 31335b1b6d375b1b x16: 6d305b1b47554245 x15: 0000000000000006 [ 1431.690343] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 [ 1431.690976] x11: ffff000013bd6570 x10: 0000000000000001 x9 : ffff80000ea69228 [ 1431.691611] x8 : ffff80000df892c8 x7 : 0000000000000000 x6 : 0000000000000001 [ 1431.692245] x5 : 0000000000000001 x4 : 0000000000000002 x3 : ffff80000e6feac8 [ 1431.692879] x2 : 000000000000036e x1 : ffff800008ed1c70 x0 : 0000000000000000 [ 1431.693513] Call trace:
[ 1431.693732]  mmc_put_card+0x38/0x110
[ 1431.694055]  mmc_mq_recovery_handler+0x98/0xd0 [ 1431.694452]  process_one_work+0x23c/0x3fc [ 1431.694812]  worker_thread+0x74/0x420 [ 1431.695139]  kthread+0xec/0xf0 [ 1431.695414]  ret_from_fork+0x10/0x20 [ 1431.695738] Code: f9001bf7 aa0103f6 aa0003f5 aa1403e1 (f9400017) [ 1431.696278] ---[ end trace 0000000000000000 ]---

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 4 ++--
 drivers/mmc/core/queue.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index ce89611a136e..0cd3a7065629 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -997,8 +997,8 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 
 	md->reset_done |= type;
 	err = mmc_hw_reset(host->card);
-	/* Ensure we switch back to the correct partition */
-	if (err) {
+	/* Ensure we switch back to the correct partition on successful reset */
+	if (!err) {
 		struct mmc_blk_data *main_md =
 			dev_get_drvdata(&host->card->dev);
 		int part_err;
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index fefaa901b50f..6931fa082ea7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -137,9 +137,10 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	struct mmc_queue *mq = container_of(work, struct mmc_queue,
 					    recovery_work);
 	struct request_queue *q = mq->queue;
+	struct mmc_card *card = mq->card;
 	struct mmc_host *host = mq->card->host;
 
-	mmc_get_card(mq->card, &mq->ctx);
+	mmc_get_card(card, &mq->ctx);
 
 	mq->in_recovery = true;
 
@@ -157,7 +158,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	if (host->hsq_enabled)
 		host->cqe_ops->cqe_recovery_finish(host);
 
-	mmc_put_card(mq->card, &mq->ctx);
+	mmc_put_card(card, &mq->ctx);
 
 	blk_mq_run_hw_queues(q, true);
 }
--
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

