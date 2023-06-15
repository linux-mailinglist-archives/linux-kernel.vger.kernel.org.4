Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CD7319AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjFONOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFONNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:13:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B52949;
        Thu, 15 Jun 2023 06:13:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDDPfT010754;
        Thu, 15 Jun 2023 08:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686834805;
        bh=M7CeXsp0hI8eJl4yv7H32Sa2Shs0XQoJyWaQVxvyiA0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ybkxGjP0ipsCC8AF00VLoCDEe7Im+x3N88dnHtMOoLWKUzUjPaYn0VL/PBSxpYoLK
         dWeNVHkFVhM/hFSG5p4w/0H8y99ZAivGQD5gWN9aNDnbBkH8OfaJTuILXcG7FYKT1x
         gr6fpsIUvxcCeJo+HoYgP/3puFEpMKoK0A23SWIw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDDP0H128431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:13:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:13:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:13:25 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDDLIM055309;
        Thu, 15 Jun 2023 08:13:22 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 0/7] arm64: dts: ti: Add additional secproxy instances
Date:   Thu, 15 Jun 2023 18:43:20 +0530
Message-ID: <168681817155.2098323.11372041300861131434.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530165900.47502-1-nm@ti.com>
References: <20230530165900.47502-1-nm@ti.com>
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

Hi Nishanth Menon,

On Tue, 30 May 2023 11:58:53 -0500, Nishanth Menon wrote:
> This series introduces secure proxies meant for usage with bootloaders
> and firmware components in the SoC for all K3 SoCs. AM64x SoC is an odd
> case here as the single instance of secure proxy is dual use for both
> ROM and general purpose. All other SoCs have independent instances that
> is used for firmware and bootloader communication.
> 
> Nitin had posted [1] to address one of the SoCs (AM62), I am cleaning
> that patch a bit in this series.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-am62-main: Add sa3_secproxy
      commit: 7450aa5153af55a0c63785a6917e35a989a4fdf5
[2/7] arm64: dts: ti: k3-am62a-main: Add sa3_secproxy
      commit: f7d3b11cacd1fc9596444e89209b80800d20ea22
[3/7] arm64: dts: ti: k3-am65-mcu: Add mcu_secproxy
      commit: 84debc33b529cae428f29b1eb21ccc05c8b47a16
[4/7] arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
      commit: c4e43f5aef9731c480789dcb044d261f894a102e
[5/7] arm64: dts: ti: k3-j721e-mcu: Add mcu_secproxy
      commit: 753904da7072646666fa17a5030ef2be871a385a
[6/7] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add sa3_secproxy and mcu_sec_proxy
      commit: 77f622cb8633c020a78cfb8b7d3d73ba3eaf0a44
[7/7] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add sa3_secproxy and mcu_sec_proxy
      commit: 389ad7111ddd99a05c75bc7d4f480a0526761d06

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

