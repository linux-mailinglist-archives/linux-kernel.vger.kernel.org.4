Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7765A850
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiLaXzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiLaXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:55:51 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECA28B;
        Sat, 31 Dec 2022 15:55:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 953035816B4;
        Sat, 31 Dec 2022 18:55:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672530943; x=1672538143; bh=pTEZggda+tOfZg7lY89KlH18L
        nud0xfDB+BCBVcDtdQ=; b=O4aYKMtL/Ol6TXmF28k8d7KPJVn7SUjFDUdKbNJUn
        nk4rrRU/320BwQ4em1PkAtkC25b3h3Ma0m7NpYKYdjhb5Mquzfb99aJsjgNZgSGT
        QyOWtqWcG0rtJPbiTXc9smTumrM6nz+nNudBeK9BUH3X+7arouBYGD7oPq+8tJhV
        pjMF2KJzV8D3awcFnDHeD1yWX+TGu9ZPMh+ufSjK/R7q8pRQq7ylDWfEoewiUzjz
        MfvUd3XTi8yjXRD0N37NcYXJ3AcaNJ0u3XLZr/zhea/oos8xovtNAC9owDFB05hW
        aDBqX99XDdWBKivAUKqn4rewHAY4ZFLAkBgMzq0RhNXvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672530943; x=1672538143; bh=pTEZggda+tOfZg7lY89KlH18Lnud0xfDB+B
        CBVcDtdQ=; b=phuA8hr+iYwKNrjL3M8Gds61FdmsaXcHXpzYqb53MniGJChPcHZ
        VtfLBk4jOWDtIHjipMRSIWWnfg1Gq5gpiauV+Y+wlakQEATgL1KsqmFn++fJNEMa
        DfXUMoYyDEENbbiDvXsQr96WJXn4pzDRlS1c1oYdzLRbItqGLsF3cfByRp+HbFW/
        khbXSvOCbp/D0Ftjv/aoGIAw9yMX0CGmoD0EWyY7V9r7WlmgBPktRxzfNvMsPqEz
        pKg0QoPuKVvhMr0BjE8jscZIU8d5HNWE/mDfiYqzcfZfbjuE806zuiLmqYdsM8pX
        OrxQodpW94g96ehRgbokrlzs/47eH5i59Dw==
X-ME-Sender: <xms:_suwY2Mqr_vyArpSylsZ0_HlKHwlgjjTXqiUwsL_I1I_Loc15kCCcQ>
    <xme:_suwY08a5L74f2u5vJ7Pz2FUFGinei4WWRMmPSa_BaQBGtLR6P1zRJM5V-XpGibPu
    GFEAI5-MZXv0o9HMw>
X-ME-Received: <xmr:_suwY9SF9vD192w9uUlMdpN5RBObROhmAIHdlRoJX5LVLqzx5eLwPX9B3jvpuVKmFw9lGy2Bf3gjymwSCHtObJF-g2tQ6dnI9M9tDkZmxOyYZxZiNQCF7q95jA-0tnQjwdxa1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:_suwY2vfhpFx9hDkoWEOk897y9QtZ3LsLGFJjnpteH3PotbxL9H4aA>
    <xmx:_suwY-cGDyDpt4My5W1USFp1NNRqp2Pjpl1T4U0wVG9dDYohCpufhg>
    <xmx:_suwY60WdFaZVrdTQrPo1oTTzdW6yaWjgnrnic5LuBRoiAWAo2BXQg>
    <xmx:_8uwY89gCf25i-fPmgQAvrUUjiUHp5fJz6RaHv0lxuWz5m-J3dNHgA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:55:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [RESEND PATCH v7 0/5] leds: Allwinner A100 LED controller support
Date:   Sat, 31 Dec 2022 17:55:35 -0600
Message-Id: <20221231235541.13568-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

[Resending because it has been a couple of months since v7 with no LED
maintainer feedback, and LEDs now have an additional maintainer.]

This series adds bindings and a driver for the RGB LED controller found
in some Allwinner SoCs, starting with A100. The hardware in the R329 and
D1 SoCs appears to be identical.

Patches 4-5 depend on the D1 devicetree series[1], but the rest of this
series can/should be merged without them.

This driver was tested on the D1 Nezha board.

[1]: https://lore.kernel.org/lkml/20221231233851.24923-1-samuel@sholland.org/

Changes in v7:
 - Use DEFINE_SIMPLE_DEV_PM_OPS

Changes in v6:
 - Drop the A100 DMA controller DT node patch, which was merged via a
   different series

Changes in v5:
 - A100 contains the original implementation, so use that as the base
   compatible string, and rename the binding to match
 - Add "unevaluatedProperties: false" to the child multi-led binding
 - Rename the driver R329 -> A100, since that is the actual original
   implementation

Changes in v4:
 - Use "default" instead of "maxItems" for timing properties
 - Depend on LEDS_CLASS_MULTICOLOR

Changes in v3:
 - Removed quotes from enumeration values
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa

Changes in v2:
 - Fixed typo leading to duplicate t1h-ns property
 - Removed "items" layer in definition of dmas/dma-names
 - Replaced uint32 type reference with maxItems in timing properties
 - Renamed from sunxi-ledc to sun50i-r329-ledc
 - Added missing "static" to functions/globals as reported by 0day bot

Samuel Holland (5):
  dt-bindings: leds: Add Allwinner A100 LED controller
  leds: sun50i-a100: New driver for the A100 LED controller
  arm64: dts: allwinner: a100: Add LED controller node
  riscv: dts: allwinner: d1: Add LED controller node
  riscv: dts: allwinner: d1: Add RGB LEDs to boards

 .../leds/allwinner,sun50i-a100-ledc.yaml      | 139 +++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  14 +
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  12 +
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    |  13 +
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |   6 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  15 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sun50i-a100.c               | 555 ++++++++++++++++++
 9 files changed, 764 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
2.37.4

