Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719EA6BA62A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCOE0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOE0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:26:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3941B49;
        Tue, 14 Mar 2023 21:26:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F3VLBu028972;
        Wed, 15 Mar 2023 04:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Xtj7hkdeD+O9adjJ6rML0HI4ghCc+h2O00CkuoEMyeo=;
 b=SYWuS1E4IwW+OD+v/0WTw6XNaLp/WOYqRY5kgVyH+FQnh6WlZ//9+zsX4Ppa4imkoMww
 aMuTp76kJM/xnQBLpplJgHJcq2yr+xiJeOUrC+qqYTp4bszLlIKkw9ZoCR9y0vfDuYrd
 I36+nW1mZ2f/cyF/lvDFvM68e74IHphezC5FBMCLq+mt+V0wlYeUaF1P70tlxLq0NKSm
 WdZw7g4PUJTpXNVu0Vpk2pqXsElsEcnU8D0AnQrCsqJcHq6Df4MO6jhLoaUiRzEa0A1+
 uz0tYhD/y9ZbqUGLXakSLooXaM+zpZitRKDqAm4BGTvpE8XFk4/N4ViUJVfyiUnK2qgV vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cs8grm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 04:26:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F4QKgM019540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 04:26:21 GMT
Received: from [10.216.43.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 21:26:14 -0700
Message-ID: <84c3e0ac-c364-4242-b141-bf0b9e198b56@quicinc.com>
Date:   Wed, 15 Mar 2023 09:56:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/8] Add multiport support for DWC3 controllers
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <ZBDZ3q6b4+0IBi4s@fedora>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZBDZ3q6b4+0IBi4s@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ol-sN4eFnM5FQS-TM3PS30AYG_tEoRUm
X-Proofpoint-GUID: ol-sN4eFnM5FQS-TM3PS30AYG_tEoRUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_01,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=631
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 2:02 AM, Adrien Thierry wrote:
> Hi Krishna,
> 
> I'm unable to apply your patch series, it looks like patch 2 is malformed.
> 'git am' prints the following:
> 
>    Applying: dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
>    Applying: usb: dwc3: core: Access XHCI address space temporarily to read port info
>    error: corrupt patch at line 83
>    Patch failed at 0002 usb: dwc3: core: Access XHCI address space temporarily to read port info
> 
> Are you able to apply the series on your side?
> 
> Best,
> 
> Adrien
> 
Hi Adrien,

   I rebased them last week before sending them out. Probably code got 
updated causing conflicts. I will rebase them again this week and send 
v6 addressing review comments.

Regards,
Krishna,
