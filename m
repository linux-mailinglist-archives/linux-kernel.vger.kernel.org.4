Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDD7068E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjEQNHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ACD1BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684328806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ricdlEvGEUBLNA0MniTa/NJPkEIbLbsrJ3rrWmsjOC8=;
        b=P8gzYDSiEl7RudGTLBEuhcp25uhVNZZn4RyzvLlabxm4npHuQoE6+pXEHOgin+6jk/TWlF
        D4qVd+bYVlZq6rDS6apFTBCvPcpfT6V7HW638aybFVl/EJ4lq3d589JPd/tn7V9f88J3ua
        txr8ndDzkY+nla9CUHQ+8W2kiDggzoA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-I_4TdqUoMhGbrdvh5kWDUg-1; Wed, 17 May 2023 09:06:42 -0400
X-MC-Unique: I_4TdqUoMhGbrdvh5kWDUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852211C0512D;
        Wed, 17 May 2023 13:06:41 +0000 (UTC)
Received: from localhost (unknown [10.22.32.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26A882166B31;
        Wed, 17 May 2023 13:06:39 +0000 (UTC)
Date:   Wed, 17 May 2023 10:06:39 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     nobuhiro1.iwamatsu@toshiba.co.jp, jan.kiszka@siemens.com,
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
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: 5.10.179-rt87 (was Re: [ANNOUNCE] 5.10.175-rt84)
Message-ID: <ZGTRX5hb0rK7MQSW@uudg.org>
References: <ZBebYGllb3f9sOOS@uudg.org>
 <ZGS2sTPKvvNHyzGH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0l8oaj5e51kAaOmh"
Content-Disposition: inline
In-Reply-To: <ZGS2sTPKvvNHyzGH@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0l8oaj5e51kAaOmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 01:12:49PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > I'm pleased to announce the 5.10.175-rt84 stable release.
> >=20
> > You can get this release via the git tree at:
>=20
> Are there any plans for new -rt release?
>=20
> Last I see is:
>=20
> Author: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Date:   Fri Mar 24 11:52:56 2023 -0300
>     Linux 5.10.176-rt86
>=20
> There's pending one in rt-next:
>=20
> commit 5f84852113c1391abe8c38defdda562640bb3808 (origin/v5.10-rt-next)
> Author: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Date:   Fri May 5 14:40:10 2023 -0300
>     Linux 5.10.179-rt87
>=20
> ...but "real" release would be useful for us, as we could base our
> -cip-rt on that.
>=20
> Thanks and best regards,
> 								Pavel

Hi Pavel,

We are submitting our stable v5.10-rt kernels to kernel-ci now, to avoid
problems our local tests were not able to uncover. The process is new for
me and, while trying to streamline the process on our side, I seem to have
hit a problem. Please allow me two more days and you shall have the release
in hand.

Best regards,
Luis


--0l8oaj5e51kAaOmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmRk0V8ACgkQ85SkI/jm
fCZmFw/+JRazR6H+Er/SohhaI8jiXtsrNABOCzMeDxiEF7DG3IQmJU5RM1kQ6iAw
sRDmF1NFpEKKcumDbwn1J1OCmVPb8opUI+D/Yu3y2asuK6q34g8yYydTwYzSSsVb
hjn1oL9D8XL78sAPIPcPxHdE2xKzSzLpMQ7T3CHHBODgGKwHnWTmm1ZvZ2xBIUlA
coVEddcf6kw6WhN9hQnpDAXRc2C7G8zlu1zyvc62pXEsS3cw3aiPf6HabQxkvQwy
tkIrkNB+fUxlz6mBlFqOIUxJp1kbAp/5rqFeQRs1HEUdoQli/njSHe/iQY3dM6w3
tV2k28OpKWi9E+0pet51cV//WvoLGnlKUZjlXilwCWqNBBiKhJxmsVDdbzE3UVIO
Lrv00CdoWHK98zvxBIbTnsXJF6CKSnD0prlLpZinOse2/VMGOKXjyWqttxVt7efF
KvJ6MjGGp7uZN//M3tmc1i4ZWLWkkSUZRpWZuyKy480J8MG9PTH3HMrHvmp03KmD
1JzEV6JUJGlD758WwJuvoVekl4t5QshqDY3VkxNN+7u4sipUqG7lqrA0TiFsqVYR
Ez0sYGwlbq2BV0mJKyr6ai+dXK3/s4a2XADHr7O02lQ8RG1WEksTuK2ajzOkL34N
xBamXkeVZE2CBlOtYf27ffa/e+AvikQcid9FUSUkfJXAmx1UMg4=
=cGnq
-----END PGP SIGNATURE-----

--0l8oaj5e51kAaOmh--

