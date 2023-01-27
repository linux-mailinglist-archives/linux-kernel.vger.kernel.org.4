Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8867EA16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjA0P5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjA0P5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:57:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD5FF31;
        Fri, 27 Jan 2023 07:57:50 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFVHkI018014;
        Fri, 27 Jan 2023 15:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yu37LESpuJzTHACVz2qu9ifN28/IfF4Kd6w+Kg375ec=;
 b=kpQkie2qInefAzJMG/T1Khbae0NotYO5QZDj5IXypGlg7xVKiu13HZ1wsmhUP4pSHYUc
 +7TJM9VVmgHcogNnMUEHwoQBldna5JUeEViveVRO49rM1r3lav2PL8MJrwtkY2sYri7a
 Fr5cjXLA7K6pTEdn9oaT4Z+Bf+HJN8c9TSBIYl8zdNiarYQCPapMgWoHx1tkl5LLZt99
 r9mObCDS2n7oD9BTELq3r/ooV8zosmPYTrFqyb4BuDL6n1O2JJ/MdZx+QyYRJnedFRDG
 YKaxINcOLPwGWJQm5ig2clgDXfj7WQcjmpDsbdBktbvh876XhZN9dkWlQBtjDgMM9djr kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc956rt24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:57:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFvj1p030736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:57:45 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 07:57:40 -0800
Message-ID: <4829f14a-5d00-3c00-f963-25f039ee74bd@quicinc.com>
Date:   Fri, 27 Jan 2023 21:27:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-2-quic_devipriy@quicinc.com>
 <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
 <Y8UxHZx6Mkt3sHXq@sirena.org.uk>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <Y8UxHZx6Mkt3sHXq@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fcOXEIAyNG8v0BpcuzC6TTUrnYjkQmu4
X-Proofpoint-ORIG-GUID: fcOXEIAyNG8v0BpcuzC6TTUrnYjkQmu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=549 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270148
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/2023 4:42 PM, Mark Brown wrote:
> On Fri, Jan 13, 2023 at 05:42:36PM +0100, Krzysztof Kozlowski wrote:
>> On 13/01/2023 16:03, devi priya wrote:
>>> Adding compatible string to support RPM communication over SMD for
>>> IPQ9574 SoC
>>>
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>
>> What exactly was developed here but the other author?
> 
> It's fairly clear looking at this in the context of the series
> that the same tags have been applied to every patch in the
> series.  Probably a patch like this was actually written by just
> one person but there's a decent chance that it's just been
> forgotten who it was and fundamentally it just doesn't matter
> that much.

Yeah!
Will drop the tag


Best Regards,
Devi Priya
