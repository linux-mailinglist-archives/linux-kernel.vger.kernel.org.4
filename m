Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0086F071F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbjD0OS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjD0OS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472F199B;
        Thu, 27 Apr 2023 07:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFEC863DA0;
        Thu, 27 Apr 2023 14:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58795C433A1;
        Thu, 27 Apr 2023 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682605106;
        bh=ikojoOEpntI4XF5hPzrBSqDGpExPjhMyp3xsyynei8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=enO8fSZ5q0CFS2ixGiftSx/yfnsJ00xd688Nx4bL+0K7x1tKxrjOuoSk65HbRUuNR
         05TPyZdzLSzXAbcp+psybufI8ILZCHeZZyDD+Oq6AtnXaTBZwnJr7cMardkg1HfZNB
         6x/2zZY9KHX2qnDKhhVD0Yxw7qrOvaCbx4hfyCQHz9DtblxgTAfMU5JnzywmuSxHJD
         FUz/bEHiGsYqzpj2x5MGgH5+Ll2Z4j+qZupTuUbiIS6uKISyBy8i7xO8JaNfny4YhW
         2ZShEgtAanQCC39RbebcePzQFc4GmF0N2H/932gn0PC+6PoSp5ce/n0TnFnxqJ8hcS
         cTLo57VdPRAtA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54fe08015c1so104171567b3.3;
        Thu, 27 Apr 2023 07:18:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDxnPGZ8FBIcyQbTf4mXYtguE4wFoh+GtF752ZBG00gyyYsyL6XW
        V2JSr2CQ56DIcSTSbhzI8LgISZZHgm+rFXaAnQ==
X-Google-Smtp-Source: ACHHUZ7eCffK6AlPYzWD9kLSzJbn9o1jfSRj+nBabLEOgJsgrwxxzdqzxv1W+5iHuPvk9JuP3kQGVQUd9STJ33Cz4/M=
X-Received: by 2002:a0d:c582:0:b0:552:a63e:18d1 with SMTP id
 h124-20020a0dc582000000b00552a63e18d1mr1094504ywd.52.1682605105314; Thu, 27
 Apr 2023 07:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230412060843.149283-1-piyush.mehta@amd.com> <20230418184026.GA2099329-robh@kernel.org>
 <MN2PR12MB4333134E60DC454D29BFE2F588609@MN2PR12MB4333.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4333134E60DC454D29BFE2F588609@MN2PR12MB4333.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Apr 2023 09:18:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com>
Message-ID: <CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to
 include hibernation interrupt
To:     "Mehta, Piyush" <piyush.mehta@amd.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 8:28=E2=80=AFAM Mehta, Piyush <piyush.mehta@amd.com=
> wrote:
>
> Hi
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, April 19, 2023 12:10 AM
> > To: Mehta, Piyush <piyush.mehta@amd.com>
> > Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
> > michal.simek@xilinx.com; linux-usb@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Paladugu, Siva Durga Prasad
> > <siva.durga.prasad.paladugu@amd.com>; linux-arm-
> > kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-name=
s to
> > include hibernation interrupt
> >
> > On Wed, Apr 12, 2023 at 11:38:43AM +0530, Piyush Mehta wrote:
> > > The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> > > Added host mode interrupts and "usb-wakeup" interrupt-names optional
> > > property in the binding schema to capture remote-wakeup and connect/
> > > disconnect event in the hibernation state.
> > >
> > > Xilinx dwc3-core uses "host" and "otg" interrupts interrupt-names DT
> > > properties from dwc3-core.
> >
> > Is wakeup really not implemented in the DWC3 core, but outside it?
>
> Wakeup is implemented inside the dwc3-core.

Then it goes in the dwc3 node.

> Initially we planned to implement wakeup interrupt name/interrupt optiona=
l property in the dwc3-core.
> However, looking at other vendor wakeup interrupt implementation (Commit:=
 dd566faebe9f dt-bindings: usb: qcom,dwc3: refine interrupt requirements)
> we moved wakeup property to xilinx USB binding.

That one looks like the phy implements wake-up? I don't know really,
but doesn't seem like one to copy.

Rob
