Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4762B24E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKPE1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPE1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:27:42 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CCEC;
        Tue, 15 Nov 2022 20:27:40 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AG4RLGq112791;
        Tue, 15 Nov 2022 22:27:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668572841;
        bh=C/X7s6SVt6zu2Xe45YtuDhssIAYdMIz7Oczws4SA7iw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jbbJyjBOYBy4/3ugbZ+2n57OOFuZX4KjDuQG8LZ43WVUZtCv7SP84BUfVcB0V1vc/
         3lHq9LzhE5GoIHQPpaa11maKG/wHPrETDUDev0NgxNdxNIjUnN+l1s30akmT/I9BVI
         5WJwc2DfzI74T+EZKMzLwg0RuDYjnFxWpPy/szLY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AG4RLcV021881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 22:27:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 22:27:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 22:27:20 -0600
Received: from [172.24.222.97] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AG4RFWX042886;
        Tue, 15 Nov 2022 22:27:16 -0600
Message-ID: <38247c21-647c-2778-c105-b94fa344b27a@ti.com>
Date:   Wed, 16 Nov 2022 09:57:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] RNG clock property cleanup
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221107110607.59216-1-j-choudhary@ti.com>
From:   Manorit Chawdhry <m-chawdhry@ti.com>
In-Reply-To: <20221107110607.59216-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/11/22 16:36, Jayesh Choudhary wrote:
> This series removes the clock property from the rng node of
> K3 devices for TI SoCs as that clock is not dedicated to RNG
> module and it cannot be controlled by the rng driver.
>
> DT binding fix:
> <https://lore.kernel.org/all/20220901171041.32056-1-afd@ti.com/>
>
> Changelog v1 -> v2:
> - Update the commit description properly for each patch
>
> Jayesh Choudhary (3):
>    arm64: dts: ti: k3-am65-main: drop RNG clock
>    arm64: dts: ti: k3-j721e-main: drop RNG clock
>    arm64: dts: ti: k3-am64-main: drop RNG clock
>
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 1 -
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
>   3 files changed, 3 deletions(-)
>
For the whole series,

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

