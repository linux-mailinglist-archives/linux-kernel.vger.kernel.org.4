Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F13632F69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKUV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKUV6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:58:15 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C921A39C;
        Mon, 21 Nov 2022 13:57:54 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLvjmM112721;
        Mon, 21 Nov 2022 15:57:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669067865;
        bh=tvTImJMmP2TDtG43bXn/KaBYMy8+NGyRh/xyk6m4iBE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y6P2RG/bpZH5lEiCWPrjJrtoG0XTa76f6IY+1zx1uzkXWisQBy4Tji7Iue28HzUdo
         lJ7we2vTvA9gjlDzWE4ZFeDhmLQ0gkOLvMIq62Gu2r9Ml8fuVa+sTu5tW6HeBhTsMc
         IQVwdVQEFpv+XrKYQVpa8fzQEA2ejZhD7s+mmVrU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALLvj14113558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 15:57:45 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 15:57:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 15:57:45 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLvj1o112185;
        Mon, 21 Nov 2022 15:57:45 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robertcnelson@gmail.com>,
        <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <drew@beagleboard.org>,
        <jkridner@beagleboard.org>, <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Mon, 21 Nov 2022 15:57:45 -0600
Message-ID: <166906780624.22658.5653408503605717690.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221118163139.3592054-1-robertcnelson@gmail.com>
References: <20221118163139.3592054-1-robertcnelson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert Nelson,

On Fri, 18 Nov 2022 10:31:38 -0600, Robert Nelson wrote:
> This board is based on the ti,j721e
> 
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

I did a minor typo fixup while committing, but thanks for being patient with
the series.

[1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
      commit: b784c27f40cfac1a0097f43bc68207c1bf350f2e
[2/2] arm64: dts: ti: Add k3-j721e-beagleboneai64
      commit: fae14a1cb8dddb83bb923093aade3470a872f048

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

