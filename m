Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8145FA6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJJU7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiJJU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:58:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F857E020;
        Mon, 10 Oct 2022 13:58:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AItFiN003151;
        Mon, 10 Oct 2022 20:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JemLN4s2DlwZ342CFWdBzSb6ZQFVPC8/pfjeskdzVbg=;
 b=pmpktESDSH68Sj6F4UwldlygtwdKuCWpXIIcJqk9zrxZBUXgZh1iha8LEf2SqgObWOmj
 Nia3nGnkRDRcf69PccdHOjd1WtcK/3/m1lSn0i6+XPk6MW/Pjg6u7CL38Pz0/rVBSmeL
 mfIpXUDhtEOtGwisKbaNfNLzsF0nBMPGpUatCrXPe45cUTtK+LrkX2wySyHAE392nRcD
 q9fQHzckUcnSBp1GO/QCPG3FmWQYSotGS4NVQBkazCIk2b7as63h1qDomsMhbS2TkbK0
 QDzNsJEFY+aHc0lLJGy8/QZ1+PQil2CcCAn1q7PyYOWrRb0pb2kStn/WlUHYyHTqAILR qw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx2g8nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 20:58:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29AKw2Xj007507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 20:58:02 GMT
Received: from [10.110.10.240] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 13:58:01 -0700
Message-ID: <ca42d89e-9e19-0536-0951-2c123d898892@quicinc.com>
Date:   Mon, 10 Oct 2022 13:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
 <Yz/YBDqqwBUlswgX@kroah.com>
 <615493a8-449d-b105-709e-0642dfb5359b@quicinc.com>
 <Y0R/QbysXa6ebNd8@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y0R/QbysXa6ebNd8@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JVk-a2uHWaQg5Q69tWKDC589IcS8uUqv
X-Proofpoint-ORIG-GUID: JVk-a2uHWaQg5Q69tWKDC589IcS8uUqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=858
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100124
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2022 1:23 PM, Greg Kroah-Hartman wrote:
> On Sun, Oct 09, 2022 at 01:59:21PM -0700, Elliot Berman wrote:
>>
>>
>> On 10/7/2022 12:40 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Oct 06, 2022 at 10:59:51PM -0700, Elliot Berman wrote:
>>>>
>>>> "GH" is the shorthand we've been using for "Gunyah". I didn't find
>>>> documentation for dynamically assigned char devices, but if it exists, I can
>>>> add entry for ttyGH.
>>>
>>> Why use a new name at all?  Why not stick with the existing tty names
>>> and device numbers?
>>>
>>
>> I can use hvc framework, although driver-level buffering is needed on
>> both the get_chars/put_chars paths because:
> 
> I'm not asking about the framework (although that is a good question,
> you need to document why this has to be new.)  I'm asking why pick a new
> name?  You will not have a name conflict in your system with this device
> with any other tty name right?
> 

That's correct, I didn't see any other instances of "ttyGH" in kernel.

>>   - get_chars wants to poll for characters, but Gunyah will push
>>     characters to Linux
>>   - put_chars can be called in atomic context in the printk console path.
>>     Gunyah RM calls can sleep, so we add to buffer and queue work to
>>     write the characters.
>>
>> I also chose to use new tty driver because the Gunyah hypervisor call to
>> open the console (gh_rm_console_open) can only be done after starting the
>> VM. Gunyah will only forward characters sent from the other VM to Linux
>> after the gh_rm_console_open call is made. When launching a VM, users would
>> want to open console before VM starts so they can get startup messages from
>> the VM. I planned to use the carrier_raised() to hold
>> tty_port_block_until_ready until the VM is started and the
>> gh_rm_console_open() happens.
> 
> I'm sorry, but I don't understand this.
> 
> Why is this all a new api at all?  What about the virtio api?  Why not
> just use that instead?

We want to support virtual machines and Virtual Machine Managers (the 
userspace component) that don't support virtio. Qualcomm has some 
lightweight VMs that have a Gunyah driver stack but no virtio stack. 
Further, implementing a simple userspace VMM to launch a Linux kernel is 
much easier with the Gunyah console as no device paravirtualization is 
needed to get some output from Linux. I don't anticipate these VMs to be 
commonplace, but they do exist.

Thanks,
Elliot
