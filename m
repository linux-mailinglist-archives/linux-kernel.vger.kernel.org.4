Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F66A005E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjBWBBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:01:29 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E443478
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:01:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ECEC33200977;
        Wed, 22 Feb 2023 20:00:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Feb 2023 20:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1677114040; x=1677200440; bh=YeHa4BvVFU4eoWzbk5wqnLEbG
        zt1vzczq7IVwR8vJ9o=; b=XrKoCq/VX/mAZIwxnzIlSJr8dFaWeRvqrp7I7Tmrt
        fFcWf118NdoP4oG4GufGksnS3zJuiO3m3b5O3mgYMykSo8iz+3JT4ivKmycCscY/
        XpoyxCaOJXe4xjtAtfyRNc+1RiXwSEYpjYC53c3kRC2c9t3kLc6OcM8rESZkO+vY
        +bZGeoqPbCn1Xb27MYMkOI/1HaXlH+1E1pa5czNw8nHb0fDb3g5RLOqaIm/Xu1bT
        iv3IsLcrFonqNB5+YsR8NEyVyknTiCLTWDDT1OLOToezrDHZgulwG/OePsIaE/SL
        yTpz2tTRZwKY4kuwMng0vnoGFmzPEFxIs3IMJW8gqQNIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677114040; x=1677200440; bh=YeHa4BvVFU4eoWzbk5wqnLEbGzt1vzczq7I
        VwR8vJ9o=; b=rpIizh5jva+uCu7+2dPM9LdQOykDk0a6Tc+cBSBCwZedCbsJoS+
        Ud5xa42/vZch+4dZ8sBUkuRjmZq7eNHsgri60A/8j7wSq564J/SKoxNpj8iqCZtd
        DhsITT5g8U+7RsuYN7UfV+PvokwbacjG7hD90MCCXqxNfEWkt2jlVwTTW+KKUoDm
        ZqzScVgKFYQUUAIVXRZUBrrIupcZDSfcTUnSm+QDBxddZi/6zsq4wH6HZH+f6gD7
        CeuoIxiQepi1v5rAdQe5CFRY9pcnXKwkKkxyu4Ozb4N7FRkSzot0ntchJvDOCYAL
        pG/FRK+XhxrJsIgBYrB+vLAgozStGian/TQ==
X-ME-Sender: <xms:uLr2Y9U8S1XLyHfhumhV7HHyvBj2mLMzThlY-MI1zp8ao-sQpBMmTA>
    <xme:uLr2Y9lgAvwGutjPMOTeW7C1BXXZJuwVCH1n7CILrf2a_AQrDIMqxc0lKNKgr-6wf
    NW_8dyZNzKQ4yJv3PU>
X-ME-Received: <xmr:uLr2Y5aKct13BjqcRvaLTV6ueWv0XuHW_qT5q7STcMFTet_wqyy9j-ieR4G3UBgxOgU0EYJrsHcogzFyTBikKfumAYmq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgurgdr
    ihhoqeenucggtffrrghtthgvrhhnpeetkeehgfdukeejheegleefjedugeeiveevuedtud
    elgeduheeuleektedtvefftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhesvhgurgdrih
    ho
X-ME-Proxy: <xmx:uLr2YwUyc03JbzQ7QrFpPey9aLPSDRiidtdZT_IiUC-qvbJ2Ec5wmw>
    <xmx:uLr2Y3mO3Cc3o7iy841FT_g1TPXT001F4vIPtan5ZDZp1DyyBfpdPg>
    <xmx:uLr2Y9f7W-eYcr5I8jh-8jGTGu761hH7T2n5ZRccW6Y6vL_33QcJ0g>
    <xmx:uLr2Y_uY-vhsF2T0JslxTm_SnDgLmYdvosH463cwyKwtxDqq9vIB_A>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 20:00:39 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v6 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Date:   Wed, 22 Feb 2023 20:00:21 -0500
Message-Id: <20230223010025.11092-1-v@vda.io>
X-Mailer: git-send-email 2.39.2
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

Hi,

This is version 6 of the patch to add stdint.h to nolibc. Previous
versions of this patch are available here:

* v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
* v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
* v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
* v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
* v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/

This version integrates the feedback from Thomas, removing the limits
for ssize_t (not required by the standard) as well as multiple cosmetic
  issues.

Vincent.

Vincent Dagonneau (4):
  tools/nolibc: Adding stdint.h
  tools/nolibc: Adding integer types and integer limit macros
  tools/nolibc: Enlarging column width of tests
  tools/nolibc: Adds tests for the integer limits in stdint.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +-
 tools/include/nolibc/stdint.h                |  84 +++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 139 ++++++++++++-------
 4 files changed, 177 insertions(+), 65 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

-- 
2.39.1

