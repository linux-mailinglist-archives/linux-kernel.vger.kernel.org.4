Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4BD726631
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFGQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFGQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:42:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA911FC4;
        Wed,  7 Jun 2023 09:42:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 194615C007C;
        Wed,  7 Jun 2023 12:42:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 12:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686156128; x=1686242528; bh=42y1EYFXvq4hYeXlSpmVr7gmNpbInmaS7tg
        G+Ss9F5U=; b=CHxsNu/TLuBvPTG0yHh4WOq5QJN1It8U4K4Mt15g1FIi6vpL6Ad
        4SNv/41uiq14W8leF4UWTsz72Su5CRbXiIRYEnHIDHBx9oDZqT6ymIagHkd2CQwm
        wNifs0xXvmsiFF3ncmrudJvXcMTwLJELPyOnernFr6t3hASMW0zPB0PfLDwC0BW0
        uHq3ry34wEAUTA3EsUXoZvNluvYHvcmg1lIB0QJ7a3DfUUW9bYOQ3lM4uFz62ezH
        Prl2L8QV+COLB0QySNuIbWY+j9m6wIwBBTmIGRXwua/wfc+B9Lhpp6LKDxOCNs1A
        bvTFZlTojHJl6zVroypQ8HtiXc5lAVlS+rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686156128; x=1686242528; bh=42y1EYFXvq4hY
        eXlSpmVr7gmNpbInmaS7tgG+Ss9F5U=; b=CsL/olnib/EC7s2AniVOsID2RnvaO
        gHEE1/PviC87GXlrK2jQrtRUoDiIUCd3PtoZMt1pM2/PfxbOkOjWQjNVZkVe/Lvr
        KUlvOi1I9n0bCjNREsjfXNTcuAmGB3wZUYXeFyqAUFyLIH0XI/ZdN2tZRXyBDIDw
        Q0OybDNsW02ypxRMnzz6nL11B8Pm6rec3hbwVmEFrw+0ZpslcCIJJN3Q1grAWypJ
        LgceyJdxSEpqDgSvmOPuPPq4XxJZ5J0z5qm3GBh9GhG88SW3k3wKeKyHBl/WLKwK
        9wEObMIJ7i8awdQgzUCQQmLUcfv6L9lHBdVfEyqqz1sK1byku2VFQmGKg==
X-ME-Sender: <xms:X7OAZM1ueUtCZdO5gXwRqFsrTiESkIoCnY3pNx4WgbAYO0oyzbY1PA>
    <xme:X7OAZHF3Mm8dFQfIxCWk2Q2sncJ1ilMSCg4BcG3qR59V5ItJEHxuGXhmWfURtWr79
    0K3DL6PsGWuCx4>
X-ME-Received: <xmr:X7OAZE65WME9hDYCcsiCzgK011Z8Vz86jMcNQVl3Ypi6IuTe6Ryys5wXUsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:X7OAZF1mDsYgwtD-fK8d8Ln8N-NhaJ-ZqD3je5aBQiOsM5VgdG175w>
    <xmx:X7OAZPHnGIQFnU7zGkQzx5MOEv1iOX-kwemrqJUS1fOPh52IJyHP7A>
    <xmx:X7OAZO_jD_APgbz570axrPJPE4wcAJWB3FlObPxftl1hiSmRcMkhFA>
    <xmx:YLOAZFMANyMVDb7AixBzA8LP_hT_vpDIINqDbQ6YIw0Uxp04beErWA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 12:42:07 -0400 (EDT)
Date:   Wed, 7 Jun 2023 12:42:00 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, loop: Increment diskseq when releasing a loop
 device
Message-ID: <ZICzXbJeLj56NRYB@itl-email>
References: <20230601222656.2062-1-demi@invisiblethingslab.com>
 <ZIA004HDuhoTQzY/@infradead.org>
 <ZICg2sxHQRRPW3Nc@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lhc+hn0jVRR2V+8y"
Content-Disposition: inline
In-Reply-To: <ZICg2sxHQRRPW3Nc@itl-email>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lhc+hn0jVRR2V+8y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jun 2023 12:42:00 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, loop: Increment diskseq when releasing a loop
 device

On Wed, Jun 07, 2023 at 11:23:00AM -0400, Demi Marie Obenour wrote:
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -1205,6 +1205,12 @@ static void __loop_clr_fd(struct loop_device *=
lo, bool release)
> > >  	if (!part_shift)
> > >  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> > >  	mutex_lock(&lo->lo_mutex);
> > > +
> > > +	/*
> > > +	 * Increment the disk sequence number, so that userspace knows this
> > > +	 * device now points to something else.
> > > +	 */
> > > +	inc_diskseq(lo->lo_disk);
> >=20
> > And I'm not sure why we even need this.  __loop_clr_fd
> > already calls disk_force_media_change, which calls inc_diskseq.
> > Why do we need an extra increment?
>=20
> How does disk_force_media_change() call inc_diskseq()?  I don=E2=80=99t s=
ee any
> calls in the source code.  I=E2=80=99m going to use systemtap to see if t=
here is
> an indirect call chain.

Were you thinking of bdev_check_media_change()?  That can call
inc_diskseq() via this call chain:

  bdev_check_media_change()
    disk_clear_events()
      disk_check_events()
        inc_diskseq()

disk_force_media_change() does not call inc_diskseq(), and I checked
that calling losetup -D does not change the diskseq of a loop device.
=46rom what you have writte, I=E2=80=99m pretty sure that=E2=80=99s a bug in
disk_force_media_change(), though.  I=E2=80=99ll send a v3 that adds this c=
all.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Lhc+hn0jVRR2V+8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSAs10ACgkQsoi1X/+c
IsGbBBAAoZxDjSSs9J+siCWh0MMyGUEwddaQhnOqS6hH//JuLOHDb71mJVF51gZR
ayDHrJnYDhxsSpb02lxWKKPfo0plXSnTwb8gt2ZX+HUIXR+QteXUpfXzKi45ZwT7
p70ZnygsFNmn24ePKu5RS491F3n/Kz51PPdacIE429QBLi5YRAAlTTan4pOJRvRt
bgliY4CSe63mDrCJ4GMd7614e4mTPrsaJYbAAx5ri1xJBNy8pKjbyUMcSfR5VQnu
ujJgAXImHu3mzEeJlHKusofkCA43rWdhLsrZvrjArGXEXOcK7Qk4zkVUGh/dG7Ta
QxljW+MD+foQRsFmsrc+XMfIpPuWy/AigkYi7a+jINyzwfmNqfnWwuxW4Q3mQlhu
eJ7inplmVJ7xsPJKbRL/DcqiHvE+KgGU5GHuZPCwu7e9G+pkcEJ1kTqzHZrRTAJW
WXhLxBLajojgzKCrbTusEmLuodkVMZpqM1VPsSBeGjYwV+BvVlymK15DWtlxffC4
XdsQHu88yG8rdDe4TO7GgSWfNXDGuIQOtmHTsvrvLR/XVduEByxaXdsYj5k5JO/V
A7h0LAnLqTZo2+0tYqaFHHUjUHWua8edZYrdVvXTsNgkMfDol8/SGSSsbstvEbGz
8WGMKF+Qp8uA8T9fUDq95d6QDXwdg1E5NLawy7Yg9CfYScpy1Mg=
=AmeY
-----END PGP SIGNATURE-----

--Lhc+hn0jVRR2V+8y--
