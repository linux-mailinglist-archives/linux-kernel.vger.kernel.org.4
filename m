Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697D604B56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJSP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiJSP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:27:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A911D4404;
        Wed, 19 Oct 2022 08:20:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29JFJ62p062988;
        Wed, 19 Oct 2022 10:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666192746;
        bh=hgvKuMYRReQ/YIGdZqCMAWOo31oN4NukuCC1/NHydnY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OQgNCM5zIxRKuM7Hy0vzdGZ1eW7BUYfoaaCK9euxAR8Gyij6OovVqOeZ3vGywYI6F
         ShwLPAe4sD/0aQ4PSC14vZ/eCWYA0zUFuFi74NqeqzpUm+iMnT1hA6a2OyLHdm26Yq
         pDltpneCd7hLLPNufZ4z4FYmQqFlyoXD/4DuovOE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29JFJ6fw105079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Oct 2022 10:19:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 19
 Oct 2022 10:19:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 19 Oct 2022 10:19:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29JFJ5h8010414;
        Wed, 19 Oct 2022 10:19:05 -0500
Date:   Wed, 19 Oct 2022 10:19:05 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] AM62x Disable Incomplete DT Nodes
Message-ID: <20221019151905.5w3cudpjfn42f5jm@bryanbrattlof.com>
References: <20221018211533.21335-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 18, 2022 thus sayeth Andrew Davis:
> Hello all,
> 
> Same story as for AM64x[0], this time for AM62x. If there
> are no objections here then the J7x platforms are next.
> 
> Thanks,
> Andrew
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg1018532.html

Not a lore fan is see ;)

>
> Andrew Davis (10):
>   arm64: dts: ti: k3-am62: Enable UART nodes at the board level
>   arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-am62: Enable SPI nodes at the board level
>   arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
>   arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
>   arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
>   arm64: dts: ti: k3-am62: Enable MDIO nodes at the board level
>   arm64: dts: ti: k3-am62: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-am62: Enable SDHCI nodes at the board level
>   arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 26 +++++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  4 ++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  2 +
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts     | 81 +++-------------------
>  4 files changed, 43 insertions(+), 70 deletions(-)
> 

LGTM!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
