Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF45BC060
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIRWTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIRWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:19:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF997B1EC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 15:19:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 100D73200A26;
        Sun, 18 Sep 2022 18:19:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 18 Sep 2022 18:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663539540; x=
        1663625940; bh=zcqx2N4R1BR5BdTUpHM9SqnT3l2EblSdwv3FLtEPo0I=; b=p
        2vX3oaKHPSMzJgl4qjK4RSGT7HtqCASKMQwbp4iXLaz4Y604NxAKAia9VqZvnkk8
        z4WCh6IH1zKETddl80BSadD54RqMdlypBs/xzj1x8EaBiDUNc93b+F9OFXyEX8li
        JN1w0pYuckrvv06eI4wQREHjjUIrlClArqkRd/8Hwr4F43Csq8s2bpWGWrFBT0i+
        QGzqfCb8PsPVILBTP3mh5MIqHKAAZS0GZvq+/PjBgKpgMRqbF8xH050Sp5/LAD/h
        3ENT9Ln+C/C1QrBFkIG/TsGWQ9lhc5NbF2B67lwNBgGWdZZvelUezuGMvv4iMggZ
        5hiQdgnP1YBpotYB6y22Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663539540; x=
        1663625940; bh=zcqx2N4R1BR5BdTUpHM9SqnT3l2EblSdwv3FLtEPo0I=; b=d
        bbtuWHC7ozI2uCYGdIYeNH1ViNJbCW7EjT01Rdmt0KBNICdTIPahUwJMmehn05s4
        Lny+/tFKs4+zo9vlZHfRmTSwJNnsM64EDC+FI9K+owRdJ2snJPk6vhl2oZCChFDE
        UMzqWa+4nr25DWBlK1f95PoL0MBKRJ9GZoTBm4QXff0SKGLZMQ+gE7bM+3tfqENJ
        kbl2EiEfpBj6b12S61SGgDS2nKGHJF5BYdG3m4tPoFQXScdvFm0UrBP/hebvG4nW
        Wq1EqvW/Av0w8bxI0Hkp0bg+ZMC8IZoR+0PvHTimpDoX1ZNIe1UDQvByJTymUv5D
        DuRnQgl8wUfHdskzWZ01w==
X-ME-Sender: <xms:VJknY0YzdN0B6fvIx4ld2N0g1LFq_eKA1Cvf6G9aD4F3wqyCEk-dcg>
    <xme:VJknY_bUCPEZw2_jKLgOhv4cCvufg8FFNkGG8vLq-yYtGgRs0ImNzeeC2r6HsmBJv
    AJfh1X8cxRyk9Krh4w>
X-ME-Received: <xmr:VJknY-8IQC4Lm_Y0a3tPGlHnaHbZewXd4Njgt7xW5BoW4mQw96BeuWqh_BnF99-EQH7vYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedviedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:VJknY-rzgfy6g4X9wbWZsWiOkIC7qtP8DZ9VvDV2Bxv-yuiSE8OjUg>
    <xmx:VJknY_radEgmlaJ38M3YxawsVWW0WJ9_eYhjMY7A8mfJizmkpz3vVA>
    <xmx:VJknY8R03AEHjjGQ5flBWg2GRpiflCa5QqqJOLxAcZ-_GNVXpHo4XQ>
    <xmx:VJknY22N_pPe6hvwoL7KjxL-4h9uvlAJOUoHkKAY5VccYqh6AdGlqA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Sep 2022 18:18:57 -0400 (EDT)
Message-ID: <3a7a54d2ed0115c4aace64613f6144208487a8d9.camel@ljones.dev>
Subject: Re: [PATCH v2 0/3] sound: realtek: add quirks for ASUS G513, G533Z,
 GA503R
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz
Date:   Mon, 19 Sep 2022 10:18:47 +1200
In-Reply-To: <87fsgsvdfq.wl-tiwai@suse.de>
References: <20220915080921.35563-1-luke@ljones.dev>
         <87fsgsvdfq.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-15 at 17:56 +0200, Takashi Iwai wrote:
> On Thu, 15 Sep 2022 10:09:18 +0200,
> Luke D. Jones wrote:
> >=20
> > This series adds quirks to fix pincfg for the ASUS ROG G513 and
> > G533Z laptops, and adds a mapping
> > for the ASUS ROG GA503R to use the previous G15/G14 quirks which
> > fix the DAC mapping.
> >=20
> > Changelog:
> > V2:
> > - Use smallcaps in hex string
> > - Chain the G533Z quirk with the G513 quirk as they use the same
> > base pincfg
> > - Add the quirk for GA503R series to use GA401 quirk
> >=20
> > Luke D. Jones (3):
> > =C2=A0 sound: realtek: Add pincfg for ASUS G513 HP jack
> > =C2=A0 sound: realtek: Add pincfg for ASUS G533Z HP jack
> > =C2=A0 sound: realtek: Add quirk for ASUS GA503R laptop
>=20
> Now applied all patches, but I corrected the positions of the new
> entries to be in the SSID order locally.=C2=A0 Also, the subject lines ar=
e
> adjusted to "ALSA:" prefix.

Excellent, many thanks.

>=20
>=20
> thanks,
>=20
> Takashi

