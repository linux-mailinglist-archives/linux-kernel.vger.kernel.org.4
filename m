Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEE67E457
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjA0L6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjA0L5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:57:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296487DBF7;
        Fri, 27 Jan 2023 03:54:32 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RAv3M0018628;
        Fri, 27 Jan 2023 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oMyYPgxFDMQUZFnFYW/eWDIRoBAPRxwwLWMQLJhWCpA=;
 b=F3pT2k70qU4G0lANJG6Od0MbA/hZ+7pKqvG0+dQI+Fk7mNx2YPdbyP+iSU2INLPPq3st
 guSIC1eox9timKB+a83bZfOfmQCF+UH5NTHnfPkzLr3dL+Y7LUEOxDxiEPbs5E+/7cjs
 QyWKVI4gZeVmBxTv6NATriNGuYn+MnL45Mw9HG6ws/IJ4w6E5tvXA/ppYf+eqlmKskrB
 ksJq5cQnu8hLfoCsXEWd9PWwsWzrWqsQ7Xr0ogpXyVM1N4rs7dzNj9xzhgO6zU7Zbfbp
 8vxrq30Km+wfyebEByEnE+uT+nS6HLwgYDyczeabU19bQ0v2mrU4WgM/YtpBTKrw8ZDR kA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncavc08gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:37:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RBbJS6014648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:37:19 GMT
Received: from [10.216.54.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 03:37:15 -0800
Message-ID: <9155d7ce-9799-9bd7-d26b-c9997599332c@quicinc.com>
Date:   Fri, 27 Jan 2023 17:07:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        <agross@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com>
 <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
 <Y6HHCrl0q5BhrHOY@google.com>
 <e269300d-539e-9eb8-8b3c-d309f3abca1b@quicinc.com>
 <bbc3c257-0a49-4c80-4586-c179c8997b50@linaro.org>
 <CAD=FV=X3DyMrEWESV2cWvqg_TQYnj+VGFBQodAp+gfbhBz6X3Q@mail.gmail.com>
 <9f6bd192-2a42-0a23-0032-df8b01921bdc@linaro.org>
 <CAD=FV=U6KhJR+9q49=T3-aYppukRNmLrgvhaxP_ZtLP=VgSaDA@mail.gmail.com>
 <18c2bd9a-0216-c4fc-773e-601aea030b48@quicinc.com>
 <CAD=FV=WJWnGKgw74nW_VteSwaMswskT7_sQ3iz3YZvsBMfOyxA@mail.gmail.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <CAD=FV=WJWnGKgw74nW_VteSwaMswskT7_sQ3iz3YZvsBMfOyxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4DWsVbUJsyUWApEOo4Ju0SeqLshWNzry
X-Proofpoint-ORIG-GUID: 4DWsVbUJsyUWApEOo4Ju0SeqLshWNzry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270110
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2023 5:50 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jan 9, 2023 at 8:21 PM Rajendra Nayak <quic_rjendra@quicinc.com> wrote:
>>
>>
>> On 1/10/2023 3:12 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Jan 9, 2023 at 1:36 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On 09/01/2023 23:00, Doug Anderson wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Dec 20, 2022 at 9:12 AM Dmitry Baryshkov
>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>
>>>>>> On 20/12/2022 18:20, Rajendra Nayak wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 12/20/2022 8:00 PM, Matthias Kaehlcke wrote:
>>>>>>>> On Tue, Dec 20, 2022 at 10:30:32AM +0530, Rajendra Nayak wrote:
>>>>>>>>>
>>>>>>>>> On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
>>>>>>>>>> On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
>>>>>>>>>>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>>>>>>>>>>> which come with a Pro variant of the qcard.
>>>>>>>>>>> The Pro qcard variant has smps9 from pm8350c ganged up with
>>>>>>>>>>> smps7 and smps8.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>>>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>>>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>>>>>>> ---
>>>>>>>>>>> v4 changes:
>>>>>>>>>>> Added the zoglin-sku1536 compatible along with hoglin-sku1536.
>>>>>>>>>>> Zoglin is same as the Hoglin variant, with the SPI Flash reduced
>>>>>>>>>>> from 64MB to 8MB
>>>>>>>>>>>
>>>>>>>>>>>       Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>>>>>>>>>>       1 file changed, 6 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>>>>>> b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>>>>>> index 1b5ac6b02bc5..07771d4c91bd 100644
>>>>>>>>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>>>>>> @@ -558,6 +558,12 @@ properties:
>>>>>>>>>>>                 - const: google,hoglin
>>>>>>>>>>>                 - const: qcom,sc7280
>>>>>>>>>>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro
>>>>>>>>>>> platform (newest rev)
>>>>>>>>>>> +        items:
>>>>>>>>>>> +          - const: google,zoglin-sku1536
>>>>>>>>>>> +          - const: google,hoglin-sku1536
>>>>>>>>>>
>>>>>>>>>> Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro
>>>>>>>>>> qcard
>>>>>>>>>> with 64MB of SPI flash, or do they all have 8MB of flash?
>>>>>>>>>
>>>>>>>>> The SPI flash is on the CRD mother-board and not on the qcards, so if
>>>>>>>>> you replace
>>>>>>>>> the qcards on the CRDs with 64MB flash you would need the
>>>>>>>>> hoglin-sku1536 to
>>>>>>>>> boot on those.
>>>>>>>>
>>>>>>>> With such a configuration how does the bootloader know it should pass
>>>>>>>> the kernel
>>>>>>>> the device tree for 'hoglin-sku1536' (pro) and not the non-pro
>>>>>>>> variant? IIUC the
>>>>>>>> device tree is selected based on pin strappings on the mother-board,
>>>>>>>> not the
>>>>>>>> qcard.
>>>>>>>
>>>>>>> The device tree is selected based on the pin strappings _and_ additional
>>>>>>> logic
>>>>>>> to dynamically identify modem/non-modem(wifi) as well as pro/non-pro
>>>>>>> SKUs which
>>>>>>> was added in the bootloaders.
>>>>>>
>>>>>> Just to clarify things, when you mention pro SKU, is it a separate SoC
>>>>>> revision (like sc7280-pro vs bare sc7280), or is it a CRD revision (CRD
>>>>>> Pro vs bare CRD)?
>>>>>
>>>>> I guess Rajendra never responded, but since I know the answer: it's a
>>
>> Thanks Doug for the clarifications, I seem to have missed responding to this
>> once I was back from vacation,
>>
>>>>> different SoC revision. ...but the SoC in this case is on a daughter
>>>>> card, so you could remove the daughter card containing the SoC and put
>>>>> a new daughtercard on. That would have the effect of making an old CRD
>>>>> revision have the new Pro SKU SoC.
>>>>
>>>> So, this is a new SoC. Is it 100% compatible with the sc7280? In other
>>>> words: does it require any additional customizations (in OPP tables, in
>>>> frequences, speed bins, etc)?
>>
>> Yes, the OPP differences are taken care of with no changes needed in kernel.
>> We describe a superset of *all* OPPs supported by a SoC family in DT and the
>> cpufreq driver then queries the firmware for supported OPPs on a given
>> SoC variant and ends up disabling the rest.
> 
> I saw that Bjorn just send out a pull request but it didn't include
> this patch. Bjorn: are you expecting anything from Rajendra here, or
> did it just get missed? I think Rajendra responded to all of Dmitry's
> comments, but I could be mistaken.

Yes, there is nothing outstanding for these patches, they should be good
to go, Bjorn can they be pulled in?

> 
> -Doug
