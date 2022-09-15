Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088D5B9560
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIOH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIOH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:27:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB38FD62;
        Thu, 15 Sep 2022 00:27:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7MlpL002809;
        Thu, 15 Sep 2022 07:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=goc2CvMB7xVbUlia39i3ox3mDrYzyU+LKXINBSITg+Y=;
 b=hkSPf9Y0Xe6680HYOovI2R0fhVBHRZbT8EtAP2mQxqgd1jJHymYOSdld+/Cp6o570dAQ
 6wP1gP2XyPJ39yzwIjGhe3B0aggp7HrB1Fh7M6CWw5NZ1m8htFMpHe0khqq5ZWbCJlHq
 isrdG8YlZPnU1X2RXOUrjN39Xdw4RAstY/P0Tg4P2VjdWmoL2j4n5smOvpgOqaXEplqN
 0Qqeo1Yz3aK7o7c/A9rifYjU/ddd4xIrkB49v/DbusKJPOK8AmpKdf+mlA2BNRbVUA0w
 INTjf5ERu58SxqlEGVDnHmRkHBe170NFyihfEmCHwwtHg359broLaSJDys54vxh3l5sl Gg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkp8ashyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 07:26:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F7QCFu023313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 07:26:12 GMT
Received: from [10.216.56.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:26:07 -0700
Message-ID: <4490d181-7bf2-791c-1778-1102e9adbc25@quicinc.com>
Date:   Thu, 15 Sep 2022 12:55:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Johan Hovold <johan@kernel.org>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <johan+linaro@kernel.org>,
        <quic_kriskura@quicinc.com>, <dianders@chromium.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YxDYJ+ONryLROBhL@google.com> <YyF+5CQqcLQlXvzV@hovoldconsulting.com>
 <YyJGNR33JbHxWWYD@google.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <YyJGNR33JbHxWWYD@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nhvtnoVQYw09joTXs-KiNOTCtXuV1eRH
X-Proofpoint-ORIG-GUID: nhvtnoVQYw09joTXs-KiNOTCtXuV1eRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=702
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150039
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2022 2:53 AM, Matthias Kaehlcke wrote:
> On Wed, Sep 14, 2022 at 09:12:36AM +0200, Johan Hovold wrote:
>> On Thu, Sep 01, 2022 at 09:04:55AM -0700, Matthias Kaehlcke wrote:
>>> On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
>>>> USB on sc7280 cannot support wakeups from low power states
>>>> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
>>>> only transitions to RET in low power.
>>>>
>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>>
>> Did you confirm that you actually hit the retention state?
> 
> No, how would I do that?
> 
>> IIUC, this series is equivalent to using ALWAYS_ON unless CX is actually
>> powered off during suspend.
> 
> The count in /sys/kernel/debug/qcom_stats/cxsd increses with each suspend,
> however it also does that with the GDSC configured as ALWAYS_ON and with
> Rajendra's "arm64: dts: qcom: sc7280: Add required-opps for USB" [1], so

hmm, that's really not expected. With my above patch and with the GDSC as
ALWAYS_ON there is a cx vote in suspend preventing cxsd so the counter
should not go up.

> I guess that isn't the correct signal.
> 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20220914053017.23617-1-quic_rjendra@quicinc.com/
