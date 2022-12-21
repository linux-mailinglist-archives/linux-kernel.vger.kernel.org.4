Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F4652C82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiLUFrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUFrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:47:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D85F87;
        Tue, 20 Dec 2022 21:47:00 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL1bOZR014040;
        Wed, 21 Dec 2022 05:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RA7Hd+cZC/9X/zleey9EVeBsRmig/cD6MmzKzXQ4/t4=;
 b=Nm92RqXRBm4EL3IOXCLuDzXzW1O9mfOi/xdrq3zV8cMQkyg/6qMA/Jzw16HBSXizuPbk
 8jOUXLyCTYM2oFQgRENNWic1Zg5s0yAFb40tqSxQRaBxA66XsdMkZNczNhesFdtk+0dK
 VuxiiaP2qr9JMRQ+glowsALgJhR7kZxwI3pTMjMXZtgc9gWBjO3U+em4kPqIKgD3lEka
 UBKkot+OA0oXbzLn90hq0qi4RzcWantlD2rPQVdPEgp8j5qW5vOiv8tPxNs8zKsUZcdW
 qxATCr0rt8YGdokLcXpP6gwLkn98T/Se1USFQdYFljI6m0vSHZPvu3lgD/wGBIh0JzDt bQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mkcxv9w37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:46:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL5kEdJ006256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:46:14 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 21:46:08 -0800
Message-ID: <e54d0094-5cbd-8710-4fce-5f2d8414bbb7@quicinc.com>
Date:   Wed, 21 Dec 2022 11:16:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
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
References: <1671523269-21154-1-git-send-email-quic_srivasam@quicinc.com>
 <1671523269-21154-2-git-send-email-quic_srivasam@quicinc.com>
 <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
In-Reply-To: <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9OlD3RSog9t6gYd-90mAm-eBPN7ewSbF
X-Proofpoint-ORIG-GUID: 9OlD3RSog9t6gYd-90mAm-eBPN7ewSbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_01,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210040
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/2022 6:20 PM, Mukesh Ojha wrote:
> Hi,
> 
> On 12/20/2022 1:31 PM, Srinivasa Rao Mandadapu wrote:
>> Update the way of checking resource table name with prefix
>> substring search instead of complete string search.
>> In general Qualcomm DSP binary is prepared by combining different ELFs',
>> hence section header name (e.g. .resource_table), appended with ELF name
>> to differentiate with same section(e.g. resource_table.ac_bin_process) of
>> different ELFs'.
>> Example readelf output of DSP binary:
>>      [60] .start.ac_bin_process PROGBITS
>>      [61] .resource_table.ac_bin_process PROGBITS
>>      [62] .comment.ac_bin_process PROGBITS
>>
> 
> Could we rephrase above like below ? It could be also taken why applying 
> the patch.
> 
> Update the way of checking resource table name with prefix substring 
> search instead of complete string search.
> 
> In general, Qualcomm DSP binary is prepared by combining different 
> ELF's. Hence, section header name (e.g. .resource_table), appended
> with ELF name to differentiate with same section(e.g. 
> resource_table.ac_bin_process) of different ELFs'.
> 
> Example readelf output of DSP binary:
>        [60] .start.ac_bin_process PROGBITS
>        [61] .resource_table.ac_bin_process PROGBITS
>        [62] .comment.ac_bin_process PROGBITS
> 
> 

Looks like my email client did not honour new line
put by me in rephrased text. Sorry for that.

Please run checkpatch.pl before sending the patch.

-Mukesh

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> 
> Otherwise, LGTM.
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> -Mukesh
>> ---
>>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c 
>> b/drivers/remoteproc/remoteproc_elf_loader.c
>> index 5a412d7..77330d6 100644
>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct 
>> firmware *fw)
>>           u64 offset = elf_shdr_get_sh_offset(class, shdr);
>>           u32 name = elf_shdr_get_sh_name(class, shdr);
>> -        if (strcmp(name_table + name, ".resource_table"))
>> +        if (!strstarts(name_table + name, ".resource_table"))
>>               continue;
>>           table = (struct resource_table *)(elf_data + offset);
