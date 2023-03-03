Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC56A93CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCCJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCCJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:20:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6F580F3;
        Fri,  3 Mar 2023 01:20:09 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3238YBsI029415;
        Fri, 3 Mar 2023 09:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O5vTVTIUN0fCaG6LkdfP9jsn9Um4thhPGwXy4duo6BY=;
 b=FbeCibHiLz6qmmfey1qhAqBsQjCR9rOfdh883+F0sE4r4mwQR5CFfWVNS1/MIYsGOk15
 BjeIyuWfE5ZWyzM1knawg9RrwL5ZP4PKUjQwRiR5ypcYGyDpfxlSGG6w6JEgLoHEc8iO
 ECc+Q8PvgVZuAfon2qxih/OYLl35ytJolxRCLNa+T7x5P/ZsSXlFmHmdQJtpjVdkJSU+
 HYgwKWptAc7RWt72nRAGBVUYEwvcfRCioqV8vQaKZ5dZYUAJY3ZCq4B4jvapQ+wBy6I2
 2v926+KCWstKB7kxgIWIogZCDb6pIOH5bXQ6CO108LTmIZ0o24eNlg4AULxmXFUjHpxo Hw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3dfrg3q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:19:39 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239JcIE028302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:19:38 GMT
Received: from [10.50.35.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 01:19:35 -0800
Message-ID: <24d307a2-ea83-d9f3-95a2-42ec9ab3fc73@quicinc.com>
Date:   Fri, 3 Mar 2023 14:49:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/8] phy: qcom-qusb2: add QUSB2 support for IPQ9574
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <8f62ea9941fdb425f63f8389e10a370d2ce0d117.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJppArws0PO1XQKsYB1H9OjpsHDRPwKgHtTGUkvDe=mdq_Q@mail.gmail.com>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <CAA8EJppArws0PO1XQKsYB1H9OjpsHDRPwKgHtTGUkvDe=mdq_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aAM-DA1wRtl-snieoF1_HRLx7Dweyvv3
X-Proofpoint-ORIG-GUID: aAM-DA1wRtl-snieoF1_HRLx7Dweyvv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030082
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2023 9:47 PM, Dmitry Baryshkov wrote:
> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>> Add the phy init sequence for the Super Speed ports found
>> on IPQ9574.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> index 2ef638b..c59413b 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> @@ -915,6 +915,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
>>                  .compatible     = "qcom,msm8953-qusb2-phy",
>>                  .data           = &msm8996_phy_cfg,
>>          }, {
>> +               .compatible     = "qcom,ipq9574-qusb2-phy",
>> +               .data           = &ipq6018_phy_cfg,
>> +       }, {
> The table is sorted. Please keep it this way.

Sorry, didn't notice that. Will post a revised patch.

Thanks

Varada

>
>>                  .compatible     = "qcom,msm8996-qusb2-phy",
>>                  .data           = &msm8996_phy_cfg,
>>          }, {
>> --
>> 2.7.4
>>
>
