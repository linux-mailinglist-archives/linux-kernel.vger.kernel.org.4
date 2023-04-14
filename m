Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4C6E214D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDNKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDNKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:52:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E749E3;
        Fri, 14 Apr 2023 03:52:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EAqTfk050230;
        Fri, 14 Apr 2023 05:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681469549;
        bh=gXHlTLHMhCpA2CPdobmUa19vBRFU9p8ydVXafd7CETo=;
        h=From:To:CC:Subject:Date;
        b=ON/OWQqJGFCTCZ9BblZLXcfmwGdD3yexI1kcT4p9vt+ei8y4dj6NkHzmzesKHnV42
         Fv5f9ExAaSfLlHgtNxJDbITECPyH7XIWcX7zOJZgYX48Lp2B9LGr4gTxn7JZ4zab0f
         OEhU1R3u9MHjE8C+4UhKv7rKbQmxxDz6gBguSxlk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EAqTVQ114075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 05:52:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 05:52:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 05:52:28 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EAqPpe077262;
        Fri, 14 Apr 2023 05:52:26 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <u-boot@lists.denx.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH 0/3] Add support for ESM
Date:   Fri, 14 Apr 2023 16:22:22 +0530
Message-ID: <20230414105225.194195-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ESM (Error Signaling Module) is a fundamental IP responsible for
handling safety events. The driver currently present in U-Boot is
responsible for configuring ESM. This patch series adds dt-binding and
nodes for J721E and J7200. This goes towards end goal of having DTB sync
with that of U-Boot as well as ensuring completeness of hardware
description in devicetree.

Neha Malcom Francis (3):
  dt-bindings: misc: esm: Add ESM support for TI K3 devices
  arm64: dts: ti: k3-j721e: Add ESM support
  arm64: dts: ti: k3-j7200: Add ESM support

 .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
 4 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml

-- 
2.34.1

