Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E05BD1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiISQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiISQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:04:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B664F3;
        Mon, 19 Sep 2022 09:03:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28JG3hAT080911;
        Mon, 19 Sep 2022 11:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663603423;
        bh=2ObUHsu17ZORD4jCLvyH/uWRJtHCGgdk1cTknrp/V7A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u6j+vYJVplWE6z19mG6BuoUQNRORtXY3d9E25m043Z/JjB/brusODlIA1RehuNthK
         80FZRzehiknHeBsrtfkPNDdIDNqgjhoNG9r98B7O2sBdEHAe14aJ50X0MwvLJoQDDS
         2ljWqAg8p0Jsy/TrPbLfksQgaQ10b4QcI0tfR+M4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28JG3hWX004692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 11:03:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 11:03:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 11:03:42 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28JG3dEr001204;
        Mon, 19 Sep 2022 11:03:40 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] arm64: dts: ti: Add support for AM62A family of SoCs
Date:   Mon, 19 Sep 2022 21:33:36 +0530
Message-ID: <166360336860.225542.16586137913783585865.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901141328.899100-1-vigneshr@ti.com>
References: <20220901141328.899100-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh Raghavendra,

On Thu, 1 Sep 2022 19:43:23 +0530, Vignesh Raghavendra wrote:
> This series adds basic boot support for AM62A SoCs with UART, MMC/SD and
> GPIO support on AM62A SK EVM
> 
> Bootlog: https://gist.github.com/r-vignesh/4d88f53bb0489f1675fa78f993e95d3f
> Tech Ref manual: https://www.ti.com/lit/zip/spruj16
> Schematics: https://www.ti.com/lit/zip/sprr459
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] dt-bindings: arm: ti: Rearrange IOPAD macros alphabetically
      commit: a3c52977419beabc5cb4d6f0b062fd4cb460e54d
[2/5] dt-bindings: arm: ti: Add bindings for AM62A7 SoC
      commit: cad20a8de86f37d2500963b1a424f9d658d8e54a
[3/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62A
      commit: 1607e6f9289cdb4c982a223e80ff3c5e827b7cd4
[4/5] arm64: dts: ti: Introduce AM62A7 family of SoCs
      commit: 5fc6b1b62639c764e6e7e261f384d2fb47eff39b
[5/5] arm64: dts: ti: Add support for AM62A7-SK
      commit: 38c4a08c820cd2483750a68f2bf84c3665fe6137

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

