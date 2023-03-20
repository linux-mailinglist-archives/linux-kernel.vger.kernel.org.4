Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E46C24FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCTW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCTW5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:57:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1982E800;
        Mon, 20 Mar 2023 15:57:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KMvJro023518;
        Mon, 20 Mar 2023 17:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679353039;
        bh=M67PRLwFLDe+3gJD44sdCYfLWHH0IjEiv4dDXPyoH5o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IexiYJ8frK6KNZ9Mu5SjvlltVJ+2bHsc360Sdu9rykcy89CyegY6uwLzBnuNsRXSn
         8u6+qtEBOpY9gMG0qCX2BnyeY+55bPZOeiIhUIF8qXsDF73jxAMEMvDm/qSTtof8PK
         2G8CJ1FgQLGU74n3Bv3aBeUBhMRi6emiil2GNR/4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KMvJrc045259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 17:57:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 17:57:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 17:57:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KMvIEC092988;
        Mon, 20 Mar 2023 17:57:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Date:   Mon, 20 Mar 2023 17:57:18 -0500
Message-ID: <167935297528.213211.11496422611397737657.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230316095146.498999-1-b-kapoor@ti.com>
References: <20230316095146.498999-1-b-kapoor@ti.com>
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

Hi Bhavya Kapoor,

On Thu, 16 Mar 2023 15:21:44 +0530, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add support
> for both ADC nodes in dtsi file. Add pinmux information for both
> instances of ADC in board dts file.
> 
> Changelog v6->v7:
>  - Created 2 commits for k3-j721s2-mcu-wakeup.dtsi and
>  k3-j721s2-common-proc-board.dts instead of a single commit
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
      commit: 4beba5cf9ecc099d59e6fe8a03254cd995b80123
[2/2] arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux information for ADC
      commit: cf2aacfe5f48b8c91d148dd7a3d3814b8ae04463

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

