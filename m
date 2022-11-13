Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC0627280
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiKMUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiKMUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:33:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A8B87C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:33:57 -0800 (PST)
Message-ID: <20221113202428.312137892@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vMcbkOsI7zhBRENyqdYaxGJtTm5add2jLySmQi7aSgs=;
        b=B74oW/OOJ7fj1CNm7SphJbAi8TEiMtPdl+rzbegi+PkCblBuU/4AToA8SWVkGCaUIeBmwa
        K4zl6D1eL5SY+Ja8Ggwe0XBHyKx4wnUV+gq6dtLAEucOHAIlE/rQZ0S1TCBv85TF/47o6q
        j9w2XTEANl71wGZWX3AVUE+gvstBaxabik9pfXLA+Kf6PmWw4Dx8c4NKLydApWlhQi9Ocu
        RODg690fAhgQZhziW0wN8JXhWqxRDmvD5zCeos44i4lLWQKZt3re+h378RvZM9k66Z/jxF
        hAvFH0lDbXfx48uHrZ3clhC0KsY6ML/dDka5Gx+0+avgYRifR+VzH9Q09bOeww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vMcbkOsI7zhBRENyqdYaxGJtTm5add2jLySmQi7aSgs=;
        b=plB3yfTPnTHibRCxWAlpnhkjuMJnRwtSZ5e4D+BMaMIzYULCbV/c+wZtXhDN1YPQL4h4Mm
        eiQRXSPLourPetCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Lee Jones <lee@kernel.org>
Subject: [patch 01/10] mfd: timberdale: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:33:56 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/timberdale.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/msi.h>
 #include <linux/mfd/core.h>
 #include <linux/slab.h>
 

