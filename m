Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE46EC06B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDWOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:35:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D9FF;
        Sun, 23 Apr 2023 07:35:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 869DF32008C0;
        Sun, 23 Apr 2023 10:35:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 23 Apr 2023 10:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1682260552; x=1682346952; bh=PAr4ZIboJa
        MJHdcJfTxs+nnLe/T7fzo0XDxOaHgRyXc=; b=jELwyHghNtdBQkMRWXrbT7Pi85
        SekQsOSnG0U4zaTXXArDVkRWgSgqG71E/yRCZufo9K6Htzj9QUA7KDCC+qYwI6p6
        /HJAKNzXzZLA6NWdLkmDfj8ZqimxCWS9D2iWVSlUCJ5r9XA3WjQ1/h2xIxXi0itc
        zO0rhDub8Y8WlwgYZIN/f9F792PSz+MgzqDoIp9T0yWkvnkDngY1E3piiKy/Xz9V
        o/rtjWuWjyB23palsPzR3QWTdXOfCuEO4eNkpRwOKoVS9wTCzsHr/f2kPq9DQTL4
        ONkhrtgYO7RhAQame0E5XzmNWyOPKQxqfP+xpOGiPjKJtMH5cYTh37CMo3Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682260552; x=1682346952; bh=PAr4ZIboJaMJH
        dcJfTxs+nnLe/T7fzo0XDxOaHgRyXc=; b=GVR0AE//fuvQZurX4qScKH9S8wlFd
        3Bk1pjj0b3d29JhfD3xMrTg5bY12VmqSmk62zxyljkgk6LB70r3jkWmTi/o1fYWo
        8BHTyT1png2MgBgcrgP0wvJcLr8jZwhXjP4nlc/TbSHXox2gOzLtOo6SEAnCzOE7
        QUrpMWZayAEMbShoeNAZWtRuJkqwTrr13UhJA119GJPSlFQAHhau3ba6eAJFGWDa
        JlZT77/wK877WOLnqv7ybSLG/gSwSiNS/k0ZVKEoRu6EgkPa4UINbyk3P/Mou6mw
        ldUPYD+YTCEE5NMNha7TY2ZVbriezfMuIeCdBzfiVHJKlolt3bOHe0QZg==
X-ME-Sender: <xms:R0JFZP5McjHkG02elBuK4R3cdnp10UAc2fTEXC3TO8MFdB1HJZbjiQ>
    <xme:R0JFZE4Y9URdImaDNkIis_DnZzizHQhnKD9eIfP-EP02sHnauAdeDytjkacPLIhey
    9eflFD8N5SRoI80hMM>
X-ME-Received: <xmr:R0JFZGfFeZOs8RJIopBuNsC7Ub5p74Eov2WbP8kBaBSk7I5DnU5F8r8VcZlK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtkedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:R0JFZAIDC8SGw8EhhWmMfhPFrAmY055IwQUFA9jd6r85lXHWLXaJfw>
    <xmx:R0JFZDLYfxsPJel5rzSaVJaV-ZjDrcn5zbhmbKgbS7gDkKDq4Hr3pg>
    <xmx:R0JFZJyVqryL6S9ldbDJI4bTApa731sJ7Yq9vnh-xJTjWy1UjRClOw>
    <xmx:SEJFZKX5xvwKBK0CrjXCO7V5YpIkKQhZYo9QEXdiD8bqBzOFieXoug>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Apr 2023 10:35:50 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: Remove unused variable in arch_local_irq_restore
Date:   Sun, 23 Apr 2023 15:35:45 +0100
Message-Id: <20230423143545.32487-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was left over in 9efe1ad6f24a ("MIPS: Don't play with fire in
DIEI irq_restore").

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/irqflags.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 3357bce75c69..b79269789c71 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -59,8 +59,6 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	unsigned long __tmp1;
-
 	if (likely(flags)) {
 		__asm__ __volatile__(
 		"	.set	push						\n"
-- 
2.39.2 (Apple Git-143)

