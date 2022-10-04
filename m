Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF65F4564
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJDOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:24:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFED32BB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:24:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2AC1A1F8FE;
        Tue,  4 Oct 2022 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664893459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gv5GmCQFsdbQXt6KprnLekJV0ba5vXMeZ/bX1s7tLi8=;
        b=rDUAXLiZUWK+jDlbu5DLMFqiwmjXXjxPQiq5LPl5ncNKNaVc7XTBHeDXkSmDKBknlTmY1Q
        4/PyMzdUZ+PyqqPzeS/14mHBcmghyc9ZfirGLvBgkpdmmGvpW+9YgHyNjtZbFQEFOB3rIq
        yQYRhL2SIfuI372UMIUGueh42oqAyYw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02401139EF;
        Tue,  4 Oct 2022 14:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o1yPOhJCPGNXdQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 14:24:18 +0000
Message-ID: <9654aa58-2e1b-88b0-0165-fff39ba7b953@suse.com>
Date:   Tue, 4 Oct 2022 16:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [GIT PULL] x86/paravirt for 6.1
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <Yzw/1M8lEiLriU57@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Yzw/1M8lEiLriU57@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Lez4EFgFZzXj8zyTz3cUPkTn"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Lez4EFgFZzXj8zyTz3cUPkTn
Content-Type: multipart/mixed; boundary="------------85rQApS3sZ0XaiztHAkiirKi";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <9654aa58-2e1b-88b0-0165-fff39ba7b953@suse.com>
Subject: Re: [GIT PULL] x86/paravirt for 6.1
References: <Yzw/1M8lEiLriU57@zn.tnic>
In-Reply-To: <Yzw/1M8lEiLriU57@zn.tnic>

--------------85rQApS3sZ0XaiztHAkiirKi
Content-Type: multipart/mixed; boundary="------------rrWFry5dcr0r0skDOcVYMpsw"

--------------rrWFry5dcr0r0skDOcVYMpsw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTAuMjIgMTY6MTQsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gSGkgTGludXMs
DQo+IA0KPiBwbGVhc2UgcHVsbCBhIHNpbmdsZSBwYXJhdmlydCBvcHMgZml4IGZvciA2LjEu
DQo+IA0KPiBUaHguDQo+IA0KPiAtLS0NCj4gDQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBz
aW5jZSBjb21taXQgNTIxYTU0N2NlZDY0NzdjNTRiNGIwY2MyMDYwMDA0MDZjMjIxYjRkNjoN
Cj4gDQo+ICAgIExpbnV4IDYuMC1yYzYgKDIwMjItMDktMTggMTM6NDQ6MTQgLTA3MDApDQo+
IA0KPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4gDQo+ICAg
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlw
LmdpdCB0YWdzL3g4Nl9wYXJhdmlydF9mb3JfdjYuMV9yYzENCj4gDQo+IGZvciB5b3UgdG8g
ZmV0Y2ggY2hhbmdlcyB1cCB0byBmOTJmZjhmNWRjYTJhY2ZhNDc1ODQyYzcxMjEyNjU3YjA3
MDNjM2JlOg0KPiANCj4gICAgeDg2L3BhcmF2aXJ0OiBFbnN1cmUgcHJvcGVyIGFsaWdubWVu
dCAoMjAyMi0wOS0yMSAxMjozMDoxNiArMDIwMCkNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLSBF
bnN1cmUgcGFyYXZpcnQgcGF0Y2hpbmcgc2l0ZSBkZXNjcmlwdG9ycyBhcmUgYWxpZ25lZCBw
cm9wZXJseSBzbyB0aGF0DQo+IGNvZGUgY2FuIGRvIHByb3BlciBhcml0aG1ldGljIHdpdGgg
dGhlaXIgYWRkcmVzc2VzDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRob21hcyBHbGVpeG5lciAo
MSk6DQo+ICAgICAgICB4ODYvcGFyYXZpcnQ6IEVuc3VyZSBwcm9wZXIgYWxpZ25tZW50DQo+
IA0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmggICAgICAgfCAxICsNCj4g
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oIHwgMSArDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQoNCkhtbSwgYW55IHJlYXNvbiB3
aHkNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDkwMzA3MzcwNi4zMTkz
NzQ2LTEta2Vlc2Nvb2tAY2hyb21pdW0ub3JnLw0KDQppc24ndCBwYXJ0IG9mIHRoYXQgcHVs
bCByZXF1ZXN0Pw0KDQoNCkp1ZXJnZW4NCg==
--------------rrWFry5dcr0r0skDOcVYMpsw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------rrWFry5dcr0r0skDOcVYMpsw--

--------------85rQApS3sZ0XaiztHAkiirKi--

--------------Lez4EFgFZzXj8zyTz3cUPkTn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM8QhIFAwAAAAAACgkQsN6d1ii/Ey9F
4wf/bQUda+4d6h53+gy0CsSoEXNe8M6eV6YByLl3jOT9bCeq7uwgKwrYj+EVpmHrfFafME2pi/6i
0Uw0VvrD0rkgFVGCgFb9NQTXPYEuClej8ZKeUqABiYWPZnC4e8QKEBp/xw+HkmxglfPG0zeiPXVK
YD4QORriMfSlVQNRqdC6Y5JNyV8OJSPR0Oft4o5/mmMxFXPAy7fnRCoTImQDNZFweRsajZ6EpxPC
RXwdqOQUXjSzzqmTtQF7mY8gpiiMQRP8qLMXyc5f9qfDIc5luk2ttW0Z+bz+96aD57Z7aK78dEe7
jKni17XbJfPSyI0yrpUoHqHpNA3ZKM1xg1ijmFHoiw==
=nI8g
-----END PGP SIGNATURE-----

--------------Lez4EFgFZzXj8zyTz3cUPkTn--
