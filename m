Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8045B56F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:10:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3A186E7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:10:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 230831FDE8;
        Mon, 12 Sep 2022 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662973830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrFu+GWgOCpM5QiWWOb2MH9U1mQKUvazALzL+fiP0MQ=;
        b=Y2+pe/vFvts8o8s4l3yqnMw7BIgbd7lIHoDsk1H+/9CPjGrlVxXSvD3DxRQ0DKCdaYgvZa
        vdjd1NRTDRb0XYZrEm09J22FidVHHbogl+uk+CZ+D4M2pC90cdZR6TVAB1Kb2c7m/lcyvH
        rmEKlnJAkycZX7KTNZVAK50roUHbRNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA235139E0;
        Mon, 12 Sep 2022 09:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0kuyM4X3HmOnPQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 12 Sep 2022 09:10:29 +0000
Message-ID: <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
Date:   Mon, 12 Sep 2022 11:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-4-jgross@suse.com> <Yx21cizZHNzD38z7@nazgul.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Yx21cizZHNzD38z7@nazgul.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------10N96WsrFizMoApfIgie5x2c"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------10N96WsrFizMoApfIgie5x2c
Content-Type: multipart/mixed; boundary="------------sJuVWfGGh2FIS08NSnXmT3RQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
Subject: Re: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-4-jgross@suse.com> <Yx21cizZHNzD38z7@nazgul.tnic>
In-Reply-To: <Yx21cizZHNzD38z7@nazgul.tnic>

--------------sJuVWfGGh2FIS08NSnXmT3RQ
Content-Type: multipart/mixed; boundary="------------2ZwtFVK3TybacaG4smhlRi0P"

--------------2ZwtFVK3TybacaG4smhlRi0P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDkuMjIgMTI6MTYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMDgsIDIwMjIgYXQgMTA6NDk6MDdBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWluZm8uaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlaW5mby5oDQo+PiBpbmRleCA4NmIyZTBkY2M0YmYu
LjFhZWFmYTk4ODhmNyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Nh
Y2hlaW5mby5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWluZm8uaA0K
Pj4gQEAgLTIsNiArMiwxMSBAQA0KPj4gICAjaWZuZGVmIF9BU01fWDg2X0NBQ0hFSU5GT19I
DQo+PiAgICNkZWZpbmUgX0FTTV9YODZfQ0FDSEVJTkZPX0gNCj4+ICAgDQo+PiArLyogS2Vy
bmVsIGNvbnRyb2xzIE1UUlIgYW5kL29yIFBBVCBNU1JzLiAqLw0KPj4gK2V4dGVybiB1bnNp
Z25lZCBpbnQgY2FjaGVfZ2VuZXJpYzsNCj4gDQo+IFNvIHRoaXMgc2hvdWxkIGJlIGNhbGxl
ZCBzb21ldGhpbmcgbW9yZSBkZXNjcmlwdGl2ZSBsaWtlDQo+IA0KPiAJbWVtb3J5X2NhY2hp
bmdfdHlwZXMNCg0KSW4gdGhlIGVuZCB0aGlzIHZhcmlhYmxlIGRvZXNuJ3Qgc3BlY2lmeSB3
aGljaCBjYWNoaW5nIHR5cGVzIGFyZSBhdmFpbGFibGUsDQpidXQgdGhlIHdheXMgdG8gc2Vs
ZWN0L2NvbnRyb2wgdGhlIGNhY2hpbmcgdHlwZXMuDQoNClNvIHdoYXQgYWJvdXQgIm1lbW9y
eV9jYWNoaW5nX3NlbGVjdCIgb3IgIm1lbW9yeV9jYWNoaW5nX2NvbnRyb2wiIGluc3RlYWQ/
DQoNCj4gb3Igc28gdG8gZGVub3RlIHRoYXQgdGhpcyBpcyBhIGJpdGZpZWxkIG9mIHN1cHBv
cnRlZCBtZW1vcnkgY2FjaGluZw0KPiB0ZWNobm9sb2dpZXMuIFRoZSBjb2RlIHRoZW4gd291
bGQgcmVhZCBhcw0KPiANCj4gCWlmIChtZW1vcnlfY2FjaGluZ190eXBlcyAmIENBQ0hFX01U
UlIpDQo+IA0KPiBUaGUgbmFtZSdzIHN0aWxsIG5vdCBvcHRpbWFsIHRobyAtIG5lZWRzIG1v
cmUgYnJvb2Rpbmcgb3Zlci4NCj4gDQo+PiArI2RlZmluZSBDQUNIRV9HRU5FUklDX01UUlIg
MHgwMQ0KPj4gKyNkZWZpbmUgQ0FDSEVfR0VORVJJQ19QQVQgIDB4MDINCj4gDQo+IEFuZCB0
aG9zZSBzaG91bGQgYmUgQ0FDSEVfe01UUlIsUEFUfS4NCg0KRmluZSB3aXRoIG1lLg0KDQo+
PiAgIHZvaWQgY2FjaGVpbmZvX2FtZF9pbml0X2xsY19pZChzdHJ1Y3QgY3B1aW5mb194ODYg
KmMsIGludCBjcHUpOw0KPj4gICB2b2lkIGNhY2hlaW5mb19oeWdvbl9pbml0X2xsY19pZChz
dHJ1Y3QgY3B1aW5mb194ODYgKmMsIGludCBjcHUpOw0KPj4gICANCj4+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9jYWNoZWluZm8uYw0KPj4gaW5kZXggNjY1NTY4MzNkN2FmLi4zYjA1ZDNhZGU3YTYgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jDQo+PiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jDQo+PiBAQCAtMzUsNiArMzUsOSBA
QCBERUZJTkVfUEVSX0NQVV9SRUFEX01PU1RMWShjcHVtYXNrX3Zhcl90LCBjcHVfbGxjX3No
YXJlZF9tYXApOw0KPj4gICAvKiBTaGFyZWQgTDIgY2FjaGUgbWFwcyAqLw0KPj4gICBERUZJ
TkVfUEVSX0NQVV9SRUFEX01PU1RMWShjcHVtYXNrX3Zhcl90LCBjcHVfbDJjX3NoYXJlZF9t
YXApOw0KPj4gICANCj4+ICsvKiBLZXJuZWwgY29udHJvbHMgTVRSUiBhbmQvb3IgUEFUIE1T
UnMuICovDQo+PiArdW5zaWduZWQgaW50IGNhY2hlX2dlbmVyaWM7DQo+IA0KPiBUaGlzIHNo
b3VsZCBlaXRoZXIgYmUgX19yb19hZnRlcl9pbml0IGFuZCBpbml0aWFsaXplZCB0byAwIG9y
IHlvdSBuZWVkDQo+IGFjY2Vzc29ycy4uLg0KDQpPa2F5Lg0KDQo+IA0KPj4gICB1MzIgbnVt
X3Zhcl9yYW5nZXM7DQo+PiAtc3RhdGljIGJvb2wgX19tdHJyX2VuYWJsZWQ7DQo+PiAtDQo+
PiAtc3RhdGljIGJvb2wgbXRycl9lbmFibGVkKHZvaWQpDQo+PiAtew0KPj4gLQlyZXR1cm4g
X19tdHJyX2VuYWJsZWQ7DQo+PiAtfQ0KPj4gK3N0YXRpYyBib29sIG10cnJfZW5hYmxlZDsN
Cj4gDQo+IEhtbSwgSSBkb24ndCBsaWtlIHRoaXMuIFRoZXJlJ3Mgd2F5IHRvbyBtYW55IGJv
b2xlYW4gZmxhZ3MgaW4gdGhlIG10cnINCj4gY29kZS4gVGhlcmUncyBtdHJyX3N0YXRlLmVu
YWJsZWQgdG9vLiA7LVwNCj4gDQo+IENhbiB3ZSBzZXQgKG9yIGNsZWFyKSBYODZfRkVBVFVS
RV9NVFJSIHRvIGRlbm90ZSBNVFJSIGVuYWJsZW1lbnQgc3RhdHVzDQo+IGFuZCBnZXQgcmlk
IG9mIG9uZSBtb3JlIGJvb2xlYW4gZmxhZz8NCg0KSSdsbCBoYXZlIGEgbG9vay4NCg0KPiAN
Cj4gLi4uDQo+IA0KPj4gICB2b2lkIF9faW5pdCBtdHJyX2JwX2luaXQodm9pZCkNCj4+ICAg
ew0KPj4gKwlib29sIHVzZV9nZW5lcmljID0gZmFsc2U7DQo+PiAgIAl1MzIgcGh5c19hZGRy
Ow0KPj4gICANCj4+ICAgCWluaXRfaWZzKCk7DQo+PiBAQCAtNjk0LDYgKzY5MSw3IEBAIHZv
aWQgX19pbml0IG10cnJfYnBfaW5pdCh2b2lkKQ0KPj4gICANCj4+ICAgCWlmIChib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfTVRSUikpIHsNCj4+ICAgCQltdHJyX2lmID0gJmdlbmVyaWNf
bXRycl9vcHM7DQo+PiArCQl1c2VfZ2VuZXJpYyA9IHRydWU7DQo+PiAgIAkJc2l6ZV9vcl9t
YXNrID0gU0laRV9PUl9NQVNLX0JJVFMoMzYpOw0KPj4gICAJCXNpemVfYW5kX21hc2sgPSAw
eDAwZjAwMDAwOw0KPj4gICAJCXBoeXNfYWRkciA9IDM2Ow0KPj4gQEAgLTc1NSwxNSArNzUz
LDE4IEBAIHZvaWQgX19pbml0IG10cnJfYnBfaW5pdCh2b2lkKQ0KPj4gICAJfQ0KPj4gICAN
Cj4+ICAgCWlmIChtdHJyX2lmKSB7DQo+PiAtCQlfX210cnJfZW5hYmxlZCA9IHRydWU7DQo+
PiAtCQlzZXRfbnVtX3Zhcl9yYW5nZXMoKTsNCj4+ICsJCW10cnJfZW5hYmxlZCA9IHRydWU7
DQo+PiArCQlzZXRfbnVtX3Zhcl9yYW5nZXModXNlX2dlbmVyaWMpOw0KPiANCj4gWW91IGRv
bid0IG5lZWQgdXNlX2dlbmVyaWMgZWl0aGVyOg0KPiANCj4gCQlzZXRfbnVtX3Zhcl9yYW5n
ZXMobXRycl9pZiA9PSBnZW5lcmljX210cnJfb3BzKTsNCj4gDQo+IChUaGUgcmVhc29uIGJl
aW5nIEkgd2FubmEgZ2V0IHJpZCBvZiB0aGF0IG5hc3R5IG1pbmVmaWVsZCBvZiBib29sZWFu
DQo+IHZhcnMgYWxsIHJvdW5kIHRoYXQgY29kZSkuDQoNCkZpbmUgd2l0aCBtZS4NCg0KDQpK
dWVyZ2VuDQo=
--------------2ZwtFVK3TybacaG4smhlRi0P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------2ZwtFVK3TybacaG4smhlRi0P--

--------------sJuVWfGGh2FIS08NSnXmT3RQ--

--------------10N96WsrFizMoApfIgie5x2c
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMe94UFAwAAAAAACgkQsN6d1ii/Ey8j
mAgAiwaZ2skUEx074gzV7xFZp/2XhoEokvt+MYcB/QkwhkccPft+ZZbQkDx7l1gZ8INDlXJVOG90
ZmTCZORv9SzNGzhwLzKZNAT76KjLPNieYcd2GMQJ5jZ3Fu847UQm2FI2QyJIsV2Ua+Mnl0zY/8RN
2crlpSCm/16q8Df1RyyHV/mNALh6IVgm8TWCkgEzEFjy6hapKWFrQ5f2yFWAbK6IHK6b/LhViY13
0l23m8Z44ZodoTNaUZ3bb2pgRA7QTVHvkAsfRI8wWe6gPiJ6C+J3m7Frj5hF27suKCYlki8bi9aH
z9fTfWTC6nB33r8wt0lFJ4pOoO9/u1tgIHhN0gmuFw==
=VpX0
-----END PGP SIGNATURE-----

--------------10N96WsrFizMoApfIgie5x2c--
