Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543B60E27B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiJZNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiJZNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:48:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672D105CCC;
        Wed, 26 Oct 2022 06:47:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 679DE5C00D2;
        Wed, 26 Oct 2022 09:47:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 26 Oct 2022 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666792049; x=1666878449; bh=pnMK5XKDDG
        c90XsqPqSH4CamFyR4mr2IljwezkbLwlE=; b=OjVqlYfYAfse9fEDEVNsG7dAAw
        cfayJsp2QaqchCfykgEfBSRcSzBOfJc8dyyIryJKqBk0T1Mh80R6pWP8SPTfDU7L
        rkddLPQwrr5KFSEDxXHEgsyigTTGexMfCtRA1Nep47CdUHmnP+F4y4wtlSLgmAu6
        +CCg3cVMRoSeiTHbR4Xs6go8Uxg0JiVz1V9iyAA48raz9/Uqas7+KcjZYX0xTW58
        0qBf0exCQBnGP3dxCPM2D2amVaoLDbEVILOQ9em2fAopwXivL1NWfdWMdlkQBDyE
        eZ7scA3K8XO6GVrohkQ6ajaVSxmqRb6vgseQ5pNu9aX/azaNiULB15YU2gKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666792049; x=1666878449; bh=pnMK5XKDDGc90
        XsqPqSH4CamFyR4mr2IljwezkbLwlE=; b=e0ojpbSFaPGgu05tGKEdWK/8umhX8
        isfK08aqe28pqF0fwbTK+pC/yzDrNJUHCZesjSeOuqpN9JNHucB6vUFHa6Rjd/pQ
        K8CBUdzv0OhG+Xek0bJqE0Oo7QYpczjD4YukH5yWXGWLHHGX/a0woJSZpKCBtEPp
        bzYxbhDyCPJWokxpIBaz89Ot6zNo5ahyA5gCtGobvubekPHDnkOcCaZUoSxEVhQ8
        uZGr0xNJLzQWWAKNIE1oRTm1hSsCY430fvvhvJcz9Vso4CWIRwuHup2ZRmMmHm3E
        99xD5JwCV015ci/t+H7waDBIpjCyhEtL9jsPNJ0d5Y3STRQCdI/kR2Gvw==
X-ME-Sender: <xms:cTpZYyRQKcpg-ouuho5GBk6tPzpqrNW_QOAGPm7XNDpRPdeyND6DhA>
    <xme:cTpZY3yTvZLmynfSnxh_lYCnFyD_77ZF5dUZyku1UqD5MtJWO6u3AmXKnBDLF6xMg
    UnJ04ioJnhPK5VHWps>
X-ME-Received: <xmr:cTpZY_2L6UKPfe-PZVhQNXjYUpGkAR5yE0R5bZhuGZ71oiOtW_epaK_k2z5AY4X4UAzNxka1gqwJ6dgrnuB5RufWvoFl-bbTI__WrkEdULbdJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufggtgfgfffkvfevofesthekredtredtjeenucfhrhhomhepmhgrgihimhgv
    segtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeeltdeifefgffetueehueefgf
    dvtdfgjeegueetiedtteelieeftedtvefhlefgheenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cTpZY-BUVQkLjmyPI9wetBjQ-G8gcB8KU824ZSQUQSz11a7OfzXe7A>
    <xmx:cTpZY7gnWl7Xh_7izDGN3m3Y8v_cX5j4D7qDkUh-fuhraDvwRfF4nQ>
    <xmx:cTpZY6rVmNrcSbmFuVuyc54ANH-LeVCGQprMdUwWOXiR-hdKNULs_A>
    <xmx:cTpZY0bRilgFVh_H-YNqgNwskvJbEK1Za191LX1v-TfNKMAFeKhjwQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:47:28 -0400 (EDT)
From:   maxime@cerno.tech
Subject: [PATCH v2 0/2] clk: Rate Request Tracing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFE6WWMC/42NQQrCMBBFr1KydiRJo1ZX3kNcTNKxDZaUTtKClNzdwRO4+rwP//1dZeJIWd2aXT
 FtMcc5CdhDo8KIaSCIvbCy2lqjTQdhegNjIWBaVsoFCmOIaYCLo057d2pdb5TMPWYCz5jCKIK0TpOU
 Y8xl5s/vbjMSjz/MmwEN51eLqL32157ugTjNx0KiftZavzqfn0bGAAAA
Date:   Wed, 26 Oct 2022 15:46:57 +0200
Message-Id: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=Ym/mQsI/sFoFqKKeo24pXbCH8MqSSbz1qd8rYqDzaQw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRVsFtBg2Zv56piyZKzhbx9hA3WSewWd9wxZZsW8eAUzXs
 fL87SlkYxLgYZMUUWWKEzZfEnZr1upONbx7MHFYmkCEMXJwCMJFzsxkZnpmUVPx/8iE+Yab9vJkrwp
 p4nB3+fX72ct+U9TukRf8laDMyvJphu+wI91e9B6IBf/6aWckEz99Sl7TYJ+3i7QrnD/ozWAE=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a couple of patches to enable the tracing of clk_rate_requests as they
are submitted to round/determine_rate.

Let me know what you think,
Maxime

To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---
Changes in v2:
- Used a more optimal structure layout for the event
- Added a commit log to the first patch
- Link to v1: https://lore.kernel.org/r/20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech

---
Maxime Ripard (2):
      clk: Store clk_core for clk_rate_request
      clk: Add trace events for rate requests

 drivers/clk/clk.c            | 32 ++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 include/trace/events/clk.h   | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
---
base-commit: 69a14e4a9d5a0e1ed73063e0d439c3cb33ce9829
change-id: 20221018-clk-rate-request-tracing-74e80b4534d1

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
