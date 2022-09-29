Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70995EFE1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiI2Tpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiI2Tpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:45:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304861C612E;
        Thu, 29 Sep 2022 12:45:30 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.59]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsI0I-1pXLCj2IyA-00tns0; Thu, 29 Sep 2022 21:44:59 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 5018E3C0EE; Thu, 29 Sep 2022 21:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1664480681; bh=/IdJ/iIOnaSJvNrs5eWWK6bLbVF1qoMoWNVY5xgybgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJeD9ZktKIGUe7odDOSO9lIhA72OKyPU7cGeIpO4Q9fxk675D3DeF2gkBCu9Up8Ce
         9iDodBraXtRiWMVqfgtolBr5IrSXaHW56WKm2H4jBldsWhohA45Vu7TeazVI/6Cg0I
         raj8HkDAetPGdZ1KJOvVwrJMB439T0e5YsHoU8Ok=
Date:   Thu, 29 Sep 2022 21:44:36 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: simplify esi object addition in Makefile
Message-ID: <YzX1pC8KpAwLFzfq@fjasle.eu>
References: <20220929181715.2504087-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tq5f2PmMQquE+b+1"
Content-Disposition: inline
In-Reply-To: <20220929181715.2504087-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:TmOsAeIV+WN5ZcZgZbtSZvQ0lIlIcYig/S1kFd9BhuGxqH7yWfd
 EV8Rt0i8Fm8HpgysL2gZArxD8GyqMZU6e+rJJP/cvqMMfGR2eJrY9mYIkDVQYATUW9+agH+
 pL0h92MXNtPNJB6acO2yS/8JyDbx9LH44+NQvm0zFdbLrlSrkNhrWfpfdiQ/gToHF6cLRiP
 UcykgXQzSngPsj4EAUTTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UlYbnXWmEg0=:oFh6/PnQzsl/VKLSINNy+7
 enqcqupYhrFYPe8A9mzPVE+g30gXNn0H1Ew+lZhxB2Kl+JtDRhxlHEYupym9PSQc8Ap4phVry
 bK1HwOCNsodwyUqc9RHzFBRE806MfOMswCxpODMkG7634A5cLBYepfNUJnlenAFLLFJpRsZaN
 KiWvI4IHJLM2uHDb4gMd/EtDzujItFSHhWmFt78Rv1txu3QAF0YJyMMDjLk/ZsmSNgoyhVAhl
 y/h6cVFcRaMMXbj8mLk8nfdt5a8ynBSWpz3lCO3OQ4x5OwC7IRBEcXhL8J1e10BPB+D7R8vpd
 +RSKmA6zj/SAf/XqObic5vSTgY6t19MsupWGxPmeTtAt2HrCMShO1Dp0IICv+zdJqwQ6+bLBe
 tyMGB7Z3ePhy1sAqUD/AJMVBSj/IQgLe49Vqkm8Oxy28I6sY+GKtplhyhxy70lncVEbtqj/mo
 ZuIZek+9irK5tq4sgS2GemgXfI6vYFIk0Gf6Rc7W3UPRE/2ua4pBWOOuyL7/clV30eR+vQO85
 6Yx5lLMcUjPkEjXlCnVeOFfEU/XRFSHv9mrq6h8VkIAtRiZyrfTCiCzh+ZYR6iqAvdbQMNaqz
 0Qr4bc6B0NawGRkPyvg02XK/WQRjbStie6KCG3WR4RIiPXD6e/7Zu8BpehOw+ZceH3ePMiVrY
 EZT/s06P2q8J0ZLmjLAeGOul5YOedmfOCR1oUOwllDVgj0rdXh1n6D/FNawotOZNB36XmA1u4
 ZQNo3L+8gHMFP+GYAL9uU8505MfFSmlxbqNv0ONU7iKhJCoSdsBcDqJxeQpv/ANYYlRs7mo1z
 ID2IN++
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tq5f2PmMQquE+b+1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 03:17:15AM +0900, Masahiro Yamada wrote:
> CONFIG_IA64_ESI is a bool option. I do not know why the Makefile was
> written like this, but this should not have any functional change.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/ia64/kernel/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> index 4a1fcb121dda..ae9ff07de4ab 100644
> --- a/arch/ia64/kernel/Makefile
> +++ b/arch/ia64/kernel/Makefile
> @@ -34,10 +34,7 @@ mca_recovery-y			+=3D mca_drv.o mca_drv_asm.o
>  obj-$(CONFIG_IA64_MC_ERR_INJECT)+=3D err_inject.o
>  obj-$(CONFIG_STACKTRACE)	+=3D stacktrace.o
> =20
> -obj-$(CONFIG_IA64_ESI)		+=3D esi.o
> -ifneq ($(CONFIG_IA64_ESI),)
> -obj-y				+=3D esi_stub.o	# must be in kernel proper
> -endif
> +obj-$(CONFIG_IA64_ESI)		+=3D esi.o esi_stub.o # must be in kernel proper
>  obj-$(CONFIG_INTEL_IOMMU)	+=3D pci-dma.o
> =20
>  obj-$(CONFIG_ELF_CORE)		+=3D elfcore.o
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--Tq5f2PmMQquE+b+1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM19ZUACgkQB1IKcBYm
EmkEbBAAm5UCu4BTNWub0JzpHT+zh4G3HV6bTXxys44FjP8YWOp6s7CJU6XMiWMo
UMQDondudm8qiED+ubk1gihfQTfAtwSLO5rXf1mrxqFbJ2n9eazvitBYM4v7uxsh
M4BMCjPXCxSvbsfbzYCe6qodGc6nmT1/K+fXovJwl7I0WxCzOyELi3O4s5U/rsiU
osB2pNSN9X0nqywj7iaEsPYYswXVXN4QhXg2ogKEKsei41E7pZVWaix+JwPPYosa
81YK+18IyCCzVwXiQ8FsHBas6hxHVl2/l1XfhQoG/heQ7ZfbBSlDl7qSKceblDb4
Ue3cG365ejb2ghYtb3wBCH/WE3wDZ7H95OsCWbubJbr+TwyXLX5jlwV5cf9RoE2s
cw8jiX5nnmBTiIPt0ithvI0BfppjJAfjZkBVYzujpVVDgmKLV6HGfshg3xFDOmMJ
M9C1EIiapWWwnoISfgp/QL4YCFcP2lIE9Wgq88Dz9bd2dN43kStvxTu7uUkfgdr8
O0bYOv5etL8TrDAY63OEJ2d0RnttwFJnLLf8lrq3f0GT98Lb1OzS40rK8bE759VI
uZOyeRl3ntWl18HBIXnB7LVt6SDfMiwLrty2i+iFGFzDNxl9GYlZG4aqnLwt1EeG
gMuZeNVk5HzpdSqsxIs36jN4QeK/M7FiXlKPeeB2VB6q4EiifhU=
=23js
-----END PGP SIGNATURE-----

--Tq5f2PmMQquE+b+1--
