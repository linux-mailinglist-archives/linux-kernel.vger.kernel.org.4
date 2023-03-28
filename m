Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC66CB6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjC1GM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1GM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:12:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB722D76;
        Mon, 27 Mar 2023 23:12:51 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6Ar2M021018;
        Tue, 28 Mar 2023 06:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XWOlGsxME/RGTimFawcO+3onavw7u61kf0OztcJnRHM=;
 b=PiMnOPgLGZi8zOYtt+VJwlcVcf/KqslMyKBfiUUpWk9SDi/81LJDwHXq9J1TjLDC4qPJ
 nhi3+4Ffh2lj9DkI+UienYCu78yyh5VVTJTUXzEUZKAt0U1V4uNxFyGY7jHPA5q7KTi+
 maFvK/LtYyOuuaH6J3wSMkQhIOwjbuHjl0rBNEJyeewCrjY0PQbFl0udUawmceUD+1gS
 1IU3gj5c9fhAFylOmsgfAs10ddogYpzlmchTFBZKZy5DDvS7A4+y1WCbazbkxS12w8J+
 a2S2I47n8vj7VPBr36x12egS/LhEKNuUL+lx7v7gtC3KPpUwOb0yFue9j+DeQRO92Kg9 OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkjhss2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:12:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S6CdKs031235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:12:39 GMT
Received: from [10.216.32.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 23:12:34 -0700
Message-ID: <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
Date:   Tue, 28 Mar 2023 11:42:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
 <Y/aeu5ua7cY5cGON@sirena.org.uk>
 <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
 <8ce07abd-2d02-69d2-8dc6-fe11525aecda@linaro.org>
 <11b05b9f-b969-6648-2204-2da5f8465c96@quicinc.com>
 <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
 <3f434777-c4b6-272f-1971-f9adf3faefe4@linaro.org>
 <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
 <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
 <e19393e3-5898-bff2-cc00-d88c9194c7c2@quicinc.com>
 <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TG3xq4TlnTW-UlDp7ULFIZBwR6VmCXkn
X-Proofpoint-GUID: TG3xq4TlnTW-UlDp7ULFIZBwR6VmCXkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280050
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 2:56 PM, Konrad Dybcio wrote:
> 
> 
> On 27.03.2023 10:40, Devi Priya wrote:
>>
>>
>> On 3/18/2023 7:38 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 14.03.2023 18:15, Devi Priya wrote:
>>>>
>>>>
>>>> On 3/8/2023 3:57 PM, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 7.03.2023 07:55, Devi Priya wrote:
>>>>>>
>>>>>>
>>>>>> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>>>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>>>>>>
>>>>>>>>>>> Thinking about it again, this seems like something that could be
>>>>>>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>>>>>>> boards that are already upstream.
>>>>>>>>>>
>>>>>>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>>>>>>
>>>>>>>>>> The overwhelming majority of devices that have variable voltages
>>>>>>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>>>>>>> unique in this regard.  We don't want a general property to set a
>>>>>>>>>> specific voltage since normally we should be using the
>>>>>>>>>> constraints and don't normally need to adjust things immediately
>>>>>>>>>> since we can tell what the current voltage is.
>>>>>>>>>>
>>>>>>>>>> This is pretty much just going to be a device specific bodge,
>>>>>>>>>> ideally something that does know what the voltage is would be
>>>>>>>>>> able to tell us at runtime but if that's not possible then
>>>>>>>>>> there's no good options.  If the initial voltage might vary based
>>>>>>>>>> on board then a device specific DT property might be less
>>>>>>>>>> terrible, if it's determined by the regulator the current code
>>>>>>>>>> seems fine.  Or just leave the current behavour, if the
>>>>>>>>>> constraints are accurate then hopefully a temporary dip in
>>>>>>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>>>>>>> current behaviour might well save power if you've got a voltage
>>>>>>>>>> range configured and nothing actually ever gets round to setting
>>>>>>>>>> the voltage (which is depressingly common, people seem keen on
>>>>>>>>>> setting voltage ranges even when the voltage is never varied in
>>>>>>>>>> practice).
>>>>>>>>>
>>>>>>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>>>>>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>>>>>>> set the voltage on there, it may be too high/low..
>>>>>> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
>>>>>> 875mV
>>>>> Okay, but what about any other design that employs or may employ
>>>>> MP5496 in the future?
>>>>>
>>>>>>>>
>>>>>>>>      Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>>>>>>> That's an SoC-specific thing, the same regulator can be used with
>>>>>>>> many different ones. We can't just assume it'll always be like this.
>>>>>>>> I see the problem, but I believe this is not the correct solution
>>>>>> Okay, As we had discussions on reading back the voltage & the generic
>>>>>> DT property, do you suggest any other possible solutions here?
>>>>> Due to the sudden influx of various IPQ SoCs on the mailing list lately
>>>>> I have no idea if it concerned this one too, but at least one of them
>>>>> was said not to use RPM for controlling the clocks. If that's the case,
>>>>> I see no reason at all to use it for scaling the regulators, the PMIC
>>>>> could be addressed directly over I2C as a normal device. You'd probably
>>>>> want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
>>>>> simply not registering the CX/MX registers as children of the I2C
>>>>> regulator IC.
>>>>
>>>> IPQ9574 SoC has RPM and uses it for controlling the regulators.
>>>> Currently, the RPM firmware does not have read support implemented
>>>> and so, we were not able to read the bootup voltage.
>>>> As we randomly saw silent reboots when the kernel boots up,
>>>> do you think we could proceed with this change for time being
>>>> and revisit the same when any SoC in the future employs MP5496?
>>> I'm still thinking about a cleaner fix because hardcoding voltages
>>> in kernel is just dangerous. Could you check whether attaching a CPU
>>> supply and adding an OPP table where each level has an opp-microvolt
>>> property would resolve your issue?
>>>
>>> Konrad
>> Yes, Understood! We already have the CPU supply and OPP table where
>> each level has an opp-microvolt property changes in place and it did
>> not help in our case.
> Ouch. That totally sounds like a bug.. Would you be willing to dig
> a bit further into why this happens?
As the regulator registration happens before the cpu freq scaling comes
into picture, having an OPP table did not help to set the bootup voltage
> 
> Konrad
>> We have now planned to update the regulator-min-microvolt property
>> with the SVS voltage (725000uV) in the board DT such that the regulators
>> are brought up with the nominal voltage which would be sufficient
>> for all the corner parts operating at 800MHz.
>>
>> That way, we would update the DT and drop this patch in the next spin.
>>
>> Thanks,
>> Devi Priya
>>>>>
>>>>> Konrad
>>>>>>>>
>>>>>>>> Konrad
>>>>>>>>>
>>>>>>>>> Best Regards,
>>>>>>>>> Devi Priya
