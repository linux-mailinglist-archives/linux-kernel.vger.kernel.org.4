Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7EE6D3DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDCHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjDCHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:10:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357AF748
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:10:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52556219C2;
        Mon,  3 Apr 2023 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680505811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjRTZJ6W1r6Mkvpg5Nf/4MISmQ/2Ed0dEVEG2QMv8w4=;
        b=tiwPhFMyflJ9Uvq2CRktjBPsGNvFzO/vUAfS7jKJm75qDSUEa8bX3tmRtvcx8mA7eWuK4d
        ZfVgUhvrZCuslpPx7cwctNM/+Iobroesik8VuVXACu83lb9qtldvNcuWp91P1kuLNbAU5P
        8QqjbBfvhWnZuIR4lswuubKb/OdouD8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED7C413416;
        Mon,  3 Apr 2023 07:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ddYSONJ7KmQqFwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 03 Apr 2023 07:10:10 +0000
Message-ID: <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
Date:   Mon, 3 Apr 2023 09:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------07JgIE6kie0TtisQQdz5ml4x"
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------07JgIE6kie0TtisQQdz5ml4x
Content-Type: multipart/mixed; boundary="------------oRzSpGNiqIWizF0gE2rb0ZKy";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Huang, Kai" <kai.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Message-ID: <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
In-Reply-To: <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>

--------------oRzSpGNiqIWizF0gE2rb0ZKy
Content-Type: multipart/mixed; boundary="------------UCKxb0dJikt3Oy8LDajL0C9J"

--------------UCKxb0dJikt3Oy8LDajL0C9J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDQuMjMgMDQ6MjUsIEh1YW5nLCBLYWkgd3JvdGU6DQo+IE9uIFNhdCwgMjAyMy0w
NC0wMSBhdCAwODozNiArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+ICsvKioNCj4+
ICsgKiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSAtIHNldCBzdGF0aWMgTVRSUiBzdGF0ZQ0KPj4g
KyAqDQo+PiArICogVXNlZCB0byBzZXQgTVRSUiBzdGF0ZSB2aWEgZGlmZmVyZW50IG1lYW5z
IChlLmcuIHdpdGggZGF0YSBvYnRhaW5lZCBmcm9tDQo+PiArICogYSBoeXBlcnZpc29yKS4N
Cj4+ICsgKiBJcyBhbGxvd2VkIG9ubHkgZm9yIHNwZWNpYWwgY2FzZXMgd2hlbiBydW5uaW5n
IHZpcnR1YWxpemVkLiBNdXN0IGJlIGNhbGxlZA0KPj4gKyAqIGZyb20gdGhlIHg4Nl9pbml0
Lmh5cGVyLmluaXRfcGxhdGZvcm0oKSBob29rLg0KPj4gKyAqLw0KPj4gK3ZvaWQgbXRycl9v
dmVyd3JpdGVfc3RhdGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2YXIsIHVuc2lnbmVkIGlu
dCBudW1fdmFyLA0KPj4gKwkJCcKgIG10cnJfdHlwZSBkZWZfdHlwZSkNCj4+ICt7DQo+PiAr
CXVuc2lnbmVkIGludCBpOw0KPj4gKw0KPj4gKwkvKiBPbmx5IGFsbG93ZWQgdG8gYmUgY2Fs
bGVkIG9uY2UgYmVmb3JlIG10cnJfYnBfaW5pdCgpLiAqLw0KPj4gKwlpZiAoV0FSTl9PTiht
dHJyX3N0YXRlX3NldCkpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCS8qIE9ubHkgYWxs
b3dlZCB3aGVuIHJ1bm5pbmcgdmlydHVhbGl6ZWQuICovDQo+PiArCWlmICghY3B1X2ZlYXR1
cmVfZW5hYmxlZChYODZfRkVBVFVSRV9IWVBFUlZJU09SKSkNCj4+ICsJCXJldHVybjsNCj4+
ICsNCj4+ICsJLyoNCj4+ICsJICogT25seSBhbGxvd2VkIGZvciBzcGVjaWFsIHZpcnR1YWxp
emF0aW9uIGNhc2VzOg0KPj4gKwkgKiAtIHdoZW4gcnVubmluZyBhcyBTRVYtU05QIGd1ZXN0
DQo+PiArCSAqIC0gd2hlbiBydW5uaW5nIGFzIEh5cGVyLVYgaXNvbGF0ZWQgZ3Vlc3QNCj4+
ICsJICogLSB3aGVuIHJ1bm5pbmcgYXMgWGVuIFBWIGd1ZXN0DQo+PiArCSAqIC0gd2hlbiBy
dW5uaW5nIGFzIFRTWCBndWVzdA0KPiAJCQkgICAgIF4NCj4gCQkJICAgICBURFggZ3Vlc3QN
Cg0KVGhhbmtzLg0KDQo+IA0KPj4gKwkgKi8NCj4+ICsJaWYgKCFjY19wbGF0Zm9ybV9oYXMo
Q0NfQVRUUl9HVUVTVF9TRVZfU05QKSAmJg0KPj4gKwnCoMKgwqAgIWh2X2lzX2lzb2xhdGlv
bl9zdXBwb3J0ZWQoKSAmJg0KPj4gKwnCoMKgwqAgIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2
X0ZFQVRVUkVfWEVOUFYpICYmDQo+PiArCcKgwqDCoCAhY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwkvKiBE
aXNhYmxlIE1UUlIgaW4gb3JkZXIgdG8gZGlzYWJsZSBNVFJSIG1vZGlmaWNhdGlvbnMuICov
DQo+PiArCXNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfTVRSUik7DQo+PiArDQo+
PiArCWlmICh2YXIpIHsNCj4+ICsJCWlmIChudW1fdmFyID4gTVRSUl9NQVhfVkFSX1JBTkdF
Uykgew0KPj4gKwkJCXByX3dhcm4oIlRyeWluZyB0byBvdmVyd3JpdGUgTVRSUiBzdGF0ZSB3
aXRoICV1IHZhcmlhYmxlIGVudHJpZXNcbiIsDQo+PiArCQkJCW51bV92YXIpOw0KPj4gKwkJ
CW51bV92YXIgPSBNVFJSX01BWF9WQVJfUkFOR0VTOw0KPj4gKwkJfQ0KPj4gKwkJZm9yIChp
ID0gMDsgaSA8IG51bV92YXI7IGkrKykNCj4+ICsJCQltdHJyX3N0YXRlLnZhcl9yYW5nZXNb
aV0gPSB2YXJbaV07DQo+PiArCQludW1fdmFyX3JhbmdlcyA9IG51bV92YXI7DQo+PiArCX0N
Cj4+ICsNCj4+ICsJbXRycl9zdGF0ZS5kZWZfdHlwZSA9IGRlZl90eXBlOw0KPj4gKwltdHJy
X3N0YXRlLmVuYWJsZWQgfD0gTVRSUl9TVEFURV9NVFJSX0VOQUJMRUQ7DQo+PiArDQo+PiAr
CW10cnJfc3RhdGVfc2V0ID0gMTsNCj4+ICt9DQo+PiArDQo+PiAgwqAvKioNCj4+ICDCoCAq
IG10cnJfdHlwZV9sb29rdXAgLSBsb29rIHVwIG1lbW9yeSB0eXBlIGluIE1UUlINCj4+ICDC
oCAqDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+IGluZGV4IDFiZWIzOGY3YTdh
My4uMWMxOWQ2N2RkYWIzIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9t
dHJyL210cnIuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0K
Pj4gQEAgLTY2Niw2ICs2NjYsMTUgQEAgdm9pZCBfX2luaXQgbXRycl9icF9pbml0KHZvaWQp
DQo+PiAgwqAJY29uc3QgY2hhciAqd2h5ID0gIihub3QgYXZhaWxhYmxlKSI7DQo+PiAgwqAJ
dW5zaWduZWQgaW50IHBoeXNfYWRkcjsNCj4+ICAgDQo+PiArCWlmICghZ2VuZXJpY19tdHJy
cyAmJiBtdHJyX3N0YXRlLmVuYWJsZWQpIHsNCj4+ICsJCS8qIFNvZnR3YXJlIG92ZXJ3cml0
ZSBvZiBNVFJSIHN0YXRlLCBvbmx5IGZvciBnZW5lcmljIGNhc2UuICovDQo+IAkJCQkJCQkg
ICAgICBeDQo+IAkJCQkJCQkgICAgICAhZ2VuZXJpYyBjYXNlPw0KDQpOby4gVGhpcyB0ZXN0
IGp1c3QgdmVyaWZpZXMgdGhhdCB0aGUgKHZpc2libGUpIE1UUlIgZmVhdHVyZSBpcyBzd2l0
Y2hlZCBvZmYsDQphcyB0aGVyZSBhcmUgbm8gd2F5cyB0byBtb2RpZnkgYW55IE1UUlIgcmVn
aXN0ZXJzIGluIHRoZSBvdmVyd3JpdGUgY2FzZS4NCg0KSSBjYW4gbWFrZSB0aGlzIG1vcmUg
b2J2aW91cyBpbiBhIGNvbW1lbnQuDQoNCg0KSnVlcmdlbg0K
--------------UCKxb0dJikt3Oy8LDajL0C9J
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------UCKxb0dJikt3Oy8LDajL0C9J--

--------------oRzSpGNiqIWizF0gE2rb0ZKy--

--------------07JgIE6kie0TtisQQdz5ml4x
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQqe9IFAwAAAAAACgkQsN6d1ii/Ey9f
Awf/TPJCvvB3ndk+s+0gUqef4pj0WvP43Zk4DtyMuShFvwysaEweu5lf7a+vavTCV5l4pV9AmhIj
oS6G9MjZ50d28vpOLf6iDORQzFfQb/72sCiyyPktPhhd8CzrELIrPxSDSdw1Og8lbBWNWtNFPHIl
xS6G9c8SFXXl6YQCQs2Wa0Kel/N6FMxx8hsx/9+3d9Yvp8mu2IJZatlcsCZqsRHeuiOcGgQJ58Wi
Qi8oNvJvlNqKfuGl+2/suKHyK3trZCvcruylGPzUbNdb9HzHnq4ifqySxaiCn+O9zHSW9uZ/y8Eq
vTt1yKD8KtxS3ZD3lomzRx02caUI0kPciHdQlZZVHA==
=wxvC
-----END PGP SIGNATURE-----

--------------07JgIE6kie0TtisQQdz5ml4x--
