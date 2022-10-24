Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04850609FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJXLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJXLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:10:37 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FA38478;
        Mon, 24 Oct 2022 04:10:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CFEAE320092A;
        Mon, 24 Oct 2022 07:10:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 07:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666609832; x=1666696232; bh=gb
        hK/eMcTlKbenVeIyYgpWT6RRs4ePlOWO1qBGWrAKg=; b=cYSOFk+XBLFUytwYYW
        k8sZ52HdfuVanKe7QeCD11V0YG8oWV+WfXOsh44ndupJIeBsEpMtqt0XzzYRoHkm
        T6Wh0SUwDOp2toWrUMt23Gkk+hqJ5R7ojdMSmhl2yo5FF1yqlvrxkRafSgtDcgL5
        jyJCM5PvGgT5H4NazJ3euvcHzEz5rSVo8kDs2M0V5IawWvjJkRRsQPIT7bas3LjI
        S69vP85lYZoh8a0n+wMmmgwW5L7qXHqsrVtw8TLpEN7GyOa3lECLrzJo1xbVRkgj
        VjxODEqZrl4tdd9G2x+t41LjhCuoLO8cg7BBUKJFHSuzgruZPBigvbJUle8a9KX4
        jSlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609832; x=1666696232; bh=gbhK/eMcTlKbe
        nVeIyYgpWT6RRs4ePlOWO1qBGWrAKg=; b=oBCu9z2eauloy/0TjSHQq2tIMrAwk
        9Km027WomJnOG9tl6XEtM/fi2qp31kT681CfU8Z2UnOeiLORtFbD+tX/0qWmDVek
        M1emND0dUIJVrmMA3zJ2rmGiD1v26gEtw51M8x9Rzu2270AAeLiDBjyh2f0CQuwv
        oAKpV7iXFTxpa2GKFLm7X61bHLmINB+fyRn4OXh/fEDDuA4q6Q2vUL6N6gd7fiB7
        zQo+VSMi6K5yMp8OeMb0MfYiF07JYcSWedBdhf5NjgJ/Fi1pBG4Ye65oseLRK3yg
        kglp3mKOJpT5ajccMeWYzUJvr4DRDOxHJuA5JOlSRPJpbTnVZg+n2Ol8w==
X-ME-Sender: <xms:p3JWY5Jvdxsc9Wn1ERvEXUdosGwwfUQT-W3QClAl_EIMJ3b1oD5pbw>
    <xme:p3JWY1LJpb5sts9buVLIcQi8utH7Bg_pgNpZQpYzLqnLabi8eOI5YWPXTVQsU5InN
    rTWFM9i8bSQj30as3Y>
X-ME-Received: <xmr:p3JWYxu8bspXPYqKieY1K-O9thAk45poNUmliAKam2Lg05rHFqkfLCc8JUehMgbfxOvpZyZB6SNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeegtddvffefff
    ejkeeggfegteffffdtueevkeefvdejveetvdeuuddvvddtiefgleenucffohhmrghinhep
    lhifnhdrnhgvthdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedr
    mhgv
X-ME-Proxy: <xmx:p3JWY6bF7cXjXpzCACQMoF7MwYsnJkKKK1nNSnfsLH1GmAysLFjD-w>
    <xmx:p3JWYwYQHEtXf8ySwCm9oSB0sJCI06orNCH9iCZQn3IS2NPXh1r5zg>
    <xmx:p3JWY-DSxquRdzVgWp-7qPJQiAPHDe5BGK0G8-pN1gEHA0Ixacodpw>
    <xmx:qHJWY8Qg-_g8mhXnbwQqZB--D68y8j7ph2HER2mVF5c50ke5z_vD6Q>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 07:10:22 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, andreas@kemnade.info,
        krzysztof.kozlowski+dt@linaro.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 0/4] Add support for the Cypress cyttsp5
Date:   Mon, 24 Oct 2022 21:10:13 +1000
Message-Id: <20221024111017.43859-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

This patch series builds on top of [1] and adds support for the cyttsp5
touchscreen controller for the reMarkable 2.

I first tried to add an I2C HID device. Although the cyttsp5 has some HID
looking aspects it is not HID compatible. Just in trying to probe the device
I found:
 - The HID descriptor has extra padding
 - The HID descriptor sets the high bytes of the descriptor length
 - The HID descriptor has extra unrecognised tags
 - The HID reset command doesn't appear to work

I don't think there is a way to use the I2C HID framework with the cyttsp5.
For anyone interested you can see the work here [2]. In that branch though I
can only obtain a HID descriptor, nothing else works without more core
changes.

So instead I rebased the series from [1]. Converted to the new yaml DTS
documentation, added regulator support and fixed a x/y miscalculation bug.

1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@bootlin.com/
2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid

v9:
 - Fixup kernel robot failures
v8:
 - Rebase and resend
v7:
 - Fix device tree warnings
v6:
 - Use reg for the button properties
v5:
 - Address review comments from v4

Alistair Francis (4):
  Input: Add driver for Cypress Generation 5 touchscreen
  dt-bindings: input: Add Cypress TT2100 touchscreen controller
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5

 .../input/touchscreen/cypress,tt21000.yaml    | 100 ++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 drivers/input/touchscreen/Kconfig             |  16 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++
 6 files changed, 1120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.37.3

