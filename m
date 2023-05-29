Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8F714A85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjE2NnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjE2NnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:43:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ABA0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685367779; x=1716903779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lck7HYWXjUv9FzYPBUbNMYKle2RKHVZNP7rTsjD50t8=;
  b=tqBjFXK5oMrNkbolIYD+bP0WATWx/HNleO6uh08ORoZ7GMUPajlynR70
   fgCYwFRXJQ4SnZGos2jYEZrVs3W9jO4HUE/sNscTgoPV9UmQCI68YH69B
   23xYTfm3Il4HPJPeR7kabvtEg2wljN7DDkp1ft8BLQCHlEqKO4y3O6CIv
   mIYO5349jqx81gM632+vTYOqrAnazMHFCHZPkxtj3H1TIkYU4eiMJfbJS
   9Yrw9Imn8Im3Gq6F0f8mLE0HZ/umbbeeyx+RVpctatY9iz7XhOhzz9SPY
   w6ievwhMqgq3sXRoakGNmkN+dqoNVr8W/OY1rBSfb6NJV+jhiRQDwgeKK
   A==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="215318630"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 06:42:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 06:42:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 06:42:57 -0700
Date:   Mon, 29 May 2023 14:42:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <greentime.hu@sifive.com>, <vincent.chen@sifive.com>,
        <andy.chiu@sifive.com>, <paul.walmsley@sifive.com>,
        <palmer@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
Message-ID: <20230529-jasmine-amigo-6d01f6852b35@wendy>
References: <20230529073845.2859178-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akcCoxLpoL7TwvtM"
Content-Disposition: inline
In-Reply-To: <20230529073845.2859178-1-guoren@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--akcCoxLpoL7TwvtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 03:38:45AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Some .ko also need the riscv_v_user_allowed symbol.
>=20
> ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
> undefined!
> make[3]: ***
> [/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
> Module.symvers] Error 1
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/vector.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 1c4ac821e008..3ae08816d608 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
>  {
>  	return riscv_v_get_cur_ctrl(current) =3D=3D PR_RISCV_V_VSTATE_CTRL_ON;
>  }
> +EXPORT_SYMBOL(riscv_v_user_allowed);

Is there a reason that this should not be EXPORT_SYMBOL_GPL()?

I figure Andy will roll this into this next revision..

Cheers,
Conor.

--akcCoxLpoL7TwvtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSrygAKCRB4tDGHoIJi
0oWoAP9FuWiLyHszPu/BNFTA31PQXq1uTLNjgff7dnZJXmDsRgEArXKuxMpe5bLA
ojf2vGH2BafRIK0+zNrThRf2a3sfqQo=
=YVAK
-----END PGP SIGNATURE-----

--akcCoxLpoL7TwvtM--
