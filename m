Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDC6112A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJ1N0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1N0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:26:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03621CA5B4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:26:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDQHnV126502;
        Fri, 28 Oct 2022 08:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963577;
        bh=pqYof2f2d4DNdJVTvoHSDZx10BRmjo3rdtBJ15oeWlg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eUmU6RBirLirYxNCB+HM6MImzLWx2lpBNPhPQ0QMfhgl4ipWk/Ghtt5IuLNSb0VAq
         rdGnbNSi7iHnlJrB9gzWVEO2L72RhzWf3vR5jkTeRXgO447TVDB7c1zM32sZOCqYT3
         Lxnv+UYLlYfttsMh8ccZveuw4NNlHXwC3wdVHCaQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDQHuW013420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:26:17 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:26:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:26:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDQHuW006956;
        Fri, 28 Oct 2022 08:26:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <m-karicheri2@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <chenjiahao16@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH -next v2] drivers: soc: ti: mark knav_acc_firmwares as static
Date:   Fri, 28 Oct 2022 08:26:16 -0500
Message-ID: <166696355169.9835.16456843796158917218.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019153212.72350-1-chenjiahao16@huawei.com>
References: <20221019153212.72350-1-chenjiahao16@huawei.com>
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

Hi Chen Jiahao,

On Wed, 19 Oct 2022 23:32:12 +0800, Chen Jiahao wrote:
> There is a sparse warning shown below:
> 
> drivers/soc/ti/knav_qmss_queue.c:70:12: warning: symbol
> 'knav_acc_firmwares' was not declared. Should it be static?
> 
> Since 'knav_acc_firmwares' is only called within knav_qmss_queue.c,
> mark it as static to fix the warning.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] drivers: soc: ti: mark knav_acc_firmwares as static
      commit: adf85adc2a7199b41e7a4da083bd17274a3d6969

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

