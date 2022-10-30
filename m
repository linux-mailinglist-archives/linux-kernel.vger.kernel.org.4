Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03761612B95
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ3QU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJ3QU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:20:56 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91150A46F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667146832; bh=fOBr9LiSqmHS9jainUOvZJ9zz096aPVD/DPP2cPL7+0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=m/Et4NvKJ4VuYrsLV9f0Q+gdk258PzUnEH62RPXZa7Dnm/LL9EWV+jYjwfTXskaV3
         rDcYgpVMUwrP20M+0HUxNAX7HnIIam81TI1uxV9vkkjo6R+b7J070+rxlWzja4EuTa
         VQPlDcLg5hByMIrkPy8UCfi/+FwrIjK3UgGw7FHmx2wZz+axz0bKEoPqn/W2abxPp2
         jrenfnx415r9+8OfLV6IdBYjDgerZq3X1tI+FP24thQHTIgtHXunIQfbsahdi9ZAEM
         SfTwnpk3PgeA++XbbLLGJQ7LU4g/JucY8isgtLqOXOxKi6bnCw5Gh0kVEFonuOpuXH
         1WoJJgk5CvyaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from gecko.fritz.box ([82.207.254.101]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1oVSEJ4B56-00KKW5; Sun, 30
 Oct 2022 17:13:28 +0100
Date:   Sun, 30 Oct 2022 16:13:15 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        "Melissa Wen" <mwen@igalia.com>
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one)
 to avoid userspace regression
Message-ID: <20221030160300.3a3e72c7@gecko.fritz.box>
In-Reply-To: <SJ1PR11MB60839A08E01742321F8446BCFC579@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
        <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
        <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
        <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
        <SJ1PR11MB60839A08E01742321F8446BCFC579@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/blTXMv.pM3CzC.J8IB+IlVC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:RUHxR/QHqnTecROiHhek1ZYiITE0325qS764zNasEt9tzxGCYxB
 hJTA8Ph5MraUHLWFuMZ1IKesU77RQ6NKJ48JZY6fhX+9fs+F/cqrOT22BZx/E9gYuRX3Bvu
 0fsGSBWD4SG/s663DlHE5PpRT0G1G0xBZYt735mEATAq8WVhLcRTVwPHlO+cXOWx72LxZMl
 nxZutCfVt5mrkYxyzgX2g==
UI-OutboundReport: notjunk:1;M01:P0:ip+199mkyQs=;8FhBjuAdcqTEQHSCvjbJVLrSNSm
 C+G1bG52BGEREQ9H29PUKRWRj3n/gH/stOQt000QXEgNttMlSdX3WTbflInlBg8lkEa2XxMCn
 a7wX8krgn4/h4SO8R3xnn8FkHEP2HpAlEk01+9XlGtlhbY5ZYApLXN9QGv94v+N+q3CaV2cRB
 G2XKYOOC/j1YMz9h8VvQnwbOLd2nkCvtht/kEHMv3SyFIQ+wf03XlmSvPinGj23pNPRDGvWmW
 iHfbHB54XSrxw1CMiA17uiCmiFG9PXJDMEd1sNSciQ4mL+f6EyIlgyQiOeefWoZQI0fnfONyF
 SbTFhJf8PVpg3N5IDolZiw2g/bKH0IScQlMWmhPPDfUTjw/EhvQxabGJU9RUoVhjNrohV2vt0
 fZxMNpyqQDEVsV8s2xwK+i4Zi84hlRvFo2zuaNAvY3JbK/6Vv5aAhnYtlHZKa9zIK4ZDuQwEs
 jPUBAC1XCRJAFfENgrjzHZzp+ISEBNTt+YkLQnCoTja5+TLX6m7GdeELpaXs09sGzB6U9ZwDV
 pI+4fq5ofM6ynyZuOFywjY+2GIJpJOnOaX9krLZHu2yL7/qOdtGaUhtTynQv9MCZV3REfP6C/
 U6fJRpfb/B+iV/t0JT6kZYqT+fQuCbJXP9QbsAn1toGHqtnzkrcke1H4iK0mlnD8VwazoqGRk
 dAkF0vzUNb+AXkCUqW/liR2qieKHDoEedWha3qcneASLi6pVp50ho8PfmfXDED1sdrXLG2eFx
 PXWzUNZBo699XZL3wNt7oJxFjsHn9rZe49vqDakk/xYwowKzFSfmDGa4bG7MgrmtdKBAQuQPH
 WetToRQrVr/Nb8ekCfy7qvVua/vCz+2cKzL0Q7OgSjwiCow8wtL2rFbSJq/pC1NrnGMf8ppQA
 SA8BSQb/l2fylZEjP35Q2wuphw28jSwHUAaoCvM/9+VYFKgPfbG/KhnnZPGNkovoa7gUNcbAF
 VVEEDu+R5lcpAcxqTZr2HEmD8ow=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/blTXMv.pM3CzC.J8IB+IlVC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Sep 2022 15:37:55 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> >> I have a revert removing the misery ready and tested, let me know if I
> >> should submit it. =20
> >
> > I'm a bit of a late arrival to the split lock party, so I'm a bit
> > hesitant to merge any changes immediately.
> >
> > How about we give it a few weeks and see if the current behavior impacts
> > anyone else?  Maybe the best route will be more clear then. =20
>=20
> Applying "misery" to the processes that are executing split-lock flows sa=
ves
> the rest of the system from a different level of misery (for the duration=
 of the
> split lock other logical CPUs and I/O devices have access to memory block=
ed).
>=20
> So the "misery" serves a very useful purpose on multi-user systems.

Hello Everyone,
How about the following: The kernel traps the split-lock, but instead
of punishing the process artificially it emulates it in a different way
that won't harm the system as a whole. Of course this still will be
slower than a non-split-lock but surely won't take 10ms.

For example, you could emulate the instruction without atomic semantics,
but protected under a single global mutex for all split-lock operations
instead. This is how atomics are done on on alpha AFAIK, which doesn't
have atomic instructions.

This is not as simple as the current solution. But I see the current
solution more like a quick and dirty workaround for this security/DoS
issue, until a proper solution (like my proposal) is implemented.

Regards,
Lukas Straub

> Maybe the decision of which mode to use could be dynamic based on
> number of online CPUs? Laptops/desktops with low counts (<50???)
> could just "warn", while servers could default to the "seq" mode.
>=20
> Or perhaps there is some other heuristic to distinguish single-user
> systems where the split-locks are not causing pain to other users?
>=20
> -Tony



--=20


--Sig_/blTXMv.pM3CzC.J8IB+IlVC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmNeopsACgkQNasLKJxd
slgVpw/+PEzqpQPaoe28XCRiQz47VjeNxiB2Sr+O8ZSxC3wTk4SECW3TK0OwLF5H
lKvw811pbJXjU08KjuHgyn34FsyfOBAvUE5Pi29CSCpnVxyOoLm1BS6JYxRT2Ypi
ja98+O0+YuUZkOk6F/PGYBZPPzZXaCHsfA6kFhvWmC03tzCv/7/yFN9Ihe8rGBI6
FdbsPZezh+MuinU/bJffTZQWIp6g46qv+Qj4RntFGy8efUkxDLWdjjy1ZdZu54vr
X8pjhSw+f48WD52prMNpjdcLg7yqBbro+X5vb7qTTSIORxfwrf4RBNPWcIzLGbnJ
4Eemp8Q/I0tfnNc1xEXlQHcvZazvlZ+k87JJzAXzYENOnf2voUMVXG4idKi1U1bo
sPDubcoKMDhd3pQ9Ba0LttskRzfqb8qSqJzi2WxFnRvHMJJVW0rUI2W9+rI+3+KZ
du9kOE9qwJ2djv+a+CYrsUMLj3i7U/KTo9QC4GVPR/kPSdY/G4D/J5JLdACiNlK6
DwKfAk3VfdF/O5xCqwGT0iNSPAebicQH1PEixYsvhxTIXtCogaYWfQCIyduepUcV
n2vklLTnnx0ctB0i8JJrR+QWoP5/3eRmqBt9B/kdGwAOn0Lv4HgxiXqbIBKiLHvw
4S0WxEMEsirnxKHHDQy4o20adO5Sp+zyt6Sx3/V1HGvjgxMnGnI=
=0ROh
-----END PGP SIGNATURE-----

--Sig_/blTXMv.pM3CzC.J8IB+IlVC--
