Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59D568E820
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:20:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372216322
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:20:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5B4F33881;
        Wed,  8 Feb 2023 06:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675837201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xUVtxn9umrXzehBMD41DrPKXaAGxasYqCfosQyD/eK8=;
        b=HfA/FSj9wV/OzBsFs5LwpKlTTzGbLV4urRJuzdmAdp5Ea0wZNSgHTDc/B3B/gcmmTym1g3
        ch+0ByBc+/P3RawpWTn7Hu98Fp/wIzfAX+1g8Q3pGgEGJjCd7VzNJUgPigL3ypsfAGRUAB
        t+36cB55mvP4eyDufeQhlGc6etw2gl8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54CD013425;
        Wed,  8 Feb 2023 06:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bb9XEhE/42PkUQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 08 Feb 2023 06:20:01 +0000
Message-ID: <59a24334-35c7-8afa-f35d-d654dd2823ba@suse.com>
Date:   Wed, 8 Feb 2023 07:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-5-jgross@suse.com>
 <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 4/6] x86/mtrr: don't let mtrr_type_lookup() return
 MTRR_TYPE_INVALID
In-Reply-To: <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YHUWG01nz1q0QiRhUkUaWZaE"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YHUWG01nz1q0QiRhUkUaWZaE
Content-Type: multipart/mixed; boundary="------------jw05tQmYZV4prZZSurJcGM5n";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <59a24334-35c7-8afa-f35d-d654dd2823ba@suse.com>
Subject: Re: [PATCH 4/6] x86/mtrr: don't let mtrr_type_lookup() return
 MTRR_TYPE_INVALID
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-5-jgross@suse.com>
 <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>
In-Reply-To: <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>

--------------jw05tQmYZV4prZZSurJcGM5n
Content-Type: multipart/mixed; boundary="------------1dvamWNPW6360J3a0VxgRLg5"

--------------1dvamWNPW6360J3a0VxgRLg5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDIuMjMgMTc6MjAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiBPbiBNb24sIEZl
YiA2LCAyMDIzIGF0IDExOjI5IFBNIEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gbXRycl90eXBlX2xvb2t1cCgpIHNob3VsZCBhbHdheXMgcmV0dXJu
IGEgdmFsaWQgbWVtb3J5IHR5cGUuIEluIGNhc2UNCj4+IHRoZXJlIGlzIG5vIGluZm9ybWF0
aW9uIGF2YWlsYWJsZSwgaXQgc2hvdWxkIHJldHVybiB0aGUgZGVmYXVsdCBVQy4NCj4gDQo+
IFdoeSBpc24ndCB0aGUgc2Vjb25kIGNhc2UgKGllIE1UUlJfU1RBVEVfTVRSUl9FTkFCTEVE
IG5vdCBiZWluZyBzZXQpDQo+IHJldHVybmluZyAnbXRycl9zdGF0ZS5kZWZfdHlwZScuIFRo
YXQncyB3aGF0IHRoZSBodyBkb2VzLCBubz8NCg0KQXJlIHlvdSBzdXJlPyBJbiB0aGUgU0RN
IEknbSByZWFkaW5nOg0KDQoqIEUgKE1UUlJzIGVuYWJsZWQpIGZsYWcsIGJpdCAxMSDigJQg
TVRSUnMgYXJlIGVuYWJsZWQgd2hlbiBzZXQ7IGFsbCBNVFJScyBhcmUNCiAgIGRpc2FibGVk
IHdoZW4gY2xlYXIsIGFuZCB0aGUgVUMgbWVtb3J5IHR5cGUgaXMgYXBwbGllZCB0byBhbGwg
b2YgcGh5c2ljYWwNCiAgIG1lbW9yeS4NCg0KU28gVUMgaXQgc2hvdWxkIGJlIElNSE8uDQoN
Cj4+IEF0IHRoZSBzYW1lIHRpbWUgdGhlIG10cnJfdHlwZV9sb29rdXAoKSBzdHViIGZvciB0
aGUgIUNPTkZJR19NVFJSDQo+PiBjYXNlIHNob3VsZCBzZXQgdW5pZm9ybSB0byAxLCBhcyBp
ZiB0aGUgbWVtb3J5IHJhbmdlIHdvdWxkIGJlDQo+PiBjb3ZlcmVkIGJ5IG5vIE1UUlIgYXQg
YWxsLg0KPiANCj4gLi4gYnV0IHlvdSBkaWRuJ3QgZG8gdGhhdCBmb3IgdGhlIENPTkZJR19N
VFJSLCBzbyBub3cgdGhleSByZXR1cm4NCj4gTVRSUl9UWVBFX1VOQ0FDSEFCTEUsIGJ1dCBk
b24ndCBzZXQgdW5pZm9ybT0xLg0KDQpJIGFncmVlIHRoYXQgc2V0dGluZyB1bmlmb3JtIHNo
b3VsZCBiZSBkb25lIGF0IGxlYXN0IGZvciB0aGUgY2FzZSBvZiBub3QNCmVuYWJsZWQgTVRS
UnMuDQoNClRoZSBjYXNlIG9mICFtdHJyX3N0YXRlX3NldCBpcyBkaWZmZXJlbnQsIGFzIHRo
ZSBkYXRhIHJlZ2FyZGluZyBzZXR0aW5nDQp1bmlmb3JtIGlzbid0IGtub3duIHlldC4gT1RP
SCB0aGVyZSBpcyBubyBjYWxsZXIgb2YgbXRycl90eXBlX2xvb2t1cCgpDQppbnRlcmVzdGVk
IGluIHRoZSB1bmlmb3JtIHNldHRpbmcgc28gZWFybHkgaW4gYm9vdCwgc28gSSBndWVzcyBu
b3QNCnNldHRpbmcgaXQgaXMgZmluZSAoc2V0dGluZyBpdCB3b3VsZCBiZSBva2F5IGZvciB0
aGUgc2FtZSByZWFzb24sIGJ1dA0KaXQgd291bGQgYmUgdGVjaG5pY2FsbHkgd3JvbmcgSU1P
KS4NCg0KDQpKdWVyZ2VuDQo=
--------------1dvamWNPW6360J3a0VxgRLg5
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1dvamWNPW6360J3a0VxgRLg5--

--------------jw05tQmYZV4prZZSurJcGM5n--

--------------YHUWG01nz1q0QiRhUkUaWZaE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPjPxAFAwAAAAAACgkQsN6d1ii/Ey8c
Rwf7Bps5pZL63eoac5a5JEr+jmbQ3Wjb6UQrfZ4QxH60htGKX/tIosm6k7rnveqNDB4YkaEbxlUe
v9sTc2gKeEXK+E7oPXOPttyg6iUyi3wP75RDyLZ24lM1lCFB9TaHeV7WVx9Uf7yidZBljGQsJUkX
7CZMYhnz2MPoh5FvKiSVRR3AE3KyHfbtUYW29sV9tW5wqK/3ufVIhshLYkWDxhv4MUvFvLWPNG37
BHuxZ78ihi5cE1ijW+kjrFyNpxaOrV/FO+0TVvcg8cKNWbUPf5qsF8MRm4qc6a5by9DxgF6iANM6
bEJLRaYigrceNbAuLlo11hI3+TanBYrTUHWPqptQBA==
=rlMC
-----END PGP SIGNATURE-----

--------------YHUWG01nz1q0QiRhUkUaWZaE--
