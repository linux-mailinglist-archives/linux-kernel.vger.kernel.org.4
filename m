Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA864635079
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiKWG3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiKWG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:29:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936D5C74E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:29:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 911FD1F88C;
        Wed, 23 Nov 2022 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669184957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUfgOGdZnSLe6IuECdKoKhSKRXlmP9Gm7X9r8vwitcI=;
        b=QdtxX1ap7X2YvGDUn+cj0NUHsHqDww7AuQIQSvohJsPcz6EdFeuxe4jrDHDjW07vXwy9w5
        Uurn1MAifshOqyConR0D0fUCP2VtT5zwRAZ8gO0QeQdorgnIMwmU9eYHP9/IBKiZXY/Guw
        brvDiJDXK+RIv1Wj89SstRvHJWOgtZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5901213A37;
        Wed, 23 Nov 2022 06:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZFz+E729fWOOOgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Nov 2022 06:29:17 +0000
Message-ID: <71ab8962-bcb2-e735-d70c-509949efb6eb@suse.com>
Date:   Wed, 23 Nov 2022 07:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221121162433.28070-1-jgross@suse.com>
 <Y3vMpbsHA35VoasD@zn.tnic> <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
 <289E9B77-FA56-4655-91F3-7BDE4DF9BB78@zytor.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/boot: skip realmode init code when running as Xen PV
 guest
In-Reply-To: <289E9B77-FA56-4655-91F3-7BDE4DF9BB78@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VgXUdcHUoBeuuFBdTeGOQRLL"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VgXUdcHUoBeuuFBdTeGOQRLL
Content-Type: multipart/mixed; boundary="------------Wy8JT701jwCPPJdRGmbsV2Jx";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <71ab8962-bcb2-e735-d70c-509949efb6eb@suse.com>
Subject: Re: [PATCH] x86/boot: skip realmode init code when running as Xen PV
 guest
References: <20221121162433.28070-1-jgross@suse.com>
 <Y3vMpbsHA35VoasD@zn.tnic> <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
 <289E9B77-FA56-4655-91F3-7BDE4DF9BB78@zytor.com>
In-Reply-To: <289E9B77-FA56-4655-91F3-7BDE4DF9BB78@zytor.com>

--------------Wy8JT701jwCPPJdRGmbsV2Jx
Content-Type: multipart/mixed; boundary="------------pXWv73Jo1AxUHGWPJaJ9mvjE"

--------------pXWv73Jo1AxUHGWPJaJ9mvjE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMTEuMjIgMDE6MDcsIEguIFBldGVyIEFudmluIHdyb3RlOg0KPiBPbiBOb3ZlbWJl
ciAyMSwgMjAyMiAxMDoyODoyMSBQTSBQU1QsIEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNl
LmNvbT4gd3JvdGU6DQo+PiBPbiAyMS4xMS4yMiAyMDowOCwgQm9yaXNsYXYgUGV0a292IHdy
b3RlOg0KPj4+IE9uIE1vbiwgTm92IDIxLCAyMDIyIGF0IDA1OjI0OjMzUE0gKzAxMDAsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+IFdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBndWVz
dCB0aGVyZSBpcyBubyBuZWVkIGZvciBzZXR0aW5nIHVwIHRoZQ0KPj4+PiByZWFsbW9kZSB0
cmFtcG9saW5lLCBhcyByZWFsbW9kZSBpc24ndCBzdXBwb3J0ZWQgaW4gdGhpcyBlbnZpcm9u
bWVudC4NCj4+Pj4NCj4+Pj4gVHJ5aW5nIHRvIHNldHVwIHRoZSB0cmFtcG9saW5lIGhhcyBi
ZWVuIHByb3ZlbiB0byBiZSBwcm9ibGVtYXRpYyBpbg0KPj4+PiBzb21lIGNhc2VzLCBlc3Bl
Y2lhbGx5IHdoZW4gdHJ5aW5nIHRvIGRlYnVnIGVhcmx5IGJvb3QgcHJvYmxlbXMgd2l0aA0K
Pj4+PiBYZW4gcmVxdWlyaW5nIHRvIGtlZXAgdGhlIEVGSSBib290LXNlcnZpY2VzIG1lbW9y
eSBtYXBwZWQgKHNvbWUNCj4+Pj4gZmlybXdhcmUgdmFyaWFudHMgc2VlbSB0byBjbGFpbSBi
YXNpY2FsbHkgYWxsIG1lbW9yeSBiZWxvdyAxTSBmb3IgYm9vdA0KPj4+PiBzZXJ2aWNlcyku
DQo+Pj4+DQo+Pj4+IFNraXAgdGhlIHRyYW1wb2xpbmUgc2V0dXAgY29kZSBmb3IgWGVuIFBW
IGd1ZXN0cy4NCj4+Pj4NCj4+Pj4gRml4ZXM6IDA4NGVlMWM2NDFhMCAoIng4NiwgcmVhbG1v
ZGU6IFJlbG9jYXRvciBmb3IgcmVhbG1vZGUgY29kZSIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL3JlYWxtb2RlLmggfCA0ICsrLS0NCj4+Pj4gICAgYXJjaC94
ODYvcmVhbG1vZGUvaW5pdC5jICAgICAgICB8IDMgKysrDQo+Pj4+ICAgIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+ICAgIA0KPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcmVhbG1vZGUuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3JlYWxtb2RlLmgNCj4+Pj4gaW5kZXggZmQ2ZjZlNWI3NTVhLi41YmZj
ZTU4ZjFiYWIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3JlYWxt
b2RlLmgNCj4+Pj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcmVhbG1vZGUuaA0KPj4+
PiBAQCAtNzgsOCArNzgsOCBAQCBleHRlcm4gdW5zaWduZWQgY2hhciBzZWNvbmRhcnlfc3Rh
cnR1cF82NF9ub192ZXJpZnlbXTsNCj4+Pj4gICAgICBzdGF0aWMgaW5saW5lIHNpemVfdCBy
ZWFsX21vZGVfc2l6ZV9uZWVkZWQodm9pZCkNCj4+Pj4gICAgew0KPj4+PiAtCWlmIChyZWFs
X21vZGVfaGVhZGVyKQ0KPj4+PiAtCQlyZXR1cm4gMDsJLyogYWxyZWFkeSBhbGxvY2F0ZWQu
ICovDQo+Pj4+ICsJaWYgKHJlYWxfbW9kZV9oZWFkZXIgfHwgY3B1X2ZlYXR1cmVfZW5hYmxl
ZChYODZfRkVBVFVSRV9YRU5QVikpDQo+Pj4+ICsJCXJldHVybiAwOwkvKiBhbHJlYWR5IGFs
bG9jYXRlZCBvciBub3QgbmVlZGVkLiAqLw0KPj4+PiAgICAgIAlyZXR1cm4gQUxJR04ocmVh
bF9tb2RlX2Jsb2JfZW5kIC0gcmVhbF9tb2RlX2Jsb2IsIFBBR0VfU0laRSk7DQo+Pj4+ICAg
IH0NCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYyBiL2FyY2gv
eDg2L3JlYWxtb2RlL2luaXQuYw0KPj4+PiBpbmRleCA0MWQ3NjY5YTk3YWQuLjE4MjY3MDBi
MTU2ZSAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYvcmVhbG1vZGUvaW5pdC5jDQo+Pj4+
ICsrKyBiL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYw0KPj4+PiBAQCAtMjAyLDYgKzIwMiw5
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzZXRfcmVhbF9tb2RlX3Blcm1pc3Npb25zKHZvaWQp
DQo+Pj4+ICAgICAgc3RhdGljIGludCBfX2luaXQgaW5pdF9yZWFsX21vZGUodm9pZCkNCj4+
Pj4gICAgew0KPj4+PiArCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hF
TlBWKSlhDQo+Pj4NCj4+PiBUaGlzIHJlbWluZHMgbWUgb2YgdGhlIG5vdG9yaW91cyBpZiAo
eGVuKSBzcHJpbmtsaW5nIGZyb20geWVhcnMgYWdvLg0KPj4+IFBsZWFzZSBkb24ndCBkbyB0
aGF0Lg0KPj4+DQo+Pg0KPj4gT2theSwgd2hhdCBhYm91dCBwbGFuIEI6DQo+Pg0KPj4gLSBy
ZXdvcmsgcmVhbG1vZGUvcm0gdG86DQo+PiAgICsgcmVwbGFjZSBoZWFkZXIuUyB3aXRoIG1h
aW4uYyBtYWtpbmcgaXQgcG9zc2libGUgdG8gaW5pdGlhbGl6ZQ0KPj4gICAgIHN0cnVjdCBy
ZWFsX21vZGVfaGVhZGVyIHVzaW5nIHRoZSBzdHJ1Y3QgZGVmaW5pdGlvbg0KPj4gICArIG9w
dGlvbmFsOiBtZXJnZSBzdGFjay5TIGludG8gbWFpbi5jDQo+PiAtIGluY2x1ZGUgcmVhbG1v
ZGUvcm0gYWRkcmVzc2VzIG5lZWRlZCBvdXRzaWRlIG9mIGl0IGluIHN0cnVjdA0KPj4gICBy
ZWFsX21vZGVfaGVhZGVyDQo+PiAtIHNldHVwIGEgZHVtbXkgc3RydWN0IHJlYWxfbW9kZV9o
ZWFkZXIgaW4gWGVuIFBWIGNvZGUgcmVtb3ZpbmcgdGhlDQo+PiAgIG5lZWQgdG8gc2tpcCBp
bml0X3JlYWxfbW9kZSgpLCBidXQgbWFraW5nIGl0IGJhc2ljYWxseSBhIG5vcA0KPj4NCj4+
IFdvdWxkIHlvdSBiZSBmaW5lIHdpdGggdGhhdD8NCj4+DQo+Pg0KPj4gSnVlcmdlbg0KPiAN
Cj4gSSdtIHdvbmRlcmluZyBpZiBpbml0X3JlYWxfbW9kZSBzaG91bGQgbm90IHNpbXBseSBi
ZSBwYXJ0IG9mIHRoZSBwbGF0Zm9ybSBvcHMuIEl0J3MgY2FsbGVkIGV4YWN0bHkgdHdpY2Ug
cGVyIGJvb3QsIGl0IGlzIGhhcmQgdG8gYmUgbGVzcyBwZXJmb3JtYW5jZSBjcml0aWNhbCB0
aGFuIHRoYXQuDQoNCkFjdHVhbGx5LCBpdCBpcyBjYWxsZWQgb25seSBvbmNlLiA6LSkNCg0K
QW55IHByZWZlcmVuY2VzIHJlZ2FyZGluZyB0aGUgY2FsbCBoaWVyYXJjaHk/IEkgY291bGQg
ZWl0aGVyIGtlZXANCnRoZSBlYXJseV9pbml0Y2FsbCgpIGFuZCBjYWxsIHRoZSBwbGF0Zm9y
bV9vcCBmcm9tIHRoYXQgaW5pdGNhbGwsIG9yDQpJIGNvdWxkIGludHJvZHVjZSBhIHNtYWxs
IHdyYXBwZXIgY2FsbGVkIGJ5IGtlcm5lbF9pbml0X2ZyZWVhYmxlKCksDQp3aGljaCB3b3Vs
ZCBiZSBlbXB0eSBvbiBhbGwgYnV0IHRoZSB4ODYgYXJjaGl0ZWN0dXJlLg0KDQpCb3Jpcywg
aWYgeW91IGFncmVlLCBJIGNhbiBnbyB0aGF0IHJvdXRlLg0KDQoNCkp1ZXJnZW4NCg==
--------------pXWv73Jo1AxUHGWPJaJ9mvjE
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------pXWv73Jo1AxUHGWPJaJ9mvjE--

--------------Wy8JT701jwCPPJdRGmbsV2Jx--

--------------VgXUdcHUoBeuuFBdTeGOQRLL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN9vbwFAwAAAAAACgkQsN6d1ii/Ey+i
cAgAiLcm2vkcRAzLgT/veD1p+Wzy8DG709gXznGmQcjHAmqxCRygrvmZQ7H/ysuE+9hxWGflIssx
KS9P2cBfnNNksqY7prrxfjlICdsgGesgIpa1gffhXikeAQ7dSMSZ+cHbkz9LWmUvLRa0UUG6gOaA
AOHeirNSVZc4V1SzFPpEqFhdvGvRU5qlXPBbDsrmXZGHxoTwFJnCsW27H3uywC8Ntq0/b+oPJU1K
rWXaqQ1hqM/oT8E9NYTYYkRMyU1n1rU2JmL7V2wBNipeQV9cKwK5BdYWHeZBO/f2a2leB1dGcuUr
/TLiDVa5uO/vCB3R9dwA/i2tMCF8jJP//jgIPXPCxQ==
=M9qM
-----END PGP SIGNATURE-----

--------------VgXUdcHUoBeuuFBdTeGOQRLL--
