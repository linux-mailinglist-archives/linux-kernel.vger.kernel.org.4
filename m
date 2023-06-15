Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0C731584
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjFOKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbjFOKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:36:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0B2943;
        Thu, 15 Jun 2023 03:35:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAZkhi127111;
        Thu, 15 Jun 2023 05:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825346;
        bh=FMtPoQzXH4RUyE7lkPZYz6l+euOtk6eZmTPs6h0NSTg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lYyZIxzixJ96u/8JqOnY7F0+/MCHOK2DMtM1FPeMeIfOlQo/9i66uRnw7hqHhr5Ii
         E/H5lGtFa5+fhRsHviniOKfnowsJOr0IKE345p+xK26MPamYiN0sIAgrEfPBu5Wjnl
         qmRcrDKxWAFLIcdzd5ocKV4UKwfc1FcPVuLG3JBk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAZkeL001385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:35:46 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:35:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:35:46 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAZhJf118026;
        Thu, 15 Jun 2023 05:35:44 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems
Date:   Thu, 15 Jun 2023 16:05:40 +0530
Message-ID: <168681785694.2096385.13063792162799133848.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230424093827.1378602-1-b-kapoor@ti.com>
References: <20230424093827.1378602-1-b-kapoor@ti.com>
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


On Mon, 24 Apr 2023 15:08:27 +0530, Bhavya Kapoor wrote:
> Update the delay values for various speed modes supported, based on
> the revised august 2021 J721E Datasheet.
> 
> [1] - Table 7-77. MMC0 DLL Delay Mapping for All Timing Modes and
> Table 7-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
> https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
> (SPRSP36J – FEBRUARY 2019 – REVISED AUGUST 2021)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems
      commit: 64b57ece526a63141fe8e3dd52ab93e6f0dcd9a0

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

