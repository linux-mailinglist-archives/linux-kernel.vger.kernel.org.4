Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6796F73155C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbjFOKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbjFOKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:30:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCBC2942;
        Thu, 15 Jun 2023 03:30:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAU9NG035857;
        Thu, 15 Jun 2023 05:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825009;
        bh=8pVN9oNkmGnblqPTMI9HI/Zob7NSr7t4bUPavzlHqPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sL4KOCd6KD0Dha/1ao7OwLHltGIHCaptS98MaANMyL46fph0U8PKuuUTqToaIVBLD
         4Yp8mOr/TC9mXKZOUqO0fjgktgdRx6Y1/9WOY3+doto7mBwO2heCNaXdSHEKklbwdR
         n9NgCaJoh6WQDcLk1sxiewmc9GM7blS05qM9vROA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAU88w015512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:30:08 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:30:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:30:08 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAU5PN112615;
        Thu, 15 Jun 2023 05:30:06 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Andrew Davis <afd@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status
Date:   Thu, 15 Jun 2023 16:00:01 +0530
Message-ID: <168681817152.2098323.100603307953896320.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515172137.474626-1-afd@ti.com>
References: <20230515172137.474626-1-afd@ti.com>
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

Hi Andrew Davis,

On Mon, 15 May 2023 12:21:33 -0500, Andrew Davis wrote:
> Mailbox nodes are now disabled by default. The BeagleBoard AI64 DT
> addition went in at around the same time and must have missed that
> change so the mailboxes are not re-enabled. Do that here.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status
      commit: 155e7635ed1f3814d94d12556a3a0fed41d05b76
[2/5] arm64: dts: ti: k3-j721e: Remove PCIe endpoint nodes
      commit: a0cfd88d4a8a1106e9de5c3b03e68efe9e6249ec
[3/5] arm64: dts: ti: k3-j721e: Enable PCIe nodes at the board level
      commit: 731c6deda85ffcac3629bea757a806306e335618
[4/5] arm64: dts: ti: k3-am64: Enable Mailbox nodes at the board level
      commit: 91f983ff7039fa2ff8ef153e118eec6d60f55e45
[5/5] arm64: dts: ti: k3-j721e: Enable MDIO nodes at the board level
      commit: b0efb45d126ee914bafca37a582ae6574560dd25

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

