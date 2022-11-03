Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5076174E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKCDWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKCDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:21:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D914D2E;
        Wed,  2 Nov 2022 20:21:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f7so1156648edc.6;
        Wed, 02 Nov 2022 20:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mJ1M1GCa29hKoerTifDSh6zyzpsImb+52pEFvSJf6k=;
        b=SqxPLb37gwUzlh0M2OCmLT3oshNTX2u7ZDnwnsLBGMw+2hzrjm6H6qVneSZ2JRG7ad
         RKiQCmfVy/LwMrC4GGlPmWe4n1VN+tOdt7Ec/A3lOUs0teu08X0hUfJqw0pqAVWz9a6S
         OBaBfZQ1F4jdSUk1XyQfZegrANC4EX4EGTs+tpsRpkxPDI6zneQs5wrsCrlFnMV9tcIe
         O62MGSmazs952yy/io8OtJPPORD4inDvrc8dFCzFjPezL8uKfHbEJuZsEYTcX5oAeDsK
         wQCIFJ6DdBY6dhNV+e4msBR4tYEJvv6NUHbumbMH596G34oFlWLJbM/bmStZk3954W2g
         H7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mJ1M1GCa29hKoerTifDSh6zyzpsImb+52pEFvSJf6k=;
        b=7nsxTNaFvprYu2zh1StnMYIQJUnMedGE+UUoCgCSUdjSoRsnFWlWihUXELN1KTVHPV
         DAReOtiPHKzGBIsfAMkva1JUdTEUy8vzoJUJNVyY9NmrqJiSJuv4CwCaY3aU0RN0Kx3j
         gi/2YNHW3IULGkojpNxmcOJRFeK7O5nsfBMaVZjFVMIU3viu/EtEwVbR/6VWzSqJUW26
         gPA24Zy2x2o8eO5KnhJCcZyMe4C1Rza0jCyR1MiPKTuIiGJup6jBZEJR5miViXxaUCw4
         P5+PAGgvioOLyq+KVK17UZhTLZuKKYqBo82+bmTCHNDYKTQBHfDPbyHUwqU7jOeX7fWH
         Lxow==
X-Gm-Message-State: ACrzQf3a1g69PfJl4cEcYxTozNNyF/P8fZkAqk0rRkGjlVGqoitNJbDS
        t08bBwPK+w1ZySUjNwRMc+0BQJlrZbfPTUP2e8A=
X-Google-Smtp-Source: AMsMyM6kKs8VptkJDrUguJRraGRylo14qt/1lsP7wua44fsE/ep67/0MdoOlKkkmkz/BVyRXfkdfHy9iRMu5SfKNflU=
X-Received: by 2002:a05:6402:1d4e:b0:461:c7bd:7d9c with SMTP id
 dz14-20020a0564021d4e00b00461c7bd7d9cmr27654272edb.284.1667445710302; Wed, 02
 Nov 2022 20:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com> <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com> <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
 <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com> <CABb+yY2GA90RLazHZL7sLtC+ka-P8y6s00V2BVF4OMPTDi-rKg@mail.gmail.com>
 <62f7402d-f0e7-8e8a-e1a4-958ddbcf8d8b@quicinc.com> <CABb+yY0-rtt5CfzGA_D3THnfTO1pgstmVo2_1McEJ=JMdTcD2Q@mail.gmail.com>
 <840d876c-6a09-59cf-fc66-c5752ad22d7e@quicinc.com> <CABb+yY1rd2mzNz-ovaO2Di=9qeAKp4XeUUE+6yPbBiv7YjTCfw@mail.gmail.com>
 <10525d0d-b887-6960-5fbc-933b91e2e97c@quicinc.com>
In-Reply-To: <10525d0d-b887-6960-5fbc-933b91e2e97c@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 2 Nov 2022 22:21:38 -0500
Message-ID: <CABb+yY2fBa3up8Byu8axagwTEoidW+mbwene1qFyh=qJxPLJ=Q@mail.gmail.com>
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 6:23 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
>
> On 11/2/2022 11:24 AM, Jassi Brar wrote:
> > On Wed, Nov 2, 2022 at 1:06 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>
> >> Hi Jassi,
> >>
> >> On 11/1/2022 7:01 PM, Jassi Brar wrote:
> >>> On Tue, Nov 1, 2022 at 7:12 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/1/2022 2:58 PM, Jassi Brar wrote:
> >>>>> On Tue, Nov 1, 2022 at 3:35 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 11/1/2022 9:23 AM, Jassi Brar wrote:
> >>>>>>> On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Jassi,
> >>>>>>>>
> >>>>>>>> On 10/27/2022 7:33 PM, Jassi Brar wrote:
> >>>>>>>>      > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
> >>>>>>>> <quic_eberman@quicinc.com> wrote:
> >>>>>>>>      > .....
> >>>>>>>>      >> +
> >>>>>>>>      >> +        gunyah-resource-mgr@0 {
> >>>>>>>>      >> +            compatible = "gunyah-resource-manager-1-0",
> >>>>>>>> "gunyah-resource-manager";
> >>>>>>>>      >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
> >>>>>>>> full IRQ */
> >>>>>>>>      >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
> >>>>>>>> empty IRQ */
> >>>>>>>>      >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> >>>>>>>>      >> +                  /* TX, RX cap ids */
> >>>>>>>>      >> +        };
> >>>>>>>>      >>
> >>>>>>>>      > All these resources are used only by the mailbox controller driver.
> >>>>>>>>      > So, this should be the mailbox controller node, rather than the
> >>>>>>>>      > mailbox user.> One option is to load gunyah-resource-manager as a
> >>>>>>>> module that relies
> >>>>>>>>      > on the gunyah-mailbox provider. That would also avoid the "Allow
> >>>>>>>>      > direct registration to a channel" hack patch.
> >>>>>>>>
> >>>>>>>> A message queue to another guest VM wouldn't be known at boot time and
> >>>>>>>> thus couldn't be described on the devicetree.
> >>>>>>>>
> >>>>>>> I think you need to implement of_xlate() ... or please tell me what
> >>>>>>> exactly you need to specify in the dt.
> >>>>>>
> >>>>>> Dynamically created virtual machines can't be known on the dt, so there
> >>>>>> is nothing to specify in the DT. There couldn't be a devicetree node for
> >>>>>> the message queue client because that client is only exists once the VM
> >>>>>> is created by userspace.
> >>>>>>
> >>>>> The underlying "physical channel" is the synchronous SMC instruction,
> >>>>> which remains 1 irrespective of the number of mailbox instances
> >>>>> created.
> >>>>
> >>>> I disagree that the physical channel is the SMC instruction. Regardless
> >>>> though, there are num_online_cpus() "physical channels" with this
> >>>> perspective.
> >>>>
> >>>>> So basically you are sharing one resource among users. Why doesn't the
> >>>>> RM request the "smc instruction" channel once and share it among
> >>>>> users?
> >>>>
> >>>> I suppose in this scenario, a single mailbox channel would represent all
> >>>> message queues? This would cause Linux to serialize *all* message queue
> >>>> hypercalls. Sorry, I can only think negative implications.
> >>>>
> >>>> Error handling needs to move into clients: if a TX message queue becomes
> >>>> full or an RX message queue becomes empty, then we'll need to return
> >>>> error back to the client right away. The clients would need to register
> >>>> for the RTS/RTR interrupts to know when to send/receive messages and
> >>>> have retry error handling. If the mailbox controller retried for the
> >>>> clients as currently proposed, then we could get into a scenario where a
> >>>> message queue could never be ready to send/receive and thus stuck
> >>>> forever trying to process that message. The effect here would be that
> >>>> the mailbox controller becomes a wrapper to some SMC instructions that
> >>>> aren't related at the SMC instruction level.
> >>>>
> >>>> A single channel would limit performance of SMP systems because only one
> >>>> core could send/receive a message. There is no such limitation for
> >>>> message queues to behave like this.
> >>>>
> >>> This is just an illusion. If Gunyah can handle multiple calls from a
> >>> VM parallely, even with the "bind-client-to-channel" hack you can't
> >>> make sure different channels run on different cpu cores.  If you are
> >>> ok with that, you could simply populate a mailbox controller with N
> >>> channels and allocate them in any order the clients ask.
> >>
> >> I wanted to make sure I understood the ask here completely. On what
> >> basis is N chosen? Who would be the mailbox clients?
> >>
> > A channel structure is cheap, so any number that is not likely to run
> > out. Say you have 10 possible users in a VM, set N=16. I know ideally
> > it should be precise and flexible but the gain in simplicity makes the
> > trade-off very acceptable.
>
> I think I get the direction you are thinking now. N is chosen based off
> of how many clients there might be. One mailbox controller will
> represent all message queues and each channel will be one message queue.
> There are some limitations that might make it more complex to implement
> than having 1 message queue per controller like I have now.
>
> My interpretation is that mailbox controller knows the configuration of
> its channels before being bound to a client. For dynamically created
> message queues, the client would need tell the controller about the
> message queue configuration. I didn't find example where client is
> providing information about a channel to the controller.
>
>   1. need a mechanism to allow the client to provide the
> gunyah_resources for the channel (i.e. the irqs and cap ids).
>
IIUC there is exactly one resource-manager in a VM. Right?
Looking at your code, TX and RX irq are used only by the mailbox
driver and are the same for all clients/users. So that should be a
property under the mailbox controller node. Not sure what cap ids are.

>   2. Still need to have bind-client-to-channel patch since clients
> aren't real devices and so shouldn't be on DT.
>
the clients may be virtual (serial, gpio etc) but the resource-manager
requires some mailbox hardware to communicate, so the resource-manager
should be the mailbox client (that further spawns virtual devices)

thnx.
