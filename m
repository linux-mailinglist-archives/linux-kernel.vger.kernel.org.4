Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8E618E85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKDC5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKDC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:57:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12025287;
        Thu,  3 Nov 2022 19:57:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A42v9mi121141;
        Thu, 3 Nov 2022 21:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667530629;
        bh=KXmUTvXsRh+/y7JM6K9LWoCa2OVGE7mxrKt5mQgY1Ko=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RsXAmx0nTPEEPoAJDoqki1vwi9lMEUZvIvjjpIqnieN1GUDzHj+41HP4D+LGEQ8Gc
         mnkfpm0drtUvAPTZlxdAPa1ziiWgsWKevYEej0wxo09zaMZOK6zARJObjKGHtpNGjY
         Vgz4RBZyWxLcFBqPSCI8qRikLPlO/2KCziLGaeVs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A42v9os032416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 21:57:09 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 21:57:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 21:57:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A42v9r5115637;
        Thu, 3 Nov 2022 21:57:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kristo@kernel.org>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <bb@ti.com>, <afd@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <le.jin@siemens.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <jan.kiszka@siemens.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 00/11] AM65x Disable Incomplete DT Nodes
Date:   Thu, 3 Nov 2022 21:57:08 -0500
Message-ID: <166753059764.28312.10505241921624248527.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Fri, 28 Oct 2022 09:24:06 -0500, Andrew Davis wrote:
> Same story as for AM64x[0], AM62x[1], and J7x[2].
> 
> Last round for AM65x, but there are some boards that I do not have
> (Simatic IOT2050), so testing very welcome!
> 
> Thanks,
> Andrew
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/11] arm64: dts: ti: k3-am65: Enable UART nodes at the board level
        commit: 65e8781ac90e74242ebb1a98bf415809e8387aaf
[02/11] arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
        commit: c0a5ba87af56f073145dd026280454aec4a44db0
[03/11] arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
        commit: 1c49cbb19b1f2c61168741f987e65b50dd2f97de
[04/11] arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
        commit: 5780cf09409551c67112127b90786e553c8f9a25
[05/11] arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
        commit: c1d1189eafb27fa5c0cb0b92a4e81c155709068b
[06/11] arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
        commit: 0edd6d7ed646a53b41d09f7aa1d8c01d23bd7b73
[07/11] arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
        commit: c75c5c0bba500b1e454dc2591acdd6596fe64ce2
[08/11] arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
        commit: b08bf4a5c0ed0a6b8472ca78ccf416d73d2609aa
[09/11] arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
        commit: 7ff8432c272e3556461b7c9daad8156ae446e812
[10/11] arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
        commit: 3f9089ea008c195b6cf449735c5a3a5fcac1a382
[11/11] arm64: dts: ti: k3-am65: Enable McASP nodes at the board level
        commit: fdb02688f22b397c811328bf826b5b110d5cdc41

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

