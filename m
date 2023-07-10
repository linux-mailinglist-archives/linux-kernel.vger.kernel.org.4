Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCB74CCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGJGOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGJGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:14:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFEA9C;
        Sun,  9 Jul 2023 23:14:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A4LYno008582;
        Mon, 10 Jul 2023 06:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FMve1eQub66kI6fvvmNFMyg8O1f/vSGfF/06s5ulACg=;
 b=cYbTl9KDBNc2M0dsP+bZ3Pt9qcmBPIc8lZ/VXzjz4nDFPrdCVPXg4MFREgoohbIp1qyA
 ePkWe/bhNT8tRn8GAkcmCdcD+zuVlK5cfoHHd5LF+lJqrE/YikW1WnkeyKaDUwMFyyZl
 WbjGL6Po4WUrJPhojoPjX0P9zdjFZLumJBmMdxUrRNptAO6xnQjPGhz9PC1+z2NaRwJj
 /JiT4bbfGGkosE/EAueoJ3VcmPofDeyS6PygYmL8o6RSeuA/vLiBUrXRRGR88fPPJyig
 PpbtIcM/rhQ2gRGKnw7H4mx9sBEO1qtRsaKpa19zz1nB//2bb9UGMsra4rf0ByrTVyjy WQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq06d2m3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:14:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A6E4PJ030970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:14:04 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 9 Jul
 2023 23:14:01 -0700
Message-ID: <4cf8a7f4-e116-be23-f279-cd418410ccee@quicinc.com>
Date:   Mon, 10 Jul 2023 14:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Randy Dunlap <rdunlap@infradead.org>, <will@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>
CC:     <maz@kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_songxue@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <e7747626-bc77-6142-4fa7-f9fc0f719432@infradead.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <e7747626-bc77-6142-4fa7-f9fc0f719432@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gZ53p9fnmwQ1orKYCZUbeJg79TtM-hsk
X-Proofpoint-GUID: gZ53p9fnmwQ1orKYCZUbeJg79TtM-hsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=927 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 2:07 PM, Randy Dunlap wrote:
> Hi--
> 
> On 7/9/23 22:59, Maria Yu wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 85fb0fa5d091..6ad754549f1d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -433,6 +433,8 @@
>>   	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
>>   			Set instructions support
>>   
>> +	arm64.nolse_atomic [ARM64] Unconditionally disable LSE Atomic support
>> +
> 
> These entries should remain in alphabetical order, so arm64.nolse_atomic
> should be just after arm64.nobti.
Thanks for the quic feedback, will fix this in next patchset.
> 
> Yes, these are not quite in the correct order. :(
> 
> Thanks.
> 
>>   	ataflop=	[HW,M68k]
>>   
>>   	atarimouse=	[HW,MOUSE] Atari Mouse
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

