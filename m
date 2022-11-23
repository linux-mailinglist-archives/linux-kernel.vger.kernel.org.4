Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAF636CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKWWMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKWWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:11:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4EF102E5B;
        Wed, 23 Nov 2022 14:11:25 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:11:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669241483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhE4FYrmg0VsI1sDDZU3V9rADHXdsUtV/SXV0lKU7a0=;
        b=Aboj5SQA+3DO+LHbKuw45elnbeyatdfHTmk52D5VFPCZFFm2/9CKDi6WwHBvpJ4Y7Ha/6X
        w3ona43sqaqXATuCAVzxsGmHq6y9GkMXomRwUU51RtGMKnXJB6d3SBj2OtE7yaUcg26AGn
        lmijERfQMnmkG3RG5lFRuNEud2pvKEqOOeVfzvrSvzmGO/Japyi4Tt2IZUAiWDyBm+qQG+
        V7i5MxRKsF+oVkYF1+DSrzf20BBjkxz441bf+7xQOqyhgYGtvAJFw+94+te6u1y6abmkcX
        YYUk7sjQZ6v4T1n2HQi2shijkpl/NU/p5zV85E7ib9cHyrjVRtfXas+st3IKCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669241483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhE4FYrmg0VsI1sDDZU3V9rADHXdsUtV/SXV0lKU7a0=;
        b=B1KWG5cZY57pqE1wH+GjRYnAGF2DrNtpzmfr+KrrwTWj/g4TgbIwgUbhryN1B5YpNo170c
        HfjMX5zM8X2t7hAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/of: Remove linux/msi.h include
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221113202428.889624434@linutronix.de>
References: <20221113202428.889624434@linutronix.de>
MIME-Version: 1.0
Message-ID: <166924148193.4906.2643350724895787656.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d9dcb63677fcdf0a5a8cd3c138ab174cf1e9b871
Gitweb:        https://git.kernel.org/tip/d9dcb63677fcdf0a5a8cd3c138ab174cf1e9b871
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Nov 2022 21:34:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Nov 2022 23:07:38 +01:00

iommu/of: Remove linux/msi.h include

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20221113202428.889624434@linutronix.de

---
 drivers/iommu/of_iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5696314..00d98f0 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -9,7 +9,6 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
