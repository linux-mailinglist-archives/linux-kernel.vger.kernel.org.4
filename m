Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473A369598F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjBNHCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBNHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:02:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50B76B1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:01:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D87F020D9E;
        Tue, 14 Feb 2023 07:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676358117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0YGZhSOGQ7xd7ruMQjs1cptR3vMnMb9ZbHnktKbaig=;
        b=nYRMNqOHz3G7Ci+1cQAc9D9xaGmb5HgpHEOZldWy6DyEyv+m/0KE9a+Sn41rEEOxFlLlhp
        nbl1glQtbdUjcbSCxiZ5Mzf3tDHglbGkWkrwRDXWmKqnaIDVs4b9IrP5vJPwat+WbpLEWw
        9QJwiXnOPBSFL0h4BotJ4SSkytDzExc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92F1A138E3;
        Tue, 14 Feb 2023 07:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZGyBIuUx62P1CQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Feb 2023 07:01:57 +0000
Message-ID: <01fa7eb8-e534-1c67-3629-7834e7df3c5d@suse.com>
Date:   Tue, 14 Feb 2023 08:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com> <Y+qEwtzCV65s+ZFq@zn.tnic>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y+qEwtzCV65s+ZFq@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S1NoUHM5K4LX8gHZcnFAdtjy"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S1NoUHM5K4LX8gHZcnFAdtjy
Content-Type: multipart/mixed; boundary="------------cUApi3aeM5kRUWcxq23avsi6";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <01fa7eb8-e534-1c67-3629-7834e7df3c5d@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com> <Y+qEwtzCV65s+ZFq@zn.tnic>
In-Reply-To: <Y+qEwtzCV65s+ZFq@zn.tnic>

--------------cUApi3aeM5kRUWcxq23avsi6
Content-Type: multipart/mixed; boundary="------------az6IFU6bMTuFKJ4wkDOFwAhV"

--------------az6IFU6bMTuFKJ4wkDOFwAhV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTk6NDMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMTMsIDIwMjMgYXQgMDQ6MzY6MTJQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluIHRoZSBlbmQgSSB3b3VsZG4ndCBtaW5kIGRyb3BwaW5nIHRoZSBmaXhlZCBNVFJS
cyBmcm9tIHRoZSBpbnRlcmZhY2UsIGFzDQo+PiB0aGV5IGFyZSBjdXJyZW50bHkgbm90IG5l
ZWRlZCBhdCBhbGwuDQo+IA0KPiBZZXMsIHRoZSBsZXNzIHRoZSBiZXR0ZXIuDQo+IA0KPj4g
SSdkIHNheSB3ZSBnbyB3aXRoIHdoYXQgaXMgbmVlZGVkIHJpZ2h0IG5vdy4gQW5kIGhhdmlu
ZyBhIHNpbmdsZSBpbnRlcmZhY2UNCj4+IG1ha2VzIGFsbCB0aGUgc2FuaXR5IGNoZWNraW5n
IHlvdSBhcmUgYXNraW5nIGZvciBlYXNpZXIuDQo+IA0KPiBJIGd1ZXNzIEkgbmVlZCB0byBy
ZW1lbWJlciB0byBmaW5pc2ggZGVzaWduaW5nIHRoaXMgaWYgbW9yZSB1c2Vycw0KPiBhcHBl
YXIuLi4NCj4gDQo+PiBXaGF0IGFyZSB5b3UgZXNwZWNpYWxseSBhc2tpbmcgZm9yPw0KPj4N
Cj4+IFdpdGggbXkgY3VycmVudCBwYXRjaGVzIFhlbiBQViBkb20wIHdpbGwgY2FsbCBtdHJy
X292ZXJ3cml0ZV9zdGF0ZSgpIGJlZm9yZQ0KPj4geDg2X2h5cGVyX3R5cGUgaXMgc2V0LCB3
aGlsZSBhIEh5cGVyLVYgU0VWLVNOUCBndWVzdCB3aWxsIG1ha2UgdGhlIGNhbGwgYWZ0ZXIN
Cj4+IGl0IGhhcyBiZWVuIHNldC4gQm90aCBjYWxscyBoYXBwZW4gYmVmb3JlIGNhY2hlX2Jw
X2luaXQoKS4NCj4+DQo+PiBTbyBJIGNvdWxkIG1vdmUgdGhlIG10cnJfb3ZlcndyaXRlX3N0
YXRlKCkgY2FsbCBmb3IgWGVuIFBWIGRvbTAgaW50byBpdHMNCj4+IGluaXRfcGxhdGZvcm0o
KSBjYWxsYmFjayBhbmQgY2hlY2sgaW4gbXRycl9vdmVyd3JpdGVfc3RhdGUoKSB4ODZfaHlw
ZXJfdHlwZQ0KPj4gdG8gYmUgc2V0LA0KPiANCj4gSSBiZWxpZXZlIHRoYXQgaXMgZ29vZCBl
bm91Z2gsIHNlZSBiZWxvdy4NCj4gDQo+PiBvciBJIGNvdWxkIHJlamVjdCBhIGNhbGwgb2Yg
bXRycl9vdmVyd3JpdGVfc3RhdGUoKSBhZnRlciB0aGUgY2FsbCBvZg0KPj4gY2FjaGVfYnBf
aW5pdCgpIGhhcyBoYXBwZW5lZCwgb3IgSSBjb3VsZCBkbyBib3RoLg0KPiANCj4gSSB0aGlu
ayBvbmUgdGhpbmcgaXMgZW5vdWdoIGFzIHdlJ2xsIGJlIGxvdWQgZW5vdWdoLg0KPiANCj4g
LS0tDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiBpbmRleCBiNzNmZTI0M2M3ZmQu
LjJkYmUyYzEwZTk1OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJy
L210cnIuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+IEBA
IC00OSw2ICs0OSw3IEBADQo+ICAgI2luY2x1ZGUgPGFzbS9jYWNoZWluZm8uaD4NCj4gICAj
aW5jbHVkZSA8YXNtL2NwdWZlYXR1cmUuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2U4MjAvYXBp
Lmg+DQo+ICsjaW5jbHVkZSA8YXNtL2h5cGVydmlzb3IuaD4NCj4gICAjaW5jbHVkZSA8YXNt
L210cnIuaD4NCj4gICAjaW5jbHVkZSA8YXNtL21zci5oPg0KPiAgICNpbmNsdWRlIDxhc20v
bWVtdHlwZS5oPg0KPiBAQCAtNjY4LDcgKzY2OSwxMiBAQCB2b2lkIF9faW5pdCBtdHJyX2Jw
X2luaXQodm9pZCkNCj4gICAJY29uc3QgY2hhciAqd2h5ID0gIihub3QgYXZhaWxhYmxlKSI7
DQo+ICAgCXVuc2lnbmVkIGludCBwaHlzX2FkZHI7DQo+ICAgDQo+ICsjaWZkZWYgQ09ORklH
X0hZUEVSVklTT1JfR1VFU1QNCj4gICAJaWYgKG10cnJfc3RhdGUuZW5hYmxlZCkgew0KPiAr
DQo+ICsJCS8qIFRoaXMgc2hvdWxkIG5vdCBoYXBwZW4gd2l0aG91dCBhIGh5cGVydmlzb3Ig
cHJlc2VudC4gKi8NCj4gKwkJV0FSTl9PTl9PTkNFKCF4ODZfaHlwZXJfdHlwZSk7DQo+ICsN
Cj4gICAJCS8qIFNvZnR3YXJlIG92ZXJ3cml0ZSBvZiBNVFJSIHN0YXRlLCBvbmx5IGZvciBn
ZW5lcmljIGNhc2UuICovDQo+ICAgCQltdHJyX2NhbGNfcGh5c2JpdHModHJ1ZSk7DQo+ICAg
CQlpbml0X3RhYmxlKCk7DQo+IEBAIC02NzYsNiArNjgyLDcgQEAgdm9pZCBfX2luaXQgbXRy
cl9icF9pbml0KHZvaWQpDQo+ICAgDQo+ICAgCQlyZXR1cm47DQo+ICAgCX0NCj4gKyNlbmRp
Zg0KDQpJIHdpbGwgY2hhbmdlIHRoaXMgYSBsaXR0bGUgYml0IGluIG9yZGVyIHRvIGF2b2lk
IHRoZSAjaWZkZWYgYnkgdXNpbmcNCiJXQVJOX09OKGh5cGVydmlzb3JfaXNfdHlwZSgpID09
IFg4Nl9IWVBFUl9OQVRJVkUpOyINCg0KDQpKdWVyZ2VuDQo=
--------------az6IFU6bMTuFKJ4wkDOFwAhV
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------az6IFU6bMTuFKJ4wkDOFwAhV--

--------------cUApi3aeM5kRUWcxq23avsi6--

--------------S1NoUHM5K4LX8gHZcnFAdtjy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPrMeQFAwAAAAAACgkQsN6d1ii/Ey+o
XQf/Q5r1U1n0QoBdHmYzZZJGoCODmMSmmdDef5FhXgJEzZbQWKdd9uS1jn/5RGZGTsTxPDpWPMio
T/Q5sj9IFpiLPLhFtYMVise7bGxS/0lI5wNh9i2Qsc1LdS7y94RQcZ7IUnpyqnS98xBos726H/Nr
bQnVLqWnhs0t10tBWhYFr6aOheT9E92p9pDkEVEgESFVxQNdxvixQlCz3OPLAvvG5ZUP00QbmMgY
GcbxXrmpxoGVO9zc1k63O5MjmZqjCuLCgf4A2BBcWHe5MmithOoKgc6JRZP6tQI9wtabbFrAFIM5
D2e/I4xDqFTcF+D8mHmFjU0Eo+mIh4n2W3A2MO+Q1g==
=QCUN
-----END PGP SIGNATURE-----

--------------S1NoUHM5K4LX8gHZcnFAdtjy--
