Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2160E002
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiJZLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiJZLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:50:09 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80A71717;
        Wed, 26 Oct 2022 04:50:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A92F5320069B;
        Wed, 26 Oct 2022 07:50:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Oct 2022 07:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666785003; x=
        1666871403; bh=DYhlWWuz7xHPrgJ+GpDPXYoT7+HSDhtE2eFMNMu+ZwI=; b=u
        Do6XUZuNK1b3i2p+TtuHrNg/1S3tSDHVuXykIk0SmB8o+CUQhrUZDQ0zDkjVVxg7
        Sl/sHP6w2M257+dwpLVygl/TanvZfSWDyfni6iLISDfJc8ALpv327uRyuQwX0Zc6
        RPCDd3ZFTaaytpL4F3dkxCbjXTFwMjQQ1w81PERKz6YWOKxqE3kvcc/obCpG+U+V
        HHJ29Nlt0MghlbrDuKCVW+95hOFMkeQJWTgXZR/D/UfdmC+gRna+YLvYmOIrqhmN
        INdeqHhacepm92q8H7rpTNHyjfn3Lop+A3Qq2P/DqGb9mtGru6ENntVh5be/dbsH
        UV5qhtwqOOGTI5M1aKjZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666785003; x=1666871403; bh=DYhlWWuz7xHPr
        gJ+GpDPXYoT7+HSDhtE2eFMNMu+ZwI=; b=qrzgy+6oMJ8gzfJYFtM2OSTRa5o7j
        A6t/KoUgS8B/qZpnT+eGY7YeDYZzaHEGW22oN7CfD/uwIMO23ASZ5cCwfuP3VQD9
        uzCuLKu8hK7jsUlBEqWdC4xO4tivVnWghk2co+7uyHVwNc4W3fGeitkAOp+3SLMP
        pS3r3Cay8Nk7D1m8qzXdvYWehOOAR849OrJdYUxN5Rg1D564/eljBK1dyn99hKzP
        MwC8zjqxc5JbQaCWzPSNvAKVTEdoZgFykY2mOYRew4BvCnkdwZFAABtSXZZP5fDL
        +ZTpkAvMcE++CIb3ACiApMNmWraa0thb3sH2puEoSnqQ/csofM8vsTdBQ==
X-ME-Sender: <xms:6h5ZY770TCDsGcwSIZpoMYLxICCxJg9Q0vh0eWF8w-yhHNPrZczdYA>
    <xme:6h5ZYw4FxY_Agz1jcaAnTC-TKmUfUCsiXYX5kbIIBpSW706vnhdKIVmtw0cZx70t1
    mhsSlwdxhkdSZF8r0o>
X-ME-Received: <xmr:6h5ZYycTtv0_FZd5dlxihEAUPH3jdyVt-5VV8cIRJ9t6ORzfZZfm0vqkGBomNG8ci_quoRUn8F58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:6h5ZY8KdklrANt8pmljMukiubgdjKL0q8TlKpj3e2N6P8m22hGZegg>
    <xmx:6h5ZY_I7RTH6ImjvfyJe22HxcYVzr1aUs1LWmox9HqedCzcUnuByxA>
    <xmx:6h5ZY1yOVM5c8CPEtD8LA83iUaZfhfUta07XuTzvkEDi1t8BhJ1m-w>
    <xmx:6x5ZY5Dni_d4ct_r8GMgD5d5-LxMIfOLKD4jyCm0ZWgk_3m5sEpINw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 07:49:53 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        rydberg@bitmath.org, alistair23@gmail.com, s.hauer@pengutronix.de,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Wed, 26 Oct 2022 21:49:07 +1000
Message-Id: <20221026114908.191472-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026114908.191472-1-alistair@alistair23.me>
References: <20221026114908.191472-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6/7 based devices Remarkable 2, Kobo Clara HD, Kobo Libra H2O,
Tolino Shine 3, Tolino Vision 5 all contain a Cypress TT2100
touchscreen so enable the corresponding driver.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 078d61b758a9..8665b192d83c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -166,6 +166,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_AD7879=y
 CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_CYTTSP5=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
-- 
2.37.3

