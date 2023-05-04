Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2038A6F6D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjEDNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjEDNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76647A96;
        Thu,  4 May 2023 06:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6691363458;
        Thu,  4 May 2023 13:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD2DC433A0;
        Thu,  4 May 2023 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683207867;
        bh=yPQOViyYJRwXqhVxZi/3NsWsOWGUceyxlhPN/9yy+YE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=awKI4UsIVouM9nyAoAnvbCO9Xn+K6joD8FZrY/VbxKW0yUzb4r1fRmNYlBlRlgAYQ
         eGUoSBezAIxvui56afY6aspnVbxrMsHtshdIhbRwK4eBzh7ciufx3QO9VvkRLJKlQ4
         yKhEhCQ+C6rSJaUxv4cdnW05LBCbh8N/YnGpIx2U0wfguCh0KjD7hMuWdJvsBuUYk1
         iwv9npcXOpWVUAdGjzJbLrBP5lN2QWMhK/EqAMxoOJNAuT+ycrK0Rj+y0c3MIaLBAX
         BGqwZ+T/rOdcFf0ZYyJ3evxIzzFRqKRstCH9urhKPwcdIVoySWCLUIe0Wajqwna0fC
         s+n2H62ex4BwA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so6166121fa.2;
        Thu, 04 May 2023 06:44:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwOzE4ECerqa4GrHr+pe9EUrAhSHwRNbSO02Yv+7twnVvqXz4W
        OEMnWpg3CYZn68jj/IHhhEoUMXAZC3RLqCvdmLk=
X-Google-Smtp-Source: ACHHUZ5zOsk4X21Ij/parQ8V5EqyaxP3HA0jkPnXBHA8EvDBqDyqs4OU662SiHrz2khlyEpqbfyvkWofL63rFpUnRtI=
X-Received: by 2002:ac2:46f1:0:b0:4ec:8524:65a4 with SMTP id
 q17-20020ac246f1000000b004ec852465a4mr1850868lfo.55.1683207865707; Thu, 04
 May 2023 06:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <ZEpbTE4gcsf8meXc@FVFF77S0Q05N> <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
 <CAEEQ3w=495snOz3UNBO4dpgyfZs3jQoRKo4QRAXXqR5-0j4SWA@mail.gmail.com>
 <CAP6exYK9ytcgqcy2gFyOGvbxd7DPGQNs=m7nNgnfunnh8et9aQ@mail.gmail.com>
 <CAMj1kXGB4yXCdzts2=G_-hadoka9F2BU1gvVxeLEs5ifSbqgog@mail.gmail.com> <CAEEQ3wmcPMf44g2zRLRW3jKgd1ostpjQp=JMmwWdyYrhGQJnjA@mail.gmail.com>
In-Reply-To: <CAEEQ3wmcPMf44g2zRLRW3jKgd1ostpjQp=JMmwWdyYrhGQJnjA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 May 2023 15:44:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzfiTG=_ceJJM6ca0TSB7E_G2jKNg+LVvCEB9iXFzTew@mail.gmail.com>
Message-ID: <CAMj1kXFzfiTG=_ceJJM6ca0TSB7E_G2jKNg+LVvCEB9iXFzTew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 at 14:06, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedan=
ce.com> wrote:
>
> Hi Ron, Ard
>
> On Sat, Apr 29, 2023 at 2:03=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Fri, 28 Apr 2023 at 17:09, ron minnich <rminnich@gmail.com> wrote:
> > >
> > > There is lots of text in the preceding notes :-), which is nice becau=
se we're clearly looking at something that matters!
> > >
> > > But, note, ARM Chromebooks run Linux, and I checked with the firmware=
 team just now:
> > > "Right. We're not using UEFI or ACPI or SMBIOS or DMI or any of that =
on Arm. Just the Device Tree."
> > >
> > > So I do not agree that we need UEFI tables due to some presumed seman=
tics that they implement, because: several tens of millions of ARM chromebo=
oks running Linux show otherwise.
> > >
> > > We've got a chance here to move to self describing data, and I think =
we need to take it. It will be a long time before we get this chance again.
> > >
>
> > However, introducing such a binding for SMBIOS is perfectly
> > reasonable, although I would suggest that we don't copy the
> > SMBIOS/SMBIOS3 entry point address into the device tree (as this patch
> > does), but properly describe the memory region that contains the
> > actual SMBIOS structured data directly, along with its version. This
> > might be reused by other DT based platforms as well.
>
> Could you help to give me an example to add smbios in the memmap
> region description?
>

I'm not a DT expert, better to ask the maintainers for guidance.

> Even after adding to the memmap region, it needs to be connected to
> the current dmi_scan_machine()?
> Or add another dmi code under the fdt framework?
>

Yes. This should be generic code that permits any DT platform to
expose SMBIOS data without relying on EFI. So I would imagine that the
support code will live somewhere under drivers/of/ perhaps?

>
> > Doing the same for ACPI is where we'll get into trouble, given that
> > we'd end up with two conflicting hardware descriptions and unfulfilled
> > dependencies on EFI specific data structures, and it is not the
> > kernel's job to reason about which h/w description should take
> > precedence, or to make guesses about memory types. So I fully agree
> > with Ron that moving to device tree is a much better choice here -
> > that way, you can avoid ACPI and UEFI altogether
>
> Thanks for your suggestions, I don't quite get what needs to be moved
> to dts? Could you explain in detail?
> Is it to realize the content of acpi based on the dts framework?
>

Yes. You will have to duplicate the platform topology description,
including CPU's, interrupt controllers, PCI host bridges and all other
non-discoverable peripherals. You will lose some functionality
regarding hotplugging and RAS, because DT does not support that, but
otherwise, it should be quite feasible to replace ACPI entirely.

But Ron is the expert here on replacing vendor provided firmware with
open(er) source alternatives, so perhaps he has some ideas on how to
bridge this gap?
