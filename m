Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D37715374
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjE3CIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjE3CIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:08:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A61BD;
        Mon, 29 May 2023 19:08:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U201hL022203;
        Tue, 30 May 2023 02:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BU/Zh7gAVl7zuLey3Sc2DV5MP6qQi28dn/deIGn+bE8=;
 b=nyPaH9dDAjZ4hXlFB37OJF0ifEnQqWuUGufBGyFCEnDMa0GXFJ73E/BrwSLnhz00wiwC
 S1BlkDR82DC63QDBSgrfNcel+9ZelFrlw/+atGMwsK+oAetKxFgdj5PfPgLtXqC4yThJ
 GHdSh5qRAJAOmqXnopxvcXkyjTzupIxTofI0PpjPnouZKQSb4z5KTnswD4KIohyI5Nyo
 5Uy+PgqiZru1mjIX6wXyo7Vr8nRU1XPw+WQ0mQL9WUiDu4FEdeGeO4Xl+9aTVkJf9NlX
 2k5eTXxXcHmApt1s0TlF/Fi1GnIEISspBeRSFojoboCYmxOg57zphR5Il9ivQIQHnasU +A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvws8gt58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 02:08:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34U28OM6004526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 02:08:24 GMT
Received: from [10.216.20.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 19:08:20 -0700
Message-ID: <b85216b3-8e6a-b3ea-4c01-680b1339a623@quicinc.com>
Date:   Tue, 30 May 2023 07:38:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 0/3] Minor updates in the IPQ5332 DTS files
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230519133844.23512-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230519133844.23512-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HxBdie4wuRl7l4QO8YQujraezCU8NvBb
X-Proofpoint-GUID: HxBdie4wuRl7l4QO8YQujraezCU8NvBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_14,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=589
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300015
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2023 7:08 PM, Kathiravan T wrote:
> Rename the MI01.2 DTS after Reference Design Platform(RDP) number to align
> with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
> and SBL to avoid losing the RAM contents which will be used in post
> morterm analysis.


Gentle Reminder...


>
> Kathiravan T (3):
>    arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
>    arm64: dts: qcom: ipq5332: define UART1
>    arm64: dts: qcom: ipq5332: add few more reserved memory region
>
>   arch/arm64/boot/dts/qcom/Makefile             |  2 +-
>   ...{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} |  0
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 24 ++++++++++++++++++-
>   3 files changed, 24 insertions(+), 2 deletions(-)
>   rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} (100%)
>
