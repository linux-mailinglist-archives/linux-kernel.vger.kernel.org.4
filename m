Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742AB65B8E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbjACBcB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Jan 2023 20:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjACBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:31:55 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F406199;
        Mon,  2 Jan 2023 17:31:51 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3B73924DF03;
        Tue,  3 Jan 2023 09:31:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 09:31:49 +0800
Received: from ubuntu.localdomain (113.72.146.202) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 09:31:48 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] Temperature sensor support for StarFive JH7110 RISC-V SoC
Date:   Tue, 3 Jan 2023 09:31:41 +0800
Message-ID: <20230103013145.9570-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.202]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds temperature sensor support for StarFive JH7110 SoC.
The last two patches depend on series [1].

[1]: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/

Emil Renner Berthing (4):
  dt-bindings: hwmon: Add starfive,jh71x0-temp
  hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor
  riscv: dts: starfive: jh7110: Add temperature sensor node
  riscv: dts: starfive: visionfive-2: Add thermal-zones

 .../bindings/hwmon/starfive,jh71x0-temp.yaml  |  75 ++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sfctemp.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 .../jh7110-starfive-visionfive-2.dtsi         |  28 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  13 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sfctemp.c                       | 350 ++++++++++++++++++
 9 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
 create mode 100644 Documentation/hwmon/sfctemp.rst
 create mode 100644 drivers/hwmon/sfctemp.c


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
prerequisite-patch-id: 4dc515731ce237184553c1606ffb3afaeb51c3d8
prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
prerequisite-patch-id: a798370d170dc2bcc79ed86f741c21c1e6d87c78
prerequisite-patch-id: bd9fd8b5cb2376dc7a5e08e1a1fbb969cf475926
prerequisite-patch-id: c57ebb83bc43ccd2a8366ff166eb499da1e1d2cf
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 94860423c7acc9025249d4bb36652a585bd0a797
prerequisite-patch-id: b5084253283929d9a6d0e66c350400c7c85d034d
prerequisite-patch-id: 6e369dbe9dca2785e4ea7d0b80e525e227a90a6e
prerequisite-patch-id: e08806183c152714c563f3a21c6d7b2f539c4d6e
prerequisite-patch-id: 79db8036abdc48fd36da227652ec62627a6b548b
prerequisite-patch-id: 06971b8e6bddc0e87e63bfdb0ce8bfb653bd73aa
prerequisite-patch-id: 16309a0e23811a2c55d2e56886de3e8eccc51554
prerequisite-patch-id: bf4f7ab0b6cfa90b6e49e66c7d75ed2eaaebbe78
prerequisite-patch-id: 38468d532e87867990055d3320679f18c5f52278
prerequisite-patch-id: 4710f2ac22dca0bdd9ff5d744d2c37cab3c74515
prerequisite-patch-id: 6bb9a780c62af3bcc2368dfd20303c7b1bc91e23
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: a2b3a9cff8a683422eb0ccf3a0850091401812d4
prerequisite-patch-id: e0ba7af0f8d3d41844da9fbcba14b548cbc18f55
prerequisite-patch-id: bc0176325c11a632c6abaa83e54e891cc92d1c74
-- 
2.38.1

