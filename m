Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6A6A948C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCCJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCCJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:54:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411B36687;
        Fri,  3 Mar 2023 01:54:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3236QsOa009479;
        Fri, 3 Mar 2023 09:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2sCFqWkUj5tuG3vQzE8IwXlJBkVraVjQuvLOaYp90/s=;
 b=ISrfwXNDjK+jSKSHsMqvwge6sdRBVU4InmajHjX8DmsfndO8B1HfP54f5fyBk+rGxFt7
 7//xSp1+Oz4s+YrgisQYRp6sRoiBXnTvFEPwcqe62LbQyH+79A1ADxZ2CSUcNW8iKMFk
 xrGF1+nSgY6k583p9xWRm6hl5BGG5fbcj7N4D3nEFB5029sBrinS5Q7GxFVjNuoK9TQV
 ltS6R9lm2hqacazUTT5G7Ye2hx2T4/vsROkDVu6cNj/kQ/7waxKfP0MLWLkS5E3RkmJ9
 /xCDx+7I2KgonSUvzzKSQndP+j1xKRtF31yIkfmWP43qQnplklGntb1pNbD+hLTPvgdq nA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2veetv08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:54:25 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239sOSH016998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:54:24 GMT
Received: from [10.50.35.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 01:54:21 -0800
Message-ID: <2eef90b9-ff67-15bb-3fa1-e7b28a6f4244@quicinc.com>
Date:   Fri, 3 Mar 2023 15:24:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 8/8] arm64: dts: qcom: ipq9574: Enable USB
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <405a87eebf3c6a971def16122b70158dd8c7ed03.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJpqoocEYZPsaBe-pQ92ikLCAZD5hV46NZBC29pNv7U4dGg@mail.gmail.com>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <CAA8EJpqoocEYZPsaBe-pQ92ikLCAZD5hV46NZBC29pNv7U4dGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: We0TW6e1lyEO-s2k1uzbwWV_K4E1GteT
X-Proofpoint-GUID: We0TW6e1lyEO-s2k1uzbwWV_K4E1GteT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=678 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030087
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2023 9:48 PM, Dmitry Baryshkov wrote:
> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>> Turn on USB related nodes
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> index 8a6caae..6a06ca4 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -121,3 +121,7 @@
>>   &xo_board_clk {
>>          clock-frequency = <24000000>;
>>   };
>> +
>> +&usb3 { status = "ok"; };
>> +&ssphy_0 { status = "ok"; };
>> +&qusb_phy_0 { status = "ok"; };
> Please follow an example of how it is done on other platforms. DT
> nodes are sorted, newlines and empty lines are inserted in proper
> places.
>
>> --
>> 2.7.4

Will rectify and post a new version.

Thanks

Varada

>
