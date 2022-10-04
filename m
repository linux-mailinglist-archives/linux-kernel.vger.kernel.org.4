Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30205F3CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJDGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJDGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:40:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615AE2BB3B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:40:41 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d17so7853435qko.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date;
        bh=RYr2dN2GAExY4WLz7khxe9O/8gRJYs7RcxMwHL3Ob94=;
        b=P1T/u43hen7L6Gx9nEYPJAHXzuqnO5J1BwK/remxnKv1+mpeZIYEqX9c5fXTt0OOd/
         XcVsEhkIlwZI0eY5YJ/8QSiv5+2VW4JobfmLxi+j0hTKDl/rBCRe0yvFRH05aPSvnzWG
         a3HpI+mOWiyqXy+D0ak2fXdh9hwB5/QUdNHWmFXYmUwA3QJ19f/B5hCiHRfJynWovk6D
         6mN5SOaQeY5cF5CiDqQtW2+JLPF4YZUqnPUe7BNq0BVJSyB8xmmqAjb91TUhORG+oGRU
         jmc6COhsegNPsrz1fQA5mxnatfgXOVTk1ye0FwqcKgfkmaYYvHxjEt6gNZU0pd6X++8J
         oLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RYr2dN2GAExY4WLz7khxe9O/8gRJYs7RcxMwHL3Ob94=;
        b=59tMwgLbTEUc3PGH65hD5YoWKXpLQOGVO+8+Rz/m1iNuMlxGM/PyU7zL4OAh/ZV7BT
         HqE3x2hKCKJLyjTKnoOSbjsytT6rJU+TirS8STOba52x8S7X7SuEFG+X0lW9M7flFHCI
         48rUCj6SX2L376x0PrHgrc2knGrbHMoUIOda/qmQ8hiScgqSyFS+esI3r1Il4AVpIA/s
         QsC09qXm66HWNZZMTHvbPrd7wZf2geVImEycH/KmcX69JcNpH2MMA67RiMDAU6di3076
         L0ReeCJXNC4mL+5LYT2NXDLT6atnGowF2cVTaxrxa9QeGCW95PlbsYzp1nt3sLEiP6j2
         PYJQ==
X-Gm-Message-State: ACrzQf25y50HVoMUymtdpHr0Z72nJCsgTz6mAwMr0szrL+0vijnIGwnF
        VqyAWZE6zm2iDRgYrRoil38=
X-Google-Smtp-Source: AMsMyM6tT16haWNWSKRFb/A3mgmUdH71IoY0vuTk/EfaOZaI7K7Z2rn+JT+TIwXaVUaof9U6MNBa5w==
X-Received: by 2002:a05:620a:29c9:b0:6ce:a961:af73 with SMTP id s9-20020a05620a29c900b006cea961af73mr15828638qkp.226.1664865640488;
        Mon, 03 Oct 2022 23:40:40 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q19-20020a05620a0d9300b006cebfea5c55sm13972883qkl.2.2022.10.03.23.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 23:40:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5B32B27C0054;
        Tue,  4 Oct 2022 02:40:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Oct 2022 02:40:38 -0400
X-ME-Sender: <xms:YtU7Y13Mx4nYXH5Y4h4I7pd72BX2hhSGA37AxjaV6O1VpGfBoyR-sg>
    <xme:YtU7Y8GtX3-yjBdTADPSK82kJ0fa4V9wBeEW8UEl7aPsEv2Bc0gthBrTl5dx9DwPo
    jHLY1atFdiNQPQ3Rg>
X-ME-Received: <xmr:YtU7Y165JLWtjrYTxdIJ9C67irVvI4PVNtyY6hxzL5u_auMQLy8-bDj96H3fOvRIHuCMp95PNMqptFESKacSNVC4trFPc8Wxy-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeitddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgfeivdeugeeujeduuedvueeuvdeuieekudejieehgfejvedtgefhleej
    tdduvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YtU7Yy3NuMpdmGtJDQ8W_4djuR_B6xR2UGq0IRNw2EfMtgH3CKXqYw>
    <xmx:YtU7Y4GOxcBk9hTFQwvbRPMc3s5GksGEnGJ1OpgSpt__v4YPFsRLRw>
    <xmx:YtU7Yz8v-E-1oKy4N5cbTLtcrb6wPocyl9VXi7l6hF8L4cxYr3cN7g>
    <xmx:ZtU7Y8CTEUnOqaAkcMdOT8GF92Nxw_PzM1iIKkjgap9oTdRIFu8baFvvHlw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Oct 2022 02:40:34 -0400 (EDT)
Date:   Mon, 3 Oct 2022 23:40:32 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Fox Chen <foxhlchen@gmail.com>, Gary Guo <gary@garyguo.net>,
        Geert Stappers <stappers@stappers.nl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Julian Merkle <me@jvmerkle.de>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Matthew Bakhtiari <dev@mtbk.me>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Petr Mladek <pmladek@suse.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: Re: [GIT PULL] Rust introduction for v6.1-rc1
Message-ID: <YzvVYIo8q5TeBmB4@tardis>
References: <202210010816.1317F2C@keescook>
 <8d9810e2de8aa658223542a651346118ee7be4ac.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eFSGTpVSgQxB6uU7"
Content-Disposition: inline
In-Reply-To: <8d9810e2de8aa658223542a651346118ee7be4ac.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eFSGTpVSgQxB6uU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2022 at 01:32:49PM +0800, Xi Ruoyao wrote:
> On Sat, 2022-10-01 at 08:58 -0700, Kees Cook wrote:
> > Hi Linus,
> >=20
> > Please pull the initial Rust support for v6.1-rc1. The tree has a recent
> > base, but has fundamentally been in linux-next for a year and a half[1].
> > It's been updated based on feedback from the Kernel Maintainer's Summit,
> > and to gain recent Reviewed-by: tags. Miguel is the primary maintainer,
> > with me helping where needed/wanted. Our plan is for the tree to switch=
 to
> > the standard non-rebasing practice once this initial infrastructure ser=
ies
> > lands. The contents are the absolute minimum to get Rust code building
> > in the kernel, with many more interfaces[2] (and drivers[3]) on the way.
>=20
> Hi,
>=20
> As a Linux From Scratch maintainer I have to express some concern.
>=20
> I think I have the most open attitude to Rust among all Linux From
> Scratch members.  But this will be just *too* troubling for us.
>=20
> I'm not against the use of Rust in kernel, but:
>=20
> 1. Current implementation strictly depends on bindgen, which depends on
> libclang in turn.  It means even if the Rust support land in GCC 13,
> we'll still need to build and install the giant LLVM for building the
> Rust components in the kernel.  Is it possible to use some different
> approach (for example, including the binding in the kernel tree)?
>=20
> 2. Squashing all the cmake, LLVM, and Rustc stuff into the Linux From
> Scratch book will be extremely painful, but still possible.  However, we
> currently need "A particular version of the Rust compiler".  This is
> just annoying.  What will happen if a security vulnerability suddenly
> shows up in the "particular version" required by a kernel LTS branch?=20
> And from a distro maintainer's point of view this will forces us to
> build multiple Rustc versions.  I see the reason "the kernel depends on
> some unstable Rust features", but then shouldn't we wait for (or urge
> the Rustc developers for) the stabilization of these features, instead
> of merging Rust into the mainline too quickly?  Now they can declare the
> victory like "oh, the kernel is now using our language!" but *we* are
> paying all costs.
>=20

Just my 2 cents.

IIUC the Rust support is still in the *experiment* stage, in other
words, the whole thing may get removed if things don't go well. So I
wouldn't recommend any distro to enable it for the LTS kernel or any
kernel used for production.

That said, it may be a good time to start thinking of the list of
prerequisites for distros to enable it. I believe you just mentioned a
few above, so thank you!

As for the "victory of them but cost of us" thing, TBH, we do use the
compiler and other tool from them (and for free), so that's fair ;-)
Besides if the victory make them care more about kernel needs, it's
better ;-)

Regards,
Boqun

--eFSGTpVSgQxB6uU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmM71VsACgkQSXnow7UH
+rixcAf+Px0w/osHsVaufgzVYdUjNqQqVxpW7rQa60f2Ciubxbk54cvWszr23azZ
9z8HhfUoE2qlVbe2KoLGM17rtRXRVB7odnPRrqnGc00sDBBvJsQJ5ml7Pm3UtwWN
lRBBP0VEsG4oD+Jmy+Hl6ZhhCvEhgbijFkzmar8A4otmBF587j8Bi7k78LMocvBS
hOdiA3l+MmdHOD+4TG7xz7++zkEL+vu1V43MTokapJk0dA7evDuiD7wB+WXCKKJT
3qJ+fNDYcB0gOghEP91xB3rOzBR7QtzkWY0YNv9AO5nZUHZReLDc45/nyVR78/6w
v+6I/p4xRoEoD+jXpC9kCBM5mVHA6Q==
=z7V7
-----END PGP SIGNATURE-----

--eFSGTpVSgQxB6uU7--
