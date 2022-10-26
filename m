Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215860E1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiJZNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiJZNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:19:09 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF810FFFBA;
        Wed, 26 Oct 2022 06:19:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6BA80580607;
        Wed, 26 Oct 2022 09:19:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 26 Oct 2022 09:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666790344; x=1666797544; bh=wszv/k4GyR
        LXwHILyqHKs7t9b42cIN/cP7xoErtZWxE=; b=FieEWp97Zj/gSt/IhBLTjKUNu/
        vyxw4Pa8fN2M1KdNu5k1lY1HiY0uRcKIDUWSj+QHut/TNFxHS7v6p+39z2/b8agn
        Uuf+9cvJbxMQD15KsZBecM9Ma0bUL463bbHWWeokIZRAItS4l2e/s2ii0S3Bo8br
        dySvotg7xA7BezAVRYJSVpGXnzxLEU7Hen0SSDGO8zOE8I7w278ABaZ7YyoulECV
        OVeJ+bVgCmJbZ1sy4T9ukEvFSXUqWa0vKN6z1HbzL6U4ccibWC2IeU50HQAe9Hn5
        UBn7j7d6WY6HaTXtiaH1tSlGF9BoIdY31gTY0q68aoOKTHKkELAb5FD5uZ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666790344; x=1666797544; bh=wszv/k4GyRLXw
        HILyqHKs7t9b42cIN/cP7xoErtZWxE=; b=Xxk/C8gR4RvyzWnc40s5qGyl42LA4
        lLI2WTRf1R0RMuSKsP/ASQGKHhWBmNTjdU8Gm3xWC+kf0MoYQWtpn9EFj8qoMgvF
        Agn9ajvQua0f3FY1aQD3fE6zrXCz7z+82wEKL4oPBpWMIaKgHp5fZcKND6bn2ipT
        VaP3eJjiipxSrqXp+EIWty7KlKpwOSRZk51GQ8SWNzCKPWAV8YDlIt7hHzEMKcgL
        KFP4ri/wZiT2m4XbFqd6QcAoe6V/81Bk3H5zYtk5moTGPYFnvw2R1aDq4LwSyo1b
        nvlOSiqr8uiJqeXmwgwMYcDkqz61kkM2S7e0lcnqUi6LvNeTTIiyCZ5iQ==
X-ME-Sender: <xms:yDNZY3PZg0IhGmE4WLLigaZz-9UuwlM-NZpPl-9WCjWx_4QjymnjzQ>
    <xme:yDNZYx8Eez8nsg7G7aZYB4Si3p1LvWuHwejpU5VphDnpKCV8LghyywTJKKq27Rva_
    G-48L5_52tdu1HnmfM>
X-ME-Received: <xmr:yDNZY2TzCDOZlLQu3gaMyNYj019_OvMPFxjVSn9P5jLd7ZTeM41S9RVO1Yk4lE2Y2tYbP4JPam25ieKtQOdFTvipxCtIo-EXHggdrhY0QNYSpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufggtgfgfffkvfevofesthekredtredtjeenucfhrhhomhepmhgrgihimhgv
    segtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpefgfffhvdetheetvdfgjedttd
    eiuefhkeegtdekkeejgeefvdeiieehgfefjeduveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yDNZY7vljiK5nsQIlZIp-UEX1qUf8BrtOCSDyIc6CUaUMRGiJM5MoQ>
    <xmx:yDNZY_eW5UdMBXP278L-4kzO-Xkg0ivMdrXIsON4RNm9QrrGFz-yfQ>
    <xmx:yDNZY33N_cD5mPAmOCNhFof7ZbTXLwIJ05Wz9xPgSdrwAfCLonYfWw>
    <xmx:yDNZYyzClmSCyHEXxU_s4FoTrzr49fFCGCXeQx2Tq07rBTMSLkIIOQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:19:03 -0400 (EDT)
From:   maxime@cerno.tech
Subject: [PATCH 0/2] ARM: dts: bcm283x: Switch to firmware clocks for Pi0-3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHEzWWMC/13OwQrCMAyA4VcZORvsOtTh22RdaoO1lnQoY+zdF68e/8MH/waNVbjBvdtA+SNN3s
 WiP3UQEpUHo8zW4J33vfNX1Co4S6uZVoxfDPmJbhh9vFGkC49gcKLGOCmVkH7UxPlPVOUsLymkK1Za QrKDfT8AfR4OEo0AAAA=
Date:   Wed, 26 Oct 2022 15:17:37 +0200
Message-Id: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=ckRY9B9QAZzOgxB+4vCDP390J1dt7U0jDedMOt0GYh0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRxsXlEnPTPbyi+6cs733GOOFabWGt1P0yR12778mxyYUP
 Hnl0lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCIadxn+V79mWMxrNFWSraLKo/TDu6
 z1Ex/rTfRf90za7sHFBnHBLww/GbXLVVakfFbY+2Hmp++H94a+d9BO0ivmFM5kveJh7P+JCwA=
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

Over the years, the differences between the Pi0-3 and the Pi4 created a bunch
of issues in the KMS driver that trace back to the policy differences between
the clk-bcm2835 and clk-raspberrypi drivers.

Instead of piling hacks over hacks to work around those differences, let's just
follow what downstream is doing and use the clk-raspberrypi for all the KMS
related devices.

Let me know what you think,
Maxime

To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Ray Jui <rjui@broadcom.com>
To: Scott Branden <sbranden@broadcom.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <dom@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Cc: devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---
Maxime Ripard (2):
      ARM: dts: bcm283x: Remove bcm2835-rpi-common.dtsi from SoC DTSI
      ARM: dts: bcm2835-rpi: Use firmware clocks for display

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts  |  1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts       |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts  |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts  |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts       |  1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi    |  1 +
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts  |  1 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts    |  1 +
 arch/arm/boot/dts/bcm2835.dtsi            |  1 -
 arch/arm/boot/dts/bcm2836-rpi.dtsi        |  1 +
 arch/arm/boot/dts/bcm2836.dtsi            |  1 -
 arch/arm/boot/dts/bcm2837.dtsi            |  1 -
 13 files changed, 26 insertions(+), 3 deletions(-)
---
base-commit: 5398aeb71349b5e67658d51f46e12117060d867d
change-id: 20221026-rpi-display-fw-clk-0382f7afa5e8

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
