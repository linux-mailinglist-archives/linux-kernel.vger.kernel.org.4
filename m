Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81B267BB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjAYUDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjAYUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:13 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E493C297;
        Wed, 25 Jan 2023 12:03:11 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8E20F235E;
        Wed, 25 Jan 2023 21:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1674676988;
        bh=0Pyp8XqYL9yIPYRFtwwGMk7tjP+Lqo4V6waKpXL5npc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jht9dtTg+3QMDcTOoW4CC1IP/zBnQctn/FZY1QRY9cdYHzs1s3NdCx0Z4YdBs8Z3j
         DPaM4SqlldqJYnORtAQTKKijjKzT7btQrxGlahpckm2TCfA43EBmugC5aLP+D92Pnf
         icQUDnmOZa9KuNY8UVlxw4GvgzszKjTI0lTpY7BTBl2O6/xJTiB6vUJAjxyFTPetW/
         OvlYFp9zeB2/9qdV4oYUJR9gzvqhaA78eVRDPn7xvS5wDabc3T4uL2YklOZvjbS3Oz
         7obKJsa0et3Um+DufMxxoLera3oJRj5wlpYgJncmMslnFAstirVUwAZbZt+2i+NLTa
         VF0I2GzNDKHXg==
Date:   Wed, 25 Jan 2023 21:03:07 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
Message-ID: <20230125200307.5f7yvbfhxxwq2ped@tarta.nabijaczleweli.xyz>
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
 <87tu0ecsk1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4ykb7jl63jyuh6k"
Content-Disposition: inline
In-Reply-To: <87tu0ecsk1.fsf@meer.lwn.net>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i4ykb7jl63jyuh6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2023 at 12:39:26PM -0700, Jonathan Corbet wrote:
> There was a series out there to delete this file entirely:
>   https://lore.kernel.org/lkml/cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz/
> I wonder whatever became of that?
No-one cared enough to apply and I got over re-sending it,
so only part of the whole clean-up landed.

Best,

--i4ykb7jl63jyuh6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPRivgACgkQvP0LAY0m
WPFZaw//WxkADLpW/pAu0nHQCiYlbIB4AttbAQYoik2NDKVO2WefzRYDP8pGGUtR
OQm2xWGEuD5+FG1lk0djvSQ4+a27W1lMrgtZjECAubRIo7GA3M+lv8+1xdkKkKjj
S8ucPg5X+1JsFjtZi2bQyH7yx3lztG69QecFJXMuB4t2SwCOOF5Tqx87c2RSVWgg
w0//DDbfsp3LPQ/pMyJuPmRms6Pcxy7F4nI/aBrbvjxXqVRUBrpraBHC/vjNOA14
x5ifXtImrjmPPqNJR6JjplyIYnHVIn1jcUwpbSh8L1BKR6M0HhRF8BItPlZg71bR
bvwDy4BkPMazpyjZUfNz1X/PMhj+wDMnhCfCQCLhLOEd24O8QZnAyaN5HzkgrkaY
G1V+gx742lK8SiYE/3HCpouJ1WyJ8QC9/BOmADglggWv396qjuxwDHp4+8P7xGRT
MurXanlB/li0zcbsNlKNQYTEYhsOhh3HBCRDfEOfqnRABUFdx38OdyMS2728cHw0
2PtTBNX+GpBBZZl+AsBHdUXqSfTobh3cZBHJBMOSrSYREdGHarpD8ylCfnUlyo23
zp/5IJ4Vf4ROZX55/455+j9TZJv5LE3mSmyoGOg7jC4ojbCQBsFCP2cdI0WFH+v8
yCg2fWUApp1Y9zkKMpcZoffYAzXL1lAeP3RaYSeAwyKn4NQ/XEc=
=tj7V
-----END PGP SIGNATURE-----

--i4ykb7jl63jyuh6k--
