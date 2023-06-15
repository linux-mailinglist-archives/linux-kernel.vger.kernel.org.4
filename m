Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB57319F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjFONaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbjFONaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:30:07 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80090271C;
        Thu, 15 Jun 2023 06:30:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDU06H014196;
        Thu, 15 Jun 2023 08:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835800;
        bh=2NMh/b/afTkBqtJlqpb9uOC9liEojj7j/JQOCJZX2e0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pL7twuoLZgaCXyqsqNG0i1d7uvDJAHLfdfcN+LhEhYDt5yPnokvrDmLkQsa32YA3m
         7onQH5HI+5+dtadXbz9MLooRQRYNBAo/PQZfXh1D1mZe/NhLLqCSbHbwb+w+tkUbMj
         idm7D0UK1NtUdqWBEceg0xO+wrN5NiwRV2mSGF+Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDU0Vc056505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:30:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:29:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:29:59 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDTuKn092222;
        Thu, 15 Jun 2023 08:29:57 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <kristo@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Change CPTS clock parent
Date:   Thu, 15 Jun 2023 18:59:54 +0530
Message-ID: <168681817156.2098323.5002450800685982754.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605110443.84568-1-n-francis@ti.com>
References: <20230605110443.84568-1-n-francis@ti.com>
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

Hi Neha Malcom Francis,

On Mon, 05 Jun 2023 16:34:43 +0530, Neha Malcom Francis wrote:
> MAIN_PLL0 has a flag set in DM (Device Manager) that removes it's
> capability to re-initialise clock frequencies. CPTS and RGMII has
> MAIN_PLL3 as their parent which does not have this flag. While RGMII
> needs this reinitialisation to default frequency to be able to get
> 250MHz with its divider, CPTS can not get its required 200MHz with its
> divider. Thus, move CPTS clock parent on J721S2 from MAIN_PLL3_HSDIV1 to
> MAIN_PLL0_HSDIV6.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721s2: Change CPTS clock parent
      commit: 1f36d0e8be3ae7717c801e954275fba6247b2f46

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

