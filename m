Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120365CC1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjADDRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:17:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA74E95B4;
        Tue,  3 Jan 2023 19:17:51 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3041Hebh017589;
        Wed, 4 Jan 2023 03:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0XWWvi91s0nxwXMJlepFLsP9HVt69U3mlZhv35tFFQU=;
 b=Mu9T6Uh0+LmyfySxB5OEm9kr+AYUVbdS8uTT3W1dZ9VGgR6sxGOUA7/aIe4Qq++8ZJyp
 PjxUqwg6t/WEOlBwUuIfapizDxNQgENNcHiE31zcEuBbRYM6dIVYbgoZq01baUfKLNUl
 gJ0CQAg3gGzzpmHa6fE+CuZRCAmJ9lnB/hq/0zQkBfLtQiMdMNkaMRuAtONlbaFIKE6U
 46fkEc/A7jf8G1zJNL28U4yZDxK8IAY0soUA3uHQWFdyTWuqC/eyXRsAp6fNNXb1svKK
 ds0WIi5+Lri/VgZxrtah47t+cJi7vna2XeLvy5RqPYvnuIm/QPpujCgCtGL8U/6dMp+o wQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvwrv0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 03:17:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3043Hatr030567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 03:17:36 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 19:17:34 -0800
Message-ID: <b0e8d03f-0e4e-b736-aa9d-cd49181d9041@quicinc.com>
Date:   Wed, 4 Jan 2023 11:17:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
Content-Language: en-US
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
CC:     <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <mhi@lists.linux.dev>
References: <20230104021445.47484-1-quic_bqiang@quicinc.com>
 <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
 <7dac372b-167c-2dff-b207-6e32fd40c7bb@quicinc.com>
 <CAOCk7NqNrxcXLsw3PRRdsiOrq5SB9DfxpuSH84-rB9-43fdpog@mail.gmail.com>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAOCk7NqNrxcXLsw3PRRdsiOrq5SB9DfxpuSH84-rB9-43fdpog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wt-U8mOX8YDKIaLOfFdHBUGofwXwDp5i
X-Proofpoint-ORIG-GUID: Wt-U8mOX8YDKIaLOfFdHBUGofwXwDp5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_08,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040026
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/2023 11:11 AM, Jeffrey Hugo wrote:
> On Tue, Jan 3, 2023 at 7:57 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>>
>> On 1/4/2023 10:41 AM, Jeffrey Hugo wrote:
>>> Why was this not sent to the MHI mailing list?
>> I don't know the MHI mailing list address, could tell me that?
> The relevant entry from MAINTAINERS -
>
> MHI BUS
> M: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> L: mhi@lists.linux.dev
> L: linux-arm-msm@vger.kernel.org
> S: Maintained
> T: git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
> F: Documentation/ABI/stable/sysfs-bus-mhi
> F: Documentation/mhi/
> F: drivers/bus/mhi/
> F: include/linux/mhi.h
>
>>> On Tue, Jan 3, 2023 at 7:19 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>>>> Currently no log printed when SYS_ERR happens, this makes
>>>> debug quite hard, so change log level to make it noisy.
>>> You are going to need to explain this more.
>>> There are two drivers in the upstream kernel that are MHI clients -
>>> pci_generic and ath11k.
>>> I'm assuming that you care about ath11k because you included that mail list.
>> Yes, I am talking about ath11k.
>>> In ath11k_mhi_op_status_cb() I see a warning message printed when the
>>> syserr callback is triggered.
>>> I see something similar in pci_generic.
>>>
>>> Looks like a log is printed when SYS_ERR happens in all possible
>>> scenarios, so I don't understand the point of this change.
>>> Particularly given that dev_dbg messages can be trivially enabled.
>>>
>>> -Jeff
>> Well, this is not true in some cases. For example, we have met cases where
>>
>> WLAN HW/firmware is not working well, and only send a SYS_ERR event to MHI
>>
>> driver, however this event is not sent to ath11k host becuase of
>> mhi_pm_sys_err_handler(),
>>
>> so we got no log at all.
>>
> With the 6.1 kernel?
>
> mhi_pm_sys_err_handler() queues the st_worker.
>
> mhi_pm_st_worker() , which is the st_worker function, calls
> mhi_pm_sys_error_transition() in the DEV_ST_TRANSITION_SYS_ERR case
> (we are processing a SYS_ERR).
>
> Pretty much the first thing mhi_pm_sys_err_transition() does is this -
>
> /* We must notify MHI control driver so it can clean up first */
> mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
>
> Which calls the ath11k driver ath11k_mhi_op_status_cb() I mentioned earlier.
>
> -Jeff


No, mhi_pm_sys_err_handler() will NOT queue the st_worker because ath11k 
host supports RDDM, so the SYS_ERR event will be skipped. See below log:

kernel: [  165.393720] mhi mhi0: local ee: MISSION MODE state: M0 device 
ee: RAMDUMP DOWNLOAD MODE state: M0
kernel: [  165.401820] mhi mhi0: State change event to state: SYS ERROR
kernel: [  165.401824] mhi mhi0: System error detected
kernel: [  165.401827] mhi mhi0: Controller supports RDDM, skip SYS_ERROR

