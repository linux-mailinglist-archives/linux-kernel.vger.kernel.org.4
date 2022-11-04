Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB7618E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKDCzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDCy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:54:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC456158
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:54:56 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A42smci120588;
        Thu, 3 Nov 2022 21:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667530488;
        bh=giSkrJoKX75wowCgeqptKZEsNuyQLKm1XQsFzWBaoNk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YPok+PsQurEkpdRroPv1fId3zGtsTidiREteE/95j74dILre3D1SMT3gtDbIZqnNy
         pwAClA8Z45ZpmTD1NwjuF94v9YG0/DH2uuLhPvzk7UJChuBQSxUBJeEzCRNwxOLbGy
         GXPoa0SRHWrEjkniwxXzlLa1enXMCtJaJYpX1PS0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A42smRW003645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 21:54:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 21:54:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 21:54:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A42sltu114032;
        Thu, 3 Nov 2022 21:54:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <r-ravikumar@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: defconfig: Enable TI_TFP410 DVI bridge
Date:   Thu, 3 Nov 2022 21:54:47 -0500
Message-ID: <166753014103.25720.9618852304616828963.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103180845.17076-1-r-ravikumar@ti.com>
References: <20221103180845.17076-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul T R,

On Thu, 3 Nov 2022 23:38:45 +0530, Rahul T R wrote:
> Enable TI_TFP410 DPI to DVI bridge. This is
> required to enable HDMI output on j721e-sk
> platform
> 
> 

I have applied the following to branch ti-k3-config-next on [1]
(For future reference: Did minor formatting fixup for commit message 75
  characters Documentation/process/submitting-patches.rst line 589).

Thank you!

[1/1] arm64: defconfig: Enable TI_TFP410 DVI bridge
      commit: 9f7e3ed268520f4d539c03d4d48a604a9658ba37

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

