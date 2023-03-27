Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C611C6C9A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjC0Dd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjC0Ddb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:33:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79DB4EEF;
        Sun, 26 Mar 2023 20:32:23 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R2l99d010139;
        Mon, 27 Mar 2023 03:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P4l4VCCofIGdqPT8rLRuo5kp2Pia678p/YPH/OflnKg=;
 b=KiKN7mC+yAmIaYPdEUlpSzx/YyXOUCZ3tHEgDH2BshldeRhhEPB2JvD8dkIiLDi2g6Z6
 wv50XL2KcvPjLfpVewPP6m8t9+kRUqEDxbhOxJ5r1ao/Fp+s9BbccnwWvGJswXrTJNWu
 D65ckhvTXYFWk0whEEUP+/toQ2IYTcqvw+HQwOu2dZiC6tMEoLZD+eiRTgpBfdNGrR7B
 mZmHg5qar0aQ+B7ljAWVSWmS6eRF/Yh8di4WYFx1iTe8CSlX4J6VEz+K34Lomj/k8sN9
 SuWN5uptWgt1nO7tZ6RQ+ax0GqF1J3lZT8zSQY7mfzkSRRoYdPs8YJ4UQa44GuWH9Ixe vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phssrb7m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 03:32:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R3W2pU004295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 03:32:02 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Mar
 2023 20:31:57 -0700
Message-ID: <595568c3-d2bc-e37e-83b3-2adfd3fa4193@quicinc.com>
Date:   Mon, 27 Mar 2023 11:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 02/11] coresight-tpda: Add DSB dataset support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark <james.clark@arm.com>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-3-git-send-email-quic_taozha@quicinc.com>
 <e578790c-4794-5609-16e8-15d63082760e@arm.com>
 <51ad3cb3-bd83-51c9-52bc-f700cd17103c@quicinc.com>
 <48f31b84-573f-fe1d-bcd7-e55ec7f47831@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <48f31b84-573f-fe1d-bcd7-e55ec7f47831@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O628Krw_oVai7_wxW0JEmBNS10jIbmK_
X-Proofpoint-GUID: O628Krw_oVai7_wxW0JEmBNS10jIbmK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270028
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2023 3:31 AM, Suzuki K Poulose wrote:
> On 24/03/2023 14:58, Tao Zhang wrote:
>> Hi Suzuki,
>>
>> 在 3/23/2023 7:51 PM, Suzuki K Poulose 写道:
>>> On 23/03/2023 06:03, Tao Zhang wrote:
>>>> Read the DSB element size from the device tree. Set the register
>>>> bit that controls the DSB element size of the corresponding port.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 58 
>>>> ++++++++++++++++++++++++++++
>>>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>>>   2 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> index f712e11..8dcfc4a 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> @@ -21,6 +21,47 @@
>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>   +/* Search and read element data size from the TPDM node in
>>>> + * the devicetree. Each input port of TPDA is connected to
>>>> + * a TPDM. Different TPDM supports different types of dataset,
>>>> + * and some may support more than one type of dataset.
>>>> + * Parameter "inport" is used to pass in the input port number
>>>> + * of TPDA, and it is set to 0 in the recursize call.
>>>> + * Parameter "parent" is used to pass in the original call.
>>>> + */
>>>
>>> I am still not clear why we need to do this recursively ?
>>
>> Some TPDMs are not directly output connected to the TPDAs. So here I
>>
>> use a recursive method to check from the TPDA input port until I find
>>
>> the connected TPDM.
>>
>> Do you have a better suggestion besides a recursive method?
>>
>>>
>>>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>>>> +               struct coresight_device *csdev, int inport, bool 
>>>> parent)
>>>
>>> Please could we renamse csdev => tpda_dev
>>
>> Since this is a recursively called function, this Coresight device is 
>> not
>>
>> necessarily TPDA, it can be other Coresight device.
>>
>>>
>>>> +{
>>>> +    static int nr_inport;
>>>> +    int i;
>>>> +    struct coresight_device *in_csdev;
>>>
>>> similarly tpdm_dev ?
>> Same as above, this variable may not necessarily be a TPDM.
>>>
>>> Could we not add a check here to see if the dsb_esize[inport] is 
>>> already
>>> set and then bail out, reading this over and over ?
>>>
>> I will update this in the next patch series.
>>>> +
>>>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (parent)
>>>> +        nr_inport = inport;
>>>> +
>>>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>>> +        in_csdev = csdev->pdata->in_conns[i].remote_dev;
>>>
>>> Please note, the names of the structure field might change in the
>>> next version of James' series
>> Got it. I will keep an eye out for the James' patch series.
>>>
>>>> +        if (!in_csdev)
>>>> +            break;
>>>> +
>>>> +        if (parent)
>>>> +            if (csdev->pdata->in_conns[i].port != inport)
>>>> +                continue;
>>>> +
>>>> +        if (in_csdev && strstr(dev_name(&in_csdev->dev), "tpdm")) {
>>>
>>> Isn't there a better way to distinguish a device to be TPDM ? May be we
>>> could even add a source_sub_type - SOURCE_TPDM instead of using
>>> SOURCE_OTHERS ? Do you expect other sources to be connected to TPDA?
>>> e.g., STMs ?
>>
>> I can add "SOURCE_TPDM" as a source_sub_type, but SOURCE_OTHERS needs
>>
>> to be kept since the other Coresight component we will upstream later 
>> may
>>
>> need it.
>>
>>>
>>>> + of_property_read_u32(in_csdev->dev.parent->of_node,
>>>> +                    "qcom,dsb-element-size", 
>>>> &drvdata->dsb_esize[nr_inport]);
>>>> +            break;
>>>> +        }
>>>> +        tpda_set_element_size(drvdata, in_csdev, 0, false);
>>>
>>> What is the point of this ? Is this for covering the a TPDA 
>>> connected to
>>> another TPDA ?
>>>
>>> e.g., { TPDM0, TPDM1 } -> TPDA0 -> TPDA1 ?
>>
>> A TPDM may not connect to the TPDA directly, for example,
>>
>> TPDM0 ->FUNNEL0->FUNNEL1->TPDA0
>>
>> And many TPDMs can connect to one TPDA, one input port on TPDA only has
>>
>> one TPDM connected. Therefore, we use a recursive method to find the 
>> TPDM
>>
>> corresponding to the input port of TPDA.
>
> How do you find out decide what to choose, if there are multiple TPDMs
> connected to FUNNEL0 or even FUNNEL1 ?
>
> e.g
>
> TPDM0->FUNNEL0->FUNNEL1->TPDA0
>                 /
>           TPDM1

We can find out the corresponding TPDM by the input port number of TPDA.

Each input port is connected to a TPDM. So we have an input port number in

the input parameter of the recursive lookup function 
"tpda_set_element_size".

> Suzuki
>
>
