Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF66C612220
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ2KHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2KHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:07:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764F7B7AA;
        Sat, 29 Oct 2022 03:07:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DECFE5C015A;
        Sat, 29 Oct 2022 06:07:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 29 Oct 2022 06:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667038023; x=1667124423; bh=X1
        FoTzqNKN1Kmjdz4a3YhRLFY9KNaucDFaWdfFf2th0=; b=VIsSSJmS3SJ1oleOa5
        ykSLvEHrT/7b2P4YKN9oDFAxX81qyEzZDbzZWicVm9rhMzSBH44lgEkwivgpcd50
        Ap6qDtLvw2jhoSgsvz+fonG8mXnc/RvThtXBuqAb+6a44jL+ck6zPdcy4siN0z1L
        NTmNHk9tH87kRIh//ksytGP0HiBpmcx0xEqPwhLImB8mO7lWpznpbKH77hti9eGW
        9UJZQ2JA1rv2fVw+4mheQYy3tpOG47/WYWB8WVWuVjUuZyj4t/XQdcnt1npg+3S4
        g71Un2Gl42KYwuDW45VBURKhsFFQnTIqbhtpZAkOkPp6bBzSA7nEh7gIxqz2zZbs
        etBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667038023; x=1667124423; bh=X1FoTzqNKN1Km
        jdz4a3YhRLFY9KNaucDFaWdfFf2th0=; b=SyU/3aqKGtEVofaulqnCHmPyGqHlF
        co4j771E6n4PSuVUh0kz1cgJJMMfiWOpwc9rBdDf9yudb9MC4hbE7b8VBu3Vq72N
        abGOEqaZKlV8QMYcfO/b1t2uKgJXIyMtmbMGC+hE+ydinWfF+070GIXBtpxdSRjm
        GWdVF20gVBqgM8E1CyZv6DqNQiWHGNPrAM6uWGzQFsYE+QYUOs6msO2k7ZsKY1S2
        nSbz8gRFGd7F0JTxONBFuF3fBVuGUDFChIO6+PxoRHz7lcCiLQE+g6IUYumZNHyz
        la7NQXTy4HxfksJTIQtWkPjRWXcZU8cW/RG0+opadpGZY6J+UAFsxQOXw==
X-ME-Sender: <xms:R_tcY5QoSxnvDf4bA9ZWDC5r1i-ghIeL_0KblDCxeB1KYcBs1Y5asw>
    <xme:R_tcYyxb21PBAlIx8Ib71PXqyOJyrejegTrp2gqzEmJI0q3GLVDuATcuKYkRK1k_E
    SoBtpiNazO5r5sU17I>
X-ME-Received: <xmr:R_tcY-2xP_RYAVY4Z1i0Zi5h29KAwMjM3doEKrTwoc2P7PjbexfMVzzUC5C7rDU7cHBDK3ADLXjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgtggfgsehtkeertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffekhfelteeggf
    etieekteekhedtffekvddtveetgeffgfelffeftdehuefgheefnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:R_tcYxAcWQp_LlrVmo3eTZruES8G7rC-0zA-hy_1IiyvjRUAJr9u1w>
    <xmx:R_tcYygXK3J6K0hEoUqxKGRZn1avSbkaN5i9b4LSlBYghKQ7Yd3C1w>
    <xmx:R_tcY1po7dxk7m22OY7v4XlCEaaUoAFa8n-6nsH8_7yqrWpUn0ELlw>
    <xmx:R_tcY7Ztl3VmoNENOasV4Ur-xttiF9G8pNCqdLREqeTMWDThesRSVQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Oct 2022 06:06:52 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        kernel@pengutronix.de, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-imx@nxp.com, alistair@alistair23.me, amitk@kernel.org,
        s.hauer@pengutronix.de, linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        andreas@kemnade.info, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH v23 0/2] Add support for the silergy,sy7636a
Date:   Sat, 29 Oct 2022 20:06:44 +1000
Message-Id: <20221029100646.294583-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
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

v23:
 - Cleanup device tree changes
v22:
 - Rebase on master
 - Drop `ARM: dts: imx7d-remarkable2: Enable lcdif`
v21:
 - Rebase on master
v20:
 - Remove merged patches
 - Fixup Kconfig selection based on previous discussions
v19:
 - Rebase on linux-next
v18:
 - Rebase
v17:
 - Rebase and fix build issues
v16:
 - Improve vdd regulator comments
v15:
 - Address comments on the patches
v14:
 - Merge the thermal driver and hwmon
v13:
 - Address comments on thermal driver
 - Rebase on master (without other patches)
v12:
 - Rebase
v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (2):
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a

 arch/arm/boot/dts/imx7d-remarkable2.dts | 63 +++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
 2 files changed, 66 insertions(+)

-- 
2.38.1

