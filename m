Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285626D6D78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjDDTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:53:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03621A8;
        Tue,  4 Apr 2023 12:52:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so135430881eda.0;
        Tue, 04 Apr 2023 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637976;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36+7aMVMhxPiaZSDInCq5WZoJFXnceFIbbddWnkZGAA=;
        b=EbxUB1Cz8pmEOeH6pX192ejW9siDp508olpuKSO6s5OJTZtTu6Fe9ih8QasR6FXtuH
         L8PEtdbyhsTyMFLzbg4rwzdBHx7PAdfup51jxbhvD0aInffwYgwLsnRrW2inAY3WTyZk
         eeNdlL5nvlaS1YVQlQs+Bnw32B7Q57Dz9ZbjQXJ6IMZGlbxfWWVlxI++LJyqfhRKF7ow
         z5RS1IoQuKyOk/rU0w4zC0bwZLB27sTPOqkxw3wNDVUuVmpm04Mg/IzzyRx3NTh/WWKe
         Q9zKp3sDJAq2WKS06J2ZvvpvP+FoqtCps0VeMKvUmVwCroIyBfAK5tWUiA3Un+PO889L
         9/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637976;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36+7aMVMhxPiaZSDInCq5WZoJFXnceFIbbddWnkZGAA=;
        b=P2GPk7B8Kdax2t3Nc+/Q40nYp5eKHz29zAQvOWLRJDEtW/dtgnlNMSRy+p5Qw3kQsI
         WqW/zQcLqUnK0S66XKqTgliBx0bMY+sSr0tdPVH9SYGqIlWU5NgNbBMxezbfSLaNa3i6
         iCfMzZCwhZGn3jIzA6SkO3G/tErOWEzre35fjuERMC//ENEPA0LygeUxge5UHPQcQlyW
         PCuDDnlHT9shnrAu2XH3h/fIbBKST1MZAA7TTco9/YMWanlWF5Auefkq2/bBfxFQ88/3
         /F0M92anQ4ETgCgIAuwTGkEOjKqFx8BMPvw/tOpUaLSFiNm3p13qM7qD8v19G2krPXh8
         /V3A==
X-Gm-Message-State: AAQBX9dSdVUsXMr3NnBv0z1nTkSUyvC+GFYjq5SYHQN67cZMi1/RJkf3
        p4sBQflvxo4SVkTxIZ4VPqMjJy45+Nk=
X-Google-Smtp-Source: AKy350Z21fXi6LMGQHNRL6QVxiE6JPhpjRpfFo2FYbHjU2CuzE9G5Zoxm2dxLbIU4FXi2l4tADQ+xw==
X-Received: by 2002:a17:907:8745:b0:933:1702:a12b with SMTP id qo5-20020a170907874500b009331702a12bmr737071ejc.17.1680637976201;
        Tue, 04 Apr 2023 12:52:56 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906a28c00b00946e6dd887csm6292277ejz.126.2023.04.04.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:52:55 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:52:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] firmware: Use of_property_present() for testing DT
 property presence
Message-ID: <ZCyAFhY0xVy8Q0Yk@orome>
References: <20230310144704.1542045-1-robh@kernel.org>
 <20230323120030.7mk62xk7tco32zw2@bogus>
 <ZCwmWoZhMOlHnnzf@orome>
 <20230404165846.GA49361-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EV9WiWkvTmZhpxvQ"
Content-Disposition: inline
In-Reply-To: <20230404165846.GA49361-robh@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EV9WiWkvTmZhpxvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:58:46AM -0500, Rob Herring wrote:
> On Tue, Apr 04, 2023 at 03:30:02PM +0200, Thierry Reding wrote:
> > On Thu, Mar 23, 2023 at 12:00:30PM +0000, Sudeep Holla wrote:
> > > On Fri, Mar 10, 2023 at 08:47:04AM -0600, Rob Herring wrote:
> > > > It is preferred to use typed property access functions (i.e.
> > > > of_property_read_<type> functions) rather than low-level
> > > > of_get_property/of_find_property functions for reading properties. =
As
> > > > part of this, convert of_get_property/of_find_property calls to the
> > > > recently added of_property_present() helper when we just want to te=
st
> > > > for presence of a property and nothing more.
> > > >=20
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  drivers/firmware/arm_scmi/optee.c | 2 +-
> > >=20
> > > Acked-by: Sudeep Holla <sudeep.holla@arm.com>(for the SCMI part)
> > >=20
> > > I am assuming you will route this as it has other changes as well in =
the
> > > patch.
> >=20
> > I can also pick this up along with the Tegra changes if Rob doesn't
> > want to take it. But also feel free to take this through whatever tree
> > works best, for the Tegra parts:
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> You can take it. Thanks.

Applied now, thanks.

Thierry

--EV9WiWkvTmZhpxvQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQsgBYACgkQ3SOs138+
s6EnWg//c7WQrukK4feUgU8dH0K8IO0ecq7TdKAaG2qzAY/nmrcVweH4fkoOQzu5
RMw7p2Cwc6gS+oty/bX/jWBuFAKVYfyjDCYmRPbvhwQD4DxvD6uT7v+DmIGA5aCu
5cwT/I5vLLqJZhxbmecB+ByLRe2EO8TKTCKs7G3iydO/OUt8wW3DeOzGf/Rr3568
+ZntYrBRXvJ6KBBJ8ghTr54daiJK2AN6QGX8GFvtzxGZ77733DPuOI5LImK/j6vw
czfc0BpUWTmNnlKAm82b729R32gTGWHlE50tb6MLQaO4Z0qjt97K+fCxPfcuVut+
2wqMMYRT+ZyI07ySV5o3YKuXYFoqBAZeHEkuQ3OUoYH6KS47x6A86HbXhfohU6wT
iNstMGArkdF4eFOc846WZuKDqiY3PFCp3fNN/pF8T4Jkt77tuM1EDU6O5/pDkTg9
FZ7KOFRqbNV00SnM52M+8TJ99GaugoxmXbsxX/aQh3rqiqOBrBbdGjF9UbphFtQD
lx7ZSSgTCtuMOBl5gbDeJCxBsfZCnsPdtFA2LzsR44dTzOyOaGWNkzd65EjVz0gG
P4/mcvxoxMj9h08QHuzHtmKIxam9x34UyCoXdmYM1LhKYi/SHsSNX8Ehk6oU09xb
xVMIeWlKk5hO5hmr7IdyO0vFR0wPjzvrOYKCBJOK/kKNsH4hBi0=
=M5/M
-----END PGP SIGNATURE-----

--EV9WiWkvTmZhpxvQ--
