Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6023073BCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjFWQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFWQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:37:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7002957;
        Fri, 23 Jun 2023 09:37:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDxif7001099;
        Fri, 23 Jun 2023 16:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1aXic0PFqKMVm9iJhACJnGTqDrzAcHYchyHjUrBbIyg=;
 b=hRphocc1AQM7S3/M83IlcWyGF5lzMDVle+7Iai4ivYu8BnlkYoOxrDtZ1K06TiJvN6dC
 OahM3gmAokJF9V1mAkh0A3kxeUh/8pvzyZS9NWWGjgZXRvvx6sVpzpg4wSawpkU9Nbmt
 1Ok/OkhO2KBxDh/AugCdsi6gwlQw4dvPL7ljDSSzeEzI8zaP+Vi3raAGCZkg9KvETiwt
 GimH7otS/GWw4CYWnJlULg18ebd1IsvKSmp00C85YiD3pgoT1aKTqdaWWxnWjsfsjsI4
 F19HpurhFF3a7P6cV+hT3lUxOSpG8p13yrVE8oxr48liI7KlBUJ1mWcG9EPw0JIaE1Cw bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rckn2uwn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:37:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NGbQEj014950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:37:26 GMT
Received: from [10.216.8.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 09:37:21 -0700
Message-ID: <0239d17b-eb8a-8feb-d8a4-a7f82edfa612@quicinc.com>
Date:   Fri, 23 Jun 2023 22:07:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 0/4] Add camera clock controller support for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <88b41c0f-e515-ce94-e4fd-befbeef53781@linaro.org>
 <65fd51f1-56d9-7b7b-7757-229cbb65051d@quicinc.com>
 <CAA8EJpoLWm4=1J2QTfh9N55U-FjuYA7CwJeoG=Zv4mOhC1nytQ@mail.gmail.com>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpoLWm4=1J2QTfh9N55U-FjuYA7CwJeoG=Zv4mOhC1nytQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sUHdBxk3ltN7QTF5u-ZcIPP2xY5vPUyF
X-Proofpoint-ORIG-GUID: sUHdBxk3ltN7QTF5u-ZcIPP2xY5vPUyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=968
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230148
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 5:47 PM, Dmitry Baryshkov wrote:
> On Wed, 14 Jun 2023 at 14:58, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 6/9/2023 6:24 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 9.06.2023 13:50, Jagadeesh Kona wrote:
>>>> Add bindings, driver and devicetree node for camera clock controller on
>>>> SM8550.
>>>>
>>>> Jagadeesh Kona (4):
>>>>     dt-bindings: clock: qcom: Add SM8550 camera clock controller
>>>>     clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
>>>>     clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
>>>>     arm64: dts: qcom: sm8550: Add camera clock controller
>>> What's the final verdict on RINGOSC_L etc.?
>>>
>>> Konrad
>>
>> We would like to pass RINGOSC_CAL_L field directly in config->l value
>> itself and reuse existing code rather than adding a separate function
>> for lucid ole pll configure.
> 
> As I wrote in another email, it doesn't sound like a good approach.
> 

Will avoid this approach and use separate clk_lucid_ole_pll_configure() 
to configure lucid ole PLL's in next series.

Thanks,
Jagadeesh

>>
>> Thanks,
>> Jagadeesh
>>
>>>>
>>>>    .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
>>>>    arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>>>>    drivers/clk/qcom/Kconfig                      |    7 +
>>>>    drivers/clk/qcom/Makefile                     |    1 +
>>>>    drivers/clk/qcom/camcc-sm8550.c               | 3585 +++++++++++++++++
>>>>    include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>>>>    6 files changed, 3801 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>>>    create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
>>>>
> 
> 
> 
