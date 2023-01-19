Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E4673405
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjASIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjASIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:54:51 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAFB6E96;
        Thu, 19 Jan 2023 00:54:49 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MHnyM-1pXKPO2Kb0-00Eqzc;
 Thu, 19 Jan 2023 09:54:33 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v1 1/2] clk: imx6sll: add proper spdx license identifier
Date:   Thu, 19 Jan 2023 09:54:20 +0100
Message-Id: <20230119085421.102804-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230119085421.102804-1-marcel@ziswiler.com>
References: <20230119085421.102804-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GL2rVT1JpqMd06MBhb1IBAtTIz0M492IhxLsitDd6WeuTyBlAKe
 t/SnNg0eLxYXzBrOdrC5iH2Pa+Cbnf00EVKe5G9N21OsAXQZRwY6DPR8DSiJry1Oh47o8HM
 +XJNHHHF/aNHU5Y3DqZJx+CZHMRLwsQ6/Mwfky5ODwMtzs3t03+NJ+JrZn7krRY1+1bVbcA
 CfnjzHWB3E5trFWT0K2fg==
UI-OutboundReport: notjunk:1;M01:P0:2xG9WqZAkDc=;9aMwXrI9nWkTRDmTbyMV3x28PrX
 AqQJy7AkIvhIHOUzLedc1YVo3B1ai39V47uq3cr6BrUa9PZcyoRQpZfye2SiXflITcyHLvE0B
 QhPRNBQ4VU3/sBRzFlLDCEvUUQgX3XyZ2eEi0hynXs9QN9RbLPI7I4X0mD9GDcPH9uUzgEGwH
 0EbOLHMU6jWnAi/X1U4VYLbZabCOSVg34A4XWU0cdP3e7e4+Ea215qAN2405CWND4/cDf6LPt
 JLWnqV973nFYhIvMmFRmrNRP6uEzUUnit5aoqdBNaAyJx1VVYUcakIZ1ntD1Z4qonyAMlNIF9
 F1F/hhUKezrtlikZme160Cvicy8ehVhudewXs2aRBuBm18o/ePndhdES9GqpD3cewkD9hiOuT
 9b8pIlV16odbByavhDLPZ3V8xUOizDOurWNa0+2CJAYlyR+imJQIeSMZ4nb/LjVHI9lUE0DnP
 hfi01ikpDnQX4b15fAopT2sQYHsFnOIovlIfhWG7onKxltkbZIQQqdPWeCsFwm2zJ4BLR1ew7
 W8NhhLrNt8KCxkTx7DHdHRreu8iDRBa36drgnz9JvyGWT/3sG+rsBu5ju/vuOtYWwYigIYXEi
 SyQAHtqWpwnOpnN+lHDe1mzL4g8pb/x4A3MRyQZaH756Z/HgwP9o3v5FuvKM/fgon+9gds0I6
 Dx3GEKNUEUTZWd9/kQgKDfoPnbghyfeL51x9n7+ClQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error:

include/dt-bindings/clock/imx6sll-clock.h:1: warning: Improper SPDX
 comment style for 'include/dt-bindings/clock/imx6sll-clock.h', please
 use '/*' instead
include/dt-bindings/clock/imx6sll-clock.h:1: warning: Missing or
 malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 include/dt-bindings/clock/imx6sll-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index f446710fe63d..494fd0c37fb5 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  * Copyright 2017-2018 NXP.
-- 
2.36.1

