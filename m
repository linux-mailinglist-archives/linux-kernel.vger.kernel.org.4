Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106B570DE30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjEWNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEWNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:55:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C0E58;
        Tue, 23 May 2023 06:55:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDswRu006496;
        Tue, 23 May 2023 13:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w+f8J0edQ87CUusWo2DbekDNDc0jHAVnfM3SeXMVo20=;
 b=ixB6hKkBVImczCYDndJ6S4GbaVVh1yp0HrptATyCg9xG6+Pj1/VrCddwUSknOCAAFJHx
 XBupfH34v/FttdBi2CWHpKlPxmDJkgzEDyHNc5H0q0TgYemnxHcAl51ldOr+8T7FsJGM
 +C8UnO65FBfTxQcAoL1Ch4Wmsl/+w8QTrHctcwUD0WURYSmHfk94d9qeZwn+FTHNQdZM
 ywZHaue1tjj5USqTXcqBmGgYM6VphhWckntxBgRdYilD4aZOiS2l+cmjkWODBVMImo4h
 nYTRzc1lHPNtkJbWipDl1HvYP2adXEhRWQrd8uwxNZOd0NOia4xwNhwOLevFL0LX4Fo/ JA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrhb0hshs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 13:54:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NDsvjs003162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 13:54:57 GMT
Received: from [10.216.34.130] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 06:54:52 -0700
Message-ID: <eeeb8971-162e-6c33-83ff-d003739d5211@quicinc.com>
Date:   Tue, 23 May 2023 19:24:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
 <20230522093620.3568-5-quic_kbajaj@quicinc.com>
 <CAH=2NtxwG3YaN7F_q2PARXPA_Rit7-KhkxFKXzL0xD3J8J4SpQ@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAH=2NtxwG3YaN7F_q2PARXPA_Rit7-KhkxFKXzL0xD3J8J4SpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VqolYvS-jyAYWeLnZO_vdCTy98jvXVyJ
X-Proofpoint-GUID: VqolYvS-jyAYWeLnZO_vdCTy98jvXVyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=955 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230108
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 3:23 PM, Bhupesh Sharma wrote:
> On Mon, 22 May 2023 at 15:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>> Add sdhci node for emmc in qdu1000-idp.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 9e9fd4b8023e..61d8446a2d55 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -451,3 +451,26 @@
>>   &uart7 {
>>          status = "okay";
>>   };
>> +
>> +&sdhc_1 {
>> +       pinctrl-names = "default", "sleep";
>> +       pinctrl-0 = <&sdc1_on_state>;
>> +       pinctrl-1 = <&sdc1_off_state>;
>> +
>> +       cap-mmc-hw-reset;
>> +       mmc-ddr-1_8v;
>> +       mmc-hs200-1_8v;
>> +       mmc-hs400-1_8v;
>> +       mmc-hs400-enhanced-strobe;
>> +
>> +       non-removable;
>> +       no-sd;
>> +       no-sdio;
>> +
>> +       supports-cqe;
>> +
>> +       vmmc-supply = <&vreg_l10a_2p95>;
>> +       vqmmc-supply = <&vreg_l7a_1p8>;
>> +
>> +       status = "okay";
>> +};
> This node is out of alphabetical order again.
> &uart7 would follow &sdhc_1 and so on...
Sure will change this next version.

Thanks
Komal
>
> Thanks,
> Bhupesh

