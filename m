Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B370AE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEUPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291FE4;
        Sun, 21 May 2023 08:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8B560F15;
        Sun, 21 May 2023 15:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32B6C433EF;
        Sun, 21 May 2023 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684683491;
        bh=rsSKWKgzrdYi2+QrzmaBdQMUeBWsskCgLQSydAupoTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qwf0/ZmwhQxctn5etWjGtdfBtb/GIBXYMstyBmUVcWUeuK97EZ9JtBxCOg6P6JGFP
         16PgRDFIPKLJuGMutO6bTM+dG5HsRzlCTRLvZ2owrreWQoZYYq3ZW2PcJMOiYEtJ6+
         ts1y5yoiiy3k9zYJ3X2Zop7FRhEjwfRotnH1Azlq6IYVacEr0NLfi6jFiUfPYbvC+F
         0AJXjTSyg+sm0GhjLhwXO9aIKfzms+4vSrNnreCzacw5AsmUeRlz+UqO/hAj9HSURD
         QpK7ojClyvqWNL5mBqVzOT6ettQeyT3azhbX3dg4n7dRVJy032xdUjV52KJTgoiram
         3ZxtzDuKIwQHQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-96fb45a5258so166601566b.2;
        Sun, 21 May 2023 08:38:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDw5WLlOjo2Qe3gg3+bIPby9M0hxM9VrDIqsunHoj/9AlSp9G89/
        mAOu/Xh1KWhoxMpdMDdytp66pj/h1zk91yG2ZO8=
X-Google-Smtp-Source: ACHHUZ5CViNXL356WnB7eKprukgeq44eBPyn5myooMQtHmUvgxxC0NILsR5aCx0KAsnQjkJfL90u7zWhy3vKUUMJml8=
X-Received: by 2002:a17:907:26c3:b0:94f:2a13:4e01 with SMTP id
 bp3-20020a17090726c300b0094f2a134e01mr7498092ejc.74.1684683490097; Sun, 21
 May 2023 08:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud> <ZFkiotPacIMUghDP@xhacker> <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
In-Reply-To: <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 May 2023 23:37:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSFm32ozEDy_3zvrf05USJ8FxCsaGK-2FbkJQsPUDQXmA@mail.gmail.com>
Message-ID: <CAJF2gTSFm32ozEDy_3zvrf05USJ8FxCsaGK-2FbkJQsPUDQXmA@mail.gmail.com>
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

On Tue, May 9, 2023 at 12:44=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, May 09, 2023 at 12:26:10AM +0800, Jisheng Zhang wrote:
> > On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > >
> > > > +         c910_0: cpu@0 {
> > > > +                 compatible =3D "thead,c910", "riscv";
> > > > +                 device_type =3D "cpu";
> > > > +                 riscv,isa =3D "rv64imafdc";
> > >
> > > Does this support more than "rv64imafdc"?
> > > I assume there's some _xtheadfoo extensions that it does support,
> > > although I am not sure how we are proceeding with those - Heiko might
> > > have a more nuanced take.
> > >
> > > > +         reset: reset-sample {
> > > > +                 compatible =3D "thead,reset-sample";
> > >
> > > What is a "reset-sample"?
> >
> > This node is only for opensbi. The compatible string is already in
> > opensbi. Do we also need to add dt-binding for it in linux?
>
> If it's to be included in the kernel's dts, then yes, you do need a
> dt-binding. If you remove it, then you don't :)
>
> That said, "thead,reset-sample" is a strangely named compatible, so if
> you do keep it it may end up needing a rename!
How about compatible =3D "thead,reset-th1520" ?

>
> Cheers,
> Conor.
>


--=20
Best Regards
 Guo Ren
