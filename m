Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A173842F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFUM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjFUM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:58:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67AAC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:58:05 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A738E1EC0102;
        Wed, 21 Jun 2023 14:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687352283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hJ9dcznI0I185LOlDtXS/ROzArA4tI6hAX6eJusGfo=;
        b=mhXE2icJ/fgNBPiYoK0gHOKeffbjEZaWKs0Rxy+IwOvffJ1qCsH7vs+RndyAC89WSGrq6a
        jBvpnN/HfXpx6vTmNlaGAKzhP5McDSHx61x/Y4Pc0Zf6nSmNe9b7jVdN7QFhCdd5NNVnIV
        jVrzm4gx/xuXeMG3/saxDKDcwZYeeZM=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ifOziNYGLxQi; Wed, 21 Jun 2023 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687352279; bh=K4Ml6x1DhwPXY+WicQKr2/XHlje1x1sU0WePdwyi3Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fku/XE4c8q5LsuT2fAFGeH258/jppZd+qFQNFWrMTZYsdGfBszDqUSy+99vIjn02D
         6GdG9MQf1R33qUgo0ChJjlNJxtJmX/hBqUPC2W95hAyU8ahx9HQ/6At+cvBWGdievL
         +VljSTnSizVQgRLgciafz67RHzznBUdQo94c4bfZwLUCAlkAVSPtxT52gboG7MzeAR
         D38rrROIpGPM3fzKVQ1XM1F6ScgdYveqnoYXVw+747r4cWWSXudDy67BPCkdWVFDum
         /9yu7CgZYneNnVC3AWTWr3RScgV2L7rn5D2GluxzbkTno5l3w8LbQC/ZUojAFvSEej
         bC0mzwi17UUP8PVaLn7Qz9r8D8GodYPHn+kq1ybV532/2L/ui42xRVDWXm+KFgAUfL
         x9sMDC8qzocY7nePnaGcljRP4bFpXiczidhg87ws6Qk3w1GXCJQaJBK/MAXIFkQc2o
         c/yycuXQ521jdSgCPJZ5j5cBU7Qc/qYrKlHjpHlZ6ueZSTZFb2+0TkyPM5MhVtorZP
         Bgr9MG18uudjb4cGcPHGh98lfGNmWG3Nv6eAyUxDJ1AWaGYxpUU7ZaGgTZ0OSyQ8k4
         WLQ9jqbXcYucfHk79C9dcAp0h98+bL/ogqMeqz0OKpII87moaK/IxcJ16qLvZ9nvkX
         0nrCodsCU8CDgY7x94KFcsmk=
Received: from zn.tnic (p200300EA971Dc565329C23ffFeA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC21740E0145;
        Wed, 21 Jun 2023 12:57:54 +0000 (UTC)
Date:   Wed, 21 Jun 2023 14:57:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
Message-ID: <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
 <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
 <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
 <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
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

On Wed, Jun 21, 2023 at 08:04:39PM +0800, Xi Ruoyao wrote:
> Hmm, while it's true for AMD, the Intel SDM claims otherwise.  It says
> prefetchw is only (really) supported with "Intel=C2=AE Core=E2=84=A2 M =
processor
> family; 5th Generation Intel=C2=AE Core=E2=84=A2 processor family, Inte=
l Atom
> processor based on Silvermont microarchitecture" or later.  On the
> earlier Intel CPUs supporting LM, the prefetchw instruction is treated
> as NOP.

And this is a problem because?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
