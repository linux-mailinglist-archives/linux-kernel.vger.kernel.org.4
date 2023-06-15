Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1E7315A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbjFOKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbjFOKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:43:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826B1BF3;
        Thu, 15 Jun 2023 03:43:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAhEH9077500;
        Thu, 15 Jun 2023 05:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825794;
        bh=NZwHMOeBiurjrCW0mAE5ZQbWmc48c0ebjVbZDJOCMgU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=edFwT1SjTAFN6Z4U5WNu16QOZu7jTa4tbN8ABeVY7p2r0dA1nsRDk92irlsPNYgO8
         TSdOn10JiqeyioEXg38AGmK2ek/3OMaYSt4RowkU+QwsSKX/OlDC0rH+WiH8OdlPyk
         uu+O7wQxHvr91SPoY3IFTyjN7UhIwarU4Uk5R/cY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAhEBg005653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:43:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:43:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:43:13 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAhAGR081052;
        Thu, 15 Jun 2023 05:43:10 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, <kristo@kernel.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: j721e: Add HyperFlash support
Date:   Thu, 15 Jun 2023 16:13:08 +0530
Message-ID: <168682577717.2266254.12712212456915723597.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230513123313.11462-1-vaishnav.a@ti.com>
References: <20230513123313.11462-1-vaishnav.a@ti.com>
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

Hi Vaishnav Achath,

On Sat, 13 May 2023 18:03:09 +0530, Vaishnav Achath wrote:
> This series adds hyperflash support for J721E. J721E SoC has HyperBus
> and OSPI controller muxed within the FSS subsystem and the J721E SoM
> has a 64 MiB S28 OSPI flash and a 64 MiB Hyperflash present which is
> muxed externally also.
> 
> Changelog:
> V1->V2:
>  * Address feedback in similar series:
>  https://lore.kernel.org/all/feddcd03-1848-b667-6a38-ae7c0f6ff160@ti.com/
>  * Add partitions information in Hyperflash node.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
      commit: d93036b47f354b7acb95aad5c91e9becbe4e9f61
[2/4] arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
      commit: 0979c0069cb669528d13818410de9f0dd41585f3
[3/4] arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash select pinmux
      commit: be8be0d036b2fed1f705931ac3901077039b7496
[4/4] arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash select pinmux
      commit: 58cd171af4d7e27525b1924b72100cba98d88d2a

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

