Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A129261EA60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiKGFWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKGFWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:22:08 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9465F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:22:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F5E55C00D1;
        Mon,  7 Nov 2022 00:22:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 00:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1667798523; x=1667884923; bh=CuTgFWqChvmu8b2BPKTbdryO+
        xAYh1S57El28nrvuA8=; b=FdqwZQYfIExNw9rtIBSyPgQA9Cr25E4OLsJS1iMIs
        8FZihjVZyQwqez/msYtTcdxG7Dvf+dqFHezTdsvF2nEBjAWaAndOUMErNlPN1cPL
        dDhQysMAlRvKEfOpU3JZM4DfFiXeSCOmn2f0k0htxo8dARNs8jY1E3GWpOsWFSef
        eCRX0g1aV35EvJGajkYqD+rGx/wvhTrixA/1n4bPX6dA6XJ+/XqymXaaabqvc0Ah
        PEfAuMugRO2OC1DpgZgGJ1z8zVb97+5orXBgZ//tQ/EgwJuiMJt/3gXxx+x/Yn2B
        7X/pttHcwTqhE22x5qxH6qDnOozkbthszT7xLxMlXxi3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667798523; x=1667884923; bh=CuTgFWqChvmu8b2BPKTbdryO+xAYh1S57El
        28nrvuA8=; b=UhKQCSz+b+ZzrXWLWbQO2Q8Kc73CxsTxPNYVp/dduirY+n4xqLl
        RLAk/KXFDenEhXuumIibyQcLGagzDlqsw/SfHFF/mrCQwomIS2CjrW/Yprjli8S2
        +a6gUoTE5WLVVy2Np6HW9jJG3EWSZLhpTdQoESgw3zk/7xz40lGJbR9Z5hbdSUtJ
        L8hVqLiNdiLPPXbej00YXiRsmWoogWfvXcQ7bTk4wYEZqXv6fCLG0KHwwu7kX/Qh
        KPId9Ca39IlFaSuilcIkxMH8sqex+dVQvAhk5wnpXOBsG8aoxG49+VFgRKsTGGpu
        CqcdRz5mVeWVaawRO22yBuP3ck2EwOOSdKg==
X-ME-Sender: <xms:-pVoY8BAkRACm5Nv10ut8J7E6VGPSo2hN04WWHic-BocUYKAufgacw>
    <xme:-pVoY-gt-wbKzQvAB5XxwxDal_BA_oqLgs1t7kCw6cB1ZdqkhwmKtQgKDl04nynhL
    ySBL-YDgNzGZJTAvg>
X-ME-Received: <xmr:-pVoY_lTcR1q4cGP6kItTQlmDqQXXXLPGrlyYPZTJCmT8Z-ZXlol7wYhAYdfP4vJgaYDJKcj83Ins66Gax7LhpwawI6FL_ETX5YXcTg4g2PXWJOA2oXNDLQI1ut0XONIFoMxkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-pVoYyzjIffYtMfJyFLdutIoEzviVo0dxOH0iWBB9kQ1EX9CpzZTNA>
    <xmx:-pVoYxQGW3xUcTFv33ELCxR-7hcUBFtCWne-WbIDY9H211cUQvGgFQ>
    <xmx:-pVoY9Yqji11ctVf_zsvqkQZ6DpZsVvbaydYk04xE79OuUSK83wn-Q>
    <xmx:-5VoY6KsRyH_EhgDDJ-deuICOv6UD5tmtKikkR7AL2sHSL6GBCvA8w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:22:02 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/2] bus: sunxi-rsb: Fix poweroff issues
Date:   Sun,  6 Nov 2022 23:21:58 -0600
Message-Id: <20221107052201.65477-1-samuel@sholland.org>
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

Changes in v2:
 - Add Fixes tag to patch 2
 - Only check for specific status bits when polling

Samuel Holland (2):
  bus: sunxi-rsb: Remove shutdown callback
  bus: sunxi-rsb: Support atomic transfers

 drivers/bus/sunxi-rsb.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.37.3

