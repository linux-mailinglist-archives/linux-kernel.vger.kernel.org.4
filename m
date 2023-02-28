Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868296A5E39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjB1RcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB1RcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:32:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A0241E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 09:32:06 -0800 (PST)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E50B3F5A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677605523;
        bh=JFnTwWesuP+6/jfIdHg+eoaheKqjKyvzVA2hbRKkEWA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JHUTLnA8a0rD+a+E7w1nF/h//v9ipdQysHnXincR+6SVaX1MMppwqsjnmrA3HfF1Q
         onoWN4jiRPAjL/YmawmvGmrpwctxiJpxHgXB6MVdSZus8cJn9hiSwxHIXcZfY4HBYO
         ebotSjC1TTSp8JxwMswRbsri3qC04mgnSH8YOVp2decyhhpE1UDSoPcXM/EbDWXjbu
         /tP9/HH/cotRd4P2lKq9euhVSDNEm/GllYtOc4sOO2PAIanC3zxRBDM/3iM1iys6GL
         AArD5uPv16OpA6xytgHQrx+hFt1y07nYlGF0xAyWdf4iv4WwPHyywrKAt3TIzX8lDD
         mUZPODUdKjrXQ==
Received: by mail-qk1-f197.google.com with SMTP id 19-20020a370c13000000b007428253bb55so6394341qkm.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 09:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFnTwWesuP+6/jfIdHg+eoaheKqjKyvzVA2hbRKkEWA=;
        b=M2Vp6krhP+ESwm+QEFgPqDrN01kQWy9WiKGecO5Nz2SgJ/pbrFBOAWNU3I+nxcpkpr
         f1+1YzN82PC49Wkt1Yn31ztrMno0/EiQ2xwIKJB8+BLI+W2VMhgK9Lq58cj23ABaQLgn
         QDnYVTRZ0xdb+JmhqP4FpJ1vLByjiytMsHKI6Y2YaNVxH3J4H2RQZdASdNv48Vg/4cBD
         P+fBOD5ptfmaPMiZ2u+jsNKHkIkrqOKqCO2QZcBcqPHtSMvGPvoypolWUDn3G/fFYNSh
         2c40UmcpK6OWTw65X+uTKjRj6S0nLN8Aw8wdmRWTWylbFhqlOp8iT9RTwwTyWchWvvAO
         gEMw==
X-Gm-Message-State: AO0yUKWecxRMLy4qmDvLZAovRo+xT7MT2YQGXwSpfcEHVpv53KOKIFH8
        1oSZbpIp8IbxIKLciPHt8tKhFU1G6Bx01WnhBPGmdb7U8f9yArsRgk8IJde+Sc/h+z4Ucas3dxz
        Hr5QlSVMaAZOEI9m/96k4jlfUM47Rkn8dlYGj7Ak0JCQHIw30m2ZiiVishg==
X-Received: by 2002:a05:6214:4a4d:b0:571:1409:5ee1 with SMTP id ph13-20020a0562144a4d00b0057114095ee1mr1012578qvb.0.1677605522544;
        Tue, 28 Feb 2023 09:32:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9t/TkmnqfqOwJJveS07Su1pSm1G5Dd3UI8Jt8Yy93BTw9Pdg4PTV8e7Rr83zYdh2FnCK7NZUIMOb2IChn3os8=
X-Received: by 2002:a05:6214:4a4d:b0:571:1409:5ee1 with SMTP id
 ph13-20020a0562144a4d00b0057114095ee1mr1012568qvb.0.1677605522237; Tue, 28
 Feb 2023 09:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com> <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com> <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com> <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
 <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
 <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org> <CAJM55Z8dR4TDJNeO-qiS9CurfCWM1ccNigOA1fDb7S1VKCxv2Q@mail.gmail.com>
 <be911895-4944-e983-1af5-b11ff5e8e7cc@linaro.org>
In-Reply-To: <be911895-4944-e983-1af5-b11ff5e8e7cc@linaro.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 28 Feb 2023 18:31:46 +0100
Message-ID: <CAJM55Z99FZteGkzFC-cSCrTKD_qBn8huzcnynM9Xd7-4F_9rGQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 17:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 28/02/2023 15:59, Emil Renner Berthing wrote:
> > On Tue, 28 Feb 2023 at 12:28, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 28/02/2023 12:02, Emil Renner Berthing wrote:
> >>> On Tue, 28 Feb 2023 at 11:40, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 28/02/2023 10:05, William Qiu wrote:
> >>>>>
> >>>>>
> >>>>> On 2023/2/28 6:29, Rob Herring wrote:
> >>>>>> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2023/2/21 7:43, Rob Herring wrote:
> >>>>>>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> >>>>>>>>> Add documentation to describe StarFive System Controller Registers.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >>>>>>>>> ---
> >>>>>>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
> >>>>>>>>>  MAINTAINERS                                   |  5 ++
> >>>>>>>>>  2 files changed, 56 insertions(+)
> >>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>>>> new file mode 100644
> >>>>>>>>> index 000000000000..fa4d8522a454
> >>>>>>>>> --- /dev/null
> >>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>>>> @@ -0,0 +1,51 @@
> >>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>>>>>> +%YAML 1.2
> >>>>>>>>> +---
> >>>>>>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> >>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>>>>> +
> >>>>>>>>> +title: StarFive JH7110 SoC system controller
> >>>>>>>>> +
> >>>>>>>>> +maintainers:
> >>>>>>>>> +  - William Qiu <william.qiu@starfivetech.com>
> >>>>>>>>> +
> >>>>>>>>> +description: |
> >>>>>>>>> +  The StarFive JH7110 SoC system controller provides register information such
> >>>>>>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> >>>>>>>>> +
> >>>>>>>>> +properties:
> >>>>>>>>> +  compatible:
> >>>>>>>>> +    items:
> >>>>>>>>> +      - enum:
> >>>>>>>>> +          - starfive,jh7110-stg-syscon
> >>>>>>>>> +          - starfive,jh7110-sys-syscon
> >>>>>>>>> +          - starfive,jh7110-aon-syscon
> >>>>>>>>
> >>>>>>>> Is 'syscon' really part of what the blocks are called? Is just 'stg',
> >>>>>>>> 'sys' and 'aon' not unique enough?
> >>>>>>>>
> >>>>>>>> Rob
> >>>>>>> Hi Rob,
> >>>>>>>
> >>>>>>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
> >>>>>>> controller, so 'syscon' is added to avoid confusion.
> >>>>>>
> >>>>>> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2
> >>>>>> different h/w blocks and unrelated to each other? Or 'syscrg' is the
> >>>>>> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child
> >>>>>> of 'sys-syscon' or possibly just all one node. Please provide details on
> >>>>>> the entire h/w block so we can provide better input on the bindings.
> >>>>>>
> >>>>>> Rob
> >>>>>
> >>>>> Hi Rob,
> >>>>>
> >>>>> It's my description that's problematic.'syscon' here refers to the hardware module
> >>>>> inside our JH7110, which is different from the syscon interface in linux. The syscon
> >>>>> I added now uses the syscon interface of linux to read and write the syscon register
> >>>>> in our JH7110. So we decided to name it that way.
> >>>>
> >>>> You didn't really answer Rob's questions.
> >>>>
> >>>> Also, syscon is Linux term, so are you sure hardware module is called
> >>>> like this? Hardware engineers took pure Linux name and used it?
> >>>
> >>> Yes, from the documentation I could find[1] there are CRG blocks
> >>> (Clock and Reset Generator) and SYSCON blocks:
> >>> SYS CRG
> >>> STG CRG
> >>> AON CRG
> >>> SYS SYSCON
> >>> STG SYSCON
> >>> AON SYSCON
> >>>
> >>> The CRG blocks contain registers to control clocks and resets that
> >>> follow a pattern used by the clock and reset drivers. The SYSCON
> >>> blocks just seem to contain registers to control whatever didn't fit
> >>> in any other blocks, but might be vaguely related to the peripherals
> >>> that run off clocks controlled by the corresponding CRG block.
> >>
> >> The memory map [1] suggests these are indeed separate address spaces,
> >> e.g. AON CRG, AON SYSCON and AON GPIO, but now I would argue that this
> >> might be still one device - AON (or STG, SYS). Just like PCIE0 has four
> >> address spaces, it does not mean you have four separate PCIE0 devices.
> >> You have only one PCIE0, just like you have only one AON, one STG and
> >> one SYS (System).
> >
> > I see what you mean, but if you look into what the registers in the
> > SYSCON blocks actually do it's not clear to me that they should be
> > grouped with the clocks/resets any more than say the pinctrl/GPIO
> > node. Maybe it's my fault for not giving you the full picture. Eg. for
> > "system" and "always-on" there are blocks:
> >
> > SYS CRG
> > SYS SYSCON
> > SYS IOMUX
> > AON CRG
> > AON SYSCON
> > AON IOMUX
> >
> > ..and it really don't see why eg. SYS CRG and SYS SYSCON should be
> > thought of as one device, but not include SYS IOMUX then.
>
> ... include sys iomux as well, just like GPIO is included for AON.

This would at least take the view that the blocks named alike should
be thought of as a single device to its logical conclusion.
Unfortunately we're a bit late for that. The pinctrl/GPiO bindings and
drivers are already merged:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6e0a660097dcdb80e7c5c859eb12f776060b02e

> >
> > As an examly the SYS SYSCON includes registers to control:
> > - remapping of different peripherals from SD controller to video encoders
> > - voltage select for certain GPIO pins
> > - phy interface selection for ethernet and CAN
> > - QuadSPI delay chain and SRAM configuration
> > - PLL configuration
> > - endian selection for the SD controller
> >
> > To me this is pretty much exactly described by the syscon device tree binding:
> > "System controller node represents a register region containing a set
> > of miscellaneous registers. The registers are not cohesive enough to
> > represent as any specific type of device. [..]"
> > In any case it's clear that however the SYSCON blocks are represented
> > in the device tree, a driver for it would need to export registers in
> > the SYSCON block for other drivers to use.
>
> You started entire sentence with "but" so you disagree but with what
> exactly? The naming? But syscon is fine - hardware manual calls it like
> that.
>
> The point was that AON is one device (consisting of multiple blocks).

Yes, and what I'm trying to explain is that I'm not convinced that's
the right model. The CRG blocks and IOMUX blocks don't really have
anything in common other than the name StarFive gave them. You can
argue that the CRG and IOMUX blocks overlap with the corresponding
SYSCON block, but so do a lot of other peripherals as you can see from
the list above.

I think the IOMUX and SYSCON blocks are just named after the clock
domain they're under, but a lot of other peripherals are also under
the SYS and AON clock domains and we don't model them as one big
device.

/Emil

>
> Best regards,
> Krzysztof
>
