Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F76A2412
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBXWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBXWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:10:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB586A7B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:10:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s18so429660pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677276603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKiNDoTcLo8AHmzDD/VbxwypT47/9cT6va97Ac9AgMY=;
        b=O9pQEXPoCmuscd+Y83qXqMRZHe+GcnXGXrp4THxsSgF5Og4D5hfTVXD3doeSOvNCJZ
         4Pg4UEFl/Gd1jlII+04CNn1Dz5f8Eh5A0ekRyS7zXFwoisJscQBt5phs1SLbiNT/oViE
         qyZWlkju9YxhecVa0BrURwXlH53t2A1KGuMVTyLM8rv6DM4Oc29MVJyAqPl0aPGpPSVf
         e2XMFD3Y7m0z/x2D/9Jm90i6CscTiHUEqiVSGO/VI0OTQqjazzTt0a92aMPseruBokfJ
         tO/lCpLaJNJpMHrD1V8fVZuABMkrEp2HABWQ3JBL5D6Ws0M2l+XDoo+uLWLH4WJNy4lo
         68sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677276603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKiNDoTcLo8AHmzDD/VbxwypT47/9cT6va97Ac9AgMY=;
        b=AgeJDmXme2bsCqrHxU/CeQvZcrRcwDJbFIvb+QByxeSd8d3+wnYTUmKjsNk0m1Ti3T
         rjClRjK3t1dm2v5f5DMzqUTUU3obVgDHY6+fOU7AhRLPCHr8qWpDYz+6gPO4FeE58mx0
         U3XnPqUcQQMRgPNLm8Tz43xOfgRChd2M91aw7LtJjbrsumA0Hu1bOjIW8yhVMZVa5Mlw
         +OkommJT3qAx9jUFHsfpdg5jCcN6M1feTBoTyW4Ch6YcWEAerlTh198X/t9hHZ2fzhVd
         PRy+QyVgAb9SpsdKAL8v71/5p5brJGKwwCms32qMIZDt7dzsaLizoVODoehzNs++JpJQ
         R32w==
X-Gm-Message-State: AO0yUKVWRL2EBNox6YQ6OZvUy3/fFmiu+qvl+3TPTsnpA0ocGUauXQ47
        q3CwsTXjarH7MUebSKX0CbzTpEP7jq98uzEH5PYzsg==
X-Google-Smtp-Source: AK7set9fvB+d594qKHzyTXSRtF3EF3NCvZbapr3GBVlawJ8LB0XiUsnM/tBMnYbL7JACgGDRHHZ7XWr78Vx2BsJTMwY=
X-Received: by 2002:a63:8c55:0:b0:502:f5c8:a00c with SMTP id
 q21-20020a638c55000000b00502f5c8a00cmr2119837pgn.9.1677276603222; Fri, 24 Feb
 2023 14:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20230224195749.818282-1-sdalvi@google.com> <20230224195749.818282-2-sdalvi@google.com>
 <b50ab99f-e307-3a66-9198-85a71b012e5e@linaro.org> <CAEbtx1k-7TJPcd3+cueRoKLJcoUQLfF6nfOQFVfzB0YCUrbtqg@mail.gmail.com>
 <2e4964c1-0831-c156-3372-81a56f8d623e@linaro.org>
In-Reply-To: <2e4964c1-0831-c156-3372-81a56f8d623e@linaro.org>
From:   Sajid Dalvi <sdalvi@google.com>
Date:   Fri, 24 Feb 2023 16:09:51 -0600
Message-ID: <CAEbtx1=EGC+4LfSz+HqGzjJvF2O1vsB7a42ESTqbU8p5N-yUHg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
To:     Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel-team@android.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 3:29 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/02/2023 22:27, Sajid Dalvi wrote:
> > On Fri, Feb 24, 2023 at 2:40 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/02/2023 20:57, Sajid Dalvi wrote:
> >>> When the Root Complex is probed, the default behavior is to spin in a loop
> >>> waiting for the link to come up. In some systems the link is not brought up
> >>> during probe, but later in the context of an end-point turning on.
> >>> This property will allow the loop to be skipped.
> >>>
> >>> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> >>> ---
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>> index 1a83f0f65f19..0b8950a73b7e 100644
> >>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>> @@ -197,6 +197,14 @@ properties:
> >>>        - contains:
> >>>            const: msi
> >>>
> >>> +  snps,skip-wait-link-up:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      When the Root Complex is probed, the default behavior is to spin in a
> >>> +      loop waiting for the link to come up. In some systems the link is not
> >>> +      brought up during probe, but later in the context of an end-point turning
> >>> +      on. This property will allow the loop to be skipped.
> >>
> >> I fail to see how probe behavior is related to properties of hardware.
> >> You describe OS behavior, not hardware. This does not look like
> >> belonging to DT.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Thanks for your response Krzysztof.
> > The hardware configuration of the system determines whether an
> > endpoint device is available during host init. If it isn't available
> > on a particular and dedicated pcie interface, we should skip waiting
> > for the link to be up. For other interfaces, possibly even on the same
> > system, where a device is present or maybe present we should wait for
> > the link to come up.
>
> Keep discussions public.
>
> Your commit and property description mentions probe, which is nothing
> related to hardware. Why the device would not be available during host
> init (I understand we do not talk about hotplug as it is already
> supported by Linux) in a way it is hardware property, not OS?
>
> Best regards,
> Krzysztof
>

+ everyone else I mistakenly didn't reply to earlier

If I understand you correctly, the usage of probe is misleading
because it doesn't have anything to do with the hardware.
So your recommendation is to replace probe with device init, in the
description of the property and the commit message?

Sajid
