Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0773A384
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjFVOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjFVOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:47:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D019B7;
        Thu, 22 Jun 2023 07:47:53 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MBsGtf000857;
        Thu, 22 Jun 2023 14:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b2UBZuHskh15s+DurO9NcN4i7Jbj0PA/9fZzBou2Cu4=;
 b=KGkf/CvFf6W0EfWPmxcJPggyxu3m6KmvnUDYocqkLfGFT5Vi0CHovMjdQMgdXmXfJAOj
 KCwyEDmfKV3vyvsp4EIBunOAGF64/6J8ZINdrcKx6j87GAPQzKo08CFNmB2T1Iae2cxr
 qkFQITf6oODUPajPdk6kUIEit5CjC7THd1GTd7k+cc7bF43Pm9VEEup2bv/fb+OCjmTq
 KDvHnr1Q3XhEU567KpLWW9nuks53P/M6I92qCSgR5NRpM/vCswg3o/7mF0w2D0XRk/tO
 OeCJljKI5bJDCWAW0b8BPCsU6yR80TUioh298fhnT7miaJ4/1ueB+rx/ivtIT8OWVsKT SA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc359jt40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:47:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35MElI1G030070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:47:19 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 22 Jun
 2023 07:47:17 -0700
Message-ID: <c5be82d0-c1bb-a447-a6c9-33e4e65f7c1f@quicinc.com>
Date:   Thu, 22 Jun 2023 08:47:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/9] dt-bindings: clock: qcom,mmcc: Add GPLL0_DIV for
 MSM8998
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
 <20230622-topic-8998clk-v1-2-5b7a0d6e98b1@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230622-topic-8998clk-v1-2-5b7a0d6e98b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MVPTnqiCj0s2FOsc0Hi24gCohzADQsG7
X-Proofpoint-ORIG-GUID: MVPTnqiCj0s2FOsc0Hi24gCohzADQsG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=822
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2023 5:57 AM, Konrad Dybcio wrote:
> We've not been consuming that clock for no apparent reason. Describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Nice catch.

Acked-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
