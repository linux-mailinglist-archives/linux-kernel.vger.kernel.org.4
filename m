Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD7615494
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKAV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiKAV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:59:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B51A812;
        Tue,  1 Nov 2022 14:58:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f5so19024861ejc.5;
        Tue, 01 Nov 2022 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TMJ2/97uEF+3KaUi8/IJUBwB2FgHNsew0b2CWSykd0=;
        b=N5MlkBYasbaBLPbYSLbwkBFgPK6XXiKDrbPXeLderFC0hN+1hqOiBdezANh1oMuCZY
         imjOu8VGMMXlEk60P8cD0Z5PE6gEyd4OkOST0fKrKQp3ENUFvL9lN9/4qwYfFkDXOMA9
         iSJlDLbkIpVta68NLet1Cl1wEZkEjxA4BQLy/kXGoQ4EADyX7/SAC2AoguIFFkpLNRXr
         keqExt3Bo/d7P0ZzgJzNy4le+ovY3LvlsPH4vN5e8uAfsrx02Z/PlE9TACqm/RswpPjN
         exD9MmDNVG5L0RaTNgfiBMBpjdU57J761psqOv91wEC/bdQrTcPLpDD/Pt8/fsJzW/00
         Y8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TMJ2/97uEF+3KaUi8/IJUBwB2FgHNsew0b2CWSykd0=;
        b=xyZpzWbIt7w7uXmcAdzU9nkfKoRRFT7BTQ3QwgWKgwQXSA/fAYA2fFuJ3ZgS2KOwXp
         2XH1eymU6BJrUMKeFdngOXdOGk8VXxaN5IBoaXSNyXNWG1Nvl6yoL9XjEHIxxj0WE331
         axgaPgx0mEB44Es1PmDwuMAE6CI8A4w4++oo6pA0/VEq4uxsr5h4bhw04VVXClOyFUEP
         LjfgR6i/3EvyMGP3qHZvlcTwRyBbbhsV33NChgqBFbQSaWNB37EduNlLayeBCTKvgENS
         JSe2JqkHW6AyLZw8IyVHn+IYXjxFYYXHlsBCPYC1xg6UiuhzmPXPaN+QnWc+SyWbsm+f
         xyDg==
X-Gm-Message-State: ACrzQf1WlF3PuePe5u+UG4kElFASv9MQBkYwB15KL6YvfAP72WS/UWar
        +J6QsV2aAtcweinWw5gNLr+udsuxI22aEAqGg7w=
X-Google-Smtp-Source: AMsMyM7gKetTduEW6MoryEjGlM7bGisT8V3iiRxLCrzL3iNkTHiUe9QH39sF2k31aoiedPiZQxniBSUE419TF76ewHA=
X-Received: by 2002:a17:906:2a93:b0:78d:b87e:6aab with SMTP id
 l19-20020a1709062a9300b0078db87e6aabmr20674022eje.157.1667339928024; Tue, 01
 Nov 2022 14:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com> <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com> <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
 <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com>
In-Reply-To: <4cb58489-cd42-1868-9add-0c360065de23@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 1 Nov 2022 16:58:36 -0500
Message-ID: <CABb+yY2GA90RLazHZL7sLtC+ka-P8y6s00V2BVF4OMPTDi-rKg@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 3:35 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
>
> On 11/1/2022 9:23 AM, Jassi Brar wrote:
> > On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>
> >> Hi Jassi,
> >>
> >> On 10/27/2022 7:33 PM, Jassi Brar wrote:
> >>   > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
> >> <quic_eberman@quicinc.com> wrote:
> >>   > .....
> >>   >> +
> >>   >> +        gunyah-resource-mgr@0 {
> >>   >> +            compatible = "gunyah-resource-manager-1-0",
> >> "gunyah-resource-manager";
> >>   >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
> >> full IRQ */
> >>   >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
> >> empty IRQ */
> >>   >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> >>   >> +                  /* TX, RX cap ids */
> >>   >> +        };
> >>   >>
> >>   > All these resources are used only by the mailbox controller driver.
> >>   > So, this should be the mailbox controller node, rather than the
> >>   > mailbox user.> One option is to load gunyah-resource-manager as a
> >> module that relies
> >>   > on the gunyah-mailbox provider. That would also avoid the "Allow
> >>   > direct registration to a channel" hack patch.
> >>
> >> A message queue to another guest VM wouldn't be known at boot time and
> >> thus couldn't be described on the devicetree.
> >>
> > I think you need to implement of_xlate() ... or please tell me what
> > exactly you need to specify in the dt.
>
> Dynamically created virtual machines can't be known on the dt, so there
> is nothing to specify in the DT. There couldn't be a devicetree node for
> the message queue client because that client is only exists once the VM
> is created by userspace.
>
The underlying "physical channel" is the synchronous SMC instruction,
which remains 1 irrespective of the number of mailbox instances
created.
So basically you are sharing one resource among users. Why doesn't the
RM request the "smc instruction" channel once and share it among
users?

-j
