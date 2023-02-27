Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2186A4372
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB0N4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0N4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:56:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2AB1F4B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:56:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F8461FD63;
        Mon, 27 Feb 2023 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677506172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RfQNYah8x5Y0NPIXsAytRMg7OoSg/dSA9feq5QKA7Dc=;
        b=g0kSGKQSIXWApLzSk10vcrDrvHUVa2w0ERnXx8KDUWxm8g8t7bq9IPguB6R/sDFUG0Nlwy
        cLTaiMJQGw7sC1HbCozbl0KGKh+tChRfX8AiOEQMDX/w7Q1nDcGYgCSZ3Gy1590icu+pn+
        NRlpaZ8//x6A+4KT7C9KidAfgNkUG58=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C05013912;
        Mon, 27 Feb 2023 13:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fwykAXy2/GOgdgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Feb 2023 13:56:12 +0000
Message-ID: <ba2deb01-ccb3-8a01-9856-0ac7d0679ccc@suse.com>
Date:   Mon, 27 Feb 2023 14:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 05/12] x86/xen: set MTRR state when running as Xen PV
 initial domain
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-6-jgross@suse.com>
 <a7897030-d420-a741-074a-6e21e7c1629b@oracle.com>
 <58248946-f0ad-ae3b-57a6-f7c15fd35198@suse.com>
 <432bb9b3-959e-1074-c0e6-a65ac46e489e@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <432bb9b3-959e-1074-c0e6-a65ac46e489e@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZzdaRHHSqC803kjDf1XRY09o"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZzdaRHHSqC803kjDf1XRY09o
Content-Type: multipart/mixed; boundary="------------YSFPn3OWBWPbjfHDzaYXpC5l";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Message-ID: <ba2deb01-ccb3-8a01-9856-0ac7d0679ccc@suse.com>
Subject: Re: [PATCH v3 05/12] x86/xen: set MTRR state when running as Xen PV
 initial domain
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-6-jgross@suse.com>
 <a7897030-d420-a741-074a-6e21e7c1629b@oracle.com>
 <58248946-f0ad-ae3b-57a6-f7c15fd35198@suse.com>
 <432bb9b3-959e-1074-c0e6-a65ac46e489e@oracle.com>
In-Reply-To: <432bb9b3-959e-1074-c0e6-a65ac46e489e@oracle.com>

--------------YSFPn3OWBWPbjfHDzaYXpC5l
Content-Type: multipart/mixed; boundary="------------M8wUK980ffJONh0gz0OEMY0o"

--------------M8wUK980ffJONh0gz0OEMY0o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDIuMjMgMTQ6NTIsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IA0KPiBP
biAyLzI3LzIzIDI6MTIgQU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAyNC4wMi4y
MyAyMjowMCwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPj4+DQo+Pj4gT24gMi8yMy8yMyA0
OjMyIEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgZm9y
IChyZWcgPSAwOyByZWcgPCBNVFJSX01BWF9WQVJfUkFOR0VTOyByZWcrKykgew0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgb3AudS5yZWFkX21lbXR5cGUucmVnID0gcmVnOw0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKEhZUEVSVklTT1JfcGxhdGZvcm1fb3AoJm9wKSkNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+Pj4NCj4+Pg0KPj4+IElmIHdlIGZhaWwg
b24gdGhlIGZpcnN0IGl0ZXJhdGlvbiwgZG8gd2Ugc3RpbGwgd2FudCB0byBtYXJrIE1UUlJz
IGFyZSANCj4+PiBlbmFibGVkL3NldCBpbiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSgpPw0KPj4N
Cj4+IEhtbSwgZ29vZCBpZGVhLg0KPj4NCj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgZHJv
cCB0aGUgY2FsbCBvZiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSgpIGluIHRoaXMNCj4+IGNhc2Uu
DQo+IA0KPiANCj4gVEJIIEkgYW0gbm90IHN1cmUgd2hhdCB0aGUgcmlnaHQgd2F5IGlzIHRv
IGhhbmRsZSBlcnJvcnMgaGVyZS4gV2hhdCBpZiB0aGUgDQo+IGh5cGVyY2FsbCBmYWlscyBv
biBzZWNvbmQgaXRlcmF0aW9uPw0KDQpUaGUgbWFpbiByZWFzb24gd291bGQgYmUgdGhhdCBv
bmx5IG9uZSB2YXJpYWJsZSBNVFJSIGlzIGF2YWlsYWJsZS4NCg0KSXRzIG5vdCBhcyBpZiB0
aGVyZSBhcmUgdmVyeSBjb21wbGljYXRlZCBzY2VuYXJpb3MgbGVhZGluZyB0byBmYWlsdXJl
cyBoZXJlLg0KDQpFaXRoZXIgdGhlIGludGVyZmFjZSBpcyB1c2FibGUgYW5kIHRoZW4gaXQg
d2lsbCB3b3JrLCBvciBpdCBpc24ndCB1c2FibGUNCmFuZCB3ZSBjYW4gZmFsbCBiYWNrIHRv
IHRvZGF5J3MgaGFuZGxpbmcgYnkgaWdub3JpbmcgTVRSUnMuDQoNCg0KSnVlcmdlbg0K
--------------M8wUK980ffJONh0gz0OEMY0o
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------M8wUK980ffJONh0gz0OEMY0o--

--------------YSFPn3OWBWPbjfHDzaYXpC5l--

--------------ZzdaRHHSqC803kjDf1XRY09o
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmP8tnsFAwAAAAAACgkQsN6d1ii/Ey8v
iQgAlJoeaKt/LI90VYkZC1QZshksoLiwmJjvgIlzPpJcTyr2t1jcVThoxBXCu+G86q5edXawKoEi
AK8kX2P/JsBNmD/SgYLHWiGqALNMStlj/cwZ3d6wEpc0icbrkU/tQq/OdEgMCdO5YT1VqUVSd/2R
3/rVbnOPA8E8Hjso9zWMfQu7LmWwMQKbhOJB8MRiXNc41qMvKKw1eWrgX/o1CKx+6j44XTgmS/5o
/fpi0WT1yP3iP+RsfzDncJPKdWtN4O0liTQaEmjC7khj9hY8Ekr+3dibTtRfx5Ru39chYLOTLFJR
jwA2lASmK0TmYnp4VpEmkiQjj2yU5Kl0l4rF5NOOaw==
=kPIV
-----END PGP SIGNATURE-----

--------------ZzdaRHHSqC803kjDf1XRY09o--
