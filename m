Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D37656FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiL0VKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiL0VJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:09:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9D3A7;
        Tue, 27 Dec 2022 13:07:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRKjb1s019199;
        Tue, 27 Dec 2022 21:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GutUbXB1IakrXGdBIJC1gfkGpv20AavOAvOUFVw47TY=;
 b=hk+QgYsB02Tjj30JXOrZAvdeOiyRyQLg/J8BA4JewLr48LVHoJj5qUM97xbhxLfBuCQ1
 4+xpqqzaxE4LrH91QK75iowOoKE3RfZ1QncQliCDUFh9x2WSmwcRraxDEU4iAWaoMg6/
 z1lJpW8VWpkAdDyZVvmO+IQdJKMyBPz1GkW0AdaE2oL3+e1o/m7w5smBjiZAHhVe5Ez0
 UqZzF2g/12GzOswxhozlshXQcpmxG8WXt0vZIAiI7cHE/wShZJWU414GdEqFDq/ZJZsU
 7D3m3IQvkmwRINcyUkS3tCU6tBhhxyx2AWf7g1T35Dr8MslUDRZHQadIPAkZNW0MEn9E Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mntkvdfx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:06:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL6jSQ006363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:06:45 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:06:44 -0800
Message-ID: <f5af23da-a89f-3e76-5cd6-1f630e44fcdd@quicinc.com>
Date:   Tue, 27 Dec 2022 13:06:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 08/14] usb: dwc3: Add DT parameter to specify maximum
 number of interrupters
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-9-quic_wcheng@quicinc.com>
 <CAA8EJppsK=L69AaBgj=MzWp-ess3NSn=gPYf8-3QtJVqEVqGzw@mail.gmail.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <CAA8EJppsK=L69AaBgj=MzWp-ess3NSn=gPYf8-3QtJVqEVqGzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Td3kYWk33zAaGGtaC1UySb4xRCN-PSWG
X-Proofpoint-ORIG-GUID: Td3kYWk33zAaGGtaC1UySb4xRCN-PSWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_15,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=794 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212270176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 12/24/2022 3:13 AM, Dmitry Baryshkov wrote:
> On Sat, 24 Dec 2022 at 01:33, Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>>
>> Allow for the DWC3 host driver to pass along a XHCI property that defines
>> how many interrupters to allocate.  This is in relation for the number of
>> event rings that can be potentially used by other processors within the
>> system.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 12 ++++++++++++
>>   drivers/usb/dwc3/core.h |  2 ++
>>   drivers/usb/dwc3/host.c |  5 ++++-
>>   3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 476b63618511..67d6f0ae81d2 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1446,6 +1446,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>          u8                      tx_thr_num_pkt_prd = 0;
>>          u8                      tx_max_burst_prd = 0;
>>          u8                      tx_fifo_resize_max_num;
>> +       u8                      num_hc_interrupters;
>>          const char              *usb_psy_name;
>>          int                     ret;
>>
>> @@ -1468,6 +1469,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>           */
>>          tx_fifo_resize_max_num = 6;
>>
>> +       /* default to a single XHCI interrupter */
>> +       num_hc_interrupters = 1;
>> +
>>          dwc->maximum_speed = usb_get_maximum_speed(dev);
>>          dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
>>          dwc->dr_mode = usb_get_dr_mode(dev);
>> @@ -1511,6 +1515,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>                                  &tx_thr_num_pkt_prd);
>>          device_property_read_u8(dev, "snps,tx-max-burst-prd",
>>                                  &tx_max_burst_prd);
>> +       device_property_read_u8(dev, "snps,num-hc-interrupters",
>> +                               &num_hc_interrupters);
> 
> bindings change?
> 

Will add one.  Thanks!

Thanks
Wesley Cheng
