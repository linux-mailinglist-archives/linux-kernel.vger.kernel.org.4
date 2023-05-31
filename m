Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C171788F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjEaHpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjEaHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:45:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C53C5;
        Wed, 31 May 2023 00:45:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7Zxrk024622;
        Wed, 31 May 2023 07:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5/KPGixHQEe4ArgFn9xQuro6/NX1I/JhlNlISJP6N/g=;
 b=ASaEdO4SJ5kx6FZbMMy+W5H1TOJXkWzsnRlNFDJvZKWwA0oUmkI/sWPpxWCc9vsegBNX
 Mmo7StmKZ/6kAIHwNp5/d2kqR7JE78np/NsGZ895zQMPSxAVtFW1GszMNQHbwMZ2O/gf
 boo4hK3mZmrXPBQQ6okLKaUajg8LbErT8KJ0YxFjk0wrIvVLIIudW0QYCvlk/TafA7/A
 mhKZqieqBW3UIxCP9AMr8ruwh2vTR9llS/2o4Uvr3qR4UNUJAMOJstlajFtf6ozmTcV5
 RxR7WoPHOjoc7rREDSm9/tw/4zuV8dP+LIT53WEynvwZBUSbdII8darzCTamNgi2u32j 0g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx1yk00ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 07:45:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V7jaIQ024487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 07:45:36 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 00:45:33 -0700
Message-ID: <eefd371e-9c9c-2e29-8d6e-d657ee0db237@quicinc.com>
Date:   Wed, 31 May 2023 13:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>
CC:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
 <38a627a2-040d-23e2-5637-32f199d0fc31@quicinc.com>
 <ZHbvkDkkS_pZltMG@gerhold.net>
 <31b850f0-7ee4-67e0-8cdb-39b9651a9d57@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <31b850f0-7ee4-67e0-8cdb-39b9651a9d57@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ooZxzd3ln4sMwMn7h4836vpohOYGx0Ov
X-Proofpoint-GUID: ooZxzd3ln4sMwMn7h4836vpohOYGx0Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310068
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 1:04 PM, Vikash Garodia wrote:
> 
> On 5/31/2023 12:26 PM, Stephan Gerhold wrote:
>> On Wed, May 31, 2023 at 11:36:52AM +0530, Vikash Garodia wrote:
>>> On 5/29/2023 11:46 PM, Stephan Gerhold wrote:
>>>> Reserved memory can be either looked up using the generic function
>>>> of_address_to_resource() or using the special of_reserved_mem_lookup().
>>>> The latter has the advantage that it ensures that the referenced memory
>>>> region was really reserved and is not e.g. status = "disabled".
>>>>
>>>> of_reserved_mem also supports allocating reserved memory dynamically at
>>>> boot time. This works only when using of_reserved_mem_lookup() since
>>>> there won't be a fixed address in the device tree.
>>> IIUC, this would avoid precomputing the hard range for different firmware
>>> regions and also make it more flexible to adjust the sizes, if anyone wants a
>>> bigger size later.
>>> Incase a specific firmware needs a dedicate start address, do we have an option
>>> to specify the same ?
>>>
>>
>> If you want a specific start address (or in other words: a fixed base
>> address) then you should continue using static reservation for that
>> component. You can mix static and dynamic reservations. The static ones
>> (with fixed addresses) will be reserved first, then the dynamic ones
>> will be allocated from the free space.
>>
>> I have this example for one device in my proposal at [1]:
>>
>> 	/* Firmware must be loaded at address 0x8b600000 */
>> 	wcnss_mem: wcnss@8b600000 {
>> 		reg = <0x8b600000 0x600000>;
>> 		no-map;
>> 	};
>> 	/* Firmware can be loaded anywhere with 1 MiB alignment */
>> 	venus_mem: venus {
>> 		size = <0x500000>;
>> 		alignment = <0x100000>;
>> 		no-map;
>> 	};
>>
>> The wcnss_mem will be always at 0x8b600000, but the venus_mem can be
>> loaded somewhere around that. If only certain regions need a fixed
>> address this still provides the flexibility to change sizes more easily.
>>
>> Does that answer your question? I wasn't sure what exactly you mean with
>> a "dedicated start address". :)
> Yes, it clarified the need if any subsystem wants a specific start address.
> 
> One more thing, lets say, we keep it dynamic allocation and at the same time we
> need to pass the start address to TZ call in [1]. How do we get that allocated
> address so as to pass in [1] ?

+	*mem_phys = rmem->base;

It will provide the start, is not it ?

-- Mukesh

> 
> Thanks,
> Vikash
> 
> [1]:
> https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/soc/qcom/mdt_loader.c#L249
