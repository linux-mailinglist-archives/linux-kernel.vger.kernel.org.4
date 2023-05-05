Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829476F7F86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjEEJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjEEJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:06:03 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DB18934;
        Fri,  5 May 2023 02:06:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 79DFE24E1F4;
        Fri,  5 May 2023 17:05:59 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 5 May
 2023 17:05:59 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 5 May 2023 17:05:58 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Samin Guo" <samin.guo@starfivetech.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v2 0/2] Add motorcomm phy pad-driver-strength-cfg support
Date:   Fri, 5 May 2023 17:05:56 +0800
Message-ID: <20230505090558.2355-1-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motorcomm phy (YT8531) supports the ability to adjust the drive
strength of the rx_clk/rx_data, and the default strength may not be
suitable for all boards. So add configurable options to better match
the boards.(e.g. StarFive VisionFive 2)

The first patch adds a description of dt-bingding, and the second patch adds
YT8531's parsing and settings for pad-driver-strength-cfg.

Changes since v1:
Patch 1:
- Renamed "rx-xxx-driver-strength" to "motorcomm,rx-xxx-driver-strength" (by Frank Sae)
Patch 2:
- Added default values for rxc/rxd driver strength (by Frank Sea/Andrew Lunn)
- Added range checking when val is in DT (by Frank Sea/Andrew Lunn)

Previous versions:
v1 - https://patchwork.kernel.org/project/netdevbpf/cover/20230426063541.15378-1-samin.guo@starfivetech.com

Samin Guo (2):
  dt-bindings: net: motorcomm: Add pad driver strength cfg
  net: phy: motorcomm: Add pad drive strength cfg support

 .../bindings/net/motorcomm,yt8xxx.yaml        | 12 +++++
 drivers/net/phy/motorcomm.c                   | 46 +++++++++++++++++++
 2 files changed, 58 insertions(+)


base-commit: d3e1ee0e67e7603d36f4fa2fec6b881c01aabe89

-- 
2.17.1

