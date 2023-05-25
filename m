Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96B710D28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjEYNVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjEYNVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:21:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F8B2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:21:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacf685150cso303185276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685020901; x=1687612901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2D6sf7OotstMG4fjL+LV8Xk0WYtEN7o8mVPfPP4hJc=;
        b=hjqXKLhsQ2aq9s0bxkpaEilM4R4O7PNM4z2rgkDCnMzWO50ta5q5Y6U0TdXrtF7+tl
         cBP3IcNtXNwXr8e9hYAp/1n9kRP9nLJB/8Dn+EEhizlruwuM9TaiZutTdq8dwEQk5CHB
         xH6w+5Dbc6AQZYnm1olOeJClidzVD1SVemwIif+TYkYY/iBuMccIeB5pkosIbGp6WOCq
         AQw22hHldiYRBoU56tplWIWm/PHNF2dltPOsHRydbBob25Z2zKQW+0rg89PLfUJI8eBa
         ahFEvGk5jMvQrcPk8DkeJuk7d+eLUuJmCbRJVCn4MFxYHmwSjeFtz0i+8MBgs1whNg4F
         UIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685020901; x=1687612901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2D6sf7OotstMG4fjL+LV8Xk0WYtEN7o8mVPfPP4hJc=;
        b=U/NK54pBgbByQnVopQPPDxVLLPAF09v+j5ObUjHh11XZtQNx0/9Q0wWmCpkqOYlnKj
         YUyC/2Kz+quXudXJ0hVc3+EVfCG7S5cTegSBLdrQMV0t3Hn9BEguSZQJ6sNFXUwc7FTs
         FLafOdi/P0JlPSv5wnvYvaCOwx7ol29YNTvz6r698TE/AcF/lhIp//ohm4ajT+DjBScM
         xknMb4wk7vA2WmE41zKOEccLhwc9qSH/BlC3A88Pj3kyLYGMfoe1JsMGBIPw83b0TwpU
         3UiI4dd9ewHplvlpi7jFhKoSfjbjqqlIztdBKjNb/uEZz2cyRPrsjPl5mQGiJkuY8k21
         wtzw==
X-Gm-Message-State: AC+VfDyJP9O2oadSbbWaTg44m/pYxIFy/jqWQfKuOWGAgmlhEISai9PW
        dvIWxlD1wEweTXku4iAf/K4EVucByNsqWVWMQHx0gA==
X-Google-Smtp-Source: ACHHUZ4lsfr2X4npu8zvxcB/JBRGWlr11Ehk1blVXVkGhckzqImQwivBzeO8zGDwiY45pIe0KvbVPWCtSkWKaeWexNg=
X-Received: by 2002:a0d:fe83:0:b0:565:97ee:dd78 with SMTP id
 o125-20020a0dfe83000000b0056597eedd78mr685081ywf.28.1685020900657; Thu, 25
 May 2023 06:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com> <20230525-guacamole-swimmer-68048a73baac@wendy>
In-Reply-To: <20230525-guacamole-swimmer-68048a73baac@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 25 May 2023 18:51:28 +0530
Message-ID: <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, Anup Patel <anup@brainfault.org>,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 6:39=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Wed, May 24, 2023 at 04:45:36PM -0700, Atish Patra wrote:
> > On Thu, May 18, 2023 at 7:04=E2=80=AFAM Anup Patel <apatel@ventanamicro=
.com> wrote:
> > > On Thu, May 18, 2023 at 5:39=E2=80=AFPM Alexandre Ghiti <alex@ghiti.f=
r> wrote:
> > > > On 5/18/23 08:53, Anup Patel wrote:
> > > > > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > >> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dool=
ey@microchip.com> wrote:
>
> > > > > I think we have two possible approaches:
> > > > >
> > > > > 1) Update OpenSBI to set "no-map" DT property for firmware
> > > > >      reserved regions. We were doing this previously but removed
> > > > >      it later for performance reasons mentioned by Alex. It is al=
so
> > > > >      worth mentioning that ARM Trusted Firmware also sets "no-map=
"
> > > > >      DT property for firmware reserved regions.
> > > > >
> > > > > 2) Add a new "no-save-restore" DT property in the reserved
> > > > >      memory DT bindings. The hibernate support of Linux arch/risc=
v
> > > > >      will use this DT property to exclude memory regions from
> > > > >      save-restore. The EFI implementation of EDK2 and U-Boot
> > > > >      should do the following:
> > > > >      1) Treat all memory having "no-map" DT property as EFI
> > > > >          reserved memory
> > > > >      2) Treat all memory not having "no-map" DT property and
> > > > >          not having "no-save-restore" DT property as EfiBootServi=
cesData
> > > > >      3) Treat all memory not having "no-map" DT property and
> > > > >           having "no-save-restore" DT property as EfiRuntimeServi=
ceData
> > > > >           (Refer,
> > > > > https://devicetree-specification.readthedocs.io/en/latest/chapter=
3-devicenodes.html#reserved-memory-and-uefi)
> > > > >
> > > > > Personally, I am leaning towards approach#1 since approach#2
> > > > > will require changing DeviceTree specification as well.
> > > >
> > > >
> > > > If needed, indeed #1 is the simplest, but I insist, to me it is not
> > > > needed (and we don't have it in the current opensbi), if you have
> > > > another opinion, I'm open to discuss it!
> > >
> >
> > The problem with relying on the "mmode_resv" name is that there will be
> > other use cases where a portion of the memory must be reserved and acce=
ssing
> > that from the kernel will result in fault. CoVE is such a use case wher=
e
> > TSM will probably run from a memory region with confidential memory
> > which the kernel must not access.
>
> We should only rely on this node name for known bad versions of opensbi
> IMO. Going forward, if something needs to be reserved for firmware, the
> firmware should make sure that it is reserved by using the property for
> that purpose :)

There is no issue with OpenSBI since it does the right thing by marking
memory as reserved in the DT. This real issue is with the kernel handling
of reserved memory for hibernate.

Like Atish mentioned, not just OpenSBI, there will be other entities
(like TSM) or some other M-mode firmware which will also reserve
memory in DT/ACPI so clearly kernel needs a SBI implementation
independent way of handling reserved memory for hibernate.

Regards,
Anup

>
> > We have to name it "mmode_resv" as well or mark it as "no-map" which wi=
ll
> > present a hole in mappings. We will end up in same 1GB hugepage issue
> > if we choose "no-map".
> >
> > Another option is to use compatible string or label property to indicat=
e
> > that this memory region is not to be saved/restored during hibernation.
> > This can be documented in RISC-V DT bindings as well as the booting gui=
de
> > doc that alex was talking about.
>
> Sure, a dt-binding for sbi reserved regions doesn't immediately sound
> like an awful idea... But we still have to work around the borked
> firmware - be that disabling hibernation or using the mmode_resv node
> when we know that the version of OpenSBI is one of those with the
> problem.
>
> > > I agree with you, backward compatibility with older firmwares
> > > is important.
> > >
> > This does break the compatibility with the older firmware w.r.to hibern=
ation
> > feature. However
> >
> > It is specific to hibernation only. So hibernation will fail to work
> > if an user is running kernel > 6.4 but 0.8 < OpenSBI < 1.2
> >
> > The same problem lies if users use other firmware that don't have
> > no-map property today. IMO, this can be documented as a known problem.
>
> I'd rather we disabled it than documented it as broken.
> Or disable _and_ document it.
>
> > > Let's go with your proposed change to treat reserved DT nodes
> > > with "mmode_resv*" name as M-mode firmware memory (it could
> > > be any M-mode firmware). We will certainly need to document it
> > > somewhere as an expectation of Linux RISC-V kernel.
> > >
> > > @Sunil How about treating "mmode_resv*" as
> > > EfiRuntimeServiceData in EDK2 ? Other reserved memory
> > > nodes can follow the device tree specification.
> > >
> >
> > Either way, we also need to fix U-Boot to match the behavior.  Currentl=
y,
> > it treats any reserved memory without no-map property as EFI_BOOT_SERVI=
CES_DATA.
>
> Cheers,
> Conor.
