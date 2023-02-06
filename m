Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE668B3D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFBd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBFBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:33:28 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310915CAA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:33:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4454D5C0050;
        Sun,  5 Feb 2023 20:33:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 05 Feb 2023 20:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1675647204; x=1675733604; bh=X4OT9GWB6XA8BqBHx1AYHuoGq
        /gwYTA4mDpu+7XHvZg=; b=T0GXBCV7DjAA/cobCQa/czDtBvxkor1z0Vd+9c0Zb
        bIFYcW8xX8I3TXbznPK6yS/1/bOMjl96lON0kVOs4nygajetOWr40EaRlXQoSloR
        YPQnyNi28g/A6kaxy3uS1jjcmGBfCgR5yiztOMaJlmmRDyWQDm3thcXnMgMjEOMY
        jAtgboZd9jWb2gG09rpMdARyJefxCXNZGLc+tEi7ulcRlpe/eUZxCYteF0eSaVPC
        NNIbBQyLpIVE7KSb7SukQ0hmebDdij8tVUzaldDCaE5TpiuGJzu6UED4DecuU0Qa
        dOVvxDZ3HvfAQqZz0wBIYlDDdLTTkY297ucRU7NrfufBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1675647204; x=1675733604; bh=X4OT9GWB6XA8BqBHx1AYHuoGq/gwYTA4mDp
        u+7XHvZg=; b=Kh1wn1DgyCyjUDE5FspZuw9qrKRmlkBwNsyntLwOlpwMIohDc68
        YYJNTfAS4FGVf/Or92PRgO/0xj2yr5Aj467SUuLIddlgzOW7O6a3yvf+IteuGVVw
        dVxj3fOnhtWh/Tp42ljA+IbS3gkDBE4TvS6UPCc0T6wZKfzoNJVRb8/4Syy/kqeI
        tkvnD38QhQ1xZBwnFhKkSr5xAm3S4OncdiYWwMt7UKP84hCG5MRy30nFIMIajn4I
        x/vZiBa2F1Z3poXzsd2E3JzChj5DuITOymWwr/TwxlEyk6nLiWSSxIt+QCoXkhH5
        72Hg9sdtTgrdSlUKrbk5dkRX8CThRuEqKmg==
X-ME-Sender: <xms:41jgY4aT8FUbUubXGrZJkESNbXN3xjf7i8NAeASfE_JnRbWwFZYWaA>
    <xme:41jgYzZQdzd3Bkgzcy3wA8hDuv0ZEW5E4dHLq2sKGAJcu0-EYS_iHpD9UusnnHxKl
    cNuy6uYt7zMsX5wXCo>
X-ME-Received: <xmr:41jgYy8DBo2UexgmFd_LdOrwws3M02z31u6oritBzFnhTSO_wl2X_krKqdzkHedoE_kY23x7qMlhr9jeoYAel1Dfg2F1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeghedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgurgdr
    ihhoqeenucggtffrrghtthgvrhhnpeetkeehgfdukeejheegleefjedugeeiveevuedtud
    elgeduheeuleektedtvefftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhesvhgurgdrih
    ho
X-ME-Proxy: <xmx:41jgYyoBo2iMAYM2P30_asV5b2uUx4WwQJK93GWP6-AmpTjomJIAuQ>
    <xmx:41jgYzr_brsU773zBgRflq46qS-Yk8wa_P6Zm7ytOp4-xR2vZRk7nQ>
    <xmx:41jgYwRk753AAZ7ozhfGGgHuSwJh5Z_yG5vfsMLtWtIRsdWJOjPxJA>
    <xmx:5FjgY8BHJRfSROdAY2GjZn5vwkenP0CHMYPnLMJCW9GwCBZhP1mLNg>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Feb 2023 20:33:22 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v3 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Date:   Sun,  5 Feb 2023 20:32:45 -0500
Message-Id: <20230206013248.471664-1-v@vda.io>
X-Mailer: git-send-email 2.39.1
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

Hi,

This is version 3 of my patch to add stdint.h to nolibc. Previous
versions of this patch are available here:

* v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
* v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/

This version should address most of the concerns raised by Willy on the
previous version (missing LL, ULL suffixes, uintptr/size_max size).

I tested it successfully on x86_64 and arm64 (on qemu). I have some
trouble setting up my cross compilation chain for i386, arm and mips
however.

Vincent Dagonneau (4):
  tools/nolibc: Adding stdint.h
  tools/nolibc: Adding integer types and integer limit macros
  tools/nolibc: Enlarging column width of tests
  tools/nolibc: Adding tests for the integer limits in stdint.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +--
 tools/include/nolibc/stdint.h                |  84 ++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 135 ++++++++++++-------
 4 files changed, 173 insertions(+), 65 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

-- 
2.39.1

