Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A370B2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjEVBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjEVBhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709ECDE;
        Sun, 21 May 2023 18:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB0F618FA;
        Mon, 22 May 2023 01:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6E5C433A8;
        Mon, 22 May 2023 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684719421;
        bh=lv6wouIBbbs+ZUnfY6iszC49L7vXimaT8vWL2XojXUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FCmviC3wl9npZoyPR9/+xP/t2umpo7tSwAklN5q4WZD+YwBWs4UPFLUyfsOLWs3ye
         t7oJdiEnEaiCwdkgoKtffidLtwNE/oRIXag03eVnT3JEvnYGJ32WPFszueN+ytzOXA
         3kBDlLNkEBbjmM00A7bn0PBlrTSSebh0MH49H18d6ac3snWaSngprGiq16L6OWjxRf
         wMp/bo5dT7sLCjp9Nznq/HrgMzwn0dBLDOPJqbvOdlhSguDnIlnkWD1EmhaRze8cey
         mI2Ni8rm3V6NBQgTr2rhx0AMX0aUoo97CULhJdOvWTe5ENW7aMfdSu+3QZeeD63lVB
         1xw2meoBa0JHA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-510c734fa2dso6230363a12.0;
        Sun, 21 May 2023 18:37:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDwdCtgmxUN+5dkJMd6HPqIqlJ7yinNje/uE3YkK+b+lnERz2P5e
        9unC7RbcDpiscZuyDVj37PsXFZYwtYElQUhmk9k=
X-Google-Smtp-Source: ACHHUZ6CO1iiQGsq6FLHKPtTopDUygqukzZyE+vzpTFrZB3aFb7iQCtAfVLKr/WwESBwjwhnp8zhJbdCNmBWQiBlpY4=
X-Received: by 2002:aa7:c452:0:b0:504:81d4:118d with SMTP id
 n18-20020aa7c452000000b0050481d4118dmr8659697edr.3.1684719419571; Sun, 21 May
 2023 18:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud> <ZFkiotPacIMUghDP@xhacker>
 <20230508-unmoved-unvocal-9a6c5fc0c629@spud> <CAJF2gTSFm32ozEDy_3zvrf05USJ8FxCsaGK-2FbkJQsPUDQXmA@mail.gmail.com>
 <20230521-licorice-follicle-2f83e82f8bce@spud>
In-Reply-To: <20230521-licorice-follicle-2f83e82f8bce@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 22 May 2023 09:36:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTReEW3onRyAXvasX748JuyXJeLU3nQpmQMZRrkS2=ANjg@mail.gmail.com>
Message-ID: <CAJF2gTReEW3onRyAXvasX748JuyXJeLU3nQpmQMZRrkS2=ANjg@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 1:08=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, May 21, 2023 at 11:37:58PM +0800, Guo Ren wrote:
> > On Tue, May 9, 2023 at 12:44=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Tue, May 09, 2023 at 12:26:10AM +0800, Jisheng Zhang wrote:
> > > > On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> > > > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > > > >
> > > > > > +         c910_0: cpu@0 {
> > > > > > +                 compatible =3D "thead,c910", "riscv";
> > > > > > +                 device_type =3D "cpu";
> > > > > > +                 riscv,isa =3D "rv64imafdc";
> > > > >
> > > > > Does this support more than "rv64imafdc"?
> > > > > I assume there's some _xtheadfoo extensions that it does support,
> > > > > although I am not sure how we are proceeding with those - Heiko m=
ight
> > > > > have a more nuanced take.
> > > > >
> > > > > > +         reset: reset-sample {
> > > > > > +                 compatible =3D "thead,reset-sample";
> > > > >
> > > > > What is a "reset-sample"?
> > > >
> > > > This node is only for opensbi. The compatible string is already in
> > > > opensbi. Do we also need to add dt-binding for it in linux?
> > >
> > > If it's to be included in the kernel's dts, then yes, you do need a
> > > dt-binding. If you remove it, then you don't :)
> > >
> > > That said, "thead,reset-sample" is a strangely named compatible, so i=
f
> > > you do keep it it may end up needing a rename!
>
> > How about compatible =3D "thead,reset-th1520" ?
>
> "vendor,soc-function" is more typical, but "reset" is usually used for
> reset controllers of which this isn't as far as I can tell.
> I commented on the v2, hoping that you might actually know what the IP
> block' full/proper name is:
> https://lore.kernel.org/all/20230518-driving-secluding-793b3192776e@spud/
Oh, sorry, I focused on s64ilp32 these days and missed that. I would
reply to that thread.

>
> Do you?
>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
