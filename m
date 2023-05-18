Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106F7708162
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjERMec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjERMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:34:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC2AA;
        Thu, 18 May 2023 05:34:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9jHZ7009941;
        Thu, 18 May 2023 12:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RKqTvj5Rjz5J/uXlekULcFzx0PDAaPn0J5DcQEz+clA=;
 b=ft3f1KEC4pf042KQH2YZs9rAmILbeMvsHokCJNhc49OGruzqVgbZOdJcTcuMMkBNK63w
 D61iO0Al++3xgtpYFjAzPW/Mk+rknuxgjI89ksVKoxZNtG370XB9AqJW6kr7CMq9T7wj
 vOscId/9stzcvCvoSauvjvt6nhwK72QsAM4IMY/QVrWzEHYGmR3hdqQRhuh8TPhpGeBS
 /UL0ANTVIRnwjk3oJy+py+xE6q5JU/ri3RcgkHpM5qr3pj28QAfmVUnUpKPd08yhFDoa
 4l0mrJEVZFOQCUE0kG0AyXo5coEFtkusWUp9OaaVmY3crzNt2Ali7tB0vjT9+AmLe6kK nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned30qam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 12:34:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ICYJ8Z024801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 12:34:19 GMT
Received: from [10.216.51.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 05:34:14 -0700
Message-ID: <55586754-9de9-679c-f8cd-1d1bd0f84d77@quicinc.com>
Date:   Thu, 18 May 2023 18:04:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: ipq5332: add few more reserved
 memory region
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230518082934.24129-1-quic_kathirav@quicinc.com>
 <20230518082934.24129-4-quic_kathirav@quicinc.com>
 <CAH=2Ntz2MxM1rNeTULTWAotXWouEOj+uNHaWCjzW+ZMNZiT2hg@mail.gmail.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <CAH=2Ntz2MxM1rNeTULTWAotXWouEOj+uNHaWCjzW+ZMNZiT2hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E8WHlzviNGxCzi2w2f9sgTzyRQpvRVSW
X-Proofpoint-GUID: E8WHlzviNGxCzi2w2f9sgTzyRQpvRVSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=734 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180099
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2023 4:55 PM, Bhupesh Sharma wrote:
> Hi,
>
> On Thu, 18 May 2023 at 14:00, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>> In IPQ SoCs, U-boot will collect the system RAM contents upon crash for
>> the post morterm analysis. If we don't reserve the memory region used by
>> U-boot, obviously linux will consume it and upon next boot on crash, uboot
>> will be loaded in the same region, which will lead to loose some of the
>> data, sometimes we may miss out critical information. So lets reserve the
>> region used by the U-boot.
>>
>> Similarly SBL copies some data into the reserved region and it will be
>> used in the crash scenario. So reserve 1MB for SBL as well.
>>
>> While at it, drop the size padding in the smem memory region.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>>          - Dropped the size padding in smem memory region
>>
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 753581e60604..7e0a2a674f09 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -114,6 +114,16 @@
>>                  #size-cells = <2>;
>>                  ranges;
>>
>> +               uboot@4a100000 {
> Shouldn't this be bootloader agnostic? AFAIK any bootloader ported on
> IPQ SoCs and booting linux can access the system RAM.
>
> I mean s/uboot/bootloader here and in the commit log.


Ack.


>
> Also which entity collects the post-crash data, is it some linux driver?
> If yes, can you add more details about it in the commit log.


Bootloader is the one which collects the post-crash data. Below is the flow

System crash -> TZ -> Reset the system -> PBL -> SBL -> Bootloader,

During system boot, crashdump magic is set. Upon system reboot cases, 
these magic values will be cleared. In the system crash scenarios like 
panic,

the crashdump magic will not be cleared. Bootloader checks this value 
and collects the data and then reset the system.


Thanks,

Kathiravan T.


>
> Thanks,
> Bhupesh
>
>> +                       reg = <0x0 0x4a100000 0x0 0x400000>;
>> +                       no-map;
>> +               };
>> +
>> +               sbl@4a500000 {
>> +                       reg = <0x0 0x4a500000 0x0 0x100000>;
>> +                       no-map;
>> +               };
>> +
>>                  tz_mem: tz@4a600000 {
>>                          reg = <0x0 0x4a600000 0x0 0x200000>;
>>                          no-map;
>> @@ -121,7 +131,7 @@
>>
>>                  smem@4a800000 {
>>                          compatible = "qcom,smem";
>> -                       reg = <0x0 0x4a800000 0x0 0x00100000>;
>> +                       reg = <0x0 0x4a800000 0x0 0x100000>;
>>                          no-map;
>>
>>                          hwlocks = <&tcsr_mutex 0>;
>> --
>> 2.17.1
>>
