Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827B07500AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGLIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjGLID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:03:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01ED1BC0;
        Wed, 12 Jul 2023 01:03:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6HJ4b012814;
        Wed, 12 Jul 2023 08:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dgsJcgx4OO/iJndXs1xts8G7gzalVktNdO4CkRnQ6+M=;
 b=ehAwqJT/nhJaM+4gmssexos6ymYMHYgy4nHrjXcehLiYZuLCj/HlqjgejA3wjq+djMpb
 w7IQGuC1eAiSBenwng8dipxHtbB0HV8OM69S0lgIDx6yoi1jqXyswyIaUiosG4d+zbAn
 YrlUzc9NIT080zEN2jyJRwQPm5Of122mSkMW9n0GrB+onzWN0xVtbjkYWHY1yweqsTwS
 BKUZwiQZOzQf8+pDkICy3vbBGXZorm8vKTWa/waVIWAmpdwEgxgWiOUCONaRSmJSYFa8
 z3kqh3OfWPjPHdW/4E3nAO1xeDcWPwyhvTJtDQP6AEelNGPV2Nm0HRiK4sCa/2Qq9xi2 ow== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf87gx4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:03:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C83g1u004136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:03:42 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 01:03:39 -0700
Message-ID: <c38179ec-ff16-7b38-8124-87d009aafac8@quicinc.com>
Date:   Wed, 12 Jul 2023 16:03:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Marc Zyngier <maz@kernel.org>
CC:     <will@kernel.org>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_songxue@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <875y6s8bwb.wl-maz@kernel.org>
 <32f442e3-3d5c-4cec-9791-0da039f88287@quicinc.com>
 <874jmc8654.wl-maz@kernel.org>
 <6e07ad52-2629-346e-6217-ec07777ebc5b@quicinc.com>
 <86lefnvsto.wl-maz@kernel.org>
 <8a950aa5-fdd8-f983-0411-4b39ade596f4@quicinc.com>
 <86cz0ywx5p.wl-maz@kernel.org>
 <9e69158f-1e67-344b-fea9-85bb5e21183f@quicinc.com>
 <87h6q9a8pu.wl-maz@kernel.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <87h6q9a8pu.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rlkFao0PXBYir0ve8zwCfMknVxFTaTf7
X-Proofpoint-ORIG-GUID: rlkFao0PXBYir0ve8zwCfMknVxFTaTf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=677 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2023 3:29 PM, Marc Zyngier wrote:
> On Wed, 12 Jul 2023 03:47:55 +0100,
> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>
>> On 7/11/2023 6:38 PM, Marc Zyngier wrote:
>>> On Tue, 11 Jul 2023 11:12:48 +0100,
>>> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>>>
>>>> For the KVM part, per my understanding, as long as the current feature
>>>> id being overriden, the KVM system also get the current vcpu without
>>>> the lse atomic feature enabled.
>>>> KVM vcpu will read the sys reg from host arm64_ftr_regs which is
>>>> already been controled by the idreg_overrides.
>>>
>>> You're completely missing the point.
>>>
>>> The guest is free to map memory as non-cacheable *and* to use LSE
>>> atomics even if the idregs pretend this is not available. At which
>> The guest also can have the current linux kernel mechanism of LSE
>> ATOMIC way.
> 
> [snip useless diagrams]
> 
> Yes, the guest can do the right thing. The guest, a totally
> unprivileged piece of SW, can also ignore the idregs and take the
> whole machine down because your HW is broken.
> 
if the guest ignore the idregs, it is not supported by the current Linux 
KVM id reg emulation as well. The similar rule is applied to other cpu 
feature as well.

So it can be an expected machine down because of this.

We want to support/utilize the current HW with current inline runtime 
patching for lse atomic ops.
>> Just like other KVM vcpu cpu features, lse atomic can be a feature
>> inherit from the pysical cpu features for the KVM vcpus.
> 
> See above. Your reasoning applies to a well behaved guest, which is
> the *wrong* way to reason about these things.

The feature supported is not always that *freely* even for current cpu 
features as well.
Our current target is that the software can utilize the HW as best as 
software can.

The current HW can be possible with Generic common Image with other cpu 
which support lse atomic. So the Image can have inline runtime patching 
for lse atomic operations. And from software side it can have option to 
support this.

For example, for current newer memory controller the far lse atomic 
operations is supported, and the atomic operation is not limited to 
non-cached memory mapping as well.

Also the lse atomic instead of FWB performance in specific scenarios can 
be different with current hardware design as well.

we are trying to do possible improvement with HW design change instead 
of ruin it.
Feel free to comment if it is not same understanding.
> 
> 	M.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

