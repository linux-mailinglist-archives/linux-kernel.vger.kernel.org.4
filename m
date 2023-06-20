Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D891736710
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFTJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFTJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:10:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02189C9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:09:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311167ba376so4234963f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687252198; x=1689844198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX+s+92hf3DgfkJEyVQHEHwARpdNxyWJPg+xhjL0XyM=;
        b=q8i5UShKwu8jjzjQQGb6dP8fG0/t9EntmkBpZZLwGOAJEzMQsZeObzQmzpHdpnAtD3
         gt0KEnmEBpRnNw2fc5zi5grbXjZrZFoiOp56iWt2yNAmtFzEqxwmYB4ZlQ0QDuLsHyRk
         geXwIYy9e8m20ti8qsfZD5xxVdoFV5AvSwaJdCTuDL/If6dDpuUsUzYKXYJvXVumOuhw
         +P1sEtwJE+N8EJl6tTfJMsVfmFkzBIQ4vJ4djIZLmlcq5jwXr9nTj4gVgnS9OaiVQ6Dc
         WWOznCHml89ubVo6Y5VpTqaEaitl7N0O+4dj1w7+0Zi7LMJg/d1KA3ouZA49mBhnaIwk
         e64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252198; x=1689844198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX+s+92hf3DgfkJEyVQHEHwARpdNxyWJPg+xhjL0XyM=;
        b=PG6CPgCuMjw2mdYLAPO6gity7qJSnTOibj/prlBJauyfxOaCDzhF6DXBK8gRhRljq3
         0PcjIx8OI/npcom0gmzQBjbgt+3bL+wgJQNGrbkNZc0TqtaEfaPBNZ0lNBqg7tRW8dMB
         5IJTNN+n4bx8OSlCDrvHeQO/bttX25Qek2tZ1gNjUS1+eRv2egIGLt/ysD6GejIx5bNZ
         boNSbVYQ3zvtO19W2GWso+z3/j7+iBTmVYteGksnsA+Lkdy5528bBoWIguTVyWFv7z5B
         RbWfk39FzBMehUoaGb/hMTh1pnaqABKpW+aANUdKbG7ylBsESUGTZBPVYU4pIpFBgWQ9
         dpHA==
X-Gm-Message-State: AC+VfDzADzU8g3Ux2sCk7xskWaBw9omg5igsrxAPTo2tH8fCI6oSEFd2
        Pkhw82+ddM7utb1JEQ+/ozD0R/DY0uqYSrd29S4XyLsBReW+w9r2
X-Google-Smtp-Source: ACHHUZ5l5dH2+AQbCK9AgM+wVYZGLKYSXA+ddnUUJAXKgsoEQvLNkK1oCNoscahhTsw09iuiBon/wAcJOq7I+Zp/pAo=
X-Received: by 2002:adf:f804:0:b0:311:f69:5ee9 with SMTP id
 s4-20020adff804000000b003110f695ee9mr9793683wrp.9.1687252198390; Tue, 20 Jun
 2023 02:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy> <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <20230619-sponge-armful-6beeaf4a8624@spud>
In-Reply-To: <20230619-sponge-armful-6beeaf4a8624@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 11:09:47 +0200
Message-ID: <CAHVXubjHpdRpgrywwm1UTxwV99uCYOp9qhKBui9Ghff65yGmsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 6:00=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> > On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
>
> > > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boo=
t.rst
> > > > new file mode 100644
> > > > index 000000000000..b02230818b79
> > > > --- /dev/null
> > > > +++ b/Documentation/riscv/boot.rst
> > > > @@ -0,0 +1,181 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Early boot requirements/constraints on RISC-V
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Please use "title case", here and elsewhere in the doc.
> >
> > You mean using "title: " instead of "=3D=3D=3D=3D"? Or using uppercase =
for the
> > first letter of each word? FYI I followed
> > https://docs.kernel.org/doc-guide/sphinx.html?highlight=3Dtitle#specifi=
c-guidelines-for-the-kernel-documentation
>
> The latter. That's weird, I guess it would be nice to see what Jon
> thinks about that.
>
> > > > +Reserved memory for resident firmware
> > > > +-------------------------------------
> > > > +
> > > > +The RISC-V kernel expects the firmware to mark any resident memory=
 with the
> > >
> > > Should this be
> > > "...resident memory, or memory it has protected with PMPs, with..."
> > > ?
> >
> > I used "resident" memory instead of "PMP" memory because it was more
> > general. I mean you can have a region that is resident but not
> > protected by PMP, and I don't think the kernel should ask for this
> > resident memory to be protected with PMP right?
>
> Nah, I was thinking about the opposite. PMP protected regions that do
> not have memory-resident programs in them.

Ok, I'll add a reference to PMP regions like you mentioned the first time.

>
> > > > +`no-map` flag, thus the kernel won't map those regions in the dire=
ct mapping
> > >
> > > "no-map" is a DT specific term, should this section be moved down und=
er
> > > DT, as a sub-section of that?
> >
> > Maybe I can rephrase with something like that:
> >
> > "The RISC-V kernel must not map any resident memory in the direct
> > mapping, so the firmware must correctly mark those regions as follows:
> > - when using a devicetree, using the `no-map` flag,
> > - when booting with UEFI without devicetree, either as
> > `EfiRuntimeServicesData/Code` or `EfiReserved`."
>
> I'm not sure you need to have a list to be honest. Could do it in
> free-form text if you like. But you've got 3 options there for Efi
> stuff, isn't only one of them a valid equivalent for "no-map"?

Indeed, the no-map attribute is (according to the dt spec) always
converted to EfiReservedMemoryType and no-map is the only way to
"reserve" such memory using devicetree. A firmware can also mark those
regions as EfiRuntimeServicesData/Code so that they don't get mapped
in the direct mapping.  But ok, let's make it simple, I'll go with
something like Sunil's proposition.

> >
> > > > +(avoiding issues with hibernation, speculative accesses and probab=
ly other
> > > > +subsystems).
> > >
> > > I'm not sure that this () section is beneficial. To be honest, recent
> > > issues aside, this section here seems like a statement of the obvious=
...
> >
> > But I made the mistake, so it was not that straightforward to
> > me...I'll remove the ().
>
> I know, hence the "recent issues aside" ;)
>
> > > > +that's not the case.
> > > > +
> > > > +Device-tree
> >
> > Damn, missed this one, thanks!
> >
> > >
> > > s/Device-tree/Devicetree/ and...
> > >
> > > > +-----------
> > > > +
> > > > +The RISC-V kernel always expects a device tree, it is:
> > >
> > > ...s/device tree/devicetree/ to match elsewhere in the kernel docs.
> > > Same applies to the other instances of "device tree" in this patch,
> > > please.
> >
> > Ok I'll do that (but I'm happy to say that I thought about that and it
> > was intentional since "git grep "device tree" | wc -l" returns a
> > significant number of instances :)).
>
> Yeah, I had the same thoughts recently too. It's completely mixed
> unfortunately, but I suppose I was going off of the headings in the DT
> docs that are in rst form. It's not a big deal obviously.
>
> > > > +- either passed directly to the kernel from the previous stage usi=
ng the `$a1`
> > > > +  register,
> > > > +- or when booting with UEFI, the device tree will be retrieved by =
the EFI stub
> > > > +  using the EFI configuration table or it will be created.
> > >
> > > Can I suggest changing this around a little, pulling the "either" &
> > > dropping some boilerplate so that it reads (to me!) a little more
> > > naturally:
> > >         The RISC-V kernel always expects a devicetree, it is either:
> > >
> > >         - passed directly to the kernel from the previous stage using=
 the `$a1`
> > >           register,
> > >         - retrieved by the EFI stub when booting with UEFI, using the=
 EFI
> > >           configuration table or it will be created by ____.
> > >
> > > Also, please elaborate on what it will be created by.
> >
> > Is it better this way:
> >
> > "The RISC-V kernel always expects a devicetree, it is either:
> >
> > - passed directly to the kernel from the previous stage using the
> > `$a1`
> >   register,
> > - retrieved by the EFI stub if present in the EFI configuration table,
> > - created by the EFI stub otherwise."
>
> Nah, I think the 2 bullet structure was better. This 3 bullet mode
> implies that if not passed in a1, then the EFI stub will create it.
> Which is obviously not true

I'll go with Sunil's proposition which is way better than the list above!

> >
> > >
> > > > +
> > > > +Bootflow
> > >
> > > "Boot Flow", no?
> > > I am not sure that this is the "correct" heading for the content it
> > > describes, but I have nothing better to offer :/
> >
> > Yes you're right, what about simply "Kernel Entrance"? Not sure this
> > is easily understandable though.
>
> "Non-boot Hart Initialisation"?

Hmmm not that great either (sorry for being direct here)

>
> > > > +--------
> > > > +
> > > > +There exist 2 methods to enter the kernel:
> > > > +
> > > > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the ke=
rnel, one hart
> > > > +  wins a lottery and executes the early boot code while the other =
harts are
> > > > +  parked waiting for the initialization to finish. This method is =
now
> > >
> > > nit: s/now//
> >
> > Ok
> >
> > >
> > > What do you mean by deprecated? There's no requirement to implement t=
he
> > > HSM extension, right?
> >
> > I would say yes, you have to use a recent version of openSBI that
> > supports the HSM extension. @Atish Kumar Patra WDYT?
>
> Uh, you don't need to use OpenSBI in the first place, let alone use a
> recent version of it, right? What am I missing?

You need a M-Mode firmware which follows the SBI specification and
that implements the HSM extension.

> Also, what about !SMP systems? Although my suggested new section title
> kinda addresses that!

I'll add "On SMP systems, there exist 2 methods to enter the
kernel:....", I don't think we need to detail the !SMP case as it is
obvious.

>
> > > > +  **deprecated**.
> > > > +- Ordered booting: the firmware releases only one hart that will e=
xecute the
> > > > +  initialization phase and then will start all other harts using t=
he SBI HSM
> > > > +  extension.
> > > > +
> > > > +UEFI
> > > > +----
> > > > +
> > > > +UEFI memory map
> > > > +~~~~~~~~~~~~~~~
> > > > +
> > > > +When booting with UEFI, the RISC-V kernel will use only the EFI me=
mory map to
> > > > +populate the system memory.
> > > > +
> > > > +The UEFI firmware must parse the subnodes of the `/reserved-memory=
` device tree
> > > > +node and abide by the device tree specification to convert the att=
ributes of
> > > > +those subnodes (`no-map` and `reusable`) into their correct EFI eq=
uivalent
> > > > +(refer to section "3.5.4 /reserved-memory and UEFI" of the device =
tree
> > > > +specification).
> > > > +
> > > > +RISCV_EFI_BOOT_PROTOCOL
> > > > +~~~~~~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +When booting with UEFI, the EFI stub requires the boot hartid in o=
rder to pass
> > > > +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot =
hartid using
> > > > +one of the following methods:
> > > > +
> > > > +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> > > > +- `boot-hartid` device tree subnode (**deprecated**).
> > > > +
> > > > +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the d=
evice tree
> > > > +based approach is deprecated now.
> > > > +
> > > > +During kernel boot: (Kernel internals)
> > >
> > > With the other section titles changed, this could be:
> > >         Early Boot Requirements and Constraints
> > >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >         The RISC-V kernel's early boot process operates under the
> > >         following constraints:
> > >
> > > Thoughts?
> >
> > I think it's better as you propose, I changed it, thanks.
> >
> > >
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +EFI stub and device tree
> > >
> > > Same comments about "device tree" here etc.
> > >
> > > > +------------------------
> > > > +
> > > > +When booting with UEFI, the device tree is supplemented by the EFI=
 stub with the
> > > > +following parameters (largely shared with arm64 in Documentation/a=
rm/uefi.rst):
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +Name                        Size     Description
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +linux,uefi-system-table     64-bit   Physical address of the UEFI =
System Table.
> > >
> > > nit: Hmm, I think for all of these sizes s/-bit/ bits/.
> >
> > That's a copy-paste from the link just above the table.
> >
> > But maybe I should have pointed to the doc and added only the
> > "bootargs" stuff (maybe that's also present for arm64 actually).
>
> If it is identical, sounds like a good idea. It's common code that does
> that stuff, right?

Yep, all of that is done in the same generic function in libstub
(update_fdt()). I'll move the bootargs stuff to the arm documentation
\o/

>
> > > > +---------------------
> > > > +
> > > > +The installation of the virtual mapping is done in 2 steps in the =
RISC-V kernel:
> > > > +
> > > > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > > > +   :c:var:`early_pg_dir` which allows to discover the system memor=
y: only the
> > >
> > > s/to discover/discovery of/
> >
> > You mean "the discovery of" right?
>
> No? The "the" there would not be required.

That was a genuine question, thanks

>
> > > > +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able t=
o correctly
> > > > +convert direct mapping addresses to physical addresses, it needs t=
o know the
> > >
> > > nit: s/it/they/
> >
> > Ok
> >
> > >
> > > > +start of the DRAM: this happens after 1, right before 2 installs t=
he direct
> > >
> > > s/:/./
> >
> > Ahah, you really don't like long sentences :)
>
> I dunno if it is long sentences per se, I just think it is easier to
> follow.
>
> > But of course ok :)
> >
> > > Also how about s/1/step 1/ & s/2/step 2/?
> >
> > Way better, thanks
>
> > > > +Pre-MMU execution
> > > > +-----------------
> > > > +
> > > > +Any code that executes before even the first virtual mapping is es=
tablished
> > > > +must be very carefully compiled as:
> > >
> > > Could you point out what the non-obvious examples of this code are?
> >
> > I can do a list, yes
>
> Not even a list, just something like "...established, for example early
> alternatives and foo, must be very..."

Done as follows:

"A few pieces of code need to run before even the first virtual mapping is
established, that comprises the installation of the first virtual mapping, =
the
early alternatives and the early parsing of the kernel command line. That c=
ode
must be very carefully compiled as:..."

>
> > Thanks for your thorough review!
>
> NW chief.
>
