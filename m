Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF49F693E41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMG1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:27:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E06E39F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:27:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 590E95D8C3;
        Mon, 13 Feb 2023 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676269647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPL+vaVzX1H6jys+GZ/CFQzZsZFmg1G/CNrZGYV5GNQ=;
        b=ann0v8rQ/ApQX2b+Ylc6RvBYR9nmiBXLBe2GSQqMdgUkdu63KesgNeoqM/qM9gMrigSTK0
        UHrcQPw5kF5tMyhXxZVjNFio23WMJlnFKBe77qL2lHF91skpOV5LCMxHN3r5ix0gy2r9fK
        vxlKEu3/k9MGNL7FW3O3ZUXBIxHq0FY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C94F1391B;
        Mon, 13 Feb 2023 06:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x6iFAU/Y6WMXBQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:27:27 +0000
Message-ID: <b568c7e0-553c-4747-32c2-d2a25309f2d4@suse.com>
Date:   Mon, 13 Feb 2023 07:27:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ytCMa8DuorXCqrSOTuKcUpAv"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ytCMa8DuorXCqrSOTuKcUpAv
Content-Type: multipart/mixed; boundary="------------yn2Qx4Q01xzWKT7SuWDxeNhU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b568c7e0-553c-4747-32c2-d2a25309f2d4@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------yn2Qx4Q01xzWKT7SuWDxeNhU
Content-Type: multipart/mixed; boundary="------------rn3w2ivt7ensmUBtxZ2PwmYW"

--------------rn3w2ivt7ensmUBtxZ2PwmYW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMDI6MDcsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSA4LCAyMDIzIDExOjIyIFBNDQo+Pg0KPj4gV2hlbiBydW5uaW5nIHZpcnR1YWxp
emVkLCBNVFJSIGFjY2VzcyBjYW4gYmUgcmVkdWNlZCAoZS5nLiBpbiBYZW4gUFYNCj4+IGd1
ZXN0cyBvciB3aGVuIHJ1bm5pbmcgYXMgYSBTRVYtU05QIGd1ZXN0IHVuZGVyIEh5cGVyLVYp
LiBUeXBpY2FsbHkNCj4+IHRoZSBoeXBlcnZpc29yIHdpbGwgcmVzZXQgdGhlIE1UUlIgZmVh
dHVyZSBpbiBjcHVpZCBkYXRhLCByZXN1bHRpbmcNCj4+IGluIG5vIE1UUlIgbWVtb3J5IHR5
cGUgaW5mb3JtYXRpb24gYmVpbmcgYXZhaWxhYmxlIGZvciB0aGUga2VybmVsLg0KPj4NCj4+
IFRoaXMgaGFzIHR1cm5lZCBvdXQgdG8gcmVzdWx0IGluIHByb2JsZW1zOg0KPj4NCj4+IC0g
SHlwZXItViBTRVYtU05QIGd1ZXN0cyB1c2luZyB1bmNhY2hlZCBtYXBwaW5ncyB3aGVyZSB0
aGV5IHNob3VsZG4ndA0KPj4gLSBYZW4gUFYgZG9tMCBtYXBwaW5nIG1lbW9yeSBhcyBXQiB3
aGljaCBzaG91bGQgYmUgVUMtIGluc3RlYWQNCj4+DQo+PiBTb2x2ZSB0aG9zZSBwcm9ibGVt
cyBieSBzdXBwb3J0aW5nIHRvIHNldCBhIGZpeGVkIE1UUlIgc3RhdGUsDQo+PiBvdmVyd3Jp
dGluZyB0aGUgZW1wdHkgc3RhdGUgdXNlZCB0b2RheS4gSW4gY2FzZSBzdWNoIGEgc3RhdGUg
aGFzIGJlZW4NCj4+IHNldCwgZG9uJ3QgY2FsbCBnZXRfbXRycl9zdGF0ZSgpIGluIG10cnJf
YnBfaW5pdCgpLiBUaGUgc2V0IHN0YXRlDQo+PiB3aWxsIG9ubHkgYmUgdXNlZCBieSBtdHJy
X3R5cGVfbG9va3VwKCksIGFzIGluIGFsbCBvdGhlciBjYXNlcw0KPj4gbXRycl9lbmFibGVk
KCkgaXMgYmVpbmcgY2hlY2tlZCwgd2hpY2ggd2lsbCByZXR1cm4gZmFsc2UuIEFjY2VwdCB0
aGUNCj4+IG92ZXJ3cml0ZSBjYWxsIG9ubHkgaW4gY2FzZSBvZiBNVFJScyBiZWluZyBkaXNh
YmxlZCBpbiBjcHVpZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4gLSBuZXcgcGF0Y2gNCj4+IC0t
LQ0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmggICAgICAgIHwgIDIgKysNCj4+
ICAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyB8IDM4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRy
ci5jICAgIHwgIDkgKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oDQo+PiBpbmRleCBmMGVlYWY2ZTVmNWYu
LjBiOGY1MWQ2ODNkYyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL210
cnIuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oDQo+PiBAQCAtMzEs
NiArMzEsOCBAQA0KPj4gICAgKi8NCj4+ICAgIyBpZmRlZiBDT05GSUdfTVRSUg0KPj4gICB2
b2lkIG10cnJfYnBfaW5pdCh2b2lkKTsNCj4+ICt2b2lkIG10cnJfb3ZlcndyaXRlX3N0YXRl
KHN0cnVjdCBtdHJyX3Zhcl9yYW5nZSAqdmFyLCB1bnNpZ25lZCBpbnQgbnVtX3ZhciwNCj4+
ICsJCQkgIG10cnJfdHlwZSAqZml4ZWQsIG10cnJfdHlwZSBkZWZfdHlwZSk7DQo+IA0KPiBD
b3VsZCB5b3UgYWRkIGEgc3R1YiBmb3IgdGhlICFDT05GSUdfTVRSUiBjYXNlPyAgVGhlbiB0
aGUNCj4gI2lmZGVmIENPTkZJR19NVFJSIGNvdWxkIGJlIHJlbW92ZWQgaW4gUGF0Y2ggMyBv
ZiB0aGlzIHNlcmllcy4NCg0KSSB3YXMgb24gdGhlIGVkZ2Ugd2hldGhlciB0byBhZGQgYSBz
dHViLiBUaGUgWGVuIHVzZSBjYXNlIHN0cm9uZ2x5DQpzdWdnZXN0cyB0aGF0IHRoZSBjb2Rl
IHdhbnRzIHRvIGJlIGluc2lkZSBhbiAjaWZkZWYsIHdoaWxlIHRoZSBIeXBlci1WDQpjYXNl
IGlzIHNvIHNpbXBsZSwgdGhhdCBpdCB3b3VsZCBiZW5lZml0IGZyb20gdGhlIHN0dWIuIEFz
IHRoZXJlIHdhcw0KYW5vdGhlciAjaWZkZWYganVzdCBhYm92ZSB0aGUgYWRkZWQgY29kZSBp
biBtc2h5cGVydi5jIEkgYmVsaWV2ZWQgaXQNCndvdWxkIGJlIGZpbmUgd2l0aG91dCBhIHN0
dWIuIEFzIHlvdSBzZWVtIHRvIGxpa2UgaXQgYmV0dGVyIHdpdGggdGhlDQpzdHViLCBJIGNh
biBhZGQgaXQuDQoNCg0KSnVlcmdlbg0K
--------------rn3w2ivt7ensmUBtxZ2PwmYW
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------rn3w2ivt7ensmUBtxZ2PwmYW--

--------------yn2Qx4Q01xzWKT7SuWDxeNhU--

--------------ytCMa8DuorXCqrSOTuKcUpAv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp2E4FAwAAAAAACgkQsN6d1ii/Ey9j
twgAgHOMwoaAR1L9uMkHjO1h/fzM0DoBXmo0dbRDaHI8MTFgNH52SjPSJ1DPaxe1G8D+5fviA2eN
scdDyZHPcuhuEWrFolPyqcglPPlKGeQAqGQlSEXTc34ftSpcijZ7NEAM6XeyxS7h6v4F/2xGWErh
YiJmkXMvUMePxRoxhXMviDdPBC+iFlLw1Xaa8jsst/fDS9ffUgKf7ABN6NWLSjnWRfIwaruvG1mm
yasYtJ2Yf4vdHe/USgeStkpMOtYMOsWLt2sYe4Tx7ouiq6l7mZtgR1exvaggsRL96F7LMrSN7eqH
OZYC7oKqOoOK7tjGiFiElXRSKDdF/VW9G50H1Njw6g==
=rJwk
-----END PGP SIGNATURE-----

--------------ytCMa8DuorXCqrSOTuKcUpAv--
