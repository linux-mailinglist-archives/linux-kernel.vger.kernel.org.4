Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFB6470FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiLHNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiLHNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:42:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C804B8B39F;
        Thu,  8 Dec 2022 05:41:53 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8CIeXh003845;
        Thu, 8 Dec 2022 13:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bGawsvtpYEDznEm4b8jKPt0VkPsUz0y02oBiQf+JrC4=;
 b=aV0uUH/VGVH8VcllqZ7OxTWHlotsxL1I/kCPZW+bAV6WLdw+kUUWj+rgt6/qLP7k6vZv
 aalN4Aq+AUuk2rHv+DiAVZSNkkTbvwz4LRZez0mLsbBSHX1RfIp+dqglFTS34nDJ+IOO
 eGDtNJ683D/NtngtsiwS544Dbk4p69N25K19oNJtNcwmJA4OaLHeWKDr5wRK4hKH+5QE
 /Z+esdcoIaDBWy3D5orFU6YrQGZz9bxxMY/BM4BBwCCnuhzF2cW0u2dz96w14bL1wWxV
 5rypCzGe5RrquLsbp3kPM2JreFYBd5LLmd4K/djXl+YeI5gYRzH0IdY3wdyCi0mFdnT3 cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mbffs880v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 13:41:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8Df3bT015445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 13:41:03 GMT
Received: from [10.216.30.208] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 05:40:57 -0800
Message-ID: <ec403926-24ef-947d-2a1c-6cbf0e31ab89@quicinc.com>
Date:   Thu, 8 Dec 2022 19:10:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] remoteproc: elf_loader: Update resource table name check
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <bgoswami@quicinc.com>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n520=mjdc4H1m8au0iBo2qEeaL8OrF1HCP0bXORe2Wa_7w@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n520=mjdc4H1m8au0iBo2qEeaL8OrF1HCP0bXORe2Wa_7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u0MLp0o3BE-g2iuoQLX6FffRLsAyL9lZ
X-Proofpoint-GUID: u0MLp0o3BE-g2iuoQLX6FffRLsAyL9lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_07,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080115
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/2022 7:25 AM, Stephen Boyd wrote:
Thanks for Your Time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-12-01 04:20:48)
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
> Does this need a Fixes tag?
I don't think so. I feel It's kind of enhancement.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
>> index 5a412d7..0feb120 100644
>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
>>                  u64 offset = elf_shdr_get_sh_offset(class, shdr);
>>                  u32 name = elf_shdr_get_sh_name(class, shdr);
>>
>> -               if (strcmp(name_table + name, ".resource_table"))
>> +               if (!strstr(name_table + name, ".resource_table"))
> Was the strcmp not working before because the 'name_table' has something
> else in it? It really looks like your elf file is malformed.

Actually, DSP binary is prepared by combining different elfs. So Section 
header names are appended with

something else to distinguish same section name of different elfs, by 
using some Qualcomm specific QURT scripts.
Hence final binary contains resource_table name appended with module 
specific name.

So this patch is required to handle such modified name.

