Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135C731A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbjFONfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344521AbjFONfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DA30ED;
        Thu, 15 Jun 2023 06:34:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDYG8w015431;
        Thu, 15 Jun 2023 08:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686836056;
        bh=lMOnK1i7X2ucCZqWvCght1vJtWbIWWUy9vQXuN2xkxM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T9qDEOq8nhcJQFNa0kihFLKR7sN9c7nJt3fieG4oBgFEZ6tlXLCNKlz9RJKsOuZZe
         Mlo94xmotppPn2WcuV9KJO8EfKLhb8LZ9wqsAtyzWJo6/XgWIsMSqK+jY59avl7hSh
         K3OFyI7wwiVhCuQDx/bd4C4CKJ32z1A85HN9X5NE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDYGSv059436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:34:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:34:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:34:15 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDYCjD026934;
        Thu, 15 Jun 2023 08:34:12 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am62/64: Add ESM Support
Date:   Thu, 15 Jun 2023 19:04:10 +0530
Message-ID: <168683604345.2365430.13268995742166730561.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530185335.79942-1-nm@ti.com>
References: <20230530185335.79942-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Tue, 30 May 2023 13:53:33 -0500, Nishanth Menon wrote:
> Couple of follow on patches based on [1] adding ESM nodes and mapping
> for AM62/AM64.
> 
> Nishanth Menon (2):
>   arm64: dts: ti: k3-am62: Add ESM support
>   arm64: dts: ti: k3-am64: Add ESM support
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62: Add ESM support
      commit: a58eedd1d195f17418c327482a79de5b84bc5aa8
[2/2] arm64: dts: ti: k3-am64: Add ESM support
      commit: f049b541b81acd88133c2c2247d4fae6c33f1b99

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

