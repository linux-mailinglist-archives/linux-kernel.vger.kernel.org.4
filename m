Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6407C6638FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjAJGC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjAJGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00401C26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:59:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17595612FE;
        Tue, 10 Jan 2023 05:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673330378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aF338VeMd8mOG+zXjPDXJGd2RkUVJK3TeF08hiwUm6Q=;
        b=KTZbsyV6KslH4Fbu+GLkmPyl0I184Qoa384lQ+XFvMCkiTwfx9siYJHO1uC18cre/Q41fI
        pEv6pUPPn52RcJXlDAsOouwV0Bsf+aXRydGHD53GVkuvnoGf7O88AEHI1EZCih9EOkvTU6
        xc9ws0/gr5QH/OW+4DZqxLVnmRKvg1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D371E1358A;
        Tue, 10 Jan 2023 05:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IcYgMsn+vGMASwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 05:59:37 +0000
Message-ID: <ba24157d-92fc-f472-9ef5-4eae3c63c12e@suse.com>
Date:   Tue, 10 Jan 2023 06:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Jan Beulich <jbeulich@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
In-Reply-To: <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NCcMP466BJPyiDVM1qKkw022"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NCcMP466BJPyiDVM1qKkw022
Content-Type: multipart/mixed; boundary="------------Q25iRST94k8C9636ZAsL0ppF";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Andrew Lutomirski <luto@kernel.org>, Jan Beulich <jbeulich@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <ba24157d-92fc-f472-9ef5-4eae3c63c12e@suse.com>
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
In-Reply-To: <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>

--------------Q25iRST94k8C9636ZAsL0ppF
Content-Type: multipart/mixed; boundary="------------HvmiliKnfQFHcSOjC0mQZzph"

--------------HvmiliKnfQFHcSOjC0mQZzph
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDEuMjMgMDY6NDcsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDA5LjAxLjIz
IDE5OjI4LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPj4gSSd2ZSBjb21lIGFj
cm9zcyBhIGNhc2Ugd2l0aCBhIFZNIHJ1bm5pbmcgb24gSHlwZXItViB0aGF0IGRvZXNuJ3Qg
Z2V0DQo+PiBNVFJScywgYnV0IHRoZSBQQVQgaXMgZnVuY3Rpb25hbC7CoCAoVGhpcyBpcyBh
IENvbmZpZGVudGlhbCBWTSB1c2luZw0KPj4gQU1EJ3MgU0VWLVNOUCBlbmNyeXB0aW9uIHRl
Y2hub2xvZ3kgd2l0aCB0aGUgdlRPTSBvcHRpb24uKcKgIEluIHRoaXMNCj4+IGNhc2UsIHRo
ZSBjaGFuZ2VzIGluIGNvbW1pdCA3MmNiYzhmMDRmZTIgKCJ4ODYvUEFUOiBIYXZlIHBhdF9l
bmFibGVkKCkNCj4+IHByb3Blcmx5IHJlZmxlY3Qgc3RhdGUgd2hlbiBydW5uaW5nIG9uIFhl
biIpIGFwcGx5LsKgwqAgcGF0X2VuYWJsZWQoKSByZXR1cm5zDQo+PiAidHJ1ZSIsIGJ1dCB0
aGUgTVRSUnMgYXJlIG5vdCBlbmFibGVkLg0KPj4NCj4+IEJ1dCB3aXRoIHRoaXMgY29tbWl0
LCB0aGVyZSdzIGEgcHJvYmxlbS7CoCBDb25zaWRlciBtZW1yZW1hcCgpIG9uIGEgUkFNDQo+
PiByZWdpb24sIGNhbGxlZCB3aXRoIE1FTVJFTUFQX1dCIHBsdXMgTUVNUkVNQVBfREVDIGFz
IHRoZSAzcmQNCj4+IGFyZ3VtZW50LiBCZWNhdXNlIG9mIHRoZSByZXF1ZXN0IGZvciBhIGRl
Y3J5cHRlZCBtYXBwaW5nLA0KPj4gYXJjaF9tZW1yZW1hcF9jYW5fcmFtX3JlbWFwKCkgcmV0
dXJucyBmYWxzZSwgYW5kIGEgbmV3IG1hcHBpbmcNCj4+IG11c3QgYmUgY3JlYXRlZCwgd2hp
Y2ggaXMgYXBwcm9wcmlhdGUuDQo+Pg0KPj4gVGhlIGZvbGxvd2luZyBjYWxsIHN0YWNrIHJl
c3VsdHM6DQo+Pg0KPj4gwqDCoCBtZW1yZW1hcCgpDQo+PiDCoMKgIGFyY2hfbWVtcmVtYXBf
d2IoKQ0KPj4gwqDCoCBpb3JlbWFwX2NhY2hlKCkNCj4+IMKgwqAgX19pb3JlbWFwX2NhbGxl
cigpDQo+PiDCoMKgIG1lbXR5cGVfcmVzZXJ2ZSgpwqAgPC0tLSBwY20gaXMgX1BBR0VfQ0FD
SEVfTU9ERV9XQg0KPj4gwqDCoCBwYXRfeF9tdHJyX3R5cGUoKcKgIDwtLSBvbmx5IGNhbGxl
ZCBhZnRlciBjb21taXQgNzJjYmM4ZjA0ZmUyDQo+Pg0KPj4gcGF0X3hfbXRycl90eXBlKCkg
cmV0dXJucyBfUEFHRV9DQUNIRV9NT0RFX1VDX01JTlVTIGJlY2F1c2UNCj4+IG10cnJfdHlw
ZV9sb29rdXAoKSBmYWlscy7CoCBBcyBhIHJlc3VsdCwgbWVtcmVtYXAoKSBlcnJvbmVvdXNs
eSBjcmVhdGVzIHRoZQ0KPj4gbmV3IG1hcHBpbmcgYXMgdW5jYWNoZWQuwqDCoCBUaGlzIHVu
Y2FjaGVkIG1hcHBpbmcgaXMgY2F1c2luZyBhIHNpZ25pZmljYW50DQo+PiBwZXJmb3JtYW5j
ZSBwcm9ibGVtIGluIGNlcnRhaW4gSHlwZXItViBDb25maWRlbnRpYWwgVk0gY29uZmlndXJh
dGlvbnMuDQo+Pg0KPj4gQW55IHRob3VnaHRzIG9uIHJlc29sdmluZyB0aGlzP8KgIFNob3Vs
ZCBtZW10eXBlX3Jlc2VydmUoKSBiZSBjaGVja2luZw0KPj4gYm90aCBwYXRfZW5hYmxlZCgp
ICphbmQqIHdoZXRoZXIgTVRSUnMgYXJlIGVuYWJsZWQgYmVmb3JlIGNhbGxpbmcNCj4+IHBh
dF94X210cnJfdHlwZSgpP8KgIE9yIGRvZXMgdGhhdCBkZWZlYXQgdGhlIHB1cnBvc2Ugb2Yg
Y29tbWl0DQo+PiA3MmNiYzhmMDRmZTIgaW4gdGhlIFhlbiBlbnZpcm9ubWVudD8NCj4gDQo+
IEkgdGhpbmsgcGF0X3hfbXRycl90eXBlKCkgc2hvdWxkIHJldHVybiBfUEFHRV9DQUNIRV9N
T0RFX1VDX01JTlVTIG9ubHkgaWYNCj4gbXRycl90eXBlX2xvb2t1cCgpIGlzIG5vdCBmYWls
aW5nIGFuZCBpcyByZXR1cm5pbmcgYSBtb2RlIG90aGVyIHRoYW4gV0IuDQoNCkFub3RoZXIg
aWRlYSB3b3VsZCBiZSB0byBsZXQgdGhlIG10cnJfdHlwZV9sb29rdXAoKSBzdHViIGluDQph
cmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmggcmV0dXJuIE1UUlJfVFlQRV9XUkJBQ0ssIGVu
YWJsaW5nIHRvIHNpbXBsaWZ5DQpwdWRfc2V0X2h1Z2UoKSBhbmQgcG1kX3NldF9odWdlKCkg
YnkgcmVtb3ZpbmcgdGhlIGNoZWNrIGZvciBNVFJSX1RZUEVfSU5WQUxJRC4NCg0KDQpKdWVy
Z2VuDQo=
--------------HvmiliKnfQFHcSOjC0mQZzph
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------HvmiliKnfQFHcSOjC0mQZzph--

--------------Q25iRST94k8C9636ZAsL0ppF--

--------------NCcMP466BJPyiDVM1qKkw022
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO8/skFAwAAAAAACgkQsN6d1ii/Ey84
Cwf9G/P++wHlaCcX8j+JRBcoA9jKCSsN2iWkWtxi0WC9kZpybt58HDx1D2QPHYD2raTtF5s+NAkr
IDXa8QMCVXWDsDEzXbrDjjascvUtG2HViGemQe4YDNbqNqSRH43pu9qiF7aR6GC87w/aV5Ma0bwZ
FYfbGJsqT8wkH0IjMYglU63GCQw4sjjoR7V1sXR+SYVqHH7dy1PTj7XBcwEDw/Lk6mS4ihor79Zk
voE3hwtt8VfY8sHSTC5AAr1vIt3i2DaAN8cDqGX2ah//JUvI9PwsbwW+wqPhjaLc9/GGxm6m4+5Q
qrjZdGfbfw1smAfHptLkYsBB4c4E9eTzt40UI8nOkA==
=ff7s
-----END PGP SIGNATURE-----

--------------NCcMP466BJPyiDVM1qKkw022--
