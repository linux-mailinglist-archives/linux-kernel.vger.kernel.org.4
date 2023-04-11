Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017A6DD093
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDKD6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKD6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:58:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD898;
        Mon, 10 Apr 2023 20:58:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5144043d9d1so388045a12.3;
        Mon, 10 Apr 2023 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681185497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKdZbWy4jwijLOLOEbSGdVMaYn7h020PIX2k8NqOSZo=;
        b=YrArys0C7zjnMXda4FNLCkoSe1ZR7omGasqB9hnue3Q7HAupxVPI6UK7beT/uGuvja
         8y/LqVgcrR3izzc9X3/+OdYf2z37VnS7WXUXCWw6T+iqkAbZdnu+Cf7L9lMtgOG9NG1W
         hoUcVNhKxbHCp8frLvuPSA9rs0U1o0VvdyitT1vEPfaNQuWJ9q2xYejzMuOXJt5ZwZbG
         Dy2Fegfmn3Ullz8d56mPDmqsE66ZtaRK2itNkhntx36NKTUSPr8PvxyoFC2wz35JE3wW
         Y+3Jz51rICr2drVzy1BZlekWvBehp1s5uRf4kTSRcQIOG0srViccIv9dRu+TVf7PT4Um
         PU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681185497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKdZbWy4jwijLOLOEbSGdVMaYn7h020PIX2k8NqOSZo=;
        b=ymhemzUwUXb6icS1uNGcgqN9lQ4+1mAqtC6SSX7wEGIDotjk9jKuqaCYkf6rySXsaM
         G5zfo8TRAXzGchDa97ULQ3BR3dvokB5iDTsYIiQwlT3scQbZG1X8RBqi9jQJX3YnONG/
         MpW0W/mLm1Rdapjz/BeSrXTuZcKu9rKY5/dRlCrxx4HCIR5U4aceQIhTrdNjuYIvt9s2
         cMUGyIz/IIOViY7q+JaXFxgLRWpotTS9/vtJUHC+s+DIbKbI9pN57sr2t/Vn5sSS+0r7
         qVWe7hPbQ+bn1VqbEO7PXYuwcyoTSKen3yRbVjTmniGZfMrRhWaIlkmVWXjfWNIUcxOJ
         1a3Q==
X-Gm-Message-State: AAQBX9eQhMgdnDkJHwv7OhwPzYSqYrFdikTRDnWyL55NIajqtiWF9Xl5
        JIbuw+8En4MQKmaLS4gq4yg=
X-Google-Smtp-Source: AKy350a8JeUjpoVeuqE3YRFo8p8V7nDdkF3nlUt2GK1vtwEhCLk5pvrKsjKo89MfDwv/aSNlxzxU7A==
X-Received: by 2002:aa7:948b:0:b0:635:56c3:4bb6 with SMTP id z11-20020aa7948b000000b0063556c34bb6mr8221749pfk.27.1681185496759;
        Mon, 10 Apr 2023 20:58:16 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id d1-20020a63ed01000000b005133f658f1asm7598272pgi.94.2023.04.10.20.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:58:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 09C681068DD; Tue, 11 Apr 2023 10:58:12 +0700 (WIB)
Date:   Tue, 11 Apr 2023 10:58:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/Documentation: Add documentation about cluster
Message-ID: <ZDTa1PbEqcyrhJsU@debian.me>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <20230410163527.1626-3-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JhsElS4CpgPS1dxo"
Content-Disposition: inline
In-Reply-To: <20230410163527.1626-3-kprateek.nayak@amd.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JhsElS4CpgPS1dxo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 10:05:27PM +0530, K Prateek Nayak wrote:
> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.=
rst
> index 7f58010ea86a..35991d8cdef1 100644
> --- a/Documentation/x86/topology.rst
> +++ b/Documentation/x86/topology.rst
> @@ -33,6 +33,7 @@ historical nature and should be cleaned up.
>  The topology of a system is described in the units of:
> =20
>      - packages
> +    - cluster
>      - cores
>      - threads
> =20
> @@ -90,6 +91,27 @@ Package-related topology information in the kernel:
>          Cache. In general, it is a number identifying an LLC uniquely on=
 the
>          system.
> =20
> +
> +Clusters
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +A cluster consists of 1 or more threads. It does not matter whether the =
threads
> +are SMT- or CMT-type threads. All the threads of a cluster share the sam=
e L2
> +cache.
> +
> +Cluster-related topology information in the kernel:
> +
> +  - cluster_id:
> +
> +    A per-CPU variable containing:
> +
> +      - On Intel, the common upper bits of APIC ID of the list of CPUs s=
haring
> +        the L2 Cache with lower bits set to 0.
> +
> +      - On AMD, with Topology Extension, the common upper bits of the Ex=
tended
> +        APIC ID of the list of CPUs sharing the L2 Cache, left shifted to
> +        remove trailing 0s.
> +
> +
>  Cores
>  =3D=3D=3D=3D=3D
>  A core consists of 1 or more threads. It does not matter whether the thr=
eads
> @@ -125,6 +147,11 @@ Thread-related topology information in the kernel:
> =20
>      The number of online threads is also printed in /proc/cpuinfo "sibli=
ngs."
> =20
> +  - topology_cluster_cpumask():
> +
> +    The cpumask contains all online threads in the cluster to which a th=
read
> +    belongs.
> +
>    - topology_sibling_cpumask():
> =20
>      The cpumask contains all online threads in the core to which a thread
> @@ -138,6 +165,10 @@ Thread-related topology information in the kernel:
> =20
>      The physical package ID to which a thread belongs.
> =20
> +  - topology_cluster_id();
> +
> +    The ID of the cluster to which a thread belongs.
> +
>    - topology_core_id();
> =20
>      The ID of the core to which a thread belongs. It is also printed in =
/proc/cpuinfo

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--JhsElS4CpgPS1dxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZDTa0QAKCRD2uYlJVVFO
o8bSAQCKg98KN3Qnlstb665jkFCvsedDcoxoMR2GR6qKmjGR9gD+IqyIoN/hwb22
29qvJ4250RNiyDU/MpLzSvk5Pfm7MAY=
=c5Hj
-----END PGP SIGNATURE-----

--JhsElS4CpgPS1dxo--
