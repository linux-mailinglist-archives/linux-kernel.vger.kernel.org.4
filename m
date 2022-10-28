Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3961127E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJ1NPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJ1NPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:15:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B753A63;
        Fri, 28 Oct 2022 06:15:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDFLxd124254;
        Fri, 28 Oct 2022 08:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666962921;
        bh=yVb75vWswYo2lZ6O2P7WBQeQA1oaX7Ir3hSVvtddISU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=qGpaKjRmtUzyz/9D2Kq19X68Hep3BHdEy/L9s//hW2bg9uHADtslZtcL61is+dK6T
         oK1Emv2xsOQO9vO4k1WXeU0EQ4o4JezH1yJYv4uf537fD7h1JKLD2nlR++4j+143z6
         ZscBj16MHW8vmw/KNswY3T8TAoCzRWwvh4Cjfe+8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDFLWm022874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:15:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:15:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:15:20 -0500
Received: from [10.250.232.28] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDFGPS062125;
        Fri, 28 Oct 2022 08:15:17 -0500
Message-ID: <0c5d0418-8b1c-3ea4-1ec5-1e229ac18f6c@ti.com>
Date:   Fri, 28 Oct 2022 18:45:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/10] AM62x Disable Incomplete DT Nodes
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221018211533.21335-1-afd@ti.com>
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/22 2:45 am, Andrew Davis wrote:

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

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>
