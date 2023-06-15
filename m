Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FB77315BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbjFOKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjFOKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:48:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA581FC7;
        Thu, 15 Jun 2023 03:48:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAm4Dn078370;
        Thu, 15 Jun 2023 05:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686826084;
        bh=ZTwnmyq57fNfahfoTZSZG4Z5uSs4RrRwPyAA4yhelgQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YDptHJ9Fh/CMoTETDkt0tPjoDmTE56VuHeuBQVZ/jMDzSNybyXIwtBvJEgP/NBJGA
         aDcEw8h7fnQLF+47rocnYc85Jiat5+lZA4pi7OGcGgu+fJ7Up0B8vZjGJe21ZcGngn
         6NPuv2/bH+Ok67GKIF9Udu/B5YffbeQ6KOXaIcBk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAm4fV092952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:48:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:48:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:48:04 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAm085084939;
        Thu, 15 Jun 2023 05:48:01 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashes
Date:   Thu, 15 Jun 2023 16:17:56 +0530
Message-ID: <168682606306.2285484.2419811801756393008.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504080305.38986-1-a-nandan@ti.com>
References: <20230504080305.38986-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi Apurva Nandan,

On Thu, 04 May 2023 13:33:03 +0530, Apurva Nandan wrote:
> J784S4 has S28HS512T OSPI flash connected to OSPI0 and MT25QU512A QSPI
> flash connected to OSPI1, enable support for the same.
> 
> Changes in v3:
> - Split the SoC dtsi changes and EVM dts changes into separate patches
> - Added QSPI flash node and partition information in EVM dts
> - Removed address-cells = <1>; and size-cells = <1>; in OSPI0 flash node
> - Add flash partition information for OSPI flash.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add FSS OSPI0 and FSS OSPI1
      commit: 8758109d135401c8afea0d0e3c51e7a52c843b7b
[2/2] arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashes
      commit: 150ce1b10740c10f87e90e485bc279c205e3f731

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

