Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5974A6A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGFWQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:16:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2A1B6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:16:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7227F5C00C1;
        Thu,  6 Jul 2023 18:16:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 06 Jul 2023 18:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688681784; x=1688768184; bh=mZa85bjJH2f5cdL4Fdfp9uPj+HoFpYkkuG6
        bMzMcTdQ=; b=KEmUd9mwOIc5og5O+4gcFwNYEKiX++l2j3hfeH4OZAjWc5ZOrbl
        jo8drgUhxvSWcnPUy93cY9VBRWrhtcJxcxUL4HHPAoCgF9GNpAzjPUu8DHKv4xYi
        s3MsHQy9p1OQ3oImwm/LaRNyIoLgvpWIpsW98oTRFgYtHhnf5w5H2cz89fqh+Tp2
        juQLFHAkIVs1Ey08xOfNnE5FWn9KYDQdo8KypyAgTA212NIXe8IlTGE2LeEK/5LN
        a9Wv7b3+88Dq8jRzaUxgfdxzrzwO/+bMIHvK55xqIQwy1YaQxlD9LOYQTB72Q6lc
        pxYaBXnsaR0f9FeiR+ELxFDSXJdzO8tIy0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688681784; x=1688768184; bh=mZa85bjJH2f5cdL4Fdfp9uPj+HoFpYkkuG6
        bMzMcTdQ=; b=o9EYYWELh+x81CkEnS47NL0uThwveb5exxfkYq4uMmYTRa8ymJZ
        o6CnlzmC5U6FnqwcpQpWLFOQfJZKzUagM+60GH1eANvJWb4SXxLLID3Ntw4Q94Sy
        No2ENZnagp2hgjGwAoBE3qTwJxXKbDOOkg3LiOmzr/nvGVp+OKVy/VvsXntDsGT0
        qHZfOuWuwyQbcaf5HsjwK4gKfP9YpH8Upxv4wZ7S6diD0k1tXyvYqeybw1i7kNcB
        QlDj5jMAbaxyDoaRWztbtNteDgXi2BoCFWffEJ6igJIui/5KL7TkRdcQZA9+FSUZ
        ExlFs2IXXWaqHzOvWHK2gLxtxWfOuc8lXpQ==
X-ME-Sender: <xms:Nz2nZOlV9eRIZqEX3Dch4kMCUKmULja2qQ5URWRFYFtf9WL8mgf5Eg>
    <xme:Nz2nZF0GZ3C4-oJyhWftXv3CMwdlx5HJt_0lNEdB2zs54cWgZhtCDvZ0OT7yiFIWF
    Fs-QFNstMymMFykutg>
X-ME-Received: <xmr:Nz2nZMqbseah6x9fXub-SILH3JHrqDHRA8-goBaO98rHoamMmf0To3G2nJgP-fTrnjhbHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epkeefffeujeevueejueegleelhedtgedvledukedttdffhfeifeelvdduheefjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Nz2nZCk9stqxnWW5rQU0J28GUmM7ZG0WKfRi6Yx4Sde-HLv-LPObow>
    <xmx:Nz2nZM2k5mwbSrAyWhOctBouBrDpQibQsqsIGPcU3dZiQniq3bgJ3w>
    <xmx:Nz2nZJv1JsqTa6d1k4qxLCwVuunp4XswCwnsxy-6KWdfWVit9ouEwA>
    <xmx:OD2nZNnhwgxdcyH96L4yPj1eJPQNv90sL-jK8YhPuHk-SBrYjiJ6mw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 18:16:20 -0400 (EDT)
Message-ID: <b1843d246fb02cd5f7590e9440124a080852d106.camel@ljones.dev>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 10:16:15 +1200
In-Reply-To: <87v8exml0e.wl-tiwai@suse.de>
References: <20230706091447.17025-1-luke@ljones.dev>
         <87v8exml0e.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 11:45 +0200, Takashi Iwai wrote:
> On Thu, 06 Jul 2023 11:14:47 +0200,
> Luke D. Jones wrote:
> > diff --git a/Makefile b/Makefile
> > index 12579666581f..e2cae6cc7574 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2,7 +2,7 @@
> > =C2=A0VERSION =3D 6
> > =C2=A0PATCHLEVEL =3D 4
> > =C2=A0SUBLEVEL =3D 0
> > -EXTRAVERSION =3D
> > +EXTRAVERSION =3D .rog
> > =C2=A0NAME =3D Hurr durr I'ma ninja sloth
> > =C2=A0
> > =C2=A0# *DOCUMENTATION*
>=20
> Obviously this is wrong for upstreaming.
> Please take a look at the patch before the submission at the next
> time :)

Oh, sorry mate. It's been a very tough week. :(
