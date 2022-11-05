Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF061DEFD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiKEVtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKEVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:48:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E6DEBB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:48:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8D843320034E;
        Sat,  5 Nov 2022 17:48:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 05 Nov 2022 17:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667684926; x=1667771326; bh=Zc
        G1ArcUeKGaZd5PrcG3/1gsyCRPoz0HrnVVRDFda8o=; b=lt1OxjWmL1nd76byHp
        +iLUkjYf1FXz50/TIKpxCQ32IFhvnOi/5U6n/6LITuWcWty1X17uEPFrIkgP4J0X
        +zdzkEkXl3zqra9oQR3jcHgXUa5d/5xkHDhie31xFsRbN0Xduv2mRh4HHpULzyzN
        nvXloCvUet97MqU/X+toReAG5kVJe3vTpfGOmpe1VoRmKYGraaXOmKXwphZJ4sBj
        ZJKHdyJ7dTnJK30Hclt3Im9/ouLr5oiZl/kDS/ewBmzzDzmKTe1zCpoioG3tikBj
        X9UwDv6xQ/IpFOuiF3F5j2sAih1p0dZ4kmP3qOQkWBiXdBzsiqd5vijbajDVJBhI
        Mx0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667684926; x=1667771326; bh=ZcG1ArcUeKGaZ
        d5PrcG3/1gsyCRPoz0HrnVVRDFda8o=; b=QxhX3TCnyL73D6/2ikOn311BWBU4F
        tyQcJAH7rIOr1ptw+OjFf5fdT8sZiNY42764LEbZIHxlLNfEr0fBw68M3a0k2y9P
        qlzX/A3NmkKqGnewHldOq0USkGFTCVwUbCrYEl6COC9/NKRnHDJ1wqNtzQIWKsrE
        tvhrjFfwb6cRRHyPlarOw2rL4TEdX7QfFW9MeM9I85BcXg3CLtt+IBY3YOIFap84
        qhe+C2gY3aK+tOsIW11JwELtlk2fSnxe7Td25r1HS/Q/zI6HdZmqxNjYnHIXJNPK
        8r4UwWO3ohG0tgHeYYY5KzzMynlsXo4x4a/TEEPEMYTQzJj2m2A3EzjSA==
X-ME-Sender: <xms:PdpmY-5ntTMtFqBmIGBaEk79l13MdpdExHtRHcvHWUZIbOEpL3tiig>
    <xme:PdpmY34w-3pBR_r4jKAwpDX1hPXZDcdH-UuC8aKc3gBY2Bqhinx6xCWYUQdOkVTns
    tuOB3Fphtw5pptWww>
X-ME-Received: <xmr:PdpmY9cxDfoH4ARnTbzUeyYVJAyMSI_0Wu2q9I6M9eHuZVF4nvc5DeX7p1aKQs56Zx-_Wb30mXiMNV4wz5SCbETIunICImfhlyQN1QGOReVa8OmzFW-EcS16S4KHOIU0n4lqEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:PdpmY7LOfPu2S4YI5ub_hCcQfLM3_CQA9gswMCv0oe__cp2KN-N5YQ>
    <xmx:PdpmYyKyM1oPh0EX0r80hHq9A_zeoUcwahFZt7ufGjWja7V9RTN2dA>
    <xmx:PdpmY8wATA4EgZv7_ejbw9K2ojSAPKmmA9uITfbuyKsQQ3-J5HCScw>
    <xmx:PtpmY0ihW6swwV1DoJD38swQqEVGMzQrvGkNwZP7tJB-G7NQxnNiCw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 17:48:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] kernel/reboot: Use the static sys-off handler for any priority
Date:   Sat,  5 Nov 2022 16:48:39 -0500
Message-Id: <20221105214841.7828-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221105214841.7828-1-samuel@sholland.org>
References: <20221105214841.7828-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 587b9bfe0668 ("kernel/reboot: Use static handler for
register_platform_power_off()") addded a statically-allocated handler
so register_sys_off_handler() could be called before the slab allocator
is available.

That behavior was limited to the SYS_OFF_PRIO_PLATFORM priority.
However, it is also required for handlers such as PSCI on ARM, which
needs to be registered at SYS_OFF_PRIO_FIRMWARE. Currently, this call
stack crashes:

  start_kernel()
    setup_arch()
      psci_dt_init()
        psci_0_2_init()
          register_sys_off_handler()
            kmem_cache_alloc()

Generalize the code to use the statically-allocated handler for the
first registration, regardless of priority. Check .sys_off_cb for
conflicts instead of .cb_data; some callbacks (e.g. firmware) do not
need any per-instance data, so .cb_data could be NULL.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 kernel/reboot.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..38c18d4f0a36 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -327,7 +327,7 @@ static int sys_off_notify(struct notifier_block *nb,
 	return handler->sys_off_cb(&data);
 }
 
-static struct sys_off_handler platform_sys_off_handler;
+static struct sys_off_handler early_sys_off_handler;
 
 static struct sys_off_handler *alloc_sys_off_handler(int priority)
 {
@@ -338,10 +338,8 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
 	 * Platforms like m68k can't allocate sys_off handler dynamically
 	 * at the early boot time because memory allocator isn't available yet.
 	 */
-	if (priority == SYS_OFF_PRIO_PLATFORM) {
-		handler = &platform_sys_off_handler;
-		if (handler->cb_data)
-			return ERR_PTR(-EBUSY);
+	if (!early_sys_off_handler.sys_off_cb) {
+		handler = &early_sys_off_handler;
 	} else {
 		if (system_state > SYSTEM_RUNNING)
 			flags = GFP_ATOMIC;
@@ -358,7 +356,7 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
 
 static void free_sys_off_handler(struct sys_off_handler *handler)
 {
-	if (handler == &platform_sys_off_handler)
+	if (handler == &early_sys_off_handler)
 		memset(handler, 0, sizeof(*handler));
 	else
 		kfree(handler);
-- 
2.37.3

