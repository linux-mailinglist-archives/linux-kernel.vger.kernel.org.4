Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3A609FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJXLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJXLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:11:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F45247D;
        Mon, 24 Oct 2022 04:11:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1F649320039A;
        Mon, 24 Oct 2022 07:11:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 07:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666609869; x=
        1666696269; bh=ynAT58+Vu0mtbcRfj1YgAHjDB2Kth/KaQbVDWU03R6w=; b=0
        DYGfdYr6RoRkVKhZJIdmWVMXdoxHKnLJ5AacM+oEApZJOKn2F4N/bNt/IBIpRln5
        C0F8PL/1wTaZkfYPqJ7t2zXu9az/aHdGpAjh+ZTXSMZREMZ92UTDV7otXV0kZHM6
        PBJMpQCKb49L/pU2rkq2cwWG1+4Hzy3352ytdks7EmcYtblepq2HH6STjL0dbVXd
        TyUPr3VIiQeKV1FmnEx7iLC/FOOwDdpfcy9oBIJfhuPNPadkrQi+qoiNvzsJsHti
        mCEcpes4/hd/HgPTzsRTPQUKB63GF5T12gXTCvq/NiQQTgEBCxmcvwfqn6TS6UWi
        QPQ/3xPLOQ0DylJyaAsLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609869; x=1666696269; bh=ynAT58+Vu0mtb
        cRfj1YgAHjDB2Kth/KaQbVDWU03R6w=; b=KADEwXXEJuMHg6ExF9TQOrKRcHgcx
        i6GVmZy3zSrQOeEdP5TZoAnnHc8d4PdJWQkOh/2jXHxTsklBMZ587bPvJM/xctkP
        9XVza3TJXS0C0okWe7pYglE/nTDI3WrQ0IGiYMZRPR+Z1r+/3wIvT4Ee2FgdEr/G
        X9i1DIW4mwvaUkpwXPFAGqgptWmCmkGt6lwYLZbX+vpdEWJltkcgXPfkeE0vyoWn
        gbYHvRy0AlwkDol2ZMF6pdx/02HuIgFr0IMoE+sQttobwVGdxDdPQFBMQ3PfVrmB
        9bohjCkBHzKtJYEZ0VmY5gt9othYlzZYSxpa2ymx8Iw8ZER90lCFId8kQ==
X-ME-Sender: <xms:zHJWY7NqZZX5tbA8K0sFYG1L3iLiqGzc6tXAHWm8Zk6JHF-sTIElDQ>
    <xme:zHJWY19cBZkJjGRSSGLCqvrzFy5PTtOVpeOxi_1hhA28pMewrc9A_EmJ0ibZLam-m
    ADjEhefsdMNJx3E754>
X-ME-Received: <xmr:zHJWY6QGOnmD0i_eJB813QytgGGvX5BUc9-EeRJNl7Rl4gqkKgDeqmFwyFPpj_qhQm1yoE189iL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:zHJWY_uXv1s6n14Zy4a8X9AzO0vtqLsVpBEejqg-OfsI72xbv0UeHg>
    <xmx:zHJWYzf8xjSF3bd5H9Ah5ExK8wjl9u1e8AhM9wRMs8KEL9tirRorOg>
    <xmx:zHJWY71p7fR2fG30hPwJEj225cJC4-3ynKdD1UxCo6NdfG3YFvbqrg>
    <xmx:zXJWYx2jyo2o6JBsXHr5KAiTCohZnmBr6HPZlzyqDQgZBAeBWoNLVA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 07:11:00 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, andreas@kemnade.info,
        krzysztof.kozlowski+dt@linaro.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Mon, 24 Oct 2022 21:10:16 +1000
Message-Id: <20221024111017.43859-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024111017.43859-1-alistair@alistair23.me>
References: <20221024111017.43859-1-alistair@alistair23.me>
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

