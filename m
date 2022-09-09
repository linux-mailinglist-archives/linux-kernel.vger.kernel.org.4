Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E45B34A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIIJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIIJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:56:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB0129C6D;
        Fri,  9 Sep 2022 02:56:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2899uYFO073458;
        Fri, 9 Sep 2022 04:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662717394;
        bh=swu/b/egvLaIh4KxRu0r45VIJnFolDvGx0gZBY8MyAQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lDX0mNsG9J3PSrVB/K/w3p2lR08X1KEob4FG6oQSXcNoFxuS/dgWxzCP/qacCCO9i
         dwIysJAl+zmZ7cg48EC0g8Y1IF+TOqPOtRIB2bxlm0GRQCDETC9bEbyiu+ctqwj7lW
         Ew3dHIB2VadbigqpLQb6PmDTTXTVTeJLF37U/T+Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2899uY4o120796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 04:56:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 04:56:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 04:56:33 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2899uTHr005120;
        Fri, 9 Sep 2022 04:56:30 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
Date:   Fri, 9 Sep 2022 15:26:21 +0530
Message-ID: <166271737625.1620505.2192569000187439281.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220823001136.10944-1-afd@ti.com>
References: <20220823001136.10944-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Mon, 22 Aug 2022 19:11:33 -0500, Andrew Davis wrote:
> The hardware random number generator is used by OP-TEE and is access is
> denied to other users with SoC level bus firewalls. Any access to this
> device from Linux will result in firewall errors.
> 
> We could remove this node, but it is still valid device description,
> and it is possible it could be re-enabled in the bootloader if OP-TEE
> is not used. So only disable this node for now.
> 
> [...]

I have applied the following to branch master on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
      commit: 1ad4669b4bbe6b72784acdb5b24f72b22ad8f1d1
[2/4] arm64: dts: ti: k3-am65-main: Move SA2UL to unused PSI-L thread ID
      commit: 530eaa573a33fdd86725fdd2b979cbbbc539d47c
[3/4] arm64: dts: ti: k3-am65-main: Do not exclusively claim SA2UL
      commit: 49611f43e035f30be685fcf7468f23e85ce2ee06
[4/4] arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL node
      commit: d683a73980a61cc5d8abea7f3f996028e64e9144

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

