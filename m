Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9880D6BA28B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCNWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:32:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A64A1D8;
        Tue, 14 Mar 2023 15:32:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EMWHsb064993;
        Tue, 14 Mar 2023 17:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678833137;
        bh=GQqHwyqCtwVa92bHH7eV7/KUpPO84Jr0Ue9kxmkBlrA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ak+HXIhutYrdTTIzgl6Pv3UAGBiVStApyAhC0JbNBEWbKlKjkdaBQYUyOncT5pU0u
         5yvf9NwlQxCZI8nzXhSxU2pqR009QAoCmTG4K7aYSe9MmPELNd7EKe0svxQp+Q9IuN
         6mtRfg9mz6L+i0GUGrRvAIt1bOaUZcLTSE77i+dI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EMWG7t019074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 17:32:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 17:32:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 17:32:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EMWG7b016126;
        Tue, 14 Mar 2023 17:32:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <a-govindraju@ti.com>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <u-kumar1@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
Date:   Tue, 14 Mar 2023 17:32:15 -0500
Message-ID: <167883312312.2564.13311755073974811403.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073724.29529-1-b-kapoor@ti.com>
References: <20230203073724.29529-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya Kapoor,

On Fri, 3 Feb 2023 13:07:24 +0530, Bhavya Kapoor wrote:
> According to latest errata of J721e [1], (i2024) 'MMCSD: Peripherals
> Do Not Support HS400' which applies to MMCSD0 subsystem. Speed modes
> supported has been already updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> but it missed dropping 'ti,strobe-sel' property which is only required
> by HS400 speed mode.
> 
> Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
      commit: 4f4b30a777d3e61603119297965343a37be36435

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Nishanth Menon <nm@ti.com>
