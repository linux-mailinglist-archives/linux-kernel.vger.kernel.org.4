Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFB66DA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjAQJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjAQJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:33:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887E44A1;
        Tue, 17 Jan 2023 01:32:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30H9WYq8129934;
        Tue, 17 Jan 2023 03:32:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673947954;
        bh=+N4fJ7UvYcL31lhx3PT2sqSpjRoDoDBgG+OHb6Sl8A8=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=KWwUmo2Jk1GdpxiVyOfzxeZCaTvZW3tsdPgyS07xE4e7S3AgBOilGryRVaG7795LK
         YNXa2W6zIKnxJ77Ea6wSgOeISyMDB1LleVao/jW+z5b+X/pSB4ChKaXE+FNVnbmDve
         EXoku8dmoIIa+WkhfUc/+92mQRbcdDUBvoy4lFvA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30H9WYQ3104669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 03:32:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 03:32:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 03:32:34 -0600
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30H9WUju009929;
        Tue, 17 Jan 2023 03:32:30 -0600
Message-ID: <d978d797-2e04-89b0-4585-68d28347f469@ti.com>
Date:   Tue, 17 Jan 2023 15:02:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
CC:     Andrew Davis <afd@ti.com>, Matt Ranostay <mranostay@ti.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 7/8] arm64: dts: ti: k3-j721s2-main: Add PCIe device
 tree node
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>
References: <20221122101616.770050-1-mranostay@ti.com>
 <20221122101616.770050-8-mranostay@ti.com>
 <a88349a2-94ac-1980-1998-a45ac5525f6b@ti.com>
 <20230117092331.GA3277247@desktop-3598>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230117092331.GA3277247@desktop-3598>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hello Achal,

On 17/01/23 14:53, Achal Verma wrote:
>  Tue, Nov 29, 2022 at 11:53:46AM -0600, Andrew Davis wrote:
>> On 11/22/22 4:16 AM, Matt Ranostay wrote:
>>> From: Aswath Govindraju <a-govindraju@ti.com>
>>>
>>> Add PCIe1 RC device tree node for the single PCIe instance present on
>>> the j721s2.
>>>
>>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 41 ++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index 2858ba589d54..27631ef32bf5 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -841,6 +841,47 @@ serdes0: serdes@5060000 {
>>>   		};
>>>   	};
>>> +	pcie1_rc: pcie@2910000 {
>>
>> NIT: Not sure we need to call this "_rc", and "1", 0 index these names for
>> consistency, "pcie0".
> 
> Sure, I will name this node as "pcie0_rc" in next patch and "_rc" is because it can be used in endpoint mode too for which "pcie0_ep" node can be added in future.

The naming is based on the PCIe instance documented in the Technical Reference
Manual (TRM). For example, consider J7200 SoC which has "pcie1_rc" even though
it has no "pcie0_rc". This convention is based on the numbering used in the TRM.

Regards,
Siddharth.
