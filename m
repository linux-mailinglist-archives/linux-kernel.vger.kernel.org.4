Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D094A6FEA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEKEOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEKENy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:13:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B8546B6;
        Wed, 10 May 2023 21:13:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6a5f7341850so5481355a34.2;
        Wed, 10 May 2023 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683778432; x=1686370432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDH9QUcCMeMca23FE1jt1bCtNZnalbDq2HP2ml5fhuA=;
        b=DaqmcVByATrZIpuCbgOAbaBMBK6Ujb8MQtVUwCe1la3a/N6IykewNuuaOyF4eKVqs/
         q6s8VVyBODKC6bXGm0/OTBUhbb9tuJkS37zkhX5+/9b6oUV9F3TQuyIp6JDPuXziY7A1
         GTBTzhf/Me/uLvgKQ8j9+CioIzpjEnkb3AK2Da1nbxmeXQWJ+RLsHZFuUt34Q43AWwEt
         dGDPLDDSOTnPl4mZbJLHWhK4MhsOAwugq7wDY0Smf61NvpA7S+pcH+DgfK6Tng93i/iV
         zL5umxC1ylT5CPW2cfSHNlzy156kNJHQPrZck3UC8fu8pK6SCfvii1K9U1v6SzMgWtLp
         +3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683778432; x=1686370432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDH9QUcCMeMca23FE1jt1bCtNZnalbDq2HP2ml5fhuA=;
        b=DeQD2JoyrHCw3vfIipexMX2q2CO+NQI76O5EuIFw4RcDBt8K9L729fCvsmaS9tgpHS
         l6DB4IQJAr1rOP41aanhe1DgiX4FtphSs+KmcsjcqrHRCODHzdY4DuIXLRG5wJAlEY10
         fY873wICuNBHQVwBm4niXM24/DRdVtlYL0DGOLPwQVV5/90TIHijkGoCdild4TMVUSWP
         uk/t6ePe60nWhaEz8kfWJlfF9lz6w5MjM887hKvUstECJ46OAQt32oU3oTmGDzI9uMP6
         NrWQz5EX+Pebn6VZMxi7PygBrZePr/NVjH3SJyeVpAJpbhij7/Zzxzl446W3nv5jiLem
         zGXw==
X-Gm-Message-State: AC+VfDycWbLtnfetaU56HnxIbTK/ttbOoMiKQJ9IN6AiAqvb7z5MW/FR
        EejxG5jaZ/rnayHdwRteh27bGcOtHJiQsvBdI4JfSdIUgJ0=
X-Google-Smtp-Source: ACHHUZ5cNk4FiELtWYVUIm9lDNspsAsjoItDP/Zs0NmARUdRJiYDeURdOZ41UBfnJnA9NoVbUzB/8Z9dxm+GJADBxpw=
X-Received: by 2002:a54:440d:0:b0:38c:647b:e298 with SMTP id
 k13-20020a54440d000000b0038c647be298mr4057148oiw.14.1683778432206; Wed, 10
 May 2023 21:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509200032.308934-1-liviu@dudau.co.uk> <a5fdd37e-6f42-2f37-357f-ad5bb082fa7d@arinc9.com>
 <ZFvaxVwVOnzVofrU@bart.dudau.co.uk>
In-Reply-To: <ZFvaxVwVOnzVofrU@bart.dudau.co.uk>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 11 May 2023 06:13:41 +0200
Message-ID: <CAMhs-H8yu9HFte0x53u_Mq8vFzS1ZOKxxR7H=tszfijhtVrU=A@mail.gmail.com>
Subject: Re: [PATCH] mips: dts: ralink: Clarify usage of MT7621 ethernet phy arguments
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On Wed, May 10, 2023 at 7:56=E2=80=AFPM Liviu Dudau <liviu@dudau.co.uk> wro=
te:
>
> Hi Ar=C4=B1n=C3=A7,
>
> On Wed, May 10, 2023 at 02:59:44PM +0200, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote=
:
> > On 9.05.2023 22:00, Liviu Dudau wrote:
> > > The device tree uses numbers as arguments to the phys property that a=
re
> > > confusing for newcomers. Define names for the values and use them in =
the
> > > device tree.
> > >
> > > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> >
> > You should document this on
> > instead of
> > doing this. Under the phys property, add 'description:' and explain thi=
s.
>
> There is already some sort of explanation under
> Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml, so I'=
m
> not sure what I'm improving by adding new text in the /pci/ section.
>
> Maybe I haven't explained properly in the commit message, this is meant t=
o
> give a name to the 1 and 0 values used in the device tree, not to clarify
> any perceived missing documentation.

What is that useful for if the bindings are well documented? The
description in the
'Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml' file
for the '#phy-cells'
property is already telling you what that cell is used for. It is
obvious that zero means not dual ported and one means dual ported.
So for me there is no need to add anything extra but in case you want
to clarify anything you should modify binding documentation not the
device tree file at all.

Thanks,
    Sergio Paracuellos
>
> >
> > Ar=C4=B1n=C3=A7
>
> Best regards,
> Liviu
>
> --
> Everyone who uses computers frequently has had, from time to time,
> a mad desire to attack the precocious abacus with an axe.
>                                   -- John D. Clark, Ignition!
