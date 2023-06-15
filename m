Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E0731547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbjFOK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbjFOK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:28:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22A2D69;
        Thu, 15 Jun 2023 03:28:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FASI36035492;
        Thu, 15 Jun 2023 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686824898;
        bh=Q+PFg8MVj68fdFjz6yBmn3VN+S2JhyVGeBpernnJN3w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=giIPEXocxKY9ip/z78GaGzZd5UElnxTDlwa71sFJboFBsdmpRHNkkqcvPckz6F8LJ
         j6PyQ87EoNydQDrYJV4SEWdSGYcFYKSkVl+12CYJRaRSuXMPa//L2NNQ8gOQs6Axx0
         wEirjXHAYZZTKvLwgfrB5JA29qE6NP6kLHposaXw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FASI9w013918
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:28:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:28:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:28:18 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FASFt2110609;
        Thu, 15 Jun 2023 05:28:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: ti: k3-am62x-sk-common: Cleanups and minor additions
Date:   Thu, 15 Jun 2023 15:58:14 +0530
Message-ID: <168682488237.2210554.1813394610850551665.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230418213740.153519-1-nm@ti.com>
References: <20230418213740.153519-1-nm@ti.com>
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

On Tue, 18 Apr 2023 16:37:36 -0500, Nishanth Menon wrote:
> This is a result of looking to cleanup u-boot and realizing there are
> pieces missing in kernel that need to be pushed out.
> 
> So, minor cleanups and adding a few missing pieces.
> 
> Bootlog: https://gist.github.com/nmenon/5e18c8d02c13cf00db649b6f01971d99
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62x-sk-common: Drop extra EoL
      commit: 477d43f6d8546597e007a3a2ebd19f6e4e090fee
[2/4] arm64: dts: ti: k3-am62x-sk-common: Describe main_uart1 and wkup_uart
      commit: 76194aba0c30b1ee25067b34235141443bd078fb
[3/4] arm64: dts: ti: k3-am62x-sk-common: Add eeprom
      commit: f40ed3b39b486ed8fbca7aa4a319c8d1d14ac97d
[4/4] arm64: dts: ti: k3-am62x-sk-common: Improve documentation of mcasp1_pins
      commit: 5cab8abaee22470523a5293994a52784360a7926

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

