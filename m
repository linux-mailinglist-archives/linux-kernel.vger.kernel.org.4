Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A35BDCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiITGCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiITGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:02:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7551839B;
        Mon, 19 Sep 2022 23:02:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K61wak016433;
        Tue, 20 Sep 2022 06:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4eqh6LAXrgTPEabpyKZdHjLMqH21BnHQ04RcSCEExLU=;
 b=ZY3sLX3jL+esynYwVfHdBgKqKlDCATO+8omtEeY7eeGdsE3QMLZqGYbalcALq3Rp0mAo
 7/MkCCKPgp18HIAfNmcR7+uUkbhpuEQpI45d/W0pa7IfXtT7Z92aEG/Kh9KKXhJC6J9d
 BnA8ZQugx/rQwO77X8Bsek6IjFVxdpRr6TKJaoJ5Qr0rCTnRACp/vxqY8bxq2MHaEkeH
 9+GD9q8fJCN2nhZfuTU8uoKnrHT203RS5ND4FCVTdQ/Zb9vGNIb6wL8jBOrXF2geLW8z
 s2tJCqYsNvHLur8yaa3uSlwaMDG+28G3VBL5eqxGGzu9qy+oqlOaxnXN3MFaM5nm8yjW 2g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jptw325b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:01:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28K61wfm031408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:01:58 GMT
Received: from [10.216.12.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 23:01:53 -0700
Message-ID: <cf4f7b9f-d870-a4f9-5056-666f820cf032@quicinc.com>
Date:   Tue, 20 Sep 2022 11:31:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb
 gdsc
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
 <20220916102417.24549-2-quic_rjendra@quicinc.com>
 <YyiOiudZuMDXOvGr@hovoldconsulting.com>
 <e446d0c0-7084-8b5a-132e-977b25913343@quicinc.com>
 <YylU9hx/9j0QKLsO@hovoldconsulting.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <YylU9hx/9j0QKLsO@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hhK2TDrPyJAmTkTJVXuOFEjPuuZiDWD5
X-Proofpoint-GUID: hhK2TDrPyJAmTkTJVXuOFEjPuuZiDWD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200036
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/2022 11:21 AM, Johan Hovold wrote:
> On Tue, Sep 20, 2022 at 09:06:22AM +0530, Rajendra Nayak wrote:
>>
>>
>> On 9/19/2022 9:15 PM, Johan Hovold wrote:
>>> On Fri, Sep 16, 2022 at 03:54:16PM +0530, Rajendra Nayak wrote:
>>>> The USB controller on sc7180 does not retain the state when
>>>> the system goes into low power state and the GDSC is
>>>> turned off. This results in the controller reinitializing and
>>>> re-enumerating all the connected devices (resulting in additional
>>>> delay while coming out of suspend)
>>>> Fix this by updating the .pwrsts for the USB GDSC so it only
>>>> transitions to retention state in low power.
>>>>
>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>>>> ---
>>>> v2:
>>>> Updated the changelog
>>>>
>>>>    drivers/clk/qcom/gcc-sc7180.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
>>>> index c2ea09945c47..2d3980251e78 100644
>>>> --- a/drivers/clk/qcom/gcc-sc7180.c
>>>> +++ b/drivers/clk/qcom/gcc-sc7180.c
>>>> @@ -2224,7 +2224,7 @@ static struct gdsc usb30_prim_gdsc = {
>>>>    	.pd = {
>>>>    		.name = "usb30_prim_gdsc",
>>>>    	},
>>>> -	.pwrsts = PWRSTS_OFF_ON,
>>>> +	.pwrsts = PWRSTS_RET_ON,
>>>>    };
>>>>    
>>>>    static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
>>>
>>> It seems like the above will not work unless you also provide the
>>> registers offsets that gdsc_force_mem_on() expects.
>>
>> That's true, but its needed only on platforms that support complete
>> CX domain power collapse. sc7280 (and sc7180) does not support
>> that and hence we can achieve GDSC RET without any of the RETAIN_MEM/
>> RETAIN_PERIPH bits programmed.
>> I explained some of that in detail on another related thread a
>> while back [1]
>>
>> [1] https://lore.kernel.org/all/5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com/
> 
> Thanks for the link, that was was very informative.
> 
> Could you please update the commit message of patch 1/3 so that it also
> covers these systems and explains why you don't set the RETAIN_MEM and
> RETAIN_PERIPH bits for them?
> 
> As that commit message stands now, it seems that those bits must be set
> for retention to work.

Agree, I will update the commit message and re-spin, thanks.

> 
>>> Specifically, unless you set cxc_count for the GDSC, the above call is a
>>> no-op and the retention setting (i.e. the RETAIN_MEM and RETAIN_PERIPH
>>> bits) will not be updated when registering the GDSC.
> 
> Johan
