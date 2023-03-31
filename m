Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36C6D22AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjCaOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjCaOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:30:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AAC1F79A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680272983; x=1711808983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPeKCSq//jX/PgJO9hMQy3VzulKpWZJXnBnblAWYvII=;
  b=sD/Oid2Ob47X/qU9GbxXf2wibKCMN/sh3MsKSOsjvVBI5FFZsVe9KJzQ
   q+TX4XIATIy72MoobFaL7A74fO64+KYhKFZah1iXzhn8uZfa0KA2yMcQX
   dF5GKANbf5TqnbTWf7Sf9Z8Ob1+ylX2JvQsAOyJ3rL72diMzf8rP85kM1
   okKNeCHkQiCJWGSgkG41Jia1d8rUAJGWorBNfT/E+r+1hgwlJHlBtnN0P
   DgvfU2Ld+hA5c49o3DXdYZcJR0Mgvz5hppOhOEL2XFAc31x57c5G7u6E1
   WKkHbGNzNkjW7NP+wHktHLFK/7eBv/RQ+wgoM2B/rlr9UcGVpqdwhyyBH
   w==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="208261974"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 07:28:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 07:28:16 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 07:28:14 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 6.4
Date:   Fri, 31 Mar 2023 16:27:51 +0200
Message-ID: <20230331142751.41522-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the dt changes for 6.4. Just a few patches this cycle, please pull.

Thanks, best regards,
  Nicolas

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-6.4

for you to fetch changes up to 2c0a1faa4da5324a2ad6621b69fb7db26134b994:

  ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its maximum frequency (2023-03-30 21:20:59 +0200)

----------------------------------------------------------------
AT91 device tree updates for 6.4:

It contains:
- Update to maximum frequency for QSPI on several boards thanks
  to the additon of the new spi-cs-setup-ns property.

----------------------------------------------------------------
Tudor Ambarus (4):
      ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its maximum frequency
      ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its maximum frequency
      ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its maximum frequency
      ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its maximum frequency

 arch/arm/boot/dts/at91-sam9x60ek.dts        | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_icp.dts      | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
Nicolas Ferre
