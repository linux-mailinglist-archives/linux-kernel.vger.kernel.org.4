Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283474D3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGJKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGJKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:40:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC7EE;
        Mon, 10 Jul 2023 03:40:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9741caaf9d4so497058066b.0;
        Mon, 10 Jul 2023 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688985630; x=1691577630;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67xmh9LVZnEPITxD2YUcmJFqrGxMBcWoYDKnu4sd8OU=;
        b=MkvayJ0Jv4m9lUG9hPeO2Sk9U7JdJTItupZQZNN0hK0qhYLlxr7Yypva2rkiiuOwYG
         Z6L9Rzl6YMpdkaIRcvx/+M2KapmF7H62wQjv8FunJu9xTRVF+/FOcewCj6YDRWUtxZ5E
         170gBHvl/dBUHNhnxFV8YbiCLUVUXEwe7B1klfxyq0T0eMoKQg/mr63Bh+WeSBPx7Vin
         FW+LEFgQm9jL+62O80oF/2LdMbFUdBBfQ6eW3wy4Cj0QbjzsTkJ94hsZazBJDvVlcqdT
         1ao91Ri6huYsg3U8qL5rADNu5c4rnPLyXDwJIk6/8sHcbvQulBVEogjEipkLD6xAygEf
         eR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688985630; x=1691577630;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67xmh9LVZnEPITxD2YUcmJFqrGxMBcWoYDKnu4sd8OU=;
        b=UXPr7th2boJSwyiQiYXJnCBgnwWba0tYWUZR1mq57V5jqsGa0SEdkiRp5tf3wq2EYe
         nWbWvKIWH2t9TQhZMLR1ATqC7iOfQGdAtk4ksM+Er7clxgC6xTGmzz78JA52GpzztNh4
         iT+wFtZcNGy+CIrObVn927URnlwGFr3+txmHbCYvKTvhQdpK7Tzz+LTAoUoRBNJ6ZhKb
         eGo3GnDUyQkm9H5r0FaNdGT8EznBw8YzYfeUliTRK7xrfR+MHhegVDpqCBPqwzAFW3R9
         M5a8sGVX/KGEzaKLQ16k3Pc/vSWAtFmYkHMIOTwDCCLXZ7OdOF/1OL8nGTulqa50mKUh
         E6sw==
X-Gm-Message-State: ABy/qLbod14pZvMAFOhIixvRIblBkllAilHuC4dowYCrF1q61sq69HCo
        IqaBSpgkh55GuUwfoykxcyQ=
X-Google-Smtp-Source: APBJJlHEl/N+Os9L08/l1QjO2uw8ozmQRNKcElRRC0XE2Nyi2fEqOHcZd5I3eMYuRCGyGmGHOvypUg==
X-Received: by 2002:a17:906:1de:b0:993:fdb4:327f with SMTP id 30-20020a17090601de00b00993fdb4327fmr5526132ejj.4.1688985629738;
        Mon, 10 Jul 2023 03:40:29 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gg11-20020a170906e28b00b0098921e1b064sm5893786ejb.181.2023.07.10.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:40:29 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:40:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stanimir Varbanov <svarbanov@suse.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZKvgG4-IzqiYPSUT@orome>
References: <20230710082252.9702-1-svarbanov@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pT5OYcSxwNIoLEou"
Content-Disposition: inline
In-Reply-To: <20230710082252.9702-1-svarbanov@suse.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pT5OYcSxwNIoLEou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> Add def_domain_type implementation op and override default IOMMU
> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), which
> could be enabled on some distros. The current quirk has been done
> for Tegra234 machine, because I found the issue on it. The issue
> itself appears on USB host controller which cannot be initialized
> without IOMMU translation. Something more, we proved that IOMMU
> translation is needed for display and GPU drivers as well.
>=20
> I evaluated few possible options to solve that:
>=20
>  a) select default IOMMU domain from .def_domain_type op
>  b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dn
>  c) add iommu.passthrough=3D0 on the kernel cmdline
>  d) firmware - ACPI / DT
>=20
> a) This option is implemented in the proposed patch.
>=20
> b) Since that the community has agreed that pass-through is preferred
> as a default IOMMU domain option because this will avoid performance
> impacts on some of the platforms [1]. On the other side we have examples
> where you cannot even install Linux distribution on a machine where the
> storage media cannot be detected and the system just hangs.

That's not how I read that thread. It sounds more to me like Will and
Robin had ideas on how to improve the performance and were planning to
address these issues. It doesn't exactly sound to me like there was
concensus to make passthrough the default.

Having said that, given that it's possible for distributions and users
to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy, I think it would be useful in
general to have a way of enforcing IOMMU translations if it's needed by
the hardware.

I'm not sure I fully understand the particular problems that you're
seeing on Tegra234, though. I'm not aware of anything in the USB host
controller driver (or hardware, for that matter) that would require the
IOMMU to be enabled. The only peculiarity that I can think of is the
firmware, which is typically loaded by an early bootloader and therefore
might perhaps need the IOMMU to properly map this in the kernel.
However, my understanding is that this firmware is loaded into special
carveout regions which don't require remapping.

However, passthrough is admittedly not something that we've thoroughly
tested, so it's possible you're running into a use-case that I'm not
aware of. In that case, could you provide a few more specifics (such as
the DTB and .config) of your build configuration so that I can try and
reproduce?

Thanks,
Thierry

>=20
> c) - This option involves installer's knowledge of platforms/devices
> which needs IOMMU translations.
>=20
> d) - IORT ACPI table / DT - I'm not sure is that option even possible
> but firmware looks like a good place for such.
>=20
> Please, treat this as an RFC and a call for proper solution.
>=20
> [1] https://marc.info/?l=3Dlinux-arm-kernel&m=3D148864682514762
>=20
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-nvidia.c
> index 87bf522b9d2e..691b57d1e699 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -286,6 +286,22 @@ static int nvidia_smmu_init_context(struct arm_smmu_=
domain *smmu_domain,
>  	return 0;
>  }
> =20
> +static int nvidia_smmu_def_domain_type(struct device *dev)
> +{
> +	if (of_machine_is_compatible("nvidia,tegra234"))
> +		return IOMMU_DOMAIN_DMA;
> +
> +	return 0;
> +}
> +
> +static int nvidia_smmu_single_def_domain_type(struct device *dev)
> +{
> +	if (of_machine_is_compatible("nvidia,tegra234"))
> +		return IOMMU_DOMAIN_DMA;
> +
> +	return 0;
> +}
> +
>  static const struct arm_smmu_impl nvidia_smmu_impl =3D {
>  	.read_reg =3D nvidia_smmu_read_reg,
>  	.write_reg =3D nvidia_smmu_write_reg,
> @@ -297,11 +313,13 @@ static const struct arm_smmu_impl nvidia_smmu_impl =
=3D {
>  	.context_fault =3D nvidia_smmu_context_fault,
>  	.probe_finalize =3D nvidia_smmu_probe_finalize,
>  	.init_context =3D nvidia_smmu_init_context,
> +	.def_domain_type =3D nvidia_smmu_def_domain_type,
>  };
> =20
>  static const struct arm_smmu_impl nvidia_smmu_single_impl =3D {
>  	.probe_finalize =3D nvidia_smmu_probe_finalize,
>  	.init_context =3D nvidia_smmu_init_context,
> +	.def_domain_type =3D nvidia_smmu_single_def_domain_type,
>  };
> =20
>  struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *sm=
mu)
> --=20
> 2.41.0
>=20

--pT5OYcSxwNIoLEou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSr4BgACgkQ3SOs138+
s6F74g//VwtSTp6dhR5zDoIqJA8hR6PncaF9faNfSTqWj83cNF/5VG2zJxdS2JIm
f2EHElN8YUvlQympiraEQP+DnE1SdLNbsG2j+DSQQS3h0HYmYhh2V8sLVNnY5AJ2
pacvdCD7GZfZX3E19MBcMXsqRv+IFZNFg99bMZBJeYjWm2QKtFn16piOYdzuqmLG
HuxG5u0un0WKnAM/Q35uGVdSBMueOF24pq8WrHc5FNVmzE7Z3sJ30V1g9IqJoIcU
NhqHbAfsQHt20n2r9KRnn742fj7GD0IrOI185n8B/NxoedyfhkGIJDocTiYMxgcv
x7lNmrWwzqRHE8QM96YPfqiTnokkTtZmcgH82E8mCvbHiHD3ekp83xZBfN8eY1qD
Zx3iJgs08FfFjnYFuV0Ijv+pVLNyxPZkTSv7Dy0jz7l4yYjdn9LYmw2FuX1HRZkA
NFJNVDZk2YXSEbaUgbD4qwhvRBn6veucBP3DcSfmoXB9ljF7t5LuuA1eDBEj/2j2
YknEMjnmjmScpxsNKHY55sraVWaS9Am3mQ3oXAKh6qPVxTkpMYE0EkjsBqOSlVmy
LrFXeh28dZ9oxmB/bMC3B45TDoVbljsAwV7Azm1zOSC14bccrHQlwTRMWBj57w4i
ZgAZUW1TAACUaDinTehCvBfuZisRqt/GWwm8/G0nFl7R8C6jE5w=
=9RJq
-----END PGP SIGNATURE-----

--pT5OYcSxwNIoLEou--
