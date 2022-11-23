Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553FD6353EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiKWJBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiKWJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:01:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D278EEC0A5;
        Wed, 23 Nov 2022 01:01:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C721FB;
        Wed, 23 Nov 2022 01:01:57 -0800 (PST)
Received: from pierre123.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95C043F73B;
        Wed, 23 Nov 2022 01:01:48 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Andi Shyti <andi@etezian.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: dts: Update cache properties for exynos/fsd
Date:   Wed, 23 Nov 2022 10:01:02 +0100
Message-Id: <20221123090109.74441-1-pierre.gondois@arm.com>
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

v1:
 - exynos: [1]
 - fds: [2]
v2:
  No change.
 - exynos: [3]
 - fds: [4]
v3:
 - Update commit header for fds platform.

As requested by [5], resend patches updating the cache properties for the
exynos/fsd platforms with:
1. Fixed subject.
2. Changelog.
3. Trimmed list.

[1] https://lore.kernel.org/all/20221031091945.531874-1-pierre.gondois@arm.com/
[2] https://lore.kernel.org/all/20221031092125.533621-1-pierre.gondois@arm.com/
[3] https://lore.kernel.org/all/20221107155825.1644604-8-pierre.gondois@arm.com/
[4] https://lore.kernel.org/all/20221107155825.1644604-23-pierre.gondois@arm.com/
[5] https://lore.kernel.org/all/4f4bdc95-16a2-df76-9787-df46a3b5e1eb@linaro.org/

Pierre Gondois (2):
  arm64: dts: Update cache properties for exynos
  arm64: dts: Update cache properties for fds

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 2 ++
 3 files changed, 8 insertions(+)

-- 
2.25.1

