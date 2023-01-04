Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA665CC0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjADC5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:57:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EBC17595;
        Tue,  3 Jan 2023 18:57:52 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303Nq27j007677;
        Wed, 4 Jan 2023 02:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wMcMDlTY49K91ZeSvBz0G5w0eMRXbxHmlLZMi7YMavU=;
 b=lj3n7gD+w6tUqo3Y9sMH3oGdLgHK/Gvt4gw/rIbVX0oNZLefP7BV8rQoF1I7QXd8M4fn
 CZefZrTdDRk3idLpf8sRYfywbB84P6vZ+bHBucKWLi07GKa7lagzaNRcAmQmiWA9aqLZ
 zi2+jzWffOGuKV8kG9IqWgCaZqVOSrd98AnYZIrXSc5iTfyupmFVVH8VNyqpx2jhSva8
 ooVBXtP5T1H/FzmimynU/29+ysZoBez2SzDGEx9Va257oRzmUzjrAqWTJIeYLHQqG4jM
 ZiKwPRa+vF+Kj0maHLOtTwK9DMmYD4cdMnc6KHbfyjRypDqHeUPTapGKH8bngJ5iyMCM xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvwrtxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 02:57:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3042vk6J002512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 02:57:46 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 18:57:44 -0800
Message-ID: <7dac372b-167c-2dff-b207-6e32fd40c7bb@quicinc.com>
Date:   Wed, 4 Jan 2023 10:57:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
Content-Language: en-US
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
CC:     <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20230104021445.47484-1-quic_bqiang@quicinc.com>
 <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K2Qn6WbE-03-XthB4RCLqF6SQh3vjl4m
X-Proofpoint-ORIG-GUID: K2Qn6WbE-03-XthB4RCLqF6SQh3vjl4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_08,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040023
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/2023 10:41 AM, Jeffrey Hugo wrote:
> Why was this not sent to the MHI mailing list?
I don't know the MHI mailing list address, could tell me that?
>
> On Tue, Jan 3, 2023 at 7:19 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>> Currently no log printed when SYS_ERR happens, this makes
>> debug quite hard, so change log level to make it noisy.
> You are going to need to explain this more.
> There are two drivers in the upstream kernel that are MHI clients -
> pci_generic and ath11k.
> I'm assuming that you care about ath11k because you included that mail list.
Yes, I am talking about ath11k.
> In ath11k_mhi_op_status_cb() I see a warning message printed when the
> syserr callback is triggered.
> I see something similar in pci_generic.
>
> Looks like a log is printed when SYS_ERR happens in all possible
> scenarios, so I don't understand the point of this change.
> Particularly given that dev_dbg messages can be trivially enabled.
>
> -Jeff

Well, this is not true in some cases. For example, we have met cases where

WLAN HW/firmware is not working well, and only send a SYS_ERR event to MHI

driver, however this event is not sent to ath11k host becuase of 
mhi_pm_sys_err_handler(),

so we got no log at all.

