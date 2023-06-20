Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD17366DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjFTJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFTJBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:01:09 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E01704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=h0pwII/osiZQMcrjxkgj4Y9BGp05
        vZ2TtRFtVzE1d00=; b=3agXCm4UMOic3fHPpNZFnpFfAQFZErRv2POvhTB+gYjr
        TNM2E4T5hHSZnT3wTNUHGrrPsKncBb/MZc159daTUUiPtNU0ftCodifLKc++M1aW
        Tj2khKTi7Ft+G00GpC4mRwpuHp1R29jPsJ6GVjOnKkbRG4yuVV2W/H4pnctLNkk=
Received: (qmail 568493 invoked from network); 20 Jun 2023 11:00:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 11:00:55 +0200
X-UD-Smtp-Session: l3s3148p1@fa+U44v+vINehhtC
Date:   Tue, 20 Jun 2023 11:00:55 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Message-ID: <ZJFqxzU2ij4kI131@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
 <ZIcC/sg59Ti+lL1N@ninjato>
 <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b2ug3UcAHMJsknOi"
Content-Disposition: inline
In-Reply-To: <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2ug3UcAHMJsknOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johan,

> and sorry about the late feedback on this. Didn't have time to process
> my queue before some holiday last week.

No worries. I hope you had some nice holiday!

> No, sorry, keeping separate drivers per vendor was a deliberate choice.

Yes, OK. I am not really surprised.

> First, some of these devices support vendor specific protocols which we
> may add driver support for at some point beyond currently just exporting
> this information to user space (e.g. to change line speed from the
> driver).

OK, I thought we can seperatae again if this really coming somewhen, but
we can also leave it like this.

> Second, device families are expected to share at least some common
> properties like reset signalling and supplies, which are better kept
> separate.

Thanks for the feedback!

   Wolfram


--b2ug3UcAHMJsknOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRascACgkQFA3kzBSg
KbbNpg/9Fub1Yxq7inof/XB992RnC3OfDgqetgzj8TnecbxYKDg+hNd+IRHywhZV
iUm8SrL5wC5jHZ7ugxgtRkZbqAkaEHh5rNI3Vo5HFl29bBjC6XKAiW+xoGMyauNi
LfvzVAMDBFRC9i4fGHVQSS5o+rUMN4iX/BmtfAs4mVaV8LQt16XiE6TXtZt5kBYV
Ac0RBgyLoe+8cIIvNccXZX/xjZRYjKx8L2lkAJdJBzhbs1vBP/baGOzu+wf6kS1N
xqSVliwEp0d+UPg1sapvHX+65+rYDkvJ8Wh4lUtQ4U9tRPhP2VQiEE70rXDwmbF4
aMEYC1hKiGCiMMfenDgXQ/wnrQoemrBxvs0Ac/okveNzY0A7BCDccXJPIkgQvE9+
CZmjUWSpPpUmu/QATsYrl5q9fmrT9BxRVbgLYeX1m7tF4XVngrjHJxAXLPz0EJrU
pL9Er95ogXL4opiOpZvaYz9THBBgogvW8yAD/HhHA9cetEGnxOG67g4kLbGQgeEp
8sFqRcZA2s64DemewUOFwDu4gv/OBxV7qe5XULNfYg1aLQXukwaQcNLK3qCYI4De
qj+zHbbCwA0omxCBxrs39zO1l1bdQCfum6UZc/3j5JcjY2NE2H3slVLtBj6AK1XY
egfrzBa5L5mO4r2Eo9yrB/NKe/n8ofzvkbdWCocfMtx51Ky+vfo=
=4U9z
-----END PGP SIGNATURE-----

--b2ug3UcAHMJsknOi--
