Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF549616B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKBSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:06:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660521278;
        Wed,  2 Nov 2022 11:06:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2I0B8U032383;
        Wed, 2 Nov 2022 18:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9bd16qJOxFxmn3WuYuWKXuBoDrhtl72XvI6Qp1P+n1A=;
 b=dYhgQ32blGE3d2HIJ/kzqiQTidud8dXQ9N8sDv9bi6l3+ynTQAKx8iUJiI8zn7trV5S0
 vWURgtF8O6OSIqcRMkBaYFzSR+kMRSLj99P1GdYhf6SoHWr8ymnOl2uk8mTsdb5VzF8f
 x8INJ/YEBMUQqQwGaFzck/bFY7/+NKbQlZ9+ECFkj7Dzl+itWDh2P6Y1baitEX8t0oWm
 lyAkeA0VQ/qi0xPvLj5jepQ7YHZUsF3CzBDTkbMoaXsYRW6mOJgzCHAUVNEwQyBseuxR
 lA9w/MzNe4o4Cf8C7UUSgcYXVTaGG9wdVKlaHh+jXORuLBUj5EqT16XWkfuF99+Q7InM zQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkweg80h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:05:54 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2I5rNQ021036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 18:05:54 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 11:05:53 -0700
Message-ID: <840d876c-6a09-59cf-fc66-c5752ad22d7e@quicinc.com>
Date:   Wed, 2 Nov 2022 11:05:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com>
 <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com>
 <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
 <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com>
 <CABb+yY2GA90RLazHZL7sLtC+ka-P8y6s00V2BVF4OMPTDi-rKg@mail.gmail.com>
 <62f7402d-f0e7-8e8a-e1a4-958ddbcf8d8b@quicinc.com>
 <CABb+yY0-rtt5CfzGA_D3THnfTO1pgstmVo2_1McEJ=JMdTcD2Q@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CABb+yY0-rtt5CfzGA_D3THnfTO1pgstmVo2_1McEJ=JMdTcD2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xgq7az1uubtFEhv7QA1MXokBI2i9xs46
X-Proofpoint-ORIG-GUID: xgq7az1uubtFEhv7QA1MXokBI2i9xs46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=854
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 11/1/2022 7:01 PM, Jassi Brar wrote:
> On Tue, Nov 1, 2022 at 7:12 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>>
>>
>> On 11/1/2022 2:58 PM, Jassi Brar wrote:
>>> On Tue, Nov 1, 2022 at 3:35 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/1/2022 9:23 AM, Jassi Brar wrote:
>>>>> On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>>>>>
>>>>>> Hi Jassi,
>>>>>>
>>>>>> On 10/27/2022 7:33 PM, Jassi Brar wrote:
>>>>>>     > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
>>>>>> <quic_eberman@quicinc.com> wrote:
>>>>>>     > .....
>>>>>>     >> +
>>>>>>     >> +        gunyah-resource-mgr@0 {
>>>>>>     >> +            compatible = "gunyah-resource-manager-1-0",
>>>>>> "gunyah-resource-manager";
>>>>>>     >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
>>>>>> full IRQ */
>>>>>>     >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
>>>>>> empty IRQ */
>>>>>>     >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
>>>>>>     >> +                  /* TX, RX cap ids */
>>>>>>     >> +        };
>>>>>>     >>
>>>>>>     > All these resources are used only by the mailbox controller driver.
>>>>>>     > So, this should be the mailbox controller node, rather than the
>>>>>>     > mailbox user.> One option is to load gunyah-resource-manager as a
>>>>>> module that relies
>>>>>>     > on the gunyah-mailbox provider. That would also avoid the "Allow
>>>>>>     > direct registration to a channel" hack patch.
>>>>>>
>>>>>> A message queue to another guest VM wouldn't be known at boot time and
>>>>>> thus couldn't be described on the devicetree.
>>>>>>
>>>>> I think you need to implement of_xlate() ... or please tell me what
>>>>> exactly you need to specify in the dt.
>>>>
>>>> Dynamically created virtual machines can't be known on the dt, so there
>>>> is nothing to specify in the DT. There couldn't be a devicetree node for
>>>> the message queue client because that client is only exists once the VM
>>>> is created by userspace.
>>>>
>>> The underlying "physical channel" is the synchronous SMC instruction,
>>> which remains 1 irrespective of the number of mailbox instances
>>> created.
>>
>> I disagree that the physical channel is the SMC instruction. Regardless
>> though, there are num_online_cpus() "physical channels" with this
>> perspective.
>>
>>> So basically you are sharing one resource among users. Why doesn't the
>>> RM request the "smc instruction" channel once and share it among
>>> users?
>>
>> I suppose in this scenario, a single mailbox channel would represent all
>> message queues? This would cause Linux to serialize *all* message queue
>> hypercalls. Sorry, I can only think negative implications.
>>
>> Error handling needs to move into clients: if a TX message queue becomes
>> full or an RX message queue becomes empty, then we'll need to return
>> error back to the client right away. The clients would need to register
>> for the RTS/RTR interrupts to know when to send/receive messages and
>> have retry error handling. If the mailbox controller retried for the
>> clients as currently proposed, then we could get into a scenario where a
>> message queue could never be ready to send/receive and thus stuck
>> forever trying to process that message. The effect here would be that
>> the mailbox controller becomes a wrapper to some SMC instructions that
>> aren't related at the SMC instruction level.
>>
>> A single channel would limit performance of SMP systems because only one
>> core could send/receive a message. There is no such limitation for
>> message queues to behave like this.
>>
> This is just an illusion. If Gunyah can handle multiple calls from a
> VM parallely, even with the "bind-client-to-channel" hack you can't
> make sure different channels run on different cpu cores.  If you are
> ok with that, you could simply populate a mailbox controller with N
> channels and allocate them in any order the clients ask.

I wanted to make sure I understood the ask here completely. On what 
basis is N chosen? Who would be the mailbox clients?

Thanks,
Elliot

