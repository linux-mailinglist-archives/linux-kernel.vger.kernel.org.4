Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF77697728
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjBOHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBOHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:08:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB33367D3;
        Tue, 14 Feb 2023 23:07:27 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0S267030152;
        Wed, 15 Feb 2023 07:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qXP9cB/Tot7OCsfbeCQM+UaSm9j9mh8KwilwPLACQdc=;
 b=AUrsFbz1i7kXHaAOlPTWBQzwi2z/kjV72RznELQFYpqZOra0jG8rwC1zghDXgHJ5y6z/
 dSpZps047bGq5sVgpqY/91uZeYOI87BboNpR8N6rm5t0jqhV1CehC8pet4vuPKXvhp/Y
 8LArX25Jc7d0OgWypynUFdcDKRZhZZUh4XfYDPxxsPSfw3opSzuTg27/0ZracF0unQYC
 MsTZMoHIefJpHHm1NxkFYR0zVX5MgjE8mztMYXPbToyQaYHU2A20QFFpUlAFmRdICSs0
 /qs+xgPchqn6ooXMbWVbhaLVK58skk8Lb8kLa0dp05m2sPzdT32rWo/HISeHg45UodeY 0w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7vngc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:06:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F76blc015280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:06:37 GMT
Received: from [10.216.30.120] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 23:06:33 -0800
Message-ID: <602b1c64-db73-b6e3-020c-f2b24085a986@quicinc.com>
Date:   Wed, 15 Feb 2023 12:36:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sa8775p-ride: enable relevant QUPv3
 IPs
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230214155715.451130-1-brgl@bgdev.pl>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20230214155715.451130-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bfg-7E4lFtRRccGRRsryvdxBkMwQus2z
X-Proofpoint-ORIG-GUID: Bfg-7E4lFtRRccGRRsryvdxBkMwQus2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=590 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 9:27 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This enables the QUPv3 interfaces that are exposed on the sa8775p-ride
> board: I2C, SPI and the GNSS UART.
> 
> Bartosz Golaszewski (3):
>    arm64: dts: qcom: sa8775p: add the i2c node for sa8775p-ride
>    arm64: dts: qcom: sa8775p: add the SPI node for sa8775p-ride
>    arm64: dts: qcom: sa8775p: add the GNSS high-speed UART for

Hi Bartosz,
This instance is for BT HS UART , not for GNSS.
For GNSS we have uart12 (0x00A94000).

-Shazad

>      sa8775p-ride
> 
>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 67 +++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 72 +++++++++++++++++++++++
>   2 files changed, 139 insertions(+)
> 
