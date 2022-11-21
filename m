Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F2631DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKUKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKUKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:12:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193613CFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:12:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7xnjL006487;
        Mon, 21 Nov 2022 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xJnXZMuGkMM3asOVBftY7SLBqbmpzgFfuwmpeoFkQRA=;
 b=LerrHJNzAUfe38JBrewG+ROhXFP14mZH82xGQC06655F0ggoC+IrxxE5QKRDNAnKVj6k
 xpiIAhNDuJI80LRAbYC69VYGh0x3Sn4m1Iq+JwQHY2uA87dt6I02ND4it9M/WZtM4BDO
 8lAeEjbbeo5d+CycgDFqzLAgFtJDquLCtKfSbgkSOaHn441jXt7nGZmiENQliaVBOxja
 m+Wmi9ycDtsk1JoKc0UV1T52VGQhG4FECn+Ueg/p/8DPXVozwVSNSTq5Qn8lMPDWQq5G
 gjkMiPIvSO37imfz3xOBXhCO/bU94TIj3z9neVe1ZsiiB83oJjNPSjlljCZ+Uf4gZpdV Fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxream50s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:12:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALACaVg032454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:12:36 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 02:12:30 -0800
Message-ID: <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
Date:   Mon, 21 Nov 2022 15:42:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, <amit.pundir@linaro.org>,
        <andersson@kernel.org>, <sumit.semwal@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com> <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad> <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221121064224.GB11945@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NNaUO2DtSVfX5F25WV76KfYAm98_84Ey
X-Proofpoint-ORIG-GUID: NNaUO2DtSVfX5F25WV76KfYAm98_84Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/22 12:12, Manivannan Sadhasivam wrote:
> On Fri, Nov 18, 2022 at 12:33:49PM +0000, Will Deacon wrote:
>> On Fri, Nov 18, 2022 at 04:24:02PM +0530, Manivannan Sadhasivam wrote:
>>> On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
>>>> On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
>>>>> On 2022-11-14 14:11, Will Deacon wrote:
>>>>>> On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
>>>>>>> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
>>>>>>>
>>>>>>> As reported by Amit [1], dropping cache invalidation from
>>>>>>> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
>>>>>>> (most probably on other Qcom platforms too). The reason is, Qcom
>>>>>>> qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
>>>>>>> for validation. The modem has a secure block (XPU) that will trigger a
>>>>>>> whole system crash if the shared memory is accessed by the CPU while modem
>>>>>>> is poking at it.
>>>>>>>
>>>>>>> To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
>>>>>>> with no kernel mapping, vmap's it, copies the firmware metadata and
>>>>>>> unvmap's it. Finally the address is then shared with modem for metadata
>>>>>>> validation [2].
>>>>>>>
>>>>>>> Now because of the removal of cache invalidation from
>>>>>>> arch_dma_prep_coherent(), there will be cache lines associated with this
>>>>>>> memory even after sharing with modem. So when the CPU accesses it, the XPU
>>>>>>> violation gets triggered.
>>>>>>
>>>>>> This last past is a non-sequitur: the buffer is no longer mapped on the CPU
>>>>>> side, so how would the CPU access it?
>>>>>
>>>>> Right, for the previous change to have made a difference the offending part
>>>>> of this buffer must be present in some cache somewhere *before* the DMA
>>>>> buffer allocation completes.
>>>>>
>>>>> Clearly that driver is completely broken though. If the DMA allocation came
>>>>> from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
>>>>> shenanigans wouldn't work, so if it backed by struct pages then the whole
>>>>> dance is still pointless because *a cacheable linear mapping exists*, and
>>>>> it's just relying on the reduced chance that anything's going to re-fetch
>>>>> the linear map address after those pages have been allocated, exactly as I
>>>>> called out previously[1].
>>>>
>>>> So I guess a DMA pool that's not mapped in the linear map, together with
>>>> memremap() instead of vmap(), would work around the issue. But the
>>>> driver needs fixing, not the arch code.
>>>>
>>>
>>> Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
>>> not part of the kernel's linear map? I looked into it but couldn't find a way.
>>
>> The no-map property should take care of this iirc
>>
> 
> Yeah, we have been using it in other places of the same driver. But as per
> Sibi, we used dynamic allocation for metadata validation since there was no
> memory reserved statically for that.

Will,

Unlike the other portions in the driver that required statically defined 
no-map carveouts, metadata just needed a contiguous memory for 
authentication. Re-using existing carveouts for this metadata region
may not work due to modem FW limitations and declaring a new carveout 
for metadata will break the device tree bindings. That's the reason for
using DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr and vmpa/vunmap with
VM_FLUSH_RESET_PERMS before passing the memory onto modem. Are there 
other suggestions for achieving the same without breaking bindings?

- Sibi

> 
> But if we do not have a way to allocate a dynamic memory that is not part of
> kernel's linear map, then we may have to resort to using an existing reserved
> memory.
> 
> Thanks,
> Mani
> 
>> Will
> 
