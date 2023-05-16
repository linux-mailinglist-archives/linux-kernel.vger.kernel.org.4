Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5289E7048D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEPJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjEPJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:16:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D24EDD;
        Tue, 16 May 2023 02:15:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so25225555a12.1;
        Tue, 16 May 2023 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228495; x=1686820495;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWRz/dtuEAlvoTpK4wwHN8J++rGj37sontn+jndrmPM=;
        b=Ecx6GH5pLKCyWaPjaCt8A98NT9jc7KikKMZl+YDWl70ubboIGL4S+BMYdWGAYxvx77
         owY7/HOmWSQVbfvLaY1YlTQqVx3TOeD8MBIpwCc+9SW6I6/4dMEqUgOoPlfUR1FoYI66
         CeueIUpF20fcplgX1d38vKT6tjt2MzuURE+9X0B2X+k2RPwudeiYHAYFQZrEL+6YcvZV
         Ggl9zhjQp9Ztl/yz1TzBjaqLXW/8JNlS1kW6qo+9F8hLTREOhbe1n5lHCwIXu5/+9/6j
         w8BE2bPiM9DYXwbhFW3KcFLebmBPSLhFqXZLUrq686lAUmxjlC5lwMctJ+tK1JVffaFR
         VD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228495; x=1686820495;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWRz/dtuEAlvoTpK4wwHN8J++rGj37sontn+jndrmPM=;
        b=CtjdMsim2wXMvVdI216aoCNDDWirGZZlT2Xq8hzwQjmq2Wss7SLzzshXA6/nvvvTm2
         65Aam9j7+gfh2HPRMNilV13YDwLTUhaorR/oGld2kKdZ3QK3FtnPDHKiVlaYBh7f16x5
         MUGKGgpdTCJ5MaJnXR/ouBXlVozEw6Rk1BJwq4EPPLifnXHrMaBmsBfZNe5AxtJO9v8c
         rL4xDBVfFWVnmUtnoLdlyGf0gu0X+YapUeS5EqCFPBfbwfWFUrIHb0dvIdZr4IqbxXWC
         4a1SaSvx8VUGzmxa2dCfhD8tQfVlCKif+O3n0y3UkJEJuPkSv2aTcLR8nXlrTN71cujj
         E8aA==
X-Gm-Message-State: AC+VfDxpyzYPOT6jir9vSweGHlypAAStdDTlLoWi9zwDZaGpFgKu38LD
        8IhaFsY0d2xfCyKaisRHqEs=
X-Google-Smtp-Source: ACHHUZ72S8q+djK5XS8l8jM00K5FNc0ejOx8zT3psl9bAI6+DgUhqL04tf2ZZiw3IgdChZKZczUyNQ==
X-Received: by 2002:a17:906:9b89:b0:96a:6939:11af with SMTP id dd9-20020a1709069b8900b0096a693911afmr15263419ejc.50.1684228494940;
        Tue, 16 May 2023 02:14:54 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kz23-20020a17090777d700b009659fed3612sm10589445ejc.24.2023.05.16.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:14:54 -0700 (PDT)
Date:   Tue, 16 May 2023 11:14:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
Subject: Re: [PATCH v4 5/6] dt-bindings: Add support for tegra186-bpmp DRAM
 MRQ GSCs
Message-ID: <ZGNJjFOUFZ2rYu5X@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-6-pdeschrijver@nvidia.com>
 <80ff83ab-d5e9-7a00-1099-a752330ef28d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9J2Kz8gt9fDKhsNu"
Content-Disposition: inline
In-Reply-To: <80ff83ab-d5e9-7a00-1099-a752330ef28d@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9J2Kz8gt9fDKhsNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 08:45:22AM +0200, Krzysztof Kozlowski wrote:
> On 11/05/2023 15:20, Peter De Schrijver wrote:
> > Add memory-region property to the tegra186-bpmp binding to support
> > DRAM MRQ GSCs.
>=20
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>=20
> >=20
> > Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  .../firmware/nvidia,tegra186-bpmp.yaml        | 37 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186=
-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpm=
p.yaml
> > index 833c07f1685c..f3e02c9d090d 100644
> > --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.y=
aml
> > +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.y=
aml
> > @@ -57,8 +57,11 @@ description: |
> >    "#address-cells" or "#size-cells" property.
> > =20
> >    The shared memory area for the IPC TX and RX between CPU and BPMP are
> > -  predefined and work on top of sysram, which is an SRAM inside the
> > -  chip. See ".../sram/sram.yaml" for the bindings.
> > +  predefined and work on top of either sysram, which is an SRAM inside=
 the
> > +  chip, or in normal SDRAM.
> > +  See ".../sram/sram.yaml" for the bindings for the SRAM case.
> > +  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for binding=
s for
> > +  the SDRAM case.
> > =20
> >  properties:
> >    compatible:
> > @@ -81,6 +84,11 @@ properties:
> >      minItems: 2
> >      maxItems: 2
> > =20
> > +  memory-region:
> > +    description: phandle to reserved memory region used for IPC between
> > +      CPU-NS and BPMP.
> > +    maxItems: 1
> > +
> >    "#clock-cells":
> >      const: 1
> > =20
> > @@ -115,10 +123,15 @@ properties:
> > =20
> >  additionalProperties: false
> > =20
> > +oneOf:
> > +  - required:
> > +      - memory-region
> > +  - required:
> > +      - shmem
> > +
> >  required:
> >    - compatible
> >    - mboxes
> > -  - shmem
> >    - "#clock-cells"
> >    - "#power-domain-cells"
> >    - "#reset-cells"
> > @@ -184,3 +197,21 @@ examples:
> >              #thermal-sensor-cells =3D <1>;
> >          };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/mailbox/tegra186-hsp.h>
> > +
> > +    bpmp {
> > +        compatible =3D "nvidia,tegra186-bpmp";
> > +        interconnects =3D <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
> > +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
> > +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
> > +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
> > +        interconnect-names =3D "read", "write", "dma-mem", "dma-write";
> > +        mboxes =3D <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB
> > +                            TEGRA_HSP_DB_MASTER_BPMP>;
> > +        memory-region =3D <&dram_cpu_bpmp_mail>;
>=20
> I am not sure if difference with one property justifies new example...

It makes sense in this case, in my opinion, because both memory-region
and shmem properties are mutually exclusive, so this is a good way to
make sure both validation paths are tested.

Thierry

--9J2Kz8gt9fDKhsNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRjSYwACgkQ3SOs138+
s6HJeA//V9jHTmp8k/QOCnT9ZE9dGCF6Ng9NBjuIxqan2up3nyUTy8UBwXnai5UP
mop1HVvUeyfzHFo481s8QN9Luj5O94MaQuI14GeO+tmMAhQXiK7XPPOwpalrFgRn
Y0FY1wb33xwRVfDat4AdrB/WFwRX5XpN0Is084sBCyQMXVcNDcoGq/4S9hOLF53Y
YByRM6Np74N0Me30CgTEfWzOZ0s25D5YinlEB0TEVdShXlfdQdaKvNkv/j/4xQvp
MMhV7QlVa/16EjftOvNPodJVmxauxa0nwSYWyP5Ia2xZRk1/DF54CWtETf5Dvca4
1+mcMhuwtyPePkq88KtQorUSS6Pp8Nrey0YPPlrQxQDbw/M492fxDV7HFwhqmhfq
sKcFohb/2767aEPDQld2Zr9yYvAeBZLSPmrqpyM+Ae3Aaz2yCkvbocCeYn1dKLGK
T9pv6WPTQ5T1LKwwoyMjM/qhvN5r/bCdYYWjjRr4bRm7vR04QIqWfowckTdedfyq
ZuvUEUtMEI1ckK8t3sJYkfM9GgmkNp4QhKxd2wPLmAPGWWkH1qBFmtW0ZGPQSThl
nlaNMryce8HiL9d+LtNoHY9Dm/qGAhKINfmVkF2VOgP21QGyJl7OkHjRW7ILBRaf
PGWK31d9loM3wm8XKsTp1J2NpAruywcDHT44yZXn2nHzpmTEiNw=
=OXT8
-----END PGP SIGNATURE-----

--9J2Kz8gt9fDKhsNu--
