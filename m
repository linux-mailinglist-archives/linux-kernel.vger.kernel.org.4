Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF55B8334
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiINIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiINImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:42:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA84AD76;
        Wed, 14 Sep 2022 01:42:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8U8I4006290;
        Wed, 14 Sep 2022 08:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=REZpNGzuQdzWXIG2UKDdc3xzOJmMPnuNTNyyMLxTV9w=;
 b=dzaS8NWEEFDaNYNFa7HmTW5CcVEz6i5eowugMeDT7JdGI9Ds/4+FaVM9fXqFAGJ7PADH
 fR2k5mA2qWfVYVBRIEQzDkk/CTtY3hsR4hNHZH3SwqIUkblfKUdkLrzqjDLOrSFR6tW5
 HzyfLuTwSEa5GcxzThHjrYOVLjiUvpjytPB2UwOPakIhphtsX1VqCjhmqwmV9brHUZ4V
 qZ6b1lE5PH6141bI39icGqhJp2+Qjz8MuK6IjcPRp4PGhC/8Q8dTrDNI16l02/nw2p/n
 rcR0ceQ5z+dQaiiQnsBlCDuYIDot8Cb7EvPeWfYASOLWSeN38ZifspyitBbpibI+4UVv kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy06hkww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:42:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E8bEUH003099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:37:15 GMT
Received: from [10.216.31.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 01:37:10 -0700
Message-ID: <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
Date:   Wed, 14 Sep 2022 14:07:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>, <johan+linaro@kernel.org>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6oo2OAQCEJJJv67U_I9FcvTXMOz7372o
X-Proofpoint-ORIG-GUID: 6oo2OAQCEJJJv67U_I9FcvTXMOz7372o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140042
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2022 12:39 PM, Johan Hovold wrote:
> On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
>> USB on sc7280 cannot support wakeups from low power states
>> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
>> only transitions to RET in low power.
> 
> It seems this isn't just needed for wakeup to work. On both sc7280 and
> sc8280xp the controller doesn't resume properly if the domain has been
> powered off (i.e. regardless of whether wakeup is enabled or not).
> 
Hi Johan,

   I believe you are referring to the reinit that happens in xhci resume 
path after wakeup happens:

[   48.675839] xhci-hcd xhci-hcd.14.auto: xHC error in resume, USBSTS 
0x411, Reinit

I see that when USB GDSC is not in retention, we don't retain controller 
state and go for reinit and re-enum of connected devices. We are seeing 
an additional delay of around ~0.7 sec (in chromebooks running on 
SC7280) in the wakeup path for re-enumeration of connected USB devices. 
To avoid this, we wanted to put GDSC in retention during PM suspend.

> Are you sure there's no state that needs to be retained regardless of
> the wakeup setting?
> 
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-sc7280.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
>> index 7ff64d4d5920..de29a034e725 100644
>> --- a/drivers/clk/qcom/gcc-sc7280.c
>> +++ b/drivers/clk/qcom/gcc-sc7280.c
>> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>>   	.pd = {
>>   		.name = "gcc_usb30_prim_gdsc",
>>   	},
>> -	.pwrsts = PWRSTS_OFF_ON,
>> +	.pwrsts = PWRSTS_RET_ON,
>>   	.flags = VOTABLE,
>>   };
> 
> And what about gcc_usb30_sec_gdsc?

Currently wakeup is not enabled on secondary controller as its not 
required for end product platform (herobrine variant). So leaving the 
usb30_sec_gdsc as it is for now.

Regards,
Krishna,

