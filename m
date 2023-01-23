Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCE678369
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjAWRij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:38:37 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D8279AA;
        Mon, 23 Jan 2023 09:38:36 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NHcIxO042783;
        Mon, 23 Jan 2023 11:38:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674495498;
        bh=ZYpC4HCm4ounQrlN3im4FoY4A6kZTwnVXQbIJKLNYY8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UEgTwquMCsgP3cYTSvE/HXtLg1u2QqYzAo41HR/MGFHZYTGU896ChQuYBHLCfMIkZ
         O/0RWBU0d7aKER/HFryfw5HTXCNB5C4249aj7Kve/we3Ch3NuO66BR47iboMYwXaBO
         nEaVoiPEfumvS0QAQBotfrIHItp24mzL900OOSI4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NHcIV3129949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 11:38:18 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 11:38:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 11:38:17 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NHcErf129649;
        Mon, 23 Jan 2023 11:38:14 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <j-keerthy@ti.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix wakeup pinmux range
Date:   Mon, 23 Jan 2023 23:08:07 +0530
Message-ID: <167449539361.2850134.7539915497267178877.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119042622.22310-1-vaishnav.a@ti.com>
References: <20230119042622.22310-1-vaishnav.a@ti.com>
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

Hi Vaishnav Achath,

On Thu, 19 Jan 2023 09:56:22 +0530, Vaishnav Achath wrote:
> The WKUP_PADCONFIG register region in J7200 has multiple non-addressable
> regions, split the existing wkup_pmx region as follows to avoid the
> non-addressable regions and include all valid WKUP_PADCONFIG registers.
> Also update references to old nodes with new ones.
> 
> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> wkup_pmx1 -> 2 pins (WKUP_PADCONFIG 14 - 15)
> wkup_pmx2 -> 59 pins (WKUP_PADCONFIG 26 - 84)
> wkup_pmx3 -> 8 pins (WKUP_PADCONFIG 93 - 100)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j7200: Fix wakeup pinmux range
      commit: 9ae21ac445e911e3541985c20052fc05d60f6879

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

