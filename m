Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137B16D3D73
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjDCGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjDCGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:39:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE48CA30;
        Sun,  2 Apr 2023 23:39:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3334f8mn017249;
        Mon, 3 Apr 2023 06:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AC0DGBr1P5ZXE9dXpblLlLAEcoFh5fnTzg7ZQvDdUnE=;
 b=oyYH/b1GkMyA4RybCpPKyR6Pb3v9+mP+KH66fSOS3taZua21ODCqqtHNplhkFBfLYauf
 8ET3qwm1fBauGAm0+BDAPbJ110Lz9JIBZ2TUOqTOIZl9e+Cd6xH1s9U0CyCiTHVV83Fp
 lcYXfFn1FiTHaYZK2sf7tZrLesSh0vnHcpLPIdHUWZf2FGqb1RoPWY+k4ciNlhm+PW30
 ydw6jEmLKyVe4UZ3dboID1azEfkfeeTU06wzQpOLAmBwbvRpHcosGLcbCShSRBsD4PZW
 NNp5lu89kSYIt5ndOWfl8UwnFeGAiGKFCYlwZzXc7W1pQ0OUdG/sJ8c7iTRwKXKom40F Hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ppcq3kprf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 06:39:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3336dWn3018470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 06:39:32 GMT
Received: from [10.216.31.88] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 2 Apr 2023
 23:39:26 -0700
Message-ID: <8c18bddc-c3d5-74b4-7b85-d819df0ec3d6@quicinc.com>
Date:   Mon, 3 Apr 2023 12:09:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 2/3] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock
 registration
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <quic_visr@quicinc.com>, <robh+dt@kernel.org>,
        <swboyd@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230331152805.3199968-1-quic_mohs@quicinc.com>
 <20230331152805.3199968-3-quic_mohs@quicinc.com>
 <32e439d2fb2db190cd1486b2bd15aab3.sboyd@kernel.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <32e439d2fb2db190cd1486b2bd15aab3.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eeoQ-h7je3rZXW3YNnPm8RIXha6bhBec
X-Proofpoint-ORIG-GUID: eeoQ-h7je3rZXW3YNnPm8RIXha6bhBec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_03,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030049
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2023 12:16 AM, Stephen Boyd wrote:
> Quoting Mohammad Rafi Shaik (2023-03-31 08:28:04)
>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>> index 5c1e17bd0d76..24aeed6bcf0e 100644
>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>> @@ -17,6 +17,8 @@
>>   #include "clk-branch.h"
>>   #include "common.h"
>>   
>> +#define QDSP6SS_MAX_REGISTER           0x3f
> You can drop the define and just put the raw number in the one place
> this is used.
Thanks for comment,

okay, will drop the define.
>> +
>>   static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>>          .halt_reg = 0x0,
>>          .halt_check = BRANCH_HALT,
>> @@ -118,12 +120,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>>                  goto destroy_pm_clk;
>>          }
>>   
>> -       lpass_regmap_config.name = "qdsp6ss";
>> -       desc = &lpass_qdsp6ss_sc7280_desc;
>> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
>> +               lpass_regmap_config.name = "qdsp6ss";
>> +               lpass_regmap_config.max_register = QDSP6SS_MAX_REGISTER;
>> +               desc = &lpass_qdsp6ss_sc7280_desc;
>>
