Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BC74F140
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjGKOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjGKOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102F10CA;
        Tue, 11 Jul 2023 07:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0390D61516;
        Tue, 11 Jul 2023 14:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AA9C433CB;
        Tue, 11 Jul 2023 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084569;
        bh=wPU4WgrILHi9+5F2DlhzPw9Lp0u+27HoJUb3pFKm1oY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RCuZZ7PXyIN3eOhGs1bf0ErA04156k9Ond9Tt1No7pzS2UVgv5CBkmePw7dDii6xn
         J+DCbc98kpLrJqwFB9eR8mRpuIIiv7GlvBdbOQSS6FXDOyaeNGkDbF+EK2HrNdroeL
         D3KHqS3rFWHxUf3cDYoUyolysl/c+Ve4O9pASw++RfxReTh2WliugG/VTRBisxonnx
         TKxvWb75v4UOiVV8SVOwlp3RzLjpAAvSm7StvrDY1aRrGuuB9EjiuSf595RzfBUyVA
         TsBCOrEZpdVEIhmZzsL0gqiyax+JdDihy3MfT/FLDVFl826dFDBdqWylF3LT9Vh+PG
         Nu0EUC32hDt3A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso89775321fa.0;
        Tue, 11 Jul 2023 07:09:29 -0700 (PDT)
X-Gm-Message-State: ABy/qLbzKUYjcCt4X5WCk9bi8saNLT2BGmI5+eHzt6gnAFobVXnFBQyn
        Rtl+EXDN82d3L5oUfMGChWqbaOqSdKlw+1Ks5A==
X-Google-Smtp-Source: APBJJlFEr5SnwtzLsObTkneUOhTe4Giozatn3QjuQu5+oxJvELnDikg/9hzm9xsBK89Dbapr0ULFsJF5oBzL6l5rJHE=
X-Received: by 2002:a2e:7a04:0:b0:2b6:eb5a:6504 with SMTP id
 v4-20020a2e7a04000000b002b6eb5a6504mr13751911ljc.18.1689084567351; Tue, 11
 Jul 2023 07:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210646.868758-1-robh@kernel.org> <20230710-underling-angelfish-c47d363a59f5@spud>
 <CAL_Jsq+5mtgCAfFZOZTUjqFLW0DM5A6exD+PbznO71A8SDyyTA@mail.gmail.com> <20230710-octane-disarray-44b363c02f73@spud>
In-Reply-To: <20230710-octane-disarray-44b363c02f73@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Jul 2023 08:09:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBTGeyJgCgPjQL1SdMc73=DBWRRmcsO6YXQkPSAAvWXQ@mail.gmail.com>
Message-ID: <CAL_JsqLBTGeyJgCgPjQL1SdMc73=DBWRRmcsO6YXQkPSAAvWXQ@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT schema
To:     Conor Dooley <conor@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 10, 2023 at 12:20=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Jul 10, 2023 at 12:03:38PM -0600, Rob Herring wrote:
> > On Mon, Jul 10, 2023 at 11:57=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Fri, Jul 07, 2023 at 03:06:46PM -0600, Rob Herring wrote:
> > > > Convert the OmniVision OV7251 Image Sensor binding to DT schema for=
mat.
> > > >
> > > > vddd-supply was listed as required, but the example and actual user
> > > > don't have it. Also, the data brief says it has an internal regulat=
or,
> > > > so perhaps it is truly optional.
> > >
> > > ov7251.c:
> > >         ov7251->core_regulator =3D devm_regulator_get(dev, "vddd");
> > >         if (IS_ERR(ov7251->core_regulator)) {
> > >                 dev_err(dev, "cannot get core regulator\n");
> > >                 return PTR_ERR(ov7251->core_regulator);
> > >         }
> > >
> > > Looks like the driver's probe function disagrees?
> >
> > Doesn't the regulator framework return a dummy regulator if missing?
>
> Huh, I think I misunderstood how _regulator_get() worked. Apologies for
> the noise, I thought it was returning an error when it used a dummy.
>
> > > I was going to ask how it worked, but the one user has
> > > status =3D "disabled"...
> >
> > Saw that too, but figured there's some other include with that
> > overridden. We should really add a built .dts output target to avoid
> > trying to manually walk includes.
>
> Probably gonna sound like an eejit, but the user is in a dts - can an
> include overwrite that status?

Yes, sometimes .dts files are both built into a dtb and included. Say
you have a board with and without an optional camera sensor.

Rob
