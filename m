Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA86FC35F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjEIKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEIKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:02:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EADE49
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:02:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349A2LvV096995;
        Tue, 9 May 2023 05:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683626541;
        bh=7M2efcBhLwpMXQlbfmGHhxpkElb1sZWiOsOlcPdLtnM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AnRKcOZHiYa2iylKvADQG77bmLF0cNgBoWyVO5WcCI30BwstXkIeQAWocB01JDCPg
         nU7QjARe0m5Pv2wlef+1ML/cOFFkTrW4QCsPb7AtXNcKP0XMaVr2MY+0abwXt7p2ww
         1kN1bOYIesBviPqYz71ZafHlQvLAoTiXwPii7FDk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349A2L0F009547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:02:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:02:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:02:21 -0500
Received: from [10.249.131.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349A2GtE110931;
        Tue, 9 May 2023 05:02:16 -0500
Message-ID: <35f0c8d0-6681-4fb7-5f80-646687225d14@ti.com>
Date:   Tue, 9 May 2023 15:32:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: enable PCIe controller
 on TI platforms
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
References: <20230509063431.1203367-1-a-verma1@ti.com>
 <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
 <de6432db-0da0-b535-1f44-04541116be8b@ti.com>
 <63dc3d1b-ba17-48ee-a02e-83b2903e360a@app.fastmail.com>
 <b48613f5-9442-5a41-34fb-760d9edf3682@ti.com>
 <2880d5bb-61ce-a4d7-f870-b5549a5d88f2@linaro.org>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <2880d5bb-61ce-a4d7-f870-b5549a5d88f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 3:01 PM, Krzysztof Kozlowski wrote:
> On 09/05/2023 11:19, Verma, Achal wrote:
>>
>> Hello,
>> On 5/9/2023 1:58 PM, Arnd Bergmann wrote:
>>> On Tue, May 9, 2023, at 10:08, Vignesh Raghavendra wrote:
>>>
>>>> Also, see [0] for history. We really want these to be
>>>> modules unless its necessary for bootup.
>>>>
>>>> You may want to revive [1] and get it to mainline
>>>>
>>>> [0]
>>>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
>>>> [1]
>>>> https://lore.kernel.org/linux-arm-kernel/20230110153805.GA1505901@bhelgaas/
>>>
>>> Agreed, that seems simple enough. Ideally these should even
>>> be removable modules, not just single-load but unremovable.
>>>
>>> Doing that may require changes to the cadence PCIe host
>>> code if that does not support unloading yet (I have not
>>> checked), but should not require any changes to the core
>>> PCIe host code that supports loadable/removable modules.
>>>
>>>        Arnd
>> So, my understanding is that following change is expected
>> +CONFIG_PCIE_CADENCE=m
>> +CONFIG_PCIE_CADENCE_HOST=m
>> +CONFIG_PCIE_CADENCE_EP=m
>> +CONFIG_PCI_J721E=m
>> +CONFIG_PCI_J721E_HOST=m
>> +CONFIG_PCI_J721E_EP=m
>> +CONFIG_PCI_EPF_NTB=m
>>
>> I also want to inform that pci_j721e.c is a single file with both host
>> and EP functionality, last attempt to build it as modules depending on
>> host or EP selected failed because of symbols dependency.
>> Refactoring of pci_j721e.c into common, host and EP specific files could
>> work similar to the Cadence driver, So I will follow this way and push
>> the changes.
>>
>> Please let me know if there are concerns.
> 
> Aren't HOST and EP just customizing main module?
Current pci-j721e driver is composed of host specific and endpoint 
specific code encapsulated in switch case and shared required common 
code, last attempt of putting endpoint and host specific code inside EP 
and HOST CONFIGS respectively failed (also reported by kernel test bot) 
when tried with different combinations of Y/M/N along with CADENCE 
driver on which pci-j721e depends, So only way is to break main module 
into common, host and endpoint files.
> 
> Best regards,
> Krzysztof
> 
