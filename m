Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E136BA28E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCNWdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCNWdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:33:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9196126BC;
        Tue, 14 Mar 2023 15:33:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EMXfUE124294;
        Tue, 14 Mar 2023 17:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678833221;
        bh=xxoQWhmjeLNy+6qyqn+1tJEzz9EbazbMNAuuzx4DZ1k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZumVrEsG+Brco5iHrkw+Z/E73G4OYFPOouWs7s46JsDxFHbmOQjmyZAUQFE2stoWH
         HlalrdzZZo3vcAUvr5wk87gT2tuDvuZhwonjK8ev+8H3CaBXit7B2FT9bfCKXRVHbv
         SBmC9HG7tSkXCbsn/F/1AN3Cs79OOEGfgKlH++b8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EMXfxN092995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 17:33:41 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 17:33:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 17:33:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EMXf34017095;
        Tue, 14 Mar 2023 17:33:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hnagalla@ti.com>,
        <a-nandan@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <kristo@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] Add Crypto Support for J784S4 SoC
Date:   Tue, 14 Mar 2023 17:33:40 -0500
Message-ID: <167883314243.2654.16836479551627547568.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314152611.140969-1-j-choudhary@ti.com>
References: <20230314152611.140969-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Tue, 14 Mar 2023 20:56:09 +0530, Jayesh Choudhary wrote:
> This series adds the crypto node for sa2ul for j784s4 platform.
> 
> First patch adds the device-id for NAVSS without which the probe
> for dma-controller fails due to 'ti,sci-dev-id' read failure.
> Second patch adds the crypto node.
> 
> This series has functional dependency on j784s4 k3_soc_id[1] and
> PSIL-thread support[2] but it does not affect the boot.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-*: Add 'ti,sci-dev-id' for NAVSS nodes
      commit: 436b288687176bf4d2c1cd25b86173e5a1649a60

Just picked up the fixes part of the series, rest we can look once we
pick up the dependencies together.

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
Nishanth Menon <nm@ti.com>
