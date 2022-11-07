Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7961EA6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKGFcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKGFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:32:50 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4013FDED9;
        Sun,  6 Nov 2022 21:32:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A7F3A5C00A3;
        Mon,  7 Nov 2022 00:32:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 07 Nov 2022 00:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1667799168; x=1667885568; bh=6V6QlHLGLw2oRr9jPgc9OjO2T
        eOPpJbgq8qGN4VXflk=; b=ZZ6P/iPDkK/QMpgmXyx6+tiw+rt6GaIUHB5krFnNI
        hal0ibWG8E8BBTcV+BOt8Xmuu86JiaH5e2Lfl0LzKtgR6e6yuR1Kipf6P8uU23Oe
        uBkT/EgyDwlAc4Q5aZ38aYMZ3ZjSjssDc6UUsXlJwYdoOCaI+54zg20Wxhe3dsDP
        1xVSUG0saM8rQNT0vutOeH2E9kO4xFviTZxgGNqlNquLRkgNoIU67WcKeHXzOqiJ
        Wg7I3aEW1PLyQj+fvNlfODPcaAMPQqh4LIJN0ykZRxNZ8QOiYJrkI64thJquX2ht
        97rtdnbtVeuMYM+/HCQg6iaItFQcYLctqJ1rqyfupAG+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667799168; x=1667885568; bh=6V6QlHLGLw2oRr9jPgc9OjO2TeOPpJbgq8q
        GN4VXflk=; b=G3H1WImmm0vDfT8lVkcqqNKqa+nE+NeBwRxKLrMoWNnQXOkviGW
        MmmjECmS4bsT/Mm791hrBxdMgUQVfgdhdajdt00FjniEjhBWdPQ6Q+0RoCdRQfZB
        rRXgUX8xAibyvywhbUSjrApPepaybd4AO59mQg4y7ZOVjTF3/bNB84evstXKxzXv
        6aVnGUvPvYI+hYPnLu7zUOZkG1n786Fg6uyQ2HmIWO5u3L0zqd4obztKbiFY0Lxq
        9dak7xi00q+2dEnCDC/JDK/ZYcKoWpd7Y8r2SEVQ5rdc0W4IXx/zD3k/6i8VuDk/
        xRN5M0cQJf0hEo/YfhOyjyzjIDYMTbgfH5Q==
X-ME-Sender: <xms:gJhoY4n7AehjkRmfxvr-stc8onj90fzux4Ob1NsQF0K9hK16WMgdbQ>
    <xme:gJhoY31LF4lknYUgq_nzkRNVncJsZuxKSL9eX8FvHNOBfWb8BFG68spyQROiiJ4kL
    93ik1OzKopX_f-hvw>
X-ME-Received: <xmr:gJhoY2rKWUGlpwM5iJC87SjwFod9i1_kNos-446sb4y1iM3NzLtUgRNgKUZin-lHKjkxx_VI8gaP2LkDAtDKZ_y5rXDqXDmLWgyA9xQEpKkdv5CNZsOAduloloYp5Kg-P64iTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:gJhoY0nXsUnC5akjjWLv_vH8m0NXb3yVruKN23N_2vTZiCuasv1NVw>
    <xmx:gJhoY20EtCmS0c6XMKUMYnNDBkQ4lKZzif1R5IxOBXkbC8hLEdl0XQ>
    <xmx:gJhoY7tsAplFnUySLb5UnMtq8zWpUVJjvIhLDVA5UI7ZDYWnhY7QKQ>
    <xmx:gJhoY_mujgSloETcokPqzX0js1xF-pvOdqDPGVL21z4ivQASBYh_PA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:32:47 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 0/5] leds: Allwinner A100 LED controller support
Date:   Sun,  6 Nov 2022 23:32:41 -0600
Message-Id: <20221107053247.1180-1-samuel@sholland.org>
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

This series adds bindings and a driver for the RGB LED controller found
in some Allwinner SoCs, starting with A100. The hardware in the R329 and
D1 SoCs appears to be identical.

This v6 is effectively a resend. v5 received no feedback since August.

Patches 4-5 depend on the D1 devicetree series[1], but the rest of this
series can be merged without them.

This driver was tested on the D1 Nezha board.

[1]: https://lore.kernel.org/linux-riscv/20220815050815.22340-1-samuel@sholland.org/

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
 drivers/leds/leds-sun50i-a100.c               | 554 ++++++++++++++++++
 8 files changed, 763 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
2.37.3

