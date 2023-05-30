Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B481D716ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjE3UdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjE3Ucu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:32:50 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB43E62;
        Tue, 30 May 2023 13:32:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F2B183200930;
        Tue, 30 May 2023 16:32:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 May 2023 16:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478723; x=1685565123; bh=rwGIL/9NRS
        MhUwVWwsxjoxS5AMM8VOhnzZgHY9xGhxg=; b=qkBueq2r2OyWcbusDQUrjajFFr
        8ESqGro3ggJwym7lFf9BI9ESX7xekhNhstWp8F1ueTG3NmoZqthNHTWOXbCGq5Vw
        67eIWybB+EGrobvjODoQqwC70WtdLXTl2k5nQabcp3ZQs/dQWH2f+QrTvapYJOrW
        JrHz90N9W+aLbcMlDjF0cjaNT1cyK5hLdd/RpV3VjOJWSictxkSNvJ89RwdrBPZG
        E9Kxm85hwY5s7dhDK62GqfSywSV09msrreFFwcypf91DJsdE3WhAfmU038D6fTNC
        IJwxS9XPoI4erBBQzlRsVtR6w58sX6QtAWlnzP3FUVoK+Ii+7VvWyJVHGyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478723; x=
        1685565123; bh=rwGIL/9NRSMhUwVWwsxjoxS5AMM8VOhnzZgHY9xGhxg=; b=y
        4N/s9MUZzZd4QAK3LutuCyRwXJa6PV0apyBdJJ0IvWA7d2gGhkz/XsZL7+VJH2SG
        iOcTbZxxHnngGWA/vK1Cy/hWHcqG4/qzaYGV3DdLfQBhITU6JQPFY6rYK8F78XZs
        GsFx5qwOlj2SIdDWk5FlJyasxkbCa3R96lDH1Hm2Dvhf2k7z0wpQK4fuV1Q/mMRI
        fUSMAzPyoOA+uwmX+9p0bB+XYk6wNk3PB/5bWjVYO6PrYeHoE9udaLaxIrHaFqnW
        IaScZZBdVbuKJ7vOHjBpV2ygqFDhJvzlolEe5vP4KmsAbmnCAoIBk1ZiIgIsCNXl
        w1VoeHG8LsGkBO7eC24Bg==
X-ME-Sender: <xms:Q112ZMJhVikC1UrX3Mb_HLcgL_u4cRjw7_2N3_37WA8f1GdiBc0pnw>
    <xme:Q112ZMIHatiw5Vza07l_H3J8Q5Jo6SiJ0JklzDq2oVq19WcxL7-SLcq2Z6xIGOn9e
    WudhjdY1xw9uGw>
X-ME-Received: <xmr:Q112ZMvxVcJBiasn5UFXjTImzNzJJWI7pNevtYfQQmMTBB-b8IybX_PYolTn_jMKlOzP0fkNc-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:Q112ZJbB2ysOiize_ujypULuG_R3Cn4Yq-9hscSDMSK5ll_YW10Haw>
    <xmx:Q112ZDb1CeOkQsN1ioyuZQeKryd91axJ67ADAgGmg8uxAd6cVc2vzw>
    <xmx:Q112ZFCIOgBVdd0gvdQPehRl4EuciVdHt2_LQ9qvpSUR9DQCv8tXpQ>
    <xmx:Q112ZH4GTf0whc09NpBt8a1c0iKBwD4CvlewH7ytbqUM7jnZPa7ciw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:32:02 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 10/16] device-mapper: Refuse to create device named "control"
Date:   Tue, 30 May 2023 16:31:10 -0400
Message-Id: <20230530203116.2008-11-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typical userspace setups create a symlink under /dev/mapper with the
name of the device, but /dev/mapper/control is reserved for the control
device.  Therefore, trying to create such a device is almost certain to
be a userspace bug.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 52aa5505d23b2f3d9c0faf6e8a91b74cd7845581..9ae00e3c1a72c19575814cf473774835b364320b 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -771,7 +771,12 @@ static int get_target_version(struct file *filp, struct dm_ioctl *param, size_t
 static int check_name(const char *name)
 {
 	if (strchr(name, '/')) {
-		DMERR("invalid device name");
+		DMERR("device name cannot contain '/'");
+		return -EINVAL;
+	}
+
+	if (strcmp(name, DM_CONTROL_NODE) == 0) {
+		DMERR("device name cannot be \"%s\"", DM_CONTROL_NODE);
 		return -EINVAL;
 	}
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

