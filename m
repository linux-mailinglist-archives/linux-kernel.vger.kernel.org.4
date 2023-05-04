Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE996F6DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEDOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEDOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:44:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC1212D;
        Thu,  4 May 2023 07:44:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3444xV5g003734;
        Thu, 4 May 2023 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o4esY378CGg1puYP89nqAn0HOXZL3EM2geQTdW+QLbo=;
 b=UPjpZb1qGSrKjQlftJhEQMMfNElvZE5HXMYbduhMmh+I8D8HTIJ4osVqWHSyJJbHPlI0
 q2fXy1DD3CjMY5psdeBH2epFAVaeMdgvWObQ0OlL8r8Hx4ms1Ij/UjZTn4Oeo7xPJNY9
 749ItGS5Y8UN9orbYR3FoF0/+/FKRmrvfOSlT6jjBl+Ju6dv3dVBuo54ODSDtuUDHGBR
 z+5d1BDldYXKOork3mbqfURg/uZIIsz5vu7iIennM3UnIIX6gXbEekL4/ANGY97TAroR
 HX9q8mOdrY318alLjohhZXF6Q24QIvo2ytNpfNnq+PXqvuba6F54QMPNLKuI/YZSVTgF Dg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc652h9yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:43:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344EhiWo016505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 14:43:44 GMT
Received: from [10.216.46.158] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 07:43:37 -0700
Message-ID: <2fb1658a-3a38-7eb4-0e6e-d8c61981bdab@quicinc.com>
Date:   Thu, 4 May 2023 20:13:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 07/18] arm64: defconfig: Enable Qualcomm minidump
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-8-git-send-email-quic_mojha@quicinc.com>
 <ad9915b2-56ff-3f95-7c92-fae597d6ed43@linaro.org>
 <4325c2e7-8ca1-7e45-db14-5ba8bc83f5d7@quicinc.com>
 <a4118697-d575-6499-ed8e-656e51ca0da3@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <a4118697-d575-6499-ed8e-656e51ca0da3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VXrFV397fZXsjxuO3pxir-3bNZM62dOx
X-Proofpoint-ORIG-GUID: VXrFV397fZXsjxuO3pxir-3bNZM62dOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=945 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040120
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 6:02 PM, Krzysztof Kozlowski wrote:
> On 04/05/2023 13:45, Mukesh Ojha wrote:
>>
>>
>> On 5/4/2023 4:53 PM, Krzysztof Kozlowski wrote:
>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>> Previous patches add the Qualcomm minidump driver support, so
>>>> lets enable minidump config so that it can be used by kernel
>>>> clients.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>
>>> This patchset is split too much. Defconfig change is one change. Not two
>>> or three.
>>>
>>>> ---
>>>>    arch/arm64/configs/defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index a24609e..831c942 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -1250,6 +1250,7 @@ CONFIG_QCOM_STATS=m
>>>>    CONFIG_QCOM_WCNSS_CTRL=m
>>>>    CONFIG_QCOM_APR=m
>>>>    CONFIG_QCOM_ICC_BWMON=m
>>>> +CONFIG_QCOM_MINIDUMP=y
>>>
>>> This must be a module.
>>
>> Why do you think this should be a module ?
>>
>> Is it because, it is lying here among others '=m' ?
> 
> Because we want and insist on everything being a module. That's the
> generic rule. There are exceptions, so if this justifies being an
> exception, please bring appropriate arguments.
> 
>>
>> Or you have some other reasoning ? like it is for qcom specific
>> soc and can not be used outside ? but that is not true for
>> all configs mentioned here.
>>
>> The reason behind making it as '=y' was, to collect information from
>> core kernel data structure as well as the information like percpu data,
>> run queue, irq stat kind of information on kernel crash on a target
>> running some perf configuration(android phone).
> 
> I don't understand why =m stops you from all that.

How do i get kernel symbol address from a modules
can we use kallsyms_lookup_name from modules ?

--Mukesh

  What's more, I don't
> understand why do you refer to the Android here. This is a development
> and debugging Linux defconfig, not Android reference config for vendors...
> 
> Best regards,
> Krzysztof
> 
