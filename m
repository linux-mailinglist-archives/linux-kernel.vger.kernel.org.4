Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3336B3BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCJKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:19:26 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B2A56BB;
        Fri, 10 Mar 2023 02:19:23 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAJI6e109458;
        Fri, 10 Mar 2023 04:19:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678443558;
        bh=pVNanGnzeyfpN747FmkvYRwS210SW/78Jb2JiH9pMHI=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=EPY8bd22ocZmqUH81dPBxnLpwxLT++DZlhSYuqjcqdsmwFL27vJgsF/W4pwuxMXbW
         4W3gGyk2WrR1Rdcn6t2fPAcpeVb+pzwVlfTUF0kn4+KgSmMTUiDRNk8mQRZsHwU7e5
         ZZwEEqoquAf3skUgAPBTva7iM0YnsaLSwtYZAWLI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAJIiN066579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:19:18 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:19:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:19:18 -0600
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAJETI028433;
        Fri, 10 Mar 2023 04:19:15 -0600
Message-ID: <eb097dd5-8689-0598-780e-5f9a00128d8f@ti.com>
Date:   Fri, 10 Mar 2023 15:49:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j721e: Add overlay to enable
 CPSW9G ports in QSGMII mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20230310092804.692303-1-s-vadapalli@ti.com>
 <20230310092804.692303-3-s-vadapalli@ti.com>
 <af686c3d-8a24-3066-ea6d-59d435c470b6@linaro.org>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <af686c3d-8a24-3066-ea6d-59d435c470b6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 10/03/23 14:59, Krzysztof Kozlowski wrote:
> On 10/03/2023 10:28, Siddharth Vadapalli wrote:
>> The J7 Quad Port Add-On Ethernet Card for J721E Common-Proc-Board supports
>> QSGMII mode. Use the overlay to configure CPSW9G ports in QSGMII mode.
>>
>> Add support to reset the PHY from kernel by using gpio-hog and gpio-reset.
>>
>> Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
>> directly from U-Boot.
>>
> 
> 
>> +&exp2 {
>> +	qsgmii-line-hog {
>> +		gpio-hog;
>> +		gpios = <16 GPIO_ACTIVE_HIGH>;
>> +		output-low;
>> +		line-name = "qsgmii-pwrdn-line";
>> +	};
>> +};
>> +
>> +&main_pmx0 {
>> +	mdio_pins_default: mdio_pins_default {
> 
> No underscores in node names. Didn't you already get such comments?

Sorry, I overlooked this. I am aware that underscores shouldn't be used. I will
post the v2 series fixing this.

Regards,
Siddharth.
