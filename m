Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC7695539
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBNAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBNAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:09:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A9B45A;
        Mon, 13 Feb 2023 16:09:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG1mf6HK7z4x5Y;
        Tue, 14 Feb 2023 11:09:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676333395;
        bh=GPDjkuaOn+jwvXvUbubbCaUSDsW2I1N1o/5T9/Fr2rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VA4nCFUkcAzNqqsb/GChH+Ym2QYKOUtft0dd/a45TgvPjcLAWXc/YxYmH+wDewZ4l
         ZiFvMIwhVIRijzNW9IlVIlz9dS1OT7dnApkYOsdzNdDyygRxDf3rQPg9t7+6xs59cI
         BqOfrXvwbMLLEnFZ6vTHe/8Ewi9Mhkfpm9/n38SQtoT8EFqhsn5dKJtF9ezaXxnD1h
         CI6zSVld4Oc5vRt3EPghcWoD4SNzvtp/Xa6KLisM7cX0uhWlHkBi6U/Ekb/bITFxKS
         92OAweXWF2cV9Ng4XxZ2fpbIvln6hgvKduuA8iw1GaA1Bk7uiWhJIpuqhDqLyEOPGI
         8YdBfUs1FENIQ==
Date:   Tue, 14 Feb 2023 11:09:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chunwei Chen <david.chen@nutanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20230214110954.18874441@canb.auug.org.au>
In-Reply-To: <20230213142953.9c62494f0db76ba0f8af6ad5@linux-foundation.org>
References: <20230213080052.296dddb0@canb.auug.org.au>
        <20230214085452.03575f8b@canb.auug.org.au>
        <20230213142953.9c62494f0db76ba0f8af6ad5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5X6pTo6M3iC=tV3My4nC//I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5X6pTo6M3iC=tV3My4nC//I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 13 Feb 2023 14:29:53 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> yup, thanks.  I've made a note not to send this upstream.  But I'll
> keep it around in mm-hotfixes-unstable for a while so that users of the
> 6.2-rc4 based mm.git trees have it.

No worries, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/5X6pTo6M3iC=tV3My4nC//I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPq0VIACgkQAVBC80lX
0GxS+Af6An70ySmwP4/qL9zX8t7EX5At2rt9N7RGSvDTAqBvSVxKcT//fwfSHmkj
v/37MpEhuRHpH/PV6AOiovLOC+m8+EK6mySbll9f0fqumSVfXHcvI+Co+YI0AeZ6
pfAe0qhrYC2jp7CarP9bM6W7ez6xNc0pWmtqVrwPUJgUOCyRP6d9H+UYdUbpIgR7
SugqJjxcKN/DYbfKvkVUoqelcvVqOUUmqRQpYtC0a5izke7zlM+agWxrLFhjcQus
zYL4JJrwoZ2mwxqlSo5VRLzHmIBhkqfbELPYI2W4A12/qqJ+t6Js6J+NwwminIGH
m5JCKOyo0Le/SCl6YGWN3E8GYb+YJA==
=w6hs
-----END PGP SIGNATURE-----

--Sig_/5X6pTo6M3iC=tV3My4nC//I--
