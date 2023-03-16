Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDE6BCB72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCPJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCPJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:52:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79A6C6A4;
        Thu, 16 Mar 2023 02:52:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32G9pmUj060493;
        Thu, 16 Mar 2023 04:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678960308;
        bh=ZelipF9icADDXzaTHp6Kp3qFHINB7rfZwnly8m4FC9A=;
        h=From:To:CC:Subject:Date;
        b=N/TzqT6AQJXUR+W8BEEevQsl9QZCzTfwMEHRZmNvW/b3frbBn8Ar16YNtX4EV/bAm
         bYRP12Qf0HCAwjNb1HeMYHS3CuHEeOHW3iQQzAp7jOvQ52pQgqMwMdSStR3aZIO0te
         qp2WmH7NwvTttH7UDfBbpUVCXVaCbzObtY2FqgGQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32G9pmVL016394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 04:51:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 04:51:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 04:51:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32G9plDn012930;
        Thu, 16 Mar 2023 04:51:47 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <b-kapoor@ti.com>
Subject: [PATCH v7 0/2] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Date:   Thu, 16 Mar 2023 15:21:44 +0530
Message-ID: <20230316095146.498999-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721s2 has two instances of 8 channel ADCs in MCU domain. Add support
for both ADC nodes in dtsi file. Add pinmux information for both
instances of ADC in board dts file.

Changelog v6->v7:
 - Created 2 commits for k3-j721s2-mcu-wakeup.dtsi and
 k3-j721s2-common-proc-board.dts instead of a single commit

Bhavya Kapoor (2):
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
  arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux information
    for ADC

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 44 +++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.34.1

