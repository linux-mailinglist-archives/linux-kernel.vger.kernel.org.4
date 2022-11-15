Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558762A2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKOUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiKOUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:21:21 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51142CE2D;
        Tue, 15 Nov 2022 12:21:20 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKL49b011899;
        Tue, 15 Nov 2022 14:21:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668543664;
        bh=9oiGcqzoXhfjTzrCPrCbz94jGZFqK9LoI/npJADMm20=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DEBLE4pgMcA7PdblYcLa/DcRoRr047u+dJElEMpfftQA12XC4ykkzPWByyXchda52
         qHV8RJvNYYsGkg7F5frqhZiFn3vlmBeXWQxzqd24qhsA7krfA/JwDxluKVsNNzHdk8
         J6l1aFIJI1KzW/l/4mL3vkxvcUR69ei+Ou2wVQ7k=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFKL4RO053078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 14:21:04 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 14:21:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 14:21:04 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKL3av036739;
        Tue, 15 Nov 2022 14:21:03 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <r-ravikumar@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jkridner@gmail.com>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH v8 0/2] Enable RPi header on j721e sk
Date:   Tue, 15 Nov 2022 14:21:03 -0600
Message-ID: <166854359347.9543.1842133918601588169.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221107070009.11500-1-r-ravikumar@ti.com>
References: <20221107070009.11500-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul T R,

On Mon, 7 Nov 2022 12:30:07 +0530, Rahul T R wrote:
> The following series of patches enables RPi header on j721e sk. It is a
> 40 pin io expansion header which brings out i2c5, ehrpwm 2,3 and some pins
> of gpio 0,1
> 
> v8:
>    - Fixed the wraparound scheme in commit messages to 75 characters
>    - Added explanation in 1 for why the nodes are disabled
> 
> [...]

Thank you for the patience in taking this series through the paces.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721e-main: Add dts nodes for EHRPWMs
      commit: 20f67d1dfc6ad67fd70cd000b9d017447a50dbbd
[2/2] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header
      commit: 45924dffb58e13b902eca47e7cd960843176f075

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

