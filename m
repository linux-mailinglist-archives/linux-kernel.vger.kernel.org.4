Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F772987E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjFILuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbjFILuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:50:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173D3590;
        Fri,  9 Jun 2023 04:50:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3599uOuo010046;
        Fri, 9 Jun 2023 11:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jga2722Mi2DM4rq7cV17hSX/VBsVj0rZDjjBtMwRB1s=;
 b=d/iK/QloF2yGnGvjNgV8rArUMXCFkUCChlFOUay0PTrXW9bKXYaW2UNIPVbK7wUu+Eup
 a+TZvCoZ/seXEanaz0ca8GVcwuvCcBXLOt1+6R9I9hdbVV1jIQa1x4vPWX3Jh9MADulf
 Rc8SBWwX0Zv4Yc3Dakk66OIezhq05eGFrP0YKSuIy/mNonnX6JSP9OIy9ZHEWfAtj/wL
 H+77sT2NiAKjRgEQ2H5+RjWNYdFsC6FxmFILS+j6Wdqrk9eYhlJYe3693oxRzDmm5yJ2
 bm265Rt4bdneHUJlgGkJ8aVWEluLxkGYhDlz10CBu90v6zK+xan0m87LR9qhfKOr9kC5 JA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3m5f1kjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:49:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359Bnwcq012734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:49:58 GMT
Received: from [10.218.22.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 04:49:52 -0700
Message-ID: <cf60ea04-057b-7856-3a30-775051cefa26@quicinc.com>
Date:   Fri, 9 Jun 2023 17:19:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V3 3/5] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-4-quic_jkona@quicinc.com>
 <95bd4c66-08c6-15f3-db6c-97f820fe5517@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <95bd4c66-08c6-15f3-db6c-97f820fe5517@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: galVBNoqHJtWC6UIJtQ0bOi3KHPmcHjI
X-Proofpoint-GUID: galVBNoqHJtWC6UIJtQ0bOi3KHPmcHjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=971
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 6/1/2023 8:21 PM, Dmitry Baryshkov wrote:
> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>> Add support for the camera clock controller for camera clients to be
>> able to request for camcc clocks on SM8550 platform.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since V2:
>>   - No changes
>> Changes since V1:
>>   - Sorted the PLL names in proper order
>>   - Updated all PLL configurations to lower case hex
>>   - Reused evo ops instead of adding new ops for ole pll
>>   - Moved few clocks to separate patch to fix patch too long error
>>
>>   drivers/clk/qcom/Kconfig        |    7 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c | 3405 +++++++++++++++++++++++++++++++
>>   3 files changed, 3413 insertions(+)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>
> 
> [skipped]
> 
>> +
>> +static struct platform_driver cam_cc_sm8550_driver = {
>> +    .probe = cam_cc_sm8550_probe,
>> +    .driver = {
>> +        .name = "cam_cc-sm8550",
>> +        .of_match_table = cam_cc_sm8550_match_table,
>> +    },
>> +};
>> +
>> +static int __init cam_cc_sm8550_init(void)
>> +{
>> +    return platform_driver_register(&cam_cc_sm8550_driver);
>> +}
>> +subsys_initcall(cam_cc_sm8550_init);
>> +
>> +static void __exit cam_cc_sm8550_exit(void)
>> +{
>> +    platform_driver_unregister(&cam_cc_sm8550_driver);
>> +}
>> +module_exit(cam_cc_sm8550_exit);
> 
> Please convert this to use module_platform_driver
> 

We still have to evaluate if module_platform_driver() works for us in 
all scenarios. We will post a cleanup patch once we conclude on 
module_platform_driver().

>> +
>> +MODULE_DESCRIPTION("QTI CAMCC SM8550 Driver");
>> +MODULE_LICENSE("GPL");
> 

Thanks & Regards,
Jagadeesh
