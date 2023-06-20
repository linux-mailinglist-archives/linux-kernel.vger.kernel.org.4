Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DB7367BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFTJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:29:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D7A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:29:22 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0EF41EC0501;
        Tue, 20 Jun 2023 11:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687253360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWlzqwP8gXqCjOeiTZrHCHSwFsaiVGQQHxxm8rqptqM=;
        b=B0aUpAERk1IopMf2Khd4zGW6Wn9a/ort/0UVezU46OE9py/bdyCxnSj6y0d44t5ybIhOvA
        lEJk6xl2MfoR5Op7fNthvcUerBEDzSGlAXOLqp2eNktXQvTMEi5rIqbVtG1EM1DW/Vk8g3
        Zt2Pl7SCOGwBD1y5nUyWp0AMWTSfCjI=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nx4PQjQFOyxD; Tue, 20 Jun 2023 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687253358; bh=9JayRLsZBA6Sk1eXjgqLPKc/yY0N4SwLjV8/HmRDOpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkgMKjMzBfvCniOZSgGUV4SMMY5K/hg2z7YrYDDrMEAmLatVTUtYSegRAam36QFWj
         wN/5YPkDxRMA1fQBqOqZP89TSgEcXiCL6PmH2GXL6dEIdDSifVEcmk1cogFjRYD1uD
         nwhfxpt+pHGY26MbpvUz18YrCzVmPT/9tleaEHitRmuErEj6okk7ZrkF2bFghRN2/3
         JYeJcQqI9uj189Mzx/HsHEI4ePm584oMK6lj81S4ajz/oWutQMtGN5twVJBm7eUSze
         +uJwokimCEWbBCnuoq+D3dRG2u/KCIH+xjnzzZlqe5b/pn+nP5C8b9haVROyJ0G7In
         uHe7U7bjVvOqEQFFLPXGSWl4KHNKDk4bTxkPqiiIXNKO2GlZmuOeISFU007Jlnmzmw
         mARdMPmXR7hDXrbH2FQGjY1+0Ofgih93MPZODLWaDXQbxTJTyruWJTMNQ6etF7y3aR
         sh/2b1k2zn0E8BZ0107yfOzBMZhgCKpcM7JX/CivDk6UWrXePdoS8gJF6YiYNEyqRr
         ygbeooz7BiegjbEJ7xVTXQfo3q/ooa7IMsgIGvb6CPOwoRjQIg6NNLH1QtkJ4Wn73h
         nZ4idxCsaiMXqNlXpckpYCFwYI6px/p1dt/RGjiCuLQKjBF/UIm3hOQTN41VJAItvM
         +Py6CTNbHDjgveIjuXs50Kl0=
Received: from zn.tnic (p200300Ea971Dc5B2329c23FffeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60C4140E0034;
        Tue, 20 Jun 2023 09:29:07 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:29:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 6/7] x86/smp: Split sending INIT IPI out into a helper
 function
Message-ID: <20230620092906.GXZJFxYpyR2Sf9PM84@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.551157083@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.551157083@linutronix.de>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:33:58PM +0200, Thomas Gleixner wrote:
> Putting CPUs into INIT is a safer place during kexec() to park CPUs.
>=20
> Split the INIT assert/deassert sequence out so it can be reused.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
> V2: Fix rebase screwup
> ---
>  arch/x86/kernel/smpboot.c |   49 ++++++++++++++++++-------------------=
---------
>  1 file changed, 20 insertions(+), 29 deletions(-)
>=20
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -853,47 +853,38 @@ wakeup_secondary_cpu_via_nmi(int apicid,
>  	return (send_status | accept_status);
>  }
> =20
> -static int
> -wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip=
)
> +static void send_init_sequence(int phys_apicid)
>  {
> -	unsigned long send_status =3D 0, accept_status =3D 0;
> -	int maxlvt, num_starts, j;
> -
> -	maxlvt =3D lapic_get_maxlvt();
> +	int maxlvt =3D lapic_get_maxlvt();

Whoops:

arch/x86/kernel/smpboot.c: In function =E2=80=98send_init_sequence=E2=80=99=
:
arch/x86/kernel/smpboot.c:860:9: warning: ISO C90 forbids mixed declarati=
ons and code [-Wdeclaration-after-statement]
  860 |         int maxlvt =3D lapic_get_maxlvt();
      |         ^~~

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
