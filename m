Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF45EBF86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiI0KP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiI0KPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:15:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFB5AC7F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:14:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FFFB1F889;
        Tue, 27 Sep 2022 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664273683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azbsoYkT0nr+gfgwtblGuP0Br8jabje/N29/Y2mlgXM=;
        b=nvU5qKiA7aq6P+RwThovfCWJJFKdo/wI5HysxWBudaq7I6Byo8TURdSBxXCJED6aryUzwn
        D/NL3tqQTkOQK+Hiyak+mQuPxNyhQpi2QPm/p669Yo0AC4aFHczY3vSmaqAGKU09nEX32z
        9EEUl6Q2wuYZRopRtEPL+0uQfUa6fE4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12FEB139B3;
        Tue, 27 Sep 2022 10:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n1tWAxPNMmPMSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 27 Sep 2022 10:14:43 +0000
Message-ID: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
Date:   Tue, 27 Sep 2022 12:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YzLMKk4OK9FtjjKQ@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------g4zPUaP42ub5sZKf9GZVZKaU"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------g4zPUaP42ub5sZKf9GZVZKaU
Content-Type: multipart/mixed; boundary="------------NAwU7mueCQZjm0bbNAQSgXHr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
In-Reply-To: <YzLMKk4OK9FtjjKQ@zn.tnic>

--------------NAwU7mueCQZjm0bbNAQSgXHr
Content-Type: multipart/mixed; boundary="------------QIMdqdxhoc6eaoR26OZpwXFP"

--------------QIMdqdxhoc6eaoR26OZpwXFP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDkuMjIgMTI6MTAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBT
ZXAgMjcsIDIwMjIgYXQgMTA6NTc6MzdBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRCSCBJIGRvbid0IHNlZSB0aGUgcG9pbnQgb2YgaGF2aW5nIGFuIGFjY2Vzc29yIHdo
aWNoIGlzIGp1c3Qgc2V0dGluZyBhDQo+PiB2YXJpYWJsZSB0byAidHJ1ZSIuIEJ1dCBpZiB5
b3UgbGlrZSBpdCBiZXR0ZXIsIEkgY2FuIGtlZXAgaXQuDQo+IA0KPiBBY2Nlc3NvcnMgYXJl
IGFsd2F5cyBiZXR0ZXIsIG5vIG1hdHRlciBob3cgc2lsbHkuIDopDQoNCk9rYXksIHRoZW4g
SSdsbCBrZWVwIGl0Lg0KDQo+IEJ1dCwgaW4gdHJ5aW5nIHRvIGdyb2sgeW91ciBuZXh0IHBh
dGNoIC0geW91IHJlYWxseSBzaG91bGQgc3BsaXQgdGhvc2UNCj4gbW9yZSBjb21wbGV4IG9u
ZXMgYmVjYXVzZSB0aGV5J3JlIGEgcGFpbiB0byByZXZpZXcgLSBJJ20gc3RhcnRpbmcgdG8N
Cj4gd29uZGVyIHdoZXRoZXIgd2UgY291bGQgZXZlbiByZW1vdmUgbXRycl9hcHNfZGVsYXll
ZF9pbml0IGFuZCBtYWtlIHRoZQ0KPiBkZWxheWVkIGluaXQgdGhlIGRlZmF1bHQuDQo+IA0K
PiBCZWNhdXNlLCBBRkFJQ1QsIHNldF9tdHJyX2Fwc19kZWxheWVkX2luaXQoKSBpcyBjYWxs
ZWQgYnkgZGVmYXVsdA0KPiBieSBuYXRpdmVfc21wX3ByZXBhcmVfY3B1cygpLiBXaGljaCBp
cyBjYWxsZWQgYnkgaHlwZXJ2IGFuZA0KPiBhcmNoL3g4Ni94ZW4vc21wX2h2bS5jLg0KPiAN
Cj4gVGhlIG9ubHkgb25lIHRoYXQncyBub3QgY2FsbGluZyBpdCBpcyBhcmNoL3g4Ni94ZW4v
c21wX3B2LmMgYnV0IHRoYXQNCj4gdGhpbmcgZG9lc24ndCBzdXBwb3J0IE1UUlJzIGluIHRo
ZSBmaXJzdCBwbGFjZSwgcmlnaHQ/DQoNCkNvcnJlY3QuDQoNCj4gV2hpY2ggbWVhbnMsIGl0
IGRvZXNuJ3QgbmVlZCBkZWxheWVkIE1UUlIgaW5pdCBhbnl3YXkuDQo+IA0KPiBXaGljaCB3
b3VsZCB0aGVuIG1lYW4gdGhhdCB0aGlzIHdvdWxkIHNpbXBsaWZ5IHRoaXMgdWdseSBsb2dp
YyBldmVuIG1vcmUuDQo+IA0KPiBPciBhbSBJIG1pc3NpbmcgYW4gYW5nbGU/DQoNClllczog
Y3B1IGhvdHBsdWcuDQoNCg0KSnVlcmdlbg0K
--------------QIMdqdxhoc6eaoR26OZpwXFP
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------QIMdqdxhoc6eaoR26OZpwXFP--

--------------NAwU7mueCQZjm0bbNAQSgXHr--

--------------g4zPUaP42ub5sZKf9GZVZKaU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMyzRIFAwAAAAAACgkQsN6d1ii/Ey91
DQf+NKU30kayLU8o3/EyM8meTT/5wW0H5PhkarzslPfRDl0x1X9Rm6/y61s80LK9tEImIUe9eXae
klpynQVpYHn2BMpbpAs1XzzESquyCRHdNUpuEnrt7bBnA6v0iHQZdCkd0ZyMveuo3BWlp8QDMPDt
rPKv3gcTRpTFJsI2EZowJBrmbmkYCcmRE5jNCj1cYV0cWPpzVTHtH3gRkomgevdCN9voUiyLEFNs
nwXz6gKOuA8L1dXGjHnokH3/5OAadXJ8MPeHK+TXbazMfDxEjNHdsxDu4CQ0hv+DJBNMdvXGjuMF
tnw737lk707pkj8gwKKO5Zdg4o+aTBHNVN+mX3Enxw==
=u8Td
-----END PGP SIGNATURE-----

--------------g4zPUaP42ub5sZKf9GZVZKaU--
