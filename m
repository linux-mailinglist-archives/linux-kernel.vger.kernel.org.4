Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B93663D75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAJKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjAJKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:01:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6564FD77
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:01:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB39968094;
        Tue, 10 Jan 2023 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673344863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UwDp5XYDAC2Q9q+rKMqs99kfvtsDPmiiS62MPkYcPFg=;
        b=uV35YrM8vCb/3Yuy98VTRDwPJ3S8FEJxA2CzXaVSVHOi+6DZ+hoDgzpEC6oHKTedPIykJw
        kKtEO71vvi4QER9/xBEHygk3emUBiS7cystV35PJ15yR3YqwJ61SkXv7n8xgleYiNSt9yv
        1FTW4yr/XTnha8aPnX16oJWoWx5YVzo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 846B41358A;
        Tue, 10 Jan 2023 10:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPT8Hl83vWPrRgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 10:01:03 +0000
Message-ID: <00df09fe-bd71-9204-18f2-6479c91dc4b0@suse.com>
Date:   Tue, 10 Jan 2023 11:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
 <ba24157d-92fc-f472-9ef5-4eae3c63c12e@suse.com>
 <1653609a-42af-b7cd-9d30-fb2bd5721080@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
In-Reply-To: <1653609a-42af-b7cd-9d30-fb2bd5721080@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------orkPXvNaufX9x9hz0ec9o6vR"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------orkPXvNaufX9x9hz0ec9o6vR
Content-Type: multipart/mixed; boundary="------------vYkKADx0yfD0N7Rcj8wnZweX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Andrew Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <00df09fe-bd71-9204-18f2-6479c91dc4b0@suse.com>
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
 <ba24157d-92fc-f472-9ef5-4eae3c63c12e@suse.com>
 <1653609a-42af-b7cd-9d30-fb2bd5721080@suse.com>
In-Reply-To: <1653609a-42af-b7cd-9d30-fb2bd5721080@suse.com>

--------------vYkKADx0yfD0N7Rcj8wnZweX
Content-Type: multipart/mixed; boundary="------------KeddABKumQSF93NckVqhMfMH"

--------------KeddABKumQSF93NckVqhMfMH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDEuMjMgMTA6MzgsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMC4wMS4yMDIz
IDA2OjU5LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMTAuMDEuMjMgMDY6NDcsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gT24gMDkuMDEuMjMgMTk6MjgsIE1pY2hhZWwgS2Vs
bGV5IChMSU5VWCkgd3JvdGU6DQo+Pj4+IEkndmUgY29tZSBhY3Jvc3MgYSBjYXNlIHdpdGgg
YSBWTSBydW5uaW5nIG9uIEh5cGVyLVYgdGhhdCBkb2Vzbid0IGdldA0KPj4+PiBNVFJScywg
YnV0IHRoZSBQQVQgaXMgZnVuY3Rpb25hbC7CoCAoVGhpcyBpcyBhIENvbmZpZGVudGlhbCBW
TSB1c2luZw0KPj4+PiBBTUQncyBTRVYtU05QIGVuY3J5cHRpb24gdGVjaG5vbG9neSB3aXRo
IHRoZSB2VE9NIG9wdGlvbi4pwqAgSW4gdGhpcw0KPj4+PiBjYXNlLCB0aGUgY2hhbmdlcyBp
biBjb21taXQgNzJjYmM4ZjA0ZmUyICgieDg2L1BBVDogSGF2ZSBwYXRfZW5hYmxlZCgpDQo+
Pj4+IHByb3Blcmx5IHJlZmxlY3Qgc3RhdGUgd2hlbiBydW5uaW5nIG9uIFhlbiIpIGFwcGx5
LsKgwqAgcGF0X2VuYWJsZWQoKSByZXR1cm5zDQo+Pj4+ICJ0cnVlIiwgYnV0IHRoZSBNVFJS
cyBhcmUgbm90IGVuYWJsZWQuDQo+Pj4+DQo+Pj4+IEJ1dCB3aXRoIHRoaXMgY29tbWl0LCB0
aGVyZSdzIGEgcHJvYmxlbS7CoCBDb25zaWRlciBtZW1yZW1hcCgpIG9uIGEgUkFNDQo+Pj4+
IHJlZ2lvbiwgY2FsbGVkIHdpdGggTUVNUkVNQVBfV0IgcGx1cyBNRU1SRU1BUF9ERUMgYXMg
dGhlIDNyZA0KPj4+PiBhcmd1bWVudC4gQmVjYXVzZSBvZiB0aGUgcmVxdWVzdCBmb3IgYSBk
ZWNyeXB0ZWQgbWFwcGluZywNCj4+Pj4gYXJjaF9tZW1yZW1hcF9jYW5fcmFtX3JlbWFwKCkg
cmV0dXJucyBmYWxzZSwgYW5kIGEgbmV3IG1hcHBpbmcNCj4+Pj4gbXVzdCBiZSBjcmVhdGVk
LCB3aGljaCBpcyBhcHByb3ByaWF0ZS4NCj4+Pj4NCj4+Pj4gVGhlIGZvbGxvd2luZyBjYWxs
IHN0YWNrIHJlc3VsdHM6DQo+Pj4+DQo+Pj4+ICDCoMKgIG1lbXJlbWFwKCkNCj4+Pj4gIMKg
wqAgYXJjaF9tZW1yZW1hcF93YigpDQo+Pj4+ICDCoMKgIGlvcmVtYXBfY2FjaGUoKQ0KPj4+
PiAgwqDCoCBfX2lvcmVtYXBfY2FsbGVyKCkNCj4+Pj4gIMKgwqAgbWVtdHlwZV9yZXNlcnZl
KCnCoCA8LS0tIHBjbSBpcyBfUEFHRV9DQUNIRV9NT0RFX1dCDQo+Pj4+ICDCoMKgIHBhdF94
X210cnJfdHlwZSgpwqAgPC0tIG9ubHkgY2FsbGVkIGFmdGVyIGNvbW1pdCA3MmNiYzhmMDRm
ZTINCj4+Pj4NCj4+Pj4gcGF0X3hfbXRycl90eXBlKCkgcmV0dXJucyBfUEFHRV9DQUNIRV9N
T0RFX1VDX01JTlVTIGJlY2F1c2UNCj4+Pj4gbXRycl90eXBlX2xvb2t1cCgpIGZhaWxzLsKg
IEFzIGEgcmVzdWx0LCBtZW1yZW1hcCgpIGVycm9uZW91c2x5IGNyZWF0ZXMgdGhlDQo+Pj4+
IG5ldyBtYXBwaW5nIGFzIHVuY2FjaGVkLsKgwqAgVGhpcyB1bmNhY2hlZCBtYXBwaW5nIGlz
IGNhdXNpbmcgYSBzaWduaWZpY2FudA0KPj4+PiBwZXJmb3JtYW5jZSBwcm9ibGVtIGluIGNl
cnRhaW4gSHlwZXItViBDb25maWRlbnRpYWwgVk0gY29uZmlndXJhdGlvbnMuDQo+Pj4+DQo+
Pj4+IEFueSB0aG91Z2h0cyBvbiByZXNvbHZpbmcgdGhpcz/CoCBTaG91bGQgbWVtdHlwZV9y
ZXNlcnZlKCkgYmUgY2hlY2tpbmcNCj4+Pj4gYm90aCBwYXRfZW5hYmxlZCgpICphbmQqIHdo
ZXRoZXIgTVRSUnMgYXJlIGVuYWJsZWQgYmVmb3JlIGNhbGxpbmcNCj4+Pj4gcGF0X3hfbXRy
cl90eXBlKCk/wqAgT3IgZG9lcyB0aGF0IGRlZmVhdCB0aGUgcHVycG9zZSBvZiBjb21taXQN
Cj4+Pj4gNzJjYmM4ZjA0ZmUyIGluIHRoZSBYZW4gZW52aXJvbm1lbnQ/DQo+Pj4NCj4+PiBJ
IHRoaW5rIHBhdF94X210cnJfdHlwZSgpIHNob3VsZCByZXR1cm4gX1BBR0VfQ0FDSEVfTU9E
RV9VQ19NSU5VUyBvbmx5IGlmDQo+Pj4gbXRycl90eXBlX2xvb2t1cCgpIGlzIG5vdCBmYWls
aW5nIGFuZCBpcyByZXR1cm5pbmcgYSBtb2RlIG90aGVyIHRoYW4gV0IuDQo+IA0KPiBJIGFn
cmVlLg0KPiANCj4+IEFub3RoZXIgaWRlYSB3b3VsZCBiZSB0byBsZXQgdGhlIG10cnJfdHlw
ZV9sb29rdXAoKSBzdHViIGluDQo+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmggcmV0
dXJuIE1UUlJfVFlQRV9XUkJBQ0ssIGVuYWJsaW5nIHRvIHNpbXBsaWZ5DQo+PiBwdWRfc2V0
X2h1Z2UoKSBhbmQgcG1kX3NldF9odWdlKCkgYnkgcmVtb3ZpbmcgdGhlIGNoZWNrIGZvciBN
VFJSX1RZUEVfSU5WQUxJRC4NCj4gDQo+IEJ1dCB0aGF0IGhhcyBhIHJpc2sgb2YgZW5kaW5n
IHVwIG1pc2xlYWRpbmc6IFdoZW4gdGhlcmUgYXJlIG5vIE1UUlJzLCB0aGVyZQ0KPiBzaW1w
bHkgaXMgbm8gZGVmYXVsdCB0eXBlIChpbiB0aGUgYWJzZW5jZSBvZiBpbnNwZWN0aW5nIG90
aGVyIGNyaXRlcmlhKS4NCg0KSSd2ZSBzZW50IGEgcGF0Y2ggY2hlY2tpbmcgZm9yIE1UUlJf
VFlQRV9JTlZBTElEIGluIHBhdF94X210cnJfdHlwZSgpLiBUaGlzDQpzZWVtZWQgdG8gYmUg
YSBsZXNzIGludHJ1c2l2ZSBjaGFuZ2UuDQoNClRoZSBpZGVhIHRvIG1vZGlmeSB0aGUgc3R1
YiBjYW1lIHVwIGFzIGEgcmVzdWx0IG9mIGxvb2tpbmcgYXQgbXRycl90eXBlX2xvb2t1cCgp
DQp1c2UgY2FzZXMgYWZ0ZXIgd3JpdGluZyBteSBwYXRjaC4gQWxsIHVzZXJzIG5vdyB0YWtl
IGFuIGFjdGlvbiBpZiB0aGUgcmV0dXJuZWQNCnR5cGUgaXMgbm90IFdCIGFuZCBub3QgSU5W
QUxJRC4gU28gaXQgd291bGQgYmUgYSBtb2RpZmljYXRpb24gdGFpbG9yZWQgZm9yDQp0b2Rh
eSdzIG10cnJfdHlwZV9sb29rdXAoKSB1c2VycyBvbmx5Lg0KDQoNCkp1ZXJnZW4NCg==
--------------KeddABKumQSF93NckVqhMfMH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------KeddABKumQSF93NckVqhMfMH--

--------------vYkKADx0yfD0N7Rcj8wnZweX--

--------------orkPXvNaufX9x9hz0ec9o6vR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO9N18FAwAAAAAACgkQsN6d1ii/Ey9A
6wf/QDNuFDIZkOpSywJRLkULG6bKCjqnvQ7JbuaoaxVkVj3Nm+umRDzQw+UMWdrhDM8rPSAAPRma
buW5agDFnucjo1JRNjzoE9VVQJkGkWvZksYX5dx2Zkh0dI3rARgV73+/kXcWb2r4XXEYnpwFcYXf
H9aCrCndCoIllJWrKZDP3TYNTiA7VzfPsuOvcmRfkr0bQM2NsBPfApM28UQ5h/Kb7CMCzUJ/ZS6S
mdE2bxqZoAn06jEPqK6hEB3wS5FSg9rjt2qSAOjASXVf79LCqE8clE3HIqzkrqR85lv/qF4B2nbi
Yqq6O1y8BxRMqWnxTdi4wf6v2LZ0LKiweubtf3Ipbw==
=t3Ib
-----END PGP SIGNATURE-----

--------------orkPXvNaufX9x9hz0ec9o6vR--
