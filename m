Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD271F49C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjFAVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjFAVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D5196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:25:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B76685C01DE;
        Thu,  1 Jun 2023 17:25:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 17:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654721; x=1685741121; bh=ffgts7SPxx
        BHaUW6ToONfIVOqBLR5Qtq9BQQd24YCS0=; b=mFKpWD+bo1BnXnUNmn90TseJTH
        zB9LGzQOGIh2TdQeK8B4IUEUfDF0SktjtFEtA5ePrda1NpjZR/OWEegZq46Lc2Tx
        w9risN2HGDpnmYc0FyA5eRbK90QtjwceqjOTzLOBmnS8FnF2zVFRK4DHXMd7ogmG
        UaDAPC9L6iE5jRk6jbJqkMdISXqJ3p1Z5xQ5QbHrhAfAqK1TKi4xtoNKbY6ZTP/X
        PlHWYTzzhJmHy30vAlPWfRKK0lR7bPzTNe0v0ySH0lp7LqikNZJjRoqwlICptW75
        YuI858CCZgLiAOACOjRT3+WnM1DjUUxW24JwIrEKW4mmcAV+0jsjm3hOxc/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654721; x=
        1685741121; bh=ffgts7SPxxBHaUW6ToONfIVOqBLR5Qtq9BQQd24YCS0=; b=D
        v1sD4nspvJagskYKVDs0ENPh6b8ojw+Ac8rHiSgpnl84ZrmcOX0ABHdxZKeqipFd
        O3xTLaS0oR9pkOiX+6xywMA19bL4h84r+KiB3I5H/W8KCvoBVl8yKh2+PdtmGUm5
        TV5GbSRMChEqlOfoxStcaimCgk0LNFqDezwsrLD+g1J51Si/RONSDMAlvQS/Hqcj
        XUpUH1EvfgMnjPfkdXU5IIlpfNCarZJyz8DdCK6QmZvnWPodu/KW6i3NWJRD7vlF
        RhWNHYgOwNDsKkrskbgwLo4+lLypJvSTm0JLYsVxdgQRaR9uJvi0pr+gv7gSurQ/
        bDectfKORAJ6kZ+qVuoSw==
X-ME-Sender: <xms:wQx5ZFuzphTs7Mf6kVzezyo0oAj64GQtpbLQGHMpMVLYF6DCXDWNrA>
    <xme:wQx5ZOc7-BkWXwWzgkX1kVXEy3-vyBSbREXHrNgH8glSpKgnR6uHYOJ68f55fyq5d
    A8dwQvaMg914hY>
X-ME-Received: <xmr:wQx5ZIxj15bR5LK7MI-m5VC3cXdPFRME6LGEAo9nTJQ15PM954IrGdlcbd2VpF4JWgeviqm_Ros>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wQx5ZMOWGC-afaZhQHcdajjuImgpMyn5s6ZoTC6WXZNj_07HxQqudA>
    <xmx:wQx5ZF8n83a9UuFePX3cerLDbaAGmEDmGbgq_wpqsqQ3hWfYeAaXNA>
    <xmx:wQx5ZMW5YUl7XN7JEAN0gUSwBYHRKliX2z3R137bZl9WdE5NggvL2Q>
    <xmx:wQx5ZHIhUslJGYh885PUyEU_p38-gPj4kTqayCOTd--EBrOoTwY_EQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:21 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] device-mapper: Refuse to create device named "control"
Date:   Thu,  1 Jun 2023 17:24:54 -0400
Message-Id: <20230601212456.1533-6-demi@invisiblethingslab.com>
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

Typical userspace setups create a symlink under /dev/mapper with the
name of the device, but /dev/mapper/control is reserved for the control
device.  Therefore, trying to create such a device is almost certain to
be a userspace bug.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index fd46b249f6f856c49752063fc49d720e95df0525..b12592bcb4b2b8513f5da6208fb545203534d7ff 100644
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

