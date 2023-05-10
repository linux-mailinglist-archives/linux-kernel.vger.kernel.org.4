Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B66FE0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjEJOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEJOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:42:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A2BC;
        Wed, 10 May 2023 07:42:22 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AD7v6R020389;
        Wed, 10 May 2023 14:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yXhxwsbwi+08VkxnQt2ohjYL4NlaY/YYuUapTdI3wxc=;
 b=pOizwmYzf1xO5LUmU3Al0wnCTSwbfrUb5CHD1ZycsEUMxw2pYfz3J5bBh3t1InNutbU1
 mN38a0+vAu2sJCorvbP1IP+6lXU7nN9rRDA1CqaxMXk0IveC0dkq4iyI0rn2IYlQQZ98
 R8dAi6Mp3l7UN4KMC7wdA8WYY+gYSY1Ld7cK8KXnSCItn6u7epFiFAnfdXkJzWhhg+TB
 ZMPTpAgoTId0vPBjeV6MxzdlCtN7HU5shcue7094vM0+hsiDK2Nnhjgo7jqlo8VLphEE
 /OiGMc62NEAV0iEn73qYQ7/1juFy1u12fyogiruWKvE6Y1bUeOR1QVp1WK6VpXgWDlFX mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79crqqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:41:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AEfpKs021064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:41:51 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 07:41:50 -0700
Message-ID: <7e28b8b7-1bc1-bd3a-a198-a0dfaf356c01@quicinc.com>
Date:   Wed, 10 May 2023 08:41:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,mmcc: define
 clocks/clock-names for MSM8226
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
 <20230509-msm8226-mmcc-parents-v1-2-83a2dfc986ab@z3ntu.xyz>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-2-83a2dfc986ab@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XbLxN-6knLr6YD1gg7LF60DfIzBiSfEr
X-Proofpoint-ORIG-GUID: XbLxN-6knLr6YD1gg7LF60DfIzBiSfEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=807 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100118
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/2023 3:16 PM, Luca Weiss wrote:
> Define clock/clock-names properties of the MMCC device node to be used
> on MSM8226 platform.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Acked-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
