Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B899731A05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbjFONcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjFONcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:32:14 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2F2728;
        Thu, 15 Jun 2023 06:32:12 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDW2nl077334;
        Thu, 15 Jun 2023 08:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835922;
        bh=LT9SxIRDZ5Glea4YYkDGPYIGRSOnE6svaSGUdthHlZE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BcCCyxlnn8FXeXRsIsMqITra96N3Gu4xD6VCFiQ8FMVMa58TQQS7bL++nZ0d6AZ8A
         EheFAPXlmUhslZvTENkmhonbmQWycv7Kxgk18kgygYKUwv42vOB4C5jStA7uII3Rmc
         xlFqlk/Y19ZybbodILEyq0ZP8HcFqizMopiHBR8M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDW21m009613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:32:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:32:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:32:02 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDVwe6095321;
        Thu, 15 Jun 2023 08:31:59 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
        Udit Kumar <u-kumar1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [v4 0/6] arm64: dts: ti: k3-j7200: Add properties and sync with uboot
Date:   Thu, 15 Jun 2023 19:01:57 +0530
Message-ID: <168681817159.2098323.6783558956732952676.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611111140.3189111-1-u-kumar1@ti.com>
References: <20230611111140.3189111-1-u-kumar1@ti.com>
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

Hi Udit Kumar,

On Sun, 11 Jun 2023 16:41:34 +0530, Udit Kumar wrote:
> In continuation of patch series posted by Nishanth for sync of uboot device tree with kernel device tree for AM64 SOC.
> https://lore.kernel.org/linux-arm-kernel/20230414073328.381336-1-nm@ti.com/
> 
> This series extend device tree sync/clean up for J7200 SOC.
> 
> This patch series build on top of
> https://lore.kernel.org/all/20230419040007.3022780-1-u-kumar1@ti.com
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-j7200: Add general purpose timers
      commit: c8a28ed4837ce03254e0941f4fbc8364b1e78543
[2/6] arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
      commit: 03612d384621ffe21c6d338de916251d1bfd84fa
[3/6] arm64: dts: ti: k3-j7200-common-proc-board: remove duplicate main_i2c0 pin mux
      commit: 7f58e2b418d89f38f242b04da5a1dd93a2c514fd
[4/6] arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux
      commit: 3709ea7f960ed77ac29af692c9e32351060400d9
[5/6] arm64: dts: ti: k3-j7200-common-proc-board: Define aliases at board level
      commit: c4ba159fff90791956370ce93c130aadea87dbb6
[6/6] arm64: dts: ti: k3-j7200: Drop SoC level aliases
      commit: 858dde8a3f56f0b7a0c217ac4abf56e34c34ae74

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

