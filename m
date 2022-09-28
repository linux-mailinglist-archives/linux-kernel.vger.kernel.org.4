Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E575ED9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiI1KUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiI1KSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:18:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1980503
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:17:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E090C1F8F1;
        Wed, 28 Sep 2022 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664360228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wz7LqQTQwqN6NuJlrmtHY6fei9eDMFzYM6kbeSQmCqQ=;
        b=TjkY+rledB7HirNbJDSyrYBGbMIM5nX00jcZjurberAlTXb82wxeHE7UbWoUzgGReh9+4e
        8A+3nKQojGje/1y7PmnSYtnNwGRHOw0dg2HGbOPg0xRBMQHTwVVm30rWwgRoWItCF2z4ZQ
        uk7QFFIiDY5a46qvowKfwJkadkZyF8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A30C213A84;
        Wed, 28 Sep 2022 10:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hYdWJiQfNGMYBQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 10:17:08 +0000
Message-ID: <699aacca-b82a-78df-3a74-4b5b82de92c2@suse.com>
Date:   Wed, 28 Sep 2022 12:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Juergen Gross <jgross@suse.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-4-jgross@suse.com> <Yx21cizZHNzD38z7@nazgul.tnic>
 <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
Content-Language: en-US
Subject: Re: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
In-Reply-To: <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------F5icf01H3NZlsmrz1JnX9ERL"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------F5icf01H3NZlsmrz1JnX9ERL
Content-Type: multipart/mixed; boundary="------------HLiW1ScmoygFeF2gnYyGwTIf";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <699aacca-b82a-78df-3a74-4b5b82de92c2@suse.com>
Subject: Re: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-4-jgross@suse.com> <Yx21cizZHNzD38z7@nazgul.tnic>
 <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
In-Reply-To: <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>

--------------HLiW1ScmoygFeF2gnYyGwTIf
Content-Type: multipart/mixed; boundary="------------xKotCnUiVNlmCt3z0wqbHP9g"

--------------xKotCnUiVNlmCt3z0wqbHP9g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDkuMjIgMTE6MTAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDExLjA5LjIy
IDEyOjE2LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBUaHUsIFNlcCAwOCwgMjAy
MiBhdCAxMDo0OTowN0FNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWluZm8uaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2NhY2hlaW5mby5oDQo+Pj4gaW5kZXggODZiMmUwZGNjNGJmLi4xYWVhZmE5
ODg4ZjcgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY2FjaGVpbmZv
LmgNCj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWluZm8uaA0KPj4+IEBA
IC0yLDYgKzIsMTEgQEANCj4+PiDCoCAjaWZuZGVmIF9BU01fWDg2X0NBQ0hFSU5GT19IDQo+
Pj4gwqAgI2RlZmluZSBfQVNNX1g4Nl9DQUNIRUlORk9fSA0KPj4+ICsvKiBLZXJuZWwgY29u
dHJvbHMgTVRSUiBhbmQvb3IgUEFUIE1TUnMuICovDQo+Pj4gK2V4dGVybiB1bnNpZ25lZCBp
bnQgY2FjaGVfZ2VuZXJpYzsNCj4+DQo+PiBTbyB0aGlzIHNob3VsZCBiZSBjYWxsZWQgc29t
ZXRoaW5nIG1vcmUgZGVzY3JpcHRpdmUgbGlrZQ0KPj4NCj4+IMKgwqDCoMKgbWVtb3J5X2Nh
Y2hpbmdfdHlwZXMNCj4gDQo+IEluIHRoZSBlbmQgdGhpcyB2YXJpYWJsZSBkb2Vzbid0IHNw
ZWNpZnkgd2hpY2ggY2FjaGluZyB0eXBlcyBhcmUgYXZhaWxhYmxlLA0KPiBidXQgdGhlIHdh
eXMgdG8gc2VsZWN0L2NvbnRyb2wgdGhlIGNhY2hpbmcgdHlwZXMuDQo+IA0KPiBTbyB3aGF0
IGFib3V0ICJtZW1vcnlfY2FjaGluZ19zZWxlY3QiIG9yICJtZW1vcnlfY2FjaGluZ19jb250
cm9sIiBpbnN0ZWFkPw0KPiANCj4+IG9yIHNvIHRvIGRlbm90ZSB0aGF0IHRoaXMgaXMgYSBi
aXRmaWVsZCBvZiBzdXBwb3J0ZWQgbWVtb3J5IGNhY2hpbmcNCj4+IHRlY2hub2xvZ2llcy4g
VGhlIGNvZGUgdGhlbiB3b3VsZCByZWFkIGFzDQo+Pg0KPj4gwqDCoMKgwqBpZiAobWVtb3J5
X2NhY2hpbmdfdHlwZXMgJiBDQUNIRV9NVFJSKQ0KPj4NCj4+IFRoZSBuYW1lJ3Mgc3RpbGwg
bm90IG9wdGltYWwgdGhvIC0gbmVlZHMgbW9yZSBicm9vZGluZyBvdmVyLg0KPj4NCj4+PiAr
I2RlZmluZSBDQUNIRV9HRU5FUklDX01UUlIgMHgwMQ0KPj4+ICsjZGVmaW5lIENBQ0hFX0dF
TkVSSUNfUEFUwqAgMHgwMg0KPj4NCj4+IEFuZCB0aG9zZSBzaG91bGQgYmUgQ0FDSEVfe01U
UlIsUEFUfS4NCj4gDQo+IEZpbmUgd2l0aCBtZS4NCj4gDQo+Pj4gwqAgdm9pZCBjYWNoZWlu
Zm9fYW1kX2luaXRfbGxjX2lkKHN0cnVjdCBjcHVpbmZvX3g4NiAqYywgaW50IGNwdSk7DQo+
Pj4gwqAgdm9pZCBjYWNoZWluZm9faHlnb25faW5pdF9sbGNfaWQoc3RydWN0IGNwdWluZm9f
eDg2ICpjLCBpbnQgY3B1KTsNCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2Nw
dS9jYWNoZWluZm8uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY2FjaGVpbmZvLmMNCj4+PiBp
bmRleCA2NjU1NjgzM2Q3YWYuLjNiMDVkM2FkZTdhNiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jDQo+Pj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9jYWNoZWluZm8uYw0KPj4+IEBAIC0zNSw2ICszNSw5IEBAIERFRklORV9QRVJfQ1BV
X1JFQURfTU9TVExZKGNwdW1hc2tfdmFyX3QsIGNwdV9sbGNfc2hhcmVkX21hcCk7DQo+Pj4g
wqAgLyogU2hhcmVkIEwyIGNhY2hlIG1hcHMgKi8NCj4+PiDCoCBERUZJTkVfUEVSX0NQVV9S
RUFEX01PU1RMWShjcHVtYXNrX3Zhcl90LCBjcHVfbDJjX3NoYXJlZF9tYXApOw0KPj4+ICsv
KiBLZXJuZWwgY29udHJvbHMgTVRSUiBhbmQvb3IgUEFUIE1TUnMuICovDQo+Pj4gK3Vuc2ln
bmVkIGludCBjYWNoZV9nZW5lcmljOw0KPj4NCj4+IFRoaXMgc2hvdWxkIGVpdGhlciBiZSBf
X3JvX2FmdGVyX2luaXQgYW5kIGluaXRpYWxpemVkIHRvIDAgb3IgeW91IG5lZWQNCj4+IGFj
Y2Vzc29ycy4uLg0KPiANCj4gT2theS4NCj4gDQo+Pg0KPj4+IMKgIHUzMiBudW1fdmFyX3Jh
bmdlczsNCj4+PiAtc3RhdGljIGJvb2wgX19tdHJyX2VuYWJsZWQ7DQo+Pj4gLQ0KPj4+IC1z
dGF0aWMgYm9vbCBtdHJyX2VuYWJsZWQodm9pZCkNCj4+PiAtew0KPj4+IC3CoMKgwqAgcmV0
dXJuIF9fbXRycl9lbmFibGVkOw0KPj4+IC19DQo+Pj4gK3N0YXRpYyBib29sIG10cnJfZW5h
YmxlZDsNCj4+DQo+PiBIbW0sIEkgZG9uJ3QgbGlrZSB0aGlzLiBUaGVyZSdzIHdheSB0b28g
bWFueSBib29sZWFuIGZsYWdzIGluIHRoZSBtdHJyDQo+PiBjb2RlLiBUaGVyZSdzIG10cnJf
c3RhdGUuZW5hYmxlZCB0b28uIDstXA0KPj4NCj4+IENhbiB3ZSBzZXQgKG9yIGNsZWFyKSBY
ODZfRkVBVFVSRV9NVFJSIHRvIGRlbm90ZSBNVFJSIGVuYWJsZW1lbnQgc3RhdHVzDQo+PiBh
bmQgZ2V0IHJpZCBvZiBvbmUgbW9yZSBib29sZWFuIGZsYWc/DQo+IA0KPiBJJ2xsIGhhdmUg
YSBsb29rLg0KDQpIbW0sIHRoaXMgbWlnaHQgYmUgYSBsaXR0bGUgYml0IHJpc2t5Lg0KDQpJ
dCBjYW4gYmUgZG9uZSwgYnV0IHRoZW4gWDg2X0ZFQVRVUkVfTVRSUiBjb3VsZCBiZSBzZXQg
ZXZlbiBmb3IgY3B1cw0KTk9UIHN1cHBvcnRpbmcgaXQgKHRoZSAzMi1iaXQgc3BlY2lhbCBj
YXNlcyBBTUQsIENFTlRBVVIsIENZUklYKS4NCg0KU28gd2UgaGF2ZSB0aGUgZm9sbG93aW5n
IGFsdGVybmF0aXZlczoNCg0KLSBkbyB0aGUgc3dpdGNoIHRvIFg4Nl9GRUFUVVJFX01UUlIg
cmlza2luZyBjb2RlIGJyZWFrYWdlIGZvciBsYXRlcg0KICAgY29kZSBjaGFuZ2VzIHF1ZXJ5
aW5nIFg4Nl9GRUFUVVJFX01UUlIgYW5kIGFzc3VtaW5nIHRoZSBNVFJSIE1TUnMNCiAgIGJl
aW5nIGF2YWlsYWJsZQ0KDQotIGtlZXAgdGhlIGN1cnJlbnQgYm9vbA0KDQotIHJlcGxhY2Ug
dGhlIGJvb2wgd2l0aCBtdHJyX2lmICE9IE5VTEwNCg0KLSBhZGQgYSBuZXcgc3ludGhldGlj
IGZlYXR1cmUsIGUuZy4gWDg2X0ZFQVRVUkVfTVRSUl9FTkFCTEVEICh3aGljaCBpbg0KICAg
ZmFjdCB3b3VsZCBiZSBqdXN0IGEgcmVwbGFjZW1lbnQgb2YgdGhlIGN1cnJlbnQgYm9vbCkN
Cg0KTXkgcHJlZmVyZW5jZSB3b3VsZCBiZSB0aGUgcmVwbGFjZW1lbnQgd2l0aCBtdHJyX2lm
ICE9IE5VTEwuDQoNCg0KSnVlcmdlbg0K
--------------xKotCnUiVNlmCt3z0wqbHP9g
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xKotCnUiVNlmCt3z0wqbHP9g--

--------------HLiW1ScmoygFeF2gnYyGwTIf--

--------------F5icf01H3NZlsmrz1JnX9ERL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM0HyQFAwAAAAAACgkQsN6d1ii/Ey/j
3wf7B3/WRDWgT5gzaKKNYA1NYwuZUjnDzHowMPGW6+BwIrde50hzjUTFy2VN+cYH+xEdWnV7Zt8s
J4KEtqO/rP7+WcpgNuFre42q4Vk6yWKauU14QYzkkwcJNxvPsGYBm87HLGTKchN0jvfuWs5gCQw6
hkmWiFy8OIHm932arXoGtdbQaj1RXOKNoNWYpFpYhqk3MJwYWvZMrR2JlDx7CcUHNPS9jERiMBEM
qzL/eOMluT3Uubpe4H71KYZH8Zf7B5z6lcoZD860Hwm6fvjhzoNop59+qIBvVj+v8zDzWo9mdrCZ
0xHm9ZEwYgDPtgE+Usu7Exv9imkH1gEqO2sDfs1uOg==
=pGLf
-----END PGP SIGNATURE-----

--------------F5icf01H3NZlsmrz1JnX9ERL--
