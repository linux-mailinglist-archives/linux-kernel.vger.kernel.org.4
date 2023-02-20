Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE669D4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBTUV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBTUV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:21:56 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED421A35
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:21:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4282C3200D2B;
        Mon, 20 Feb 2023 15:20:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 20 Feb 2023 15:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1676924422; x=1677010822; bh=NcyI+Ot5bOq+DbkDpPioxq3dJ
        pdojFXhm2HCHfIaIkU=; b=KgNxOt0s6M9QBrokYTsZOWlg2s5K9arVXx4+ShV8N
        m0CkTc0Lw7aHu4mQIcupEuG2TVtO3fFpk2whGJ/Dxj1qLQe6BXBN5DMmNZ0vVuel
        3v7kihS6Xcn4CrfSMt+rx8gVWXgPfXSlytrYN/JauS/NWdB4afIITu11zGbhvxPi
        AaUYXzSMGHRyA2sHRoIruPAy5R/p1rp78Q72CDLLSavVtO4THuLjN1ehUM7/7oGV
        WBm6o680YE2ne248HNl4xAAkUdLM9tL0PUzWS49RMBn69m3t9VBTxce/YCUEUPkz
        RouMG5AcmY1gB9a1qn//1avkJzgfPKn5uKZZ7ibSLC8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676924422; x=1677010822; bh=NcyI+Ot5bOq+DbkDpPioxq3dJpdojFXhm2H
        CHfIaIkU=; b=t7pdPxg+ofuYCxq5hW8WY58RkycEPCw3eT0c+Wjj0gAyMuWGBs2
        X2FjEtE8wxXx+ZbxPGRpDzyF6nJvPencwmrDqIcZvvbF3DXX/aG2V4LWsWqdghQ0
        3nerVdeEqvBFut6U078kbKOuLkDTagknki8Q0oUQZk6pp65Attxc6P6svBKeBdsT
        cEBIvi6erZG+8uKHSMCmdkknllCLFYXQXuI8n7ugyC33eXCtWVFpZ8kUlQd+MKMT
        JLfvSf4lnsg2XNit1Qy8hsdtH/qOtxzncsbOWbFMdNF1Fesw+UH+XpaJLcyxu7pL
        HPFHYwjHphHXbla87vPvTzmOBWsbPTfh1gQ==
X-ME-Sender: <xms:BtbzY9viTq9Vtky_MAxYbw_Qg5Ky9wi5AAMkrLhz1ZdJIq_LzUs9eQ>
    <xme:BtbzY2d1Qdh3FpM6JmiZh7uPY2-_CEXqoLp0Plc3M_pWjSEynx_8ADev3lhonxz1F
    z72t7BgQUifPYKfTKA>
X-ME-Received: <xmr:BtbzYwzfrWecoYQieSAFsvcEH0pgU8-voVeQ6NIIB-hC8grP7xFO5AXscRMWdykCoDBvuqLt0EZQmV5dFEXkcHfKnSuW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehvuggr
    rdhioheqnecuggftrfgrthhtvghrnhepteekhefgudekjeehgeelfeejudegieevveeutd
    duleegudehueelkeettdevffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvsehvuggrrd
    hioh
X-ME-Proxy: <xmx:BtbzY0MsYKdl5U4jXJKQHYYJrYkxsPKbicRHLVCYQKKUZIhy2IcjKg>
    <xmx:BtbzY9_Ovs8WCtBxVygvmBA8udnhm5jvsoJbOHblu-22SoccbBBbCw>
    <xmx:BtbzY0ULlXoK3muaQEdIPrwSqumku4VXgwhJi7dN4lkkOsXdoou-uQ>
    <xmx:BtbzY_lc6Wyi4nfGMKoixRuKcVMk49u2ayVZEN4PABjn0SvMSwhMhw>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 15:20:21 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Date:   Mon, 20 Feb 2023 15:20:06 -0500
Message-Id: <20230220202010.37475-1-v@vda.io>
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

This is version 5 of the patch to add stdint.h to nolibc. Previous
versions of this patch are available here:

* v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
* v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
* v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
* v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/

This version includes the work done by Willy (see
https://lore.kernel.org/all/20230219185133.14576-1-w@1wt.eu/) on using
__LONG_MAX__ to calculate the max size of ssize_t, size_t, intptr_t,
uintptr_t and ptrdiff_t.

It also includes the '*fast*' types, although I have never seen them used
in the wild.

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

