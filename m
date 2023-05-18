Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988617079FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjERF71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjERF7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:59:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B61FE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 22:59:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso17442401fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 22:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684389562; x=1686981562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pC2Mw768aiiOZVW/URaji/jIL0q8fXLGmXCX/5A7RQ=;
        b=Fo7rAgsOA6iH6hlmTo1ihueMBtErgiCBJncUCGNvlUM4emHdLATv1yNCak9CgmRc0O
         SpRjRsqiIv8P4Hj7NSU00nNKvFk/8gJZZItniS1WTCp/jTP1rx4F0Jz9Z4aDB6V2QaT+
         hDxMrU92MegrLkVeIPmE1fXuWVIF5JlzhAhi8Wy9rGsOdd1cgBuLvBvfnPWoZaoAUcLM
         Q0g2f688rbnqD/+GlOr0L8evpBLTUYKWJ7ww4/CgbuaqTC8wVc+AlEZD3pXqfHOmZu1q
         hIn4Ex/4dx+NRooqrFqgVBAWei/7aa9vQSB6ZzqkPCOU3p7bD5IiY0+FydARk8d7i2C/
         /uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684389562; x=1686981562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pC2Mw768aiiOZVW/URaji/jIL0q8fXLGmXCX/5A7RQ=;
        b=EBuOXzlM80pIlmjNLfWsT+fi3tdFJNapZLHPsyoo/3faW2JDDGGhNlJ5NLdzKRADGa
         QZ6wQtPWxasmaSK/c1ynG4CfJJXFazKsAKUB1o9Avi5vFkHq6+Frd1dTGKOTuio08ZIi
         CBrB7fQHMdth/AuRmk5EsbMa5KsXWsAcdd65Xvw+ldX+acz0e1ekXP1hD/VbFbKn5v3T
         gjCMMF81OryHT+dX2Ey318e+YvSi3ojmgoZjPJiWhuZo/Qc1sbhAZznq3DVIYOz9UmLa
         DQdQ+aqrLsrCcPvu1IH5AI+1scVY8qlnUaa4CL2Mrwnh66Sic0B+e6AsE2HFI9wxTAw1
         2FFg==
X-Gm-Message-State: AC+VfDyj9L66MrDQmSkAknasueDTD5FHfHxtqccv02jPv4skDZgskDgv
        +faljUdChsxY9iJKRM5SBiQjJ6huT+wt/liK4RY=
X-Google-Smtp-Source: ACHHUZ6f1i4RUizH7lzR3yDT/TZdVZK3Oou3/klaxDVmkwNqtNKY7uniLvkxHeCyyk/poW0z4MSMZKNci8m/raB59Nk=
X-Received: by 2002:a2e:8051:0:b0:2ac:91c5:76c with SMTP id
 p17-20020a2e8051000000b002ac91c5076cmr10763289ljg.18.1684389561831; Wed, 17
 May 2023 22:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230517025747.230-1-ssawgyw@gmail.com> <52fa3a4f-5467-7b68-334c-4280d3925b39@arm.com>
 <ZGTZvbpweJMPAwu3@kernel.org>
In-Reply-To: <ZGTZvbpweJMPAwu3@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Thu, 18 May 2023 13:58:46 +0800
Message-ID: <CALJQGLnNohj8w_Cd-wX40eNoWVUCsRePHV0QvkTP9L7wJvU+Eg@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: Add flags and nid info in memblock debugfs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, tsahu@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=B8=89 21:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 17, 2023 at 11:37:25AM +0530, Anshuman Khandual wrote:
> >
> > On 5/17/23 08:27, Yuwei Guan wrote:
> > > Currently, the memblock debugfs can display the count of memblock_typ=
e and
> > > the base and end of the reg. However, when the following scenario occ=
urs,
> >
> > scenarios where the memblock flags or nid varies inside a single PA ran=
ge ?
> > I guess the commit message description here can be improved to accommod=
ate
> > such details.
> >
> > > the information in the existing debugfs cannot make it clear why the
> > > address is not consecutive.
> > >
> > > For example,
> > > cat /sys/kernel/debug/memblock/memory
> > >    0: 0x0000000080000000..0x00000000901fffff
> > >    1: 0x0000000090200000..0x00000000905fffff
> > >    2: 0x0000000090600000..0x0000000092ffffff
> > >    3: 0x0000000093000000..0x00000000973fffff
> > >    4: 0x0000000097400000..0x00000000b71fffff
> > >    5: 0x00000000c0000000..0x00000000dfffffff
> > >    6: 0x00000000e2500000..0x00000000f87fffff
> > >    7: 0x00000000f8800000..0x00000000fa7fffff
> > >    8: 0x00000000fa800000..0x00000000fd3effff
> > >    9: 0x00000000fd3f0000..0x00000000fd3fefff
> > >   10: 0x00000000fd3ff000..0x00000000fd7fffff
> > >   11: 0x00000000fd800000..0x00000000fd901fff
> > >   12: 0x00000000fd902000..0x00000000fd909fff
> > >   13: 0x00000000fd90a000..0x00000000fd90bfff
> > >   14: 0x00000000fd90c000..0x00000000ffffffff
> > >   15: 0x0000000880000000..0x0000000affffffff
> > >
> > > So we can add flags and nid to this debugfs.
> > >
> > > For example,
> > > cat /sys/kernel/debug/memblock/memory
> > > cnt     base..end       flags   nid
> >
> > These markers ^^^ are not aligned properly, and also might not be
> > required as well.
> >
> > > 0:      0x0000000080000000..0x00000000901fffff  0x0     0x0
> > > 1:      0x0000000090200000..0x00000000905fffff  0x4     0x0
> > > 2:      0x0000000090600000..0x0000000092ffffff  0x0     0x0
> > > 3:      0x0000000093000000..0x00000000973fffff  0x4     0x0
> > > 4:      0x0000000097400000..0x00000000b71fffff  0x0     0x0
> > > 5:      0x00000000c0000000..0x00000000dfffffff  0x0     0x0
> > > 6:      0x00000000e2500000..0x00000000f87fffff  0x0     0x0
> > > 7:      0x00000000f8800000..0x00000000fa7fffff  0x4     0x0
> > > 8:      0x00000000fa800000..0x00000000fd3effff  0x0     0x0
> > > 9:      0x00000000fd3f0000..0x00000000fd3fefff  0x4     0x0
> > > 10:     0x00000000fd3ff000..0x00000000fd7fffff  0x0     0x0
> > > 11:     0x00000000fd800000..0x00000000fd901fff  0x4     0x0
> > > 12:     0x00000000fd902000..0x00000000fd909fff  0x0     0x0
> > > 13:     0x00000000fd90a000..0x00000000fd90bfff  0x4     0x0
> > > 14:     0x00000000fd90c000..0x00000000ffffffff  0x0     0x0
> > > 15:     0x0000000880000000..0x0000000affffffff  0x0     0x0
> > >
> > > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > > Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>
> > > ---
> > >  mm/memblock.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 511d4783dcf1..b36fb6b31e0f 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -2144,12 +2144,16 @@ static int memblock_debug_show(struct seq_fil=
e *m, void *private)
> > >     int i;
> > >     phys_addr_t end;
> > >
> > > +   seq_puts(m, "cnt\tbase..end\tflags\tnid\n");
> >
> > Please drop this.
> >
> > > +
> > >     for (i =3D 0; i < type->cnt; i++) {
> > >             reg =3D &type->regions[i];
> > >             end =3D reg->base + reg->size - 1;
> > >
> > > -           seq_printf(m, "%4d: ", i);
> > > -           seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> > > +           seq_printf(m, "%d:\t", i);
> >
> > Why drop the existing %4d formatting qualifier ?
> >
> > > +           seq_printf(m, "%pa..%pa\t", &reg->base, &end);
> > > +           seq_printf(m, "0x%x\t", reg->flags);
> >
> > Should there be ORed string values for each memblock flag ?
> >
> > enum memblock_flags {
> >         MEMBLOCK_NONE           =3D 0x0,  /* No special request */
> >         MEMBLOCK_HOTPLUG        =3D 0x1,  /* hotpluggable region */
> >         MEMBLOCK_MIRROR         =3D 0x2,  /* mirrored region */
> >         MEMBLOCK_NOMAP          =3D 0x4,  /* don't add to kernel direct=
 mapping */
> >         MEMBLOCK_DRIVER_MANAGED =3D 0x8,  /* always detected via a driv=
er */
> > };
> >
> > Something like NN | HT | MR | NM | DM ?
>
> These are not less cryptic than numbers :)
> Most of them are mutually exclusive, so maybe just spell them out fully,
> just shorten DRIVER_MANAGED to DRV_MNG?
> And make the flags dump the last to keep columns nicely aligned.
>

Ok, I will update them in the v3 patch soon.

Thanks
> > > +           seq_printf(m, "0x%x\n", memblock_get_region_node(reg));
> > >     }
> > >     return 0;
> > >  }
>
> --
> Sincerely yours,
> Mike.
