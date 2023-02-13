Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A220B6948BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBMOxB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBMOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:52:55 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5931C585;
        Mon, 13 Feb 2023 06:52:36 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DB8DD3A1F21;
        Mon, 13 Feb 2023 15:52:34 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C71663A1E83;
        Mon, 13 Feb 2023 15:52:34 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 15:52:34 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Align to common busy polling behaviour for mmc
 ioctls
Thread-Topic: [PATCH] mmc: core: Align to common busy polling behaviour for
 mmc ioctls
Thread-Index: AQHZP7BLniIOnZzrsUi603XryTU4yq7M9RcA
Date:   Mon, 13 Feb 2023 14:52:11 +0000
Message-ID: <a1094543b3ef43eabab345c5f05eaaa2@hyperstone.com>
References: <20230213133707.27857-1-ulf.hansson@linaro.org>
In-Reply-To: <20230213133707.27857-1-ulf.hansson@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27444.007
X-TMASE-Result: 10--11.638200-10.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4qoXHZz/dXlxyHdfpwipSH4UsxngDoycC4Ay
        Bv1w/1hJfE3qFp1T4KbCnfj2t9y5LBxz/eFLcdUtHWRJEfGP5nk6rt3TPmIRUcbl1d1BOPY45L2
        yUEzy9u5/VmtqhCUamN7J5X5VmQ0MtVDpc9bC13IReM8i8p3vgEyQ5fRSh265Z8i/MdLSpTtN8x
        iZIhWc/TjUD80DDHCGweQc8uYeC4GHx1sV2zgpga28N8u7CkOHamKrgqy61cLI9EDAP/dptl5Yb
        S0p5ywlCgENw8KnnTmfb6bl1YfU92gwIvLATTKBC24oEZ6SpSkgbhiVsIMQK9LdHHLXgng3Xnr2
        FjV9kJhZHZkk+9g/hW6ER7AR3y0WT6EavwVfEFg+kK598Yf3Mg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2d41d59c-eaa2-458d-bcb6-583acc096ff2-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW you can add a
Reviewed-by: Christian Loehle <cloehle@hyperstone.com>
Thanks!


-----Original Message-----
From: Ulf Hansson <ulf.hansson@linaro.org> 
Sent: Montag, 13. Februar 2023 14:37
To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>; Avri Altman <avri.altman@wdc.com>; Christian Löhle <CLoehle@hyperstone.com>; linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Align to common busy polling behaviour for mmc ioctls

Let's align to the common busy polling behaviour for mmc ioctls, by updating the below two corresponding parts, that comes into play when using an R1B response for a command.

*) A command with an R1B response should be prepared by calling mmc_prepare_busy_cmd(), which make us respects the host's busy timeout constraints.
**) When an R1B response is being used and the host also supports HW busy detection, we should skip to poll for busy completion.

Suggested-by: Christian Loehle <cloehle@hyperstone.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 25 +++++++++++++++++--------
 drivers/mmc/core/mmc_ops.c |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 20da7ed43e6d..672ab90c4b2d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -470,6 +470,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
+	bool r1b_resp, use_r1b_resp = false;
+	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
 
@@ -545,6 +547,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	    (cmd.opcode == MMC_SWITCH))
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
+	/* If it's an R1B response we need some more preparations. */
+	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
+	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
+	if (r1b_resp)
+		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
+						    busy_timeout_ms);
+
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
@@ -596,14 +605,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
-		/*
-		 * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
-		 * allow to override the default timeout value if a custom timeout is specified.
-		 */
-		err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
-					false, MMC_BUSY_IO);
-	}
+	/* No need to poll when using HW busy detection. */
+	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
+		return 0;
+
+	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
+	if (idata->rpmb || r1b_resp)
+		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
+					MMC_BUSY_IO);
 
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c index 81c55bfd6e0c..3b3adbddf664 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -575,6 +575,7 @@ bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 	cmd->busy_timeout = timeout_ms;
 	return true;
 }
+EXPORT_SYMBOL_GPL(mmc_prepare_busy_cmd);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
--
2.34.1

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

