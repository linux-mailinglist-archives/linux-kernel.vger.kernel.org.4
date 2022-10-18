Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729C602D80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiJRN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJRN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:56:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF79D0184;
        Tue, 18 Oct 2022 06:56:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6A102320025E;
        Tue, 18 Oct 2022 09:56:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 09:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666101404; x=1666187804; bh=d6o/9ZjWll
        tettTtq0x0QTbIW2ZWxkr4XOTjsAM1BxQ=; b=QJfdmUcngfRtR5r0k42D/lqIS/
        kl1ZVK76EZYQWdQQ9/6dKNNTl5Y1op/V9aE5XMkWluq8Ddba2oLPELKAxG5HRzM7
        P7KYEw8CEMQRzLLfUzlf8OsQ2hD7Aep7UCDEUpSQ32bGDpZ2rA/z/0jDI2WBbmJu
        DCPk+gqqYE4E30lTAh9aA1vXprhj0JbHSn36u+RkmyO6yZxm8ENBGP3sQttS/JYn
        XOjP29U5kwU5Bv2UJ9wi4KpZLI/+AkkSPUXLzbpFqWPcw5VD0mMkvn3JXMQ98qdL
        Zk8bJr9GWbg6TEs/1UFz8bnJ0DITCzvrnm6eYlHaDw63boiISSm+QL5plCSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666101404; x=1666187804; bh=d6o/9ZjWlltet
        tTtq0x0QTbIW2ZWxkr4XOTjsAM1BxQ=; b=OZs4beNAU1KIAZvlDs+MPnzZmc4jf
        myliUlaYzIgKtwoAQGNm+WYEqzq841HwMkNMWN+xAsfkhoeR3rnQ5NZvOFqnOCo2
        bj8fWJYH8LLQUnH6My7/rYRasl4js+KJhjJr6xX64v4nl6TBzilGxHKNUz7+yucv
        O7mYtzcm5XUeAldby8lgrgKNK2LQQOtNzUU6S3Qc41DrrvAh5UYM8Y5/Xl7fdXa+
        AFAuiJdbxKfANl4mewbCkX0qVqMTXyjztVuNgdoQK47O8YK8IhO9ozYAlfU1eOsz
        Ln6anF79S/D3yvHuf2a0OvpYvtImuAy6ZDDDIaOo7ije39BqQk749m1MA==
X-ME-Sender: <xms:m7BOYz5ZonXNqICaBxmukVMq8pebsWPijnRVCHoWUej2z2DPQdr8VA>
    <xme:m7BOY47Pa0MJY4wQz0ZOW_8NAjhAzk3zewMdG15WFGy9mvt_wuvrR5wOJJGOR6Fpc
    kJ740kQM8p0_pwrpkU>
X-ME-Received: <xmr:m7BOY6dLqQN8iV2GQWcGjP8mFxfUZQVl-fFyCuOXMmiVb0yYaFrd4rCfr968>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepufggtgfghfffkffvvefosehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdehfeejtefhgeegudegveejieetfeeugeehveffteejkedufeeltedutdeu
    geehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:m7BOY0Ks5H2532Kz0GTpiWwh0OOQJSWa4Ubp1CrkRfcUAp-FKk027g>
    <xmx:m7BOY3JoPFI9FzN3ttLy04AMTjd3yGT-jtKf90t897wps-7OTAXRwg>
    <xmx:m7BOY9yAje_XaS3uztBy2ht7OotSGYqQtQA6JCjiM3w19gYKjSl0vw>
    <xmx:nLBOY9gJwvwpXrPHudwjjHi0Xhmy4UMvmJKBrbF8gVzxJ8qy56sm4Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:56:43 -0400 (EDT)
Subject: [PATCH 0/2] clk: Rate Request Tracing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAJiwTmMC/w3MMQrDMAxA0asEzRXYrkNDbyM7IhExKpWcLiF3r8c3/H+Bswk7vKcLjH/i8tGB+J
 ig7qQbo6zDkEJKMcQFazvQqDMaf0/2jt2oim74yryEkudnXiOMvJAzFiOt+xjo2dp9/wH6kLqNbwAA AA==
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:56:40 +0200
Message-Id: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=SwaImmjFBLVh/HJnbJyXqAs1S1NtasMsz9acLyU1qOY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+G2aJNz3k/CHZc8myKrFYeePzE6FJ9V5RE7c1Hnv7KVRz
 6aSCjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEykdAsjw/dZTZM8yjuDbC89tJpRKV
 YTa6XxcrnbyQyfs9ZK/U/VZjL8Zr9zbiPfZqlDzg5Wuy78XLeR/0YHU+FEndzny6NKmm4GMgMA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
