Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A166DEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjAQNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjAQNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:35:34 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9238EAD;
        Tue, 17 Jan 2023 05:35:33 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZSsS119357;
        Tue, 17 Jan 2023 07:35:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673962528;
        bh=JJZCDExgj4ETuImZy6eibmhXOqdhgu+ec/w/0EW9Wqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NLbH0HguhO5Yt42uQlqwSojGkJ7b52OhJN9SoX4q78HOmcstfX9vquth4gydANk2D
         IrM41FFrix9/3k6rYUC5+sI+Vo6DcmaUGS3FeCkkUBLjxo2k+NzHh82zupGPVQdGrb
         HWAG32xR8ZHRKlwF9OvBdyvXI8Wdf3D66ONjOREI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HDZSNa004308
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 07:35:28 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 07:35:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 07:35:27 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZOWD078898;
        Tue, 17 Jan 2023 07:35:25 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <bb@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] arm64: dts: ti: Enable misc peripherals
Date:   Tue, 17 Jan 2023 19:05:23 +0530
Message-ID: <167395338060.410173.5554947842512827850.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103042110.1092122-1-vigneshr@ti.com>
References: <20230103042110.1092122-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh Raghavendra,

On Tue, 3 Jan 2023 09:51:06 +0530, Vignesh Raghavendra wrote:
> This series enables few additional peripherals such as DMA, ethernet,
> PWMs, GPIOs etc  on AM62A SoC and AM62A7 SK EVM.
> 
> Vignesh Raghavendra (4):
>   arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
>   arm64: dts: ti: k3-am62a-main: Add more peripheral nodes
>   arm64: dts: ti: k3-am62a7-sk: Enable  ethernet port
>   arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
> 
> [...]

I have applied the following to branch ti-k3-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
      commit: eaee246b5e7b212069af40d6eb419158fac1325d
[2/4] arm64: dts: ti: k3-am62a-main: Add more peripheral nodes
      commit: 3dad70def7ff086152a383a60dd6ca4ea8a9b10d
[3/4] arm64: dts: ti: k3-am62a7-sk: Enable ethernet port
      commit: a9da45c013f232e72a1899ad2bf3760a187c2ab8
[4/4] arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
      commit: 42057a6ba99f42bd41a60e1f3ed111296e8bf099

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

