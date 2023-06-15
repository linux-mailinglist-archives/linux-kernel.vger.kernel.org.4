Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345997319C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjFONU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjFONUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:20:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CB191;
        Thu, 15 Jun 2023 06:20:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDJqo1031371;
        Thu, 15 Jun 2023 08:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835192;
        bh=8YWfbq8/q8VKcB5u+SGrbbYuej1y2a8NhKJhPFGJBhM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xVEBbe2LyWwndc+etA0RvkaCYW7mVYMzL06ke+1glKaFGqghe/l7zAiBqm9kHKotp
         YsgKgxO0dRfJO7Pw2VmA/aJdPEjSWzzERfSM/VAyN1TXkq2o9d4lh6Em3KdQcgC/N2
         mPw9eQRYGR5ftzAmvVkSFCwQRiGAaJ/jxZ7Fr4xQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDJqDP112826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:19:52 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:19:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:19:52 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDJmJe060571;
        Thu, 15 Jun 2023 08:19:49 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] arm64: dts: ti: k3-j7*: Add general purpose timers
Date:   Thu, 15 Jun 2023 18:49:46 +0530
Message-ID: <168683516438.2362648.11436943550545172181.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213215.602395-1-nm@ti.com>
References: <20230531213215.602395-1-nm@ti.com>
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

Hi Nishanth Menon,

On Wed, 31 May 2023 16:32:09 -0500, Nishanth Menon wrote:
> Add pending general purpose timer support for various J7 family
> 
> Full list of K3 SoCs:
> * AM625: already merged
> * AM62A7: https://lore.kernel.org/all/20230418012717.1230882-2-nm@ti.com/
> * AM64: https://lore.kernel.org/all/20230414073328.381336-2-nm@ti.com/
> * AM65: already merged
> * J7200: https://lore.kernel.org/all/20230426103219.1565266-1-u-kumar1@ti.com/ (needs a respin)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-j721e: Add general purpose timers
      commit: 7f209dd1267ce2a4a5f6a9e4571858fa2d2e588c
[2/6] arm64: dts: ti: k3-j721e: Configure pinctrl for timer IO
      commit: 72a44d1c473486582d1d6177404e2fa7adf531ac
[3/6] arm64: dts: ti: k3-j721s2: Add general purpose timers
      commit: 835d04422f9d4c232c060150e696075cd34e081a
[4/6] arm64: dts: ti: k3-j721s2: Configure pinctrl for timer IO
      commit: 1ecc75be7bc522941261b5eb0c315b09098a47f4
[5/6] arm64: dts: ti: k3-j784s4: Add general purpose timers
      commit: 833377cf858b24d45e658454bcb683dd9076b576
[6/6] arm64: dts: ti: k3-j784s4: Configure pinctrl for timer IO
      commit: 5a41bcff08f9c0705f4e6c576d168051a7b323be

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

