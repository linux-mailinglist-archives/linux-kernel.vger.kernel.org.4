Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35E61DDAA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKETT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:19:57 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DDDB841
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:19:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1DB51320031A;
        Sat,  5 Nov 2022 15:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 15:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1667675995; x=1667762395; bh=wr3CC6d17Ycv35CedFvrNV9Nc
        DbjCIEiEXd8GM+KReI=; b=YZsoe74/9QaOWXgQS/VMB9CFuOEpj1fzYeP0pcuBP
        XcdctKSZGS0Sw8GoruENLL0nXNyB8yHDFNq4Nq3xzgPqVY3trpHGWwZmzv5mPSBy
        qjIcSiNPyQ4CRhCtO1ux+iMCXqP0KZbDZLRUxuYqw5lnzr3abx6zoU+S8S37ylrF
        N73Zbt102JVgr2mI+pCuk2GzOB9ScenZMFJimlP8bBU6gvqREGKTV/3aQTdMHI3x
        fpHIe/UgOWHBQpjavBPMwPta053AGw17UAdTY3WlS36XAAjXviyD7v8watSoo05G
        1EUldJEqZNmcEe9tbs7GyFgUrpNXfPhwo7029eFqZBCmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667675995; x=1667762395; bh=wr3CC6d17Ycv35CedFvrNV9NcDbjCIEiEXd
        8GM+KReI=; b=W8FlJuE7vyO6SV8REZMYlpNYhqQRzuTEVIuFp4s6/j11VtQF/hU
        diPz8BhI6A2sv8mKBQp3H8Tww4zKrMANzdGizPzkZmEIoZfXaf9/niIm31Cj2aDD
        iu3sYYlmwVgXREautXShq7TCvrIDwGepeBZlMlxU0WRFTngeeglB3N3mWa9e37xd
        tM4056nql647OZwcLYGgpJlc861fQ+kkulj5OH8jmdZ0tE0bu8wwxCyP4GFMp2GW
        psuf3GPLgSUZs23DrsD1PZkKDI9hufuIgPhC1tCsh0msmTK5x4mJQF4GpPJGnBU+
        WgVkUZb0IZC1RhM0mQ/aZM5w42hQMcSDHnA==
X-ME-Sender: <xms:W7dmY7OQRZvyg_kltZGMMgh4Y1-iUP9RENeoRB8o68mBDqBw_gP0yg>
    <xme:W7dmY1-KmYMJz5lf7GVl61dUhXQ-kuXXxviRT9ubw1JovoddEaDe0weeWrb7Unx9R
    4nQ6gDk6Zbmzvi8xg>
X-ME-Received: <xmr:W7dmY6ScpeOWooLddNTQseBkLheZaKTkPkZCwUah1cjCLlFuSDYAbrmFV5A-lbRBgIDriB3k0sTO6JBc-CPlacyH70Ub5t2-TE5MLArEhxQGEk13_iBWFNtBVL6_RO93Xnjf6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:W7dmY_t1UpwsRQZOt7iMOVLPfwks2PykcLExVXxPn8693UtmsUeH2A>
    <xmx:W7dmYzeCw04l5QMuhiEtyavmFrgHf4uJBw7rYllpMsHEatJlU8DoSQ>
    <xmx:W7dmY7131m0D8wZnouvCou5cdUaJ0pvl94DvTR3GbsRh2rm_XcIpZg>
    <xmx:W7dmY0H2I5ygc6s_Q6PKAMrmQV_f1k4oon4NGUlzm3cCNQRrt4_f7g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:19:54 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] bus: sunxi-rsb: Fix poweroff issues
Date:   Sat,  5 Nov 2022 14:19:51 -0500
Message-Id: <20221105191954.14360-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
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

This series fixes a couple of issues that occur when powering off a
board using a PMIC attached to the RSB bus.

These issues only affected 32-bit platforms, because 64-bit platforms
use PSCI for pm_power_off(), and the PSCI firmware reinitializes the
RSB controller.


Samuel Holland (2):
  bus: sunxi-rsb: Remove shutdown callback
  bus: sunxi-rsb: Support atomic transfers

 drivers/bus/sunxi-rsb.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
2.37.3

