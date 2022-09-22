Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60E15E6873
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiIVQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiIVQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985D5A16C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:30:16 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MOAS5-1ovYPG38x7-00OWZr;
 Thu, 22 Sep 2022 18:30:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] arm64: defconfig: enable i.mx 8m plus specific interconnect support
Date:   Thu, 22 Sep 2022 18:29:25 +0200
Message-Id: <20220922162925.2368577-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4K2CiASRm10l0XKdAq/HYXf+5TSZ6MLfNp14Z/nNcTNIO1j0R6K
 Ar7j3BzsCUNzC6LDKfzoGsZGnNMygYjdyXdESuHM/PuBFRmpVSZxt2Ug8dBEBrGdJQjL6i/
 H28uB+NeUDnY+a+hiBBOCk2Xj9c8oASQ6OSdEgVw6s62rFxAxi+Xv6ugtm2iybPN0gJojbe
 AcjB+ARiQjyXT0L7rFpsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZ8XqNcfcVM=:2I/aROTHKLF1RQ9X6vpnmP
 HPbWGws0pADbng98MxItz/mzKcJTTIJMAud3cTrWXUrcy3RMiYM8U9CxFyArCRA8/wzqfnppI
 n0LNKKJx9GMpIFJKvWGSTOneNFbL9h7u9s+sSog9e9dy3jQITXMWASshMOaHNUqMbGtc7D/Zy
 Aaotlfn0UuW2k4bG1DJFgXFJZ/SwH/yOTES2rwmh/QAOpNjh+J+zZNTuRK/q0mPwzj19utPkQ
 t4rkCJe8Ud3iNhnbh7Y9Nk452dgSTH4OU1QK6mo1xwe5NZXlgltWytwQYrMhj4O3akVcsWP4A
 rjKVTg06bPwX9nEPB/RJyWZv1WP5w+VQ8/2TjkLPHDlHNTiMmt35u546JELZr2Ud4CjNH9amd
 pefuW3xw+uRGg28jeJleTQzjogUeAfU7ZTHk0AD6W4LU/eVxnt70c4C/K+6qMZEu45q8Y3hXI
 pMTPU9pyrFNnNjWrY3QCqrs8XwVJAHbP4XNaWmPiEBjTgzx3MAyPfEEv88Ph1/MNTH0Ii5AMj
 7gKg/rxCAOjWURUKLh03UDxK5lhNtKhZ/YO7nXncqVtVkMMhQSn2fpR+27/FWgaU0QvPxOrFK
 L0yN68tdk88FWpq30yn2+aJHXhDwN4p8x1tlspwSM0SrIlCGk7jMdrF05Z/udO8kY3jFZDIZa
 MTy5cB4QPrv7rmDEqW8fDfMDwVEkR8tGU89UMfBc+bbIRBw0B7PnHHg2cprlAk2fQ2WTh5gO9
 eqHxXlOgpCoakpmdPePHZ8HD3FL+uABuqjOKgu46+5ei5MW+4wIgIdhqCJA9BxC8sz1/saQtE
 ky5v5W2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build CONFIG_INTERCONNECT_IMX8MP as a kernel module without which one
may get the following after boot:

[   15.728019] platform 32f10100.usb: deferred probe pending
[   15.733471] platform 32f10108.usb: deferred probe pending
[   15.738895] platform 381f0040.usb-phy: deferred probe pending
[   15.744668] platform 382f0040.usb-phy: deferred probe pending
[   15.750437] platform 33800000.pcie: deferred probe pending
[   15.755944] platform 32ec0000.blk-ctrl: deferred probe pending
[   15.761807] platform 38330000.blk-ctrl: deferred probe pending
[   15.767673] platform 32f10000.blk-ctrl: deferred probe pending

And things like PCIe and/or USB stop working.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 521c784463bb..8ae4cbcb971c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1263,6 +1263,7 @@ CONFIG_INTERCONNECT_IMX=m
 CONFIG_INTERCONNECT_IMX8MM=m
 CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
+CONFIG_INTERCONNECT_IMX8MP=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
-- 
2.36.1

