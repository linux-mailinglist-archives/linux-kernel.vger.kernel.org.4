Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0306CF914
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC3CQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjC3CQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:16:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7654C2D;
        Wed, 29 Mar 2023 19:16:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U2GX8I123763;
        Wed, 29 Mar 2023 21:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680142593;
        bh=WLVFUvQI2j+PKE4jOYWB0ey7HeSYrCb075NwVI8tVYw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ngC/9aeVBVAiropxSQT+cKbuLS1xTw44MaKaBPy3U8IoIjkxw6Kyx07RaXt4l/BVw
         YcKOuOoHmGIxI9kHSqoEETxNgmUB6g0T1X4qyD6N8CPFBHqh9CLkqfoGDquQjAygVW
         clZfklGslGHUFb46U5dHHrYBuxj32MHZ1NuWUUAo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U2GXci088752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 21:16:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 21:16:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 21:16:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U2GXu8064123;
        Wed, 29 Mar 2023 21:16:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: ti: k3-am625-sk: Enable Type-C dual-role
Date:   Wed, 29 Mar 2023 21:16:32 -0500
Message-ID: <168014250364.14583.16299371328353584835.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328124315.123778-1-rogerq@kernel.org>
References: <20230328124315.123778-1-rogerq@kernel.org>
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

Hi Roger Quadros,

On Tue, 28 Mar 2023 15:43:13 +0300, Roger Quadros wrote:
> This series enables Type-C port on USB0.
> Series is based on [1]
> 
> Although k3-am625-lp-sk USB is exactly the same as on k3-am625-sk,
> it is missing the IRQ line from Type-C chip which is currently
> required as per chip's DT binding. So we don't add Type-C support
> for k3-am625-lp-sk till h/w is fixed or polling mode support for
> Type-C chip is accepted [2]
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1]. I picked v1
version with v2 updates in commit message to help stable, while at it,
I had to rewrite history a bit so that cherry-pick to stable won't be a
problem.

Thank you!

[1/2] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1
      commit: 49af4ecdd8ad2a964dbb9f2e7e50082433b37f98

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

