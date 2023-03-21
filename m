Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3896C2AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCUHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCUG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:59:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C96A7F;
        Mon, 20 Mar 2023 23:59:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L6xk2T070977;
        Tue, 21 Mar 2023 01:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679381986;
        bh=9EBtJGUI7qVoIn1VVGz7rpTqzGVRDExWUFdOjzroc/w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ArdiE2uoxT0IrCks9vN0syqNRRfDnXI+x20l8eTVmP+9A3ekaecg7DFgeBYrTeBww
         p+n3QzMspnuLUvVKmnqFk3jL0czrjroLQQaF/9N/KjXHZRBczcATiRHym4jiZJ6nlG
         K7zx9YbGmTcJE6nU78T/oZ2IStgPRY7thoyI0Fto=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L6xk9l122233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 01:59:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 01:59:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 01:59:46 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L6xglF123465;
        Tue, 21 Mar 2023 01:59:43 -0500
Message-ID: <29a888dc-b523-4140-2e5c-c322fc4ad49d@ti.com>
Date:   Tue, 21 Mar 2023 12:29:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/8] arm64: dts: ti: j7: Add device-tree nodes for MCSPI
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20230320053022.11093-1-vaishnav.a@ti.com>
 <20230320151634.xxcqlqidtqfnhvdt@unknowing>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230320151634.xxcqlqidtqfnhvdt@unknowing>
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

Hi Nishanth,

On 20/03/23 20:46, Nishanth Menon wrote:
> On 11:00-20230320, Vaishnav Achath wrote:
>> This series adds device tree nodes for Multi Channel Serial Peripheral
>> Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
>> MCSPI instances are disabled by default and can be enabled through overlays
>> as required, the changes were tested using spidev loopback test for all
>> instances and the data verified only for main_spi4 which is connected
>> internally as slave to mcu_spi2 for all existing J7 devices.
>>
>> Vaishnav Achath (8):
>>   arm64: dts: ti: k3-j721e-main: Add MCSPI nodes
>>   arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCSPI nodes
>>   arm64: dts: ti: k3-j7200-main: Add MCSPI nodes
>>   arm64: dts: ti: k3-j7200-mcu-wakeup: Add MCSPI nodes
>>   arm64: dts: ti: k3-j721s2-main: Add MCSPI nodes
>>   arm64: dts: ti: k3-j721s2-mcu-wakeup: Add MCSPI nodes
>>   arm64: dts: ti: k3-j784s4-main: Add MCSPI nodes
>>   arm64: dts: ti: k3-j784s4-mcu-wakeup: Add MCSPI nodes
> 
> Why split the patches per bus? why not club the patches at SoC level?
> 

I split them initially since the changes were in two different files, I have
combined the changes at SoC level and send a V2,

https://lore.kernel.org/all/20230321065447.6997-1-vaishnav.a@ti.com/#r

-- 
Regards,
Vaishnav
