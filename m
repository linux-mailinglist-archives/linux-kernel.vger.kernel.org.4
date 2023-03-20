Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841BE6C24E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCTWt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCTWtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:49:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF426BA;
        Mon, 20 Mar 2023 15:49:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KMnjuj072858;
        Mon, 20 Mar 2023 17:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679352585;
        bh=IQ+DKX5XXRvZ78BP4o0s5HOVnsU1lz+o8YnKdmFGddg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oyKg1GI7fEK6x37BeG+dYKJhGqHEm0dNK9jvjzwr8bFlk2eXXtdqNMmQBNJom1qgS
         vPnZmarI6L88c7O8UGCuiXsqIF/Xonug4g7jMfwDG5sHAUYTR8QzKHiW2W0F+Q3v39
         rZt3+fy26ufo3v6sLDscnlXdTM+B5O3ULceo261k=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KMnjkD098096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 17:49:45 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 17:49:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 17:49:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KMni1r082576;
        Mon, 20 Mar 2023 17:49:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
Date:   Mon, 20 Mar 2023 17:49:43 -0500
Message-ID: <167935256100.210551.6761946270163410194.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320044935.2512288-1-vigneshr@ti.com>
References: <20230320044935.2512288-1-vigneshr@ti.com>
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

Hi Vignesh Raghavendra,

On Mon, 20 Mar 2023 10:19:34 +0530, Vignesh Raghavendra wrote:
> Per AM62x SoC datasheet[0] L2 cache is 512KB.
> 
> [0] https://www.ti.com/lit/gpn/am625 Page 1.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
      commit: 6974371cab1c488a53960945cb139b20ebb5f16b
[2/2] arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB
      commit: 438b8dc949bf45979c32553e96086ff1c6e2504e

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

