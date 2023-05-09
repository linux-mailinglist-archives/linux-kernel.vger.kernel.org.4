Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D56FC299
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjEIJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjEIJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:20:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050CDD85
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:20:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3499Jd2x087067;
        Tue, 9 May 2023 04:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683623979;
        bh=XjeHZkAJennOHr258rCrV4GRf9FDx9zmj72yfhORqwI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qMhKljM8Q9VweNL/0D/4ZEmzAC8DErC1ziqApufgdyTi8Pm5WyDn1zxvW5Ydds0xS
         lj9JiQja+p7JoxnLyi2X/V45tZjwiPX5OeJBD1vVYH3igc+ooZeG7g4CTAaVKu2/UO
         4z9q9d3OUwM7HLk+ZQk2lRIjrnz3Oh3LMYHF+mPc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3499Jd8P014658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 04:19:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 04:19:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 04:19:39 -0500
Received: from [10.249.131.60] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3499JXZq074545;
        Tue, 9 May 2023 04:19:34 -0500
Message-ID: <b48613f5-9442-5a41-34fb-760d9edf3682@ti.com>
Date:   Tue, 9 May 2023 14:49:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: enable PCIe controller
 on TI platforms
To:     Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <63dc3d1b-ba17-48ee-a02e-83b2903e360a@app.fastmail.com>
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


Hello,
On 5/9/2023 1:58 PM, Arnd Bergmann wrote:
> On Tue, May 9, 2023, at 10:08, Vignesh Raghavendra wrote:
> 
>> Also, see [0] for history. We really want these to be
>> modules unless its necessary for bootup.
>>
>> You may want to revive [1] and get it to mainline
>>
>> [0]
>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
>> [1]
>> https://lore.kernel.org/linux-arm-kernel/20230110153805.GA1505901@bhelgaas/
> 
> Agreed, that seems simple enough. Ideally these should even
> be removable modules, not just single-load but unremovable.
> 
> Doing that may require changes to the cadence PCIe host
> code if that does not support unloading yet (I have not
> checked), but should not require any changes to the core
> PCIe host code that supports loadable/removable modules.
> 
>       Arnd
So, my understanding is that following change is expected
+CONFIG_PCIE_CADENCE=m
+CONFIG_PCIE_CADENCE_HOST=m
+CONFIG_PCIE_CADENCE_EP=m
+CONFIG_PCI_J721E=m
+CONFIG_PCI_J721E_HOST=m
+CONFIG_PCI_J721E_EP=m
+CONFIG_PCI_EPF_NTB=m

I also want to inform that pci_j721e.c is a single file with both host 
and EP functionality, last attempt to build it as modules depending on 
host or EP selected failed because of symbols dependency.
Refactoring of pci_j721e.c into common, host and EP specific files could 
work similar to the Cadence driver, So I will follow this way and push 
the changes.

Please let me know if there are concerns.


Thanks,
Achal Verma


