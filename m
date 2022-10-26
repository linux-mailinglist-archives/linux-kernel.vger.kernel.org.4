Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8E60DFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiJZLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZLt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:49:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA8764B;
        Wed, 26 Oct 2022 04:49:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8A17A32003CE;
        Wed, 26 Oct 2022 07:49:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Oct 2022 07:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666784965; x=1666871365; bh=Fs
        O0gPfX2wHmErfPj9SmHjSOURVfbrKHD0GjwO7ZwVk=; b=wguQpGpJB+dw8/sOY7
        LLeySXpRG3RP0n5L14JU/FaYJiN3r0kUN6jw2eGYikDd93TOsJVIkoVXFEOtVE5Z
        uDMU4CJoBph8oPHuYLXSGFaKgDEXMq5cHExDcvYEs7WEtqE/UT+RBLqvQ7VAZ+3v
        CCYevACGdoWityOQsXB9PiuO31Dv7fbrBX521juoWjTrF4lQrjxbVxqcPadVthuR
        eeosC508IAqq5g7ocvRmy9QFYcYpateK9DaXAuyYHT4GPSw89aa/a/hP8kRmwFq4
        zgbkr9K3dS7JpaTePv+ne1o9CiLR5mlVqnQ1Iij1cTjcPKpz1JLjpUUyDVCA+D1F
        u3Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666784965; x=1666871365; bh=FsO0gPfX2wHmE
        rfPj9SmHjSOURVfbrKHD0GjwO7ZwVk=; b=kKXNGot4HwX9HZLQpWN2eO25Rn4Aw
        8KMBK7puUOgt9RAl95V/dAzpuw4x1bYOMogRuSZPrVO7+/NB1ShRblVme+Pow0Jr
        b6JGyva8vSaIbqyT0gGDsj9+msQvV6+kFH5tF3CJ+vz7NVTDUkA7dkqxOLhVHY5Q
        saQ4DnOlrEPijwKiWMZHgFov5Pg+vVCWpBtPc6ckZanUZXjUOesG5CsUVN6k30eA
        6RXQNPbUO1QHC+JQHccazuZMKvHySq1fCZPwZHPigDkL1uj8WQutwb7oesHU+LlA
        2nQ1UG9mCHLuHIqon1rtL8UWGGUXRZupYN3y6tdbQPatz/+HCzsBPt2/g==
X-ME-Sender: <xms:xB5ZY10wOzL_asfqoRU2gGJOBBPgs8EYOF6ryjrc9XVoHIDUlWyUyw>
    <xme:xB5ZY8FBWRTdKLxb9ETcrV0yQSa_ngy9Mgcv_ODLL0SceQDJ5TCZQDKuloeTHeT6U
    FdD5Tp5TFvyby969l8>
X-ME-Received: <xmr:xB5ZY169YM56KXh70yXZYRlN-7ZblnX5J3Y9IE4iHYejSSWOH35OGMwl7jU-PeOL840RM96HwZMj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgedtvdfffeffje
    ekgefggeetfffftdeuveekfedvjeevtedvueduvddvtdeigfelnecuffhomhgrihhnpehl
    fihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vg
X-ME-Proxy: <xmx:xB5ZYy2B3iT3LecU9CWDtv7qA9DTdYxNTv22nszU-vFkxPSAkZZFUg>
    <xmx:xB5ZY4Eyi_LlYQPqaCe19NYT3IP3O06vvaCnutA0fUOz0n6EsRXLCA>
    <xmx:xB5ZYz8Dd0JRwW54laQDQwhE16rSzQ1VDpndUj_GMDXXRLdM_slpGQ>
    <xmx:xR5ZY_eVhgJMCA9WIW0jcQhc_WZAlUnMU0gqpBUltsjnZiNCCagwXA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 07:49:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        rydberg@bitmath.org, alistair23@gmail.com, s.hauer@pengutronix.de,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 0/4] Add support for the Cypress cyttsp5
Date:   Wed, 26 Oct 2022 21:49:04 +1000
Message-Id: <20221026114908.191472-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

v10:
 - Fix device tree binding errors
 - Add commit message about defcofig cahnges
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
  dt-bindings: input: Add Cypress TT21000 touchscreen controller
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5

 .../input/touchscreen/cypress,tt21000.yaml    | 106 ++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 drivers/input/touchscreen/Kconfig             |  16 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++
 6 files changed, 1126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.37.3

