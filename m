Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A4718EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjEaWs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEaWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:48:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3B121;
        Wed, 31 May 2023 15:48:46 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMfK068354;
        Wed, 31 May 2023 16:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685568742;
        bh=mvrqv5sj2sxCtu4TaCGy4a9IkYJAZkzFsgPjVhpkiPo=;
        h=From:To:CC:Subject:Date;
        b=XUtZ5jWgodW2jRdyRREB8vjenpA3izi5GoYujqkmKtRF+5bvlIAxdEuNvJ0AQgL5Y
         XQEPIKivVSvNo7EgtngJQGnKatdExlxJa8p40f7JoPh32oI6/4g93SJ4e2UhlyNqm/
         HLcEOy7c62aBXc0hpMlzVyEHVmxS/eSw0DuP+qds=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLWMY4047060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:32:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:32:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:32:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWLfV105102;
        Wed, 31 May 2023 16:32:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] arm64: dts: ti: k3-j7*: Add general purpose timers
Date:   Wed, 31 May 2023 16:32:09 -0500
Message-ID: <20230531213215.602395-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Add pending general purpose timer support for various J7 family

Full list of K3 SoCs:
* AM625: already merged
* AM62A7: https://lore.kernel.org/all/20230418012717.1230882-2-nm@ti.com/
* AM64: https://lore.kernel.org/all/20230414073328.381336-2-nm@ti.com/
* AM65: already merged
* J7200: https://lore.kernel.org/all/20230426103219.1565266-1-u-kumar1@ti.com/ (needs a respin)

And the timers for remaining J7 platforms (J721e, J721s2, J784s4) are
addressed in this series.

Nishanth Menon (6):
  arm64: dts: ti: k3-j721e: Add general purpose timers
  arm64: dts: ti: k3-j721e: Configure pinctrl for timer IO
  arm64: dts: ti: k3-j721s2: Add general purpose timers
  arm64: dts: ti: k3-j721s2: Configure pinctrl for timer IO
  arm64: dts: ti: k3-j784s4: Add general purpose timers
  arm64: dts: ti: k3-j784s4: Configure pinctrl for timer IO

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 258 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 161 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 258 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 162 +++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 258 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 162 +++++++++++
 6 files changed, 1259 insertions(+)

-- 
2.40.0

