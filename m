Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702576739C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjASNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjASNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CB113CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674134207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICTXnwd6Can73IBUDK0Kd0Dz0sJD+IpzxuL1dlMdbsA=;
        b=U0mVuQ8/dfcywesZB5fiD5QiT4HdOUQL2s4uDe2kBQ5qxys2ueCoe6+IacS54OaMyoRnt9
        OhfundatETCQlrBuVWuR03dBSbl3V0gs4A54O9qiWd7n0jLPjoxkVy0VHeSWRNS6wJLIyC
        ej0Zqs8N9PeuujPe0hNXUNCmsUMCq6U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-v4iRnjPTONmUIC1xeNPNFw-1; Thu, 19 Jan 2023 08:16:39 -0500
X-MC-Unique: v4iRnjPTONmUIC1xeNPNFw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14D941C08985;
        Thu, 19 Jan 2023 13:16:36 +0000 (UTC)
Received: from localhost (unknown [10.22.8.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF9E492B03;
        Thu, 19 Jan 2023 13:16:35 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:16:34 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8lCspFtQ0wg6uCy@uudg.org>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RrHfV96HQrxQVFBx"
Content-Disposition: inline
In-Reply-To: <Y8krsVFguwWLy+zT@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RrHfV96HQrxQVFBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > I'm pleased to announce the 5.10.162-rt78 stable release.
> > >=20
> > > You can get this release via the git tree at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > >=20
> > >   branch: v5.10-rt
> > >   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> > >=20
> > > Or to build 5.10.162-rt78 directly, the following patches should be a=
pplied:
>=20
> > I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [=
0] Full log [1]
> > Any pointers on what maybe wrong?
>=20
> We see the same failure.=20
>=20
> >   AS      arch/arm64/kernel/entry.o
> > arch/arm64/kernel/entry.S: Assembler messages:
> > arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand=
 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13=
)|(1<<7))'
> > make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Er=
ror 1
> > make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
> > make: *** [Makefile:1837: arch/arm64] Error 2
>=20
> The line is:
>=20
> >        and     x2, x19, #_TIF_WORK_MASK

I believe this is related to the arch/arm64/include/asm/thread_info.h
changes in 5.10.162-rt78, specifically:

    79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
    1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt

The first one is the original change, coming from stable v5.10.162 and the
second one has the merge conflict I fixed in that file due to the existence
of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.

It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
statement reported above. Looking at

    b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()

specially this note

    To ensure that _TIF_WORK_MASK can be used as an immediate value in an
    AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
    renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.

I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
to 8, with the risk of breaking something else, or backport commit
b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
TIF_NEED_RESCHED_LAZY.

Guidance is welcome here :)

Best regards,
Luis

> And I believe there were some cleanups in stable in that area. Let me
> search for them.
>=20
> Best regards,
> 								Pavel
> --=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


---end quoted text---

--RrHfV96HQrxQVFBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmPJQrIACgkQ85SkI/jm
fCbnbA//Zj+o1GrFLzhK3mDWQHoDRlUtgAEk0ctO3VLzBr8SZTskqJW1x47Ihfgq
BNFy7MLSniqu7fyJgEzH/0arW/+3qoOy0T61NybJv5HIUj00m37Ah4CVjVXNSpGB
Io9uCy6JdbzEmhDGAZ1iSjvowjhlzKcdM9226BVn0BMMJqy2s2j6BCykZn7YabmI
h4VelQTIJYlfSvxZsp0iK3l3Z9GRCDoSyduvnRX07siiWOZfXRRHp2XIhEHKvE/R
3LXrqYv576mF2nfY0QIYo27rhJd4RZ1X7ADKfGx13pZVyObNsyoKwdtGyQqnynRD
lxfYMW3B0mwXfrhR5soYvv/xaSqthNthjkxY+3oNTpltYxx0DzESXxXywefNseZE
3KITzG8drms7H9bzw8tVVwHeD2KtrkswsUNRCNyDpsI4klyujxwZWubkrgMd1Ja9
wGDrP+f3OGzlv62qVgBMfVV8vMrO4Xlvr/QqKywqFkAmwiX7BnDFuhSpcwQrZruF
rgEyCCFmIpDwejWGVH5ccl0tU6d5psju8taFO6ImPI9bACJ8UxqsgnGgkIl6iJRH
HCa0RRSQ5zmSj4ZOKbLUrAnNhcSmwELKdrMNI7rstN2a0hIsRxK8o5RE81sPOJAg
nppOugBmH75Jce8q5m0ZbtnJ0CrDgfM7hsH65ZgwDGiEmWGX55E=
=V2rh
-----END PGP SIGNATURE-----

--RrHfV96HQrxQVFBx--

