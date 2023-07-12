Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A0750B13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGLObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjGLObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:31:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA78121
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:31:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CEVVsD105801;
        Wed, 12 Jul 2023 09:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689172292;
        bh=YVDtkobddDeNqU2SzNCFQemucbB+DImVHuNl1DEdEZY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HhlBW2ARbkOx2ofzZeGvJ+L29E3+mSsk0/bz6sgGlo6bYIkzRssTsnX1UXH7EJU3e
         p9ogaNuSaZrxcVlUpZFTrNN+1lQS+xZdi6WQXpup2CQ87NoMqQ8JPHyoXwpfFZ3tT2
         COQyCw8MmgQPTivzV+7ertTmTv6OaPqB3xAlJemE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CEVVRH089369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 09:31:31 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 09:31:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 09:31:31 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CEVV2n044851;
        Wed, 12 Jul 2023 09:31:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: ti_sci: Fixup documentation errors
Date:   Wed, 12 Jul 2023 09:31:30 -0500
Message-ID: <168917228020.2072383.15791776476390269030.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621021619.265162-1-nm@ti.com>
References: <20230621021619.265162-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Tue, 20 Jun 2023 21:16:19 -0500, Nishanth Menon wrote:
> Fix up documentation errors, squashes the following warnings:
> drivers/firmware/ti_sci.c:1986: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_set_irq'
> drivers/firmware/ti_sci.c:2034: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_free_irq'
> drivers/firmware/ti_sci.c:2630: warning: Function parameter or member 'bootvector' not described in 'ti_sci_cmd_proc_set_config'
> drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'bv' not described in 'ti_sci_cmd_proc_get_status'
> drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'cfg_flags' not described in 'ti_sci_cmd_proc_get_status'
> drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'ctrl_flags' not described in 'ti_sci_cmd_proc_get_status'
> drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'sts_flags' not described in 'ti_sci_cmd_proc_get_status'
> drivers/firmware/ti_sci.c:2746: warning: expecting prototype for ti_sci_cmd_get_boot_status(). Prototype was for ti_sci_cmd_proc_get_status() instead
> drivers/firmware/ti_sci.c:3265: warning: Function parameter or member 'sub_type' not described in 'devm_ti_sci_get_resource'
> drivers/firmware/ti_sci.c:3265: warning: Excess function parameter 'suub_type' description in 'devm_ti_sci_get_resource'
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Fixup documentation errors
      commit: 3e67fd8dd2711a63adfe0fa087de38d86a6eb8d5

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

