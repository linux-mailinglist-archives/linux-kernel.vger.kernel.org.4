Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7635F888D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 02:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJIASm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 20:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJIASj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 20:18:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163892F660
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 17:18:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i6so2500551pli.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kA0HUMgJdt2O8o8SG2VJ7q/PSPreCGT8pIhZWTT7H7M=;
        b=jfzgUwpRyLto7mRdV23aSgE7IWBpIGaZqOV2k76H3oqtg+pbd+uxXwk8ocGLWGGHmi
         ZOxYkloG5psC7MF+uZ6uqNUM+sjcSbL9avc27DLRGK0sMODzwqzYVL4K14C4usM4DZvZ
         rxVHWG+HNFoTUZvBY71yzfLJjYvpODLuJFWkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kA0HUMgJdt2O8o8SG2VJ7q/PSPreCGT8pIhZWTT7H7M=;
        b=io6MoP6SqcY8KYIR3RbSIdJQbJnM9ucbLtLFBcWlJJGUZmIz1xnTpzNmg/K0UjD1/C
         H57r10B/x5ef1YJogs2d1zH1foES1LoXq2IQGhK3RXHAhz3tBvNoWbSFpv/F1qaPWVHt
         2f49KcjdL89UtibCkxbgCoi+xCr7uhmgfr0VoixWV8MhElMbefeGGuruzp5CkNo+G7w0
         0mIt9pP+UeMX3pyuwTkA+D8wlYbsNrB6h48yHAxJW2159YKSFkmY1G5MaFm+nRV1Qa0M
         KDoI5kVW/ylDVgEau+YMMJW8xxHgx5J2bu34nwMubl0Tobj6/09Clyux2r8Eh2nVhlPW
         WhSA==
X-Gm-Message-State: ACrzQf0vA2BPtLsFJrRem/Oa1fMuTYyXmvfJhrM1RetBqsr2UhaMrw4u
        7eP5pltBFC04DZ0ennqsLnaAWQ==
X-Google-Smtp-Source: AMsMyM6OprtZR9DEBnCoqhxK/4A16BNErCSxZZW+JRdGni+bZY3KMwPDYi2OmP3iaFAYzhdquX7Gbw==
X-Received: by 2002:a17:902:e883:b0:17f:5e7f:2bbf with SMTP id w3-20020a170902e88300b0017f5e7f2bbfmr11845201plg.150.1665274717912;
        Sat, 08 Oct 2022 17:18:37 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:338b:87a3:6e32:4dc5:2126:f18e])
        by smtp.gmail.com with ESMTPSA id f1-20020a625101000000b00561b53512b0sm3986475pfb.195.2022.10.08.17.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 17:18:37 -0700 (PDT)
Date:   Sat, 08 Oct 2022 17:18:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
CC:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D=5Bnext=5D_dlm=3A_Replace_one-e?= =?US-ASCII?Q?lement_array_with_flexible-array_member?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0IFEUjwXGZFf7bB@mail.google.com>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
Message-ID: <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 8, 2022 4:17:37 PM PDT, Paulo Miguel Almeida <paulo=2Emiguel=2E=
almeida=2Erodenas@gmail=2Ecom> wrote:
>One-element arrays are deprecated, and we are replacing them with
>flexible array members instead=2E So, replace one-element array with
>flexible-array member in struct dlm_ls, and refactor the rest of the
>code, accordingly=2E

Thanks for working on this!

>
>We strive to make changes that don't produce any before/after binary
>output differeces as that makes it easier for the reviewer to accept the
>patch=2E In this particular instance, it wasn't possible to achieve this
>due to the fact that the ls_name[1] size, which is used as the
>NUL-terminator space, was hidden within the struct's padding as shown
>below=2E
>
>$ diff <(objdump -M intel -j =2Etext -D dlm=2Eold) <(objdump -M intel -j
>=2Etext -D dlm=2Enew)

I'd suggest different options here, this is harder to map back to the sour=
ce line=2E
See https://outflux=2Enet/blog/archives/2022/06/24/finding-binary-differen=
ces/
for lots of details=2E :)

>
>13778c13778
><     c693:	49 8d bc 24 c0 08 00 	lea    rdi,[r12+0x8c0]
>---
>>     c693:	49 8d bc 24 c1 08 00 	lea    rdi,[r12+0x8c1]

This implies something unexpected changed=2E

>
>$ pahole dlm=2Eold -C dlm_ls
>=2E=2E=2E
>	int                        ls_namelen;           /*  2232     4 */
>	char                       ls_name[1];           /*  2236     1 */
>
>	/* size: 2240, cachelines: 35, members: 90 */
>	/* sum members: 2166, holes: 17, sum holes: 71 */
>	/* padding: 3 */
>	/* paddings: 3, sum paddings: 17 */
>	/* forced alignments: 1 */
>} __attribute__((__aligned__(8)));
>
>$ pahole dlm=2Enew -C dlm_ls
>=2E=2E=2E
>	int                        ls_namelen;           /*  2232     4 */
>	char                       ls_name[];            /*  2236     0 */
>
>	/* size: 2240, cachelines: 35, members: 90 */
>	/* sum members: 2165, holes: 17, sum holes: 71 */
>	/* padding: 4 */
>	/* paddings: 3, sum paddings: 17 */
>	/* forced alignments: 1 */
>} __attribute__((__aligned__(8)));

This has trailing padding, so the struct size didn't actually change=2E

>This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>routines on memcpy() and help us make progress towards globally
>enabling -fstrict-flex-arrays=3D3 [1]=2E
>
>Link: https://github=2Ecom/KSPP/linux/issues/79
>Link: https://github=2Ecom/KSPP/linux/issues/228
>Link: https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D101836 [1]
>
>Signed-off-by: Paulo Miguel Almeida <paulo=2Emiguel=2Ealmeida=2Erodenas@g=
mail=2Ecom>
>---
>My apologies for v2, there was an accidental <Cr> I added on
>the CC line which messed up the body of my previus email=2E=20
>
>This patch sets it right=2E
>
>---
> fs/dlm/dlm_internal=2Eh | 2 +-
> fs/dlm/lockspace=2Ec    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/fs/dlm/dlm_internal=2Eh b/fs/dlm/dlm_internal=2Eh
>index e34c3d2639a5=2E=2Ece2e32ed2ede 100644
>--- a/fs/dlm/dlm_internal=2Eh
>+++ b/fs/dlm/dlm_internal=2Eh
>@@ -670,7 +670,7 @@ struct dlm_ls {
> 	void			*ls_ops_arg;
>=20
> 	int			ls_namelen;
>-	char			ls_name[1];
>+	char			ls_name[];
> };
>=20
> /*
>diff --git a/fs/dlm/lockspace=2Ec b/fs/dlm/lockspace=2Ec
>index bae050df7abf=2E=2Ec3a36f3197da 100644
>--- a/fs/dlm/lockspace=2Ec
>+++ b/fs/dlm/lockspace=2Ec
>@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char=
 *cluster,
>=20
> 	error =3D -ENOMEM;
>=20
>-	ls =3D kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
>+	ls =3D kzalloc(sizeof(struct dlm_ls) + namelen + 1, GFP_NOFS);

This is allocating 1 more byte than before, since the struct size didn't c=
hange=2E But this has always allocated too much space, due to the struct pa=
dding=2E For a "no binary changes" patch, the above "+ 1" needs to be left =
off=2E

I would expect the correct allocation size to be:
offsetof(typeof(*ls), ls_name) + namelen

Question, though: is ls_name _expected_ to be %NUL terminated, and was the=
 prior 3 bytes of extra allocation accidentally required?

-Kees

--=20
Kees Cook
