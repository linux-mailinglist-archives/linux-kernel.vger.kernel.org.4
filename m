Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5A71116C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjEYQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:54:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D7135;
        Thu, 25 May 2023 09:54:31 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFAT3o023579;
        Thu, 25 May 2023 16:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jtDv3CvUJhE8vrT6Tm8i2pdWlMfRsdbR8y2tX7keamM=;
 b=WfUJAMVbaSbLrfsSuVzocmqBBj8Af8tHP8cJPNTfXMk9nIMm0juJxIK6Zn0wut4w8OaC
 tUfPuU7jWVr9C5LP1kr+pInScmqmFZIHG/HWgWUyHI7oOYMKTMNJ4u40ebGtler5Pi7r
 054+lbL2daNCrEO5p3a1gYTJ1nFhBaGQLr24xB8Lte/p2nIzl9HKNys3NscDf4yx7Z68
 NUVgFCL3ooiDNZkVR9GKVjGI8ttLrRgpqyS9hJL/uaWYBuuwUpAPHUvVI6EJeso1K/BZ
 8+YnCsMVNrKQp5z7dhL+fH8hEO8OtwJoGbmws3WiFl/2h08a6JlFPqD95TM46FrpHLwY rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qstg3t716-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:54:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PGsQ7A021467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:54:26 GMT
Received: from [10.216.52.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:54:20 -0700
Message-ID: <1900ebf0-f4c8-b2d8-429b-b53d455b3896@quicinc.com>
Date:   Thu, 25 May 2023 22:24:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/4] Add camera clock controller support for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <79f8537b-e396-7258-1df0-9792114d544a@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <79f8537b-e396-7258-1df0-9792114d544a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _xKTcCUJoKBjyrFmWttYX1Y-tgYqAgyO
X-Proofpoint-ORIG-GUID: _xKTcCUJoKBjyrFmWttYX1Y-tgYqAgyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 5/20/2023 12:59 AM, Dmitry Baryshkov wrote:
> On 19/05/2023 18:55, Jagadeesh Kona wrote:
>> Add bindings, driver and devicetree node for camera clock controller
>> on SM8550.
>>
>> Depends on [1] for lucid ole pll ops definition
>> [1] 
>> https://patchwork.kernel.org/project/linux-clk/list/?series=746186&state=%2A&archive=both
>>
>> Jagadeesh Kona (4):
>>    clk: qcom: clk-alpha-pll: Add support for rivian ole pll ops
>>    dt-bindings: clock: qcom: Add SM8550 camera clock controller
>>    clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
> 
> This patch didn't make it to the list. Please consider splitting it 
> somehow.
> 
Yes, will split it in next series.

>>    arm64: dts: qcom: sm8550: Add camera clock controller
>>
>>   .../bindings/clock/qcom,sm8550-camcc.yaml     |   82 +
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>>   drivers/clk/qcom/Kconfig                      |    7 +
>>   drivers/clk/qcom/Makefile                     |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c               | 3572 +++++++++++++++++
>>   drivers/clk/qcom/clk-alpha-pll.h              |    4 +
>>   include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>>   7 files changed, 3868 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/clock/qcom,sm8550-camcc.yaml
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
>>
> 

Thanks & Regards,
Jagadeesh
