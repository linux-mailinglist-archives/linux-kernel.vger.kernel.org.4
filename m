Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8568C032
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjBFOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBFOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:34:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74F23DA0;
        Mon,  6 Feb 2023 06:34:31 -0800 (PST)
Date:   Mon, 06 Feb 2023 14:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675694070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lTvjL1KX8h96Jn3F5nqsbDVPXpo9oQm1PefgNz3vkhg=;
        b=3pAoti8WZuS7RgNMf/03XuCU8LDBBj+ZVV0/LlnthqbkLE+37wyHj4HUna/uNAkWN8D5X6
        e5sXlZPJxw5DuSlfT1q2ZJb3E8Ck3yY1s8j5x2r+zLhXhvYHhe1nih+rnvFGXPD7cH7gfL
        3WXrJL17xLsbbWJVZx8VLDYPfz788auv1Z0xHpxeheeW4BFFjgORFDq9V/j/GsFb9z7vHw
        vN+q8eFRA+KzDsQH7E03U8ZwQPpzpwydrjqUjYpnZhFxo3AWzWm2+PRzzioS++z5wfGMnB
        AgeZ3It8T20ieO63JsTY4TVU91f2gHVIfTRijZ1U3p2kv000ZLeQZvpbUaRLZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675694070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lTvjL1KX8h96Jn3F5nqsbDVPXpo9oQm1PefgNz3vkhg=;
        b=KxeRmhxV4cXHkmXmAxf7ZYrPuwQQ3VdmfPgzTK6bEdEQuijUASrPLCo0P6/GZCl2C0LnXG
        L2nGjQWYWIg8osBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] vduse: Remove include of rwlock.h
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167569407005.4906.11428635230479765759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b4863fa5b7dd50dab1b10abbed938efd203752f
Gitweb:        https://git.kernel.org/tip/3b4863fa5b7dd50dab1b10abbed938efd203752f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 26 Oct 2022 15:44:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 15:31:05 +01:00

vduse: Remove include of rwlock.h

rwlock.h should not be included directly. Instead linux/splinlock.h
should be included. Including it directly will break the RT build.

Remove the rwlock.h include.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

---
 drivers/vdpa/vdpa_user/iova_domain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 4e0e50e..173e979 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -14,7 +14,6 @@
 #include <linux/iova.h>
 #include <linux/dma-mapping.h>
 #include <linux/vhost_iotlb.h>
-#include <linux/rwlock.h>
 
 #define IOVA_START_PFN 1
 
