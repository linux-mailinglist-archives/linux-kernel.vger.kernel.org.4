Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E173145E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbjFOJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjFOJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:46:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F51BD2;
        Thu, 15 Jun 2023 02:46:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F9k5st064895;
        Thu, 15 Jun 2023 04:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686822365;
        bh=rNnRz5youXx1kHvPeBw8+Jb16w+qow3Fd1ysPX/76Fg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u09Xcz91goyY0x2DmjOThQwuTZuwpGbuwOlqT3by7ubWBSaAksoiJeWBmy2nfmALA
         CAbF5zLaOcazAPmrsuM+NdWFYyckox6PMeh7Ib9hvcIQ9J6N9roCA2SBET646xuAlL
         EG6j9obuHfpUZW4bCeg3Yn2Qpd/HgjuRQQnaVDis=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F9k5HA120615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 04:46:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 04:46:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 04:46:04 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F9k0mK033974;
        Thu, 15 Jun 2023 04:46:01 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/8] arm64: j721s2: Add support for additional IPs
Date:   Thu, 15 Jun 2023 15:15:58 +0530
Message-ID: <168682220420.2105095.2398509850243495107.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230331090028.8373-1-r-gunasekaran@ti.com>
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
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

Hi Ravi Gunasekaran,

On Fri, 31 Mar 2023 14:30:20 +0530, Ravi Gunasekaran wrote:
> The following series of patches add support for the following
> on J721S2 common processor board,
> 
> - USB
> - SerDes
> - OSPI
> - PCIe
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/8] arm64: dts: ti: k3-j721s2-main: Add support for USB
      commit: 20fcf9d691ff6cde865f8486288b7babe1826b49
[2/8] arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
      commit: 393eee04065d26d53e9167e3721ad9a0ff89d40f
[3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
      commit: 80cfbf2f4ac735ab8e72a3c70188c433f06810c1
[4/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
      commit: da61731dc7f5d7a676acd81124229b57e6fbe0ef
[5/8] arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
      commit: 7743a9d7517a6a1f3b21d32db3bc1d00d6b16983
[6/8] arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
      commit: bbabba4ece74c51b98e7c8dbd8fa4725d0ae9baf
[7/8] arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
      commit: b6f18aa80f4eee59f9292f0007c021cb7e7dbbec
[8/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe
      commit: 715084ecc25adafe7f724721807b64fcc3a13e4a

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

