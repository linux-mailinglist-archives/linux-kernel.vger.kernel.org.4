Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF6746970
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGDGRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDGRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:17:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B33BB;
        Mon,  3 Jul 2023 23:17:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3645qiiK003534;
        Tue, 4 Jul 2023 06:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hw3fOHuf0odf9rabxQcqqiQUFcHqtCJrzJaVQs5x2fM=;
 b=Oo808jm8rlFpdfgLS57fK36qV5CLhPIaCb3oxxbKWi0h5F4k7prWQ6BksmthOjEnmnhd
 BCqb8Nm9bnuxNTkHw66WLESlMnYMmBJb8HNvkFK8nncphN3azR+eZ7aW/MOKHacwshnR
 RjvjoEbMUzS84OvvtkpO0PT9LU0awqOU8nkkPOy4ApsdZVmj91oe+ghAEqpW+KN/npaS
 P1nDRw9sEZQ5s5tHD6CEVt1GN02yw/DnyqabPz0GW1V+dLCBPi84iRoVtrDrE5BqCYVb
 u51oiUTW9exr1ImpBSQTAz2qmj4bA6qLpYS/Za2OFWBVbLo6+VlQjfxQPCcUuywbe1Ux 4g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm0he1a8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 06:17:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3646H81b012349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 06:17:08 GMT
Received: from [10.214.27.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 3 Jul 2023
 23:17:03 -0700
Message-ID: <9de424ca-271a-8ed2-5550-658a828c4ea5@quicinc.com>
Date:   Tue, 4 Jul 2023 11:46:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 00/10] Add Power Domains and Regulators in SDX75
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <3ohkrnirp4fiuru432drwgd6nowjpvf4unpstdhlz3dpcamomm@pb2uyywcaov5>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <3ohkrnirp4fiuru432drwgd6nowjpvf4unpstdhlz3dpcamomm@pb2uyywcaov5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vAtuZCtST6IVITd1p8B2JpKndm5ZoN51
X-Proofpoint-ORIG-GUID: vAtuZCtST6IVITd1p8B2JpKndm5ZoN51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_03,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=942 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040052
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/2023 8:57 PM, Bjorn Andersson wrote:
> On Mon, Jul 03, 2023 at 08:12:16PM +0530, Rohit Agarwal wrote:
>> Hello,
>>
>> This series adds driver and dt-bindings related changes
>> in SDX75 to add power domains and regulators.
>>
> Thanks for your patches, Rohit. Really nice to see the SDX75 support
> being upstreamed.
>
> This series is to be merged by five (5) different maintainers, with no
> dependencies between them, afaict. The likely outcome is confusion and
> some of the patches being left behind on the list.
>
> To reduce this risk of confusion and to get your patches looked at, and
> merged, faster, please send independent series/patches separately in the
> future.

Sure Bjorn, Thanks for the suggestion. Will surely work on this and keep 
in mind
while sending patches in future.

Thanks,
Rohit.

> Regards,
> Bjorn
>
>> Thanks,
>> Rohit.
>>
>> Rohit Agarwal (10):
>>    dt-bindings: regulator: Add PMX75 compatibles
>>    dt-bindings: power: Add rpm power domains for SDX75
>>    dt-bindings: mfd: Add compatible for pm7550ba
>>    dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
>>    dt-bindings: mfd: Add compatible for pmx75
>>    dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
>>    soc: qcom: rpmhpd: Add SDX75 power domains
>>    regulator: qcom-rpmh: Add support for SDX75
>>    pinctrl: qcom-pmic-gpio: Add support for pm7550ba
>>    pinctrl: qcom-pmic-gpio: Add support for pmx75
>>
>>   .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  2 ++
>>   .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  6 ++++
>>   .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>>   .../bindings/regulator/qcom,rpmh-regulator.yaml    |  2 ++
>>   drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  2 ++
>>   drivers/regulator/qcom-rpmh-regulator.c            | 38 ++++++++++++++++++++++
>>   drivers/soc/qcom/rpmhpd.c                          | 16 +++++++++
>>   include/dt-bindings/power/qcom-rpmpd.h             |  8 +++++
>>   8 files changed, 75 insertions(+)
>>
>> -- 
>> 2.7.4
>>
