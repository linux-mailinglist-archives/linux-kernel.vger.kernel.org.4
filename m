Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B165BA87A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIPIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIPIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:47:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540978BEE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:47:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EE9613200AC5;
        Fri, 16 Sep 2022 04:47:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 16 Sep 2022 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663318024; x=
        1663404424; bh=nZfKuZkRLwDeAdEaBc46rOYnY8b1DKqIyPPrctrI3rY=; b=O
        CQ7m7Jj05lCtmcpLpzOzNmesDd4rflUM1GKnd09RF7QY94I9T2kxaxEs+5ayY/yQ
        3EYgjbB+cfXUup8oQj8o5HfrML1t/KbkrdPHOcvMAurSF06b419u8wUtlAziZ/TJ
        4ReyqKugAhDwGB1iOPPb5v1ADKG9kpkqMyrziKkchr0PLy++zBfkTBLFJyWBmrs/
        FM2SA9uO7TCaLgW0sLb6mpwixdAO+y05ycTwRwXJiBng0YlFLPAvuOaQSVhx0S/+
        nhzYiKGI+1JrjvGcJd0C1NggQ7zmLjjkK7F5X3UvxxBUUn8Kn7Qzd0aW43l5GEv1
        1/hEZ8kXoVHU3wy6rPTsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663318024; x=
        1663404424; bh=nZfKuZkRLwDeAdEaBc46rOYnY8b1DKqIyPPrctrI3rY=; b=k
        aw0jP++/Wu/SgxX2+mE3/OPnH4DJVrlzCWXCE9we1ObegnAp9eetYvbHR++fXYvj
        0Nl/zKbpE1w9gDo5gENpBLDQvUBvy2TvaC/6L7eyh8hJFh8/4l7R2ecKX8gBm7rJ
        ylwUQSRVCF2Zf1ZYWO4MPEmYLeX1Hw+/S4ZGHu9Zgw3k/OJCvCrrNPxtxoTmoacA
        4w9DpdQnPxzFGMX+ksjO6MizM9QFRMMgjiuJCRAf/pWXv0C0wVLkdLHhqmqz0zAV
        G492zMyFl2mOrZk41WPyVr00Vq7CNgVilvItnSQrPiZufChcN+o6T63BZbsS4uAH
        YmHqmQMyurEyrGruUZCyQ==
X-ME-Sender: <xms:BzgkY5BkYzm4W1PjiBTZUe_wlRNlCttqdHjFTzMhfN43rRbSnCDnQA>
    <xme:BzgkY3hNYZjb9oKZ3E7zsUULRtMaIxdFeobZvTqHkrcCFP2ebJzCdFWOi4ejV1Oaq
    e-vobwfC0dYZQygIQE>
X-ME-Received: <xmr:BzgkY0kkCL8QxLpGPJSrSZKpJ7hC3YNZnJrV6CCDvkqJDwq3Bl82AKJZQsZLFIpFdc-06A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:BzgkYzx1QK3IDHEmBqsRM55WpmBl8iZi3DVjmuGQs-dd9mghocZrRA>
    <xmx:BzgkY-SWWQWM7fBXVptYwc0AExEuABXy5b1gsGJVy53X11qxtsMgDQ>
    <xmx:BzgkY2azzBeoERa5QFnAA9lzHDO36_AvUL-p8upPMcrjK9IUgv_sHg>
    <xmx:CDgkY5ccA30LUgfSUudoMM3TUbpP5MSCMQ2ILoLLIb_FA6Pk_Z_Xlg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 04:47:00 -0400 (EDT)
Message-ID: <850ba9d69e23be788f1963f46c348f7fdf8806cd.camel@ljones.dev>
Subject: Re: [PATCH v2 0/3] sound: realtek: add quirks for ASUS G513, G533Z,
 GA503R
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz
Date:   Fri, 16 Sep 2022 20:46:52 +1200
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

Thanks Takashi,

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
>=20

I'll try to remember this next time. There's bound to be a few more
with next generation of these laptops.

>=20
> thanks,
>=20
> Takashi

