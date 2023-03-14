Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800FB6BA289
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjCNWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCNWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:32:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFA497D5;
        Tue, 14 Mar 2023 15:32:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EMVtI4058100;
        Tue, 14 Mar 2023 17:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678833115;
        bh=DhzlH4GzY1LO8CmnlmnsPPW1iitsgQan4vs6erUI454=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JDfhQiHy+YcXDsxFZn6iOsE6kZ1Ul5L1KjM9xqJLvPJ+pj2OUbEI4OccoknZ8dnWI
         WL0FZItxuiUJ+ezs8Aru/SmYDThdMnck7gIjfFd+agkCuuah+NaMpyMFCjDizf5wiE
         0ii0Y3uW973O3UL13CPtasM5ULMbxciUkakIoVkI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EMVtYD092235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 17:31:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 17:31:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 17:31:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EMVtjt024054;
        Tue, 14 Mar 2023 17:31:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <devarsht@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <hnagalla@ti.com>, <j-luthra@ti.com>,
        <praneeth@ti.com>, <a-bhatia1@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
Date:   Tue, 14 Mar 2023 17:31:54 -0500
Message-ID: <167883309637.2460.7423926194678720333.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314094645.3411599-1-devarsht@ti.com>
References: <20230314094645.3411599-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devarsh Thakkar,

On Tue, 14 Mar 2023 15:16:45 +0530, Devarsh Thakkar wrote:
> All revisions of AM62A7-SK board have 4GB LPDDR4 Micron
> MT53E2G32D4DE-046 AUT:B memory. Commit 38c4a08c820c ("arm64: dts: ti:
> Add support for AM62A7-SK") enabled just 2GB due to a schematics error
> in early revision of the board. Fix it by enabling full 4GB available on
> the platform.
> 
> Design docs: Link: https://www.ti.com/lit/zip/sprr459
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
      commit: a1bc0d6084dba8a31831c65318a8a8e46f00906f

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
Nishanth Menon <nm@ti.com>
