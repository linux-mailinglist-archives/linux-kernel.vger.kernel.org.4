Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4336C7C54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjCXKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:16:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA379136F3;
        Fri, 24 Mar 2023 03:16:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7AAA21F898;
        Fri, 24 Mar 2023 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679652986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFdEpZgkMqY3jkdL4KU0Ps6zGuMFPWyX35+yWmsMQgk=;
        b=Xs+hNl/yRKg1wDMgjI39W1rFF/NLiFCJo8I8fqIgEc8No9Ouv0wCHOvK2/sNSPh0mxC5RK
        ZEnUBH90/GS1q3zhm/+pNwUc6EvZeGGbCHyfbNbMvMUFQwBx+eDiSWZAjJIYT0cd34E0IJ
        etx9CuLqw3wAHnb/xgzkkfjPodns7h8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D926138ED;
        Fri, 24 Mar 2023 10:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KV5VDXp4HWT1OgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 10:16:26 +0000
Date:   Fri, 24 Mar 2023 11:16:24 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH RESEND v3] nbd_genl_status: null check for nla_nest_start
Message-ID: <20230324101624.mnbagb3jxshucawq@blackpad>
References: <20230323193032.28483-1-mkoutny@suse.com>
 <6c507b78-35fb-fe23-51f0-e5bb754679d0@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tly6jqa3p5uzjb5y"
Content-Disposition: inline
In-Reply-To: <6c507b78-35fb-fe23-51f0-e5bb754679d0@kernel.dk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tly6jqa3p5uzjb5y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.

On Thu, Mar 23, 2023 at 04:51:17PM -0600, Jens Axboe <axboe@kernel.dk> wrot=
e:
> So please don't mix CVEs into any of this, they don't matter one bit.

Do not shoot the messenger.

(But I'll refrain from that numeric reference to disincentivize such
trophy collecting.)

> Never have, and never will. What's important is how the bug can be
> triggered.

=46rom my perspective it's pragmatic better-safe-than-sorry -- a proof may
be conceived that rules out any triggering condition, it's less work to
put the guard in though.

My .02=E2=82=AC,
Michal

--tly6jqa3p5uzjb5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB14dgAKCRAkDQmsBEOq
uQ71AQDGZxjMPEueZul0m/zsn0FkW1akNCWxkd5shBj5jiI4vAD/Ua8Gutx5iw+Y
Sprxj5N+CO+W9Cw4P19YOI66IpM+wAQ=
=4Dp8
-----END PGP SIGNATURE-----

--tly6jqa3p5uzjb5y--
