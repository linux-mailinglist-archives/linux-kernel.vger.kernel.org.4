Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89862A2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKOUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiKOUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:22:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3AD2CE1E;
        Tue, 15 Nov 2022 12:22:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKMfdZ119957;
        Tue, 15 Nov 2022 14:22:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668543761;
        bh=fxqH4stTU56BjQ2STtiKC3aRArMdnSggWJaOnyPIREM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w3XQUP3evDODxV/VHAsREE8ZHMJlYjqvaAmx6N169EJl+EgM6leT8AA6ngVMHlUW2
         wcpTebZZ6kU5Q5NVogy0ZVCRx7c9On0X3RuSEfPkYt8k7xtlwE8z3e5uHD/1eBducr
         /o4HTW3XF25V5o3K+cDHFp1ulsB8iZi/xrJpALr0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFKMfY0061835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 14:22:41 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 14:22:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 14:22:41 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKMeKr108659;
        Tue, 15 Nov 2022 14:22:40 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <j-choudhary@ti.com>, <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-keerthy@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <devicetree@vger.kernel.org>, <afd@ti.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH 0/3] Drop dma-coherent property from SA2UL
Date:   Tue, 15 Nov 2022 14:22:40 -0600
Message-ID: <166854370828.11536.1320576078226919032.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031152520.355653-1-j-choudhary@ti.com>
References: <20221031152520.355653-1-j-choudhary@ti.com>
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

Hi Jayesh Choudhary,

On Mon, 31 Oct 2022 20:55:17 +0530, Jayesh Choudhary wrote:
> crypto driver itself is not dma-coherent. It is the system-dma
> that moves data and so 'dma-coherent' property should be dropped.
> 
> This series drop it from the crypto nodes for the J7 family of
> TI SoCs.
> 
> DT binding fixes have already been merged[0].
> 
> [...]

(note: I picked up Manorit's reviewed-by as well)

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am65-main: drop dma-coherent in crypto node
      commit: b86833ab3653dbb0dc453eec4eef8615e63de4e2
[2/3] arm64: dts: ti: k3-j721e-main: drop dma-coherent in crypto node
      commit: 26c5012403f3f1fd3bf8f7d3389ee539ae5cc162
[3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: drop dma-coherent in crypto node
      commit: f00f26711d7183f8675c5591ba8daaabe94be452

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

