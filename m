Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4C7210A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjFCOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjFCOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BEE1A5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 07:53:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 441865C018B;
        Sat,  3 Jun 2023 10:53:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Jun 2023 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685804000; x=1685890400; bh=bzf2lzXwm0
        yOFyHlXVDw/mThYLsZ0cA++V3ZJ1NyFW4=; b=ksRwITENMjfZbLijYMBGgB4obj
        Z8jhiq5RyMTyd7FtGeuPdHhxAtTkH7l5FU2eduhrz+jaXKhExJPqken41iClDagx
        /7PSOKaEcQmI5VejX1xzh5ADEBtIvTSeXbx1mCm/ex5XmyMxM42zZpWJ0tC6pZWV
        /zdF1oq7J4H9ZfzPJntxkAz+Nw4dQVMf+ksDop/LjJ3QVO3ltqX6/l1QZAhOl52i
        FBDH5WCLAVL1VV/0/KXk69BSXntmkInEk+b399rZHodrvvvaNUBn5vXsiaWS/GCb
        qbAJ5FPdv3H3++kNYAhetFinoEgVgXzwbvTBShksM85uKgX34xQypXarAqbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685804000; x=
        1685890400; bh=bzf2lzXwm0yOFyHlXVDw/mThYLsZ0cA++V3ZJ1NyFW4=; b=m
        K3adYSf3veZMGbd7z2H9VE0Rk34pWAOoILfsPZfDA2b6VUwR8d9LPbjmKqGy28qW
        ItbDoXOIGdomPzzvdmYvQd4CFhjM+b7CHhkTSiH93L0a0yjKNkuyRzd/F1fX8x4H
        1w4/5i1PkAAcDBn8GIS1h+6RLk8uxdXocy4uIhNSi6bv3K0RpTM7uIXdi17WoZyz
        qQ0IpUTX009Yf9zi7PT21hI/jNqIvvowg+eyBOaAws4yu88kRPgOHA6cSJ+6CiD+
        x1umJG38gkBLKWuHuuFSFtAXGDIrPeIp2p6P4eCpYTsV0Kfw+jDwKutF14KgDHTj
        rg7zQo7uL44vEg8lM6WLQ==
X-ME-Sender: <xms:4FN7ZLebUufMRlHdmQH-4Xja5B9zOnfbmNv1b5o3buYKs3ywv90X8Q>
    <xme:4FN7ZBPTvDwBIKoCJ1jvK0v6lNxtMqK5DsRE5zsCWfXX1PBU-itza3LSus6OzniRk
    um2aI35OoS7GXQ>
X-ME-Received: <xmr:4FN7ZEhJ7YhboYEMcSRCWhqWfF9Hytw2MtibaXQM33bXWY5PG42Pbg7C0EMQwprElCxVGwo0_3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:4FN7ZM9PIsDUYxbvWf3AAYDZpgoz2-l9AuC4c0yaWnoFqL5ADRbUbg>
    <xmx:4FN7ZHu5Z_OZcaMfaR2iln71X6eEHkc97BlD6QGrIHDUGqQd6sLkXA>
    <xmx:4FN7ZLEXGfxYQ2sSCXTgTDTrt2YAFKSK3sry-18XBsWM07Lfah7pGw>
    <xmx:4FN7ZA5bJL37uMKTkZBOTVKC211Onl6n47AnWxjGkgb8YS0uE3IN0Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:19 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] device-mapper: Refuse to create device named "control"
Date:   Sat,  3 Jun 2023 10:52:43 -0400
Message-Id: <20230603145244.1538-6-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603145244.1538-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 7510afe237d979a5ee71afe87a20d49f631de1aa..5b647ab044e44b0c9d0961b5a336b41f50408f88 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -767,7 +767,12 @@ static int get_target_version(struct file *filp, struct dm_ioctl *param, size_t
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

