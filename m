Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6D615731
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKBCBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKBCBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:01:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B512ACA;
        Tue,  1 Nov 2022 19:01:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so41609838ejc.7;
        Tue, 01 Nov 2022 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wpkpMG7UiwPayNiAZQIqA2owOEcKN042OlaP9NIKByQ=;
        b=PSI3BxsZxQhkVlAwBWePeEx4KtAfoo+szxImTtRUReTiDfr9ZDx6Sm5NPHqenJcNxT
         C1Cc1XtX2d+q26GnaWUsavd/r/VG2SddcvxNhRrceGmgd8jXDP3zO8nuuVuiXE9yg8Hv
         VromHHJwnoFv47aFFD6im43jbHCHm0qV2ut4Mm6hghqXVKBTtMMrOPSX4Es8NmfRxURn
         Y2nNK2sDRLTEQ4u2C+01zkX51+PYOkgLN2dDilBwbJVMVTnY515pXXOwSNQHmXwZgrRC
         ZExHO0WidqM2hqoKFAVYfQ30DpWzZE83Qd9SU2LqqYcsm7iUQBgPH/cZK8jnKEybEFn/
         rKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpkpMG7UiwPayNiAZQIqA2owOEcKN042OlaP9NIKByQ=;
        b=cgRV5/DyRKhMj01OIeUrLC6eWhGYLbnLGj5xQZeRvEQN0czm4IOkAvgIBr1u5Vn+4o
         1RMmg2shoMW5l7mRnCzsQpldKVoAUFo3RpTHoH/VsFdKHoY4I9Ge1GZrjt105SSJex0Q
         C9MyQrlnobGjz8cE7Tl4uuBuZlvqYXkoy1BcnEh093jL2d0e8dXxTm2lm4bej5ffDQUF
         4Al2Y1IaOonsfKDLsW8uI51x3m7ZLflyWafQxaNn5/NQU/B5dDBSCIh2VgOw2im3lH9t
         F7ep5+lj5LtaTgc34z/yaAwBbKPTFHToPX5taKLfJW44dbcZ99vtsMe4BawFLeQrfdQl
         PwzQ==
X-Gm-Message-State: ACrzQf1LEj69j6zNOfBDQruvaCua3lfpdAzPQMAtOPfb2Zn2tLrz/32M
        zbkg4ho9d72OKhakyxVmeaKwgnbM7yWAj4KD7DU=
X-Google-Smtp-Source: AMsMyM5uJ5eWQp6S+6Z4C0hK1rcz1qVltZNk5Qi3uW9GAkUnX1SsK5gFIxVzAh58sQenfPHh535CfkF5IlSn2uxJo/M=
X-Received: by 2002:a17:906:8a7b:b0:7ac:baef:6de1 with SMTP id
 hy27-20020a1709068a7b00b007acbaef6de1mr21277925ejc.734.1667354476420; Tue, 01
 Nov 2022 19:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com> <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com> <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
 <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com> <CABb+yY2GA90RLazHZL7sLtC+ka-P8y6s00V2BVF4OMPTDi-rKg@mail.gmail.com>
 <62f7402d-f0e7-8e8a-e1a4-958ddbcf8d8b@quicinc.com>
In-Reply-To: <62f7402d-f0e7-8e8a-e1a4-958ddbcf8d8b@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 1 Nov 2022 21:01:04 -0500
Message-ID: <CABb+yY0-rtt5CfzGA_D3THnfTO1pgstmVo2_1McEJ=JMdTcD2Q@mail.gmail.com>
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Nov 1, 2022 at 7:12 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
>
> On 11/1/2022 2:58 PM, Jassi Brar wrote:
> > On Tue, Nov 1, 2022 at 3:35 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 11/1/2022 9:23 AM, Jassi Brar wrote:
> >>> On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>
> >>>> Hi Jassi,
> >>>>
> >>>> On 10/27/2022 7:33 PM, Jassi Brar wrote:
> >>>>    > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
> >>>> <quic_eberman@quicinc.com> wrote:
> >>>>    > .....
> >>>>    >> +
> >>>>    >> +        gunyah-resource-mgr@0 {
> >>>>    >> +            compatible = "gunyah-resource-manager-1-0",
> >>>> "gunyah-resource-manager";
> >>>>    >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
> >>>> full IRQ */
> >>>>    >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
> >>>> empty IRQ */
> >>>>    >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> >>>>    >> +                  /* TX, RX cap ids */
> >>>>    >> +        };
> >>>>    >>
> >>>>    > All these resources are used only by the mailbox controller driver.
> >>>>    > So, this should be the mailbox controller node, rather than the
> >>>>    > mailbox user.> One option is to load gunyah-resource-manager as a
> >>>> module that relies
> >>>>    > on the gunyah-mailbox provider. That would also avoid the "Allow
> >>>>    > direct registration to a channel" hack patch.
> >>>>
> >>>> A message queue to another guest VM wouldn't be known at boot time and
> >>>> thus couldn't be described on the devicetree.
> >>>>
> >>> I think you need to implement of_xlate() ... or please tell me what
> >>> exactly you need to specify in the dt.
> >>
> >> Dynamically created virtual machines can't be known on the dt, so there
> >> is nothing to specify in the DT. There couldn't be a devicetree node for
> >> the message queue client because that client is only exists once the VM
> >> is created by userspace.
> >>
> > The underlying "physical channel" is the synchronous SMC instruction,
> > which remains 1 irrespective of the number of mailbox instances
> > created.
>
> I disagree that the physical channel is the SMC instruction. Regardless
> though, there are num_online_cpus() "physical channels" with this
> perspective.
>
> > So basically you are sharing one resource among users. Why doesn't the
> > RM request the "smc instruction" channel once and share it among
> > users?
>
> I suppose in this scenario, a single mailbox channel would represent all
> message queues? This would cause Linux to serialize *all* message queue
> hypercalls. Sorry, I can only think negative implications.
>
> Error handling needs to move into clients: if a TX message queue becomes
> full or an RX message queue becomes empty, then we'll need to return
> error back to the client right away. The clients would need to register
> for the RTS/RTR interrupts to know when to send/receive messages and
> have retry error handling. If the mailbox controller retried for the
> clients as currently proposed, then we could get into a scenario where a
> message queue could never be ready to send/receive and thus stuck
> forever trying to process that message. The effect here would be that
> the mailbox controller becomes a wrapper to some SMC instructions that
> aren't related at the SMC instruction level.
>
> A single channel would limit performance of SMP systems because only one
> core could send/receive a message. There is no such limitation for
> message queues to behave like this.
>
This is just an illusion. If Gunyah can handle multiple calls from a
VM parallely, even with the "bind-client-to-channel" hack you can't
make sure different channels run on different cpu cores.  If you are
ok with that, you could simply populate a mailbox controller with N
channels and allocate them in any order the clients ask.

-j
