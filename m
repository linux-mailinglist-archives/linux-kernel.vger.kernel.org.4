Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E966BCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAPLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAPLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:18:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC151DB8F;
        Mon, 16 Jan 2023 03:18:18 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GBI1mj076899;
        Mon, 16 Jan 2023 05:18:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673867881;
        bh=DAuiYCUADfCRO/9+N0H7cdlBM2EtTekj/zRe4H7QKaU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NAZEtGwVp3CG0kOrJNhFO0nQ4VELN14Qa3KmJErImPqQRnt2Pi7O+RdVRCYOBNJCh
         PpO7tXZPD6CRF4xC/8F3/kkTU8lfoqxvrgXLUk2AjCfqL6Dxkn8IqfBLBxGrueqZQQ
         JTK42lNv7s9qCnA6xE1DHLtB0311SCh0u+bxNkPY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GBI1ix009870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 05:18:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 05:18:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 05:18:01 -0600
Received: from [172.24.145.71] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GBHv7T042725;
        Mon, 16 Jan 2023 05:17:58 -0600
Message-ID: <c7e9d9bb-d3d1-f958-b255-9128751be568@ti.com>
Date:   Mon, 16 Jan 2023 16:47:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V5 0/3] AM68 SK: Add initial support
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230116071446.28867-1-sinthu.raja@ti.com>
Content-Language: en-US
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230116071446.28867-1-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu

On 16/01/23 12:44, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Hi All,
> This series of patches add support for AM68 Starter kit(SK). AM68 SK
> is a low cost, small form factor board designed for TI’s AM68 SoC.
> 
> Refer below link to AM68 Technical Reference Manual for further details:
> http://www.ti.com/lit/pdf/spruj28
> 
> Design files can be referrred from https://www.ti.com/lit/zip/SPRR463
> 
> Changes in V5:
> =============
> Address review comments:
> - Remove the unessential comment.
> - Remove alignment property from secure-ddr node, as no memory is allocated out
>    of this region.
> 
> Changes in V4:
> =============
> Repost after rebasing to 6.2 rc1
> 
> Changes in  V3:
> ==============
> Address all the review comments and the changes are captured in separate patches.
>   - Remove the unused nodes that are disabled by default.
>   - Update the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-1-sinthu.raja@ti.com/t/#mbe43b02221733bb6eb06b203359e90ec08406afc
> V2: https://lore.kernel.org/lkml/20221107123852.8063-1-sinthu.raja@ti.com/
> V3: https://lore.kernel.org/lkml/20230110110052.14851-1-sinthu.raja@ti.com/
> V4: https://lore.kernel.org/lkml/20230105151740.29436-1-sinthu.raja@ti.com/
> 
> Sinthu Raja (3):
>    dt-bindings: arm: ti: Add binding for AM68 SK
>    arm64: dts: ti: Add initial support for AM68 SK System on Module
>    arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board
> 
>   .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
>   arch/arm64/boot/dts/ti/Makefile               |   2 +
>   .../boot/dts/ti/k3-am68-sk-base-board.dts     | 335 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    |  29 ++
>   4 files changed, 367 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> 

For the series:

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
