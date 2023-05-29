Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7D714B14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjE2NyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjE2Nx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:53:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9958133;
        Mon, 29 May 2023 06:52:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C5A45C0127;
        Mon, 29 May 2023 09:52:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 May 2023 09:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685368376; x=
        1685454776; bh=xV14FPf2+WbyBcB20DB/FPJ/yAOl9xyxITkMtr//G28=; b=i
        +tDjU4KfJtTlhGqxRujTHO4egfkBEwzCgYnX3P8sQojPZ0q784ue3Zd1PRT309c4
        ww9zm0qlFJk0T4KZ7rnlzVJxYRDbEBtAaKjkCyzC4M+uWJ5/Y+K4vVIR7EcYlxeX
        iy1GXudY4qPnwBhOrVP6RHNfeQiPp3bR4A44weZV+KIj4YQYWCiN4mFa+22WPB+e
        zumlA8go+KvUl1RBBy2oLVlz+IVHgckw7lr11HZSxq6kTktgr//rS5D7Z22Ikorf
        mj1fIbZ+8uV1EUEMii98NXoVF4Xj8tvg0JCw3ftiyphczj64+ddqfGhqnw89rJfx
        YDMtd50Aqt6lJzuyAop8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685368376; x=
        1685454776; bh=xV14FPf2+WbyBcB20DB/FPJ/yAOl9xyxITkMtr//G28=; b=H
        oG4od1yu9k6kRTfpWyDpC7Xc4p4nDKcrRs0illbHpT/rezuRcb8QmBgf5tN0Fgs1
        KkcXZbvqf2GteoD32cS7z7JVTfP/S9m8FEtZzbYvPEzBJEXxubYTTxiJ+0mget4b
        m4qCnuhal9+QjkrTgFiEH9BInp+sWx1/BmdvDnXNcYXEw3E5Hb4mycV3Uvw/JcUO
        S9wSWcj07bLApxXzrziC3f+i+AQx0O24ItN6OShv+wQhY/gvGSDFxd2lzzHiI/Km
        9uCnjYb9qGm/iDuTHbYHODeR+RCrA0cg9yfU6ncFeDhQIToV04YBuOI8y20zNGd6
        WXYJFJIJPfsCK8I3p2DWQ==
X-ME-Sender: <xms:OK50ZAUGL07u8YxTlJMHBew1hMu8jFjV8Y4ktc66yW3_ivakvLY_KQ>
    <xme:OK50ZEkqALSORBjXoLJHKv-bEpIIrCDExM62DgMhBn_VJaf-RnN3K7r_z_iIohCex
    74zG48Rveq8hKgifgg>
X-ME-Received: <xmr:OK50ZEbvuwoBIfNd_pE77q2h9pcAqEYGi93gwxse01lU8Z6GfUVDdVnOgsj_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:OK50ZPUwafhP8LTGkNR99JyAR78bL_DOVnVLlb2Vmrf7qwHjeRRAAA>
    <xmx:OK50ZKm65RqaijgtzfdITRYvxRmfc8QRTmNM4vlOYEgAJuXSSRCcBQ>
    <xmx:OK50ZEfsNvzMXYrl7JO0GqenOXAgiw7CFZEHwYqmc4MF57uwj72bBg>
    <xmx:OK50ZPwTxNR6gKJHLAe_tAfG1cJVV6T1AdN9-9JNNEYkhhanNIH93A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 09:52:55 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] MIPS: generic: Allow R5 CPUs to be selected
Date:   Mon, 29 May 2023 14:52:45 +0100
Message-Id: <20230529135245.4085-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we do have P5600 bitfile for boston board, we should
allow generic kernel to be compiled for R5 CPUs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e437bf43ecfc..215fcdc059d2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -154,9 +154,11 @@ config MIPS_GENERIC_KERNEL
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R5
 	select SYS_HAS_CPU_MIPS32_R6
 	select SYS_HAS_CPU_MIPS64_R1
 	select SYS_HAS_CPU_MIPS64_R2
+	select SYS_HAS_CPU_MIPS64_R5
 	select SYS_HAS_CPU_MIPS64_R6
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
-- 
2.39.2 (Apple Git-143)

