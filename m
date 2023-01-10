Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681FC663A90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbjAJIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjAJIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:08:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52D2DE2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:08:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A12B03E6DB;
        Tue, 10 Jan 2023 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673338079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0R2jA+ecFgshta3vkDpZTjBNhdF5coLo4TxsrYpzyw=;
        b=GYs+Bd0xk7tL3+jMhddK1YqdH0y8+YWKn/QW0Usjy068JSSa3m2T1TIYuNDR/J5RDDBt34
        qPBzDL4Hj17EH6WuSyKzKJbmp/bl0a1C+YJfn7kapTvp3vGqQdbnJik8osI+6bIiYmYwP7
        2RxpB0T9FicBnqLefEhE0gSrceVH9Os=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58EC01358A;
        Tue, 10 Jan 2023 08:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RSjlE98cvWN8BgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 08:07:59 +0000
Message-ID: <b220cdf1-7d8c-e8f6-eb22-7a93b0b330ea@suse.com>
Date:   Tue, 10 Jan 2023 09:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] xen/pvcalls: free active map buffer on
 pvcalls_front_free_map
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
Cc:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8gQ0uGiBiOXOeEGU0HSLL09N"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8gQ0uGiBiOXOeEGU0HSLL09N
Content-Type: multipart/mixed; boundary="------------u9z5dqxRb0ujLeyXzcx9HgSU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <b220cdf1-7d8c-e8f6-eb22-7a93b0b330ea@suse.com>
Subject: Re: [PATCH v1] xen/pvcalls: free active map buffer on
 pvcalls_front_free_map
References: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
In-Reply-To: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>

--------------u9z5dqxRb0ujLeyXzcx9HgSU
Content-Type: multipart/mixed; boundary="------------KYcv5NY9RdtDLbyPZBpgAZJU"

--------------KYcv5NY9RdtDLbyPZBpgAZJU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMTIuMjIgMTU6NTAsIE9sZWtzaWkgTW9pc2llaWV2IHdyb3RlOg0KPiBEYXRhIGJ1
ZmZlciBmb3IgYWN0aXZlIG1hcCBpcyBhbGxvY2F0ZWQgaW4gYWxsb2NfYWN0aXZlX3Jpbmcg
YW5kIGZyZWVkDQo+IGluIGZyZWVfYWN0aXZlX3JpbmcgZnVuY3Rpb24sIHdoaWNoIGlzIHVz
ZWQgb25seSBmb3IgdGhlIGVycm9yDQo+IGNsZWFudXAuIHB2Y2FsbHNfZnJvbnRfcmVsZWFz
ZSBpcyBjYWxsaW5nIHB2Y2FsbHNfZnJvbnRfZnJlZV9tYXAgd2hpY2gNCj4gZW5kcyBmb3Jl
aWduIGFjY2VzcyBmb3IgdGhpcyBidWZmZXIsIGJ1dCBkb2Vzbid0IGZyZWUgYWxsb2NhdGVk
IHBhZ2VzLg0KPiBDYWxsIGZyZWVfYWN0aXZlX3JpbmcgdG8gY2xlYW4gYWxsIGFsbG9jYXRl
ZCByZXNvdXJjZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lpIE1vaXNpZWlldiA8
b2xla3NpaV9tb2lzaWVpZXZAZXBhbS5jb20+DQoNClB1c2hlZCB0byB4ZW4vdGlwLmdpdCBm
b3ItbGludXMtNi4yDQoNCg0KSnVlcmdlbg0KDQo=
--------------KYcv5NY9RdtDLbyPZBpgAZJU
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------KYcv5NY9RdtDLbyPZBpgAZJU--

--------------u9z5dqxRb0ujLeyXzcx9HgSU--

--------------8gQ0uGiBiOXOeEGU0HSLL09N
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO9HN4FAwAAAAAACgkQsN6d1ii/Ey+7
5AgAhFX4FfJ6FhYGxjTFPefYV/e5GSvSZuMf+G8RGk5j6ehl8KBdnWO+m4l9T+lXGSLrxJZ8phvl
Heo2Z6UvTHmaoYajeIDfdmdwDfJxiNHWygW2qAFkBypCd8pKeZhk9VPiEYpsCpLDEjOlth+ggViX
wbzNwmUAslTbrWZniHPaqVdsCFV/JPdKf5/olC37FaRoVy26U4PYkUcnflMSq8jaXFfLNedOlGva
TvYd/zyEsROKkSuzBpbxRp3lcng41lzlYZcT/ZFiXECdnU4t9iHtBraYZXySbfbuCW/E4UvHWP43
02ip9dMJCiy8mzOYcO4OABjVJNr4JZad80XtOxqFBA==
=BVWP
-----END PGP SIGNATURE-----

--------------8gQ0uGiBiOXOeEGU0HSLL09N--
