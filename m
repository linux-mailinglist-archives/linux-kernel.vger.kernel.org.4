Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD859646AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLHIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLHIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:41:36 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA16176F;
        Thu,  8 Dec 2022 00:41:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A844F3200488;
        Thu,  8 Dec 2022 03:41:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Dec 2022 03:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1670488890; x=1670575290; bh=ofGKFfIQd2m7ie86s3B7/ao4k
        1jGkO2oySg1tYsGzrU=; b=sfPkxjStcjTieZ6d29X5LqINXORCQAvoGOG3hdpU7
        vbHignV9KHUlHGepP/a+byTBQCU4t7/ywAnAngxM+oEJUPeghOTvbzk8AsZBp74m
        UihL6lo3/OgwHdDyQquQaQRoZZtLf7Mkd8waXCgIYfYajh4giQkyyexOwEApEbbE
        YBK4rcigJXsRE7CEtjYmVhsF23mEw7yYO8m3nMfhqMY/CY/9ETeNO0TinhrcmF3N
        rsYQPqUP+vEHeqKMtuPJmr9Un7rXifLNmTEhVTIvZbuji/0F9WIxOcj/4HOWl26r
        EvNPSUffqj10xYGLCyxbL/uw8dcnOAKxJc6OONE+zwnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1670488890; x=1670575290; bh=ofGKFfIQd2m7ie86s3B7/ao4k1jGkO2oySg
        1tYsGzrU=; b=EtyEGp1xj8J0r6bJXsjPrQAdJt74UZqAcAkohqM7xPM4p0FmEM+
        ckMFw7Mk/G+rPYM6GPI8yk3sMqPxaKnn/GOT2ksjkLss/CPf00ogoLT9N+yAK46t
        oO0Mm38AuPhD3yHBDYTd4+x5t/3tFzkFp8ln5hBWHfw9qN7IPGfgNftPEBNhV0Hb
        E854WwObGYXGxncBYSplipbAsRzwFRcu9IiyWavhz9H8PTGWBqJgSi76PdmyMXlg
        ZzhZZNSBJ3Wj0BZGbYYEG2o4vqxHy53os0WUACmngp8JzVjDXH4aJ4ubE/yjsGZ6
        XOmAYYIH8FPKp0ecj0YasAmEmf0N90YeyHg==
X-ME-Sender: <xms:OaORY8s3vjLkNzAzi1uNhT5oim0hjsBLyY8yiFYFBNTU3cBCfworSg>
    <xme:OaORY5c_OELpoa1zQz1Vd5tvtFPE0lLiZIoVtKgFlrLvaG-qpKZciZwcXcpStax04
    C4dCh56iHAl5fM7Eg>
X-ME-Received: <xmr:OaORY3wVqUNnQ0g_8SwMYYnc1j397mS-AgKMKULN4bOzKLripokxeGoIJIyY2lIheN7d3EkVHX4ZV8q4C7uHKobpP65SyDMWvVkVzkNlGayCo4XLc5GEApVXXWIWkCMYQSpNlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:OaORY_P5flMhRbXtN9r5E2Y3bwjYphMhHHFNp9T-s5EDoNLcP64n6g>
    <xmx:OaORY8-C6AOjyPwXP8dbNPmn7ohZzwXaXm8kkSek2LWX37fMNFMGKQ>
    <xmx:OaORY3VIQCkCWCmRdlj4ciR5Dh-ZVvslfumW-VNimGZXRArR6a2SUA>
    <xmx:OqORY2fUNoxh42T9FejvkMFjPVoUBSdGznsIUjw4yvX0SlRMhLj4wQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 03:41:28 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 0/4] regulator: Add support for Allwinner D1 system LDOs
Date:   Thu,  8 Dec 2022 02:41:23 -0600
Message-Id: <20221208084127.17443-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the binding and driver for one of the two pairs of LDOs
inside the Allwinner D1 SoC. I am splitting up the two pairs of LDOs to
unblock merging the SoC devicetree; the analog LDOs depend on the audio
codec binding, but they are not required to boot.

A binding and driver change is required for the SRAM controller, to
accept the regulators device as its child node.

The example for the regulator device binding is in SRAM controller
binding document, per Rob's request to keep MFD examples in one place.

Because of this, at least the first 3 patches need to be taken together
through the regulator tree, though it should be fine to merge the whole
series that way.

Changes in v5:
 - Correct the voltage calculation for the non-linearity around 1.6 V.

Changes in v4:
 - Fix the order of the maintainer/description sections
 - Replace unevaluatedProperties with "additionalProperties: false"
 - Drop the analog LDOs until the codec binding is ready
 - Drop the analog LDOs until the codec binding is ready
 - Remove unevaluatedProperties from regulators schema reference
 - Check the compatible string instead of the node name

Changes in v3:
 - Add "reg" property to bindings
 - Add "unevaluatedProperties: true" to regulator nodes
 - Minor changes to regulator node name patterns
 - Remove system-ldos example (now added in the parent binding)
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity
 - Require the regulators node to have a unit address
 - Reference the regulator schema from the SRAM controller schema
 - Move the system LDOs example to the SRAM controller schema
 - Reorder the patches so the example passes validation

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

Samuel Holland (4):
  regulator: dt-bindings: Add Allwinner D1 system LDOs
  regulator: sun20i: Add Allwinner D1 LDOs driver
  dt-bindings: sram: sunxi-sram: Add regulators child
  soc: sunxi: sram: Only iterate over SRAM children

 .../allwinner,sun20i-d1-system-ldos.yaml      |  37 +++++
 .../allwinner,sun4i-a10-system-control.yaml   |  28 ++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sun20i-regulator.c          | 156 ++++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   3 +
 6 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

-- 
2.37.4

