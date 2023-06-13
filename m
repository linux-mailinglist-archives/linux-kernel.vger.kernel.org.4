Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A772E418
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjFMN2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFMN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87357E5;
        Tue, 13 Jun 2023 06:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B5F6363A;
        Tue, 13 Jun 2023 13:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2481DC4166A;
        Tue, 13 Jun 2023 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686662929;
        bh=Tq282l+C2Dr1lf2RPS2aM+A8Oyr7+h44UW4Jg8xfhbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KcgaJ6b3WJUNmYRSAfZ6WsF8uW14i0pHGUqfQ8qbVrnwHv8mkwzliNY52bKdNkzyw
         8oaUyvyCC780GZKnZH7KC9oC6otccI0eauPbGL9IgmQtnO3R5aSpv5ARer1rB32lkF
         2d4uKUE5XCBpIUm5U4BSU4DCrQpbGaie4LwHbJj1Siu5+1zT/muUy+h3szYViKJAFw
         oVzVrwW8F/o7VbqwygRlpxQFJUoAcazKCkvWPkHe6zjm75poQ3WFbTO3ZlMYb9/Dkz
         pw/ooL9JV7uYkoyjm75SLOFnSjhj13q03rSWUvGniN9XsFR1qwltOw2Ujx5sQGuDZH
         pj3hxljD5e64g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6734705e87.2;
        Tue, 13 Jun 2023 06:28:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDyFb6J1jrxv+FAqojxdGJaE5ek1QR3wg48tz8JqohieqJ2Dz/R0
        7QT2NaheEYV5SC+NbJVD+uUSthGcAasXQLxdtQ==
X-Google-Smtp-Source: ACHHUZ7xEzfSwXxw+hZJuk+2aAUcZRqN2kDCLuPdkshb6lV2DAnOexM7QB+9J/ErB3X9G0jVZAtdNv9Xt6ie8WSLIls=
X-Received: by 2002:a2e:9595:0:b0:2b3:3de8:7330 with SMTP id
 w21-20020a2e9595000000b002b33de87330mr747015ljh.29.1686662926823; Tue, 13 Jun
 2023 06:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy> <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy> <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud> <20230530-duller-reset-a34ae111f207@wendy>
 <20230608191537.GA3233857-robh@kernel.org> <20230608-cobbler-giving-e0fac2185e11@spud>
 <20230612-relic-fetal-1beeae3455aa@spud>
In-Reply-To: <20230612-relic-fetal-1beeae3455aa@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Jun 2023 07:28:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+CJ-mEcEujd5Sk4SLvgTfUX1A7NRXYcMDqkoViDYxTXw@mail.gmail.com>
Message-ID: <CAL_Jsq+CJ-mEcEujd5Sk4SLvgTfUX1A7NRXYcMDqkoViDYxTXw@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 3:23=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Rob,
> Before I press on with more versions...
>
> On Thu, Jun 08, 2023 at 08:30:28PM +0100, Conor Dooley wrote:
> > On Thu, Jun 08, 2023 at 01:15:37PM -0600, Rob Herring wrote:
> > > On Tue, May 30, 2023 at 03:12:12PM +0100, Conor Dooley wrote:
> > > > On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> > > > > On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:
> > > >
> > > > > >
> > > > > > Why not just have something like
> > > > > >
> > > > > > mycpu {
> > > > > >       ...
> > > > > >       riscv,isa {
> > > > > >               i;
> > > > > >               m;
> > > > > >               a;
> > > > > >               zicsr;
> > > > > >               ...
> > >
> > > I prefer property names be globally unique. The tools are geared towa=
rds
> > > that too. That's largely a symptom of having 0 type information in th=
e
> > > DT.
> > >
> > > For example if you had an extension called 'reg', it would be a probl=
em.
> >
> > Per the current ISA rules, that'd not be valid. But then again, I do
> > have trust issues & it's not like "reg" is the only property name in DT
> > land.
>
> ...you say "prefer" here. Is that a NAK, or a "you keep the pieces"?

Don't do the above node.

Rob
