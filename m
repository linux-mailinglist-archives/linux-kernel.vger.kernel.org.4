Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33335E78D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIWKxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiIWKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:52:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CDE6DE4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:52:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7404F1F947;
        Fri, 23 Sep 2022 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663930368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3QxM4MwjPaOt1y0DNX9VHt5Ewdo6VSxU3K1Z3A4bfE=;
        b=q+TIGlQUvN3ybSUMfcFqPNfxMxOpOGKdNMhmdMFMLA5U2m0fsd/S88PzbEsVXGwLa7Axj/
        1q05KY41j18tX/x1yMlnMTX2TK0VQrY2rUY/HZspIqR9Uk0qcBFUdK/1gGL2dlj2FUwVjW
        q1i0wnmwiYzgygleMzL+w7NJCbCV90g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A1813AA5;
        Fri, 23 Sep 2022 10:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hmp6M/+PLWPfSQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 23 Sep 2022 10:52:47 +0000
Message-ID: <39a67e7d-e5a8-734a-bfd7-ef147504950c@suse.com>
Date:   Fri, 23 Sep 2022 12:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>, x86@kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        ganb@vmware.com, sturlapati@vmware.com, bordoloih@vmware.com,
        ankitja@vmware.com, keerthanak@vmware.com, namit@vmware.com,
        srivatsab@vmware.com
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
 <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------apjrs2pWp1x5FG02xpH1YzjK"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------apjrs2pWp1x5FG02xpH1YzjK
Content-Type: multipart/mixed; boundary="------------CSEFt4d4k0LvCePEzgCRHtoB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexey Makhalov <amakhalov@vmware.com>,
 x86@kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 ganb@vmware.com, sturlapati@vmware.com, bordoloih@vmware.com,
 ankitja@vmware.com, keerthanak@vmware.com, namit@vmware.com,
 srivatsab@vmware.com
Message-ID: <39a67e7d-e5a8-734a-bfd7-ef147504950c@suse.com>
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
 <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
In-Reply-To: <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>

--------------CSEFt4d4k0LvCePEzgCRHtoB
Content-Type: multipart/mixed; boundary="------------kMGgT77fs0wSYb2yVRQ8EQFy"

--------------kMGgT77fs0wSYb2yVRQ8EQFy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDkuMjIgMDk6MDUsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUaHUsIEp1
bCAyMSwgMjAyMiBhdCAwMTo0NDozM1BNIC0wNzAwLCBTcml2YXRzYSBTLiBCaGF0IHdyb3Rl
Og0KPj4gRnJvbTogU3JpdmF0c2EgUy4gQmhhdCAoVk13YXJlKSA8c3JpdmF0c2FAY3NhaWwu
bWl0LmVkdT4NCj4+DQo+PiBWTXdhcmUgRVNYaSBhbGxvd3MgZW5hYmxpbmcgYSBwYXNzdGhy
dSBtd2FpdCBDUFUtaWRsZSBzdGF0ZSBpbiB0aGUNCj4+IGd1ZXN0IHVzaW5nIHRoZSBmb2xs
b3dpbmcgVk1YIG9wdGlvbjoNCj4+DQo+PiBtb25pdG9yX2NvbnRyb2wubXdhaXRfaW5fZ3Vl
c3QgPSAiVFJVRSINCj4+DQo+PiBUaGlzIGxldHMgYSB2Q1BVIGluIG13YWl0IHRvIHJlbWFp
biBpbiBndWVzdCBjb250ZXh0IChpbnN0ZWFkIG9mDQo+PiB5aWVsZGluZyB0byB0aGUgaHlw
ZXJ2aXNvciB2aWEgYSBWTUVYSVQpLCB3aGljaCBoZWxwcyBzcGVlZCB1cA0KPj4gd2FrZXVw
cyBmcm9tIGlkbGUuDQo+Pg0KPj4gSG93ZXZlciwgdGhpcyBydW5zIGludG8gcHJvYmxlbXMg
d2l0aCBDUFUgaG90cGx1ZywgYmVjYXVzZSB0aGUgTGludXgNCj4+IENQVSBvZmZsaW5lIHBh
dGggcHJlZmVycyB0byBwdXQgdGhlIHZDUFUtdG8tYmUtb2ZmbGluZWQgaW4gbXdhaXQNCj4+
IHN0YXRlLCB3aGVuZXZlciBtd2FpdCBpcyBhdmFpbGFibGUuIEFzIGEgcmVzdWx0LCBzaW5j
ZSBhIHZDUFUgaW4gbXdhaXQNCj4+IHJlbWFpbnMgaW4gZ3Vlc3QgY29udGV4dCBhbmQgZG9l
cyBub3QgeWllbGQgdG8gdGhlIGh5cGVydmlzb3IsIGFuDQo+PiBvZmZsaW5lIHZDUFUgKmFw
cGVhcnMqIHRvIGJlIDEwMCUgYnVzeSBhcyB2aWV3ZWQgZnJvbSBFU1hpLCB3aGljaA0KPj4g
cHJldmVudHMgdGhlIGh5cGVydmlzb3IgZnJvbSBydW5uaW5nIG90aGVyIHZDUFVzIG9yIHdv
cmtsb2FkcyBvbiB0aGUNCj4+IGNvcnJlc3BvbmRpbmcgcENQVSAocGFydGljdWxhcmx5IHdo
ZW4gdkNQVSAtIHBDUFUgbWFwcGluZ3MgYXJlDQo+PiBzdGF0aWNhbGx5IGRlZmluZWQgYnkg
dGhlIHVzZXIpLg0KPiANCj4gSSB3b3VsZCBob3BlIHZDUFUgcGlubmluZyBpcyBhIG1hbmRh
dG9yeSB0aGluZyB3aGVuIE1XQUlUIHBhc3N0aHJvdWdoIGl0DQo+IHNldD8NCj4gDQo+PiBb
IE5vdGUgdGhhdCBzdWNoIGEgdkNQVSBpcyBub3QNCj4+IGFjdHVhbGx5IGJ1c3kgc3Bpbm5p
bmcgdGhvdWdoOyBpdCByZW1haW5zIGluIG13YWl0IGlkbGUgc3RhdGUgaW4gdGhlDQo+PiBn
dWVzdCBdLg0KPj4NCj4+IEZpeCB0aGlzIGJ5IG92ZXJyaWRpbmcgdGhlIENQVSBvZmZsaW5l
IHBsYXlfZGVhZCgpIGNhbGxiYWNrIGZvciBWTXdhcmUNCj4+IGh5cGVydmlzb3IsIGJ5IHB1
dHRpbmcgdGhlIENQVSBpbiBoYWx0IHN0YXRlICh3aGljaCBhY3R1YWxseSB5aWVsZHMgdG8N
Cj4+IHRoZSBoeXBlcnZpc29yKSwgZXZlbiBpZiBtd2FpdCBzdXBwb3J0IGlzIGF2YWlsYWJs
ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTcml2YXRzYSBTLiBCaGF0IChWTXdhcmUpIDxz
cml2YXRzYUBjc2FpbC5taXQuZWR1Pg0KPj4gLS0tDQo+IA0KPj4gK3N0YXRpYyB2b2lkIHZt
d2FyZV9wbGF5X2RlYWQodm9pZCkNCj4+ICt7DQo+PiArCXBsYXlfZGVhZF9jb21tb24oKTsN
Cj4+ICsJdGJvb3Rfc2h1dGRvd24oVEJfU0hVVERPV05fV0ZTKTsNCj4+ICsNCj4+ICsJLyoN
Cj4+ICsJICogUHV0IHRoZSB2Q1BVIGdvaW5nIG9mZmxpbmUgaW4gaGFsdCBpbnN0ZWFkIG9m
IG13YWl0IChldmVuDQo+PiArCSAqIGlmIG13YWl0IHN1cHBvcnQgaXMgYXZhaWxhYmxlKSwg
dG8gbWFrZSBzdXJlIHRoYXQgdGhlDQo+PiArCSAqIG9mZmxpbmUgdkNQVSB5aWVsZHMgdG8g
dGhlIGh5cGVydmlzb3IgKHdoaWNoIG1heSBub3QgaGFwcGVuDQo+PiArCSAqIHdpdGggbXdh
aXQsIGZvciBleGFtcGxlLCBpZiB0aGUgZ3Vlc3QncyBWTVggaXMgY29uZmlndXJlZA0KPj4g
KwkgKiB0byByZXRhaW4gdGhlIHZDUFUgaW4gZ3Vlc3QgY29udGV4dCB1cG9uIG13YWl0KS4N
Cj4+ICsJICovDQo+PiArCWhsdF9wbGF5X2RlYWQoKTsNCj4+ICt9DQo+PiAgICNlbmRpZg0K
Pj4gICANCj4+ICAgc3RhdGljIF9faW5pdCBpbnQgYWN0aXZhdGVfanVtcF9sYWJlbHModm9p
ZCkNCj4+IEBAIC0zNDksNiArMzY1LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHZtd2FyZV9w
YXJhdmlydF9vcHNfc2V0dXAodm9pZCkNCj4+ICAgI2lmZGVmIENPTkZJR19TTVANCj4+ICAg
CQlzbXBfb3BzLnNtcF9wcmVwYXJlX2Jvb3RfY3B1ID0NCj4+ICAgCQkJdm13YXJlX3NtcF9w
cmVwYXJlX2Jvb3RfY3B1Ow0KPj4gKwkJc21wX29wcy5wbGF5X2RlYWQgPSB2bXdhcmVfcGxh
eV9kZWFkOw0KPj4gICAJCWlmIChjcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxzKENQVUhQX0FQ
X09OTElORV9EWU4sDQo+PiAgIAkJCQkJICAgICAgIng4Ni92bXdhcmU6b25saW5lIiwNCj4+
ICAgCQkJCQkgICAgICB2bXdhcmVfY3B1X29ubGluZSwNCj4gDQo+IE5vIHJlYWwgb2JqZWN0
aW9uIGhlcmU7IGJ1dCB3b3VsZCBub3Qgc29tZXRoaW5nIGxpa2UgdGhlIGJlbG93IGZpeCB0
aGUNCj4gcHJvYmxlbSBtb3JlIGdlbmVyYWxseT8gSSdtIHRoaW5raW5nIE1XQUlUIHBhc3N0
aHJvdWdoIGZvciAqYW55Kg0KPiBoeXBlcnZpc29yIGRvZXNuJ3Qgd2FudCBwbGF5X2RlYWQg
dG8gdXNlIGl0Lg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jDQo+IGluZGV4IGYyNDIyN2JjMzIyMC4u
MTY2Y2IzYWFjYThhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5j
DQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMNCj4gQEAgLTE3NTksNiArMTc1
OSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtd2FpdF9wbGF5X2RlYWQodm9pZCkNCj4gICAJ
CXJldHVybjsNCj4gICAJaWYgKCF0aGlzX2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ0xGTFVTSCkp
DQo+ICAgCQlyZXR1cm47DQo+ICsJaWYgKHRoaXNfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBF
UlZJU09SKSkNCj4gKwkJcmV0dXJuOw0KPiAgIAlpZiAoX190aGlzX2NwdV9yZWFkKGNwdV9p
bmZvLmNwdWlkX2xldmVsKSA8IENQVUlEX01XQUlUX0xFQUYpDQo+ICAgCQlyZXR1cm47DQo+
ICAgDQoNCldpdGggbXkgWGVuIGhhdCBvbiBJIGFncmVlIHdpdGggdGhpcyBhcHByb2FjaC4N
Cg0KDQpKdWVyZ2VuDQo=
--------------kMGgT77fs0wSYb2yVRQ8EQFy
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------kMGgT77fs0wSYb2yVRQ8EQFy--

--------------CSEFt4d4k0LvCePEzgCRHtoB--

--------------apjrs2pWp1x5FG02xpH1YzjK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMtj/8FAwAAAAAACgkQsN6d1ii/Ey/A
4gf/W9LLEwLuamBwj4nKU31pYfrWk9t+aVbGB4FVq0kmmvehmNCb8252yJckG2axSUE22SiXXIhA
JTuuoT2tgj6U6A77wjMZ+sjl5IsJUFqSh+Qn9tMupVYYkp+5ZE82H1AsjKdetPk4OubyTLjREtCz
q5NDnAqkfzt9qnstsIUWc92whaR+ZrijvgknFQuieNnfrSLAoFLA6sCgOGYU4VOuXxRy6flYlsjN
K+6mi/2PNs+j5c9/ROUrDX0XTcEtn5zvsPdqiI6+hZysEoDdLUDLpLTn85CrkE1kk1zWZw9JEjB/
rx7Acal5lABAt6IlSx/yLlV94vtgp7orj1y/TiztsA==
=1pVE
-----END PGP SIGNATURE-----

--------------apjrs2pWp1x5FG02xpH1YzjK--
