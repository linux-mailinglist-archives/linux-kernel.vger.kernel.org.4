Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB12686502
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBALJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBALJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:09:17 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCE76A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675249754;
        bh=KgL43wQ3kPsTkQ5m+/+Q26nDzaZ4pmpPRj2FPWVxTUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C0t5G+ErswNWyt0GnaHVhVswjZ08pZQpzuQuRdT5Vo7K/UQjjZn6kLPJLNf5hd6Gl
         Zlc+rOzSYYB2b3grow/e2lwqeKOhPNX8dh+bZe0xiJa9vATsXScMtB7HuVNdi46zWV
         xDt0zacmto745SsyZTn4CFqAoyPFQpCQ8a/nkslY=
Received: from [IPv6:240e:358:117f:3800:dc73:854d:832e:2] (unknown [IPv6:240e:358:117f:3800:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 6A41F65C7B;
        Wed,  1 Feb 2023 06:09:11 -0500 (EST)
Message-ID: <682fcd7bb7ce1b5d04dafa2cd9d8608e6ba80189.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fix Chinese comma
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Feb 2023 19:09:04 +0800
In-Reply-To: <20230201092904.11070-1-hejinyang@loongson.cn>
References: <20230201092904.11070-1-hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 17:29 +0800, Jinyang He wrote:
> Fix Chinese comma in cpu.h.
>=20
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>

This is obvious, while I'm wondering if we have a "-Werror=3Dsomething"
compiler option which can catch non-ASCII characters immediately.

> ---
> =C2=A0arch/loongarch/include/asm/cpu.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/include/asm/cpu.h
> b/arch/loongarch/include/asm/cpu.h
> index 754f28506791..c3da91759472 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -36,7 +36,7 @@
> =C2=A0
> =C2=A0#define PRID_SERIES_LA132=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x8000=
=C2=A0 /* Loongson 32bit */
> =C2=A0#define PRID_SERIES_LA264=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xa000=
=C2=A0 /* Loongson 64bit, 2-issue */
> -#define PRID_SERIES_LA364=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xb000=C2=
=A0 /* Loongson 64bit=EF=BC=8C3-issue */
> +#define PRID_SERIES_LA364=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xb000=C2=
=A0 /* Loongson 64bit, 3-issue */
> =C2=A0#define PRID_SERIES_LA464=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xc000=
=C2=A0 /* Loongson 64bit, 4-issue */
> =C2=A0#define PRID_SERIES_LA664=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xd000=
=C2=A0 /* Loongson 64bit, 6-issue */
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
