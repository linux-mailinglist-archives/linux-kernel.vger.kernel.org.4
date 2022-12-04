Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB84641AD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 06:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLDFu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 00:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDFuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 00:50:24 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292D18349;
        Sat,  3 Dec 2022 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1670133022;
        bh=d5CBndCz5Aq6+L0ashGvauRZhtuj3uLvYtyZUaEAr9E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KcC1zQ3KQ4RBSPVPLgtbyGbbp7R0ByHq2cOFksZhjkxDhqfyumagsUhBCvoGEL71K
         IIvn6V/NaJinAhJ5Nq+KvX6fBZsBxk7brR/FKvyBgWf73nUjEQERwtqRvhfPvZ1OvK
         doSQEp/g+hS4rM1ubiHyVIiFWWHnNAi0yoVti8vc=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5287B66764;
        Sun,  4 Dec 2022 00:50:21 -0500 (EST)
Message-ID: <413486cc20a6f822362419d51f83dfd508b5021a.camel@xry111.site>
Subject: Re: [PATCH 0/2] Update links of LoongArch ISA Vol1 and ELF psABI
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jonathan Corbet <corbet@lwn.net>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 04 Dec 2022 13:50:19 +0800
In-Reply-To: <87h6ycoist.fsf@meer.lwn.net>
References: <1669892345-7763-1-git-send-email-yangtiezhu@loongson.cn>
         <87h6ycoist.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
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

On Sat, 2022-12-03 at 03:58 -0700, Jonathan Corbet wrote:
> Tiezhu Yang <yangtiezhu@loongson.cn> writes:
>=20
> > Tiezhu Yang (2):
> > =C2=A0=C2=A0 docs/LoongArch: Update links of LoongArch ISA Vol1 and ELF=
 psABI
> > =C2=A0=C2=A0 docs/zh_CN/LoongArch: Update links of LoongArch ISA Vol1 a=
nd ELF psABI
> >=20
> > =C2=A0 Documentation/loongarch/introduction.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 ++++----
> > =C2=A0 Documentation/translations/zh_CN/loongarch/introduction.rst | 8 =
++++----
> > =C2=A0 2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> I've applied these - working links are better than broken ones.=C2=A0 I
> assume, though, that the new URLs, too, will break the next time the
> manual is updated?=C2=A0 Is there any chance Loongson could provide a sta=
ble
> URL for the current version of this manual instead?

Use a URL with tag name instead of "latest", like

https://github.com/loongson/LoongArch-Documentation/releases/download/2022.=
08.12/LoongArch-Vol1-v1.02-CN.pdf

It will still refer to an outdated doc if the doc is updated, but at
least it won't be broken.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
