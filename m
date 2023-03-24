Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425E36C826C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCXQe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:34:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2AE3AB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:34:23 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ODBKRW011039;
        Fri, 24 Mar 2023 17:34:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SboRCbcyRuV05Ygpi/rKpxPTf5aTWPczlwFRg2CMDRo=;
 b=T1+qXB3/c6jdtvoAkUgyEpBxAGzqwuBFCsWuiyKbxIETREUwr3A76lTJOo0vBuZAkNTy
 VO0l4l7EVVtHUdnZZ3eEBAxShGVOxviBwXQq3yHB7Ov0nom1tKaaNk+rvVNH4PSDsOwH
 Xhn3tCgGE7FhwD6BTqIbLU2FYxUu7XEBw07cKlsqF3r+W2i6u0FrfqkbGr9x/NL2ctgi
 3r1uqqtHemjlgCwEJ9cPCAFQEuz79w6yBOgSiZs7eAT6/qYvoaiOx51qKFUexd2mQj1O
 HdgCQXQqejL4okcP6ITmGvn+/pK3Hghd6XeTjJV5SljswAZOxNp5Ob+UdTIPDvbOg3AX hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pgxjwe1x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 17:34:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 713F210002A;
        Fri, 24 Mar 2023 17:34:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C90921ADAE;
        Fri, 24 Mar 2023 17:34:15 +0100 (CET)
Received: from [10.48.0.175] (10.48.0.175) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Mar
 2023 17:34:15 +0100
Message-ID: <f4c32aa5-e5b1-6465-7708-ef0281baf0af@foss.st.com>
Date:   Fri, 24 Mar 2023 17:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: do not support EDO mode
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230324160918.826452-1-christophe.kerello@foss.st.com>
 <20230324172528.4d3ccd4b@xps-13>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20230324172528.4d3ccd4b@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_10,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel,

On 3/24/23 17:25, Miquel Raynal wrote:
> Hi Christophe,
> 
> christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 17:09:18 +0100:
> 
>> FMC2 controller does not support EDO mode (timings mode 4 and 5).
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")
>> ---
>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> index 5d627048c420..3abb63d00a0b 100644
>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> @@ -1531,6 +1531,9 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>>   	if (IS_ERR(sdrt))
>>   		return PTR_ERR(sdrt);
>>   
>> +	if (sdrt->tRC_min < 30000)
> 
> When introducing NV-DDR support we as well added a timings.mode field,
> perhaps you could use it?

Yes, I can use it. It will be done in V2.

Regards,
Christophe Kerello.

> 
>> +		return -EOPNOTSUPP;
>> +
>>   	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>>   		return 0;
>>   
> 
> 
> Thanks,
> Miquèl
