Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E367D1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAZQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjAZQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:39:06 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932E5BB6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=vWapLCrdxD4HseM/i98cy1T36B2/
        HD7eHggH3gi9020=; b=co1iYTXGmC9EKd4RBrwLZeyXoe7s/MzYRp60n/MQsPO8
        D1gpYMk9gWhMzXYkpAOIse4al3BRTpHcDisR6Eca/0BjJFvFXFjChfRFYnIZAG3m
        10wcpxngtX3ZOU25EAXKF/Bb7T20plHI8yDwWak3hFPLg05YT3QPazCdaos0R+Y=
Received: (qmail 3871120 invoked from network); 26 Jan 2023 17:39:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 17:39:01 +0100
X-UD-Smtp-Session: l3s3148p1@M0XYYi3z8pMujnvo
Date:   Thu, 26 Jan 2023 17:39:00 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y9KspCXRASZOsEhc@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <CA+V-a8vp-oxaQyzPg2YonshdO-j0z+8vXpqgD=P8w94eDNJDOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ui+4td1bO9KDZD91"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vp-oxaQyzPg2YonshdO-j0z+8vXpqgD=P8w94eDNJDOA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ui+4td1bO9KDZD91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prabhakar,

> I am yet to test this patch on g2l (I'll test v3 as you plan to send it today).

Awesome, thank you!

> I think now you can get rid of this member?

Good point! I'll remove it in v3.

Happy hacking,

   Wolfram


--ui+4td1bO9KDZD91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPSrKAACgkQFA3kzBSg
KbaSqA/9H18xiwT8rXQEY9z2C0hneAa1l+h3bamcasf1zlUwwBeaPoAR8kGmPbzV
AURFHc40bcUTJP1TL7bQUApHvqhjVJjhWNHRIjo2G1JZEF08cLXexdXjvqY98l8D
LvV8oIRVvqbeyb3IhQ1iW1JXuMUI9VrI79E8T4dp185PTwmpvqI8EHbJTgrScOzg
BB5oavd+HeRyNby+N3FVplMSP1vDTwx8ijrUUmkzWSpg2NBc8cejb0lKoGHRnG71
AzpyDzF9r2Qaj7zTXZdXmcsZl8L4dxFe68glMb+obE+VlUqaUmA/ilgStq9MyTet
FxOxNLeWYw9LFIeFzYzACDtT7c+twtSlSVzlSjhb2lbsVFbM6i4zZbs5S4Fcf2rD
0kg6lJKJXwaOpM3FPt9XbAQNEJB+oQdBT0kAibjCEWtmmN/d/DUhWTM1Gt2P+k48
OC+hLSMiSa9394LSjJunnCgsit0n/YIBBNQTGR6hxvVR2s0fVS5PCGHeNWW45Qi/
Vvyp8n0/YnwsgG5zGa34Ibh7dK0KWoVqXZFnSpUv7YmgCXgUo6GUA5SLoZggedZ1
JUXwTVerWXK7yTKmvwrs5QiX8OzOGd6NP5m1firlB4zhlcVoHI47G3HnLWMmy4E2
D8Ad3apY4jbdLOUbGTLc5e7d6kVwEmIe43MTlW3O42+AnmFDKtQ=
=xzXq
-----END PGP SIGNATURE-----

--ui+4td1bO9KDZD91--
