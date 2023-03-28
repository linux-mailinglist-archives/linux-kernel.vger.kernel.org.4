Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44166CBECA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjC1MNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1MNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:13:15 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FEB4EF7;
        Tue, 28 Mar 2023 05:13:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SCD5QP119130;
        Tue, 28 Mar 2023 07:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680005585;
        bh=nrF79L5u1UWlkuJClhugIRv8py+KerdzrdsJIk0Bwr8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QFoA1jkfL+iGxWGSxYj2ryXP31gFUmpVgeTrnUGN0XPVcBw4gfiu288OCwOLyOdkz
         dmQ+BvlQZE2tApE33VjUcrHvYrz4os9oPUt+tfoM3lv9Hz7YG+WHAuaqNOnot5Ju46
         cQpw4xmWqDHGz1muXxZSt8MdQc+54LU/5Hhx0Ex8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SCD537020987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 07:13:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 07:13:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 07:13:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SCD5IG026937;
        Tue, 28 Mar 2023 07:13:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>, <j-luthra@ti.com>
Subject: Re: [PATCH v3 0/4] arm64: dts: ti: j7: Add device-tree nodes for MCSPI
Date:   Tue, 28 Mar 2023 07:13:04 -0500
Message-ID: <168000556145.589951.11862527421010581648.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321082827.14274-1-vaishnav.a@ti.com>
References: <20230321082827.14274-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav Achath,

On Tue, 21 Mar 2023 13:58:23 +0530, Vaishnav Achath wrote:
> This series adds device tree nodes for Multi Channel Serial Peripheral
> Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
> MCSPI instances are disabled by default and can be enabled through overlays
> as required, the changes were tested using spidev loopback test for all
> instances and the data verified only for main_spi4 which is connected
> internally as slave to mcu_spi2 for all existing J7 devices.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j721e: Add MCSPI nodes
      commit: 29cb8ddaab1cdbe2ace42fc1f7f5795d7c0bd82b
[2/4] arm64: dts: ti: k3-j7200: Add MCSPI nodes
      commit: e416410edf5b35632eefad09ad022eb70dc7b926
[3/4] arm64: dts: ti: k3-j721s2: Add MCSPI nodes
      commit: e1ce299d86fbb831de1a8ae76ea6d7f911fa554a
[4/4] arm64: dts: ti: k3-j784s4: Add MCSPI nodes
      commit: e1ecd17c0d1e2219c58e5152243e4702bae4f0a4

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

