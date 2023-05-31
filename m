Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6E7185A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjEaPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjEaPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:06:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD471B8;
        Wed, 31 May 2023 08:06:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDwe4u021261;
        Wed, 31 May 2023 15:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6ZeIzcgdCKjPmYnmTibQ8otwR7XccmkeAlMKuXz6bDk=;
 b=J0bQnkCiwj3KXeuibyvJfwrhE6B/4e0FUQSRdds2Wa1Vsa1UAJtebIDSPTYhLR4VgX6R
 jyQwOr1heOrhwbc/bK7p4EYKP8hTIn7KIKZZfDoYAPKWrTCDfhUSyP2pz+a6i8mx+yT3
 vpbwoDHSr4I90dpCD626Gsmnjq3gVtNso0cvI31I96NDSi6SI0zCXojanMtMWP/YG5RG
 4OdlszObCaVQ7MS9dgP2LnnBa7+eYx2iOnhI8/t027ZwWLmX+6/PutLe9uTbHRSAPHBW
 siDyY9PykhDycvKCKIp99cQMJ2w4J03z6y2iK3xqP9Qz/l4vPTLuJI+VCJfMpy0hKM7u KA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx5pxggus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:05:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VF5t60006469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:05:55 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 08:05:54 -0700
Message-ID: <eae9bd65-8d79-39af-0288-59af061a33ab@quicinc.com>
Date:   Wed, 31 May 2023 09:05:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Add userspace character interface
Content-Language: en-US
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <kuba@kernel.org>, <andersson@kernel.org>, <daniel@ffwll.ch>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
References: <20230522190459.13790-1-quic_jhugo@quicinc.com>
 <20230531142803.GH7968@thinkpad> <2023053134-unpiloted-why-0f37@gregkh>
 <31c8a9ef-bc48-138d-836b-61efd9f4128f@quicinc.com>
In-Reply-To: <31c8a9ef-bc48-138d-836b-61efd9f4128f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GyJxNAXiOsEKRzdWoCXXXCNWf2BANqh3
X-Proofpoint-ORIG-GUID: GyJxNAXiOsEKRzdWoCXXXCNWf2BANqh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310128
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2023 9:04 AM, Jeffrey Hugo wrote:
> On 5/31/2023 8:35 AM, Greg KH wrote:
>> On Wed, May 31, 2023 at 07:58:03PM +0530, Manivannan Sadhasivam wrote:
>>> + Jakub (who NACKed the previous submission of UCI driver)
>>> Link to previous submission: 
>>> https://lore.kernel.org/all/1606533966-22821-1-git-send-email-hemantk@codeaurora.org/ 
>>>
>>>
>>> On Mon, May 22, 2023 at 01:04:59PM -0600, Jeffrey Hugo wrote:
>>>> From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>>>>
>>>> I2C, USB, and PCIe are examples of buses which have a mechanism to give
>>>> userspace direct access to a device on those buses. The MHI userspace
>>>> character interface (uci) is the MHI bus analogue.
>>>>
>>>> The MHI bus devices are MHI channels which ferry blocks of data from 
>>>> one
>>>> end to the other. With this simple purpose, we can define a simple
>>>> interface to userspace - a character device that supports 
>>>> open/close/read/
>>>> write/poll operations. Since bus devices can only have a single 
>>>> consumer
>>>> we encode a whitelist of MHI channels to be exported to userspace so as
>>>> to avoid conflicts.
>>>>
>>>> We also make this mechanism open to any device that implements MHI.
>>>> Today this includes WLAN (Wi-Fi), WWAN (4G/5G cellular), and ML/AI
>>>> devices. More devices are expected in the future.
>>>>
>>>> In addition to implementing the framework for uci, we include an 
>>>> initial
>>>> usecase - the QAIC Sahara device.
>>>>
>>>> Sahara is a file transfer protocol that is commonly used for two 
>>>> purposes
>>>> when interacting with a device - transferring firmware to the device 
>>>> and
>>>> transferring crashdumps from the device. The Sahara protocol puts the
>>>> receiver of the data in control of the transfer. A firmware transfer
>>>> operation would have the device requesting the specific firmware images
>>>> that the device wants, and the host satisfying those requests.
>>>>
>>>> In most cases, including for AIC100, Sahara is used as part of a two 
>>>> stage
>>>> loading process. The device will boot a very limited bootloader that 
>>>> does
>>>> the base minimum initialization and jump to the next stage. A 
>>>> simple, one-
>>>> shot protocol like BHI is used to send the next stage bootloader to the
>>>> device. This second stage bootloader contains more functionality and
>>>> implements the Sahara protocol. The second stage determines from 
>>>> various
>>>> inputs what set of runtime firmware is required to boot the device 
>>>> into an
>>>> operational status, and requests those pieces from the host.  With 
>>>> those
>>>> images transferred over, the device can funnly initialize.
>>>>
>>>> Each AIC100 instance (currently, up to 16) in a system will create a
>>>> MHI device for QAIC_SAHARA. MHI_uci will consume each of these and 
>>>> create
>>>> a unique chardev which will be found as
>>>> /dev/<mhi instance>_QAIC_SAHARA
>>>> For example - /dev/mhi0_QAIC_SAHARA
>>>>
>>>> An open userspace application that can consume these devices for 
>>>> firmware
>>>> transfers is located at https://github.com/andersson/qdl
>>>>
>>>> Signed-off-by: Pranjal Ramajor Asha Kanojiya 
>>>> <quic_pkanojiy@quicinc.com>
>>>> [jhugo: Rename to uci, plumb to mhi, rewrite commit text]
>>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>
>>> The previous attempt on adding UCI driver was NACKed by Jakub. For 
>>> merging this
>>> patch, I need an ACK from Jakub.
>>
>> Given that this fails the kernel robot tests, why would anyone ack it
>> as-is?
> 
> I think Mani I looking for some "guidance" on the "architecture", and 
> frankly so am I.  An official Ack from Jakub might not be quite the 
> right thing at this stage, but at-least Jakub could come in and say he 
> isn't planning on NACKing this right off the bat, in particular because 
> this functionality can be used by WWAN devices which seems to be what 
> caused the mess the last time around.
> 
> We've gone full circle here.  This functionality was proposed as part of 
> the bus.  Jakub came in an NACKed that, which resulted in the WWAN 
> subsystem and the guidance that this functionally belongs with the 
> devices.  I tried to put it with the AIC100/QAIC device based on that, 
> and that got NACKed by Daniel (GPU) saying that this belongs with the 
> bus.  You (Greg) seemed to agree with Daniel on that.
> 
> Fixing kernel robot tests is one thing (I haven't seen any reports on 
> this iteration), but if there is no agreement on where this lives, isn't 
> it DOA?

I went hunting for a report and found it.  Not sure why it hasn't hit my 
inbox.  The issue looks trivial and really doesn't seem to prevent 
discussions on this IMO.

> 
> In summary, if you don't like this, please give some clear guidance. 
> Greg, you've told me in the past that you don't discuss "architecture" 
> without seeing the code.  Here is some code.  I don't claim it is 
> perfect (you mentioned the QAIC version had some issues you were going 
> to help with), but I would like to see some input.
> 
> -Jeff
> 

