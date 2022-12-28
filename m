Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED99765737B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiL1HC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL1HCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:02:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6635EE10;
        Tue, 27 Dec 2022 23:02:21 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS6KQPg018044;
        Wed, 28 Dec 2022 07:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IuLDrSDp8o65nZmLn1U/Z5goxhL8nt5SyunEDK44oyk=;
 b=XChODGUTp/w97j+FtOYKV/+y8qkrUVXzYQTa3cBAVxMKH7Jq6jREy/JhAGqhxmiLfg3K
 iSi+F4tAJLa2v2IvSNQCSEp5h+b6LpMgK2yoNc17+Kf/7JddgeORfMntDFZ7wRnUyJ/2
 VIX3273IxmCUjTHNqYwCaPAwSZxRtA0FCrifO9RoLGuC1CsGByXOECiOlPM2p+9sFN81
 wCwBqdvOcjb6eSmY/K0RRGmh9UmLMKPdI9qDyNBuWtSSf+SlP78gyZPZqtkbOGYuiMuo
 jFa4HbQgU5G+84H69TIixzlHMdik/lVGccYNhhoVTYJd2P89DRLeKrJQWAmUr9eTcb5q AQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrd1ea55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 07:02:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BS72CPg015052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 07:02:12 GMT
Received: from [10.206.64.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 23:02:09 -0800
Message-ID: <50adff46-be9e-7f4f-74dd-7e71b84bd3ac@quicinc.com>
Date:   Wed, 28 Dec 2022 12:32:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add wifi alias for
 SC7280-idp
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221223073353.20612-1-quic_youghand@quicinc.com>
 <8f9ddaeb-5481-85e2-314e-8c2a99bd48c0@linaro.org>
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <8f9ddaeb-5481-85e2-314e-8c2a99bd48c0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NCQ1rBkLwi5LYRwAa5RISFaszlFHkZXf
X-Proofpoint-GUID: NCQ1rBkLwi5LYRwAa5RISFaszlFHkZXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_04,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=726
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212280056
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/2022 1:29 PM, Krzysztof Kozlowski wrote:
> On 23/12/2022 08:33, Youghandhar Chintala wrote:
>> Currently, the boot loader code used in the SC7280 SoC accesses
>> the WiFi node using node names (wifi@<addr>). Since the bootloader
>> is a common code that is used in SoCs having different WiFi chipsets,
>> it is better if the bootloader code accesses the WiFi node using
>> a WiFi alias. The advantage of this method is that the boot loader
>> code need not be changed for every new WiFi chip.
>> Therefore, add wifi alias entry for SC7280-idp device tree
> Sounds good but which bootloader.
>
> Best regards,
> Krzysztof

Depth-charge Chrome OS bootloader.

Regards,

Youghandhar

