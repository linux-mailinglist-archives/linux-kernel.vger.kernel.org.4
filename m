Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291C5FBD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:05:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E041F8;
        Tue, 11 Oct 2022 15:05:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BKNR06016412;
        Tue, 11 Oct 2022 22:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m2ky4svN6c78eZHfjYuoCzrkPF0YSmn2G2T87NbgUtk=;
 b=BLaJEDA0hxe19fi8DKBXqVUqLzMf1aj4cQpXn9HuTiwOtfrco/VW7zr+A7NSeYr4/qOG
 BYwJyXbAod8XTENQHic6rHXEkcA9RGt5pmipTv12acnGs7TDbU4245WYGt5p0K7rIXMC
 W0CJxQWp2isyss9riOQDncbZoKcvq5pbxr4HNCFqPixOXBKUQX0vkRR7/VYDx5SLlfck
 /mBVqRM56DY378e9cbgVd8yUNz9MWAS0twgC/l7YbeGhHOro3zejbdKctwP6WMUr41H0
 mUWyATIS9mWIQVAC+z6sjnKF5xq0yc37DAQug3SSnPiaW8wb7D9poAZ0t1SffpqX9ln2 rw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5e7fgcn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 22:04:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BM4mu6017012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 22:04:48 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 15:04:47 -0700
Message-ID: <b7cca9c7-5170-bf40-c030-d676944b03c6@quicinc.com>
Date:   Tue, 11 Oct 2022 15:04:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
 <85ca7eb4-3e0c-4ffb-8bac-a435594ca0f7@app.fastmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <85ca7eb4-3e0c-4ffb-8bac-a435594ca0f7@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1oiHcYJc3plJZX0C5nyA_0BPPVmJecTJ
X-Proofpoint-GUID: 1oiHcYJc3plJZX0C5nyA_0BPPVmJecTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=997 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110128
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 4:09 AM, Arnd Bergmann wrote:
> On Tue, Oct 11, 2022, at 8:02 AM, Jiri Slaby wrote:
>> On 11. 10. 22, 2:08, Elliot Berman wrote:
>>> +
>>> +	/* below are for printk console.
>>> +	 * gh_rm_console_* calls will sleep and console_write can be called from
>>> +	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
>>> +	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
>>> +	 * A work is scheduled to flush the bytes. The work will swap the active buffer
>>> +	 * and write out the other buffer.
>>> +	 */
>>
>> Ugh, why? This is too ugly and unnecessary. What about passing the kfifo
>> to gh_rm_console_write() instead? You do memcpy() there anyway.
> 
> Another problem here is that you really want the console output to be
> printed from atomic context, otherwise one would never see e.g. the
> output of a panic() call. Having a deferred write is probably fine for
> normal tty operations, but you probably want a different device for the
> console here, e.g. the hvc_dcc driver.
> 

Yes, that is our perspective on the RM console driver as well. I'll make 
this more explicit in the Kconfig/commit text. We expect most VMs 
(especially Linux) to use some other console mechanism provided by their 
VMM. I'm submitting here because we are presently using RM console on 
some of our VMs where we have other ways to collects logs on panic. It 
also makes it easier to implement a simple virtual machine manager that 
does not want to virtualize a serial device or have a virtio stack.

Thanks,
Elliot
