Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C66656D29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiL0RDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiL0RDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:03:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9E64CC;
        Tue, 27 Dec 2022 09:03:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C4D3B80EC3;
        Tue, 27 Dec 2022 17:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA56CC433D2;
        Tue, 27 Dec 2022 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160580;
        bh=eSHui+btnB98MZVJ1oeCZsiz1EoXzJKCVJc7dZkijt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgAQ6Ot16rHxr0e4ZtHISx6Z74iradiY8eyneK3UrDvb3kBZxlwItIuKCbtrwl4Ch
         726uc346HvN0WKY24HZEZ9CiQIlxjaNYa9V2lyNkn8TGLF0e/Eejfy5Pt4iDOZM0a/
         bfSIUpOycypve5Z/AKPO/I8xNQir2pE0ea8qRR8jn5JbglFxeOp+5MdfRKBjtUfDRk
         9EIrqswf7zYS5Ra9HvkrkFmiuDD3Rvxy/BMCRCrItGARtmNYmxSgTldHzvjK/4PIHd
         klKjWtygwYTdXJy/w7NC6SVYw2W+1iVJIQx60LxzPnCayNJWtZVGy2r8zNQY9cycv6
         BNkXJYTQnXuHQ==
Date:   Tue, 27 Dec 2022 17:02:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Joseph Strauss <jstrauss16@proton.me>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        jansimon.moeller@gmx.de, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <Y6slQLto568WfmfZ@spud>
References: <20221214222428.7518-1-jstrauss16@proton.me>
 <Y6Wb1+VrutfKtGIo@google.com>
 <20221227164748.r7ouwpptb4lxbdxq@libretux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tmdYy43LmQWRZ+It"
Content-Disposition: inline
In-Reply-To: <20221227164748.r7ouwpptb4lxbdxq@libretux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tmdYy43LmQWRZ+It
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Joe,

I thought I replied to Lee's message the other day but obviously forgot
to send it.

On Tue, Dec 27, 2022 at 04:47:58PM +0000, Joseph Strauss wrote:
> On 22/12/23 12:15PM, Lee Jones wrote:
> > On Wed, 14 Dec 2022, Joseph Strauss wrote:
> >
> > Would you mind composing your mails such that my Key Manager doens't ask
> > me for a password in order to view them please?

> I would be happy to, but I am not sure how to diagnose or fix the
> problem. I used git send-email to send the patch. I have no such problem
> when viewing the email from my own client. I looked at the email headers
> and did not see anything out of the ordinary, and the thread shows up
> fine on lore.kernel.org.

> Is there any other information you can provide
> about the problem? Has it happened before?

Unfortunately it has - and it is a protonmail "feature".
kernel.org publishes keys for it's users via WKD:
https://www.kernel.org/doc/html/v4.17/process/maintainer-pgp-guide.html#configure-auto-key-retrieval-using-wkd-and-dane

protonmail, as part of the "back end" or w/e automagically picks up the
keys and uses them to encrypt the message. The list (and people without
WKD set up for their domains) will get the un-encrypted version

When I was a proton user, I could not find a way in the UI to disable
it. I contacted their support at the time who told me it was a feature!

Recently it cropped up again:
https://lore.kernel.org/all/20221122213754.45474-1-alobakin@mailbox.org/
Unfortunately, the "workaround" was to avoid proton there too.

I was wondering, when I saw Lee's mail, if we should add some sort of
comment about this proton behaviour to process/email-clients..

Conor.


--tmdYy43LmQWRZ+It
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6slPwAKCRB4tDGHoIJi
0u4MAPwK7vn2BkixTK5cV4MAxSp4odvUVVxm+yJBGFvS/AIwLgEA9lk3Dmk1HavO
R7TQV/pmi9nOEcsB7slmY5fpRiVseAQ=
=ufRz
-----END PGP SIGNATURE-----

--tmdYy43LmQWRZ+It--
