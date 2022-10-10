Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ABC5FA725
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJJVvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:51:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D251400
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:51:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C42B25C010C;
        Mon, 10 Oct 2022 17:51:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 10 Oct 2022 17:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1665438690; x=
        1665525090; bh=rpBVhQk5UAQBeLz9Wj9al8x+/KWr2QPTJzXQc8qVA3Y=; b=H
        1MMxhne69iw66AdXtMiewZX4q90l8HAGeTWeIOvfjlrL7RLDMv0fT+njsF4KrEnG
        NCBm9IBdjAJ/VxPS/eqiUz9vVdOya8eN3SoOE/vLrsEz5yDnZ/ht/GWA7zoPJkYI
        gWcTWyYecYfRcQ4Nj0zsUXIqBzF1aRgW9nc10RQm5ewrIwdZiyEDHqlp4dJJN+8C
        0KDuRj7wFSzjkCNCNAI6AeW3l0uDPSYXK4gX/W1pTTFQ6kPn3vQGYelmcZ4wBxFc
        1bz6H74VTdx/DCiLlp0wXUlLwoUGcUqtK5rSWjyLFSB5nSU02ef76w+v6Bgl0QRV
        hSSEnUpL5qXz+TrWTeLtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665438690; x=
        1665525090; bh=rpBVhQk5UAQBeLz9Wj9al8x+/KWr2QPTJzXQc8qVA3Y=; b=M
        I/DX6XAVtlo+vMeCQlHDN9gN/BkKLNTXTj5RLSoFq7aVjVsz5h8deP8CUZGD9pvO
        8FEfsmcdMWYiuHde5Y5oP3tjttT7AovpaauWFD+k/J+3oCfp9BJP3zK7h+Rm4OMB
        f28jCIFLxZRGaUcYQLnU72TbffI4zydMWmfGFU2HWq3W36qfbzZYJBwqGL7ntaQ5
        FuwiA9MKWoaBxfvXWbBXMFoOkrlw9kBmX73EAPWP/WKRlforOiu7SYOCIlobIZO8
        0oy9Q8lraOwyqzDQ6Sj/c+w4SiMvkVM2ycEfwhe4Cvyw+74HUBQDQL7s90F0I1p0
        BB6coXjDfGw/OG8BDQG5Q==
X-ME-Sender: <xms:4ZNEY00MXSo8vAfJaSdLeToykZqUrdp6EQEpcGYKtvOwEjq75DCmHg>
    <xme:4ZNEY_GGnQfAinBjoEMAys0K7zN8kokG7McbDZMB66sAx4dgrzVYvLxfGd6E3x5ER
    C_gnulbspLeFWGL59U>
X-ME-Received: <xmr:4ZNEY85S2yA58xybut3SH7kIonoVxLKAQHg2M6oDlc6emX-8rP6cj-OcgGSGVs3VFuZZfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:4ZNEY93BkkghopCCxueFIxIXOJv5kxKoZwxWZxRBKu5Eh7FpBkPojw>
    <xmx:4ZNEY3HdqFrvb8DS8rLpN4v1CAm_rx--kQlqEPz4M51jpz1m8iO8xQ>
    <xmx:4ZNEY29r7PMNZKqRprjOIpVG5GgZXZGtZh82t5DeARmBNs_ntOyNEg>
    <xmx:4pNEY8THbX7nhFh9oLv6MmsEZOSzUrRM2aLxnKB_YwGQ-5B7Jw8Irg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 17:51:26 -0400 (EDT)
Message-ID: <e5de59f50c8e4141edc96f882253feb4a12a6536.camel@ljones.dev>
Subject: Re: [PATCH] Fixes bc2c23549ccd ("ALSA: hda/realtek: Add pincfg for
 ASUS G533Z HP jack")
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, perex@perex.cz
Date:   Tue, 11 Oct 2022 10:50:29 +1300
In-Reply-To: <87zge3etjw.wl-tiwai@suse.de>
References: <20221010065702.35190-1-luke@ljones.dev>
         <87zge3etjw.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 14:45 +0200, Takashi Iwai wrote:
> On Mon, 10 Oct 2022 08:57:02 +0200,
> Luke D. Jones wrote:
> >=20
> > The initial fix for ASUS G533Z was based on faulty information.
> > This
> > fixes the pincfg to values that have been verified with no existing
> > module options or other hacks enabled.
> >=20
> > Enables headphone jack, and 5.1 surround.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> The changes look OK, but the subject line should be rather describing
> what about the patch is about.=C2=A0 I corrected the subject and put the
> proper Fixes tag (as well as Cc-to-stable).
>=20
> Also, the indent level wasn't right, so I corrected it locally, too.

Oh... Sorry about the hassle there, I could have sworn it was correct.
Thanks for accepting regardless :)

>=20
> thanks,
>=20
> Takashi

