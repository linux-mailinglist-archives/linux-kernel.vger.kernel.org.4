Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA587480E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGEJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:31:33 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 02:31:31 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464F12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:31:31 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3CADA142E5B8;
        Wed,  5 Jul 2023 11:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1688548952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N91GSQSf/ZVTw48cRDiCTRncT28+ArXOR0Qp0l1WhaI=;
        b=fatiFh20DMnYcftb/kqew0Z8qEetOxFHdmdGGWPRx4w781HpzEI75QJLxtsJf4Q0vmzlZE
        huzLnHbecXU2PK2UO/WzWszXMyrywpkuAydRr0AH6HcWPvuwQryn3sTmkdXUw5TSh2hPZ1
        rUfL4DlQx6ub6cGDjeupI/Y5K1X1w30=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Budi <budikusasi@gmail.com>
Subject: Re: Anyone outright understand explain please,..
Date:   Wed, 05 Jul 2023 11:22:19 +0200
Message-ID: <12240448.O9o76ZdvQC@natalenko.name>
In-Reply-To: <CAH0GyZCNSif21TkX4Rt5HusgHhz8DsD2se4-UMa-KfiPc2Z9Mg@mail.gmail.com>
References: <CAH0GyZCNSif21TkX4Rt5HusgHhz8DsD2se4-UMa-KfiPc2Z9Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5689937.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5689937.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: Budi <budikusasi@gmail.com>
Subject: Re: Anyone outright understand explain please,..
Date: Wed, 05 Jul 2023 11:22:19 +0200
Message-ID: <12240448.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 4. =C4=8Dervence 2023 9:46:17 CEST Budi wrote:
> Anyone outright understand so to explain
> What linux kernel #n (n is small number 1,2,3.. so on) acquired on
> just compiled one in kernel package 7
>=20
> such like
> $ make
> ...
> ...
> ..arch/x86/boot/bzimage (#4)
>=20
> $

That's a part of UTS_VERSION (see init/Makefile) that gets auto-incremented=
 by the init/build-version script each time the kernel is recompiled from t=
he current source tree without cleaning it (aka removing the .version file)=
 first.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5689937.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmSlNksACgkQil/iNcg8
M0uNnw//fdaK1OhQb6bes0ZVlJrAzh6fJcjjN/MWzoCsti2on6sryDeRetKUxict
U8AJDh/hlsL2gZOCNtkeGbJTOCMe5ZiJc4AQwaV9pAes8UsPU3iXFSfg8pcw4V9J
Fu+1vVlXqdfmtmHAC9NlzriPvK4HdRajRXQSPf4Dh4IRFKqo+bxAN+ZLOXQym92u
UhXIgdiNx177xC1f0u5D6b75MJlCOuXAixppA6/yERFczk3IpG89BEgasePD7Y2D
JD2z+UQy5Kk51LQXdo1zat+otgCS6e9z6ftFmBYcKr5th8r0fTUx/FLWUmzFklMI
czJdB0BKHWsmcn8vBK9G/KwdV4fzBKZEppxtYzjL6pjikfNds4Qjeq/hgMvfFPJG
0dsnUv4mfA0DgMBFq0CFRH8OcpwGtiENOwIe1vr2J+D6jkSxvqTPpFShXlR9asYF
SjC7AcIZLKdcLOfeNUjgGX459uMk1/wdK86rtJuzWKFb0OvxXEr+elYzK6lfTPR6
8pD9ZZu/2gYoiZLl25h0Nb1qFxwmxu1533zz175oILmeQYLeUXjli6YSYx4mJ8Vx
20Ehq8sn9C+i3rUBWkV8DypF+EW9zGvohprZzHIAiv5aOnoFYNuR00wPOTpng+hv
dI9IJ05voogaAflxOmpqbEMY92zj9pCoSMklaqZ5LPcTFoIlBgQ=
=QElp
-----END PGP SIGNATURE-----

--nextPart5689937.DvuYhMxLoT--



