Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853386496A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiLKWOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:14:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44CB7F8;
        Sun, 11 Dec 2022 14:14:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3547B1FDA4;
        Sun, 11 Dec 2022 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670796877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgvfcpkbCq4GYFPGOmXVdg4BoSQzJj/XPDHwUVl1KlQ=;
        b=UKGrC+Svz8/OgfghDC8TzrArmtw/xZAh6sP+xnmlUza72BVU2iO6ScVY4SBRrncFtxxJSC
        0uylGhceXf9s0X3Siec2KwEbKmzdOjIV0F0te671WiihCyEc8sVZhX6MIY0YP5peHhBKZe
        VOB73Dg06VbbPydZEP7ADJvASfxJVf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670796877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgvfcpkbCq4GYFPGOmXVdg4BoSQzJj/XPDHwUVl1KlQ=;
        b=7tBBer7S9vvr9r3sMg1cCqbti6oYS+89r/fB7OIwbga9Jw7DAU1yBRjn0J2wT7K98khNKb
        pQ5J3rrr9nIz4kCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E518113413;
        Sun, 11 Dec 2022 22:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCVGNkxWlmMpQwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sun, 11 Dec 2022 22:14:36 +0000
Date:   Sun, 11 Dec 2022 23:14:35 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] media: rc: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221211231435.43c4f361@endymion.delvare>
In-Reply-To: <20221211205648.hdv5haufqwfoxzu2@pengutronix.de>
References: <20221121170911.7cd72bfc@endymion.delvare>
        <20221211205648.hdv5haufqwfoxzu2@pengutronix.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Uwe,

On Sun, 11 Dec 2022 21:56:48 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Nov 21, 2022 at 05:09:11PM +0100, Jean Delvare wrote:
> > --- linux-6.0.orig/drivers/media/rc/pwm-ir-tx.c
> > +++ linux-6.0/drivers/media/rc/pwm-ir-tx.c
> > @@ -120,7 +120,7 @@ static struct platform_driver pwm_ir_dri
> >  	.probe =3D pwm_ir_probe,
> >  	.driver =3D {
> >  		.name	=3D DRIVER_NAME,
> > -		.of_match_table =3D of_match_ptr(pwm_ir_of_match),
> > +		.of_match_table =3D pwm_ir_of_match,
> >  	},
> >  };
> >  module_platform_driver(pwm_ir_driver); =20
>=20
> That hunk makes sense even without the Kconfig change. ACPI makes use of
> .of_match_table, so
>=20
> 	.of_match_table =3D of_match_ptr(pwm_ir_of_match),
>=20
> is (almost?) always wrong.

Should we just get rid of this macro altogether then?

(Somehow I have a strange feeling that we already had this
discussion...)

--=20
Jean Delvare
SUSE L3 Support
