Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA34646845
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHEbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHEaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:30:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FF950F9;
        Wed,  7 Dec 2022 20:30:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so3431721pjr.3;
        Wed, 07 Dec 2022 20:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9J9egNIrKEH6gSzkm3nX2FAWcpfOqH1vV2sOBbvy3uA=;
        b=m9AnZWn2bXXlYNXjsXasmSIsh5Otzjx5suQ8Kasdj7k6PTAU2nSpSDncsFbSNeLW0d
         oJUmZeiEUXtxvlBmyp5Gfv7Lo84QIJogUMhhqKYQhgehWz1cCdkoNt4yhZxX4xdzbuLZ
         lQMfnab43pn+FuZWe35KEsPOu36pB1KxWGMERST0/dgUhDnaL/JVsfnVPZeN42UP1i9N
         hQQEDxJUNAz85RBeHA8fWa2Ns2NfNAaX/TgwW/EOzdHH1d0AxfuGY2uLelvCR9m7pNWZ
         LMPRrLGK+prqaDoV2ca/RFe2NIZq6LErkYIluJTS2BpUWsbLAkZJ4HkcVEHDSyj5MtNv
         pDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J9egNIrKEH6gSzkm3nX2FAWcpfOqH1vV2sOBbvy3uA=;
        b=fOjfwtfY4WAPT2n8JA+xfG7Vpq3I/SRUKVj4j5QEQ/yF/nH9Plum4cmBf1l6TNzPJo
         yH8T4c/dhkinT8gFOobZfh8QXkQ0a9vwkGvsA+/VlNYVminEiv7ZKH7sw7lW/iToNvYQ
         n6eEwBmDsId/OwpAdT+xA9ViQTACBbXigphAhbPE3l1OtW7ZO0xFeRUPDvFwyVep+cD8
         te2VPEEvcYMfDNX5kavhy6v1YvhkhjtwjLj2HC7nv18zvjfeSqyVqyRi5ywGtkVvRrkk
         BRK8Mz3DwlP2tCyqDWNYZnlLHricCzWIeH1Ytq9dZhpvQM1Xrd0aLvVDAbA+47UltaiQ
         nybA==
X-Gm-Message-State: ANoB5pms1ucF2PzAgZniAheRNBuD5u6mAAlzZDbOnehcS5V5oUEAbZb9
        56DT1OPE7C1Z1t/wKSuQ3RA=
X-Google-Smtp-Source: AA0mqf4b/w2tfxh6Bt45IcnxJSN1AW42YagPzrv+A0xo3DWyW4qu4HLTNwJ3zuR5fST3xxff/313Og==
X-Received: by 2002:a17:90a:df91:b0:219:8464:84d5 with SMTP id p17-20020a17090adf9100b00219846484d5mr31336058pjv.9.1670473851281;
        Wed, 07 Dec 2022 20:30:51 -0800 (PST)
Received: from debian.me (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id m17-20020a63f611000000b0047685ed724dsm12190249pgh.40.2022.12.07.20.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:30:50 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2F1021002F3; Thu,  8 Dec 2022 11:22:37 +0700 (WIB)
Date:   Thu, 8 Dec 2022 11:22:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] mm/highmem: Add notes about conversions from
 kmap{,_atomic}()
Message-ID: <Y5FmjdBNEO8aP/Ls@debian.me>
References: <20221207225308.8290-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DpcXuOK9+sW5uRJK"
Content-Disposition: inline
In-Reply-To: <20221207225308.8290-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DpcXuOK9+sW5uRJK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 11:53:08PM +0100, Fabio M. De Francesco wrote:
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 0f731d9196b0..59d1078f53df 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -57,7 +57,8 @@ list shows them in order of preference of use.
>    It can be invoked from any context (including interrupts) but the mapp=
ings
>    can only be used in the context which acquired them.
> =20
> -  This function should be preferred, where feasible, over all the others.
> +  This function should always be used. kmap_atomic() and kmap() have been
> +  deprecated.

"... always be used, whereas ..."

> +  NOTE: Conversions to kmap_local_page() must take care to follow the ma=
pping
> +  restrictions imposed on kmap_local_page(). Furthermore, the code betwe=
en
> +  calls to kmap_atomic() and kunmap_atomic() may implicitly depend on th=
e side
> +  effects of atomic mappings, i.e. disabling page faults or preemption, =
or both.
> +  In that case, explicit calls to pagefault_disable() or preempt_disable=
() or
> +  both must be made in conjunction with the use of kmap_local_page().
> +
> <snipped>...
> +  NOTE: Conversions to kmap_local_page() must take care to follow the ma=
pping
> +  restrictions imposed on kmap_local_page(). In particular, it is necess=
ary to
> +  make sure that the kernel virtual memory pointer is only valid in the =
thread
> +  that obtained it.
> +

What about using note block to signify conversion notes above?

---- >8 ----

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 59d1078f53df57..ef53eb580d4cda 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -103,12 +103,14 @@ list shows them in order of preference of use.
=20
 * kmap_atomic(). This function has been deprecated; use kmap_local_page().
=20
-  NOTE: Conversions to kmap_local_page() must take care to follow the mapp=
ing
-  restrictions imposed on kmap_local_page(). Furthermore, the code between
-  calls to kmap_atomic() and kunmap_atomic() may implicitly depend on the =
side
-  effects of atomic mappings, i.e. disabling page faults or preemption, or=
 both.
-  In that case, explicit calls to pagefault_disable() or preempt_disable()=
 or
-  both must be made in conjunction with the use of kmap_local_page().
+  .. note::
+     Conversions to kmap_local_page() must take care to follow the mapping
+     restrictions imposed on kmap_local_page(). Furthermore, the code betw=
een
+     calls to kmap_atomic() and kunmap_atomic() may implicitly depend on t=
he
+     side effects of atomic mappings, i.e. disabling page faults or preemp=
tion,
+     or both. In that case, explicit calls to pagefault_disable() or
+     preempt_disable() or both must be made in conjunction with the use of
+     kmap_local_page().
=20
   [Legacy documentation]
=20
@@ -129,10 +131,11 @@ list shows them in order of preference of use.
=20
 * kmap(). This function has been deprecated; use kmap_local_page().
=20
-  NOTE: Conversions to kmap_local_page() must take care to follow the mapp=
ing
-  restrictions imposed on kmap_local_page(). In particular, it is necessar=
y to
-  make sure that the kernel virtual memory pointer is only valid in the th=
read
-  that obtained it.
+  .. note::
+     Conversions to kmap_local_page() must take care to follow the mapping
+     restrictions imposed on kmap_local_page(). In particular, it is neces=
sary
+     to make sure that the kernel virtual memory pointer is only valid in =
the
+     thread that obtained it.
=20
   [Legacy documentation]
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DpcXuOK9+sW5uRJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5FmhwAKCRD2uYlJVVFO
oyEbAP9nGOIqvunMYBWjKm0wiAVXP9PBwvmq0npDOR8jefqVdAD/VqnrYrP3xgh1
H+9kkiaHpEnQRTgJV4K0W0aMRra/SAI=
=T+NX
-----END PGP SIGNATURE-----

--DpcXuOK9+sW5uRJK--
