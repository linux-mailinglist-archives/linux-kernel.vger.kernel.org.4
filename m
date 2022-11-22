Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06AF63354A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiKVG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:28:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969A25DD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:28:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77DC81F895;
        Tue, 22 Nov 2022 06:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669098502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X5jmX5vv2ZCRcvUxzhS4omeLtPL1XBubbUHoLu4E5xE=;
        b=eSl4V9I4QtfPuGNRfMto4LI9zRavuPY92guYF10+u9gYacqjz2xkDtDNVyyv3yk+R7ADqy
        UqA9zVo7Hoo6ueC3npdQQGXtOQxTBypryjljWUjQaJDFx94hKuyz3WF+O4YPOO2jgMIW+1
        l+ZHoy0Qlj7wXgtv9399WAPZZCPaS84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B08913B01;
        Tue, 22 Nov 2022 06:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nPK7DAZsfGPxXQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Nov 2022 06:28:22 +0000
Message-ID: <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
Date:   Tue, 22 Nov 2022 07:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221121162433.28070-1-jgross@suse.com>
 <Y3vMpbsHA35VoasD@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/boot: skip realmode init code when running as Xen PV
 guest
In-Reply-To: <Y3vMpbsHA35VoasD@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fpiO3JUiu34VYe4SA3wZ13l3"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fpiO3JUiu34VYe4SA3wZ13l3
Content-Type: multipart/mixed; boundary="------------q48r7iH0DkNbHZsMBCAKbNKw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
Subject: Re: [PATCH] x86/boot: skip realmode init code when running as Xen PV
 guest
References: <20221121162433.28070-1-jgross@suse.com>
 <Y3vMpbsHA35VoasD@zn.tnic>
In-Reply-To: <Y3vMpbsHA35VoasD@zn.tnic>

--------------q48r7iH0DkNbHZsMBCAKbNKw
Content-Type: multipart/mixed; boundary="------------zVpPjkdmfsVKVnnZu2a9xFGQ"

--------------zVpPjkdmfsVKVnnZu2a9xFGQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMTEuMjIgMjA6MDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBO
b3YgMjEsIDIwMjIgYXQgMDU6MjQ6MzNQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBndWVzdCB0aGVyZSBpcyBubyBuZWVkIGZv
ciBzZXR0aW5nIHVwIHRoZQ0KPj4gcmVhbG1vZGUgdHJhbXBvbGluZSwgYXMgcmVhbG1vZGUg
aXNuJ3Qgc3VwcG9ydGVkIGluIHRoaXMgZW52aXJvbm1lbnQuDQo+Pg0KPj4gVHJ5aW5nIHRv
IHNldHVwIHRoZSB0cmFtcG9saW5lIGhhcyBiZWVuIHByb3ZlbiB0byBiZSBwcm9ibGVtYXRp
YyBpbg0KPj4gc29tZSBjYXNlcywgZXNwZWNpYWxseSB3aGVuIHRyeWluZyB0byBkZWJ1ZyBl
YXJseSBib290IHByb2JsZW1zIHdpdGgNCj4+IFhlbiByZXF1aXJpbmcgdG8ga2VlcCB0aGUg
RUZJIGJvb3Qtc2VydmljZXMgbWVtb3J5IG1hcHBlZCAoc29tZQ0KPj4gZmlybXdhcmUgdmFy
aWFudHMgc2VlbSB0byBjbGFpbSBiYXNpY2FsbHkgYWxsIG1lbW9yeSBiZWxvdyAxTSBmb3Ig
Ym9vdA0KPj4gc2VydmljZXMpLg0KPj4NCj4+IFNraXAgdGhlIHRyYW1wb2xpbmUgc2V0dXAg
Y29kZSBmb3IgWGVuIFBWIGd1ZXN0cy4NCj4+DQo+PiBGaXhlczogMDg0ZWUxYzY0MWEwICgi
eDg2LCByZWFsbW9kZTogUmVsb2NhdG9yIGZvciByZWFsbW9kZSBjb2RlIikNCj4+IFNpZ25l
ZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4g
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWFsbW9kZS5oIHwgNCArKy0tDQo+PiAgIGFyY2gv
eDg2L3JlYWxtb2RlL2luaXQuYyAgICAgICAgfCAzICsrKw0KPj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gICANCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWFsbW9kZS5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcmVhbG1vZGUuaA0KPj4gaW5kZXggZmQ2ZjZlNWI3NTVhLi41YmZjZTU4ZjFiYWIg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWFsbW9kZS5oDQo+PiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWFsbW9kZS5oDQo+PiBAQCAtNzgsOCArNzgs
OCBAQCBleHRlcm4gdW5zaWduZWQgY2hhciBzZWNvbmRhcnlfc3RhcnR1cF82NF9ub192ZXJp
ZnlbXTsNCj4+ICAgDQo+PiAgIHN0YXRpYyBpbmxpbmUgc2l6ZV90IHJlYWxfbW9kZV9zaXpl
X25lZWRlZCh2b2lkKQ0KPj4gICB7DQo+PiAtCWlmIChyZWFsX21vZGVfaGVhZGVyKQ0KPj4g
LQkJcmV0dXJuIDA7CS8qIGFscmVhZHkgYWxsb2NhdGVkLiAqLw0KPj4gKwlpZiAocmVhbF9t
b2RlX2hlYWRlciB8fCBjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSkN
Cj4+ICsJCXJldHVybiAwOwkvKiBhbHJlYWR5IGFsbG9jYXRlZCBvciBub3QgbmVlZGVkLiAq
Lw0KPj4gICANCj4+ICAgCXJldHVybiBBTElHTihyZWFsX21vZGVfYmxvYl9lbmQgLSByZWFs
X21vZGVfYmxvYiwgUEFHRV9TSVpFKTsNCj4+ICAgfQ0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L3JlYWxtb2RlL2luaXQuYyBiL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYw0KPj4gaW5k
ZXggNDFkNzY2OWE5N2FkLi4xODI2NzAwYjE1NmUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4
Ni9yZWFsbW9kZS9pbml0LmMNCj4+ICsrKyBiL2FyY2gveDg2L3JlYWxtb2RlL2luaXQuYw0K
Pj4gQEAgLTIwMiw2ICsyMDIsOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc2V0X3JlYWxfbW9k
ZV9wZXJtaXNzaW9ucyh2b2lkKQ0KPj4gICANCj4+ICAgc3RhdGljIGludCBfX2luaXQgaW5p
dF9yZWFsX21vZGUodm9pZCkNCj4+ICAgew0KPj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxl
ZChYODZfRkVBVFVSRV9YRU5QVikpYQ0KPiANCj4gVGhpcyByZW1pbmRzIG1lIG9mIHRoZSBu
b3RvcmlvdXMgaWYgKHhlbikgc3ByaW5rbGluZyBmcm9tIHllYXJzIGFnby4NCj4gUGxlYXNl
IGRvbid0IGRvIHRoYXQuDQo+IA0KDQpPa2F5LCB3aGF0IGFib3V0IHBsYW4gQjoNCg0KLSBy
ZXdvcmsgcmVhbG1vZGUvcm0gdG86DQogICArIHJlcGxhY2UgaGVhZGVyLlMgd2l0aCBtYWlu
LmMgbWFraW5nIGl0IHBvc3NpYmxlIHRvIGluaXRpYWxpemUNCiAgICAgc3RydWN0IHJlYWxf
bW9kZV9oZWFkZXIgdXNpbmcgdGhlIHN0cnVjdCBkZWZpbml0aW9uDQogICArIG9wdGlvbmFs
OiBtZXJnZSBzdGFjay5TIGludG8gbWFpbi5jDQotIGluY2x1ZGUgcmVhbG1vZGUvcm0gYWRk
cmVzc2VzIG5lZWRlZCBvdXRzaWRlIG9mIGl0IGluIHN0cnVjdA0KICAgcmVhbF9tb2RlX2hl
YWRlcg0KLSBzZXR1cCBhIGR1bW15IHN0cnVjdCByZWFsX21vZGVfaGVhZGVyIGluIFhlbiBQ
ViBjb2RlIHJlbW92aW5nIHRoZQ0KICAgbmVlZCB0byBza2lwIGluaXRfcmVhbF9tb2RlKCks
IGJ1dCBtYWtpbmcgaXQgYmFzaWNhbGx5IGEgbm9wDQoNCldvdWxkIHlvdSBiZSBmaW5lIHdp
dGggdGhhdD8NCg0KDQpKdWVyZ2VuDQo=
--------------zVpPjkdmfsVKVnnZu2a9xFGQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------zVpPjkdmfsVKVnnZu2a9xFGQ--

--------------q48r7iH0DkNbHZsMBCAKbNKw--

--------------fpiO3JUiu34VYe4SA3wZ13l3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN8bAUFAwAAAAAACgkQsN6d1ii/Ey+s
Ngf+NdV39lX+tWx8SiAFZkz1sZEUX0al9vyekLqWohmXxg3IrCRco+UvSJebxtkKzcQUHpfyZ7iY
iRNK9xmuq0Ka3AZREKNISWsY84lwFWCK9tRf+NjMReyKXXsMMycFCwdI7ZqwwGUmABE0wlrDu6DV
QWwbQbGqTprSRSC1hsisigzDjI9Wy5k+04PwI9FAfK4xbIn0iCXWYky0bZqZDdCbyi2Wuk1NyNAe
HHil7PTt9oG6EBKFoCwCShKT/tyZUgYL6+DqCwfqBTxesdBVnJP+3HVvctyioh7VvO+QgeFgg404
0WdQy7x0xvZL8la89DvyaUaLoaR/C5VRhmhbmJGorQ==
=YJRv
-----END PGP SIGNATURE-----

--------------fpiO3JUiu34VYe4SA3wZ13l3--
