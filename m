Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27395BCE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiISOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiISOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:12:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC7D326C7;
        Mon, 19 Sep 2022 07:12:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JD0LIm026593;
        Mon, 19 Sep 2022 14:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kq2XjCH5pBFqKo3+tPJDUzJyaRgTqIk3/SbrE2nYFeQ=;
 b=pWqEGCYL9pNp2Wh6hAqZInGV8MV/f+4iFpTIusRqFJSjCb1Wy/XQlYBWp6Q8Xgq+0Fqa
 3ZO/rpSymdxlJqC/dgD3uhANIuFT7V76mKU72JC0ce+TB4YskjT2n8BVjW/gFKdyrSu2
 T4MUe2PdvkEQycJ393PuS0KfjqlwWo5umTYlxvU29Ak3LA99gqBnu9Ijb+rwMtDqADlT
 /1D6UCauugis7gg+6G5hQ7GtFPf1KtvZO9ZMZexptvKe2sX45Ge99v3yOqjaE5qWuFSh
 NzHgw/0UujD2L5NjVvcitoNf+uh9wWLoOoRupENVX+17hG4TNc5DgckE2e8brQrlMQle 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jprv7r6b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:11:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JEBgV2001227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:11:42 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:11:35 -0700
Message-ID: <b7260131-a4ff-4cc4-7500-188f92b811a6@quicinc.com>
Date:   Mon, 19 Sep 2022 19:41:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 3/8] remoteproc: qcom: Add compatible name for SC7280
 ADSP
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-4-git-send-email-quic_srivasam@quicinc.com>
 <cd745794-6325-e291-042d-f53f72abc5bf@quicinc.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <cd745794-6325-e291-042d-f53f72abc5bf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tQ76g2ajNsju_ZazZRzGJq6v8EVa6pdz
X-Proofpoint-ORIG-GUID: tQ76g2ajNsju_ZazZRzGJq6v8EVa6pdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190095
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 2:52 PM, Sibi Sankar wrote:
Thanks for Your time Sibi Sankar!!!
>
> On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
>> Update adsp pil data and compatible name for loading ADSP
>> binary on SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes since V5:
>>     -- Rename adsp_sandbox_needed to has_iommu.
>>     -- Change adsp binary extention name.
>> Changes since V3:
>>     -- Rename is_adsp_sb_needed to adsp_sandbox_needed.
>>     -- Update sc7280 compatible name entry in sorted order.
>> Changes since V2:
>>     -- Initialize is_adsp_sb_needed flag.
>>     -- Remove empty proxy pds array.
>>
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index fa2ccac..02d17b4 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -702,6 +702,21 @@ static const struct adsp_pil_data 
>> adsp_resource_init = {
>>       },
>>   };
>>   +static const struct adsp_pil_data adsp_sc7280_resource_init = {
>> +    .crash_reason_smem = 423,
>> +    .firmware_name = "adsp.pbn",
>> +    .load_state = "adsp",
>
> given that you mention load_state info please make sure you
> mention qcom,qmp as a required property in the bindings.
Okay. Will add it in the bindings.
>
>> +    .ssr_name = "lpass",
>> +    .sysmon_name = "adsp",
>> +    .ssctl_id = 0x14,
>> +    .has_iommu = true,
>> +    .auto_boot = true,
>> +    .clk_ids = (const char*[]) {
>> +        "gcc_cfg_noc_lpass", NULL
>> +    },
>> +    .num_clks = 1,
>
> bindings seem to mention 6 other required clocks any reason why
> they were skipped?
Actually all other clocks are being enabled locally, without using clock 
framework, as the memory space conflict with other module occurred.
>
> AFAIK you'll also need lmx so you'll have to mention proxy_pd_names
> as well.
So far we didn't see any issue without LMX PD.
>
>> +};
>> +
>>   static const struct adsp_pil_data cdsp_resource_init = {
>>       .crash_reason_smem = 601,
>>       .firmware_name = "cdsp.mdt",
>> @@ -740,6 +755,7 @@ static const struct adsp_pil_data 
>> wpss_resource_init = {
>>     static const struct of_device_id adsp_of_match[] = {
>>       { .compatible = "qcom,qcs404-cdsp-pil", .data = 
>> &cdsp_resource_init },
>> +    { .compatible = "qcom,sc7280-adsp-pil", .data = 
>> &adsp_sc7280_resource_init },
>>       { .compatible = "qcom,sc7280-wpss-pil", .data = 
>> &wpss_resource_init },
>>       { .compatible = "qcom,sdm845-adsp-pil", .data = 
>> &adsp_resource_init },
>>       { },
>>
