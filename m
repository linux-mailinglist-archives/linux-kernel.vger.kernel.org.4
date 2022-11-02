Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336A3616C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKBSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:24:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB91DF02;
        Wed,  2 Nov 2022 11:24:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so47612909eja.6;
        Wed, 02 Nov 2022 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QOOAo0r1f2eB5DLts+2NHykWcP4o2rs3NL8p/ceM7Q=;
        b=P/VEzq10mQ9feW8Z8mtnoUahcCtRrzBpJymKhRtAaALAZrzAglFen+djRN7asHjv8p
         PtlSkDfKe8Kq6RS6Bm5fbSY1NEO5ghz3hFBb32TaakeA6RS1D2iVjd0lLnZHlx4AyKyq
         Nt3dxP0fIaKn+j1yCdXc7Rd0CGm+cl4hrzKid9YnGbek5eG372xrLa1z6Wgb8dRrzhmy
         DQGHFFNB7k9bwojn4mGqLCgqGCkFFJFBPgTzeekWokMiZVP7DPv00D2IDo8DP07tpi8R
         mAbIoPObR9QwEJVBm04alujSoQQIWDIEFhx7ea+MiGJ6FoFagFldozVJziU1HT730rDH
         Hndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QOOAo0r1f2eB5DLts+2NHykWcP4o2rs3NL8p/ceM7Q=;
        b=gUa5Bu4BkbGD6MU4tMSFBfbW7nBH4UC5q4lobQO1dFBmQRaIyL1f0bYSRJtO0oZJvs
         I6zPCyErtzGm0d6Ad874RWnzu1Q/MoWe0cTvB/d5oFTbYlUvI0dVqY8YbDAWAeVDlBy/
         e8T3QKR0CgFVgHiY7osnEMJI86BkxjKrZl0Hrzshr7h9bGdx5FMSjomfMgB1Y/9wKWd+
         1fAWsqxx3xl9EWCGFRnVHRIkK9I0NJnCWwLDP8KDkIpoAlcjfFQnor+yifKHlbbP28uL
         I03TwCXqJvccOvula1yLPjWM2SRlZqAAgi4LgK7TQAgQ8lCemzMiPWrgk41iv/4ZPWPN
         5b0w==
X-Gm-Message-State: ACrzQf0zPEq7hTI1noqrB6udMntYvn89qQeTWt2bBGhpcY5yvbaIsnGM
        SgSN4rbyKuz2JuQSWZK4Uiyd0p6hQDsUNTPR5Uk=
X-Google-Smtp-Source: AMsMyM424hFL7N1fZmZ40u+saEIYDQr35PSwihsP2Kvc98uvdYUlbDMISZ3jTfp45t+04ao4VgNadyyd+TS3kaJbdbE=
X-Received: by 2002:a17:907:3e92:b0:7ad:d4f1:11d8 with SMTP id
 hs18-20020a1709073e9200b007add4f111d8mr16351846ejc.291.1667413466744; Wed, 02
 Nov 2022 11:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com> <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com> <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
 <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com> <CABb+yY2GA90RLazHZL7sLtC+ka-P8y6s00V2BVF4OMPTDi-rKg@mail.gmail.com>
 <62f7402d-f0e7-8e8a-e1a4-958ddbcf8d8b@quicinc.com> <CABb+yY0-rtt5CfzGA_D3THnfTO1pgstmVo2_1McEJ=JMdTcD2Q@mail.gmail.com>
 <840d876c-6a09-59cf-fc66-c5752ad22d7e@quicinc.com>
In-Reply-To: <840d876c-6a09-59cf-fc66-c5752ad22d7e@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 2 Nov 2022 13:24:15 -0500
Message-ID: <CABb+yY1rd2mzNz-ovaO2Di=9qeAKp4XeUUE+6yPbBiv7YjTCfw@mail.gmail.com>
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

On Wed, Nov 2, 2022 at 1:06 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Hi Jassi,
>
> On 11/1/2022 7:01 PM, Jassi Brar wrote:
> > On Tue, Nov 1, 2022 at 7:12 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 11/1/2022 2:58 PM, Jassi Brar wrote:
> >>> On Tue, Nov 1, 2022 at 3:35 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/1/2022 9:23 AM, Jassi Brar wrote:
> >>>>> On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>>>>>
> >>>>>> Hi Jassi,
> >>>>>>
> >>>>>> On 10/27/2022 7:33 PM, Jassi Brar wrote:
> >>>>>>     > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
> >>>>>> <quic_eberman@quicinc.com> wrote:
> >>>>>>     > .....
> >>>>>>     >> +
> >>>>>>     >> +        gunyah-resource-mgr@0 {
> >>>>>>     >> +            compatible = "gunyah-resource-manager-1-0",
> >>>>>> "gunyah-resource-manager";
> >>>>>>     >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
> >>>>>> full IRQ */
> >>>>>>     >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
> >>>>>> empty IRQ */
> >>>>>>     >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> >>>>>>     >> +                  /* TX, RX cap ids */
> >>>>>>     >> +        };
> >>>>>>     >>
> >>>>>>     > All these resources are used only by the mailbox controller driver.
> >>>>>>     > So, this should be the mailbox controller node, rather than the
> >>>>>>     > mailbox user.> One option is to load gunyah-resource-manager as a
> >>>>>> module that relies
> >>>>>>     > on the gunyah-mailbox provider. That would also avoid the "Allow
> >>>>>>     > direct registration to a channel" hack patch.
> >>>>>>
> >>>>>> A message queue to another guest VM wouldn't be known at boot time and
> >>>>>> thus couldn't be described on the devicetree.
> >>>>>>
> >>>>> I think you need to implement of_xlate() ... or please tell me what
> >>>>> exactly you need to specify in the dt.
> >>>>
> >>>> Dynamically created virtual machines can't be known on the dt, so there
> >>>> is nothing to specify in the DT. There couldn't be a devicetree node for
> >>>> the message queue client because that client is only exists once the VM
> >>>> is created by userspace.
> >>>>
> >>> The underlying "physical channel" is the synchronous SMC instruction,
> >>> which remains 1 irrespective of the number of mailbox instances
> >>> created.
> >>
> >> I disagree that the physical channel is the SMC instruction. Regardless
> >> though, there are num_online_cpus() "physical channels" with this
> >> perspective.
> >>
> >>> So basically you are sharing one resource among users. Why doesn't the
> >>> RM request the "smc instruction" channel once and share it among
> >>> users?
> >>
> >> I suppose in this scenario, a single mailbox channel would represent all
> >> message queues? This would cause Linux to serialize *all* message queue
> >> hypercalls. Sorry, I can only think negative implications.
> >>
> >> Error handling needs to move into clients: if a TX message queue becomes
> >> full or an RX message queue becomes empty, then we'll need to return
> >> error back to the client right away. The clients would need to register
> >> for the RTS/RTR interrupts to know when to send/receive messages and
> >> have retry error handling. If the mailbox controller retried for the
> >> clients as currently proposed, then we could get into a scenario where a
> >> message queue could never be ready to send/receive and thus stuck
> >> forever trying to process that message. The effect here would be that
> >> the mailbox controller becomes a wrapper to some SMC instructions that
> >> aren't related at the SMC instruction level.
> >>
> >> A single channel would limit performance of SMP systems because only one
> >> core could send/receive a message. There is no such limitation for
> >> message queues to behave like this.
> >>
> > This is just an illusion. If Gunyah can handle multiple calls from a
> > VM parallely, even with the "bind-client-to-channel" hack you can't
> > make sure different channels run on different cpu cores.  If you are
> > ok with that, you could simply populate a mailbox controller with N
> > channels and allocate them in any order the clients ask.
>
> I wanted to make sure I understood the ask here completely. On what
> basis is N chosen? Who would be the mailbox clients?
>
A channel structure is cheap, so any number that is not likely to run
out. Say you have 10 possible users in a VM, set N=16. I know ideally
it should be precise and flexible but the gain in simplicity makes the
trade-off very acceptable.

thanks.
