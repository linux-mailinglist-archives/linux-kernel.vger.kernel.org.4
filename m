Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1526406E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiLBMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiLBMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:36:00 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469DFCCB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:35:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z4so5265318ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mVfZx+5SZWHF/rzn6Dn1bgtGaqrI8G9edfutTST++8=;
        b=NLbxbOqszmxX9f7VRQ5cyeR/+zLbLcIQKZ+4BdyRuRFJUUEszNu1/yJIks8gwIP8fU
         j9IGIeSW0L5WPrX4uwjVCTzpYBS0Xfyx93tOTTs3vplZYLFIjZfKMciwnOgOkuXlbIID
         NDQVIWIQi+E/xucQAIO962tmZP4fSXg+R5NxWUlbBqmi4SdLHSo9qpSYqSm5f5JCdeby
         bEyqJoGD6AZAvzUXgRMZRKzjqCW1d0Bk6mBQ/WlxAe3RMCz9Q7ubYABraXy43nSiq6WF
         hr2xMabgN4NqWxfDA9AtfLL0LxuLjgWHyUCdaF1d6vMC4TjkvKC93BZGOWfWqasr2gJg
         5YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mVfZx+5SZWHF/rzn6Dn1bgtGaqrI8G9edfutTST++8=;
        b=V93S6DI11cqHeGF+4iZAsaKEbyXzcec7XdqljdqgvSnqd4OGCCvKBK5NSNqk832PRb
         viMmEdv9GJHDQwwWV1+EzyCI8JfsTJYlCy67SIGAgeEpn5TCwjxDypahd/cyxom3ZTWO
         keEsWAlNIAEWJbRDHkB0GWi/p8j6V9uASVrPSPPiIAqRBfSqKD2/iT0o1M/azqJaaVDp
         lqPi+/76L6Ib4Hcq+ZmbfOqhlmOV1sPLY65wWqbgFRPk6l4qcbFEWS3YJ9taGavaPoCC
         X+xvMC4YUxqKk6zR2sjitcqaHpY0N2LVAF0zaysJi4I5MGlTEvbTGA7da/PL59O0YeIQ
         KCzQ==
X-Gm-Message-State: ANoB5pkAsnRrf0JW5+V0b7PZie/N3+XtMdFxTNjx9+LPH+ZXqhEr1at7
        8VZwY8hGIryioXGpAaCJIB4=
X-Google-Smtp-Source: AA0mqf4uC79LG0MkXzDQl7hq4Bxub6xWpXRdzge1iwzF6na5IL5HLhs1g80PjVnGbqIZ9NHyrnk5Lg==
X-Received: by 2002:a2e:3512:0:b0:277:c68:874b with SMTP id z18-20020a2e3512000000b002770c68874bmr20798723ljz.261.1669984557692;
        Fri, 02 Dec 2022 04:35:57 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id m6-20020ac24286000000b004b501497b6fsm1001311lfh.148.2022.12.02.04.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:35:57 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:35:47 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Karol Herbst <kherbst@redhat.com>
Subject: Re: [BUG] lockdep splat using mmio tracer
Message-ID: <20221202143547.3ead0246@eldfell>
In-Reply-To: <20221202072028.40b62728@gandalf.local.home>
References: <20221201213126.620b7dd3@gandalf.local.home>
        <20221202104334.649dacdf@eldfell>
        <20221202072028.40b62728@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_rVfk51wGqS=6u5YCFd05wN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_rVfk51wGqS=6u5YCFd05wN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Dec 2022 07:20:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2 Dec 2022 10:43:34 +0200
> Pekka Paalanen <ppaalanen@gmail.com> wrote:
>=20
> > On Thu, 1 Dec 2022 21:31:26 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  =20
> > > I hit this while testing ftrace on an x86 32 bit VM (I've just started
> > > converting my tests to run on a VM, which is find new found bugs).   =
=20
> >=20
> > Hi Steven,
> >=20
> > sorry, I don't think I know anymore how mmiotrace works. Surely the
> > kernel has changed in those more than 10 years since I last looked at
> > it. If I'm still listed as a contact for mmiotrace somewhere, maybe it
> > would be best to drop me? =20
>=20
> You're still listed as a Reviewer in the MAINTAINERS file. Which means you
> only want to see patches (and possibly review them), but doesn't mean you
> have to fix them ;-)
>=20
> >=20
> > I don't mind the emails, it's nice to see people hit or touch it, but
> > I'm afraid I can't help.
> >  =20
>=20
> Nice hearing from you too :-) I'll only drop you if you ask.

Do people have expectations from people listed as reviewers? If not,
I'm happy to stay. If yes, maybe best to not give a wrong impression,
and drop me.


Thanks,
pq

--Sig_/_rVfk51wGqS=6u5YCFd05wN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmOJ8SMACgkQI1/ltBGq
qqc7Ug//QuZh3dAkDQ9ZhRu4tRE0ZjLUu9PS8/cE7VJaHLo7Ulu6ahYiVg5ok+dL
V2L9vRXsLeMI5mv5bPHPt3pC33p0MAAn7+TmbHvY/dZdPhNhOxta8rH+Fo59gwgY
KPbd1WOIb9bt1zBkGlSLDEJsTsFnXHyZ+cHurrhKaTBdefYL/EG/QZcFccBKpc8E
AOKAPMLAN6uHBL2qhBlkMDfbPa1sLeEq/JkHvP9wKLz257GzqIwfoZC84NoEHWCe
ZawYfk+MACgANeHP7UN//aOK/N3LIFran+2onAXbofkdVwHfTaS77auPa5Zep3EQ
IlpPbPmxOc8dJxt+caSKG5VBEw1QX4llYoGfnMe6PyXv0u8KOab3EsNtx/7cPGXl
nvfrXzzLYfNQiDZqcjNMx4RdcnmAb0tMQMn6/oAjKJqfnJfk690CcenKiakXcihL
/bp/2lgwPPubJe5wy9VOq8W0SHOKUd6lltF7Ss3Oa1x7JnqpHv+HkbiX4ocDVwCK
55kpJMIFl7TQJEImOmVkgHiZIaXTNt/FDOeQ2r+C60sR3c6xvzghRj06+biP2Znv
+L2naBxaH4vUwGAjMJCOnUy8kJkorQcy9J1JJFUR9ZwE9+HkeKS9eZA1qJoSb5tl
Q3VNXNMmYGepFQfOsBtm4gs1RXlq+Hya0cyuOb+iy662IEJUAUU=
=R6qk
-----END PGP SIGNATURE-----

--Sig_/_rVfk51wGqS=6u5YCFd05wN--
