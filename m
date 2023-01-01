Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AEA65AAF4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjAASRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAASRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:17:24 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D92AFD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:17:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D4DBF5C002F;
        Sun,  1 Jan 2023 13:17:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Jan 2023 13:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672597039; x=1672683439; bh=hv
        kPrr/ZBNzTZaPvAZqJb8WYe/S8XnUo9LM54WyjUhs=; b=faR80+YKxD7OBgqVfS
        GBWa1BvGuSV6B8ExirQNn27xe2gal16pNpGEgUjS22yAUQGhEBa3qQWVg4GYIJJU
        AiS9PKe4GrU++FSe1nSZWWqbMR6ZmdoIMGieoljSG4FjXOaWBuMk9FUaYl3Bhc2V
        PLscU0ydkDPmse2p6DX5ukW+i1QoKc2R+ZGlaZr+W/7cY6+uwVVs6NWR55GzSfWU
        Me459g7vOiaS+8bBk4yNqRju44/xhaGR9oTCP8mF47kIb7p3uBpKLgtUv3XhlpzK
        6s9mlIxCvp5zarhvnTe2ebw/CoYO7ZmryRiWOrnNIVHRHYlIx5fX2bvFdgP7toPM
        9OHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672597039; x=1672683439; bh=hvkPrr/ZBNzTZ
        aPvAZqJb8WYe/S8XnUo9LM54WyjUhs=; b=OfZwvdM/YIE2s+Lc5c3u3DmUlD8jI
        5CbVZKrgVeynAkzMfxw2nRN3uKTpVs8FX8FJqDMhDcQgj1/BcZabK6+FlTRH13KQ
        2aCXyuUtBbO9/4RF5RbOn5EXdC0TOTcQENCNmwGnEGL80D/EOIXkkGsPL/dolAP/
        WtPzqUhEBwgbM+lAcd4NxTwzmGRVikN4gyhNZXFkMab/zUwNIQWA/dvhm9zi5BQl
        IUELh9ZIuBCDjTHPDzy/++W+JoqExea/8z4RbQ9hT17FOJYXs8jfUIDbBaz+9gVv
        H/APnztMrdWhGQYCbkeiDOuok8J3O8YM7j42p4iTX5HOxVXe8BxuiVa0g==
X-ME-Sender: <xms:L86xY2Dw5jbcnl7mI6RB1vUMFZKApB-0zYUx6BtyHNqmIgUg_kEzzw>
    <xme:L86xYwi1wPw8qBTrTAiaw4Ett6L8sheU4ARJp5VQcbJ9V0klBFKlhR5KXUNk8VkjQ
    qWfiK_pjBe5clr6WA>
X-ME-Received: <xmr:L86xY5mccovdYGvzJdRSVYzaR2nTHxdteHwz2Fkw-RwD2-t28aMQKd2Pr7NdnwzHMeFhwJwibIV5f-k95f22pKJtreuV_RGoRFZguiKEa3CIRA-H83_50Cfks2KedID9s6uCQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:L86xY0yPbaje1rcdSIxdm8d4JijfwW2JRG1-xbetbqTntr04sBm-Ng>
    <xmx:L86xY7QPuGOFJC_eZ8z3Dufjh0aE9yYYKTYFENR55-C0iVaN_wcJgw>
    <xmx:L86xY_YDUeZg7CSIH-92rE-VMqXQK2XVO_dxQ0_qZOvG8_hZbn0l-w>
    <xmx:L86xY6IeS5R1J8IAigzbxeyiz5GrwYA5qRgqty0_Vx2iWks9b69Ljg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:17:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v2 1/2] kernel/reboot: Use the static sys-off handler for any priority
Date:   Sun,  1 Jan 2023 12:17:14 -0600
Message-Id: <20230101181715.42199-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230101181715.42199-1-samuel@sholland.org>
References: <20230101181715.42199-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
 - Update commit messages

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

