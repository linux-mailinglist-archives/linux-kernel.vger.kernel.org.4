Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03665731A42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbjFONlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344442AbjFONkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:40:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDBB448D;
        Thu, 15 Jun 2023 06:39:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDdFLn016323;
        Thu, 15 Jun 2023 08:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686836355;
        bh=2/pBkqDceYj9n0f+/NIxgpHbw2aZzs7700cTCtTWooY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I2yEe5Te+hrjmA64vfviScLXJJRm+nhiKTE3f41t69kH7SCz6lvowWXQYofgmNskq
         mnwAL1efvSUGzUvV4mk5okAqek6o95VLmlHCmi3bsfDXQq2Kus3u0DXsmKoSC+J3/e
         9exTgGEg/eB73YSbdkW6d7EASCWYV2peSNifPuWo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDdFJg124047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:39:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:39:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:39:14 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDdBpm011260;
        Thu, 15 Jun 2023 08:39:12 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 0/9] arm64: dts: ti: k3-j721e-*: Fix up pinmux and aliases
Date:   Thu, 15 Jun 2023 19:09:09 +0530
Message-ID: <168683627164.2366271.3394284993273377362.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601183151.1000157-1-nm@ti.com>
References: <20230601183151.1000157-1-nm@ti.com>
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

On Thu, 01 Jun 2023 13:31:42 -0500, Nishanth Menon wrote:
> This series cleansup k3-j721e platforms for pinmuxes and aliases.
> Provide complete description of uart and i2c instead of piggy-backing on
> bootloader configurations, ensure board detection eeproms are defined,
> aliases be defined in the board files as well.
> 
> Many of these changes were maintained in u-boot tree, and this moves
> those orphan changes to the super set definition in kernel.
> 
> [...]


I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/9] arm64: dts: ti: k3-j721e-sk: Add missing uart pinmuxes
      commit: acfb362a9c78d6708080cdd850b036225c78371b
[2/9] arm64: dts: ti: k3-j721e-sk: Enable wakeup_i2c0 and eeprom
      commit: 1b4b376c878b36d1a1c848ebc885487e4cad2546
[3/9] arm64: dts: ti: j721e-som/common-proc-board: Add product links
      commit: 26efc8d1ad0cc14e2740d310935fa146b1fc5a58
[4/9] arm64: dts: ti: j721e-common-proc-board: Add uart pinmux
      commit: 86718345b4d3c0d386b3f73ef43e7f72ff04cf4a
[5/9] arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
      commit: b04b18ccb3d5c19c864c10f7cc7b014218aecb22
[6/9] arm64: dts: ti: k3-j721e-beagleboneai64: Add wakeup_uart pinmux
      commit: 4c2c99026ca1525912b40cbc1b69306145ce7082
[7/9] arm64: dts: ti: k3-j721e-sk: Define aliases at board level
      commit: d1a4304c149d1a26a912d532501ead42e5952501
[8/9] arm64: dts: ti: k3-j721e-common-proc-board: Define aliases at board level
      commit: ff59580bf2580ec262098399aab03dfca537bec8
[9/9] arm64: dts: ti: k3-j721e: Drop SoC level aliases
      commit: 8be20986e0c54420e52048d20bdc31e3a8aec93f

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

