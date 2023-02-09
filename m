Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF168FD32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjBIClM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjBIClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:41:10 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0E1C5BF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:41:05 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id ADB3C3200681;
        Wed,  8 Feb 2023 21:41:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Feb 2023 21:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1675910462; x=1675996862; bh=YHjqVPP3VMHB9eZWAfU9+XuZd
        kAw/FY0BkaiVpBExEw=; b=RQA6je9AyRzH7/NSMO49a+HULinlWdUPsASKzyPVC
        L1XFgqp4Y/IclzyTD3nVpQBigiD+uzTcasm8+DjmrWKzZKXu+VqnKf3xLs+P+ijS
        pUPyj9saUTgKHml2s6LOQCFKuxu0zJ7/lX3sODL73paTnl1pTOpm7XoxljFGfZqK
        SGU480GKAnel2sumE1bNpH4IMnk0uy8WCQQ17qmI+Y8Aj/boEvuTQUyk3Ihax4ME
        JyJVxtHHmwH7TjB2YkP7NvNJLznx/RJxM9gBbfMW25lcvvVUSmz3sDQqWRNA+OEC
        3alFfIhS2WnW1TwptzWDTHJfMKF3mZNcoDj4DrPU+1FOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1675910462; x=1675996862; bh=YHjqVPP3VMHB9eZWAfU9+XuZdkAw/FY0Bka
        iVpBExEw=; b=Trp1DmrFRFXZnedNCoDY+1WxQoyihbz2JcatojQzkfQ2a3fRbaV
        +mdNkF7SL83pKPG3fzW+EXGhDztf94xqZbIF1HcGHZEFVTjG0f20gIaYIgAjnP1u
        EcEFJVihlx2Wm1deNLzEdXyiP2qKXV14q1vXB6WGnyD6PR6hO6HsN9lzCYYeYdyZ
        +w5/NaaavfW6DM91Y1hjNgKEzaQf9vP3jPSOtv8Hro2UxH414wo9i8mnbMFkCzA+
        h5x84QIVi9yg/Vmqj294IfzpQfbem8vUrdezh/saU9pq6AtiMXot97DfvCFNd8P+
        YTuX4clkX//uSDBxaEgv7Xl8wZUHTxE79wQ==
X-ME-Sender: <xms:PV3kY9uQfxRQemEiFs7P--Yfyam7THsMDNie8jZkuJm3sYkHvLAyCA>
    <xme:PV3kY2eLTxJP11RJdDbUMqVnYrwWkNj_EHmv38Uy0XgB8ZTxolIxng7t1vI_TSi-y
    ksoZL4YTRxn8XX1UCE>
X-ME-Received: <xmr:PV3kYww9cQ9ms0oVNd4rj2sbJm-XzKkozl-G0exqqNKgBmHskGrU8Gy1RFujTQ48PnEMrAqnJ-AArWSLj2sACepEZcIG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehvuggr
    rdhioheqnecuggftrfgrthhtvghrnhepteekhefgudekjeehgeelfeejudegieevveeutd
    duleegudehueelkeettdevffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvsehvuggrrd
    hioh
X-ME-Proxy: <xmx:PV3kY0MyA0SW5u6CHUXkM7TxBJ8u7cA6FsMhQWlaZ0YqeBAakUWxrg>
    <xmx:PV3kY99cjICMftSwcxI2RiLvM9Oa0mTHR_trkRkorI23cg0HDGK_Yw>
    <xmx:PV3kY0WBrlf5SJjqjDyP6EdXN3sz4GQXACC-5W-ZIYwFgnUmHCkKeg>
    <xmx:Pl3kY_kip7zyaZlLRAnSuW55bUv-ZWikcZb1-agZSc446xfW_hoBRA>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 21:41:01 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Date:   Wed,  8 Feb 2023 21:40:40 -0500
Message-Id: <20230209024044.13127-1-v@vda.io>
X-Mailer: git-send-email 2.39.1
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

This is version 4 of my patch to add stdint.h to nolibc. Previous
versions of this patch are available here:

* v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
* v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
* v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/

I tested it successfully on x86_64, as well as i386 and arm on qemu.

Thank you Willy for the review and the guidance!
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

