Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B716D4688
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDCOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjDCOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:09:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BE11155;
        Mon,  3 Apr 2023 07:08:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333ApJiC011099;
        Mon, 3 Apr 2023 14:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LgV6ci84HwDCeMcXUGHKEVSK5rE6V5bpam5wuhCZUts=;
 b=gztSjCsJEaMSR1rdmX2C64ULt6oxVyfeZgcKS+i4yCG1DgGVLjPzaYkUmmDzTSegXDTU
 LI4YPt0yvwp52+skmsiRusYmGBnLHTOIIwg5Z9b/tVJbfItEMQkL9mFI+FOEwQRFkt7m
 DSHMRZiGObmj9sI+kJSXv6Mh0UHSQn0EUtAnrZ1CzKdTNM3iSMcn2cTSwg4LPCbx/C/G
 /Je77wJVAJppiQEGf1zN82Zg7f+cuscjg6QMDD79IM4oRaAM3y//9BnPdB+BH61aKG/6
 Y0T6LlXlitxOGO34NX8UcAivy7xsU0CCY3ioMC1Ov5dDbffqWfGv/4zp2qfuulPXnGFV ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqwdrrem7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 14:08:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333E7xhf028661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 14:07:59 GMT
Received: from [10.50.12.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 07:07:53 -0700
Message-ID: <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
Date:   Mon, 3 Apr 2023 19:37:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Content-Language: en-US
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
 <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
 <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T5Y7y9S3MGXDmzMA2iA94d1Oe3g_h7nd
X-Proofpoint-ORIG-GUID: T5Y7y9S3MGXDmzMA2iA94d1Oe3g_h7nd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_11,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030103
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2023 1:58 PM, Konrad Dybcio wrote:
> 
> 
> On 28.03.2023 08:12, Devi Priya wrote:
>>
>>
>> On 3/27/2023 2:56 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 27.03.2023 10:40, Devi Priya wrote:
>>>>
>>>>
>>>> On 3/18/2023 7:38 PM, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 14.03.2023 18:15, Devi Priya wrote:
>>>>>>
>>>>>>
>>>>>> On 3/8/2023 3:57 PM, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7.03.2023 07:55, Devi Priya wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>>>>>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Thinking about it again, this seems like something that could be
>>>>>>>>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>>>>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>>>>>>>>> boards that are already upstream.
>>>>>>>>>>>>
>>>>>>>>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>>>>>>>>
>>>>>>>>>>>> The overwhelming majority of devices that have variable voltages
>>>>>>>>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>>>>>>>>> unique in this regard.  We don't want a general property to set a
>>>>>>>>>>>> specific voltage since normally we should be using the
>>>>>>>>>>>> constraints and don't normally need to adjust things immediately
>>>>>>>>>>>> since we can tell what the current voltage is.
>>>>>>>>>>>>
>>>>>>>>>>>> This is pretty much just going to be a device specific bodge,
>>>>>>>>>>>> ideally something that does know what the voltage is would be
>>>>>>>>>>>> able to tell us at runtime but if that's not possible then
>>>>>>>>>>>> there's no good options.  If the initial voltage might vary based
>>>>>>>>>>>> on board then a device specific DT property might be less
>>>>>>>>>>>> terrible, if it's determined by the regulator the current code
>>>>>>>>>>>> seems fine.  Or just leave the current behavour, if the
>>>>>>>>>>>> constraints are accurate then hopefully a temporary dip in
>>>>>>>>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>>>>>>>>> current behaviour might well save power if you've got a voltage
>>>>>>>>>>>> range configured and nothing actually ever gets round to setting
>>>>>>>>>>>> the voltage (which is depressingly common, people seem keen on
>>>>>>>>>>>> setting voltage ranges even when the voltage is never varied in
>>>>>>>>>>>> practice).
>>>>>>>>>>>
>>>>>>>>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>>>>>>>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>>>>>>>>> set the voltage on there, it may be too high/low..
>>>>>>>> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
>>>>>>>> 875mV
>>>>>>> Okay, but what about any other design that employs or may employ
>>>>>>> MP5496 in the future?
>>>>>>>
>>>>>>>>>>
>>>>>>>>>>       Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>>>>>>>>> That's an SoC-specific thing, the same regulator can be used with
>>>>>>>>>> many different ones. We can't just assume it'll always be like this.
>>>>>>>>>> I see the problem, but I believe this is not the correct solution
>>>>>>>> Okay, As we had discussions on reading back the voltage & the generic
>>>>>>>> DT property, do you suggest any other possible solutions here?
>>>>>>> Due to the sudden influx of various IPQ SoCs on the mailing list lately
>>>>>>> I have no idea if it concerned this one too, but at least one of them
>>>>>>> was said not to use RPM for controlling the clocks. If that's the case,
>>>>>>> I see no reason at all to use it for scaling the regulators, the PMIC
>>>>>>> could be addressed directly over I2C as a normal device. You'd probably
>>>>>>> want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
>>>>>>> simply not registering the CX/MX registers as children of the I2C
>>>>>>> regulator IC.
>>>>>>
>>>>>> IPQ9574 SoC has RPM and uses it for controlling the regulators.
>>>>>> Currently, the RPM firmware does not have read support implemented
>>>>>> and so, we were not able to read the bootup voltage.
>>>>>> As we randomly saw silent reboots when the kernel boots up,
>>>>>> do you think we could proceed with this change for time being
>>>>>> and revisit the same when any SoC in the future employs MP5496?
>>>>> I'm still thinking about a cleaner fix because hardcoding voltages
>>>>> in kernel is just dangerous. Could you check whether attaching a CPU
>>>>> supply and adding an OPP table where each level has an opp-microvolt
>>>>> property would resolve your issue?
>>>>>
>>>>> Konrad
>>>> Yes, Understood! We already have the CPU supply and OPP table where
>>>> each level has an opp-microvolt property changes in place and it did
>>>> not help in our case.
>>> Ouch. That totally sounds like a bug.. Would you be willing to dig
>>> a bit further into why this happens?
>> As the regulator registration happens before the cpu freq scaling comes
>> into picture, having an OPP table did not help to set the bootup voltage
> I see, but the order should not affect it. If your regulator driver
> returns -EPROBE_DEFER, so should the cpufreq one.
> 
> Konrad
Sorry konrad, don't exactly get your point here.
The cpufreq driver depends on the regulator driver to be probed as
the regulator serves as the cpu-supply.
But, when the regulator driver comes up, it tries to bring up the
regulators to the minimum supported voltage provided with the
regulator-min-microvolt property in the DT.

The regulator being the CPU only supply, updating the
regulator-min-microvolt with SVS voltage (725000uV) would ideally help
us with the issue. That way, we could update the DT and drop this patch.

This approach seems quite ideal to us. Shall we proceed with it if we 
don't foresee any issues?

Thanks,
Devi Priya

>>>
>>> Konrad
>>>> We have now planned to update the regulator-min-microvolt property
>>>> with the SVS voltage (725000uV) in the board DT such that the regulators
>>>> are brought up with the nominal voltage which would be sufficient
>>>> for all the corner parts operating at 800MHz.
>>>>
>>>> That way, we would update the DT and drop this patch in the next spin.
>>>>
>>>> Thanks,
>>>> Devi Priya
>>>>>>>
>>>>>>> Konrad
>>>>>>>>>>
>>>>>>>>>> Konrad
>>>>>>>>>>>
>>>>>>>>>>> Best Regards,
>>>>>>>>>>> Devi Priya
