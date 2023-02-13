Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9A6942F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBMKew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 05:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBMKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:41 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B0E04D;
        Mon, 13 Feb 2023 02:34:36 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id AE65B3A1F1A;
        Mon, 13 Feb 2023 11:34:33 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 97AB03A1ECA;
        Mon, 13 Feb 2023 11:34:33 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 11:34:33 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Topic: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Index: Adkpq3tb+gXfT/KXQXawlvtJeLUDVwV6ujEw
Date:   Mon, 13 Feb 2023 10:34:32 +0000
Message-ID: <8f4a0fc6f2e64ef091784c5cd704c113@hyperstone.com>
References: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
In-Reply-To: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27444.007
X-TMASE-Result: 10--11.859300-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4l/ZJ0h1vLl1kdS3kPlaZyUUsxngDoycC4Ay
        Bv1w/1hJfE3qFp1T4KYvsWJXoHruFU7xWA6ntpDGHWRJEfGP5nkWUg/hm489yC99T+uJIleR2Si
        3/7YtpVQi+t+0AiFaYvL3NxFKQpq18gFf6MN9cav2TS1YFaI5/2+TcmJcOPh12An5g1C6+/JZEI
        hf8tdBvo33djKu5wMzf1PmKZ3/Yc0NdWPTMyGlNj4RbdPTGu78Sxj0b9FncUKbKItl61J/yRMZG
        6kg1oMPdgkRR8OiM/8gBwKKRHe+r+sNXgWBsm2vNlN4gSb/lQwLlf05lO87n3kpCaNresUkfgJm
        KoiOcok=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: d2b847c7-e73b-43ff-9eaa-a246602cc7e4-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any more comments regarding this patch?

-----Original Message-----
From: Christian Löhle 
Sent: Montag, 16. Januar 2023 15:38
To: adrian.hunter@intel.com; 'Avri Altman' <Avri.Altman@wdc.com>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org
Subject: [PATCH] mmc: block: workaround long ioctl busy timeout

The ioctl interface allowed to set cmd_timeout_ms when polling for busy on R1B commands. This was often limited by the max hw timeout so work around it like for the sanitize command.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 20da7ed43e6d..ba3bc9014179 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -472,6 +472,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
+	unsigned int busy_timeout = MMC_BLK_TIMEOUT_MS;
+	int poll_prog = false;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
@@ -493,6 +495,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	cmd.opcode = idata->ic.opcode;
 	cmd.arg = idata->ic.arg;
 	cmd.flags = idata->ic.flags;
+	/* R1B flag might be removed here to work around hw, so save it */
+	poll_prog = (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B);
+	busy_timeout = idata->ic.cmd_timeout_ms ? :
+		MMC_BLK_TIMEOUT_MS;
+	if (poll_prog)
+		mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
 
 	if (idata->buf_bytes) {
 		data.sg = &sg;
@@ -596,7 +604,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+	if (poll_prog) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
 		 * allow to override the default timeout value if a custom timeout is specified.
--
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

