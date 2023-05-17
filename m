Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF8706986
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjEQNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjEQNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:17:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78C5256;
        Wed, 17 May 2023 06:17:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ab2a37812so12993488b3a.1;
        Wed, 17 May 2023 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684329427; x=1686921427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHXuyHwVCeuY27Dn1Z0at52ryyIy4L1nPjIskZAszmI=;
        b=dUOMQp99ITY+BLsYtUfBUox35t4cHq8L99aLU4kEb/muIhogRXPxriKIy3bGhM2cIk
         Qm5vHpgfi8JzuSS7TXFXzvIqNHoiDNg8ykl4RxdhyNw2/95P5OOZ3XaaaYRmaXr+9qhP
         eyQaDeiUK+M30Y/rP999YAu1c8iQZ5pjqwpQ9JE7ugH7Nbg1YITtikepM3Qp1WTRdCnU
         1253YWL3lLBG1gZt2okIuiR8zJZWO/lEQu4rvuuCv+tzNM2FDnmT12ftVQ4uGF9aNNuf
         Zg2/0sxkU0fIXqL80dbr/59DUAxpaUJKK8K5iNjoNMj7t2IuJkYzHLjjjQr7KYO84X96
         XeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329427; x=1686921427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHXuyHwVCeuY27Dn1Z0at52ryyIy4L1nPjIskZAszmI=;
        b=iTcA3l0vx2D4yHHysW31Mhq2lGTLN8MgfwGipxmreal3oaQqSn1hG42khULzx7vfdx
         UDZa4kIqLAF1OOYtFy7MAgdl8GvQU7iC7Ep9bQ/jvRx3NV92xxbE04CBxSKbE8yxEaB/
         uzsxSx+BcNGGH1b3HpQ32K2YpVoHVsDGXXBGR3RgpUDdKRKxChNuADTRQDPttgh+fz3Y
         5/sXIrQ6BO2lcOBzdekCcsqkN8E4dLRtGkiAVGf4TH6CemetZ3y1pEawkxnYsmHJEPmU
         pLXGj9EN75SOWjAYyYnM9QkCNjUFjvjd3Bs6xDPmK5+OVNMOA0Oy65XQIrbN5WfdIzVS
         qcjw==
X-Gm-Message-State: AC+VfDw1dbLa84UxDe1tqF0ah8j5aR7fexohUk9An2sb06ourS0SxCaj
        HTXrjqSooT1xeYCp7jlv9ejoVmo6PRUL+A==
X-Google-Smtp-Source: ACHHUZ53Bt8k3To/ZCJUCFRY1gJ/yj1dblrLK/SwggOMj6JCejIVpvqNUPmQiL1F96xkVOy3qaQmXw==
X-Received: by 2002:a17:903:11c6:b0:1aa:d235:6dd4 with SMTP id q6-20020a17090311c600b001aad2356dd4mr2718253plh.19.1684329426721;
        Wed, 17 May 2023 06:17:06 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090aeb9200b0024decfb1ec2sm1527675pjy.30.2023.05.17.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:17:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 37E13104714; Wed, 17 May 2023 20:17:03 +0700 (WIB)
Date:   Wed, 17 May 2023 20:17:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch,
        poncho@spahan.ch, Bastien Nocera <hadess@hadess.net>
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
Message-ID: <ZGTTznb+zal7XRkv@debian.me>
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MBlPoFm2IDF6Uk9n"
Content-Disposition: inline
In-Reply-To: <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MBlPoFm2IDF6Uk9n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 01:58:43PM +0200, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> On 08.05.23 11:55, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> >=20
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developers don't keep an eye on it, I decided to forward it by m=
ail.
> >=20
> > Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D217412 :
>=20
> TWIMC: a few other users (three or four iirc) showed up in that ticket
> and reported problems with the receiver, albeit the symptoms are not
> exactly the same for all of them, so there might be more than one problem.
>=20
> I'll try to motivate the affected users to perform a bisection. But
> would be great if those with more knowledge about this code could
> briefly look into the ticket, maybe the details the users shared allows
> one of you to guess what causes this.

Hi Thorsten,

Another reporter in the same bug ticket has already pinned down the
culprit to 586e8fede7953b ("HID: logitech-hidpp: Retry commands when device
is busy"). I'm now updating regzbot entry (and Cc'ing the culprit author):

#regzbot introduced: 586e8fede7953b

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--MBlPoFm2IDF6Uk9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGTTzgAKCRD2uYlJVVFO
o8v/AQDMzxXPL0aJTjJvzDxxNi7DhL90709+agUP7k6Ys1BHdwEA8KY+RvcY9h4G
b9R7HSqlbCmnbX1nhs9j/8Zq4ghLzA0=
=uvie
-----END PGP SIGNATURE-----

--MBlPoFm2IDF6Uk9n--
