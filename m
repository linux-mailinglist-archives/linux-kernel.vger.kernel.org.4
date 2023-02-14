Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89FB695EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjBNJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBNJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:17:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998FA12599
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:17:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F6D221A3C;
        Tue, 14 Feb 2023 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676366233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkpGixPuFTSezTeMtSkek1NPGQfDYOVi1Bi5+Jov7fg=;
        b=uQslx2LflRJitvCeIchGLcDuph4SOz/6UxeYPUpItddeSK1u2799/+kGc63BiOX7t62eHD
        K9RGH+VTGiEV2PPmvSexFptqDwiLk/X3l047lUhrbxe+jlPu/gjdZxszPK0BXum1lguTQT
        P4zUA8h3tKmTwa9lFrSXpfsMYO+YSNI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05CDA138E3;
        Tue, 14 Feb 2023 09:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r0WRO5hR62PgPwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Feb 2023 09:17:12 +0000
Message-ID: <807cca5b-06b9-da85-738b-d88fc10298cb@suse.com>
Date:   Tue, 14 Feb 2023 10:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <6257114d-a957-f586-145c-d2a885417360@suse.com>
 <Y+pRK6a419jenR9R@zn.tnic> <Y+pTDFQlX9qNL35z@zn.tnic>
 <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com> <Y+pZ5ccprqequvpE@zn.tnic>
 <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com> <Y+qHMsZhYaYEmtTo@zn.tnic>
 <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com> <Y+tNQvpXdOAfZztQ@zn.tnic>
 <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com> <Y+tP7fvvSFSSCznH@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
In-Reply-To: <Y+tP7fvvSFSSCznH@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------A001yQ1aenwvwoOIj5ATQ5H4"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------A001yQ1aenwvwoOIj5ATQ5H4
Content-Type: multipart/mixed; boundary="------------0GGggdQYEr1vnuniTzq9DBd0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <807cca5b-06b9-da85-738b-d88fc10298cb@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <6257114d-a957-f586-145c-d2a885417360@suse.com>
 <Y+pRK6a419jenR9R@zn.tnic> <Y+pTDFQlX9qNL35z@zn.tnic>
 <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com> <Y+pZ5ccprqequvpE@zn.tnic>
 <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com> <Y+qHMsZhYaYEmtTo@zn.tnic>
 <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com> <Y+tNQvpXdOAfZztQ@zn.tnic>
 <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com> <Y+tP7fvvSFSSCznH@zn.tnic>
In-Reply-To: <Y+tP7fvvSFSSCznH@zn.tnic>

--------------0GGggdQYEr1vnuniTzq9DBd0
Content-Type: multipart/mixed; boundary="------------Twp7FuWpfzuMc0jo8NxTrqtN"

--------------Twp7FuWpfzuMc0jo8NxTrqtN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDIuMjMgMTA6MTAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBG
ZWIgMTQsIDIwMjMgYXQgMTA6MDI6NTFBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEkganVzdCBkb24ndCBsaWtlIHRoZSBpZGVhIG9mIHRyeWluZyB0byBjYXRjaCBhbGwg
cG9zc2libGUgbWlzdXNlcyBpbg0KPj4gbG93ZXIgbGV2ZWxzLCBhdCB0aGUgc2FtZSB0aW1l
IGludHJvZHVjaW5nIHRoZSBuZWVkIHRvIG1vZGlmeSB0aG9zZQ0KPj4gdGVzdHMgaW4gY2Fz
ZSBhIG5ldyB2YWxpZCB1c2UgY2FzZSBpcyBwb3BwaW5nIHVwLg0KPiANCj4gU28gd2hhdCB3
b3VsZCB5b3UgZG86IGdlbmVyYWxseSBhbGxvdyB0aGlzIHNvIHRoYXQgcG90ZW50aWFsbHkg
b3RoZXINCj4gZ3Vlc3QgY29uZmlndXJhdGlvbnMgbWlzdXNlIGl0Pw0KDQpJIGd1ZXNzIHRo
aXMgbGFyZ2VseSBkZXBlbmRzIG9uIHRoZSBmdW5jdGlvbmFsaXR5LiBJIGRvbid0IHNlZSB3
aHkgYW55b25lDQp3b3VsZCB0cnkgdG8gdXNlIE1UUlIgb3ZlcndyaXRlIGZ1bmN0aW9uYWxp
dHkgd2l0aG91dCByZWFsbHkgbmVlZGluZyBpdC4NCg0KQnV0IG1heWJlIEknbSB3cm9uZyBo
ZXJlIGFuZCBJJ20gdW5kZXItZXN0aW1hdGluZyB0aGUgImNyZWF0aXZpdHkiIG9mDQprZXJu
ZWwgaGFja2Vycy4NCg0KPiBBbmQgd2hlbiB3ZSBkZWNpZGUgdG8gY2hhbmdlIGl0LCBhbGwg
dGhvc2UgdXNlcnMgd2lsbCBjb21lIHJ1bm5pbmcgYW5kDQo+IGNvbXBsYWluaW5nIHRoYXQg
d2UgYnJva2UgaXQ/DQo+IA0KPiBBbmQgdGhlbiB3ZSdyZSBzdHVjayB3aXRoIGEgbmFzdHkg
d29ya2Fyb3VuZCBpbiB0aGUgdHJlZSBiZWNhdXNlIHdlIGhhdmUNCj4gdG8gc3VwcG9ydCB0
aGVtIHRvbz8NCj4gDQo+IFNlZSwgYWxsIHdlIGRvIGhlcmUgaXMgYmVjYXVzZSBvZiBzdWNo
IG1pc2d1aWRlZCAob3IgbWF5YmUgZGlkbid0IGtub3cNCj4gYmV0dGVyKSBkZWNpc2lvbnMg
d2hpY2ggaGF2ZSBoYXBwZW5lZCBhIGxvbmcgdGltZSBhZ28uDQoNCkkgY2FuIHNlZSB5b3Vy
IHBvaW50Lg0KDQpNYXliZSBJIGhhdmVuJ3Qgc2VlbiBlbm91Z2ggY3JhenkgaGFja3MgeWV0
LiA6LSkNCg0KTm8gbmVlZCB0byBmdXJ0aGVyIGRpc2N1c3MgdGhpcyB0b3BpYyBmcm9tIG15
IHNpZGUsIGFzIEkgaGF2ZSB2b2ljZWQgbXkNCm9waW5pb24gYW5kIHlvdSBkaWQgc28sIHRv
by4gSSB3aWxsIGFkZCB0aGUgdGVzdHMgeW91IGFyZSBhc2tpbmcgZm9yLg0KDQoNCkp1ZXJn
ZW4NCg==
--------------Twp7FuWpfzuMc0jo8NxTrqtN
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Twp7FuWpfzuMc0jo8NxTrqtN--

--------------0GGggdQYEr1vnuniTzq9DBd0--

--------------A001yQ1aenwvwoOIj5ATQ5H4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPrUZgFAwAAAAAACgkQsN6d1ii/Ey/0
8wf/Si5n6CP23mzBrwPLsZ4l0Q6OXs34o6q0y8f0D6h9RNlXZbpC4Zu3NpK6is2/ud7b/4ssl4Ti
nNlZjnFPCFpYEzlnLb4GgHeR0hARo87SCCG58txON6mhLZiv3S4gnz8/7AT1YeOLQ8/eVYkqz2+Q
7kp/WGfK2PJN/RH4bV+RU669pxIIB2rCRM94IZcvzITHmnvX98aAwDBON9ZT15aOZ1Sw3OiY8p09
jjonqc4b3E6cBSlqT6UlHG6wR3rIP9FzCyu2CxO7dV7FydekcHUVmecy5fI+ZaQ54EgBU1Mws8om
AdUMX2X4/m+NXAPr17eFYmS1bPf2nIEAgOVbMRpO/w==
=3GwQ
-----END PGP SIGNATURE-----

--------------A001yQ1aenwvwoOIj5ATQ5H4--
