Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C07249F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjFFRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbjFFRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:15:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2980B18E;
        Tue,  6 Jun 2023 10:15:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356HEiRw057354;
        Tue, 6 Jun 2023 12:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686071684;
        bh=/+aT73LDBXI0ipR5eTaYxAJSmTBn/FoWO8VadiHta7o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nuzWGhJt2mnC5QMOipag053U6Myld9lAy/iX/OXKDgY6JkytRvgB9/4b4F5j4OIqR
         mQz1whstvVMShqAC9K8oZw22yjpojwUV38AR3gZH62IQ4kFNPBMJhQCzEaI3RBFEjr
         Q2RgW0QbN2ew6fbJGlQROA+Jil9SPYT6kjA3Zhz8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356HEilF047665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 12:14:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 12:14:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 12:14:44 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356HEeY3099045;
        Tue, 6 Jun 2023 12:14:41 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/10] arm64: dts: ti: k3-am64: Add missing properties used in u-boot
Date:   Tue, 6 Jun 2023 22:44:33 +0530
Message-ID: <168607161906.2072651.15382306818493912009.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi Nishanth Menon,

On Fri, 14 Apr 2023 02:33:18 -0500, Nishanth Menon wrote:
> while attempting to cleanup u-boot, I noticed that u-boot had some
> additional nodes that were'nt in kernel.org, and this makes syncing the
> kernel.org patches back to u-boot hard.
> 
> So, sync the same.
> 
> Bootlogs: (SK and evm)
> https://gist.github.com/nmenon/6b09f55251225d3f3cce076c32a33bba
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/10] arm64: dts: ti: k3-am64: Add general purpose timers
        commit: 9972b45776aba937d0db67f8080ec627a924f56e
[02/10] arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
        commit: 744545ffec14f74f26f57828afa685f6f4eadd9e
[03/10] arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
        commit: 1d79ca01e62096e87686244cdf4864f338ccd200
[04/10] arm64: dts: ti: k3-am642-sk: Describe main_uart1 pins
        commit: c8da2f207168d2c93f7fa7bff92f6b395c342e4a
[05/10] arm64: dts: ti: k3-am642-sk: Rename regulator node name
        commit: 826b6679bd08694ad7a830eb30608c3e5a780941
[06/10] arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
        commit: cf3b25bc3cc0b66cfaae9614620228a5c2246ecb
[07/10] arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
        commit: e3e1d9ab65ebbd95907b6951637cd6809c69afc7
[08/10] arm64: dts: ti: k3-am642-evm: Rename regulator node name
        commit: 61ee5572075dfc16b480103763091b603cb06aa1
[09/10] arm64: dts: ti: k3-am642-evm: Add VTT GPIO regulator for DDR
        commit: aca16cefdd25cdcd284212f840b70b07101f2548
[10/10] arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases
        commit: bb3d657872215942cf87dd194904a7543fce3cc4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

