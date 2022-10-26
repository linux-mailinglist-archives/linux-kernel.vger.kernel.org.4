Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5A60EABB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJZVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJZVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:17:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AA10CFBC;
        Wed, 26 Oct 2022 14:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B8E8B8243C;
        Wed, 26 Oct 2022 21:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0162FC43145;
        Wed, 26 Oct 2022 21:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666819016;
        bh=eXNYsyHrjfkj168/GLzMtKplVFDcKDxriIybCsmll4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtgM/mh5CDlkpSmwzvcKBbhfpYEk/Y5oWnhBJlt2AWf/j0eJmNK1iGpz/mBT2+Pp/
         etMbGppanoU7sUeYHaaxD44JOS88dHK2XPxcBIB/wbfS7YP1GA7VEZ1/TwyPTh1nFY
         z3fZ3NgEIG7AWD6omfOK5jZ9Gc38MSXus3wVUKVMcI1esIewtArzL0ArgywqYKGwkP
         Poz3u4CxCWbGhPk/n+YKpb6swHACaoGd8XWH1EMPv6iEIREmRrMvZKrVSGRIH9F0XL
         74Nz8I1KGG6QwuhoPc4DjJ0L3t4kOtrRSbkRLrgy4ZpiBQHerYbai0/JgWcp1GHd5J
         bRL6X4aytNcJQ==
Received: by mail-lf1-f48.google.com with SMTP id r14so31494323lfm.2;
        Wed, 26 Oct 2022 14:16:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf0RGxkF/CGFQ3bz20BOCZGsSkGqDQYLfS+d/0nQqc3S7F892MoZ
        fnJGy2mvs3aMasPpsUCQagfVIGZ6D+7G8MsWdA==
X-Google-Smtp-Source: AMsMyM68r1z6vDi1lrxqvnE4FImJ7MkTnCRg99ilWEyfO4MoJUdjzznRRdfEUQrx5J9gYr8/D1cKKZfj81WvAqCZowI=
X-Received: by 2002:a05:6512:3f0e:b0:4a0:45b7:a8dc with SMTP id
 y14-20020a0565123f0e00b004a045b7a8dcmr16365342lfa.368.1666819013968; Wed, 26
 Oct 2022 14:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-3-quic_eberman@quicinc.com> <20221012155645.GA2173829-robh@kernel.org>
 <ca13eb92-9b5b-19fd-27a5-f91f5048b142@quicinc.com>
In-Reply-To: <ca13eb92-9b5b-19fd-27a5-f91f5048b142@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Oct 2022 16:16:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cR5AEa5i1u-_L6sP6nYXS6qgaVWZ=KwxpUbxV3ZW-BA@mail.gmail.com>
Message-ID: <CAL_Jsq+cR5AEa5i1u-_L6sP6nYXS6qgaVWZ=KwxpUbxV3ZW-BA@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
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
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 6:59 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
> On 10/12/2022 8:56 AM, Rob Herring wrote:
> > On Mon, Oct 10, 2022 at 05:08:29PM -0700, Elliot Berman wrote:
> >> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
> >> Resource Manager applies a devicetree overlay describing the virtual
> >> platform configuration of the guest VM, such as the message queue
> >> capability IDs for communicating with the Resource Manager. This
> >> information is not otherwise discoverable by a VM: the Gunyah hypervisor
> >> core does not provide a direct interface to discover capability IDs nor
> >> a way to communicate with RM without having already known the
> >> corresponding message queue capability ID. Add the DT bindings that
> >> Gunyah adheres for the hypervisor node and message queues.
> >>
> >> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >> ---
> >>   .../bindings/firmware/gunyah-hypervisor.yaml  | 87 +++++++++++++++++++
> >>   MAINTAINERS                                   |  1 +
> >>   2 files changed, 88 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> >> new file mode 100644
> >> index 000000000000..f0a14101e2fd
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> >> @@ -0,0 +1,87 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Gunyah Hypervisor
> >> +
> >> +maintainers:
> >> +  - Murali Nalajala <quic_mnalajal@quicinc.com>
> >> +  - Elliot Berman <quic_eberman@quicinc.com>
> >> +
> >> +description: |+
> >> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
> >
> > How you end up with the node (applying an overlay) is not relavent to
> > the binding.
> >
> >> +  describes the basic configuration of the hypervisor. Virtual machines use this information to determine
> >> +  the capability IDs of the message queues used to communicate with the Gunyah Resource Manager.
> >
> > Wrap at 80. That is the coding standard still though 100 is deemed
> > allowed. And yamllint only complains at 110 because I didn't care to fix
> > everyones lines over 100.
> >
> >> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: gunyah-hypervisor-1.0
> >> +      - const: gunyah-hypervisor
> >
> > 2 compatibles implies a difference between the 2. What's the difference?
> > Where does '1.0' come from?
> >
>
> There's no difference. I thought the convention was to have
> device-specific compatible and the generic compatible. "device-specific"
> here would be specific to version of Gunyah since it's software.

No, that's just what people do because "vendor,new-soc",
"vendor,old-soc" seems to bother them for some reason. At the end of
the day, it's just a string identifier that means something. If
there's no difference in that 'something', then there is no point in
having more than one string.

You only need something specific enough to discover the rest from the
firmware. When that changes, then you add a new compatible. Of course,
if you want existing OSs to work, then better not change the
compatible.

> We do similar for firmware in the qcom,scm bindings and following that
> principle.

Always poor examples to follow...

Rob
