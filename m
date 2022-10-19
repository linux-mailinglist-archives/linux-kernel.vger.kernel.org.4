Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C282603A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJSHSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJSHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:18:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221D77569;
        Wed, 19 Oct 2022 00:18:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F810338B8;
        Wed, 19 Oct 2022 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666163881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sN2DbqGpEK20ZzgZWtm2mF/kXKDJHNlXToLxSGgTryA=;
        b=jepEcTgBCdhPEkiEVJZnJYPhdcnEw3IIZFZPefPjT9otDk0/50WB0nlJIpy2PqFf7GOWZN
        3IudsYLndrsyDtyacmhpGevumwINBHBM0tZa/aincVLW4L4LM4MAfQKBlbLIt4il25Cpec
        FNNkpSVsZlRhpDJU+1otRo3Y2+fhTDM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B2F713A36;
        Wed, 19 Oct 2022 07:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yn0mCamkT2PlNgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 19 Oct 2022 07:18:01 +0000
Message-ID: <84c656bf-aec3-0217-40f2-0c005b8b8cd4@suse.com>
Date:   Wed, 19 Oct 2022 09:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 00/16] x86: make pat and mtrr independent from each
 other
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221004081023.32402-1-jgross@suse.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o8yXlAxj1qPKQcJ0pIJYj3My"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o8yXlAxj1qPKQcJ0pIJYj3My
Content-Type: multipart/mixed; boundary="------------P8b7VxddAArhnRCdob4VGxke";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <84c656bf-aec3-0217-40f2-0c005b8b8cd4@suse.com>
Subject: Re: [PATCH v4 00/16] x86: make pat and mtrr independent from each
 other
References: <20221004081023.32402-1-jgross@suse.com>
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>

--------------P8b7VxddAArhnRCdob4VGxke
Content-Type: multipart/mixed; boundary="------------xDT7x1HakLMB0fbMG0lJk5rC"

--------------xDT7x1HakLMB0fbMG0lJk5rC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZz8NCg0KT24gMDQuMTAuMjIgMTA6MTAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFRv
ZGF5IFBBVCBjYW4ndCBiZSB1c2VkIHdpdGhvdXQgTVRSUiBiZWluZyBhdmFpbGFibGUsIHVu
bGVzcyBNVFJSIGlzIGF0DQo+IGxlYXN0IGNvbmZpZ3VyZWQgdmlhIENPTkZJR19NVFJSIGFu
ZCB0aGUgc3lzdGVtIGlzIHJ1bm5pbmcgYXMgWGVuIFBWDQo+IGd1ZXN0LiBJbiB0aGlzIGNh
c2UgUEFUIGlzIGF1dG9tYXRpY2FsbHkgYXZhaWxhYmxlIHZpYSB0aGUgaHlwZXJ2aXNvciwN
Cj4gYnV0IHRoZSBQQVQgTVNSIGNhbid0IGJlIG1vZGlmaWVkIGJ5IHRoZSBrZXJuZWwgYW5k
IE1UUlIgaXMgZGlzYWJsZWQuDQo+IA0KPiBUaGUgc2FtZSBhcHBsaWVzIHRvIGEga2VybmVs
IGJ1aWx0IHdpdGggbm8gTVRSUiBzdXBwb3J0OiBpdCB3b24ndA0KPiBhbGxvdyB0byB1c2Ug
dGhlIFBBVCBNU1IsIGV2ZW4gaWYgdGhlcmUgaXMgbm8gdGVjaG5pY2FsIHJlYXNvbiBmb3IN
Cj4gdGhhdCwgb3RoZXIgdGhhbiBzZXR0aW5nIHVwIFBBVCBvbiBhbGwgY3B1cyB0aGUgc2Ft
ZSB3YXkgKHdoaWNoIGlzIGENCj4gcmVxdWlyZW1lbnQgb2YgdGhlIHByb2Nlc3NvcidzIGNh
Y2hlIG1hbmFnZW1lbnQpIGlzIHJlbHlpbmcgb24gc29tZQ0KPiBNVFJSIHNwZWNpZmljIGNv
ZGUuDQo+IA0KPiBGaXggYWxsIG9mIHRoYXQgYnk6DQo+IA0KPiAtIG1vdmluZyB0aGUgZnVu
Y3Rpb24gbmVlZGVkIGJ5IFBBVCBmcm9tIE1UUlIgc3BlY2lmaWMgY29kZSBvbmUgbGV2ZWwN
Cj4gICAgdXANCj4gLSByZXdvcmtpbmcgdGhlIGluaXQgc2VxdWVuY2VzIG9mIE1UUlIgYW5k
IFBBVCB0byBiZSBtb3JlIHNpbWlsYXIgdG8NCj4gICAgZWFjaCBvdGhlciB3aXRob3V0IGNh
bGxpbmcgUEFUIGZyb20gTVRSUiBjb2RlDQo+IC0gcmVtb3ZpbmcgdGhlIGRlcGVuZGVuY3kg
b2YgUEFUIG9uIE1UUlINCj4gDQo+IFdoaWxlIHdvcmtpbmcgb24gdGhhdCBJIGRpc2NvdmVy
ZWQgdHdvIG1pbm9yIGJ1Z3MgaW4gTVRSUiBjb2RlLCB3aGljaA0KPiBhcmUgZml4ZWQsIHRv
by4NCj4gDQo+IFRoZXJlIGlzIHNvbWUgbW9yZSBjbGVhbnVwIGRvbmUgcmVkdWNpbmcgY29k
ZSBzaXplLg0KPiANCj4gQ2hhbmdlcyBpbiBWNDoNCj4gLSBuZXcgcGF0Y2hlcyAxMCwgMTQs
IDE1LCAxNg0KPiAtIHNwbGl0IHVwIG9sZCBwYXRjaCA0IGludG8gMyBwYXRjaGVzDQo+IC0g
YWRkcmVzc2VkIGNvbW1lbnRzDQo+IA0KPiBDaGFuZ2VzIGluIFYzOg0KPiAtIHJlcGxhY2Ug
cGF0Y2ggMSBieSBqdXN0IGFkZGluZyBhIGNvbW1lbnQNCj4gDQo+IENoYW5nZXMgaW4gVjI6
DQo+IC0gY29tcGxldGUgcmV3b3JrIG9mIHRoZSBwYXRjaGVzIGJhc2VkIG9uIGNvbW1lbnRz
IGJ5IEJvcmlzIFBldGtvdg0KPiAtIGFkZGVkIHNldmVyYWwgcGF0Y2hlcyB0byB0aGUgc2Vy
aWVzDQo+IA0KPiBKdWVyZ2VuIEdyb3NzICgxNik6DQo+ICAgIHg4Ni9tdHJyOiBhZGQgY29t
bWVudCBmb3Igc2V0X210cnJfc3RhdGUoKSBzZXJpYWxpemF0aW9uDQo+ICAgIHg4Ni9tdHJy
OiByZW1vdmUgdW51c2VkIGN5cml4X3NldF9hbGwoKSBmdW5jdGlvbg0KPiAgICB4ODYvbXRy
cjogcmVwbGFjZSB1c2VfaW50ZWwoKSB3aXRoIGEgbG9jYWwgZmxhZw0KPiAgICB4ODYvbXRy
cjogcmVuYW1lIHByZXBhcmVfc2V0KCkgYW5kIHBvc3Rfc2V0KCkNCj4gICAgeDg2L210cnI6
IHNwbGl0IE1UUlIgc3BlY2lmaWMgaGFuZGxpbmcgZnJvbSBjYWNoZSBkaXMvZW5hYmxpbmcN
Cj4gICAgeDg2OiBtb3ZlIHNvbWUgY29kZSBvdXQgb2YgYXJjaC94ODYva2VybmVsL2NwdS9t
dHJyDQo+ICAgIHg4Ni9tdHJyOiBzcGxpdCBnZW5lcmljX3NldF9hbGwoKQ0KPiAgICB4ODYv
bXRycjogcmVtb3ZlIHNldF9hbGwgY2FsbGJhY2sgZnJvbSBzdHJ1Y3QgbXRycl9vcHMNCj4g
ICAgeDg2L210cnI6IHNpbXBsaWZ5IG10cnJfYnBfaW5pdCgpDQo+ICAgIHg4Ni9tdHJyOiBn
ZXQgcmlkIG9mIG10cnJfZW5hYmxlZCBib29sDQo+ICAgIHg4Ni9tdHJyOiBsZXQgY2FjaGVf
YXBzX2RlbGF5ZWRfaW5pdCByZXBsYWNlIG10cnJfYXBzX2RlbGF5ZWRfaW5pdA0KPiAgICB4
ODYvbXRycjogYWRkIGEgc3RvcF9tYWNoaW5lKCkgaGFuZGxlciBjYWxsaW5nIG9ubHkgY2Fj
aGVfY3B1X2luaXQoKQ0KPiAgICB4ODY6IGRlY291cGxlIHBhdCBhbmQgbXRyciBoYW5kbGlu
Zw0KPiAgICB4ODY6IHN3aXRjaCBjYWNoZV9hcF9pbml0KCkgdG8gaG90cGx1ZyBjYWxsYmFj
aw0KPiAgICB4ODY6IGRvIE1UUlIvUEFUIHNldHVwIG9uIGFsbCBzZWNvbmRhcnkgQ1BVcyBp
biBwYXJhbGxlbA0KPiAgICB4ODYvbXRycjogc2ltcGxpZnkgbXRycl9vcHMgaW5pdGlhbGl6
YXRpb24NCj4gDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vY2FjaGVpbmZvLmggICB8ICAx
OCArKysNCj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW10eXBlLmggICAgIHwgICA1ICst
DQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oICAgICAgICB8ICAxMyArLQ0KPiAg
IGFyY2gveDg2L2tlcm5lbC9jcHUvY2FjaGVpbmZvLmMgICAgfCAxNjggKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jICAgICAg
IHwgICAyICstDQo+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2FtZC5jICAgICB8ICAg
OCArLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9jZW50YXVyLmMgfCAgIDggKy0N
Cj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvY3lyaXguYyAgIHwgIDQyICstLS0tLS0N
Cj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIHwgMTI3ICsrKy0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyAgICB8
IDE4NSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gveDg2L2tlcm5l
bC9jcHUvbXRyci9tdHJyLmggICAgfCAgMjAgKystLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9z
ZXR1cC5jICAgICAgICAgICAgfCAgMTQgKy0tDQo+ICAgYXJjaC94ODYva2VybmVsL3NtcGJv
b3QuYyAgICAgICAgICB8ICAgOSArLQ0KPiAgIGFyY2gveDg2L21tL3BhdC9tZW10eXBlLmMg
ICAgICAgICAgfCAxMjcgKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL3g4Ni9wb3dl
ci9jcHUuYyAgICAgICAgICAgICAgIHwgICAzICstDQo+ICAgaW5jbHVkZS9saW51eC9jcHVo
b3RwbHVnLmggICAgICAgICB8ICAgMSArDQo+ICAgMTYgZmlsZXMgY2hhbmdlZCwgMjk4IGlu
c2VydGlvbnMoKyksIDQ1MiBkZWxldGlvbnMoLSkNCj4gDQoNCg==
--------------xDT7x1HakLMB0fbMG0lJk5rC
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xDT7x1HakLMB0fbMG0lJk5rC--

--------------P8b7VxddAArhnRCdob4VGxke--

--------------o8yXlAxj1qPKQcJ0pIJYj3My
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNPpKgFAwAAAAAACgkQsN6d1ii/Ey8C
LQf/YETIjc8WUVKGzrFHZpzPCSjYeM35fedN3vGxnSIyhozNNockxupD4nqrY1vCrWM1iOejMh5h
eYbxD9iernnZrBEjgEEcefKOlc9IWZUCnbnKWIYEriJVSeBLuazJ+++RP99CsRPV5fjQaHZg3Qdg
n/ngwtHzodUgHk+1yFxQeFWxCGOD2P499pDP5lm/bc5waNQVfkhJXEGGykSO4WfcFEWBFVnY91kg
rB+MJ2MZNVPMryrk5QinRYeyN+xyjXo2Sr4qwMKtCod7ds5tZKBCPx7VIYromyi52Ij07pgq/pPY
dsmnDCJITKSEQfhYIeHJ5UZEuVGDDYjE5Udt/gSPTg==
=XyPm
-----END PGP SIGNATURE-----

--------------o8yXlAxj1qPKQcJ0pIJYj3My--
