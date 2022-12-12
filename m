Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81A64A349
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiLLO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiLLO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:29:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A312ABB;
        Mon, 12 Dec 2022 06:28:59 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCBUgBH022168;
        Mon, 12 Dec 2022 14:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X6tkhFxmvU4NUYJxmev1CkaxZ/8skwIMbfGZNf44NrU=;
 b=L4auqA4bceTr4glQ68eq8W2DwyqaItWeZD2/8C8nT1stfye7pHxCTNWmJTZI0Uwg5QBo
 P8g+Ewh+Q3DQtnsh2LTtrmEu4D2ZgCi8bgdyeg5hnF4MSR+13vHRjMASeYvFN7iM+0Ob
 xcNhPdU81Pm6H6OJF3n7wk/dgeR7Bg4eHmC9T2EaHzvK6CTiH7xWbEUec5GFXLVjVPcZ
 M6wVRPn/1wtTK+ui49jRv0YWT87Vm7/HSPfZxsDBdaDbMGEWhjqmojRC57SLGKjGyhxL
 WvnJ4OVOaMDJWeLGspCO4mjjIPHyw3vs59kPMu1CqsvyROx3xff3loeUi2iWz4XwuQta 1g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3me09g8wut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 14:28:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCESB5k002354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 14:28:12 GMT
Received: from [10.216.26.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 06:28:04 -0800
Message-ID: <bbd462ec-33ed-1302-6532-8efb1af91017@quicinc.com>
Date:   Mon, 12 Dec 2022 19:57:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] remoteproc: elf_loader: Update resource table name check
Content-Language: en-US
To:     Peng Fan <peng.fan@oss.nxp.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>
References: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
 <24361a63-ee96-4291-175e-f25c1380cd49@oss.nxp.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <24361a63-ee96-4291-175e-f25c1380cd49@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gvYhcOw7hzKeY9Q9gsNuXA8-xtSod5Ch
X-Proofpoint-GUID: gvYhcOw7hzKeY9Q9gsNuXA8-xtSod5Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2022 8:36 AM, Peng Fan wrote:
Thanks for your time and valuable suggestion Pang!!!
>
> On 12/1/2022 8:20 PM, Srinivasa Rao Mandadapu wrote:
>> Update resource table name check with sub string search instead of
>> complete string search.
>> In general Qualcomm binary contains, section header name
>> (e.g. .resource_table), amended with extra string to differentiate
>> with other sections.
>> So far Android adsp binaries are being authenticated using TZ,
>> hence this mismatch hasn't created any problem.
>> In recent developments, ADSP binary is being used in Chrome based
>> platforms, which doesn't have TZ path, hence resource table is
>> required for memory sandboxing.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c 
>> b/drivers/remoteproc/remoteproc_elf_loader.c
>> index 5a412d7..0feb120 100644
>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct 
>> firmware *fw)
>>           u64 offset = elf_shdr_get_sh_offset(class, shdr);
>>           u32 name = elf_shdr_get_sh_name(class, shdr);
>>   -        if (strcmp(name_table + name, ".resource_table"))
>> +        if (!strstr(name_table + name, ".resource_table"))
>>               continue;
>
> How about ?
>     if (strcmp(name_table + name, ".resource_table")) {
>         if (strstr(name_table + name, ".resource_table"))
>               break;
>         continue;
>     }

It looks valid approach to me. But other reviewers may object on double 
check. Let's see Stephen Boyd comments also,

and handle it accordingly.

>
> Regards,
> Peng.
>>             table = (struct resource_table *)(elf_data + offset);
