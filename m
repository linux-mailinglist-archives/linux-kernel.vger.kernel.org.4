Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CCF66A63E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAMWxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjAMWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:53:08 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89207D27C;
        Fri, 13 Jan 2023 14:53:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 433D95C00B6;
        Fri, 13 Jan 2023 17:53:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 13 Jan 2023 17:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1673650385; x=
        1673736785; bh=lKCV0ycAY0SFtq1SYJ0F5dfFWAI3C/PKOUtKuY5T64U=; b=O
        KFd4cQE64z7byI+zm0c8nD+rqAxFmbGCCZ3Vh/GS10spMDBCdu2RoohH4GfizyP7
        vMHfF9Q3WqmBl2tCCbTlvQDj9C1AU71gp0LMeVLamWIKmQOJVj2WgoTcd2glt9CD
        NJU93AEM0M81j6mGmV+a78IrElGBu8J+WY2pq9Rph2PggMehhJ6Lxs8XMLC8+1xh
        dPPhBk46PubiUYUtfMLpaPP2foH7VbmabHbuSpPNeu7qlLnMzTf+BBW3Xn2dtM2u
        cHgF2KFFaOcui/CsmFJQNBOgoIuHOECmvhFMGxX+AdzcNb0brcCxrcIhfsuGLrL8
        jVBLMoKogB89F8lLoGumA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673650385; x=1673736785; bh=lKCV0ycAY0SFtq1SYJ0F5dfFWAI3
        C/PKOUtKuY5T64U=; b=h7tHLk4So03Ss4ZbzU95hbw5XdcLitSlfxF8xEqBfY3j
        joqrFC7z74bAP8YAbP5esYISC2yGIU8b1Egx55R5djKpVEJSvNdibHDK/PK9zCGF
        uOS8o3PHCloegp5m1Ft21Sarose/LPAvAQvydu7FsvL5YMgF3f77vlyV9z95U4vm
        2L/cmX66SFqzKcEUawqtUm1D1ikbDK+A0pHO88VUEl3q5K9TCjVn8xei29jJOiZa
        aqdN75PUUdaKyJvuaB6Raic4lKaYE7MtPNxwJP4FMeP+WLad4Rr3GBf1S33e/Eq0
        88eN3GjPn6Ggd+zIshPGDz8T8T9PfoyZ+f6JrITEyg==
X-ME-Sender: <xms:0ODBY8DY6RuCSKy1hKs8ei14XotYeEgNfvDM51g94ptZLn5i3BJQNQ>
    <xme:0ODBY-jlQ5TmHwJi7OFBAhA4mttip_uggmMKVULoKV-TlKfkIkumA4MHMTnCSTYF7
    Fo9YqvBg-Vb_w>
X-ME-Received: <xmr:0ODBY_mrtzrdIrJ9DzrMo5QCBskDEtngeyvUB4IrnxQSIPGrbl9NtRMrR6X-EjYvJTmQq547ut3C11F1URb8S6wZWIpb8SA67g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleelgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:0ODBYyxbJcG7imjuq8Dklu6XNbYfj9boTjfAqr2_DvCLFB5rN_rtKA>
    <xmx:0ODBYxQepT3qyQlR4yI0nr6pPJ7s4J7b8tINsEXME9CfYWK1N_-OIg>
    <xmx:0ODBY9ZiqivvK03r8PZFSikxrh3ofaufnbSumwH3KxvqEhXTH6DbzQ>
    <xmx:0eDBYwLcidQbQg_3PNESAxuO6rWVzK0gKXNvMRH9QqCW17WYpgZuLg>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 17:53:02 -0500 (EST)
Date:   Fri, 13 Jan 2023 23:52:59 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
Message-ID: <Y8Hgy4UHxKqh0T2T@mail-itl>
References: <20230113140610.7132-1-jgross@suse.com>
 <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4m4xLSz0QPn9icEC"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4m4xLSz0QPn9icEC
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2023 23:52:59 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen

On Fri, Jan 13, 2023 at 08:40:15PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 13, 2023 at 3:06 PM Juergen Gross <jgross@suse.com> wrote:
> >
> > Commit f1e525009493 ("x86/boot: Skip realmode init code when running as
> > Xen PV guest") missed one code path accessing real_mode_header, leading
> > to dereferencing NULL when suspending the system under Xen:
> >
> >     [  348.284004] PM: suspend entry (deep)
> >     [  348.289532] Filesystems sync: 0.005 seconds
> >     [  348.291545] Freezing user space processes ... (elapsed 0.000 sec=
onds) done.
> >     [  348.292457] OOM killer disabled.
> >     [  348.292462] Freezing remaining freezable tasks ... (elapsed 0.10=
4 seconds) done.
> >     [  348.396612] printk: Suspending console(s) (use no_console_suspen=
d to debug)
> >     [  348.749228] PM: suspend devices took 0.352 seconds
> >     [  348.769713] ACPI: EC: interrupt blocked
> >     [  348.816077] BUG: kernel NULL pointer dereference, address: 00000=
0000000001c
> >     [  348.816080] #PF: supervisor read access in kernel mode
> >     [  348.816081] #PF: error_code(0x0000) - not-present page
> >     [  348.816083] PGD 0 P4D 0
> >     [  348.816086] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >     [  348.816089] CPU: 0 PID: 6764 Comm: systemd-sleep Not tainted 6.1=
=2E3-1.fc32.qubes.x86_64 #1
> >     [  348.816092] Hardware name: Star Labs StarBook/StarBook, BIOS 8.0=
1 07/03/2022
> >     [  348.816093] RIP: e030:acpi_get_wakeup_address+0xc/0x20
> >
> > Fix that by adding an indirection for acpi_get_wakeup_address() which
> > Xen PV dom0 can use to return a dummy non-zero wakeup address (this
> > address won't ever be used, as the real suspend handling is done by the
> > hypervisor).
>=20
> How exactly does this help?

By not accessing calling acpi_get_wakeup_address() (with the patch
renamed to x86_acpi_get_wakeup_address()) during PV dom0 suspend, which
otherwise would access not initialized real_mode_header.

I confirm this patch fixes the issue.

> > Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as=
 Xen PV guest")
> > Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> >  arch/x86/include/asm/acpi.h  | 2 +-
> >  arch/x86/kernel/acpi/sleep.c | 3 ++-
> >  include/xen/acpi.h           | 9 +++++++++
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index 65064d9f7fa6..137259ff8f03 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -61,7 +61,7 @@ static inline void acpi_disable_pci(void)
> >  extern int (*acpi_suspend_lowlevel)(void);
> >
> >  /* Physical address to resume after wakeup */
> > -unsigned long acpi_get_wakeup_address(void);
> > +extern unsigned long (*acpi_get_wakeup_address)(void);
> >
> >  /*
> >   * Check if the CPU can handle C2 and deeper
> > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> > index 3b7f4cdbf2e0..1a3cd5e24cd0 100644
> > --- a/arch/x86/kernel/acpi/sleep.c
> > +++ b/arch/x86/kernel/acpi/sleep.c
> > @@ -33,10 +33,11 @@ static char temp_stack[4096];
> >   * Returns the physical address where the kernel should be resumed aft=
er the
> >   * system awakes from S3, e.g. for programming into the firmware wakin=
g vector.
> >   */
> > -unsigned long acpi_get_wakeup_address(void)
> > +static unsigned long x86_acpi_get_wakeup_address(void)
> >  {
> >         return ((unsigned long)(real_mode_header->wakeup_start));
> >  }
> > +unsigned long (*acpi_get_wakeup_address)(void) =3D x86_acpi_get_wakeup=
_address;
> >
> >  /**
> >   * x86_acpi_enter_sleep_state - enter sleep state
> > diff --git a/include/xen/acpi.h b/include/xen/acpi.h
> > index b1e11863144d..7e1e5dbfb77c 100644
> > --- a/include/xen/acpi.h
> > +++ b/include/xen/acpi.h
> > @@ -56,6 +56,12 @@ static inline int xen_acpi_suspend_lowlevel(void)
> >         return 0;
> >  }
> >
> > +static inline unsigned long xen_acpi_get_wakeup_address(void)
> > +{
> > +       /* Just return a dummy non-zero value, it will never be used. */
> > +       return 1;
> > +}
> > +
> >  static inline void xen_acpi_sleep_register(void)
> >  {
> >         if (xen_initial_domain()) {
> > @@ -65,6 +71,9 @@ static inline void xen_acpi_sleep_register(void)
> >                         &xen_acpi_notify_hypervisor_extended_sleep);
> >
> >                 acpi_suspend_lowlevel =3D xen_acpi_suspend_lowlevel;
> > +#ifdef CONFIG_ACPI_SLEEP
> > +               acpi_get_wakeup_address =3D xen_acpi_get_wakeup_address;
> > +#endif
> >         }
> >  }
> >  #else
> > --
> > 2.35.3
> >

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--4m4xLSz0QPn9icEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmPB4MsACgkQ24/THMrX
1yw2swgAk/5GqFX39AKLVH88v8kknH2HL3VTuIzqJY8+1FDQ5c7aWElrJp/WmgGR
EaqALVjRocUTHRX6/rIyg5l7R3drsEOfNLa8tNd5jlWWXRDwHlrf+eXBTlQZs9zX
a8mLaFADPonMM4XkiPfQutk/qpklvNf2ijAEfDiwsbODHa28Uzif2ysL2ZlTF2CA
rVxwY4YY9ndRkaBSR7Y/UCMP5P/f7NtbjD2UPcZVDHl0xNp89geMBuSNVHVEcMXn
tOivOdQ6IpczX6bCME1R3ewDNud+aFznTPyW9Q+ZQmYPLKXF+nzO1lQR5a/gBxyi
y1OfQ7J0s3r6JaQYvmF6O7JCgHNQ+A==
=8flr
-----END PGP SIGNATURE-----

--4m4xLSz0QPn9icEC--
