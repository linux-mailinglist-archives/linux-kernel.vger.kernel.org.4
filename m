Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A575724A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbjFFRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbjFFRWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:22:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119B170A;
        Tue,  6 Jun 2023 10:22:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356HM0eV059062;
        Tue, 6 Jun 2023 12:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686072120;
        bh=CbsxA7Opw8YBgVHuESQ555SiftJM1F+9Xytnpav4JHE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wp9hzI7jPFQC97k30Pd4+zljXc7+O5xBRKaw6E2fuwiQNq37q5vhc0HLcjsqRp3YD
         S++AILYYbu6ClhFgAe6riZ8swAH1HpllUpyLUommCuLZOtiYPkq9+HoJc0a/OhNLFi
         VH9oPskqnRJnH551oCsd+YGIqA1yHKdXnbpuOkUE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356HM0pq052828
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 12:22:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 12:22:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 12:22:00 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356HLvSB076208;
        Tue, 6 Jun 2023 12:21:58 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a: Add timers, wdt and fixup
Date:   Tue, 6 Jun 2023 22:51:32 +0530
Message-ID: <168607161908.2072651.15533240609144219974.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230418012717.1230882-1-nm@ti.com>
References: <20230418012717.1230882-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Mon, 17 Apr 2023 20:27:14 -0500, Nishanth Menon wrote:
> This is a series that adds wdt, timers to am62ax support, and adds the
> missing description for uart1 and wkup_uart that is used by firmware.
> 
> Nishanth Menon (3):
>   arm64: dts: ti: k3-am62a: Add general purpose timers
>   arm64: dts: ti: k3-am62a: Add watchdog nodes
>   arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62a: Add general purpose timers
      commit: 68dd81a75192248a2c29650d21da495069c74ffa
[2/3] arm64: dts: ti: k3-am62a: Add watchdog nodes
      commit: 804702e4c2aa5eae4611e9389833631a6b22e913
[3/3] arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart
      (no commit info)

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

