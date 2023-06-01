Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7D71F49B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFAVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFAVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933F196;
        Thu,  1 Jun 2023 14:25:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 308695C01D5;
        Thu,  1 Jun 2023 17:25:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 17:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654716; x=1685741116; bh=YCzACzClxG
        a/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=Yow1RwdfcCR7QVK1I2IfI5kT+G
        6A5aRNuZHN+dx4ifLPyv2d3v2R0GduuZCBSdHKmgS/m+GhNW3BvaPzbZ+U6WnM/f
        rgBbrybs0D3VMAgqza08vUvDmQRkOgum/90REHRP1dTaJ2f+coP+CpST89r8ENe9
        FWA3JMY0ulvPqmSox62Rg0n84Ng0zFb1yOJoiiJI3/FI9E9U5zCLkYhS+pWqq4fu
        28mNw6y5S4dLK4kWJv2tBEH50CQM8nbwdufZX9uZbYj2XwtHTE40Yzfmyy+tNYCP
        Lph5PXpNR/nDbxYefx4fZrm+Or/Ae6z5vsZktOoq5opqjvMX/7NiCceZetkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654716; x=
        1685741116; bh=YCzACzClxGa/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=N
        yUnBK+5umNQE4gkH8ZRIQSupXiK6IgaOEfWtGj5fBmK3MdhlCcEOz3J1FS2ifIXy
        aXv25JePjIbEF7CTwIvZBwOU+VzGN9/p2LvRtd/kD5PrKXguZh6tVgYSAv4VEMN0
        XQV3HTD/WCQZKmcBKZVMgHKX3wb3gCZXs4x/9sdd5GaMoV7n0xSGbUJw5is7571K
        9ne1u78HwBavBlV9xVL+eiPPb7hu7B9kqCe28WUsgewk43aXnUknaTAW8kF6qOvF
        9KjF+9CTOr9SpyNqOoVBJ8nIlBRcKRk9zDzrCa34We8N9Siz7EmAn9mDa+EHmu3y
        gMrMryjCv+dB7UCvFoKIw==
X-ME-Sender: <xms:vAx5ZPeJ62iFIc02HV_uhUIF9LB6cwRAx3mhd7A4lXCV2vaE4qfZlw>
    <xme:vAx5ZFPE5_OJTn625YVsB3lfS6Iap9WyzTUUz5xmoQoj53tHLNM1wMyuIlJgg1NMt
    ICsB-MBahW8Ufs>
X-ME-Received: <xmr:vAx5ZIiB9QFUIKDMm24fXG1pqKaZYFjcGXYaaLfWQzggM-BSP9DGpo-u7_m1adEIYaVgcq4jF4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:vAx5ZA_DKwbnMEXLnSBS4ff8ZYgvc0QHBAbsrFd_t-EnGoA-LrCNsQ>
    <xmx:vAx5ZLtL-QEn0Tv758fSfGBxyx7OmaHofAeEMdpkEIHTO_4ziX6Yzw>
    <xmx:vAx5ZPHceUzhQPK2NF_eKC-ZIYwwZnPrKexinPIVRCvz2OjrwTUw7Q>
    <xmx:vAx5ZLKPbA-xWdAPnhBokhZLLHjjnrVHGJqbvHZiw6wSnceol8JGJA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:15 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/6] device-mapper: Check that target specs are sufficiently aligned
Date:   Thu,  1 Jun 2023 17:24:50 -0400
Message-Id: <20230601212456.1533-2-demi@invisiblethingslab.com>
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

Otherwise subsequent code will dereference a misaligned
`struct dm_target_spec *`, which is undefined behavior.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
+	static_assert(_Alignof(struct dm_target_spec) <= 8,
+		      "struct dm_target_spec has excessive alignment requirements");
+	if (next % 8) {
+		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
+		return -EINVAL;
+	}
+
 	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
 	*target_params = (char *) (*spec + 1);
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

