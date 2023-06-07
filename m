Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222E7253B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjFGFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjFGFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:51:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70FD19AE;
        Tue,  6 Jun 2023 22:51:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75D625C00F4;
        Wed,  7 Jun 2023 01:51:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Jun 2023 01:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1686117095; x=1686203495; bh=9J3jSJCpCm
        e7RWOMozMLBOk4sbRbtGFt1bbFVlTtxFk=; b=kdnVMEecRHur8SDhGvc+AiUcbg
        6CuVzaBhbaNYKkiifHiwJNEbY5kihWpZl1VWrcEDu8N/gfiEg0XjiXm+sAjXF+7S
        VPnwEW9BE7XHaUQbsc7tIq5KMjqOokn3lK4oOw8s76F/y3lhIqHj/aAUEGPPYUuT
        kOH5APim2c2JTV7QT5BzLoleXc/kqNY8lwfHsgtc4qRlfBmCzBbZnCGJ3GsSyEMY
        snwI7JvWcWKb++b0ieyobp5M/a8BqP2dcb41VbFGWJC2KGCO5tE0P2K7waoc6F43
        t1Sf/iFNwJpAfVQF3ihf5nE3VTZ/FOHvKQ9/0u3odAVyLQj/rtO+deJaU0aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686117095; x=1686203495; bh=9J3jSJCpCme7R
        WOMozMLBOk4sbRbtGFt1bbFVlTtxFk=; b=i2Q1rVLIXtuggKOMpQcpxyd7GqQba
        2O02gfhAPuIrLKS3NkS9AFyBScx6y9+y9eEg1BmPVb/AXizwNu3kMV+DAVvktK53
        Sdn2+nMDrLSEYpd2PFDBi0cls5an1pfnRFOyxrfSj7Han0g51iqCsGGwry51xxok
        2T4fwiFR60bAapvuZrwIbBZjRSbmOUJHMCJu0vbYyU/g9l4fEs4cDBDJ3B1+oLit
        m6ANgb4o0J9p05VmC3IqPJVp2gM1LE5iADN41nRv1+jQEuDoPB5edEgJu+1jZuZr
        EK1RYfpURBCtdLxSiUQhJjxiw+S+v1teCH7+nf6MbMdDT+W8s5nRw/0VA==
X-ME-Sender: <xms:5xqAZHajrbiuCOGbjxyaYFDJnnBBsyEqy8dUXXmRurjkKuuuhPCmpw>
    <xme:5xqAZGa5iO_mGT1ztIACayCeGDwAVKJH_6_Rv-VajB3a1BsHdw2WvErNbgOtHuOpv
    VgE-XSDaFTANzqB0p0>
X-ME-Received: <xmr:5xqAZJ_sMCncJAjssRqbkqVH6a2DV1p4WnBZ7_J8AvHwqf5t_waXFypCuyLVAvwHbyI5wULi6vKgUEEPWUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:5xqAZNoF48f3aQ12CfAfUDgLKp1sNbyR-B1YtYk0VdzE3FUilyXkHQ>
    <xmx:5xqAZCoeJ8Dz0MotdtrIJ_7tlMZRx_KQfBGAbTGqxqdqh-TG1pr2CA>
    <xmx:5xqAZDQwYLEenM7677LCcEujenSvzEmz-MgiEDuEUNjWkBwuLuDctw>
    <xmx:5xqAZFXogsRNHLkTuKry7ZJG_AalLaASvhq-ahBPmtXxEQqsKQXcXQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 01:51:32 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: cpu-features: Use boot_cpu_type for CPU type based features
Date:   Wed,  7 Jun 2023 13:51:22 +0800
Message-Id: <20230607055122.26175-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CPU feature macros were using current_cpu_type to mark feature
availability.

However current_cpu_type will use smp_processor_id, which is prohibited
under preemptable context.

Since those features are all uniform on all CPUs in a SMP system, use
boot_cpu_type instead of current_cpu_type to fix preemptable kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/cpu-features.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 2a0b90077b50..8c6d4a87db37 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -125,7 +125,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_CAVIUM_OCTEON:						\
 	case CPU_CAVIUM_OCTEON_PLUS:					\
 	case CPU_CAVIUM_OCTEON2:					\
@@ -373,7 +373,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_M14KC:							\
 	case CPU_74K:							\
 	case CPU_1074K:							\
-- 
2.39.2 (Apple Git-143)

