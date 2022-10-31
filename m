Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA461396B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiJaOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJaOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:54:10 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C9BB8;
        Mon, 31 Oct 2022 07:54:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VEs02U119037;
        Mon, 31 Oct 2022 09:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667228040;
        bh=zqkm021jtzip3ZkKOZoIGeAQdUu0abXG33GeDfCIKYE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Hdby6WqBFbv963vpascjybpM/brO8K5KTmmBJsfSOkSn6RXbRaDp5ZQkWa/OeiyOF
         8WlBM+AyF3uf2IGkgathQYmPaFz8S7sKDcMvF5/lR1ALkGH+VTvgI18II+osV4ggQe
         8VosD5PSdnjj1bWGIisgUuhpsHhpk3JYx1SEtB0s=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VEs0Is012476
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 09:54:00 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 09:54:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 09:54:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VEs0Bp014386;
        Mon, 31 Oct 2022 09:54:00 -0500
Date:   Mon, 31 Oct 2022 09:54:00 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] AM65x Disable Incomplete DT Nodes
Message-ID: <20221031145400.garsliw3nlqgkzcb@bryanbrattlof.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 28, 2022 thus sayeth Andrew Davis:
> Hello all,
> 
> Same story as for AM64x[0], AM62x[1], and J7x[2].
> 
> Last round for AM65x, but there are some boards that I do not have
> (Simatic IOT2050), so testing very welcome!
> 
> Thanks,
> Andrew
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg1018532.html
> [1] https://www.spinics.net/lists/arm-kernel/msg1018864.html
> [2] https://www.spinics.net/lists/arm-kernel/msg1019544.html
> 
> Andrew Davis (11):
>   arm64: dts: ti: k3-am65: Enable UART nodes at the board level
>   arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
>   arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
>   arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
>   arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
>   arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
>   arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
>   arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
>   arm64: dts: ti: k3-am65: Enable McASP nodes at the board level

LGTM! Thanks Andrew!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
