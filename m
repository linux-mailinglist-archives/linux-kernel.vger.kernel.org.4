Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B96EEE06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjDZGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDZGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:07:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481B5269E;
        Tue, 25 Apr 2023 23:07:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33Q66R2b080658;
        Wed, 26 Apr 2023 01:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682489187;
        bh=NobemyBvtwjcU/aS5ZCzDkB7/FGzb5hRLrC1qI4I3KY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qeKJaFgIxXLvNp2SXhBsgXIIxMusoMEK4AKQQQm1hSyY48WwePnKFu4hJF2L2WYD3
         URjabiCWBCY7mxcKppBI/65UQODoRR+6m5P0bE/GpAqK3mDyW3d54+vy0xFDATQmrm
         f3Qntjrjy9oZnS6tNtMnjhdelokvflAwtQ+c/OtQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33Q66RlK026577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 01:06:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 01:06:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 01:06:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33Q66QTH073579;
        Wed, 26 Apr 2023 01:06:26 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 2/2] arm64: defconfig: Enable PWM drivers for TI ECAP and EHRPWM
Date:   Wed, 26 Apr 2023 11:36:12 +0530
Message-ID: <20230426060612.19271-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230426060612.19271-1-a-bhatia1@ti.com>
References: <20230426060612.19271-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's K3 SoCs uses the Enhanced high resolution PWM (EHRPWM) and the ECAP
modules for generating PWM signals, used in various application.

One such example is controlling the backlight power of the display
panels connected to the EVMs.

Enable these modules.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..dd8094eef17f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1283,6 +1283,8 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_TIECAP=m
+CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_VISCONTI=m
 CONFIG_SL28CPLD_INTC=y
 CONFIG_QCOM_PDC=y
-- 
2.39.1

