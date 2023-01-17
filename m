Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0976566DEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAQNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjAQNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:35:25 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147B22DED;
        Tue, 17 Jan 2023 05:35:23 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZEQI119203;
        Tue, 17 Jan 2023 07:35:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673962514;
        bh=PCKAzGvr22HjPZYlDQumTiViRb6UJ6p611b3ewbXRr4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mX/VtdL5nIPmusGUVCao7V12RSXdR2V1SRfrP3nicb0RcmvyxSa8whnckaILK7fUx
         bseRQb67cV7zixZHE6Ruq1bWNxnqqkQUY3ooajjZ/5vt7hVj4TljC8rw2Li+HBUhLL
         HpSca9VtEbwpQUDD0wlSdHoapNpTH1fveI3Ffv20=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HDZEl4004211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 07:35:14 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 07:35:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 07:35:13 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZAZQ083680;
        Tue, 17 Jan 2023 07:35:10 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v5 0/4] Add initial support for J784S4 SoC
Date:   Tue, 17 Jan 2023 19:05:07 +0530
Message-ID: <167395338059.410173.9288855113346154502.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112142725.77785-1-a-nandan@ti.com>
References: <20230112142725.77785-1-a-nandan@ti.com>
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

Hi Apurva Nandan,

On Thu, 12 Jan 2023 19:57:21 +0530, Apurva Nandan wrote:
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
> 
> [...]

I have applied the following to branch ti-k3-next on [1].
Thank you!

[1/4] dt-bindings: arm: ti: Add bindings for J784s4 SoC
      commit: 5e0a1e0d265cb11fca3464bbe9511740c46f759f
[2/4] dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
      commit: a0c01bc565332cff9183bd8a17b4db94732d645d
[3/4] arm64: dts: ti: Add initial support for J784S4 SoC
      commit: 4664ebd8346adaa7530555a29b47392104b5ba6c
[4/4] arm64: dts: ti: Add support for J784S4 EVM board
      commit: e20a06aca5c9d2d68354c340f96999d8dcb7128d

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

