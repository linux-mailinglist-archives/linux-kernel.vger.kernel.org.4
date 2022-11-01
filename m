Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C050C615360
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKAUfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:35:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3712772;
        Tue,  1 Nov 2022 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667334945; x=1698870945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vq8w5J8ZljgRouLDat6E82i5n2WY0T1CLVf69PaTsHk=;
  b=GNZDuxvERjCyicXQf6DyRn6LZ3QsUzqreq0KHjYqtDOtpE+bDWxMK3qi
   /FjSNPB18TAOzVVZ0+tZ4TvhlxBICltoMfMMLDMMx/GBjG+BTEhx4eRdu
   d8ljSL9ENxpSsCGm9/7d6t1BQlgScWY6favRl7U3hG806hFO9BJseMK87
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Nov 2022 13:35:44 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 13:35:44 -0700
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 13:35:43 -0700
Message-ID: <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com>
Date:   Tue, 1 Nov 2022 13:35:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
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
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 9:23 AM, Jassi Brar wrote:
> On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>> Hi Jassi,
>>
>> On 10/27/2022 7:33 PM, Jassi Brar wrote:
>>   > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
>> <quic_eberman@quicinc.com> wrote:
>>   > .....
>>   >> +
>>   >> +        gunyah-resource-mgr@0 {
>>   >> +            compatible = "gunyah-resource-manager-1-0",
>> "gunyah-resource-manager";
>>   >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
>> full IRQ */
>>   >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
>> empty IRQ */
>>   >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
>>   >> +                  /* TX, RX cap ids */
>>   >> +        };
>>   >>
>>   > All these resources are used only by the mailbox controller driver.
>>   > So, this should be the mailbox controller node, rather than the
>>   > mailbox user.> One option is to load gunyah-resource-manager as a
>> module that relies
>>   > on the gunyah-mailbox provider. That would also avoid the "Allow
>>   > direct registration to a channel" hack patch.
>>
>> A message queue to another guest VM wouldn't be known at boot time and
>> thus couldn't be described on the devicetree.
>>
> I think you need to implement of_xlate() ... or please tell me what
> exactly you need to specify in the dt.

Dynamically created virtual machines can't be known on the dt, so there 
is nothing to specify in the DT. There couldn't be a devicetree node for 
the message queue client because that client is only exists once the VM 
is created by userspace.

As a more concrete example, there is QRTR (net/qrtr) virtualization 
support which is implemented with Gunyah message queues. Whether a QRTR 
client needs to be for VM is only determined when launching the VM as 
well as which message queue resource the QRTR client should be using. 
Since many VMs could be running on a system, it's not possible to know 
the number of mailbox controllers (i.e. message queues) nor the number 
of mailbox clients (e.g. QRTR) as a static configuration in the DT.

Thanks,
Elliot
