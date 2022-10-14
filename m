Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118AE5FF725
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJNXye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNXyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:54:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE419294;
        Fri, 14 Oct 2022 16:54:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ENepD4013246;
        Fri, 14 Oct 2022 23:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tolBBot9o8uJtCSQsq+EJBJ8Msvm37cW1KnvcEz4xEg=;
 b=EPnOJT+NmGofXcwbbIzx07u69mOJZ9WCE46lFh2hsR20+RUL5dMdQxJtwd/t7THQ+Fl5
 SBHrMKPlHD2uiXIUfHHBb7WCXK7KQBZ5S1wyS56npXegukPbfY3ehBPksvVp4xf5QuFP
 2NDx8j3QsmVDkh4jFnYw/zKIe/jiNVSw7Zh3OjPxgUngYaTkSbaTgWfXzxI4LMdM7k5o
 cvuQVO84zrN6vEfjzcvKBT2KHH3ZaZGO1yLWDa0FgCD5wQ7SoajQkJiIGjlRgKgF7NuN
 1/3Avf+L3gQL4cj9vHOF/JlmTGKy91Nq53ShANJoIG3fnecxrqcsg1P8gyS3v+m1Cnip YQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k726w3typ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:54:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ENsQik004925
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:54:26 GMT
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:54:25 -0700
Message-ID: <f02d58a1-dd0f-33bd-7f8b-632f507be4ba@quicinc.com>
Date:   Fri, 14 Oct 2022 16:54:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] Add pinctrl support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221025.7372-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pLb6Bm947nqT0s0Q75eAuxQ1yHYxOm2h
X-Proofpoint-GUID: pLb6Bm947nqT0s0Q75eAuxQ1yHYxOm2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=927 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140132
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:10 PM, Melody Olvera wrote:
> This patchset adds pinctrl support for the Qualcomm QDU1000 and QRU1000
> SoCs.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
Changes from v1:
- grouped redundant pinctrl functions
- redid bindings
>
> Melody Olvera (2):
>   dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
>   pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
>
>  .../pinctrl/qcom,qdu1000-pinctrl.yaml         |  159 ++
>  drivers/pinctrl/qcom/Kconfig                  |    9 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-qdu1000.c        | 1274 +++++++++++++++++
>  4 files changed, 1443 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d

