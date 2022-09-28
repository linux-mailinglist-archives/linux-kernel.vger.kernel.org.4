Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A75EDE07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiI1NoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiI1Nn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:43:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3CA8964
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:43:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 099E621C10;
        Wed, 28 Sep 2022 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664372637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0+qgVvQ+GNlXq/zBvTYpmD3bvTKG59KN9G2baCe3L4s=;
        b=P5DHHumd2i+xFneCbxXiNZU52CtcBxpCKL9MIVmmVrmJGgYeR/5igZszVabPCAdZV1CcNQ
        crqIIxjgQ2zmZ1T0kaCBRaY6p02GE2G0aL7KND8nz3OTJl9Ayg18aWhbBm5Cjhw04nHzXr
        mDD9nG6UhXbW7Z8mFNsi6Xo2GV1IReg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B73D913677;
        Wed, 28 Sep 2022 13:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rqnjKpxPNGNkYQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 13:43:56 +0000
Message-ID: <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
Date:   Wed, 28 Sep 2022 15:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic> <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
In-Reply-To: <YzQui+rOGrM6otzp@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kLgPI4mCjxlBFdWM3iXqbGfB"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kLgPI4mCjxlBFdWM3iXqbGfB
Content-Type: multipart/mixed; boundary="------------MXeAQGi5Qqv0r0hnWtTYtC8l";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic> <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
In-Reply-To: <YzQui+rOGrM6otzp@zn.tnic>

--------------MXeAQGi5Qqv0r0hnWtTYtC8l
Content-Type: multipart/mixed; boundary="------------B5MVV0E1Q4UseucaNVxkMjr0"

--------------B5MVV0E1Q4UseucaNVxkMjr0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMTM6MjIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBT
ZXAgMjgsIDIwMjIgYXQgMDE6MTQ6MTFQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE5vLCB3ZSBkb24ndC4NCj4+DQo+PiBVc2luZyBiYXNpY2FsbHkgeW91ciBwYXRjaCwg
YnV0IHdpdGgNCj4+DQo+PiArCW10cnJfb25saW5lID0gY3B1aHBfc2V0dXBfc3RhdGVfbm9j
YWxscyhDUFVIUF9BUF9PTkxJTkVfRFlOLA0KPj4gKwkJCQkJCSJ4ODYvbXRycjpvbmxpbmUi
LA0KPj4gKwkJCQkJCW10cnJfYXBfaW5pdCwgTlVMTCk7DQo+Pg0KPj4gbW92ZWQgdG8gdGhl
IGVuZCBvZiBtdHJyX2Fwc19pbml0KCksIGFuZDoNCj4+DQo+PiArdm9pZCBtdHJyX2Fwc190
aGF3KHZvaWQpDQo+PiArew0KPj4gKwljcHVocF9yZW1vdmVfc3RhdGVfbm9jYWxscyhtdHJy
X29ubGluZSk7DQo+PiArfQ0KPiANCj4gWWVzLCBzbyB5b3Ugc2FpZC4gSSdtIG5vdCBzdXJl
IEkgbGlrZSB0aGlzIHRvZ2dsaW5nIG9mIG5vdGlmaWVyDQo+IHJlZ2lzdHJhdGlvbiBsaWtl
IHRoYXQuDQoNClllYWgsIGVzcGVjaWFsbHkgd2l0aCBoYXZpbmcgdG8gcmVtZW1iZXIgdGhl
IHNsb3QuDQoNCldvdWxkIHlvdSBmZWVsIGJldHRlciB3aXRoIGFkZGluZyBhIG5ldyBlbnVt
IG1lbWJlciBDUFVIUF9BUF9DQUNIRUNUUkxfT05MSU5FPw0KDQpUaGlzIHdvdWxkIGF2b2lk
IGEgcG9zc2libGUgc291cmNlIG9mIGZhaWx1cmUgZHVyaW5nIHJlc3VtZSBpbiBjYXNlIG5v
IHNsb3QNCmZvciBDUFVIUF9BUF9PTkxJTkVfRFlOIGlzIGZvdW5kIChxdWl0ZSBpbXByb2Jh
YmxlLCBidXQgaW4gdGhlb3J5IHBvc3NpYmxlKS4NCg0KPiBPcHRpbWFsbHksIEknZCBsaWtl
IHRvIGJlIGFibGUgdG8gcXVlcnkgdGhlIHN1c3BlbmQgY29kZSB3aGV0aGVyIGl0IGlzDQo+
IGluIHRoZSBwcm9jZXNzIG9mIHJlc3VtaW5nLg0KPiANCj4gVGhpcyBoZXJlOg0KPiANCj4g
DQo+IHN0YXRpYyBpbnQgcmVzdW1lX3RhcmdldF9rZXJuZWwoYm9vbCBwbGF0Zm9ybV9tb2Rl
KQ0KPiB7DQo+IA0KPiAuLi4NCj4gDQo+ICAgRW5hYmxlX2lycXM6DQo+ICAgICAgICAgIHN5
c3RlbV9zdGF0ZSA9IFNZU1RFTV9SVU5OSU5HOw0KPiAgICAgICAgICBsb2NhbF9pcnFfZW5h
YmxlKCk7DQo+ICAgDQo+ICAgRW5hYmxlX2NwdXM6DQo+ICAgICAgICAgIHBtX3NsZWVwX2Vu
YWJsZV9zZWNvbmRhcnlfY3B1cygpOw0KPiANCj4gDQo+IGJ1dCBiZWluZyBhYmxlIHRvIGRv
Og0KPiANCj4gICAgICAgICAgcG1fc2xlZXBfZW5hYmxlX3NlY29uZGFyeV9jcHVzKCk7DQo+
IAlzeXN0ZW1fc3RhdGUgPSBTWVNURU1fUlVOTklORyB8IFNZU1RFTV9SVU5OSU5HX0FQU19V
UDsNCj4gDQo+IHdoaWNoIGNhbid0IHdvcmssIG9idmlvdXNseS4gQnV0IHNvbWV0aGluZyBs
aWtlIHRoYXQuDQo+IA0KDQpZb3Ugd291bGRuJ3Qgd2FudCB0byBkbyB0aGF0IHRoZXJlLCBh
cyB0aGVyZSBhcmUgbXVsdGlwbGUgcGxhY2VzIHdoZXJlDQpwbV9zbGVlcF9lbmFibGVfc2Vj
b25kYXJ5X2NwdXMoKSBpcyBiZWluZyBjYWxsZWQuIEFkZGl0aW9uYWxseSBub3QgYWxsDQpj
YXNlcyBhcmUgY29taW5nIGluIHZpYSBwbV9zbGVlcF9lbmFibGVfc2Vjb25kYXJ5X2NwdXMo
KSwgYXMgdGhlcmUgaXMNCmUuZy4gYSBjYWxsIG9mIHN1c3BlbmRfZW5hYmxlX3NlY29uZGFy
eV9jcHVzKCkgZnJvbSBrZXJuZWxfa2V4ZWMoKSwNCndoaWNoIHdhbnRzIHRvIGhhdmUgdGhl
IHNhbWUgaGFuZGxpbmcuDQoNCmFyY2hfdGhhd19zZWNvbmRhcnlfY3B1c19iZWdpbigpIGFu
ZCBhcmNoX3RoYXdfc2Vjb25kYXJ5X2NwdXNfZW5kKCkgYXJlDQp0aGUgZnVuY3Rpb25zIHRv
IG1hcmsgc3RhcnQgYW5kIGVuZCBvZiB0aGUgc3BlY2lhbCByZWdpb24gd2hlcmUgdGhlDQpk
ZWxheWVkIE1UUlIgc2V0dXAgc2hvdWxkIGhhcHBlbi4NCg0KDQpKdWVyZ2VuDQo=
--------------B5MVV0E1Q4UseucaNVxkMjr0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------B5MVV0E1Q4UseucaNVxkMjr0--

--------------MXeAQGi5Qqv0r0hnWtTYtC8l--

--------------kLgPI4mCjxlBFdWM3iXqbGfB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM0T5wFAwAAAAAACgkQsN6d1ii/Ey/X
Sgf/crikTlJTPVcK1Ea0f8VQ0pY4rHV7agTDdfbNoN4Qh4vMLm/oYM+HM7DXpN64u68pk0b8eEwP
IKE24yyYWt77yWMBLfXpO9yGtV82D3GmPD/Wc2Ma+pyYC926PHf70VNKuNe/tyXZAUL96qaEA5I0
ftsq75ktri6X323ky92q72azaAblDodwowr2RUzLRQjPlwcRJr2OwnHosrAm3RWVe8LtRuFCeHm5
clWaOCiROKuhCNa1GNvuPsmIdZUa7xPItPhf9WewfMQneGxd0WrzDpJryH8g5r16a/aThcpqret6
ujJmNQIvyIQldvfHwNP0Fid5vBagiJiz9Zkt65dJOA==
=osbX
-----END PGP SIGNATURE-----

--------------kLgPI4mCjxlBFdWM3iXqbGfB--
