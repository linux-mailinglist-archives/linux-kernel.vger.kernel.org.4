Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168A1627402
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiKNBGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKNBGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:06:42 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E474DEF9;
        Sun, 13 Nov 2022 17:06:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 876D0320090E;
        Sun, 13 Nov 2022 20:06:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 20:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1668387998; x=1668474398; bh=uEBG0noFadV6gn6AN44lg+OVZ
        GcqsyZ2FQ0rSLtDMQA=; b=JCMAXkW2gbLYQvtMdC2mcNuS+FizriDr+vMzCsWAQ
        H2SIFySqy0UI6h3Lho3kOmc8n+9YPGqfdDa1N14W8AJYIUdWsz3IpSszWdipPzHV
        /tf/V/yYmCyRqFCJyOWhKnMQntdnddmuLWvJ8BagYcULeeeuaOYwBIFHyQO6KeVo
        9Eaq9mJjJj3Q2PKMtTNK23/qJYFsrZt/BMIQZUeXOgLEOIHcEwTlMwD2WD4sEvCp
        q2ckBhwaF/PGRt58QtwdJkrAro90ho03h84/oJzMTCfT2CTFswBoqo2euXXAG1uI
        r5L+vzGavWtJOMI2e/BS77NjEIOG1vwqxzGWT+/xp5Q6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668387998; x=1668474398; bh=uEBG0noFadV6gn6AN44lg+OVZGcqsyZ2FQ0
        rSLtDMQA=; b=TGcn+eT7StW/coexTw6OBKS0kCHiH2sWry37jNpljYPN+Btaq3J
        SqJ+ItX1HnvK2bCpyrOVnPGLSGSGh83DM/D8YxC44Dz/Nzg6muHjMN6Kv2Ztvf3Q
        I6cBGKg0aZICkKy+BZLo0jlOBhtDxt7fGx2ss+6f9xqh0i0MkgjVCWGCFQyoeuUa
        RvCZ95klg7eb9fD1FHKMj2vOyKoUqx+kM7HD620JkN6BdbM5f+zBJfsGYmBCWehu
        nV0+yTUbfn118XoTnQq+42C8gdMzmpHpWm9xQuukmhJtMbjtXEnxRxseWtb/wT7O
        zGWO4ZJBOGv0QBZIq1Ek331PxIdGNSiciXg==
X-ME-Sender: <xms:nZRxY2Lbv2UaWvpur6JhBMG8V3LQG2h_AAZfMO0YlbTZJN2Yz0cpuw>
    <xme:nZRxY-KQGDQTJnOyQCvRMmMuKPDfgeRLaxkY6PFjzDsprIqE_ULOWafT6dTAqTLFz
    9kI_6ssJ9xQtFy56w>
X-ME-Received: <xmr:nZRxY2sUWcTme3U92sdp1mOMYvC-n17lOgTEZBsZ5wDft9a63YVqoBb19Fp7KX8c-Krz2XNj_JOYkkvai04u_eEUEKbDJht9ktWplVM3yDr4SuYQjwt9XjehRoBi1-DlTbNYNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:nZRxY7Y_zYNd7x18mxTLtCG2E4ERUdO-Ji0bAC_IZeuBjGhgt2Me7A>
    <xmx:nZRxY9ZorVEixV_MVxa44brzwk8S1paTzT7cQb-9VFiU3vgikUQS1g>
    <xmx:nZRxY3CDNE3md7poOmnENome1FaTGtREXU9zR3qOeYqy5hprPJN0_w>
    <xmx:npRxY54XMMR-9pom5CoeecSm9krmPGWnjmyjM9jKF4M10uaGYD6rrg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:06:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 0/5] leds: Allwinner A100 LED controller support
Date:   Sun, 13 Nov 2022 19:06:31 -0600
Message-Id: <20221114010636.33052-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

This series adds bindings and a driver for the RGB LED controller found
in some Allwinner SoCs, starting with A100. The hardware in the R329 and
D1 SoCs appears to be identical.

Patches 4-5 depend on the D1 devicetree series[1], but the rest of this
series can be merged without them.

This driver was tested on the D1 Nezha board.

[1]: https://lore.kernel.org/linux-riscv/20220815050815.22340-1-samuel@sholland.org/

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
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  21 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sun50i-a100.c               | 555 ++++++++++++++++++
 8 files changed, 764 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
2.37.3

