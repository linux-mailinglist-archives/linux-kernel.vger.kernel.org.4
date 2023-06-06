Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4D724C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjFFTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbjFFTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:01:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B129E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:01:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356J1GY3031797;
        Tue, 6 Jun 2023 14:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686078076;
        bh=hKdR7e+OzXTJnZChozDBi/L+xAXs7vDfz/QSwg8b+NI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zAcDOL6ICnmEVe5FOmpvEraqOoaR6PSwgCKm6tQcHkvXvLQN36bJVTK8cU5k5EaWF
         OzTGWJ52PUzsA2TZTXXZyZ6OUkevylc4nkaXVxNLgIm3Dam/DDIIGJPr5xV0pKC/EW
         ZVJxhy7DQQ4l49ItBIrOLBAJnV2ulA1WwpKVrqZE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356J1GTj070896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 14:01:16 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 14:01:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 14:01:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356J1Gmn053316;
        Tue, 6 Jun 2023 14:01:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, Osama Muhammad <osmtendev@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wkup_m3_ipc.c: Fix error checking for debugfs_create_dir
Date:   Tue, 6 Jun 2023 14:01:15 -0500
Message-ID: <168607806409.3673808.12259234036575511379.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517172431.13507-1-osmtendev@gmail.com>
References: <20230517172431.13507-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Osama Muhammad,

On Wed, 17 May 2023 22:24:31 +0500, Osama Muhammad wrote:
> This patch fixes the error checking in wkup_m3_ipc.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is 'IS_ERR' inline function.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] wkup_m3_ipc.c: Fix error checking for debugfs_create_dir
      commit: b11403c93b7cddc8916b132a395b1524c02447a3

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

