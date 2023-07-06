Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A5749DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGFNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGFNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:40:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B03C102
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688650853; x=1720186853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/81oDQkmGKtnd4/wqBTupaOz43I6AitvqZt9E5SYXc=;
  b=KfrlN8QAkFBRbCBSKxrZM46wxNsqKS1fg4Hqm77S2xzBhjyukpemeAjz
   b21u2FcP5qFkeQ4UUQD7eftAwurIWE30QRI8rtv6DRrnDI17Bb4w/iG7K
   oW7acNnbWwddf5EnMIZ1IwHg97wddu/OtVQKCQ/D9fliIOEDd09j/lT9N
   l7iRQtQ2bS4H3yUrx5E3mFgAenY5jJg4MiOTVq8jhMyxtnKJrJJ1QEpZO
   bAu9aJPjg0Zgq6sE/dJrgGEd8xE368TYTLoyg0T6CKz/tlggnDr07TK6f
   1KWFgno1Nyvd7g0YhQXQXEGFmyBYt9TYv/p4OxgoZon6JYc6nbUOA7OVq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="221644701"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2023 06:40:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Jul 2023 06:40:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Jul 2023 06:40:49 -0700
Date:   Thu, 6 Jul 2023 14:40:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, <linux@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH v2 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230706-amused-entrench-3ce9cb6769ef@wendy>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
 <20230628131442.3022772-2-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dzDOUZFT65799+Vx"
Content-Disposition: inline
In-Reply-To: <20230628131442.3022772-2-sameo@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dzDOUZFT65799+Vx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jun 28, 2023 at 03:14:33PM +0200, Samuel Ortiz wrote:
> From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
>=20
> Parse Zb/Zk related string from DT and output them to cpuinfo.
>=20
> It is worth noting that the Scalar Crypto extension defines "zk" as a
> shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> Zbkx, Zkn, Zkr and Zkt extensions.
>=20
> Also, since there currently is no mechanism to merge all enabled
> extensions, the generated cpuinfo output could be relatively large.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> will generate the following cpuinfo output:
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
>=20
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
>  arch/riscv/kernel/cpu.c        | 11 +++++++++++
>  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index f041bfa7f6a0..b80ca6e77088 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,6 +53,17 @@
>  #define RISCV_ISA_EXT_ZICSR		40
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
> +#define RISCV_ISA_EXT_ZBC		43
> +#define RISCV_ISA_EXT_ZBKB		44
> +#define RISCV_ISA_EXT_ZBKC		45
> +#define RISCV_ISA_EXT_ZBKX		46
> +#define RISCV_ISA_EXT_ZKND		47
> +#define RISCV_ISA_EXT_ZKNE		48
> +#define RISCV_ISA_EXT_ZKNH		49
> +#define RISCV_ISA_EXT_ZKR		50
> +#define RISCV_ISA_EXT_ZKSED		51
> +#define RISCV_ISA_EXT_ZKSH		52
> +#define RISCV_ISA_EXT_ZKT		53

Getting mighty close to running out of space in a u64 :)

I'd personally rather get my changes to this extensions stuff merged
before adding more extensions, but I am clearly biased in terms of
saving my own work there, and it'd not really be "fair" to hold it up
on that basis alone.
However, since Palmer has now merged the "riscv,isa" deprecation [1],
adding parsing of new ISA extensions, now requires documenting them in
the extensions dt-binding. Can you please do that in v3?

Otherwise, this looks good to me:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/=
?h=3Dfor-next&id=3Daeb71e42caae2031ec849a858080d81462cacca9

--dzDOUZFT65799+Vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKbEQwAKCRB4tDGHoIJi
0lvyAQDOlhMFzc/aebCsGlYplaJMkiIMvB67bUS85TfWRP0MggEAshANcfwpb0uM
HROGzze0T29pn3uFAX8/Z+CqjBhj5A0=
=nxpS
-----END PGP SIGNATURE-----

--dzDOUZFT65799+Vx--
