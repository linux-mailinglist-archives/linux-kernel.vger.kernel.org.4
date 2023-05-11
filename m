Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574616FEE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjEKJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjEKJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:07:33 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD7555A2;
        Thu, 11 May 2023 02:07:29 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id D614A41D13BF;
        Thu, 11 May 2023 10:07:27 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 11 May 2023 10:07:27 +0100
Date:   Thu, 11 May 2023 10:07:27 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] mips: dts: ralink: Clarify usage of MT7621 ethernet phy
 arguments
Message-ID: <ZFywT5/S3gICedl8@bart.dudau.co.uk>
References: <20230509200032.308934-1-liviu@dudau.co.uk>
 <a5fdd37e-6f42-2f37-357f-ad5bb082fa7d@arinc9.com>
 <ZFvaxVwVOnzVofrU@bart.dudau.co.uk>
 <CAMhs-H8yu9HFte0x53u_Mq8vFzS1ZOKxxR7H=tszfijhtVrU=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H8yu9HFte0x53u_Mq8vFzS1ZOKxxR7H=tszfijhtVrU=A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 06:13:41AM +0200, Sergio Paracuellos wrote:
> Hi Liviu,

Hi Sergio,

> 
> On Wed, May 10, 2023 at 7:56 PM Liviu Dudau <liviu@dudau.co.uk> wrote:
> >
> > Hi Arınç,
> >
> > On Wed, May 10, 2023 at 02:59:44PM +0200, Arınç ÜNAL wrote:
> > > On 9.05.2023 22:00, Liviu Dudau wrote:
> > > > The device tree uses numbers as arguments to the phys property that are
> > > > confusing for newcomers. Define names for the values and use them in the
> > > > device tree.
> > > >
> > > > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> > >
> > > You should document this on
> > > instead of
> > > doing this. Under the phys property, add 'description:' and explain this.
> >
> > There is already some sort of explanation under
> > Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml, so I'm
> > not sure what I'm improving by adding new text in the /pci/ section.
> >
> > Maybe I haven't explained properly in the commit message, this is meant to
> > give a name to the 1 and 0 values used in the device tree, not to clarify
> > any perceived missing documentation.
> 
> What is that useful for if the bindings are well documented? The
> description in the
> 'Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml' file
> for the '#phy-cells'
> property is already telling you what that cell is used for. It is
> obvious that zero means not dual ported and one means dual ported.
> So for me there is no need to add anything extra but in case you want
> to clarify anything you should modify binding documentation not the
> device tree file at all.

Understood. Then please feel free to ignore this patch.

Best regards,
Liviu

> 
> Thanks,
>     Sergio Paracuellos
> >
> > >
> > > Arınç
> >
> > Best regards,
> > Liviu

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
