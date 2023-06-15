Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AFC731597
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbjFOKjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjFOKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:39:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB331BC;
        Thu, 15 Jun 2023 03:39:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAdVqL066298;
        Thu, 15 Jun 2023 05:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825571;
        bh=FIvNdUpkNDtat2d1zB9D48Rb3xDNQ64bKjJr8fg37tk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xT5nkV16wJwN1BNZJdgKtsxYE+cH19J2c5EbZfkEyUoVspmmZTQHT8OFKLmF7lZZF
         PwviOjDxzcQRBI5M4BaPE99Tc7VQ5nwiI0g2cZEFDM55dn6p7/zKrlOgQ7rPIuDzxm
         sLOZ2ii3T29oaRYhRz+SNLLuDbLoTQ2GKhtLr/8A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAdVSs088309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:39:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:39:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:39:31 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAdS8l055707;
        Thu, 15 Jun 2023 05:39:29 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Add support for ADC nodes
Date:   Thu, 15 Jun 2023 16:09:27 +0530
Message-ID: <168682555626.2264847.7193857222855659588.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502081117.21431-1-b-kapoor@ti.com>
References: <20230502081117.21431-1-b-kapoor@ti.com>
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

Hi Bhavya Kapoor,

On Tue, 02 May 2023 13:41:15 +0530, Bhavya Kapoor wrote:
> J784S4 has two instances of 8 channel ADCs in MCU domain. Add support
> for both ADC nodes in dtsi file. Add pinmux information for both
> instances of ADC in board dts file.
> 
> Link to v1 -> https://lore.kernel.org/all/0f553758-c2cc-ce70-47e0-99e08c2d94a1@ti.com/
> 
> Changelog v1->v2 :
> - Modified indentation according to Vignesh's Comments
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add support for ADC nodes
      commit: ad5f7c514442a5eb29a415f75b3ea2744933e274
[2/2] arm64: dts: ti: k3-j784s4-evm: Add pinmux information for ADC
      commit: e99913ad58af3172343e3b22fa7a2a794d78b8c1

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

