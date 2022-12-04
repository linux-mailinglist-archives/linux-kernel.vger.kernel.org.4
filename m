Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E3641AA9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 05:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLDEKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 23:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLDEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 23:10:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57018383;
        Sat,  3 Dec 2022 20:10:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so8325092pjo.5;
        Sat, 03 Dec 2022 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkoUlYZqvdu1Rw1jny30zOIeihdJDczt9Lf7PXwNm1w=;
        b=GCV4j7/VUZSnYNvho3ziUO/dQwtuycdZ1mkpjfD+TMSVLLeflh4tSGFcHGnMYC/cBL
         0rVcEwTgDxK4pyZzVuDjMLOUNxE+6buP91u1OD5XEGcoygShFDJXryYtrDIKyRdYT8Cp
         JfXWAEHmaKmsg/SE6avbaDrMyEWPTGkn2ujeLtkgOJgp24Vl5uF4CshMXIA7vZatldZ1
         xw26Pl9igi5qxz4pAvYPerUD1IUocA36hS6+/FP0nu6hJgqxjs6F6IQD00pkdg6f+N/S
         cin23slIm9DuCzQ+ngT20T5MY6vIjUx4dI5+9dvPL8EW4UBZvSnBaFvfFvHIyiTKEK+h
         DSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkoUlYZqvdu1Rw1jny30zOIeihdJDczt9Lf7PXwNm1w=;
        b=zzqCD73/nOMlMkeBeBcOGNXbJuSArHZgQoiEiJC+RxfOyau3frGX9ZWv9iAuXNsu3u
         EO6QKaKq/rBhdqNdfUr0itUd6kKu51OKiHMv5IatyUYKwboAP+3nt93g5UaOyZDNBgBB
         FxKSXo6+BLfFcPfUQvCZ1ioTuiuCftRL5uyUDqoH4BPhWoqDYujo5gVNqoM8gbcMB7Or
         bz9YGxwslxZv87TAK9Aodv4tVxYynDMwm1FBnF655+ZBwAagGrzNFJLJkzYo8vCMePMS
         SU3se9TnBLUpiT24+gI5zH8uTZ90d7t1zMLQYgyl1nSrqIFAmT5nkmR+YOliOTNmpz1L
         /7ZA==
X-Gm-Message-State: ANoB5pkdXMViI62rsDkrUKY9I76I/YT/jREMmP/iM0YrGKhEHAjCW8pC
        IFYTylAZv4M2nWm43Y+GEVC64aYzFVw=
X-Google-Smtp-Source: AA0mqf7IdbLpch8z5sTZ68DXDff+M7Q1CtE7c89JAzfOmRPHBWMvaBYubqF3plAip9DIRHQTgyiOBg==
X-Received: by 2002:a17:90b:507:b0:213:971d:9022 with SMTP id r7-20020a17090b050700b00213971d9022mr84064857pjz.47.1670127029176;
        Sat, 03 Dec 2022 20:10:29 -0800 (PST)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b0018853416bbcsm8140695plg.7.2022.12.03.20.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 20:10:28 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 20D7E102ED3; Sun,  4 Dec 2022 11:10:24 +0700 (WIB)
Date:   Sun, 4 Dec 2022 11:10:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin: move OOO entries in
 kernel-parameters.txt
Message-ID: <Y4wdsB1XR5GBMKIx@debian.me>
References: <20221204013050.11496-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VIePKEwERXl8YF55"
Content-Disposition: inline
In-Reply-To: <20221204013050.11496-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VIePKEwERXl8YF55
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 03, 2022 at 05:30:50PM -0800, Randy Dunlap wrote:
> Do not backport.

Why? Why don't you want this to be AUTOSEL-ed for stable?

> diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation=
/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -378,18 +378,16 @@
>  	autoconf=3D	[IPV6]
>  			See Documentation/networking/ipv6.rst.
> =20
> -	show_lapic=3D	[APIC,X86] Advanced Programmable Interrupt Controller
> -			Limit apic dumping. The parameter defines the maximal
> -			number of local apics being dumped. Also it is possible
> -			to set it to "all" by meaning -- no limit here.
> -			Format: { 1 (default) | 2 | ... | all }.
> -			The parameter valid if only apic=3Ddebug or
> -			apic=3Dverbose is specified.
> -			Example: apic=3Ddebug show_lapic=3Dall
> -
>  	apm=3D		[APM] Advanced Power Management
>  			See header of arch/x86/kernel/apm_32.c.
> =20
> +	apparmor=3D	[APPARMOR] Disable or enable AppArmor at boot time
> +			Format: { "0" | "1" }
> +			See security/apparmor/Kconfig help text
> +			0 -- disable.
> +			1 -- enable.
> +			Default value is set via kernel config option.
> +
>  	arcrimi=3D	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
>  			Format: <io>,<irq>,<nodeID>
> =20
> @@ -1045,26 +1043,12 @@
>  			can be useful when debugging issues that require an SLB
>  			miss to occur.
> =20
> -	stress_slb	[PPC]
> -			Limits the number of kernel SLB entries, and flushes
> -			them frequently to increase the rate of SLB faults
> -			on kernel addresses.
> -
> -	stress_hpt	[PPC]
> -			Limits the number of kernel HPT entries in the hash
> -			page table to increase the rate of hash page table
> -			faults on kernel addresses.
> -
>  	disable=3D	[IPV6]
>  			See Documentation/networking/ipv6.rst.
> =20
>  	disable_radix	[PPC]
>  			Disable RADIX MMU mode on POWER9
> =20
> -	radix_hcall_invalidate=3Don  [PPC/PSERIES]
> -			Disable RADIX GTSE feature and use hcall for TLB
> -			invalidate.
> -
>  	disable_tlbie	[PPC]
>  			Disable TLBIE instruction. Currently does not work
>  			with KVM, with HASH MMU, or with coherent accelerators.
> @@ -1166,16 +1150,6 @@
>  			Documentation/admin-guide/dynamic-debug-howto.rst
>  			for details.
> =20
> -	nopku		[X86] Disable Memory Protection Keys CPU feature found
> -			in some Intel CPUs.
> -
> -	<module>.async_probe[=3D<bool>] [KNL]
> -			If no <bool> value is specified or if the value
> -			specified is not a valid <bool>, enable asynchronous
> -			probe on this module.  Otherwise, enable/disable
> -			asynchronous probe on this module as indicated by the
> -			<bool> value. See also: module.async_probe
> -
>  	early_ioremap_debug [KNL]
>  			Enable debug messages in early_ioremap support. This
>  			is useful for tracking down temporary early mappings
> @@ -1791,12 +1765,6 @@
>  				      which allow the hypervisor to 'idle' the
>  				      guest on lock contention.
> =20
> -	keep_bootcon	[KNL]
> -			Do not unregister boot console at start. This is only
> -			useful for debugging when something happens in the window
> -			between unregistering the boot console and initializing
> -			the real console.
> -
>  	i2c_bus=3D	[HW]	Override the default board specific I2C bus speed
>  				or register an additional I2C bus that is not
>  				registered from board initialization code.
> @@ -2366,17 +2334,18 @@
>  	js=3D		[HW,JOY] Analog joystick
>  			See Documentation/input/joydev/joystick.rst.
> =20
> -	nokaslr		[KNL]
> -			When CONFIG_RANDOMIZE_BASE is set, this disables
> -			kernel and module base offset ASLR (Address Space
> -			Layout Randomization).
> -
>  	kasan_multi_shot
>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>  			report on every invalid memory access. Without this
>  			parameter KASAN will print report only for the first
>  			invalid access.
> =20
> +	keep_bootcon	[KNL]
> +			Do not unregister boot console at start. This is only
> +			useful for debugging when something happens in the window
> +			between unregistering the boot console and initializing
> +			the real console.
> +
>  	keepinitrd	[HW,ARM]
> =20
>  	kernelcore=3D	[KNL,X86,IA-64,PPC]
> @@ -3325,6 +3294,13 @@
>  			For details see:
>  			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> =20
> +	<module>.async_probe[=3D<bool>] [KNL]
> +			If no <bool> value is specified or if the value
> +			specified is not a valid <bool>, enable asynchronous
> +			probe on this module.  Otherwise, enable/disable
> +			asynchronous probe on this module as indicated by the
> +			<bool> value. See also: module.async_probe
> +
>  	module.async_probe=3D<bool>
>  			[KNL] When set to true, modules will use async probing
>  			by default. To enable/disable async probing for a
> @@ -3779,6 +3755,11 @@
> =20
>  	nojitter	[IA-64] Disables jitter checking for ITC timers.
> =20
> +	nokaslr		[KNL]
> +			When CONFIG_RANDOMIZE_BASE is set, this disables
> +			kernel and module base offset ASLR (Address Space
> +			Layout Randomization).
> +
>  	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
> =20
>  	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
> @@ -3824,6 +3805,19 @@
> =20
>  	nopcid		[X86-64] Disable the PCID cpu feature.
> =20
> +	nopku		[X86] Disable Memory Protection Keys CPU feature found
> +			in some Intel CPUs.
> +
> +	nopv=3D		[X86,XEN,KVM,HYPER_V,VMWARE]
> +			Disables the PV optimizations forcing the guest to run
> +			as generic guest with no PV drivers. Currently support
> +			XEN HVM, KVM, HYPER_V and VMWARE guest.
> +
> +	nopvspin	[X86,XEN,KVM]
> +			Disables the qspinlock slow path using PV optimizations
> +			which allow the hypervisor to 'idle' the guest on lock
> +			contention.
> +
>  	norandmaps	Don't use address space randomization.  Equivalent to
>  			echo 0 > /proc/sys/kernel/randomize_va_space
> =20
> @@ -4591,6 +4585,10 @@
> =20
>  	r128=3D		[HW,DRM]
> =20
> +	radix_hcall_invalidate=3Don  [PPC/PSERIES]
> +			Disable RADIX GTSE feature and use hcall for TLB
> +			invalidate.
> +
>  	raid=3D		[HW,RAID]
>  			See Documentation/admin-guide/md.rst.
> =20
> @@ -5572,13 +5570,6 @@
>  			1 -- enable.
>  			Default value is 1.
> =20
> -	apparmor=3D	[APPARMOR] Disable or enable AppArmor at boot time
> -			Format: { "0" | "1" }
> -			See security/apparmor/Kconfig help text
> -			0 -- disable.
> -			1 -- enable.
> -			Default value is set via kernel config option.
> -
>  	serialnumber	[BUGS=3DX86-32]
> =20
>  	sev=3Doption[,option...] [X86-64] See Documentation/x86/x86_64/boot-opt=
ions.rst
> @@ -5586,6 +5577,15 @@
>  	shapers=3D	[NET]
>  			Maximal number of shapers.
> =20
> +	show_lapic=3D	[APIC,X86] Advanced Programmable Interrupt Controller
> +			Limit apic dumping. The parameter defines the maximal
> +			number of local apics being dumped. Also it is possible
> +			to set it to "all" by meaning -- no limit here.
> +			Format: { 1 (default) | 2 | ... | all }.
> +			The parameter valid if only apic=3Ddebug or
> +			apic=3Dverbose is specified.
> +			Example: apic=3Ddebug show_lapic=3Dall
> +
>  	simeth=3D		[IA-64]
>  	simscsi=3D
> =20
> @@ -6025,6 +6025,16 @@
>  			be used to filter out binaries which have
>  			not yet been made aware of AT_MINSIGSTKSZ.
> =20
> +	stress_hpt	[PPC]
> +			Limits the number of kernel HPT entries in the hash
> +			page table to increase the rate of hash page table
> +			faults on kernel addresses.
> +
> +	stress_slb	[PPC]
> +			Limits the number of kernel SLB entries, and flushes
> +			them frequently to increase the rate of SLB faults
> +			on kernel addresses.
> +
>  	sunrpc.min_resvport=3D
>  	sunrpc.max_resvport=3D
>  			[NFS,SUNRPC]
> @@ -6957,16 +6967,6 @@
>  			fairer and the number of possible event channels is
>  			much higher. Default is on (use fifo events).
> =20
> -	nopv=3D		[X86,XEN,KVM,HYPER_V,VMWARE]
> -			Disables the PV optimizations forcing the guest to run
> -			as generic guest with no PV drivers. Currently support
> -			XEN HVM, KVM, HYPER_V and VMWARE guest.
> -
> -	nopvspin	[X86,XEN,KVM]
> -			Disables the qspinlock slow path using PV optimizations
> -			which allow the hypervisor to 'idle' the guest on lock
> -			contention.
> -
>  	xirc2ps_cs=3D	[NET,PCMCIA]
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[=
,<irq3>[,<irq4>]]]

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--VIePKEwERXl8YF55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4wdqAAKCRD2uYlJVVFO
o58FAP0U1rATTEDxe7Rcppcmtm+yb0rCtrM6cZn/ofrvJynC+wEAsn0gGAuyCnbC
OOno0O2ehaM8YNdq8/MfFucLm4W5ygo=
=q+ij
-----END PGP SIGNATURE-----

--VIePKEwERXl8YF55--
