Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9C6CB67D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC1GDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC1GDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:03:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93821BF9;
        Mon, 27 Mar 2023 23:02:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S3kP4H027584;
        Tue, 28 Mar 2023 06:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tiXyRIJPK6Rsvlv8Hvs8pKKjdhdnF707hGQ8B7kyECA=;
 b=cv1WsJOT3+/i8V09AAyFX7cmrz/2kFmazIG3RzRWzq0tIOBWZ160hQngJS+OnY5CSFSC
 zn+TltEIB0YRZnX3b3XBlAp6lk92IM6qYeELogqYNgNp6HiCTkiSQofmbw9EX8icZWJd
 g28MIv/SSM1EkmcdWEw3/jr+JozzbJ+JPtN0qxcxfHYJKt9Nf7lrMDoRKctorKHDNiCA
 5ObG60Nv0s7ojliYvDcZ7OE976x2m4xHKmoK+CxCZTqsJAx0epZRGc6/H9VkgKU4BRcR
 lMvcRAsQRK/GBQIUM/bqW+/9WIXvSJtahZQVdurPh+57vvl0oIHX7aOporp1U2WbJI0I vA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk5773512-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:02:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S62k3e019484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:02:46 GMT
Received: from [10.216.36.96] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 23:02:41 -0700
Message-ID: <fb9712fc-d103-769c-2ed7-51a08bbe76b2@quicinc.com>
Date:   Tue, 28 Mar 2023 11:32:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 0/4] Remove the qdsp6ss register from lpasscc
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
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
 <b347395dd736194ae9392f2f6ea450b0.sboyd@kernel.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <b347395dd736194ae9392f2f6ea450b0.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fj3ZzXUIWJ0lnJLW_nJtJNSq9jfRGId5
X-Proofpoint-ORIG-GUID: fj3ZzXUIWJ0lnJLW_nJtJNSq9jfRGId5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=645 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280049
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2023 11:11 PM, Stephen Boyd wrote:
> Quoting Mohammad Rafi Shaik (2023-03-27 09:32:45)
>> This patch set is to remove the qdsp6ss register from lpasscc to
>> resolve memory conflict's between lpascc and ADSP remoteproc driver.
> Is this related to the other patch series[1] ("[PATCH v9 0/4] Add resets
> for ADSP based audio clock controller driver")? Does it supersede those?
Thanks for comment,

yes, its superseded form patch series[1] ("[PATCH v9 0/4] Add resets
for ADSP based audio clock controller driver") which is required many
changes.

As the qdsp6ss clocks are being enabled in remoteproc driver,
the qdsp6ss not required in lpasscc node.

For audioreach solution required to create the remoteproc_adsp
device tree node with base address 0x3000000 for remoteproc driver,
as already this address being used in lpasscc node it's causing memory
conflict.
>> Mohammad Rafi Shaik (4):
>>    arm64: dts: qcom: sc7280: Modify lpasscc node name
>>    dt-bindings: clock: qcom,sc7280-lpasscc: Remove qdsp6ss register
>>      region
>>    arm64: dts: qcom: sc7280: Remove qdsp6ss regmap region
>>    clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration
> [1] https://lore.kernel.org/all/20230317141622.1926573-1-quic_mohs@quicinc.com/
