Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA562D5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiKQI63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiKQI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:58:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969AAF0AE;
        Thu, 17 Nov 2022 00:58:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q1so1384392pgl.11;
        Thu, 17 Nov 2022 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ9ZxjX57kwb30C71sba//gk+gZEGdW190kHtCvB7Hg=;
        b=S1ab9MoZstgPPAI5vJ7+Bj9f6F7q7Bb3NbZJRcrCBUkgvVLAB6ARKVFOFFuFlD7nhA
         I7tq4W12mH2AbIMAPoPunpuAwYl+bdNp/lVfn3RclJIeFvHykVDIhrj5sgb4CSN+bK1v
         qxwxhsD0VXuk6s5iuWYUNDmtlMXGOT6cqyKKir86JKp4KuU/7553hzp4By/5We4Cm5WM
         nXEwqCw4I2ck0eXCtUWjz0fY37+MoLr9MZzitpZ5i4EbS9hZvm0l9R3asfsAmLi+fJ1I
         FE/fw3iWTbcmYIxCyrE/iS369apsHpB/NWLYSZFsYOV/ifm5RYCxHfAv6xCY8UwJHhQa
         rAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ9ZxjX57kwb30C71sba//gk+gZEGdW190kHtCvB7Hg=;
        b=GL7jbv+CQb+B0XdhSn15OLeRPZaRFKagGQsqvU3Mv2T702A6kZ3o+np9f9DyIBEgdj
         E/0/A9Ppspc/7RVLG09sSSiFQYIJOJ8PBr2OO3Ajdhe4Wd9feUhGLiPbOcMRudmE1yBp
         ygYDD2JyDjqm3pRGxqMw3/PIBtOR7wFi/aAmi7WHfO2NWSJ/algQIEGfGh0SQDYgAnHe
         feEAebMvekerEpPZUdz+Ojm6kBfpwm3R5KyNMBJev8hTcL90t40jVVwlm6AzQS6OKWKR
         ZfknmtzIE4Kg+lVGIHAGMj/VhqbvlCL4hpwmzRZ/1Tac9yANgWxvYaljiUIk60fMLXdH
         1zzQ==
X-Gm-Message-State: ANoB5pmkOTjR7rDK47PFbEnvX/bSci+A3J+6+e1pj20nGhhaIxM+CRGe
        dmteK8FpLSRMWTd3DiOiwLc=
X-Google-Smtp-Source: AA0mqf6x5epLhpu/Eot8mVr1R57n3W9gQnK9htqODLZrcuV5TtXl2tz3dSloLWomm/+iitcF6BILZg==
X-Received: by 2002:a63:4081:0:b0:46f:e657:7d25 with SMTP id n123-20020a634081000000b0046fe6577d25mr1170397pga.347.1668675498368;
        Thu, 17 Nov 2022 00:58:18 -0800 (PST)
Received: from debian.me (subs09b-223-255-225-238.three.co.id. [223.255.225.238])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b00561b455267fsm557219pfh.27.2022.11.17.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:58:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 66BE0103240; Thu, 17 Nov 2022 15:58:12 +0700 (WIB)
Date:   Thu, 17 Nov 2022 15:58:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Documentation: amd-pstate: add driver working
 mode introduction
Message-ID: <Y3X3pPtOGX5UWsUK@debian.me>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
 <20221117073541.3350600-5-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K0BtVwehgRpOdXb+"
Content-Disposition: inline
In-Reply-To: <20221117073541.3350600-5-Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K0BtVwehgRpOdXb+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 03:35:40PM +0800, Perry Yuan wrote:
> Introduce the `amd_pstate` driver new working mode with
> `amd_pstate=3Dpassive` added to kernel command line.
> If there is no passive mode enabled by user, amd_pstate driver will be
> disabled by default for now.
>
><snipped>...
> -.. _shared_mem:
> -
> -``shared_mem``
> -Use a module param (shared_mem) to enable related processors manually wi=
th
> -**amd_pstate.shared_mem=3D1**.
> -Due to the performance issue on the processors with `Shared Memory Suppo=
rt
> -<perf_cap_>`_, we disable it presently and will re-enable this by default
> -once we address performance issue with this solution.
> -
> -To check whether the current processor is using `Full MSR Support <perf_=
cap_>`_
> -or `Shared Memory Support <perf_cap_>`_ : ::
> -
> -  ray@hr-test1:~$ lscpu | grep cppc
> -  Flags:                           fpu vme de pse tsc msr pae mce cx8 ap=
ic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx =
mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cp=
uid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1=
 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy sv=
m extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wd=
t tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 c=
dp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bm=
i2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt x=
savec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clze=
ro irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save t=
sc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic =
v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overf=
low_recov succor smca fsrm
> -
> -If the CPU flags have ``cppc``, then this processor supports `Full MSR S=
upport
> -<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>=
`_.
> +Passive Mode
> +------------
> +
> +``amd_pstate=3Dpassive``
> +
> +It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the kern=
el in the command line.
> +In this mode, ``amd_pstate`` driver software specifies a desired QoS tar=
get in the CPPC
> +performance scale as a relative number. This can be expressed as percent=
age of nominal
> +performance (infrastructure max). Below the nominal sustained performanc=
e level,
> +desired performance expresses the average performance level of the proce=
ssor subject
> +to the Performance Reduction Tolerance register. Above the nominal perfo=
rmance level,
> +processor must provide at least nominal performance requested and go hig=
her if current
> +operating conditions allow.
> =20
> =20
>  ``cpupower`` tool support for ``amd-pstate``
>=20

Why do you replace shared_mem subsection with passive mode section? It
isn't be mentioned in the patch description.

--=20
An old man doll... just what I always wanted! - Clara

--K0BtVwehgRpOdXb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3X3nAAKCRD2uYlJVVFO
o29pAQCXPZIXwgIZkekQbTgHNsOz+RXJCSPLTyjuDsswtCxkYwD/fcvq/eRf6L8Y
9A34lWHgIqfNcRkdVMB/YTdfu76vKg4=
=BJTP
-----END PGP SIGNATURE-----

--K0BtVwehgRpOdXb+--
