Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62775682475
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAaGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:35:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E822DF1;
        Mon, 30 Jan 2023 22:35:22 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V5DkRW032745;
        Tue, 31 Jan 2023 06:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BakAXG4/dRnKq7zPddX4T/aMMMaXpMe5nvkicfBCMNw=;
 b=c96fKEsa2ont1z6fpU7X28Bx3PdGCNbF3IwfHNC4BA0sk+J8M9tz5eCjX3KYGfmWaTXK
 CoBKml0j5FwqWHhehVgsUwdPFDoIBHHXMuXDq+wNg1isI9MUdgz3Up+q7KSNUqhefENg
 zTKjz79aTIb3jFhqXjM/ZD2PRczeBUPv66pIHZANxRCQMjltsh5f3BGyu3Q50bQhXYZg
 S190VU99xXxE8yew3xls2sB9EbS0lYmR2F2hGJ+ABd1+cuvAEGyc+vs24/PshofvwwtK
 zRFKNVNfdiYkosRbxRGmWD1dQTO4EjUQeU/yptHIOA4PBjhF6w0iwdUAQav/MTDYiNKy OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnynmra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:35:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V6ZDK5006110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:35:13 GMT
Received: from [10.216.43.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 22:35:09 -0800
Message-ID: <f4cc8f19-ff32-5bcb-14aa-1ced8143c202@quicinc.com>
Date:   Tue, 31 Jan 2023 12:05:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/6] clk: qcom: lpasscorecc-sc7280: Skip lpasscorecc
 registration
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
 <1674728065-24955-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50n0JaBOukBvandsciHEyKpqSytU2y7K=fmR7gn8WPp5g@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50n0JaBOukBvandsciHEyKpqSytU2y7K=fmR7gn8WPp5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yxkRbQiyoqh2crZnVmuRsBZCMVvf4cJf
X-Proofpoint-ORIG-GUID: yxkRbQiyoqh2crZnVmuRsBZCMVvf4cJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310060
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2023 6:24 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2023-01-26 02:14:23)
>> Skip lpasscorecc clocks registration for ADSP based platforms
>> as it's causing NOC errors when ADSP based clocks are enabled.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>   drivers/clk/qcom/lpasscorecc-sc7280.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
>> index 6ad19b0..3aa16d8 100644
>> --- a/drivers/clk/qcom/lpasscorecc-sc7280.c
>> +++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
>> @@ -395,6 +395,9 @@ static int lpass_core_cc_sc7280_probe(struct platform_device *pdev)
>>          const struct qcom_cc_desc *desc;
>>          struct regmap *regmap;
>>
>> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode"))
> Why is this node enabled in DT at all if it doesn't provide any clks?

Yes. Agree that we can disable this node in board specific DTS file. As 
I thought, disabling node is not appropriate,

preferred this way.
Anyway, as suggested, will drop this patch and disable node in DT.

