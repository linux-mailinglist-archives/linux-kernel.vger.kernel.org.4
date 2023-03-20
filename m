Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05746C2557
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCTXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCTXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:03:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD57DBCB;
        Mon, 20 Mar 2023 16:03:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KN3Rq3075543;
        Mon, 20 Mar 2023 18:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679353407;
        bh=IlweAH0ZEGReArX7aWf9fp3QqUONco7uXt26jNxT7K8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DfEEpprUfT1cJiXJCoG7m9fanxny1UDK58u3Q7KL6GQq5Y9pL9BzSmC24hILle/5P
         V0+IT6pJljBXHS2Z/bsxQ1I6lw83uKeLBJ/rvef7M4c1kyirjLkDOz6Nv/M+Io5Ips
         xpBl7MphrexToSaorJyHN9s6ee7vXra4AOyD+Z9U=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KN3Rk6049785
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 18:03:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 18:03:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 18:03:27 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KN3R01094836;
        Mon, 20 Mar 2023 18:03:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Andrew Davis <afd@ti.com>, Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH V2 0/3] arm64: dts/defconfig/binding: Add support for BeaglePlay
Date:   Mon, 20 Mar 2023 18:03:25 -0500
Message-ID: <167935333606.215823.10442790342780935769.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230316152143.2438928-1-nm@ti.com>
References: <20230316152143.2438928-1-nm@ti.com>
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

Hi Nishanth Menon,

On Thu, 16 Mar 2023 10:21:40 -0500, Nishanth Menon wrote:
> BeagleBoard.org BeaglePlay[1][2] is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM625
> SoC. Add the base support for the same.
> 
> Bootlog: https://gist.github.com/nmenon/2e7647970a4d6af05017e545ac0f8218
> 
> Changes Since v1: (major ones)
> - All patches updated
> - signed-off-by order fixups
> - Cleanup to drop errant pre-production board vestiges
> - defconfig adds SPI to get to mikrobus spi interface.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add BeaglePlay
      commit: 3cd557272ef0b1bbad3c5450f09629e451e101f3
[2/3] arm64: dts: ti: Add k3-am625-beagleplay
      commit: 2afe6a26744bf4245a6b33593a9c38e7cb464078

I have applied the following to branch ti-k3-config-next on [1].
[3/3] arm64: defconfig: Enable drivers for BeaglePlay
      commit: 673c8894d7d0124f14c900313d85dba0870bb7cc

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

