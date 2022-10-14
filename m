Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B05FEE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJNNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:01:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8C1974F7;
        Fri, 14 Oct 2022 06:01:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 10so4720272pli.0;
        Fri, 14 Oct 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4dlnb05MmevigtHJ5npeQ25AeXBFYvEvQsw5sWpFGI=;
        b=TGoQstWfBGwpuTarpv5uEIg+GAgT/B8QqBhRDR96IZxKwAI4I5PIdzTiMa9zbhp4+9
         oAHw1vwsww0hwwxwcqeYc+wUEuYZoqeph9+B1ucQa+mI6s7swkxUN88mJvXsIGpgsJnX
         hRojlYcK4Ty6urHIZNAr+kU0uKT9sIm0NBkNS8p1SDGuOM8XExer/rUuUxrU7tO3wyQr
         B7trVpUSBbKblV8FU5M5YZnFjGQUA/nCtq6MPDrYS1utsCDFVFBPogUXJ1mhkJzaYXHs
         lfRYXVKu4T0ycTRnriT5zMr3m0CsJLpduN8kEhjgYnB5Z9tAoVvaVwU9Arp1sJ0fRMMR
         x6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4dlnb05MmevigtHJ5npeQ25AeXBFYvEvQsw5sWpFGI=;
        b=fRcERofrRlb63DEo3jR5IYi5osrgWltpOKkB8aY9Io6HsOWdheCRNsVW/p0WAApoER
         eaN4uT6t7c3Q8QQowkb4i+tvjW4UOVTtwl8xebFlkWwR/H62yv6VD/XmAmpmca4rvR4a
         PIb0hOHQWHwsUGVbZdYbawjpT5IjifIWjNyGaailQXky7nmEyXyxAtKnWaHSfs3dNoLL
         5iP9w3Y+/18l3UPly+way/1pi5GmsQzxtnxgQPWbYFLkUydH1hDsvS91sQ3Pbvon+YPf
         mDYILzEs+WehjstTLmjJe46mEv8MgXl+ES6sQ0pV+s0Cw3OxM7b9XLMF4ZfU8gjYfBXn
         JkXg==
X-Gm-Message-State: ACrzQf0lb9DxBL3AIidpTKAghnnX338UlZ0CtWqW6idKc+jolH30fSFz
        it7TuVMI2gHsngvBj1nqeks=
X-Google-Smtp-Source: AMsMyM6j7YsVpDg/m4uDWdQUc2SyFqtniSBBp/CWN50pRwlBieYiOP5HFCzYzVOIfZ3g5tS7seORQQ==
X-Received: by 2002:a17:90b:4c85:b0:20d:7040:532a with SMTP id my5-20020a17090b4c8500b0020d7040532amr5544291pjb.243.1665752496799;
        Fri, 14 Oct 2022 06:01:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79e12000000b0056246403534sm1687407pfq.88.2022.10.14.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:01:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B5EF7103F3B; Fri, 14 Oct 2022 20:01:32 +0700 (WIB)
Date:   Fri, 14 Oct 2022 20:01:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
Message-ID: <Y0ldrJ91ac0um3++@debian.me>
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nuzjBSR3N8Zosn2Q"
Content-Disposition: inline
In-Reply-To: <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nuzjBSR3N8Zosn2Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 03:48:10PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
>=20
> Document these RISCV64 exports above.
>=20

The patch description LGTM, thanks.

> +------------------------------------------------------------------------=
----------------------------------------------------------------------------
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +------------------------------------------------------------------------=
----------------------------------------------------------------------------

The overline above header text is unnecessary, so I have to strip it:

---- >8 ----

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 6c7a1728de220e..8e2e164cf3db49 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -615,7 +615,6 @@ phys_ram_base
=20
 Indicates the start physical RAM address.
=20
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
 MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_=
END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
 --------------------------------------------------------------------------=
--------------------------------------------------------------------------
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--nuzjBSR3N8Zosn2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0ldpgAKCRD2uYlJVVFO
o51wAQDygf3rDiQGj/G3/lq6CeZQlyPUhwNtm2mmc2lNlrve0QD/cAljpqNnnPtK
WUvHdL90TLML7Na4fSDiq+671IZ0TAI=
=33JA
-----END PGP SIGNATURE-----

--nuzjBSR3N8Zosn2Q--
