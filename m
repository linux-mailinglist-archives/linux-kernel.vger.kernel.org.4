Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A6652C90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiLUFzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiLUFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:55:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764531DA6F;
        Tue, 20 Dec 2022 21:55:33 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL3u1Y0008754;
        Wed, 21 Dec 2022 05:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2+wlnUDmpXmr22tEs76QyJbJB6YDA1VcuJOtP00XjZE=;
 b=D1TZk6Wge5RaM49p2e4DXPI7rNsIArBfrSed0MNdmkDgjpqD2YVEon9GFS1BBsCjvW0M
 5iSAxGP7jN1rhPnOBQtYe7f3UFcXbDBVekQfjEM2Ft79xwPaBSstjiDmeeXZ3ArTR57y
 yf+m3p9DVU/5JcFy/ety/QBBG6WAkCIcBfSlkK80uU644a4JCxiy6onno5VwHYlPmi0G
 O5QXJwR7sqYTlx0QwP+Uyb4n3FNonHf6TkBu5rOlB72mxlakZAClMwmC7D58oMHczVED
 Jch8NqJyj606Jhx2CtZm50AhM3kDevmk6BacAQxmdDPazw97nhknNda40PL68hBgMibX HA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mkd379vbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:54:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL5soEG005960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:54:50 GMT
Received: from [10.216.2.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 21:54:43 -0800
Message-ID: <eb8818a5-1f81-561a-b3ee-2f45b3d24355@quicinc.com>
Date:   Wed, 21 Dec 2022 11:24:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
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
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HKnq-NSCI6R5HIlgieDBV5ikftIZ5vUk
X-Proofpoint-ORIG-GUID: HKnq-NSCI6R5HIlgieDBV5ikftIZ5vUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_01,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210041
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/2022 6:20 PM, Mukesh Ojha wrote:
Thanks for your time Mukesh!!!
> Hi,
>
> On 12/20/2022 1:31 PM, Srinivasa Rao Mandadapu wrote:
>> Update the way of checking resource table name with prefix
>> substring search instead of complete string search.
>> In general Qualcomm DSP binary is prepared by combining different ELFs',
>> hence section header name (e.g. .resource_table), appended with ELF name
>> to differentiate with same section(e.g. 
>> resource_table.ac_bin_process) of
>> different ELFs'.
>> Example readelf output of DSP binary:
>>      [60] .start.ac_bin_process PROGBITS
>>      [61] .resource_table.ac_bin_process PROGBITS
>>      [62] .comment.ac_bin_process PROGBITS
>>
>
> Could we rephrase above like below ? It could be also taken why 
> applying the patch.
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
>       [60] .start.ac_bin_process PROGBITS
>       [61] .resource_table.ac_bin_process PROGBITS
>       [62] .comment.ac_bin_process PROGBITS
>
Okay. will change accordingly.
>
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
>>   -        if (strcmp(name_table + name, ".resource_table"))
>> +        if (!strstarts(name_table + name, ".resource_table"))
>>               continue;
>>             table = (struct resource_table *)(elf_data + offset);
