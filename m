Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DC693FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBMInl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBMInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:43:39 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4ABA5C0;
        Mon, 13 Feb 2023 00:43:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E9A1432008FD;
        Mon, 13 Feb 2023 03:43:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 13 Feb 2023 03:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676277813; x=
        1676364213; bh=bJwx7IwzH47R8jsBNLlGfXE6Uds64AApY/i7ejI6wdY=; b=U
        FYN2TUhUNbrI2a4xXJ9XQy3WUoEIlCJdxOpqzVfnoFnQBeoAgjZHQqosBmfN1Zf/
        q0Ay0VQgfRsA0sj3AhuCol9MlTRScMqIPrP0EoFuuZ+k5khwpiptTJkOvjKG4Vgt
        MZvT13s9fFkjIQqj/xGkulimec0zjDnlMHxcf30DPf9TQH2d7DXPCkd4EESoi2y+
        p/3imwDbmqIbYjLgvdDCo/s49kpPZLZA9VaTL2+nykMUMYt6Z7gS6nRBMCYJ/hqd
        oOGcdVsmZrQapxCoM8a95zyOjWNWq/Qwkb/G3lItKEpuGCgggGc9FRCPU7u5tC99
        kyRheWd5Twb3M1Ay/3X1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676277813; x=
        1676364213; bh=bJwx7IwzH47R8jsBNLlGfXE6Uds64AApY/i7ejI6wdY=; b=I
        GcI7/1iGpjUEPD53awGngS3YgMN5cNldEbBl+Ci8jGrlPxJwqh2tNhrHqwHO6SnH
        QPqGl6QQu2Dm0o8KrywfQ3OT8fjTM+aSTHeXTPvBXXedObvZw+ROOd8zI56HXjrW
        eFIqx/vs2oKcWtmOzpizZiZOUylfS7Y/PiscK+BQTXK5mgJ2dQVore2cdK4BLfGk
        iQ8HSOuB8Vjp5op2LM6YZP1lcwf+cB++T7ZUF1AUjUNuLdTyEH54ef6r+vzW/SZK
        K9ZuJh9Co/5YNm2OPjTPRt+5ogGpSaZFDow4H0v0B6oCKOROr12l96Tk0VqkE2x8
        h6Kv05srKdDUsVGklGQJg==
X-ME-Sender: <xms:NPjpY8ALTdvtQ6E3HH5jqxKNho9ystFtb2ilcIzeVCXKxNAelOpIDQ>
    <xme:NPjpY-icUjUs0zXfSrntBo9GKr8DWouFpYuLYY6p7r3ywSe35tWqtTZ5o_647tqbd
    h7q5WLQHtJ-8LcY0cU>
X-ME-Received: <xmr:NPjpY_mWZbqAcOPPR9GRi4KRw8qJ98MSaUHnLxmUJBdQnXmBz4Jh86VCLue_CDjQOu2e_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtudenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeelleefieelleetteefvdeikeeffeffvefhtdevgfehveduveehjedv
    vdeiledtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NPjpYyxqVAMVP99KhXqZwyrQQsND3ipbrKukBUpbfGXftczv4j1x-g>
    <xmx:NPjpYxSBKIdyH64goSMPErX4FCHCG1Xua0lMXRuixILT7aQN9gbBmQ>
    <xmx:NPjpY9aJjcezKVaMxuRazW2on4PnOfMNki1r7H6Lc3KH1geka84Rpw>
    <xmx:NfjpYwAGc3PW7tZ8yCkcpYhpomvG8OyXvM1dWaonxbvfqM7pnteGJw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 03:43:32 -0500 (EST)
Date:   Mon, 13 Feb 2023 09:43:29 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Andreas Feldner <andreas@feldner-bv.de>,
        Andreas Feldner <pelzi@flying-snail.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230213084329.ulckaigwd7dof37u@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
 <20230210100620.z6j7rvkiwyu7paij@houat>
 <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote:
> > > Not sure if you were actually arguing this, but the change I sketched
> > > above (interpreting 0 as 24MHz/1) is separate though, as the current
> > > default is "no DT property", and not 0. There is no input-debounce
> > > property user in the kernel tree at the moment, so we wouldn't break
> > > anyone. The only thing that would change is if a downstream user was
> > > relying on "0" being interpreted as "skip the setup", which isn't
> > > really documented and could be argued to be an implementation detail.
> > >=20
> > > So I'd suggest to implement 0 as "lowest possible", and documenting t=
hat
> > > and the 32KHz/1 default if no property is given. =20
> >=20
> > Ah, my bad.
> >=20
> > There's another thing to consider: there's already a generic per-pin
> > input-debounce property in pinctrl.
> >=20
> > Since we can't control it per pin but per bank, we moved it to the
> > controller back then, but there's always been this (implicit)
> > expectation that it was behaving the same way.
> >=20
> > And the generic, per-pin, input-debounce documentation says:
> >=20
> > > Takes the debounce time in usec as argument or 0 to disable debouncin=
g =20
> >=20
> > I agree that silently ignoring it is not great, but interpreting 0 as
> > the lowest possible is breaking that behaviour which, I believe, is a
> > worse outcome.
>=20
> Is it really? If I understand the hardware manuals correctly, we cannot
> really turn that feature off, so isn't the lowest possible time period (24
> MHz/1 at the moment) the closest we can get to "turn it off"? So
> implementing this would bring us actually closer to the documented
> behaviour? Or did I get the meaning of this time period wrong?
> At least that's my understanding of how it fixed Andreas' problem: 1=B5s
> is still not "off", but much better than the 31=B5s of the default. The n=
ew
> 0 would then be 0.041=B5s.

My point was that the property we share the name (and should share the
semantics with) documents 0 as disabled. We would have a behavior that
doesn't disable it. It's inconsistent.

The reason doesn't really matter, we would share the same name but have
a completely different behavior, this is super confusing to me.

Maxime
