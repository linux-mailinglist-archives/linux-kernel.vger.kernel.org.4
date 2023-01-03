Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860E65C426
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjACQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjACQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:45:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00511A23
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:45:18 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303GHmoH031533;
        Tue, 3 Jan 2023 16:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UbFgjDhY1raX2ZeNtZC/NjM2vYEciID/vxc09kYi1h8=;
 b=ELV2nQMMWX5MLvKith4XqMDur1qBLJCA3rNT7GBYTVhfoO/Jlq+Ii049QEORqQN1m6aQ
 JY3eNWlJnctIeufIvqb0FaeImjvTrV+bM3VtqlcxJTpn9HQhG5X49bZ4SmNFI+FtvhT2
 zrX5Px8rqvvNi7p3z8t0jHKFNVEKXZgzdbojD3CrzfvfCT2GcA/qVIm7YzmjaKswrfTi
 tPBFAPPALLPqu8mPcNsquSGm6UeYAmam6C24pkynfiLoVsMsKh+m3m0kfr9G6vyYIdqX
 iZSUkY2HY2bmYptYy138LkwIOABkE//s1KT+Xmwn/fP7p/7zU30+scFPsAF2FAE4j8qt uA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvqrp8207-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:45:10 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 303Gj9uw016911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Jan 2023 16:45:09 GMT
Received: from [10.216.2.249] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 08:45:07 -0800
Message-ID: <a20a9592-05e7-c529-5ab1-d7d52fffa59a@quicinc.com>
Date:   Tue, 3 Jan 2023 22:15:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Query about IPI as NMI (pseudo-NMI) support patches
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>
References: <5bed08c5-8663-4e68-27b4-8b6d3957a880@quicinc.com>
 <86zgb07tfs.wl-maz@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <86zgb07tfs.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ymsRVg-mp3cYhD5WMckbu89yoO4s_IFs
X-Proofpoint-GUID: ymsRVg-mp3cYhD5WMckbu89yoO4s_IFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 mlxlogscore=777
 lowpriorityscore=0 spamscore=0 clxscore=1031 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030142
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your reply.

On 1/2/2023 10:41 PM, Marc Zyngier wrote:
> Hi Mukesh,
> 
> On Mon, 02 Jan 2023 16:44:59 +0000,
> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Hi Marc,
>>
>> I was looking similar support mentioned in below patch series.
>>
>> https://lore.kernel.org/lkml/CAFA6WYO0+LQ=mB1spCstt0cNZ0G+sZu_+Wrv6BKSeXqF5SRq4A@mail.gmail.com/#t
>>
>> Wanted to check if there is chance of these patches to land in
>> mainline ?
> 
> I certainly have no intention to merge it as is, specially as there is
> no good usage model for it other than "but think of debug!".
> 
> We have exactly *one* SGI left. If we are going to lose it over such a
> feature, I'd want a description of how we are going to share it
> between potential users, and how we claw some currently used SGIs
> back.


But, looks like patch will fail if SGI is not available.

https://lore.kernel.org/lkml/1604317487-14543-4-git-send-email-sumit.garg@linaro.org/



set_smp_ipi_range(base_sgi, 8);

+	if (n > nr_ipi)
+		set_smp_dynamic_ipi(ipi_base + nr_ipi);
+

So, static SGI allocation still has higher priority than dynamic one.
Would you be accepting if we keep it under some CONFIG_ARM64_IPI_NMI_DEBUG ?

-Mukesh
> 
> Until then, this is a proof of concept, and not much else.
> 
> Thanks,
> 
> 	M.
> 
