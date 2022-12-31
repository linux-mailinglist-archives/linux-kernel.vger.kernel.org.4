Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BBF65A5A5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiLaQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiLaQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:04:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F6E36;
        Sat, 31 Dec 2022 08:04:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E17505C00CA;
        Sat, 31 Dec 2022 11:04:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 11:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672502644; x=1672589044; bh=xWE0lT6NaS/AHVoUWn03I8qZ2
        RF4KER8K841iF6ca5E=; b=ERRgjIq669xz32IXLnN4VpdajHn1WgfVzs/8rY3NO
        bjeZ/v3UgLJYT/qISuvf8LbiCetSVa9p3FeVfQ2pWvXZ/cJw63MLSTGoC4WrIRZ3
        hUlHZvG61TgTFaO7MfOnmTj9/a4G+EAmEcS+ZYHK5uMrZuFmWlp0P9Q8Gs8HdrMM
        kFCn3iQckWrV8BNjmx+KNDUN2Qo5AXHcMEWpkETFFfJgQK8rk+dEGOZLOJZ4gmxi
        UWhr/TzdqFDlu76w7ZqWMUISlR8AsMCp9pCjacF6A/j+MoNFz4R+AgEk481QfbOm
        DN7Y8QdOQ5Xin5ql4hiOZtfkrh+rHK8lY2Lr+lkz+4dEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672502644; x=1672589044; bh=xWE0lT6NaS/AHVoUWn03I8qZ2RF4KER8K84
        1iF6ca5E=; b=YoEROOA9LgPRbDQQqDVGZ8OGREl/8S4SZ0324CF/Z4piDyCosbs
        9/OHg+kyevz6h0cMSJQ0JOfsiU2s9QVU6339P0XU9PNY7Z1BUi3dmE+jc9iECMz5
        njOzNrwXqIz4iBNfDblH77GGBgp9hjEQ6UUb0X0H3cqgqxHUijyoQH0OwK1K4gkM
        MpU30CchqyVVlIYghdlMmx51luUnWdXTb2pO+F71owsGG56aP4QLaMSS0hXrAAPm
        Fx9cG2EcPKY2//lnR90tB4DQuiV39l4BPVRURJrzSxXaVxoBzKdKn54V9bgIbENw
        x0mD+9TUsO7pb8JNO7wsTSrmjQj+BUTcHLQ==
X-ME-Sender: <xms:dF2wY_7_Mf68KkLvmZC2aN7VDfUnfEBu_x-cb9raTV03acELQNws3Q>
    <xme:dF2wY05PZrHxy_Ox3iLcP296ICPJAKO6e-wMsSEJUZMox13hAHLlQ0XFYcOJXIBST
    s6JPvi8pjFdKmcIrA>
X-ME-Received: <xmr:dF2wY2cwGCsgDO7o-sQpUZVKVFDtzipr09zOhWJZ53A1X2ouI07uc3RMauwmv_M1VHN38-bt_V-k_BUNpVR8Xjun8cTEoWpSxS1uvMe8B1VT5VfpNxYyR9djkCV8oCfDaPcRqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpedvtdelueegfeejtedujedvudejteetheevleekvdfgteegtddvieekudfh
    leegveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:dF2wYwKSoEqCMqsBPfG1Q37erLSM6cFyWf7WUMjmUpT6vIqCpCwZsg>
    <xmx:dF2wYzK7p5v0UsIVKOms0fu1AEnqfJhIJIHikPBjqXdtA7IRJfEXug>
    <xmx:dF2wY5w8mGeSa6wEjy-sz9s7wqvjSfEI4LQTjlSJtnLaGpjpAIhlzw>
    <xmx:dF2wY68A4Oc5AsQeFMiZBXnqpUl9_Z1lb-AarT-6xdPVc6PjT-wOWg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:04:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] Allwinner power domain support
Date:   Sat, 31 Dec 2022 10:04:00 -0600
Message-Id: <20221231160402.16157-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the power controller found in D1 and other
recent Allwinner SoCs. There is no first-party documentation, but there
are a couple of vendor drivers for different hardware revisions[1][2],
and the register definitions were easy to verify empirically.

I have tested this driver on D1 with the video engine. There is no DT
update patch here to avoid dependencies between series. The example in
the binding is what will go in the D1 DT.

[1]: https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/gpu_domain.c
[1]: https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/pm_domains.c


Samuel Holland (2):
  dt-bindings: power: Add Allwinner D1 PPU
  soc: sunxi: Add Allwinner D1 PPU driver

 .../power/allwinner,sun20i-d1-ppu.yaml        |  54 +++++
 drivers/soc/sunxi/Kconfig                     |   9 +
 drivers/soc/sunxi/Makefile                    |   1 +
 drivers/soc/sunxi/sun20i-ppu.c                | 207 ++++++++++++++++++
 .../power/allwinner,sun20i-d1-ppu.h           |  10 +
 5 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
 create mode 100644 drivers/soc/sunxi/sun20i-ppu.c
 create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h

-- 
2.37.4

