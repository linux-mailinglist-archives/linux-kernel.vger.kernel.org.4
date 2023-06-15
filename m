Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C572F731A02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbjFONbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbjFONbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:31:34 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B972719;
        Thu, 15 Jun 2023 06:31:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDVRHf034100;
        Thu, 15 Jun 2023 08:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835887;
        bh=/Si1dIQDtWx/OTUD912QEE6D3Mf1vah0Pt+CkMP+ng4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GvRX0Bf4IQwf4WBCVrJbSQQWdaGmj2+XADB8tQN4EvLG1Ljs9oXkqwJrQCMc3l6CT
         OENq24ZUg9oXfOFs3spmTdX7AP6MyyLPfKhibFsJU7i66a0zz97tUllMAPyzNkJtAF
         UDhXJBZ9VZ1SaX4IuvZW8cOTPPLwFbuK03GZfjOo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDVRD3120039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:31:27 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:31:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:31:27 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDVNfY095001;
        Thu, 15 Jun 2023 08:31:24 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Udit Kumar <u-kumar1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j7200-common-proc-board fixes
Date:   Thu, 15 Jun 2023 19:01:21 +0530
Message-ID: <168681817151.2098323.17529850133259185371.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230419040007.3022780-1-u-kumar1@ti.com>
References: <20230419040007.3022780-1-u-kumar1@ti.com>
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

Hi Udit Kumar,

On Wed, 19 Apr 2023 09:30:05 +0530, Udit Kumar wrote:
> This patch series fixes the pin mux configuration and enable
> wkup_i2c0 at board level.
> 
> Note to self: in u-boot i2c pin mux is set in R5 board file.
> which will moved to som file, Fix that too when syncing kernel
> and uboot DTS files.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j7200: Fix physical address of pin
      commit: 3d011933000ed9054c649952d83162d24f020a93
[2/2] arm64: dts: ti: k3-j7200-som: Enable I2C
      commit: 2f932d4151599bc647607ae841cf57273279168c

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

