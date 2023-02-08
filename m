Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7868F1DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjBHPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjBHPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:19:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD746171
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:19:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F74C33787;
        Wed,  8 Feb 2023 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675869583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDm+fjVYOSCsC+Kqr6Ej60x9OKUWUo1fnESWPYLvrcs=;
        b=ZZrWL7USYEiToVEbmASXVjuU0HQB0j8AZng8iz5mzo2sWEHdLPJ+JzF2UmH4Caw+DfkJHC
        NkvAdTAYZiLlya78FNVe3xK5Vo56DFNDnWnmksYZAFOExkDOTUv0z1TGeVbzf+DHXVeAOW
        r80k7aPj7OqWUlDNnSIXxgI9msEviV8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A97F913425;
        Wed,  8 Feb 2023 15:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FwVLJ46942PUPAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 08 Feb 2023 15:19:42 +0000
Message-ID: <6b833946-3932-11ef-173a-f1d29f4ec137@suse.com>
Date:   Wed, 8 Feb 2023 16:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] x86/mtrr: fix handling with PAT but without MTRR
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230207072902.5528-1-jgross@suse.com>
 <BYAPR21MB16886C389C45912DB4EBA362D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB16886C389C45912DB4EBA362D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5Q0esvM5r0LTLGoorfhLgP72"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5Q0esvM5r0LTLGoorfhLgP72
Content-Type: multipart/mixed; boundary="------------ve1TI2GZCEUs0mBGwE0S20Ck";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <6b833946-3932-11ef-173a-f1d29f4ec137@suse.com>
Subject: Re: [PATCH 0/6] x86/mtrr: fix handling with PAT but without MTRR
References: <20230207072902.5528-1-jgross@suse.com>
 <BYAPR21MB16886C389C45912DB4EBA362D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16886C389C45912DB4EBA362D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------ve1TI2GZCEUs0mBGwE0S20Ck
Content-Type: multipart/mixed; boundary="------------4S27xQCE5CTmcvemGWRA40OD"

--------------4S27xQCE5CTmcvemGWRA40OD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMDIuMjMgMTY6MDgsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogTW9uZGF5LCBGZWJy
dWFyeSA2LCAyMDIzIDExOjI5IFBNDQo+Pg0KPj4gVGhpcyBzZXJpZXMgdHJpZXMgdG8gZml4
IHRoZSByYXRoZXIgc3BlY2lhbCBjYXNlIG9mIFBBVCBiZWluZyBhdmFpbGFibGUNCj4+IHdp
dGhvdXQgaGF2aW5nIE1UUlJzIChlaXRoZXIgZHVlIHRvIENPTkZJR19NVFJSIGJlaW5nIG5v
dCBzZXQsIG9yDQo+PiBiZWNhdXNlIHRoZSBmZWF0dXJlIGhhcyBiZWVuIGRpc2FibGVkIGUu
Zy4gYnkgYSBoeXBlcnZpc29yKS4NCj4+DQo+PiBUaGUgbWFpbiB1c2UgY2FzZXMgYXJlIFhl
biBQViBndWVzdHMgYW5kIFNFVi1TTlAgZ3Vlc3RzIHJ1bm5pbmcgdW5kZXINCj4+IEh5cGVy
LVYuDQo+Pg0KPj4gUGF0Y2ggMiBzZWVtcyB0byBiZSBhIGxpdHRsZSBoYWNreSwgYXMgaXQg
c3BlY2lhbCBjYXNlcyBvbmx5DQo+PiBtZW10eXBlX3Jlc2VydmUoKSBhbmQgbWVtdHlwZV9m
cmVlKCksIGJ1dCBPVE9IIHRoaXMgZG9lc24ndCBzZWVtIHRvDQo+PiBiZSB3b3JzZSB0aGFu
IGluIHByZXZpb3VzIGRheXMsIHdoZXJlIFBBVCB3YXMgZGlzYWJsZWQgd2hlbiBNVFJScw0K
Pj4gaGF2ZW4ndCBiZWVuIGF2YWlsYWJsZS4NCj4+DQo+PiBNeSB0ZXN0cyB3aXRoIFhlbiBk
aWRuJ3Qgc2hvdyBhbnkgcHJvYmxlbXMsIGJ1dCBJJ20gcmF0aGVyIHN1cmUgSQ0KPj4gY291
bGRuJ3QgY292ZXIgYWxsIGNvcm5lciBjYXNlcy4NCj4gDQo+IEkgdGVzdGVkIHRoaXMgcGF0
Y2ggc2V0IHdpdGggSHlwZXItViBTRVYtU05QIGd1ZXN0cywgYW5kIGlvcmVtYXBfY2FjaGUo
KQ0KPiBpcyBjb3JyZWN0bHkgbWFwcGluZyBhcyBXQi4NCj4gDQo+IEFzIGFuIG9ic2VydmF0
aW9uLCB3aXRoIGNvbW1pdCA5MGI5MjZlNjhmNTAgaXQgd2FzIG5pY2UgdG8gaGF2ZQ0KPiB0
aGUgbWVtdHlwZSBlbnRyaWVzIGNyZWF0ZWQuICBJIGNvdWxkIGNoZWNrIGZvciBhbnkgdW5l
eHBlY3RlZA0KPiBtYXBwaW5ncyBpbiAvc3lzL2tlcm5lbC9kZWJ1Zy94ODYvcGF0X21lbXR5
cGVfbGlzdC4gIFdpdGggdGhpcyBwYXRjaA0KPiBzZXQsIHdlJ3JlIGJhY2sgdG8gbm90IGNy
ZWF0aW5nIHRob3NlIGVudHJpZXMuDQoNCkknbSBjdXJyZW50bHkgbG9va2luZyBpbnRvIHRo
ZSBzb2x1dGlvbiBtZW50aW9uZWQgYmVsb3cuIFRoaXMgbWlnaHQgdHVybg0Kb3V0IHRvIGJl
IG11Y2ggY2xlYW5lci4NCg0KPiANCj4gTWljaGFlbA0KPiANCj4+DQo+PiBUaGUgb25seSBj
bGVhbmVyIHNvbHV0aW9uIEkgY291bGQgdGhpbmsgb2Ygd291bGQgYmUgdG8gaW50cm9kdWNl
IE1UUlINCj4+IHJlYWQtb25seSBhY2Nlc3MuIEl0IHdvdWxkIHRoZW9yZXRpY2FsbHkgYmUg
cG9zc2libGUgdG8gZ2V0IHRoZSBhY3R1YWwNCj4+IE1UUlIgY29udGVudHMgZm9yIHRoZSB2
YXJpYWJsZSBNVFJScyBmcm9tIFhlbiwgYnV0IEknbSBub3Qgc3VyZSB0aGlzDQo+PiBpcyBy
ZWFsbHkgdGhlIHdheSB0byBnby4NCj4+DQo+PiBGb3IgdGhlIFNFVi1TTlAgY2FzZSB3aXRo
IEh5cGVyLVYgSSBndWVzcyBzdWNoIGEgcmVhZC1vbmx5IG1vZGUgY291bGQNCj4+IGJlIHJh
dGhlciBzaW1wbGUsIGJ1dCBJJ20gcmVhbGx5IG5vdCBzdXJlIHRoaXMgd291bGQgY292ZXIg
YWxsIG5lZWRlZA0KPj4gY29ybmVyIGNhc2VzIChJJ2QgYmFzaWNhbGx5IHNheSBhbHdheXMg
IldCIiBpbiB0aGF0IGNhc2UpLg0KDQoNCkp1ZXJnZW4NCg0K
--------------4S27xQCE5CTmcvemGWRA40OD
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------4S27xQCE5CTmcvemGWRA40OD--

--------------ve1TI2GZCEUs0mBGwE0S20Ck--

--------------5Q0esvM5r0LTLGoorfhLgP72
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPjvY4FAwAAAAAACgkQsN6d1ii/Ey8P
ogf+OA/bpBbuwJqWU6Vulhf/STYUQXrYN6Q23W8lp5FcuYBbLb5vGWQV7aGpjU0zOSFT2sUR852V
N4A3GggFdTi5h3dHx3fXmZU+SYXm5RtOjW5Bf5oUcOeX5y1Lcm44POTo55tFI9oJw2qJ5XTjW1Fu
Li73Irkc1FyLlyC/bLUC0bVjeg2ZZRuIEEPG8/rkLN9Ta4iA3+0pKY8EV+sdeGzV5XC3r+9ybBUE
CeN3bVPFqQ5odw20xUMzF1X5MxFAu840KAhCTrgYgayciLJX/8okUBQOvbQLSsVzKSyGM3shqfVv
zgIlf4HXeGAr/3rmbp0S5KffWDEQRM85ag0lBFNlFg==
=O+Bk
-----END PGP SIGNATURE-----

--------------5Q0esvM5r0LTLGoorfhLgP72--
