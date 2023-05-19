Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FF709CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjESQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjESQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:48:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D31998;
        Fri, 19 May 2023 09:48:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B29B532004ED;
        Fri, 19 May 2023 12:48:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 19 May 2023 12:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1684514891; x=1684601291; bh=uzXVcwMzPn
        337OiZ69IXbCexOkREs2VnsmCqgff2c4M=; b=rzRFwQtAi3RuWhL4UmunoMXNaS
        M5O0cEAUGM5j+jpdJJ1hadON7OKZbh+Cyj1dVGTjFqXeRBkKydIggfLrZJCnlt1x
        +eIPFJlUjSICiVBC0JHiFDhW/vqFIvwwl0nX+mCVU/K0YqZbkWPgaErIkbkjWeTb
        ft27akKKDoyJthuxtlBD/1dBz1p0+Hoo+XotiyhFybvRGvyV1zhbSkp0WutJ7Iwm
        /xFXeZNSQanFzsU6WQfPgOaIMh+K2zlNeaSnFxedmkboMx0EdrYZOfQtccSkIavG
        v2Fi2MMK4fjJg5oWNb+GHSJB6wOTa94glrRPBeNJHpBv6BNeTxf4FqfXrMOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684514891; x=1684601291; bh=uzXVcwMzPn337
        OiZ69IXbCexOkREs2VnsmCqgff2c4M=; b=AmXeONaJ+w28DKuVsAa5u+rhVRGHM
        SdC8sVTuCNXMNbOsQpChw9V0K8K8HuemcTKvmfnmRcR4PCa+U+SVJg4LjRpvBxPo
        83G9isbsvE3wBlnNLa7EhoVw+wZJZ2ajYej0uuLP9H5ZWbL08RvudFPwoI4aon8C
        AeJAggONgENLtZ7F3JzRGjkP5I7nYTzzJg2LavSSsgeNVAlGbxx2NC+eS5wCfq7o
        NXXV6Ecz2Tc7/DRIqsuZ8T7gyYCo/9GvAa096AJOkW0ksW0IrABtmhNedv9Zo3h3
        TzLnU8sOxFnkj2UudFRFWhwXL5b20isbSpWomhmkr+kozIki9As+dQT3A==
X-ME-Sender: <xms:S6hnZKdX1ERu1hmFU-nPLxj_3lgmk_arisPfvqgU4_9HAE-VchSsJw>
    <xme:S6hnZEN4E_0iN2bUCxQ35-4G0OxIwFpoGHDlanlJGq8blmynOs16r2_iQXoQAy54F
    DmEBuKMK_NtTmWj3S8>
X-ME-Received: <xmr:S6hnZLi-ei597fYONIw403Fz_AUUYOvuRHIw8ldgbA6854lsSZxBNR7XC3x7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedutdduveeileejje
    etffehueejudehgfffjeduhfeuleeludfffefgffevkeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:S6hnZH_wH7j9gI5kb1jVwSUoM20c9UqCtrIS-EaP0sRXl1iSUMO83g>
    <xmx:S6hnZGtEAyt4Vc-7sMGKSb0pv8UCxu-BepzWmPFgLHGOoc3RiAn0-A>
    <xmx:S6hnZOHfZp1HvuPEa-K9LSWyrx1JoVXeZ7l4PvaSoZaw-lSIFScO8g>
    <xmx:S6hnZP5TLKjQveT4fAGKjO83Ii6HFtnAgYq4M8v9f-_0cQiRgsVn_Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 12:48:10 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] MIPS: Enable ARCH_SUPPORTS_ATOMIC_RMW 
Date:   Fri, 19 May 2023 17:47:50 +0100
Message-Id: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series enables ARCH_SUPPORTS_ATOMIC_RMW for MIPS.
The first two patches are for making LLSC availability information
available to Kconfig, and the last one selects the actual option.

Please review.

Thanks
- Jiaxun

Jiaxun Yang (3):
  MIPS: Introduce WAR_4KC_LLSC config option
  MIPS: Introduce config options for LLSC availability
  MIPS: Select ARCH_SUPPORTS_ATOMIC_RMW when possible

 arch/mips/Kconfig                             | 27 +++++++++++++++++++
 arch/mips/include/asm/cpu-features.h          |  7 ++++-
 arch/mips/include/asm/cpu.h                   |  1 +
 .../asm/mach-ath25/cpu-feature-overrides.h    |  2 +-
 arch/mips/kernel/cpu-probe.c                  |  7 +++++
 5 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.39.2 (Apple Git-143)

