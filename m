Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418771F497
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFAVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjFAVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:21 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F85184;
        Thu,  1 Jun 2023 14:25:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 51B315C01D4;
        Thu,  1 Jun 2023 17:25:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Jun 2023 17:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654720; x=1685741120; bh=vjypfpPRoU
        7xNHCTk2Gztx5IGWJumVDp62oiO1y8MH4=; b=QS6kbn1lVsQPDjeMFPYE/Nfixp
        fCec3RGDWj6Zx5E0RTWRDq9aZpHhu181d4dpYWzyYWJkyS68BUpOBwWq9DhhATO8
        +ZyBhwwLPCBa+DtOU5kHp2eKiyWC2Oecwar73chh2Mtx+xjBFcKIKA2khgz1rVeV
        dqolwNaATMsXQ1BpanFenABNHzXkYvKkVtEwHLQvT2qi7i/TzkBlH0Du9gu8Cb6q
        +xHgEyKWJM55WSAp9bmt3ilgAAwWbrBWRsCW+/NnfyBKVRpzG97LN/nVzPZ3VCBA
        RmlCK+QFDK/qWevsJMvnWVW5MPgUVXArM3gYHEelsbECGNCROp/bQaBKBN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654720; x=
        1685741120; bh=vjypfpPRoU7xNHCTk2Gztx5IGWJumVDp62oiO1y8MH4=; b=W
        Tz8zIWLRlgVtvoDLu1mw4rwdnZkCAMXL782bpRiHn9mJ1e/HL6qrZ8PEDx9FODhn
        6e3xsfUl+zdXAH57zyhQkqqlEDtqt81pCD/UmXnJ/BWgtQ5vvUn6Voicq3dVGEZG
        RYReNPna7FeinAC4Tblf1qkgk19vioYsk02MBisIZuqiiPCiTy+Bu6/tBnlnsNym
        gYgHTt6CYZgEAaSfaRovs3FKiAcrd/My1ThqoCXxRmVszwtuWWhn8Y5YjyoXOhiq
        OPt8Ix7lDNWHhNv1gwkal4GgI/FBiSG7IauAlSD09+ap6f/XohvCXb5+oHFmBkat
        zB53v6zhxe+Tb+GWDW7KQ==
X-ME-Sender: <xms:wAx5ZCop7mZ0sTHJh6aoixbkmxXE2hpeBBeaZkvdf0fWSbsehwCnGw>
    <xme:wAx5ZApfEXNvHSO10vsufNin_SAdjUB3gVaNzAkdWzjJShuQG0v7xXjdTTDuL3PbQ
    AuwmDJkN4i0a7k>
X-ME-Received: <xmr:wAx5ZHPLYNpMCuEbyVrjrHzrxcFisklaeh4Xortc_jx63i9ls9tcqnqszl1clo4EzXEbzPztBOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wAx5ZB5e536P_TRuBejVQt_cQiplNTKjKAzNptqLpQPP2iATdXDspQ>
    <xmx:wAx5ZB7L_eqEFw3Ns9k1frl4_L1CH2Jr5jaUtLU9OLBdKUU3u_eVBg>
    <xmx:wAx5ZBgMG9dI4j10NYs_2vLlWxLRnHWZqQBkNLxmHhAXvYdKoRsUqw>
    <xmx:wAx5ZLncHxR2y9IyXXRcNarRGZph6zvk8iAelJKk8lHREVjQGLCDAw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:19 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4/6] device-mapper: Avoid double-fetch of version
Date:   Thu,  1 Jun 2023 17:24:53 -0400
Message-Id: <20230601212456.1533-5-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601212456.1533-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version is fetched once in check_version(), which then does some
validation and then overwrites the version in userspace with the API
version supported by the kernel.  copy_params() then fetches the version
from userspace *again*, and this time no validation is done.  The result
is that the kernel's version number is completely controllable by
userspace, provided that userspace can win a race condition.

Fix this flaw by not copying the version back to the kernel the second
time.  This is not exploitable as the version is not further used in the
kernel.  However, it could become a problem if future patches start
relying on the version field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index da6ca26b51d0953df380582bb3a51c2ec22c27cb..fd46b249f6f856c49752063fc49d720e95df0525 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1873,12 +1873,13 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
  * As well as checking the version compatibility this always
  * copies the kernel interface version out.
  */
-static int check_version(unsigned int cmd, struct dm_ioctl __user *user)
+static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
+			 struct dm_ioctl *kernel_params)
 {
-	uint32_t version[3];
 	int r = 0;
+	uint32_t *version = kernel_params->version;
 
-	if (copy_from_user(version, user->version, sizeof(version)))
+	if (copy_from_user(version, user->version, sizeof(user->version)))
 		return -EFAULT;
 
 	if ((version[0] != DM_VERSION_MAJOR) ||
@@ -1922,7 +1923,10 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 	unsigned int noio_flag;
 
-	if (copy_from_user(param_kernel, user, minimum_data_size))
+	/* Version has been copied from userspace already, avoid TOCTOU */
+	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
+			   (char __user *)user + sizeof(param_kernel->version),
+			   minimum_data_size - sizeof(param_kernel->version)))
 		return -EFAULT;
 
 	if (param_kernel->data_size < minimum_data_size) {
@@ -2034,7 +2038,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	 * Check the interface version passed in.  This also
 	 * writes out the kernel's interface version.
 	 */
-	r = check_version(cmd, user);
+	r = check_version(cmd, user, &param_kernel);
 	if (r)
 		return r;
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

