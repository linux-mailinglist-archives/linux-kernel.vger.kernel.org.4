Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCE634192
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiKVQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiKVQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:32:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB69662D8;
        Tue, 22 Nov 2022 08:32:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6644B1FB;
        Tue, 22 Nov 2022 08:32:37 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE2103F73D;
        Tue, 22 Nov 2022 08:32:28 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] arm/arm64: dts: Update cache properties for broadcom
Date:   Tue, 22 Nov 2022 17:32:05 +0100
Message-Id: <20221122163208.3810985-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the v3 of the update of broadcom dts:
  https://lore.kernel.org/all/20221107155825.1644604-7-pierre.gondois@arm.com/

v3:
 - Update the missed dtsi: bcm2836.dtsi, bcm47622.dtsi, bcm63148.dtsi,
   bcm63178.dtsi, bcm6756.dtsi, bcm6846.dtsi, bcm6855.dtsi, bcm6878.dtsi
 - Split the patch between arch/[arm|arm64] folders

Note:
As the 'cache-unified' property is only required by the DT spec when there
is one of these properties in the cache node:
 'cache-[size|line-size|block-size|sets|level]'
the 'cache-unified' property was added only when necessary, cf:
  https://lore.kernel.org/all/433efe6b-858f-6777-0f46-fdf4f4a7e0ca@arm.com/#t

Pierre Gondois (2):
  arm: dts: Update cache properties for broadcom
  arm64: dts: Update cache properties for broadcom

 arch/arm/boot/dts/bcm2711.dtsi                      | 1 +
 arch/arm/boot/dts/bcm2836.dtsi                      | 1 +
 arch/arm/boot/dts/bcm2837.dtsi                      | 1 +
 arch/arm/boot/dts/bcm47622.dtsi                     | 1 +
 arch/arm/boot/dts/bcm63148.dtsi                     | 1 +
 arch/arm/boot/dts/bcm63178.dtsi                     | 1 +
 arch/arm/boot/dts/bcm6756.dtsi                      | 1 +
 arch/arm/boot/dts/bcm6846.dtsi                      | 1 +
 arch/arm/boot/dts/bcm6855.dtsi                      | 1 +
 arch/arm/boot/dts/bcm6878.dtsi                      | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++++
 19 files changed, 22 insertions(+)

-- 
2.25.1

