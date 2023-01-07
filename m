Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D124D660CC2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjAGH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:28:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01478A7A;
        Fri,  6 Jan 2023 23:28:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NpsJb5GXTz4xxJ;
        Sat,  7 Jan 2023 18:28:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673076529;
        bh=Zdv+R6YPs83QWdfSNN1Av5sbUwzsrfaSkUEZjiw0r5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZMWdSxyYbGE0ATqxxmAA8OX41nzGdd3FS5GL62FW7BzYZm9mbx3zxSyXXBYkP2OV1
         5numdBYTf4HwcDUbWrip24hofQT6KiglZpcO8j0StQ6tJ8r3GLARHjp7o6BvvLVQPU
         qaSzowgPmgPsrpCu2g7DrtvpI2mRGalFCF7rOA6wg+vb66T6BXAOvWaNJY/O95iCYY
         XXIQrKU8hiblD1O0TrEyMO1bLr5Ajn6t6hVflmrSrZz1vcL5og4WHhBZZ+pxkBPe+0
         TzS+MBqGKJ1TvICmbUInrhtkD+lCHrJmxFASneBSGmo2d4IY2ou4MflVh/sAOBndTh
         U2KXpkiJzzPxw==
Date:   Sat, 7 Jan 2023 18:28:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc2
Message-ID: <20230107182826.1ae7b32c@canb.auug.org.au>
In-Reply-To: <f0bc7090c04bc6c0b08471494324a3a577c2d2a1.camel@HansenPartnership.com>
References: <f0bc7090c04bc6c0b08471494324a3a577c2d2a1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yy3=IwJLELuFjAvv5iDUngV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yy3=IwJLELuFjAvv5iDUngV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, 06 Jan 2023 22:37:10 -0500 James Bottomley <James.Bottomley@HansenP=
artnership.com> wrote:
>
> Lukas Bulwahn (1):
>       scsi: core: Remove leftovers due to pktcdvd being removed

I thought that this one was to be removed as the pktcdvd drivers
removal is being reverted in the block tree in linux-next (and the
revert caused a build failure in linux-next due to this scsi commit).

--=20
Cheers,
Stephen Rothwell

--Sig_/yy3=IwJLELuFjAvv5iDUngV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO5HxoACgkQAVBC80lX
0GxtkQgAgNaMMumoIrhmRVsz1OeVLZUNJAjASCv8TudGGRdQha5k4yMaysLoz0iD
aheei44phJDQ7jComEZ3HXJB+kscxjcnQt8BVV7dI0NhzBLSwKobFkoYaSAEMpJb
rWreT9xUmlNX44s1XzJRwZbhJ3aD1uJHdqxO91lU35YlKQrchpMm+O7MhCrvfHej
sroaavVVKYIOWkcWuVFE0mcZ0tk2HkOMDxmkacNU3hW5IFsFrBllboloXaG6Q9Ib
jjlTYifAbC7PfImEwubORR6fOUAq3F4JUxLWhVFyzu6hBzsyRO3E7fcYBXS8AR9q
6nZaQcIaFhaD9uW6wGqFseu1IkLLMQ==
=CX3N
-----END PGP SIGNATURE-----

--Sig_/yy3=IwJLELuFjAvv5iDUngV--
