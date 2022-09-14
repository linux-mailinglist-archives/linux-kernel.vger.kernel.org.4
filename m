Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6885B838A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiINJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiINI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:59:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F775491;
        Wed, 14 Sep 2022 01:58:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8TuuT010039;
        Wed, 14 Sep 2022 08:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BjKmuf3eEtjwD5HDF98kgpc7eLscHdpKI6V6qzOwFWA=;
 b=ii50FY1DU0AjT3Yt7dGB0MllsHPtBbI4dAWRmjTJqxR4VKn2XvbSJudyK1yIRbIrBvjQ
 FaWYs/9dzf6rOao+tWDRkF9r37+k5SFp9x9xvFlofKgbJ6GomrOQq3Tt2rHAHr9W8ybv
 pWQq2F4NifG9nxcC2jf/xzO9EV3wVo0wZNpjvw7wO1EVAAc/W403SYfM3MB8AHb2N7t0
 wAit+0bouGxklXwrfuNQY6lESINWBxG+1NZwdhwRd26CPpIotKGV/08d3b3y5jMOw6sp
 3hMePYLzVkF7XcmtbDcec7RXJlGsCybtdoCZvOlrOWMVaZ9la0g1OSnv3OnujHj5H1+l Qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0ghpp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:58:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E8wfUg030410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:58:41 GMT
Received: from [10.216.15.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 01:58:36 -0700
Message-ID: <32211aef-6b87-ab5b-637b-7cf9610f6926@quicinc.com>
Date:   Wed, 14 Sep 2022 14:28:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>, <johan+linaro@kernel.org>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
 <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YV4t4L6HDRWDyX0vIhSj_mamppCluHH5
X-Proofpoint-GUID: YV4t4L6HDRWDyX0vIhSj_mamppCluHH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 2:07 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 9/14/2022 12:39 PM, Johan Hovold wrote:
>> On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
>>> USB on sc7280 cannot support wakeups from low power states
>>> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
>>> only transitions to RET in low power.
>>
>> It seems this isn't just needed for wakeup to work. On both sc7280 and
>> sc8280xp the controller doesn't resume properly if the domain has been
>> powered off (i.e. regardless of whether wakeup is enabled or not).
>>
> Hi Johan,
> 
>    I believe you are referring to the reinit that happens in xhci resume path after wakeup happens:
> 
> [   48.675839] xhci-hcd xhci-hcd.14.auto: xHC error in resume, USBSTS 0x411, Reinit
> 
> I see that when USB GDSC is not in retention, we don't retain controller state and go for reinit and re-enum of connected devices. We are seeing an additional delay of around ~0.7 sec (in chromebooks running on SC7280) in the wakeup path for re-enumeration of connected USB devices. To avoid this, we wanted to put GDSC in retention during PM suspend.

ok, so perhaps the commit msg should be updated to something like

'USB on sc7280 needs to prevent the GDSC from being turned OFF for a couple of reasons
1. To prevent re-init and re-enumeration of all connected devices resulting in additional delay coming out of low power states
2. To support wakeups from connected devices from low power states'

> 
>> Are you sure there's no state that needs to be retained regardless of
>> the wakeup setting?
>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/gcc-sc7280.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
>>> index 7ff64d4d5920..de29a034e725 100644
>>> --- a/drivers/clk/qcom/gcc-sc7280.c
>>> +++ b/drivers/clk/qcom/gcc-sc7280.c
>>> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>>>       .pd = {
>>>           .name = "gcc_usb30_prim_gdsc",
>>>       },
>>> -    .pwrsts = PWRSTS_OFF_ON,
>>> +    .pwrsts = PWRSTS_RET_ON,
>>>       .flags = VOTABLE,
>>>   };
>>
>> And what about gcc_usb30_sec_gdsc?
> 
> Currently wakeup is not enabled on secondary controller as its not required for end product platform (herobrine variant). So leaving the usb30_sec_gdsc as it is for now.

It perhaps makes sense to update that as well, and given this is a compute specific chipset and we dont have to worry about
USB in device mode, its safe to assume if and when that controller is used (in future designs) it would only support host mode?

