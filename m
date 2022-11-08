Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1C620947
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKHGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKHF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:59:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD198C755;
        Mon,  7 Nov 2022 21:59:58 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A85dueA030535;
        Tue, 8 Nov 2022 05:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q5x3mbotwDjjw5wTVlGWhe4kAfiJoSuoTBpIjLq4ZGY=;
 b=PMXdN4AVnaU0R3hHbiFWvB4tQBZjWA6wv13E34iRba3hPKcp2wxB9Fgt3feYuaa0YlzV
 e6kcIK0WmB1audqfDUHIo8bneSa2ijpyvCBgTUUVrfg3ZjxuPTez7NeGn79FwfCs6GoY
 vFJEGvxcbqWFoE+0gK2EAXvadBOoUGP1otlUSq+em8kD/l8un/gaCUpIWBpBtujtnl82
 ItmholXDLdJYhAQuswkrX8tK/4+PgzOeQaX0AYmddQx76RSJO6YbVOa1JPvPGAjY5ZEN
 LD3pFF/+vUYsSk3WbPpwSInID7lA+/Qe6QiNoUvEf110ZrmotbbUwZgpcjltDRnhrYpf og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqh4g81s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:59:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A85xmht026109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 05:59:48 GMT
Received: from [10.50.47.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 21:59:45 -0800
Message-ID: <3b81d875-7f4b-446a-565b-189ad6c8d9dc@quicinc.com>
Date:   Tue, 8 Nov 2022 11:29:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: qcom: Update the force mem core bit for GPU clocks
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <linux-clk@vger.kernel.org>
References: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52N6oxSLoU_=Cq1xK9bVX7H+AvPsR3dLepMNjKywdffvQ@mail.gmail.com>
 <21cd992c-334e-3a28-f3ac-68a49a4ef00b@quicinc.com>
 <CAD=FV=WRCJ6d6jTHH2ZHvuh+c4yTeXhS_D5LZcvfMn1c4NP2aA@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAD=FV=WRCJ6d6jTHH2ZHvuh+c4yTeXhS_D5LZcvfMn1c4NP2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VJ8AVlnJS6OpLBzmpjYA0tZElcLIRZfB
X-Proofpoint-GUID: VJ8AVlnJS6OpLBzmpjYA0tZElcLIRZfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=668
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211080029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 11/7/2022 10:30 PM, Doug Anderson wrote:
> Hi,
>
> On Sun, Nov 6, 2022 at 9:38 PM Satya Priya Kakitapalli (Temp)
> <quic_c_skakit@quicinc.com> wrote:
>>
>> On 10/28/2022 5:54 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-10-18 23:05:35)
>>>> From: Taniya Das <quic_tdas@quicinc.com>
>>>>
>>>> There are few GPU clocks which are powering up the memories
>>>> and thus enable the FORCE_MEM_PERIPH always for these clocks
>>>> to force the periph_on signal to remain active during halt
>>>> state of the clock.
>>> I take it that missing this causes GPU to lose state when it suspends
>>> and that confuses the driver?
>>
>> It is more related to GPU SMMU states and the stability issues that are
>> encountered.
> I see a very similar code sequence for sc7180. Is any similar fix
> needed for sc7180, or is this something unique for sc7280?


This is not needed for sc7180, it is related to sc7280 only.

