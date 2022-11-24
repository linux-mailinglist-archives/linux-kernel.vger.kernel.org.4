Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7C6379F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKXNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiKXNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:30:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5350A4641
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:30:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9D6218BB;
        Thu, 24 Nov 2022 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669296640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNtLdszO3foiDTYSgvjJ6h1+flzm24yU1NLSZoWT7CI=;
        b=CPp9slZzK47sh8IIDmrE+Ezw924C4RpWd1/kluMqIxzZ5Js7dcBMtC9jjZuk6N8JvKwdJA
        f01XiCnXbySz0BpsHzItQqTBPU5otGfYzBfROszJJjddZCRZBG8QUL8BcHUu5iFM9f9TC2
        NJapIpT7/9zYtSRvt8cFoFfhyJmHdzA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3667613B4F;
        Thu, 24 Nov 2022 13:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /PPHCwByf2OtKAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 13:30:40 +0000
Message-ID: <a1fc1d88-2112-2b81-52bc-cbfb6736edf0@suse.com>
Date:   Thu, 24 Nov 2022 14:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] x86/boot: skip realmode init code when running as Xen
 PV guest
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
References: <20221123114523.3467-1-jgross@suse.com> <Y39xcnKCkbYQZjaE@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y39xcnKCkbYQZjaE@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0VLKXo0fwrqmfGnX066jb0rg"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0VLKXo0fwrqmfGnX066jb0rg
Content-Type: multipart/mixed; boundary="------------i6mFkV7gpV2Meh114x82itrq";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <a1fc1d88-2112-2b81-52bc-cbfb6736edf0@suse.com>
Subject: Re: [PATCH v3] x86/boot: skip realmode init code when running as Xen
 PV guest
References: <20221123114523.3467-1-jgross@suse.com> <Y39xcnKCkbYQZjaE@zn.tnic>
In-Reply-To: <Y39xcnKCkbYQZjaE@zn.tnic>

--------------i6mFkV7gpV2Meh114x82itrq
Content-Type: multipart/mixed; boundary="------------6t4UKZUx5RittVqXvsy08yw4"

--------------6t4UKZUx5RittVqXvsy08yw4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMTQ6MjgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBO
b3YgMjMsIDIwMjIgYXQgMTI6NDU6MjNQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBndWVzdCB0aGVyZSBpcyBubyBuZWVkIGZv
ciBzZXR0aW5nIHVwIHRoZQ0KPj4gcmVhbG1vZGUgdHJhbXBvbGluZSwgYXMgcmVhbG1vZGUg
aXNuJ3Qgc3VwcG9ydGVkIGluIHRoaXMgZW52aXJvbm1lbnQuDQo+Pg0KPj4gVHJ5aW5nIHRv
IHNldHVwIHRoZSB0cmFtcG9saW5lIGhhcyBiZWVuIHByb3ZlbiB0byBiZSBwcm9ibGVtYXRp
YyBpbg0KPj4gc29tZSBjYXNlcywgZXNwZWNpYWxseSB3aGVuIHRyeWluZyB0byBkZWJ1ZyBl
YXJseSBib290IHByb2JsZW1zIHdpdGgNCj4+IFhlbiByZXF1aXJpbmcgdG8ga2VlcCB0aGUg
RUZJIGJvb3Qtc2VydmljZXMgbWVtb3J5IG1hcHBlZCAoc29tZQ0KPj4gZmlybXdhcmUgdmFy
aWFudHMgc2VlbSB0byBjbGFpbSBiYXNpY2FsbHkgYWxsIG1lbW9yeSBiZWxvdyAxTSBmb3Ig
Ym9vdA0KPj4gc2VydmljZXMpLg0KPj4NCj4+IEludHJvZHVjZSBuZXcgeDg2X3BsYXRmb3Jt
X29wcyBvcGVyYXRpb25zIGZvciB0aGF0IHB1cnBvc2UsIHdoaWNoIGNhbg0KPj4gYmUgc2V0
IHRvIGEgbm9wIGJ5IHRoZSBYZW4gUFYgc3BlY2lmaWMga2VybmVsIGJvb3QgY29kZS4NCj4+
DQo+PiBGaXhlczogMDg0ZWUxYzY0MWEwICgieDg2LCByZWFsbW9kZTogUmVsb2NhdG9yIGZv
ciByZWFsbW9kZSBjb2RlIikNCj4gDQo+IFRoaXMgdGV4dCBhbmQgRml4ZXM6IHRhZyBzb3Vu
ZHMgbGlrZSB0aGlzIG5lZWRzIHRvIGdvIHRvIExpbnVzIGFuZA0KPiBzdGFibGUgbm93Pw0K
DQpMb29raW5nIGF0IHRoZSBkYXRlIHdoZW4gMDg0ZWUxYzY0MWEwIHdlbnQgaW4gSSBkb24n
dCB0aGluayBpdCBfbmVlZHNfDQp0byBnbyBpbiBub3csIGJ1dCBJIHdvdWxkbid0IGNvbXBs
YWluIC4uLg0KDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3JlYWxtb2RlL2luaXQu
YyBiL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYw0KPj4gaW5kZXggNDFkNzY2OWE5N2FkLi4y
NDdhY2E5ZjhlZDEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9yZWFsbW9kZS9pbml0LmMN
Cj4+ICsrKyBiL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYw0KPj4gQEAgLTIwMCwxNCArMjAw
LDE4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzZXRfcmVhbF9tb2RlX3Blcm1pc3Npb25zKHZv
aWQpDQo+PiAgIAlzZXRfbWVtb3J5X3goKHVuc2lnbmVkIGxvbmcpIHRleHRfc3RhcnQsIHRl
eHRfc2l6ZSA+PiBQQUdFX1NISUZUKTsNCj4+ICAgfQ0KPj4gICANCj4+IC1zdGF0aWMgaW50
IF9faW5pdCBpbml0X3JlYWxfbW9kZSh2b2lkKQ0KPj4gK3ZvaWQgX19pbml0IGluaXRfcmVh
bF9tb2RlKHZvaWQpDQo+PiAgIHsNCj4+ICAgCWlmICghcmVhbF9tb2RlX2hlYWRlcikNCj4+
ICAgCQlwYW5pYygiUmVhbCBtb2RlIHRyYW1wb2xpbmUgd2FzIG5vdCBhbGxvY2F0ZWQiKTsN
Cj4+ICAgDQo+PiAgIAlzZXR1cF9yZWFsX21vZGUoKTsNCj4+ICAgCXNldF9yZWFsX21vZGVf
cGVybWlzc2lvbnMoKTsNCj4+ICt9DQo+PiAgIA0KPj4gK3N0YXRpYyBpbnQgX19pbml0IGNh
bGxfaW5pdF9yZWFsX21vZGUodm9pZCkNCj4+ICt7DQo+PiArCXg4Nl9wbGF0Zm9ybS5yZWFs
bW9kZV9pbml0KCk7DQo+PiAgIAlyZXR1cm4gMDsNCj4+ICAgfQ0KPj4gLWVhcmx5X2luaXRj
YWxsKGluaXRfcmVhbF9tb2RlKTsNCj4+ICtlYXJseV9pbml0Y2FsbChjYWxsX2luaXRfcmVh
bF9tb2RlKTsNCj4gDQo+IEknbGwgbmFtZSB0aGF0IG9uZSAiZG9faW5pdF9yZWFsX21vZGUi
IGFzICJjYWxsIGluaXQiIHNvdW5kcyB3ZWlyZC4NCg0KRmluZSB3aXRoIG1lLg0KDQo+IA0K
PiBPdGhlcndpc2UsIGl0IGlzIGFzIHN0cmFpZ2h0Zm9yd2FyZCBhcyBpdCBnZXRzLg0KDQpU
aGFua3MsDQoNCg0KSnVlcmdlbg0KDQo=
--------------6t4UKZUx5RittVqXvsy08yw4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------6t4UKZUx5RittVqXvsy08yw4--

--------------i6mFkV7gpV2Meh114x82itrq--

--------------0VLKXo0fwrqmfGnX066jb0rg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/cf8FAwAAAAAACgkQsN6d1ii/Ey98
twf8CbDMNAfrpw7TxPRC2w32+D69rQq2LyrXAC8AmzYM+HXju0pd51kwTs40Tw3VO9rRRMIXKvQo
u0FB+TKhlkUERVyFn36qNat11KrhhR7cDZmTKRjy32C658RPe6fL5zXoWk8PlKF9N570jVQVPk1g
mP/hRpfAxG8RMpanxyaaFrCvOkHveSo3KNwjnZ/gPb0gmUUCKRmSJq+s9DySzwt1nR0tlAV5yWO1
qp5wycgReDaK+YL8lgnrxpORDMu1UYOBDpNeY4zAZucnIugR8rRyOwLLxgy6kykEmHVoGNxcmAmZ
bmPB/cX8yOOZ32jIefDkJrN6LCRqKC0J36YArIw3gg==
=hXrX
-----END PGP SIGNATURE-----

--------------0VLKXo0fwrqmfGnX066jb0rg--
