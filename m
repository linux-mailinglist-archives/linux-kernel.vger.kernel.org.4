Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0575EF28C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiI2JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiI2JpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:45:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0944DB08;
        Thu, 29 Sep 2022 02:44:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T9gK9Q005931;
        Thu, 29 Sep 2022 09:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5Hp4sD9jud9mlyXmC8TOXONcL2xXQQ9BwEsTMuFD2B8=;
 b=PN+EhcqBSFwxJm9VRRDx/T+nOA23pR/G4lIy8z3B2k5WAuQoLbjsll+eIydfZYZUCagF
 S5Srb5+N+a6vHk1oz8hNsHAzTDwgUkKJLdobgwtofqIkmSbUeWoxht8RwRuYI141mrTH
 9v92MnIMbPHzbEqvgivi12IXg2+gkzyHD+rsij3pdTKhWPJm+wGyToYz6lT7/vNN/QVS
 ePp50w/Eg4YbeP6nTP/isBSWiR53kPmBqKFraJAiwQWhTi/Y1o4446RIeyrrUoa8OVFs
 PLyhMa/+WIw0GqEeOY535W6y4bAiP/8Q2JnLMtClnLNrA9j9IN+NN4NHB/IIyJSt1uOV xQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jw4pc0v38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 09:44:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T9iWWJ028145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 09:44:32 GMT
Received: from [10.216.29.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 02:44:28 -0700
Message-ID: <270b0dfe-25fb-b5a1-e0cc-6a284367a173@quicinc.com>
Date:   Thu, 29 Sep 2022 15:14:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
 <CAA8EJpr9pcN-SG-yQNUGEoHCmv74prChprj4f42PKpSAzGzVKQ@mail.gmail.com>
 <0cc382cb-b76e-a5a5-3480-47a451bdc958@quicinc.com>
 <CAA8EJprvHSFKS2ZOLyeYgUpj4Fzec01RhQ7=nUh=qDpYBe0hrA@mail.gmail.com>
 <4d391a78-f524-5bb7-92e0-9778396ed0cb@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <4d391a78-f524-5bb7-92e0-9778396ed0cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gMy-6Q-BWkXqlv_TaoNzVGY0wN80jvQE
X-Proofpoint-GUID: gMy-6Q-BWkXqlv_TaoNzVGY0wN80jvQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_05,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=986 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290059
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2022 2:44 PM, Krzysztof Kozlowski wrote:
> On 29/09/2022 11:02, Dmitry Baryshkov wrote:
>> On Thu, 29 Sept 2022 at 11:54, Krishna Kurapati PSSNV
>> <quic_kriskura@quicinc.com> wrote:
>>>
>>>
>>> On 9/29/2022 1:29 PM, Dmitry Baryshkov wrote:
>>>> On Thu, 29 Sept 2022 at 10:14, Krishna Kurapati
>>>> <quic_kriskura@quicinc.com> wrote:
>>>>>
>>>>> Override the SNPS Phy tuning parameters for SC7280 devices. These
>>>>> values are common for both trogdor and herobrine variants.
>>>>
>>>> They are common for trogdor and herobrine, but should these parameters
>>>> be a default? In other words, a random new device based on sc7280
>>>> would more likely use these overrides or the hardware defaults?
>>>>
>>> Hi Dmitry,
>>>
>>>     Currently there are only two platforms, so I made these changes on
>>> common dtsi. If a new platform comes (mostly it won't) we can override
>>> them in platform specific file is what I thought.
>>
Hi Dmitry, Krzysztof,

>> This is not how it usually works. The 'sc7280.dtsi' is not a 'common
>> dtsi' for trogdor and herobrine. It describes the SoC.
>> Thus in my opinion if these overrides should be a default to all
>> sc7280 platforms, this patch is fine. If these overrides are
>> applicable only to the two mentioned platforms, they should go to
>> respective platform-specific DT files.
> 
> Dmitry's conclusion is correct here. The true question is whether these
> are properties of the SoC itself (so do not depend on the board or board
> layout) or these depend on design of board.
> 
> Best regards,
> Krzysztof
> 
Thanks for the info. These parameters are per-board and not common to 
SoC. I sent one patch previously for IDP platform [1]. I will let that 
get merged and I will send a v2 of this patch adding parameters only for 
herobrine platform.

[1] : 
https://patchwork.kernel.org/project/linux-usb/patch/1662480933-12326-4-git-send-email-quic_kriskura@quicinc.com/

Thanks,
Krishna,
