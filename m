Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A387651BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiLTH36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLTH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:29:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A710FE6;
        Mon, 19 Dec 2022 23:28:33 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK5RAJd001604;
        Tue, 20 Dec 2022 07:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xeKKQ88IuYossQcN2ogc+EvMSdj5DUJ0cd+4pncWdSY=;
 b=T2FVEHl9YyMFJfvZ6/+WCN261qjlWXc5XseXS+7ibAWRNeNzWxfilo1w6obtWoVRgOlB
 BVFHxB3p6mhtWpoQKJYTV5PwyKWJmshT4/6S5V7nyZSbFpCAsGdH8VIfKJ9Qb2rHSUsB
 199C3T95R9XgP6NKIBFi20vwaFx7eSWFBtt3PfqWiWosJ8UH+m2+kbmO1U0s6KmibH0n
 VM3S90zRiQbU92kzL/gajQKFVKhDaTnUeF10WjYGzXoLvU6IkWjVDUXi+Gr/aJPEOHO5
 VUBKLgQeTtXF0EDqoLP/rpov3KE2Sf5jeuI7PZfzgrOiYAt+gMyaKf9f+w2txlG57IAf 2g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjw8th946-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:27:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK7Rmws012280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:27:48 GMT
Received: from [10.216.34.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 23:27:40 -0800
Message-ID: <b4150898-d5f0-894d-2c69-b98e56142481@quicinc.com>
Date:   Tue, 20 Dec 2022 12:57:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] docs: remoteproc: Update section header name
 requirement
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
References: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
 <1670924929-26507-3-git-send-email-quic_srivasam@quicinc.com>
 <ac2d90e2-6fc3-98dc-8c73-936132b6c8d5@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <ac2d90e2-6fc3-98dc-8c73-936132b6c8d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VYv8MAuX0_dTRBmZNAywc-Z18L7enu3L
X-Proofpoint-GUID: VYv8MAuX0_dTRBmZNAywc-Z18L7enu3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212200061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/2022 12:55 PM, Philippe Mathieu-Daudé wrote:
Thanks for your time Phil!!!
> On 13/12/22 10:48, Srinivasa Rao Mandadapu wrote:
>> Add section header name requirement specification in elf segments.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   Documentation/staging/remoteproc.rst | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/staging/remoteproc.rst 
>> b/Documentation/staging/remoteproc.rst
>> index 348ee7e..3125030 100644
>> --- a/Documentation/staging/remoteproc.rst
>> +++ b/Documentation/staging/remoteproc.rst
>> @@ -245,6 +245,8 @@ if the remote processor is accessing memory 
>> directly).
>>     In addition to the standard ELF segments, most remote processors 
>> would
>>   also include a special section which we call "the resource table".
>> +This resource table section name may have anything appended after it,
>> +but it must start with ".resource_table"
>
> What do you think of:
>
>    In addition to the standard ELF segments, most remote processors would
>    also include a special section which we call the "resource table".
>    A "resource table" section name must start with the ".resource_table"
>    prefix, optionally having a more descriptive string appended. For
>    example, ".resource_table.my_rproc" is a valid section name.
Okay. Will change accordingly and re-spin the patch set.
>
> Regards,
>
> Phil.
