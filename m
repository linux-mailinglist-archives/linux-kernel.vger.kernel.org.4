Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA26580FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiL1QXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiL1QVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:21:25 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510701B794
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:19:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 85F6D5C018E;
        Wed, 28 Dec 2022 11:19:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 11:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672244360; x=1672330760; bh=+U
        8N0UmTlYd9YC+LHaZbBbMVD4CfYomec3Duaw8K1K0=; b=zr7fbQXW2nEGBaEc4T
        INBtGnH6KEP1UgaieU+aZQgiU7aex0jvJZ0hgkFNPQgPnGSGz+BS0aRbXoHxRiT4
        6H4yZd4xNTWGevCjZAZI6VU1kZpJdCpqYl2w4409kmFiqPGz8BM/SxKDmUQTqcaJ
        yVoXJyocG2vIcB8uwuobV8E/tHIkFFDkFQSW+IPlb90zDVUquNiGSUUFeDesMf9B
        2YzihJ/Q6yBVKk6oJD+U/89eg4X/mQLNYxsUPf5sZAhBIYcCcojHxGxJuQD6JJPU
        qLuT6uOM6fSzkL+B021ISwz3y/ey4FRgx/EKS2uiaC009Pqo6zgH0JgQUpyogB4U
        3Q8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672244360; x=1672330760; bh=+U8N0UmTlYd9Y
        C+LHaZbBbMVD4CfYomec3Duaw8K1K0=; b=LHKENN4HaAl9eTzGJzlvlQQpxNiLw
        iL6iM4q8xbb93azfif+ouJbTwpUljNqJKRjm4A/vC8brr0ZuAxt8ShwIWx82v+zq
        IyZ7s9L+YoBix7xe3GSigT0lOs/kN+nSuN4Xl9ElTA4MQco4MtwjwbrzRHlfxaIk
        PH5BgqZP8fWpQ0AhynLvv6xEV5bm7A7ON7moOTSnAMFF9bSX721CQdBwMS55TmU4
        Ya04Rq8J3mCLr3I4znNAahnK+TXBMqKIQprlphidStUGpfop7F8fkulJUY9fKEoQ
        NBNlM1qDxAr4Q6tv1/mU3No71LrlJHkF3AKsZceWe9ptexc5zc5n98NDw==
X-ME-Sender: <xms:iGysY0guii7cQfF3e2W_lRxmUExyUnzANv7WpecgE_V6PXRhEBE3-w>
    <xme:iGysY9CAwFhrx-LblKgItSvPDJurlJRPedCt32q6Na7mhNkVC2QbK3taWaYTrc_N1
    XmbSE1yi3VFO5naFw>
X-ME-Received: <xmr:iGysY8EQ0tSzJ9YzTNkvQsT_jg3CD6GkFW6sYtmGocEeiuxv3VqITuOBOvHH1Jqmbr2A7Dx2WM6dWpW0VQzzFV0eJckM6IZZmgXr2B9CI-io4-g9oYxMiw81poqa9eKjmmRzig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:iGysY1T0TW22FduipxSaawhlvwDpX67u9VymKmdZR035lCkXHzO86w>
    <xmx:iGysYxxEaOW5xKb8sJ6kkMOvKqkT_aNQffn5_4kt561AGRg0ykB2DA>
    <xmx:iGysYz7ETO1Ke2PXq2Uy55OipoQXUr4zYO-uD5-5G_Qr5ACmte34-g>
    <xmx:iGysY-id7cP476eOi3xrJGeEeUTYklhs93sfPvleQUlhLpvHpp5SuQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 11:19:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 1/3] kernel/reboot: Use the static sys-off handler for any priority
Date:   Wed, 28 Dec 2022 10:19:13 -0600
Message-Id: <20221228161915.13194-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221228161915.13194-1-samuel@sholland.org>
References: <20221228161915.13194-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
However, it is also required for handlers such as PSCI on ARM and SBI on
RISC-V, which should be registered at SYS_OFF_PRIO_FIRMWARE. Currently,
this call stack crashes:

  start_kernel()
    setup_arch()
      psci_dt_init()
        psci_0_2_init()
          register_sys_off_handler()
            kmem_cache_alloc()

Generalize the code to use the statically-allocated handler for the
first registration, regardless of priority. Check .sys_off_cb for
conflicts instead of .cb_data; some callbacks (e.g. firmware drivers)
do not need any per-instance data, so .cb_data could be NULL.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
2.37.4

