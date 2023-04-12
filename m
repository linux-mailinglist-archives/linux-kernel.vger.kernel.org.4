Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387C6DF1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDLKZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDLKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:25:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793746A78
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:25:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36CD31F6E6;
        Wed, 12 Apr 2023 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681295102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XG+1Xbp26fkiUaredRvGGa6A0c7Rq35i97tuNyl6amg=;
        b=m9EsDvKXKDw4Vwnc2asfsGFpOKEd+1INnddJi7BkPNMWzjbZ4EJVqXsIiF00I+lZcBu5cY
        uE1VzwtwrYgrVLTLh+wAM+H2GXWavYQ5xYY0CeRGDsYgISXVmnwy7twlzTbAbTEDixLYxc
        z+NE8NbzCDyNGZBuH6eMgFOEqxVE9ac=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7478132C7;
        Wed, 12 Apr 2023 10:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6m5ENv2GNmTCGAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 12 Apr 2023 10:25:01 +0000
Message-ID: <5e75d8ed-6950-1c16-02eb-1894b90bfffc@suse.com>
Date:   Wed, 12 Apr 2023 12:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 07/15] x86/mtrr: replace vendor tests in MTRR code
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-8-jgross@suse.com>
 <20230412084541.GIZDZvtcMnWYJ7Kh6a@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230412084541.GIZDZvtcMnWYJ7Kh6a@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rP2bLboDrdHC193A0qrLsOJM"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rP2bLboDrdHC193A0qrLsOJM
Content-Type: multipart/mixed; boundary="------------iiZEXn4fxKbVh50FCppWvlMP";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <5e75d8ed-6950-1c16-02eb-1894b90bfffc@suse.com>
Subject: Re: [PATCH v5 07/15] x86/mtrr: replace vendor tests in MTRR code
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-8-jgross@suse.com>
 <20230412084541.GIZDZvtcMnWYJ7Kh6a@fat_crate.local>
In-Reply-To: <20230412084541.GIZDZvtcMnWYJ7Kh6a@fat_crate.local>

--------------iiZEXn4fxKbVh50FCppWvlMP
Content-Type: multipart/mixed; boundary="------------Hc8jQcf2jMXpMCZsnrmmikk2"

--------------Hc8jQcf2jMXpMCZsnrmmikk2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDQuMjMgMTA6NDUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
cHIgMDEsIDIwMjMgYXQgMDg6MzY6NDRBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE1vZGVybiBDUFVzIGFsbCBzaGFyZSB0aGUgc2FtZSBNVFJSIGludGVyZmFjZSBpbXBs
ZW1lbnRlZCB2aWENCj4+IGdlbmVyaWNfbXRycl9vcHMuDQo+Pg0KPj4gQXQgc2V2ZXJhbCBw
bGFjZXMgaW4gTVRSUiBjb2RlIHRoaXMgZ2VuZXJpYyBpbnRlcmZhY2UgaXMgZGVkdWNlZCB2
aWENCj4+IGlzX2NwdShJTlRFTCkgdGVzdHMsIHdoaWNoIGlzIG9ubHkgd29ya2luZyBkdWUg
dG8gWDg2X1ZFTkRPUl9JTlRFTA0KPj4gYmVpbmcgMCAodGhlIGlzX2NwdSgpIG1hY3JvIGlz
IHRlc3RpbmcgbXRycl9pZi0+dmVuZG9yLCB3aGljaCBpc24ndA0KPj4gZXhwbGljaXRseSBz
ZXQgaW4gZ2VuZXJpY19tdHJyX29wcykuDQo+Pg0KPj4gRml4IHRoYXQgYnkgcmVwbGFjaW5n
IHRoZSBpc19jcHUoSU5URUwpIHRlc3RzIHdpdGggdGVzdGluZyBmb3IgbXRycl9pZg0KPj4g
dG8gYmUgJmdlbmVyaWNfbXRycl9vcHMuDQo+IA0KPiBSZXBsYWNlIHdpdGg6DQo+IA0KPiAi
VGVzdCB0aGUgZ2VuZXJpYyBDUFUgZmVhdHVyZSBYODZfRkVBVFVSRV9NVFJSIGluc3RlYWQu
Ig0KPiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5j
IGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4gaW5kZXggMWMxOWQ2N2Rk
YWIzLi40NmFhZTY5ZDI1OWUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1
L210cnIvbXRyci5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5j
DQo+PiBAQCAtMTA4LDE0ICsxMDgsMTIgQEAgc3RhdGljIGludCBoYXZlX3dyY29tYih2b2lk
KQ0KPj4gICAvKiAgVGhpcyBmdW5jdGlvbiByZXR1cm5zIHRoZSBudW1iZXIgb2YgdmFyaWFi
bGUgTVRSUnMgICovDQo+PiAgIHN0YXRpYyB2b2lkIF9faW5pdCBzZXRfbnVtX3Zhcl9yYW5n
ZXMoYm9vbCB1c2VfZ2VuZXJpYykNCj4+ICAgew0KPj4gLQl1bnNpZ25lZCBsb25nIGNvbmZp
ZyA9IDAsIGR1bW15Ow0KPj4gKwl1bnNpZ25lZCBsb25nIGNvbmZpZywgZHVtbXk7DQo+PiAg
IA0KPj4gICAJaWYgKHVzZV9nZW5lcmljKQ0KPj4gICAJCXJkbXNyKE1TUl9NVFJSY2FwLCBj
b25maWcsIGR1bW15KTsNCj4+IC0JZWxzZSBpZiAoaXNfY3B1KEFNRCkgfHwgaXNfY3B1KEhZ
R09OKSkNCj4+IC0JCWNvbmZpZyA9IDI7DQo+PiAtCWVsc2UgaWYgKGlzX2NwdShDWVJJWCkg
fHwgaXNfY3B1KENFTlRBVVIpKQ0KPj4gLQkJY29uZmlnID0gODsNCj4+ICsJZWxzZQ0KPj4g
KwkJY29uZmlnID0gbXRycl9pZi0+dmFyX3JlZ3M7DQo+PiAgIA0KPj4gICAJbnVtX3Zhcl9y
YW5nZXMgPSBjb25maWcgJiBNVFJSX0NPTkZJR19OVU1fVkFSX01BU0s7DQo+PiAgIH0NCj4g
DQo+ICBGcm9tIHByZXZpb3VzIHJldmlldyB3aGljaCB5b3UndmUgbWlzc2VkIHRvIGluY29y
cG9yYXRlOg0KPiANCj4gIlNpbmNlIHlvdSdyZSB0b3VjaGluZyB0aGlzIGZ1bmN0aW9uLCB5
b3UgbWlnaHQgc2ltcGx5IGV4cGFuZCBpdHMgYm9keSBpbg0KPiBpdHMgb25seSBjYWxsIHNp
dGUgaW4gbXRycl9icF9pbml0KCksIHB1dCBhIGNvbW1lbnQgYWJvdmUgdGhlIGV4cGFuZGVk
DQo+IGNvZGUgYW5kIHJlbW92ZSB0aGF0IGZ1bmN0aW9uLg0KPiANCj4gVGhhdCBpcywgaWYg
d2UncmUgZ29pbmcgdG8gZG8gdGhlIC0+dmFyX3JlZ3MgdGhpbmcuIg0KPiANCg0KT2gsIHNv
cnJ5LiBXaWxsIGRvIGl0Lg0KDQoNCkp1ZXJnZW4NCg==
--------------Hc8jQcf2jMXpMCZsnrmmikk2
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Hc8jQcf2jMXpMCZsnrmmikk2--

--------------iiZEXn4fxKbVh50FCppWvlMP--

--------------rP2bLboDrdHC193A0qrLsOJM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ2hv0FAwAAAAAACgkQsN6d1ii/Ey98
sAgAg2B/LB2qGeNC9eYHsAPK94utR4kq/M9RZUhtZksmeCYUh3OFz5oWRdoHocpLaxBm8unWBmMj
NczqWai0hGVpWJllbQb7Hq3ERyrxvCmqk81WnMKYFkUbX8D98bNNHR6d48/wTMyEO+nunX1AohGj
m3/3kSPFOG9ErxgupVBiHFjVrXUuQ2QcBvlmJ+cTOHnvVApIbddn9Qh0wXpoIMchUFlKuLdjukQC
jVK7Ma6HHNSLtKgxcZ+7w7RSe/HFaLyv7rZQMWvhwLnmTHDbsHSZ+G6U3eGNESYYHvaLEkWLQ/uj
GNa3KdwUuYYIKaakReH4iFolNzV44g2Kw+uWWvo6UQ==
=fwIo
-----END PGP SIGNATURE-----

--------------rP2bLboDrdHC193A0qrLsOJM--
