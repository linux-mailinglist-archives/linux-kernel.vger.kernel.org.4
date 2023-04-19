Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628206E7F15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjDSQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjDSQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:03:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F142B10C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:03:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B822219B2;
        Wed, 19 Apr 2023 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681920234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fj187kAnOsUhiVo8qd89qlueBGoipwOUvJwAW9NNSDE=;
        b=b2xF+YtpEENoNt9eIjyic5Of3nwIi65EqyCcWY+J7+JU9Slt0JJ1WpjdKavGZ5XXbft6ZX
        ct6mC1kLIkOsS1ADNDxEKW2UyCYzePfHsi05qxZlkz+zL5f2bGLTVkglxYO1tku0hCt5ux
        YZQDmX1fiBRoW+mvvVkDeFM4+TlFRG4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BCFE13580;
        Wed, 19 Apr 2023 16:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PTKuGOoQQGQvKgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 19 Apr 2023 16:03:54 +0000
Message-ID: <ed6bfa1a-7e82-8273-ee7f-0e8097397724@suse.com>
Date:   Wed, 19 Apr 2023 18:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
 <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
 <20230418012435.fhjxd6moaz6tmnep@treble>
 <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wYjk9cFRjZ2dTyReTa70E2Lb"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wYjk9cFRjZ2dTyReTa70E2Lb
Content-Type: multipart/mixed; boundary="------------24r0bGXJfV1KbjS2hhAiwFLy";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
Message-ID: <ed6bfa1a-7e82-8273-ee7f-0e8097397724@suse.com>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
 <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
 <20230418012435.fhjxd6moaz6tmnep@treble>
 <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>
In-Reply-To: <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>

--------------24r0bGXJfV1KbjS2hhAiwFLy
Content-Type: multipart/mixed; boundary="------------cWB1SWjEG2hm3y11ecMgCAqj"

--------------cWB1SWjEG2hm3y11ecMgCAqj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjMgMTc6NTksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBB
cHIgMTcsIDIwMjMgYXQgMDY6MjQ6MzVQTSAtMDcwMCwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6
DQo+PiBJIGltcGxlbWVudGVkIGl0IGluIHRoZSBwYXRjaCBiZWxvdy4NCj4gDQo+IEhhLCBh
bWF6aW5nISBUaGFua3MgbWFuLiA6LSkNCj4gDQo+PiBJdCB3YXMgcHJldHR5IHN0cmFpZ2h0
Zm9yd2FyZA0KPj4gc2luY2UgdGhpcyBjYXNlIGFsd2F5cyg/KSBpbnZvbHZlcyB0d28gcmVs
b2NhdGlvbnMgd2l0aGluIGEgc2luZ2xlDQo+PiBpbnN0cnVjdGlvbiwgbGlrZToNCj4+DQo+
PiAgIDNkOToJNDggYzcgMDUgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgCW1vdnEgICAkMHgw
LDB4MCglcmlwKSAgICAgICAgIyAzZTQgPHg4Nl93YWxsY2xvY2tfaW5pdCsweGE0PgkzZGM6
IFJfWDg2XzY0X1BDMzIJeDg2X3BsYXRmb3JtKzB4OA0KPj4gCTNlMDogUl9YODZfNjRfMzJT
CS5pbml0LnRleHQrMHgyODANCj4+DQo+PiBTbyBvYmp0b29sIHdhcm5zIGlmIHRoZSBpbnN0
cnVjdGlvbidzIGZpcnN0IHJlbG9jYXRpb24gaXMgbm9uLWluaXQgYW5kDQo+PiB0aGUgc2Vj
b25kIG9uZSBpcyBpbml0Lg0KPiANCj4gU291bmRzIHBsYXVzaWJsZSB0byBtZS4NCj4gDQo+
PiBUaGVyZSBhcmUgOSAiZGlzYWxsb3dlZCBzdG9yZSIgd2FybmluZ3MuICBUaGVyZSB3b3Vs
ZCBoYXZlIGJlZW4gbW9yZSwNCj4+IGJ1dCBJIGFkZGVkIHBlci1zeW1ib2wgcmF0ZS1saW1p
dGluZyB0byBrZWVwIHRoZSB0b3RhbCBudW1iZXIgb2YNCj4+IHdhcm5pbmdzIGRvd24uICBG
b3IgZXhhbXBsZSwgaW5zdGVhZCBvZiB0aGUgeDg2X3dhbGxjbG9ja19pbml0KCkgaXNzdWUN
Cj4+IGRpc2NvdmVyZWQgYWJvdmUsIGl0IHNob3dzIGEgc2ltaWxhciB3YXJuaW5nIGZyb20g
ZWxzZXdoZXJlOg0KPj4NCj4+ICAgIHZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogeGVu
X2luaXRfYXBpYysweGFiOiBkaXNhbGxvd2VkIHN0b3JlIG9mIGluaXQgc3ltYm9sIHhlbl9h
cGljX2NoZWNrIHRvIG5vbi1pbml0IGRhdGEgeDg2X3BsYXRmb3JtDQo+IA0KPiBPYnZpb3Vz
bHkgYSBnb29kIGNhdGNoLg0KPiANCj4gSG93ZXZlciwgdGhlIG9ubHkgY2FsbCBzaXRlIGlz
IGluIGFwaWNfaW50cl9tb2RlX2luaXQoKSB3aGljaCBpdHNlbGYgaXMNCj4gX19pbml0LiBT
byB5ZWFoLCBzdHJpY3RseSBzcGVha2luZyBub3RoaW5nIHdyb25nLg0KPiANCj4gKklGKiBz
b21ldGhpbmcgY2FsbHMgaXQgbGF0ZXIsIHdoZW4gX19pbml0IGlzIGdvbmUsIHRoZW4gYm9v
bS4NCj4gDQo+IER1bm5vLCBtYXliZQ0KPiANCj4gYSkgdHJhY2sgY2FsbCBzaXRlcyB0b28g
YnV0IG1heWJlIGV4cGVuc2l2ZSBhbmQgdG9vIG11Y2gNCj4gDQo+IG9yDQo+IA0KPiBiKSBt
YWtlIHRob3NlIHdhcm5pbmdzIGRlYnVnIG1lc3NhZ2VzIGluIGNhc2Ugc29tZW9uZSB3YW50
cyB0byBydW4gb2JqdG9vbA0KPiBpbiBkZWJ1ZyBtb2RlLCBmZWVscyByZWFsbHkgYm9yZWQg
YW5kIHdhbnRzIHRvIGZpeCBwb3RlbnRpYWwgaXNzdWVzLg0KPiANCj4gT3Igc29tZW9uZSBo
YXMgYSBiZXR0ZXIgaWRlYS4NCj4gDQo+PiBBbnl3YXksIHRoaXMgaXMga2luZCBvZiBleHBl
cmltZW50YWwuICBJZiBhbnkgb2YgdGhlc2Ugd2FybmluZ3MgZG9uJ3QNCj4+IHR1cm4gb3V0
IHRvIGJlIHVzZWZ1bCBJIGNvdWxkIGRyb3Agc29tZSBvciBhbGwgdGhlbS4NCj4gDQo+IFJp
Z2h0LCBJIGNhbiBjZXJ0YWlubHkgc2VlIHBvdGVudGlhbCBhbmQgYXMgc2FpZCwgc2luY2Ug
d2UncmUgYWxyZWFkeQ0KPiBkb2luZyBvYmp0b29sIG1hc3NhZ2luZyBvZiBvYmplY3QgZmls
ZXMsIHRob3VnaHQgdGhpcyBzaG91bGQgYmUgcHJldHR5DQo+IGVhc3kgdG8gZG8uIEFzIHlv
dSd2ZSBzaG93bi4gOy0pDQoNCldoYXQgYWJvdXQgc3BsaXR0aW5nIHRoZSBmdW5jdGlvbiB2
ZWN0b3JzIGludG8gX19pbml0IGFuZCBub24taW5pdCBwYXJ0cz8NCg0KVGhpcyB3b3VsZCBz
b2x2ZSBhYm92ZSBwcm9ibGVtIGF1dG9tYXRpY2FsbHksIGFzIGEgbm9uLWluaXQgZnVuY3Rp
b24gY291bGRuJ3QNCmRlcmVmIHRoZSBfX2luaXQgcGFydCBvZiB4ODZfcGxhdGZvcm0uDQoN
Cg0KSnVlcmdlbg0K
--------------cWB1SWjEG2hm3y11ecMgCAqj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------cWB1SWjEG2hm3y11ecMgCAqj--

--------------24r0bGXJfV1KbjS2hhAiwFLy--

--------------wYjk9cFRjZ2dTyReTa70E2Lb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRAEOkFAwAAAAAACgkQsN6d1ii/Ey9X
Xgf/flNa2tHQ/QZ757rCMEGF/jWVqskrzCVvIzfeElBshX/2wL6fPYdvSAN8lQ+PC6ub1PgYWyZD
bCPbGXqS2GWvq30sDr+lWCNWQVvdbUssp0YmoDq1Inu+1o7MLRnPYafB34kGGniwDmY3Hl4oOp4K
rCLsjcE8Ne53kKlO4r71G0z0METAgtPAA/0NYqQjyzeZBXdsKg7BxBEKhjqqsYTN2thgUuYTyvVL
M0UW0noDp633M+JvPorwKq2WMs/prBwTMkwNaoA65noqsc3w4eTxVzvQfIcucWmbyEd4NhrxvxEa
w3fWbNIkEOieB7PjLAUw2h6lTHwTohcK7rzBk9Z2MQ==
=4o9M
-----END PGP SIGNATURE-----

--------------wYjk9cFRjZ2dTyReTa70E2Lb--
