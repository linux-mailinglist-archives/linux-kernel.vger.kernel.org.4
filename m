Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E79700C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbjELQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbjELQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:06:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A64C12;
        Fri, 12 May 2023 09:06:26 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCmZ1l032495;
        Fri, 12 May 2023 16:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m7q8RppMGVew27onlmLTY7+KOzuH6c8ILee3vZlACKU=;
 b=RXWbD5xMarq1JaIEoZs1d71k6RPXne0ETBSlNXx3JzZphTv1CSIx6A9130reU+014E8v
 0zKroafgyFwU5vKr6GfLpZ7WuX3gVs81Yj2Qr+j6gTGTQDN/WF51CX3L1Vcaq2wCH0Qj
 FbRrynxNIEzyoz505VBBYcpxzOl4ZoLaqTuCOXb7mVorABWDkcl5xHqYWqpMKNLZ1czi
 Hf02Xkw48eNfFjrTVxYqd3MBcjWTPKB6GGNYUdn6FfMXvS0sJnxGzWpEI4LGDduheqv+
 3DKlqyP88FHJA45aD1DYjPz20Z4kDF5eFt+Cp1a2Dd/FzGEjDUYEQPrIpNVKYoyuP9yV Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhfww16r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CG6Me9016721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:22 GMT
Received: from [10.216.40.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 09:06:19 -0700
Message-ID: <3d6cc32a-d538-22c0-677a-285c00ca63d3@quicinc.com>
Date:   Fri, 12 May 2023 21:32:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/3] Minor updates in the IPQ5332 DTS files
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230412164920.21862-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230412164920.21862-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TwPISFiEyjLxxjKnyJl9X3BsFbQq79WC
X-Proofpoint-GUID: TwPISFiEyjLxxjKnyJl9X3BsFbQq79WC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=706 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120133
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2023 10:19 PM, Kathiravan T wrote:
> Rename the MI01.2 DTS after Reference Design Platform(RDP) number to align
> with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
> and SBL to avoid loosing the RAM contents which will be used in post
> morterm analysis.
>
> Bjorn, since these are minor updates, it would be great if you could
> possibly pick up this series for v6.4.
>
> Kathiravan T (3):
>    arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
>    arm64: dts: qcom: ipq5332: define UART1
>    arm64: dts: qcom: ipq5332: add few more reserved memory region


Gentle Reminder...


>
>   arch/arm64/boot/dts/qcom/Makefile             |  2 +-
>   ...{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} |  0
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 20 +++++++++++++++++++
>   3 files changed, 21 insertions(+), 1 deletion(-)
>   rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} (100%)
>
