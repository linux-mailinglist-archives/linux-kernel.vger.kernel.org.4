Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E873BA24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFWO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFWO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:28:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9190E2139;
        Fri, 23 Jun 2023 07:28:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEQbxr005942;
        Fri, 23 Jun 2023 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TC29x/yrqf12mrPqYDqnBOOE4V3VsGfOSofY8oLcnI4=;
 b=J20+NhySU3v0PP75WTymC2uD3Xhmh7erhLFd6uOzh5tjJ7o+kBC3MEyVL8vb8H6qw+hZ
 gQGAafhVAziG4yPe6hhwDZ+i9QUde8ixe2HGiuQ5zTqG69v6HCJUyF+QTRFF+qxMavXq
 gSXmR6Gqt+ynGav3S7bOu6q7Go50eo3YTsVfwX3bihbPnk0HNI+MfoAjoS+2F3+RFkTC
 mOLdcUhpvxDv7rYPEfAG4Qsw9dOuSf2H3wNZp3h/HmqWLWNCUcUFUHdvCkVmLOl7O7aH
 aGInlu+mduv6FX11q+kMMi+/NTuKAkfWF7sQdAgl7rIj+difD3Y0fFV3UDcVXs7VM7F6 5A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrhwqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:27:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NERRWJ024051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:27:27 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 07:27:26 -0700
Message-ID: <1645ef35-8cd6-eea5-3fd8-0625a9e21e7c@quicinc.com>
Date:   Fri, 23 Jun 2023 08:27:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 9/9] arm64: dts: qcom: msm8998: Use the correct GPLL0_DIV
 leg for MMCC
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
 <20230622-topic-8998clk-v1-9-5b7a0d6e98b1@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230622-topic-8998clk-v1-9-5b7a0d6e98b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XHxbzhequdUuYGyi4k7ct57tx2mFKloM
X-Proofpoint-ORIG-GUID: XHxbzhequdUuYGyi4k7ct57tx2mFKloM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=645 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230130
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2023 5:57 AM, Konrad Dybcio wrote:
> MMCC has its own GPLL0 legs - one for 1-1 and one for div-2 output.
> We've already been using the correct one in the non-div case, start
> doing so for the other one as well.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
