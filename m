Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A674EA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGKJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGKJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:25:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79F1713;
        Tue, 11 Jul 2023 02:21:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8rCqN012303;
        Tue, 11 Jul 2023 09:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EOvr3X7Tg5Zj9PHDz3vITWr2SqX4F6MjeLuvg3QK5Bo=;
 b=daWVU4If8VuUZL1PTeRxo2craFT/texQBuuilgRcQOlEwBI0ExwBJR6dCPgvnKL+eoKU
 jpKbgP9W+aXwzkfvwc/zrDTbbKap06rHyQCEfWu6jYA5QTXpaTu9XoATNAS0c+6Glikr
 9Qpl5++iiEfhlOZkct0PEC4w64Wl0eRooq8+ZxCv7SDqLSRDfprk5R/NlOOvl4bbEcHK
 x1wHmevDjk/gifR7+FmvjA0c74X20UrJO5tUPbaMe2MIHDQFhctgKUBFttX+QRuP55Vs
 jmMtnTLb/nyxX2SUT5xloiik6CAQz/f3RevOVd80r/e48yxSvMyC0huf5r+DJgqdmH2S 4g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs3y20215-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:20:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9KZn9018440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:20:35 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 02:20:29 -0700
Message-ID: <216ced8f-66eb-3953-3011-a86deffd6255@quicinc.com>
Date:   Tue, 11 Jul 2023 14:50:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] thermal/drivers/tsens: Add IPQ5332 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-7-quic_ipkumar@quicinc.com>
 <96e52c65-6216-91ba-8d2b-197f86433d98@linaro.org>
 <8661411f-ea47-2a7a-ceb4-6c37978c3a75@quicinc.com>
 <CAA8EJpoTy5sxFpK8=KqmR5zjj_Kt18hX_CJqvQbxHDmBqmduGw@mail.gmail.com>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJpoTy5sxFpK8=KqmR5zjj_Kt18hX_CJqvQbxHDmBqmduGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JUEA8-JYAFMlHNgMInHHc2qBOELtkIQA
X-Proofpoint-GUID: JUEA8-JYAFMlHNgMInHHc2qBOELtkIQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 8:33 PM, Dmitry Baryshkov wrote:
> On Mon, 10 Jul 2023 at 16:47, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>
>> On 7/10/2023 4:54 PM, Dmitry Baryshkov wrote:
>>> On 10/07/2023 13:37, Praveenkumar I wrote:
>>>> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt as
>>>> like IPQ8074. But as the SoCs does not have RPM, kernel needs to
>>>> take care of sensor enablement and calibration. Hence introduced
>>>> new ops and data for IPQ5332 and reused the feature_config from
>>>> IPQ8074.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>>    drivers/thermal/qcom/tsens-v2.c | 13 +++++++++++++
>>>>    drivers/thermal/qcom/tsens.c    |  3 +++
>>>>    drivers/thermal/qcom/tsens.h    |  2 +-
>>>>    3 files changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/thermal/qcom/tsens-v2.c
>>>> b/drivers/thermal/qcom/tsens-v2.c
>>>> index db48b1d95348..8b6e3876fd2c 100644
>>>> --- a/drivers/thermal/qcom/tsens-v2.c
>>>> +++ b/drivers/thermal/qcom/tsens-v2.c
>>>> @@ -237,6 +237,19 @@ struct tsens_plat_data data_ipq8074 = {
>>>>        .fields    = tsens_v2_regfields,
>>>>    };
>>>>    +static const struct tsens_ops ops_ipq5332_v2 = {
>>> Please drop v2. It is unclear if it refers to tsens being v2 or being
>>> specific to ipq5332 v2.
>> Sure, will drop v2.
>>>> +    .init        = init_common,
>>>> +    .get_temp    = get_temp_tsens_valid,
>>>> +    .calibrate    = tsens_v2_calibration,
>>>> +};
>>>> +
>>>> +struct tsens_plat_data data_ipq5332 = {
>>>> +    .sensors_to_en    = 0xF800,
>>> This doesn't seem to match the offsets that you have enabled in the DTSI.
>> In order to overcome the DT binding check failure, added all the
>> available QFPROM offsets in the DTSI. Else DT binding check failing on
>> "nvmem-cell-names".
> This is not a way to overcome issues in DT bindings. Please fix DT
> bindings instead by using alternatives, enums, etc.
Sure, will fix the DT bindings.
>
>>>> +    .ops        = &ops_ipq5332_v2,
>>>> +    .feat        = &ipq8074_feat,
>>>> +    .fields        = tsens_v2_regfields,
>>>> +};
>>>> +
>>>>    /* Kept around for backward compatibility with old msm8996.dtsi */
>>>>    struct tsens_plat_data data_8996 = {
>>>>        .num_sensors    = 13,
>>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>>> index 169690355dad..e8ba2901cda8 100644
>>>> --- a/drivers/thermal/qcom/tsens.c
>>>> +++ b/drivers/thermal/qcom/tsens.c
>>>> @@ -1140,6 +1140,9 @@ static const struct of_device_id tsens_table[] = {
>>>>        }, {
>>>>            .compatible = "qcom,ipq8074-tsens",
>>>>            .data = &data_ipq8074,
>>>> +    }, {
>>>> +        .compatible = "qcom,ipq5332-tsens",
>>>> +        .data = &data_ipq5332,
>>>>        }, {
>>>>            .compatible = "qcom,mdm9607-tsens",
>>>>            .data = &data_9607,
>>>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>>>> index f8897bc8944e..36040f9beebc 100644
>>>> --- a/drivers/thermal/qcom/tsens.h
>>>> +++ b/drivers/thermal/qcom/tsens.h
>>>> @@ -701,6 +701,6 @@ extern struct tsens_plat_data data_8226,
>>>> data_8909, data_8916, data_8939, data_8
>>>>    extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>>>>      /* TSENS v2 targets */
>>>> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
>>>> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332,
>>>> data_tsens_v2;
>>>>      #endif /* __QCOM_TSENS_H__ */
>> --
>> Thanks,
>> Praveenkumar
>
>
