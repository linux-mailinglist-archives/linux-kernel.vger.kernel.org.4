Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6900C6871FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBAXh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAXh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:37:57 -0500
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A049027
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:37:55 -0800 (PST)
From:   Sam James <sam@gentoo.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AB92C01C-0A6C-43B2-B399-FC07DFD7B8FA";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [BUG] Add missing <linux/string.h> include for strcmp.
Message-Id: <C11D0452-926E-4F06-B45F-004091200DA2@gentoo.org>
Date:   Wed, 1 Feb 2023 23:37:41 +0000
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_AB92C01C-0A6C-43B2-B399-FC07DFD7B8FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Finally getting back to this. Thanks for reporting the problem (we =
reverted it as a result, obviously).

Would you mind sharing a preprocessed version of the failing file =
please?

(Passing -save-temps to CC can do this, the relevant files should be =
xx.i)

Thanks.


--Apple-Mail=_AB92C01C-0A6C-43B2-B399-FC07DFD7B8FA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCY9r3xV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kNn4AP4gjQjH5r5UDRPc6Z6xKAZy967hijRyU+tf9ftkH7EYHQEAo988DoMlEJ4T
r1y6AmvXfNFzo0n4y9JfbHYJKja/ngw=
=o6qu
-----END PGP SIGNATURE-----

--Apple-Mail=_AB92C01C-0A6C-43B2-B399-FC07DFD7B8FA--
