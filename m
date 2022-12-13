Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778464B6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiLMOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiLMOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:09:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251721256;
        Tue, 13 Dec 2022 06:09:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD9aKR8008881;
        Tue, 13 Dec 2022 14:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XxcYkkRmvYx0G719hA0aXMglQ+GrepWvJ1ImhTClbF8=;
 b=JzS54+lelyU2IT8GQ96SxMSKg9UedDqMOeJomq9dh7mPJZYE0TCnW9lfc4GRWFu5rHyo
 5srtCHN6QHAOosW4bIox34XeYV/7Y0sziYbwfz3WkfAZmKiwgZ/0QrFPKQrwlyBo7AZz
 4DPz/OgZpsJCIs4jqNq7khmGS8FY9O0UZ3+vKNafS2OV/aQyeZas0x9fjLtf4/S3LrDq
 2P73ZZF1nb7LOD+KpRDPEGcf54ANOxGTEImsKKEkBB2vgbI8CzBAm8mqGlfa4PBotO8/
 fnSqf/DjUD+vvd36ym+6dBQsYwgXS5+gB0a8z0FMEC9MAAjj/B49eGqMyRFnX/ea8jlU LA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mek41hcun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:09:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE9ItF020400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:09:18 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 06:09:13 -0800
Message-ID: <cf40279d-cb9b-d8eb-5da1-20ace8b36e6e@quicinc.com>
Date:   Tue, 13 Dec 2022 19:39:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/2] Add support for CPUCP mailbox controller
Content-Language: en-US
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>
References: <20221213140409.772-1-quic_sibis@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221213140409.772-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8xmOeLp-bEBMG2nES89R5rBChT2tzmzH
X-Proofpoint-ORIG-GUID: 8xmOeLp-bEBMG2nES89R5rBChT2tzmzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional patches got tagged along. Please ignore.

On 12/13/22 19:34, Sibi Sankar wrote:
> Add support for CPUSS Control Processor (CPUCP) mailbox controller
> which enables communication between AP and CPUCP by acting as a
> doorbell between them.
> 
> Sibi Sankar (2):
>    dt-bindings: mailbox: Add dt binding for QTI CPUCP mailbox controller
>    mailbox: Add support for QTI CPUCP mailbox controller
> 
>   .../bindings/mailbox/qcom,cpucp-mbox.yaml          |  51 ++++++
>   drivers/mailbox/Kconfig                            |   9 ++
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/qcom-cpucp-mbox.c                  | 176 +++++++++++++++++++++
>   4 files changed, 238 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>   create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c
> 
