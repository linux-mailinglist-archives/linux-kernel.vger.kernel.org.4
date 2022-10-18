Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39560229D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJRD0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJRDZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:25:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF862AE5;
        Mon, 17 Oct 2022 20:19:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q1so12156698pgl.11;
        Mon, 17 Oct 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27lM4fsG2VGltbyI+HsR0GNVvFQa8niyfY/IiXC6g9U=;
        b=KjI9HR/u+WX7XG89cbrIUblYlmumfw6lIxgUY6dfjSZZ5wzG6Wia0bL09yLUAV9xfb
         a7mxiZDBmoJk5Bucbj/AjxlorzkmoOC03xXSu0VmBzuIgVnR1g5DS2yU0UHVKMfKnYCS
         /p/Lh529Xc5tUM21xfxM5QcW/4oNcWiT8sO+Yxdf4yJoiAbobNK8YFB3tksk5yU8wAqc
         uVrNODUp6495s2HoZOWgrzCqwdfx14qbkfhMEmIbAYLUqLpuka58am7ydj2eutrtt2Tc
         AdAiAv+1Svq1H1JNu8hJ9uRbNQ6y74kQ0zVNldgwq0xoVLdXHUp2A3eJKhgAHlY4sD+Q
         6u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27lM4fsG2VGltbyI+HsR0GNVvFQa8niyfY/IiXC6g9U=;
        b=WVVKBfG0/s90kpmvOcZbCtzp6fFLy+fNi8GSKUcRxeVqFr8OLB0zvnwnmSbP3cnjlX
         f9hm6NOwcizW939mNvKLZvgyBZbwXOzqDxNAGaGl0WTA40SOgzWo0e1Sa2oruchSPpMX
         OKBovB7IAfwBfDkvf+DbSLZWMTCEdofNEzP4kxULGpgwov2/tt+WQ5PBXX5vF6xNR5FX
         QDdlB6HoGXwpg/l45Rk012n8d9RNt6uf201Vkmfd7KalRx1X5UUU92aUoTmShAjJwSRs
         PzHAhFDOYWPW6YQ+6lhIb/Olf85rfnU5ss9N/Rw4N0ct5cXJRbO1stIUchiUAnphAgsi
         W/Sg==
X-Gm-Message-State: ACrzQf3Ulx4NGiQxBOs7lHy6FhXR5rYfpH8GA+qMpYR9HVUlNuY/0T6h
        wAx1VqJ1kOA3upGwl//oDmY=
X-Google-Smtp-Source: AMsMyM6/a5vrznwL4ETCawwT7rzRy/qDKRaxQuif1QLAUCW5m9HXfnhGNCmjaMT71zdnAr9JpvFQBw==
X-Received: by 2002:a63:4850:0:b0:45d:6ee6:1c18 with SMTP id x16-20020a634850000000b0045d6ee61c18mr880131pgk.255.1666063166087;
        Mon, 17 Oct 2022 20:19:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f78a00b0017a018221e2sm7317751pln.70.2022.10.17.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:19:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 03473103AB4; Tue, 18 Oct 2022 10:19:22 +0700 (WIB)
Date:   Tue, 18 Oct 2022 10:19:22 +0700
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
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y04bOv49sRsauLb6@debian.me>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mJXlfJec3bfb1DWQ"
Content-Disposition: inline
In-Reply-To: <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mJXlfJec3bfb1DWQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":

Better say "..., which are exported by ..."

> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentati=
on/admin-guide/kdump/vmcoreinfo.rst
> index 6726f439958c..8e2e164cf3db 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -595,3 +595,33 @@ X2TLB
>  -----
> =20
>  Indicates whether the crashed kernel enabled SH extended mode.
> +
> +RISCV64
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PAGE_OFFSET
> +-----------
> +
> +Indicates the virtual kernel start address of direct-mapped RAM region.
> +
> +phys_ram_base
> +-------------
> +
> +Indicates the start physical RAM address.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +------------------------------------------------------------------------=
----------------------------------------------------------------------------
> +
> +Used to get the correct ranges:
> +
> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page a=
rray.
> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.

The documentation LGTM, thanks.

When the patch subject is fixed,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--mJXlfJec3bfb1DWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY04bNgAKCRD2uYlJVVFO
o9kOAP9AaJtAmveWT2rKBcXBOriMgs2qxe6Fqu9neGo2fj4foQD/UM0HMxKN6GnG
IlT9w8j9jQUfpIzT4s7r+oaaSOgTJQY=
=ew2W
-----END PGP SIGNATURE-----

--mJXlfJec3bfb1DWQ--
