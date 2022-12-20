Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F8651BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiLTHdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiLTHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:33:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5BCD;
        Mon, 19 Dec 2022 23:33:18 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK6UY33027388;
        Tue, 20 Dec 2022 07:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6A2qUgdtnzjOdP0NB3K4qRoy0y5kw1SQGVtydHBhUa4=;
 b=bV9e4XgUpQvG1+2Y6+P35+ZaDyGlu4WD/to3ILZumDDVAZr0/Tb2dFVApDTPA6A4r4Jq
 MQN7+OuxBHsGooX7gOhZPw6B+MWkntMrAOYKhFkxTTfTrcavoJEATpqXVbkLoVZYBfpp
 g5qVPzGXkcwirQFQ2SdlmnOxeC4NMzASaiZEKKpxHrPHCWvkkO6Z0fSAVK204ByNi1q6
 iZVBoXqI8IP8zuoc7K+QpoVjCa+goPrBMLBA4yMmZvWJMEa+x8/3QUapxZyv+PvLjgLY
 PNtfegiNcfbc34sHfjqBkVB/rn3DhMQY3GthPGjR4u4murhXBRnMFGNZBnKy8WAcWAjk Zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk39t8kw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:32:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK7WPpv024206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:32:25 GMT
Received: from [10.216.34.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 23:32:17 -0800
Message-ID: <5e0abe83-22ac-137b-d08f-6b34353c06a7@quicinc.com>
Date:   Tue, 20 Dec 2022 13:02:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <mathieu.poirier@linaro.org>, <corbet@lwn.net>,
        Stephen Boyd <swboyd@chromium.org>
References: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
 <1670924929-26507-2-git-send-email-quic_srivasam@quicinc.com>
 <fe761bbe-96f9-75ae-b4be-e94b718abac3@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <fe761bbe-96f9-75ae-b4be-e94b718abac3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gD1mn5sBzc4LKdecMyC0tUeZQkSPtZuu
X-Proofpoint-GUID: gD1mn5sBzc4LKdecMyC0tUeZQkSPtZuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200062
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/2022 12:36 PM, Philippe Mathieu-Daudé wrote:
Thanks for your time Phil!!!
> On 13/12/22 10:48, Srinivasa Rao Mandadapu wrote:
>> Update the way of checking resource table name with prefix
>> substring search instead of complete string search.
>> In general Qualcomm DSP binary is prepared by combining different elfs,
>
> Maybe 'ELFs'? (twice).
Okay. Will update accordingly.
>
>> hence section header name (e.g. .resource_table), appended with elf name
>> to differentiate with same section of different elfs.
>
> Please include here the section info parsed by readelf as an example,
> as suggested by Stephen in your v1:
> https://lore.kernel.org/linux-remoteproc/CAE-0n52cNite8-4HDoQcsZ+UvZFkJU8c5oUjxPB5ag5WP6E9=g@mail.gmail.com/ 
>
Okay. Will include example and re-spin the patch set.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes since v1:
>>      -- Update the commit message.
>>     -- Use strstarts instead of strstr.
>>
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
>>   -        if (strcmp(name_table + name, ".resource_table"))
>> +        if (!strstarts(name_table + name, ".resource_table"))
>>               continue;
>>             table = (struct resource_table *)(elf_data + offset);
>
