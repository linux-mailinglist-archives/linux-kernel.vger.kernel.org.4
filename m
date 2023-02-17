Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74C769A67E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBQIDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBQIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:03:01 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB85D3E1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1676620955;
        bh=pOjzgFRo1D4loi7HlOELrLpIqKfwTeGmDwGBycgjXiM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z0Q/kP+JmbyQ5z0lZ1bYAlA3gTCVOIZ7uNIb7qZxvDnTyYta22iOmoi5S3Ju5LaAZ
         nW62HsrLuObYhdD7hlaDc3bs6KwWRui3GCrm165l7+QyYZ4lK/vtvcX1lcAQO31lfI
         7MKwrRMtoHTH7xuxkooZ5AxLARXQRo33gFRdfh7I=
Received: from [IPv6:240e:358:1156:5900:dc73:854d:832e:4] (unknown [IPv6:240e:358:1156:5900:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E875365CDC;
        Fri, 17 Feb 2023 03:02:31 -0500 (EST)
Message-ID: <5ac82f53aeb6a040be90eac2be7c64055e62f0ef.camel@xry111.site>
Subject: Re: [PATCH v5 4/5] LoongArch: Add support for kernel relocation
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Feb 2023 16:02:25 +0800
In-Reply-To: <1676618789-20485-5-git-send-email-tangyouling@loongson.cn>
References: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
         <1676618789-20485-5-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 15:26 +0800, Youling Tang wrote:

> This config allows to compile kernel as PIE and to relocate it at
> any virtual address at runtime: this paves the way to KASLR.
> Runtime relocation is possible since relocation metadata are embedded
> into the kernel.
>=20
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Use arch_initcall
> Signed-off-by: Jinyang He <hejinyang@loongson.cn> # Provide la_abs idea

Use Suggested-by if only "idea" is provided.

> +struct rela_la_abs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0long offset;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0long symvalue;
> +};

Use one tab instead of two for the indent.

Otherwise LGTM.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
