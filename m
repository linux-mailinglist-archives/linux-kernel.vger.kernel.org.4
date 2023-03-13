Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145776B7934
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCMNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:41:43 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372E61888
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:41:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0A042320083A;
        Mon, 13 Mar 2023 09:41:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Mar 2023 09:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678714899; x=1678801299; bh=mDBHXJHbLHY4OkAvYL2dWBthdlcWZEvbZj2
        obyGBERA=; b=h4rtboW2Qrvw9tx98u0N9eZvysQD8t2hlWNmlJYvlJwmmlszFk7
        sk8YVcqEQnNe8ZB8OwRSk02GWF/OuZE2VLTqLEzVWR4RC0Wq3EKaoHxIwmCxjPZ4
        ycraHBQVYYyhrlPN2/pFa2o9K2hoVFJ83i3PGCF750q1L28zei6WPRVU7/35Kash
        UMQjpbTLuFuFPwKmZxpIzTWPdmNa19tjFTKpJcfeH+y+e9uTn6CCj6dCX0QBATz+
        fnJiRcHQsogwl8UUO8Ws6DtBuhAVLJ9CqLRiUOD8eliyc4II3hbKAFuxq/WRbV+V
        LxHnkbFDEdissZErFHFr9yuCtGOj5o7109w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678714899; x=1678801299; bh=mDBHXJHbLHY4O
        kAvYL2dWBthdlcWZEvbZj2obyGBERA=; b=ow5lf4b+A2bNELk85JSd3TD+fwwAQ
        mJ20c1tUdJKORCwxQGcr7rwbdF2UKZcFTNVsSIO3wkRSuVM6vAwLsgu/o74QonXz
        wSuvnGJYMCPvyMnRFzJAOZpFy71rOt3PXC5xLc6vNcMQlE/sWF1/+kyqYFP3HA+/
        FcRY2CR2NzFI6Q5jRVT3C9txmuBfigFWGHS8m56iilmhymX8Uena+AJ8JRidJ6Xm
        dG65pH/DohxT6cHgb8Zx1CJwghhnYeLuMQQZg0ghAVLPImdc1AweqP8d8LjiJSTe
        JBtqemCaEy5cTpcFHdCbN5j9OawO5phl+5l9yCo8rnJdJkDAMJbApOPAw==
X-ME-Sender: <xms:EygPZKFb6VkB4EhsbfkD8maRG5Q0iJDRCje08yoGOjG6iAkhdxnlPQ>
    <xme:EygPZLXFEE9ZwS0OZmNfM-cC8nvHZQxwsoKgZXLwCrlLFIX9v9URqJy_JOfEcd8um
    vwlG3QCUW2sHu4>
X-ME-Received: <xmr:EygPZEIkAewDbmtsbJFH_HRPyXAspbkmrq81hC_c_RboaBi2s2iOpYZoSdinJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhimhhonhcu
    ifgrihhsvghruceoshhimhhonhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeuveehgedtfeegfeduvdefudeuudffffffjeevueeg
    fedufeeiudegudegvedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhimhhonhesihhn
    vhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:EygPZEEoy3Brpi1rYkHthEijJBxr3iXh1M7BFqlH6QYW-Spu6BanSQ>
    <xmx:EygPZAVO2kLPGBQyf4KbfnaY2D2Kk6f9fYdht02Uc7HRP_PFTfKiSw>
    <xmx:EygPZHNSjlxhk2BNyAbfmr6xSH7WzpW5onUVdcE59kMi6_NHh2hGYw>
    <xmx:EygPZHRz1ZAnBarJ25rSyZ_FYmivSx3V7W2b_gYXchRmxccWWHOEmg>
Feedback-ID: idc5945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Mar 2023 09:41:33 -0400 (EDT)
From:   Simon Gaiser <simon@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Simon Gaiser <simon@invisiblethingslab.com>
Subject: [PATCH] xen/events: Add wakeup support to xen-pirq
Date:   Mon, 13 Mar 2023 14:41:02 +0100
Message-Id: <20230313134102.3157-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows entering and exiting s2idle. Actual S0ix residency is
another topic [1].

Without this the ACPI code currently ignores the error enable_irq_wake()
returns when being used on a xen-pirq and the system goes to idle for
ever since the wakeup IRQ doesn't gets enabled. With [2] the error is
handled and the system refuses to go to s2idle.

Link: https://lore.kernel.org/xen-devel/9051e484-b128-715a-9253-48af8e47bb9d@invisiblethingslab.com/ # [1]
Link: https://lore.kernel.org/linux-acpi/20230313125344.2893-1-simon@invisiblethingslab.com/ # [2]
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---

While I think that the set of flags I set is correct, I'm not familiar
with that code, so please pay special attention during review if they
are actually correct for xen-pirq.

 drivers/xen/events/events_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd452..991082f04f05 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2176,6 +2176,10 @@ static struct irq_chip xen_pirq_chip __read_mostly = {
 	.irq_set_affinity	= set_affinity_irq,
 
 	.irq_retrigger		= retrigger_dynirq,
+
+	.flags                  = IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static struct irq_chip xen_percpu_chip __read_mostly = {
-- 
2.39.2

