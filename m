Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2DD682A74
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAaKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:25:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC121C5A3;
        Tue, 31 Jan 2023 02:25:48 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V6BAen009974;
        Tue, 31 Jan 2023 09:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=61YJvs37rVND9bnQtqkwhkRu7Ta9WxqCU5NShGp5dGg=;
 b=Lh2ts7GMEkGjaqqfoeKaiRryi0W6zZJOHQDZgupTJpcAkNjnegMSxIZTCCT/kYpEvXby
 dw95dTtiuvxEr8BJWFe981tZ4kY2eT5oSVbN9oUJUDONa0gp91Ld2SwW2eCG8HAgGPf/
 f6Q1oA+aP3GW5Ru/Cbm8qj6SLmBUJpn04xSggTlhJqZQYt6ThM39Ictc9Udj6tPCgpQ2
 K7qyl+tsQ+woqcalxc3fDenEbF4ZhPupo6xY5Y6ozvlbIzDi1IN2kzgEoekmdYa548xW
 RHoDxBQYoQUjTFsEG8V+vnUguiXMkbzoOYhBp411yBpSRA7p+VuC6jproq6yC1rLKZwP wg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neua98u0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:29:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V9TObw002725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:29:24 GMT
Received: from [10.216.43.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 01:29:20 -0800
Message-ID: <c8d779fe-2508-4aa1-8de9-26d858bc068b@quicinc.com>
Date:   Tue, 31 Jan 2023 14:59:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into
 lpass_aon
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>
References: <1674728065-24955-1-git-send-email-quic_srivasam@quicinc.com>
 <1674728065-24955-6-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50y4JEQqW2wgS_qoDkdrqP=bzpC6b_LpA6Q9P+jDc00ZQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50y4JEQqW2wgS_qoDkdrqP=bzpC6b_LpA6Q9P+jDc00ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nI_bk7k3IjfC3b6TsEh--h2AaG1ywLfq
X-Proofpoint-ORIG-GUID: nI_bk7k3IjfC3b6TsEh--h2AaG1ywLfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2023 6:34 AM, Stephen Boyd wrote:
Thanks for your Time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2023-01-26 02:14:24)
>> Merge lpasscc clocks into lpass_aon clk_regmap structure as they
>> are using same register space.
>> Add conditional check for doing lpasscc clock registration only
>> if regname specified in device tree node.
>> In existing implementation, lpasscc clocks and lpass_aon clocks are
>> being registered exclusively and overlapping if both of them are
>> to be used.
>> This is required to avoid such overlapping and to register
>> lpasscc clocks and lpass_aon clocks simultaneously.
> Can you describe the register ranges that are overlapping?
Okay. Will add register ranges in description.
>
> Here's what I see in DT right now:
>
>                  lpasscc: lpasscc@3000000 {
>                          compatible = "qcom,sc7280-lpasscc";
>                          reg = <0 0x03000000 0 0x40>,
>                                <0 0x03c04000 0 0x4>;
>                          ...
>                  };
>
>                  lpass_audiocc: clock-controller@3300000 {
>                          compatible = "qcom,sc7280-lpassaudiocc";
>                          reg = <0 0x03300000 0 0x30000>,
>                                <0 0x032a9000 0 0x1000>;
>                          ...
>                  };
>
>                  lpass_aon: clock-controller@3380000 {
>                          compatible = "qcom,sc7280-lpassaoncc";
>                          reg = <0 0x03380000 0 0x30000>;
>                          ...
>                  };
>
>                  lpass_core: clock-controller@3900000 {
>                          compatible = "qcom,sc7280-lpasscorecc";
>                          reg = <0 0x03900000 0 0x50000>;
>                          ...
>                  };
>
> Presumably lpascc is really supposed to be a node named
> 'clock-controller' and is the node that is overlapping with lpass_aon?

Okay. As it's been coming previous patches, didn't change the name.

May be we need to do it as separate patch.

Yes. It's overlapping with lpass_aon ( <0 0x03380000 0 0x30000>).

CC clocks range is <0 0x03389000 0 0x24>;

>
>> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>   drivers/clk/qcom/lpassaudiocc-sc7280.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> index 1339f92..8e2f433 100644
>> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> @@ -826,10 +829,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
>>                  return ret;
>>
>>          if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
>> -               lpass_audio_cc_sc7280_regmap_config.name = "cc";
>> -               desc = &lpass_cc_sc7280_desc;
>> -               ret = qcom_cc_probe(pdev, desc);
>> -               goto exit;
>> +               res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
> We shouldn't need to check for reg-name property. Instead, the index
> should be the only thing that matters.

As qcom_cc_probe() function is mapping the zero index reg property, and

in next implementation qcom_cc_really_probe() is also probing zero index 
reg property,

unable to map the same region twice.

Hence all I want here is to skip this cc clock probing by keeping some 
check.

If we remove, it may cause ABI break.


>
>> +               if (res) {
>> +                       lpass_audio_cc_sc7280_regmap_config.name = "cc";
>> +                       desc = &lpass_cc_sc7280_desc;
