Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309547048CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjEPJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjEPJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:15:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A847299;
        Tue, 16 May 2023 02:14:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2766976066b.2;
        Tue, 16 May 2023 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228373; x=1686820373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GOhU2oI+496DW24zv9Mv2MLzO4ODqcy9YDlBxdb2bU=;
        b=gEe95t7pSd6sF1Fj9aFSD2yd98a/FITzJ5+28X9AifjVNeF18BVmD2Ylq34s1DISYn
         CR0ttsoFyYdK36awA+ogNTrvXdoP7nVspV1bHNuJyYtvLnoB4VhGzWnTZDkfIRitBamw
         mjfJD3YOswzBB+2Z0h08aHz5ZfJVcwdoGuLgq+kzvXr0vTTuKeGIWzlCnzyvk7eM1fOr
         Knb/25SnaWcX+C00uSmPyAsJlkYg7GHfmcRwcO/WvPBFyUb21NK2xOlTM+5s5F9BJYGW
         QF9PyaiixXNaaADN16nNkSfvAr2gj7pBdYpbb/z+SvPM8BeDol3akchscumFgmvtC3GE
         Skcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228373; x=1686820373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GOhU2oI+496DW24zv9Mv2MLzO4ODqcy9YDlBxdb2bU=;
        b=CVJH5iZfaweWyquEzgYfU0vXtKOkcB2opbZFEhCjY7LM5Kl/4aKXs4NI1mzGdmN7Xx
         U0kDWS+Li/QimxUhjgHCExKPaDwyB5MCw5dNkJidol2vTLG2eA4Z+s7PVAjO2eL6YzVb
         V2faiMj9M8iFoOC38Ilk7dQDfCDfjB0K1bel+RKFVd4N8mQlldGAiIU4F+RK2TDbpihW
         y18Dz9+htoC3RIfhujGT/tdtDjQGn9Gkaav25U2lHfyWrEs5uL2Rp6z6c3N1uEuEmyJk
         QhVW7IvRR1wpgLguJokMCcnkZqwZuB2RLytfiLyJZCYO12Z2e0EzjTnZqeMXf7q5CUiG
         8ohA==
X-Gm-Message-State: AC+VfDzpkmxVDO6HxSZevrypklwkEs7OcW5oL27Gl9lDnMMtQlkvSYQ6
        wvu9tpHcmWtKozeSyfqSHThYP7EnAItl4Q==
X-Google-Smtp-Source: ACHHUZ6iN8jRZYgIpg+X9X5ZlJ1oLB0hcu0YfBFv5YC+XCpUyc8MOD3OCDmtgwJ8iMjUEi7XEgn/UA==
X-Received: by 2002:a17:907:360c:b0:94a:845c:3528 with SMTP id bk12-20020a170907360c00b0094a845c3528mr32474838ejc.45.1684228372446;
        Tue, 16 May 2023 02:12:52 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ig13-20020a1709072e0d00b0096623c00727sm10751140ejc.136.2023.05.16.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:12:52 -0700 (PDT)
Date:   Tue, 16 May 2023 11:12:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
Subject: Re: [PATCH v4 4/6] dt-bindings: Add support for DRAM MRQ GSCs
Message-ID: <ZGNJEoiFmtPiLC4p@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-5-pdeschrijver@nvidia.com>
 <20230511-carnivore-legend-17206803d713@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LUMos0kZAPiI9kG3"
Content-Disposition: inline
In-Reply-To: <20230511-carnivore-legend-17206803d713@spud>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LUMos0kZAPiI9kG3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 08:21:07PM +0100, Conor Dooley wrote:
> On Thu, May 11, 2023 at 04:20:49PM +0300, Peter De Schrijver wrote:
> > Add bindings for DRAM MRQ GSC support.
> >=20
> > Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>=20
> Perhaps Krzysztof will disagree, but looks fine to me, with some minor
> remarks below.
> Just to note, I didn't get the cover letter & therefore didn't get the
> changelog :/
> I know you had a back and forth with him about that, *my* =E2=82=AC0.02 i=
s that
> either you put the changelog in the cover & send it to everyone, or you
> put it in each patch.
>=20
> > ---
> >  .../nvidia,tegra264-bpmp-shmem.yaml           | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/n=
vidia,tegra264-bpmp-shmem.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,t=
egra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory=
/nvidia,tegra264-bpmp-shmem.yaml
> > new file mode 100644
> > index 000000000000..4087459c01db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264=
-bpmp-shmem.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpm=
p-shmem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Tegra CPU-NS - BPMP IPC reserved memory
> > +
> > +maintainers:
> > +  - Peter De Schrijver <pdeschrijver@nvidia.com>
> > +
> > +description: |
>=20
> You don't appear to have any formatting to preserve, so the | is not
> needed.
>=20
> > +  Define a memory region used for communication between CPU-NS and BPM=
P.
> > +  Typically this node is created by the bootloader as the physical add=
ress
> > +  has to be known to both CPU-NS and BPMP for correct IPC operation.
> > +  The memory region is defined using a child node under /reserved-memo=
ry.
> > +  The sub-node is named shmem@<address>.
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra264-bpmp-shmem
> > +
> > +  reg:
> > +    description: The physical address and size of the shared SDRAM reg=
ion
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - no-map
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +       #address-cells =3D <2>;
> > +       #size-cells =3D <2>;
>=20
> You also do not need these size/address-cells, because...
>=20
> > +       dram_cpu_bpmp_mail: shmem@f1be0000  {
> (nit: double space                          ^^)
>=20
> > +           compatible =3D "nvidia,tegra264-bpmp-shmem";
> > +           reg =3D <0x0 0xf1be0000 0x0 0x2000>;
>=20
> ...the 64-bit registers here are both 0x0.

I think Peter had to add these explicitly because the defaults are 2 and
1, respectively, and DTC was warning about this. I suppose the "reg"
property could be adjusted to use the defaults, but on the other hand I
find that it's good if the examples match reality and we need size-cells
to be 2 on Tegra.

Either way is fine with me, though.

Thierry

--LUMos0kZAPiI9kG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRjSRIACgkQ3SOs138+
s6EfBxAAjyFZlouN7/tDexGyNQxSpkLcX5xD6D92vOBmgFZAXft989Ks584z6kiB
TtJmyH0khLqruPZ2EPhK96AVnGupRf7fEPy7QJeQK4dXXBibOB99n1F+ipIvjSif
uNNDz9DpahS+zHWTF6QgANXL6MgiR/K1NsSC4KBo1nsZFMzc2fgJ2djlTaDpyWNd
J184WeXeh6qYSZdWy7sa7wNg/58u+Nkmg9p9g1Jy2ifastKdnFm4edaLgoevtMcg
oS+NkgBaLpH8fT3yf1CyigWOfmx/tdkbM+60nZzhmGSK9gYs+MlJsOmWi4pRHe0u
EwKrKQ0K8fOBT1Mi2GSywoEzTaQ91Bq94R5nGmD9czfQWXQsWIKhYwvnqfPiUzjr
5xNQmtH3pMc4JG5L8MVQCByHkt8SOcuVhAQaFVXEUrafBH5hEVc9urGJ4gW7wUt5
oQBgLcx9Mk1ltjcEfWHB+LGdVfMiYArKU6nQnFSt8x7mWF2+OPoAqUXo59IhUAKs
I8InqNXUnUM8zKxg1uqnvzluDWpGsiY12xVV0Jg6eGyUMVcVCUOlvC3jaBfJ9FMv
cvZ7jJuX4LK00FmqaoeTtHytDjjniEtYv71qnl6VJLqYo063ZK+eVIrBsH4dgZp5
uLVphLq0P0NbO8pgWRbscN278kyGnB7mbOE4kyc616kKLnc2HoI=
=1B8+
-----END PGP SIGNATURE-----

--LUMos0kZAPiI9kG3--
