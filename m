Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75A681D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjA3Vwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjA3Vwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:52:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE89234C3;
        Mon, 30 Jan 2023 13:52:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULUVkK022923;
        Mon, 30 Jan 2023 21:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pMeGehCvjIxyYq3VnzuG3YS/OHemqj7G5eJpv4FbH1M=;
 b=n8a2VbTM36K8tEzsZLzv/vieAeKN9eGYyT2UZx64+Nx0Au/09/KwvR2Jr4UucnY7B2dA
 Zwrl5FQ/X3dUCf7ePaoh+F4uDOD48jUHtBlC8/HbxmOIAx2HrtZOgMq74ODQ+Icva/st
 K36Y0rJ1GewHb5fI+J/CxNXxkrzQ3vqH7+f9dJtfpJq3e9QxVwv1XQ3K/nOjTne8pAok
 wWg2LeZVjuCd4sEUO0o5DvXuxD6HG55oubk0h5BBku/T0hpfgfeI/+Gk+/tcGZpKXbsK
 mB5jd1AkDh1BSeAjKXy59JRfRBwrWcPqcCbyDrlLglxGhRUyeYRvmy78IXoIuJwneaKp Jw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpcmgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:52:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULq8RN014878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:52:09 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:52:07 -0800
Message-ID: <e040a41c-8004-a5c0-eb3d-e1b2b06eeb1a@quicinc.com>
Date:   Mon, 30 Jan 2023 13:51:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 00/22] Introduce QC USB SND audio offloading
 support
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <1e889754-6492-4c53-27f0-796002d5680c@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <1e889754-6492-4c53-27f0-796002d5680c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EXurEiNRKHrMlBe5HsV4k8Of91RkhGfa
X-Proofpoint-ORIG-GUID: EXurEiNRKHrMlBe5HsV4k8Of91RkhGfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300201
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 1/26/2023 1:23 AM, Mathias Nyman wrote:
> On 26.1.2023 5.14, Wesley Cheng wrote:
>> Changes in v2:
>>
>> XHCI:
>> - Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
>> in his tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
>>
>>
> 
> I'll submit the first three patches from that branch myself to usb-next, 
> might modify
> them slightly.
> Just need to make sure they don't cause regression. Those are changes I 
> want done anyway.
> 

Sounds good! Thanks!

>> Adjustments made to Mathias' changes:
>>    - Created xhci-intr.h to export/expose interrupter APIs versus 
>> exposing xhci.h.

Do you think using the xhci-intr.h is a viable solution for class 
drivers to request for a secondary interrupter?

>>      Moved dependent structures to this file as well. (so clients can 
>> parse out
>>      information from "struct xhci_interrupter")
>>    - Added some basic locking when requesting interrupters.
>>    - Fixed up some sanity checks.
>>    - Removed clearing of the ERSTBA during freeing of the interrupter. 
>> (pending
>>      issue where SMMU fault occurs if DMA addr returned is 64b - TODO)
> 
> Was this solvable by first clearing high 32 bits and then low 32 bits?
> 

During the freeing of the secondary interrupter, the SMMU fault wasn't 
resolvable with clearing the high bits first.  This does somewhat give 
me the notion that the xHC is attempting to access the event ring base 
address every time the ERSTBA is written.  I believe the hi-lo write 
didn't work, as this time we are zero'ing out the base address. (SMMU 
FAR=0x0)

As stated in Table 5-40 in the XHCI spec, when we write a 0 to the 
secondary interrupter ERSTSZ, it should disable that event ring.  In 
this case, do we really need to explicitly clear the base address 
register?  If I don't clear the ERSTBA (during free), then I don't see a 
SMMU fault even after the event ring has been freed. (ie event ring 
memory has been unmapped from the SMMU)  So this should mean the xHC 
hasn't attempted to access that unmapped region for the memory address 
stored in the ERSTBA.

Likewise, we'll write the ERSTBA again during the alloc phase to a valid 
and mapped address.

Thanks
Wesley Cheng
