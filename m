Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846A16780A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjAWP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:58:36 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3937297
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:58:34 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EA7801C0008;
        Mon, 23 Jan 2023 15:58:32 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 16:58:22 +0100
Message-ID: <2072706.5Xk3ikgrb0@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230123154839.k3d6maptnxvb3fw3@quack3>
References: <20230122191603.59359-1-didi.debian@cknow.org>
 <20230123154839.k3d6maptnxvb3fw3@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1908092.4UR3msx5RQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1908092.4UR3msx5RQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: Fix full name of the GPL
Date: Mon, 23 Jan 2023 16:58:22 +0100
Message-ID: <2072706.5Xk3ikgrb0@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230123154839.k3d6maptnxvb3fw3@quack3>
MIME-Version: 1.0

On Monday, 23 January 2023 16:48:39 CET Jan Kara wrote:
> On Sun 22-01-23 20:16:03, Diederik de Haas wrote:
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > ---
> > fs/udf/ecma_167.h | 2 +-
> > fs/udf/osta_udf.h | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks. I've added the patch to my tree.

While I initially saw it as a spelling error, I've since changed my view that 
it would actually be changing the license and I'm not qualified to do that.
See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/

While it seemed reasonable to *assume* that the GNU General Public License was 
meant, I (now) think that is not sufficient when it comes to legal/license 
material, which this is. I think, but I'm not a lawyer.

So maybe it's better to remove/revert it from your tree?

Sorry,
  Diederik
--nextPart1908092.4UR3msx5RQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY86ungAKCRDXblvOeH7b
bq2GAP93Z5vEt/x/H0obP8AIjkCQ9OIopNH2ROfqDxbkMX5wnwEAgLn/6WmDytKG
a4A6jw06nZy1c6IYt4Lge/heskaxAAw=
=C50f
-----END PGP SIGNATURE-----

--nextPart1908092.4UR3msx5RQ--



