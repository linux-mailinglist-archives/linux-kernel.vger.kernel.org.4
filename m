Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8D6112C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJ1Na0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJ1NaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:30:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637836BCE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:30:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDU7Hq101820;
        Fri, 28 Oct 2022 08:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963807;
        bh=Y8bSMPHQkbROrWc2FBobcshghxfJ341FmSp0fOPgRXw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xf4GXQjLUnFPAhGZUmF3v+kNz8ObYlo4Jn3xeOqHdVdXtHQbPAqM5u89voK5I56He
         ver+pti5rcP2LPBA9p5a4MBIZBIjiIqHoQi5pTrqmJCr0851jDgXvw8MTxEIx7Rddl
         O+icBa19NJqNecFvhWrdUL+co40U77ke708WT0t4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDU7aK031773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:30:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:30:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:30:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDU6Lq016922;
        Fri, 28 Oct 2022 08:30:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>,
        <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] ARM: keystone: Replace platform SMP with PSCI
Date:   Fri, 28 Oct 2022 08:30:06 -0500
Message-ID: <166696377873.13032.9943933925501670844.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221026145033.17905-1-afd@ti.com>
References: <20221026145033.17905-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Wed, 26 Oct 2022 09:50:33 -0500, Andrew Davis wrote:
> The KS2 boot monitor supports PSCI commands. These are already defined
> in DT for KS2. We can drop this platform override and remove related
> code without changing SMP. Do this here.
> 
> 

I have applied the following to branch ti-keystone-next on [1].
Thank you!

[1/1] ARM: keystone: Replace platform SMP with PSCI
      commit: 7e8edf55cf729367afdb5e9a8b182f1d47897800

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

