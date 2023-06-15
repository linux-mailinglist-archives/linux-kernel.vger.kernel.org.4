Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC09731523
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbjFOKWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjFOKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:22:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7EAC;
        Thu, 15 Jun 2023 03:22:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAMOkn124558;
        Thu, 15 Jun 2023 05:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686824544;
        bh=dDwybbfVtjuCp67WsqlxXc7FQmiEac9ZSane3r/Bcrs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ClUBlbeAQddvEz3LoCkFDfK36GE0FT685OM0WhF3K7RJZ7r8GPqSk8GS/o0WJpRtK
         4XSUA7+2S145fQI7ZeNxuLhN3cpp9XDrB4CqSK1Fr4IEJJu081DSThJwEpoIBYiQXe
         CvzZhmFC1ypmh3v6hpPublrgogrqwl5D4EOjGi/U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAMOeR025208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:22:24 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:22:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:22:23 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAMKx7022328;
        Thu, 15 Jun 2023 05:22:21 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Bryan Brattlof <bb@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] add VTM nodes to TI's K3 SoCs
Date:   Thu, 15 Jun 2023 15:52:17 +0530
Message-ID: <168681817145.2098323.12531563189730512154.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230120003051.9100-1-bb@ti.com>
References: <20230120003051.9100-1-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan Brattlof,

On Thu, 19 Jan 2023 18:30:45 -0600, Bryan Brattlof wrote:
> This patch series adds in basic VTM nodes for all of TI's K3 SoCs. As of
> right now these do not do much other than add thermal entries into the
> sysfs directory and power down the device once it's exceeded a critical
> temperature.
> 
> Changes from v1:
> - Fixed indexing of thermal nodes[0]
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-am64-main: add VTM node
      commit: 96135297a76003faae68e3aa86e2e19851510eb9
[2/6] arm64: dts: ti: k3-am62-wakeup: add VTM node
      commit: bbb6dc62505acf6fcb80573f7e7a59875c33be0d
[3/6] arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
      commit: 8fb4e87c55979c1f6691346205b884d1863ca6db
[4/6] arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
      commit: d148e3fe52c855b1709ed031eff6e63e87ad0372
[5/6] arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node
      commit: 4aa6586a9720849527379c415d0977f0d5bcfcac
[6/6] arm64: dts: ti: k3-am62a-wakeup: add VTM node
      commit: 225312fbaf37bb283dbc92a0a1d4dfe58629ab64

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

