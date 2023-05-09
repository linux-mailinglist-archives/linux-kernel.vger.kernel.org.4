Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0B6FC3D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjEIKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjEIKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:24:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08DD87A;
        Tue,  9 May 2023 03:24:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349ANwo1043017;
        Tue, 9 May 2023 05:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683627838;
        bh=rTHF1tTJ7weOQLGleLLmpFp9TMG7AVgdtkZcrfyfyZM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SJaAuWz45FSR3th8AxoNcm4kL6pr7CeL9yOIrwO//18kWMuFUhTi7AKh8ejetFpTe
         azFFOJRIXh5E/CHNDkDSTdSPUbLT8KtbsKbW+RVXiZOJDTJ5yVszJGqfoefibjbW7t
         fpJmDamIQqouOF0RLSuRpDJbtvlp7lFm/IUCz/NU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ANwW5010849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:23:58 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:23:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:23:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ANvxV061704;
        Tue, 9 May 2023 05:23:57 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v4 2/2] arm64: defconfig: Enable PWM drivers for TI ECAP and EHRPWM
Date:   Tue, 9 May 2023 15:53:54 +0530
Message-ID: <20230509102354.10116-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509102354.10116-1-a-bhatia1@ti.com>
References: <20230509102354.10116-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index a24609e14d50..08679650644d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1319,6 +1319,8 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_TIECAP=m
+CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_VISCONTI=m
 CONFIG_SL28CPLD_INTC=y
 CONFIG_QCOM_PDC=y
-- 
2.40.1

