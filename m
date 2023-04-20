Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591CD6E9455
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjDTMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDTMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:31:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74236658C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:30:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24CFD219FF;
        Thu, 20 Apr 2023 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681993858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inxXvdpYH+I0AhRMlD16JLss1lN+9dfcjLpR0mCD7hc=;
        b=rlQbPnTKVnbDxnqiKl+ZESaVyqMJcLx7OZfZxE8U+ONQUfNiRI1K9QWoiYwM9vwdWRXAbT
        mbFvXHTYhWi3JO/6+biyPn/QEQI14671QWOWXjC/dnGY+36V0CzFEHTf5kw/LfDVY9rrYl
        IEvam+1YLK0yJHQDW8REwNxqQFA6484=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C84011333C;
        Thu, 20 Apr 2023 12:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eouJL4EwQWSEegAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Apr 2023 12:30:57 +0000
Message-ID: <8fe66276-cd8c-f960-6eed-0a7f19bf6bfd@suse.com>
Date:   Thu, 20 Apr 2023 14:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
In-Reply-To: <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jkXldnmeREWrO8YEiI5nev89"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jkXldnmeREWrO8YEiI5nev89
Content-Type: multipart/mixed; boundary="------------08X48LioTnPhy49mHF52MVFn";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <8fe66276-cd8c-f960-6eed-0a7f19bf6bfd@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
In-Reply-To: <d164d84b-6773-36e3-1136-672072e9233d@suse.com>

--------------08X48LioTnPhy49mHF52MVFn
Content-Type: multipart/mixed; boundary="------------0Nxf1FpFhJv3X0nvsxQJxwry"

--------------0Nxf1FpFhJv3X0nvsxQJxwry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjMgMTQ6MzAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDIwLjA0LjIz
IDE0OjE1LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBTYXQsIEFwciAwMSwgMjAy
MyBhdCAwODozNjo0OEFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+ICtzdGF0
aWMgdm9pZCBybV9tYXBfZW50cnlfYXQoaW50IGlkeCkNCj4+PiArew0KPj4+ICvCoMKgwqAg
Y2FjaGVfbWFwX24tLTsNCj4+DQo+PiBMZXQncyBub3QgY2FsbCBtZW1tb3ZlKCkgd2hlbiBj
YWNoZV9tYXBfbiA9PSBpZHguDQo+Pg0KPj4gQmVsb3cgdG9vLg0KPj4NCj4+IEVzcGVjaWFs
bHkgc2luY2UgY2FjaGVfbWFwICsgaWR4ICsgMSBpcyBub3QgdmFsaWQgYW5kIEkgd291bGRu
J3Qgd2FudCBpdA0KPj4gZ2V0dGluZyBwcmVmZXRjaGVkIGZyb20gJXJzaSBpbiB0aGUgaHcg
d2hlbiB0aGVyZSdzIG5vIHJlYXNvbiBmb3IgaXQgYW5kDQo+PiBhbHNvIHRoZSBSRVQgZXZl
biBmcm9tIGEgZnVuY3Rpb24gd2hpY2ggZG9lc24ndCBkbyBhbnl0aGluZywgY29zdHMuDQo+
IA0KPiBPVE9IIHRoZSBhZGRpdGlvbmFsIGNvbXBhcmUgdG8gMCBoYXMgY29zdHMsIHRvbywg
YW5kIHRoaXMgY29zdCBpcyBzcGVudCBmb3INCj4gQUxMIGNhbGxzLCB3aGlsZSB0aGUgemVy
byBzaXplIGNhbGwgaXMgYSByYXRoZXIgcmFyZSBjYXNlLg0KPiANCj4gUmVnYXJkaW5nICJj
YWNoZV9tYXAgKyBpZHggKyAxIGlzIG5vdCB2YWxpZCI6IHRoZSBzdGFuZGFyZCBjbGVhcmx5
IHBvaW50cw0KPiBvdXQgdGhhdCBhIGNhbGwgd2l0aCBzaXplIDAgaXMgdmFsaWQgYW5kIHdv
bid0IGNvcHkgYW55dGhpbmcgWzFdLg0KPiANCj4+DQo+Pj4gK8KgwqDCoCBtZW1tb3ZlKGNh
Y2hlX21hcCArIGlkeCwgY2FjaGVfbWFwICsgaWR4ICsgMSwNCj4+PiArwqDCoMKgwqDCoMKg
wqAgc2l6ZW9mKCpjYWNoZV9tYXApICogKGNhY2hlX21hcF9uIC0gaWR4KSk7DQo+Pj4gK30N
Cj4+DQo+PiBPaywgZmlyc3Qgd2VpcmQgaXNzdWUgSSBlbmNvdW50ZXJlZCB3aGlsZSBwbGF5
aW5nIHdpdGggbXkgY2FydmVkIG91dA0KPj4gcHJvZ3JhbSB0byBleGVyY2lzZSB0aGlzIGNh
Y2hlX21hcCBoYW5kbGluZyB0aGluZy4gSSBjYW4gc2hhcmUgaXQgaWYgeW91DQo+PiB3YW50
IGl0IC0gaXQgaXMgdWdseSBidXQgaXQgd29ya3MuDQo+Pg0KPj4gU28gd2hpbGUgcmVidWls
ZGluZyB0aGUgbWFwLCBJIGhhdmUgdGhlc2UgY3VycmVudCByZWdpb25zIGluIHRoZSBtYXAs
IGF0DQo+PiBvbmUgcG9pbnQgaW4gdGltZToNCj4+DQo+PiBDdXJyZW50IG1hcDoNCj4+IDA6
IHN0YXJ0OiAweDAwMDAwMDAwMDAwMDAwMDAsIGVuZDogMHgwMDAwMDAwMDAwMTAwMDAwLCB0
eXBlOiAweDANCj4+IDE6IHN0YXJ0OiAweDAwMDAwMDAxMDAwMDAwMDAsIGVuZDogMHgwMDAw
MDAwODIwMDAwMDAwLCB0eXBlOiAweDYNCj4+IDI6IHN0YXJ0OiAweDAwMDAwMmYxMDAwMGMw
MDAsIGVuZDogMHgwMDAwMDNiZjAwMDBjMDAwLCB0eXBlOiAweDINCj4+IDM6IHN0YXJ0OiAw
eDAwMDAwM2JmMDAwMGMwMDAsIGVuZDogMHgwMDAwMGQ0YjAwMDBjMDAwLCB0eXBlOiAweDEN
Cj4+IDQ6IHN0YXJ0OiAweDAwMDAwZDRiMDAwMGMwMDAsIGVuZDogMHgwMDAxOWZjMDAwMDAx
MDAwLCB0eXBlOiAweDANCj4+IDU6IHN0YXJ0OiAweDAwMDE5ZmMwMDAwMDEwMDAsIGVuZDog
MHgwMDAxZGYyZDAwMDAxMDAwLCB0eXBlOiAweDINCj4+DQo+PiBub3RlIGVudHJ5ICMzLg0K
Pj4NCj4+IE5vdyB0aGUgbmV4dCBvbmUgaXQgaW5zZXJ0cyBpczoNCj4+DQo+PiBhZGRfbWFw
X2VudHJ5X2F0OiBzdGFydDogMHgzYmYwMDAwYzAwMCwgZW5kOiAweGQ0YjAwMDBjMDAwLCB0
eXBlOiAweDAsIGlkeDogMw0KPj4gwqAgbWVyZ2VfcHJldiAwOiBwcmV2LT5maXhlZDogMCwg
cHJldi0+ZW5kOiAweDNiZjAwMDBjMDAwLCBwcmV2LT50eXBlOiAweDINCj4+IMKgIG1lcmdl
X25leHQ6IDEsIG5leHQtPmZpeGVkOiAwLCBuZXh0LT5zdGFydDogMHhkNGIwMDAwYzAwMCwg
bmV4dC0+dHlwZTogMHgwDQo+PiBhZGRfbWFwX2VudHJ5X2F0OiByZXQ6IDENCj4+DQo+PiBO
b3RlIGhvdyBpdCBpcyB0aGUgc2FtZSBhcyBlbnRyeSBudW1iZXIgIzMgLSBqdXN0IGEgZGlm
ZmVyZW50IHR5cGUuDQo+Pg0KPj4gV2hhdCBpdCBlbmRzIHVwIGRvaW5nIGlzLCBpdCBzaW1w
bHkgb3ZlcndyaXRlcyB0aGUgcHJldmlvdXMgb25lIGFuZA0KPj4gbWVyZ2VzIGl0IHdpdGgg
dGhlIG5leHQ6DQo+Pg0KPj4gQ3VycmVudCBtYXA6DQo+PiAwOiBzdGFydDogMHgwMDAwMDAw
MDAwMDAwMDAwLCBlbmQ6IDB4MDAwMDAwMDAwMDEwMDAwMCwgdHlwZTogMHgwDQo+PiAxOiBz
dGFydDogMHgwMDAwMDAwMTAwMDAwMDAwLCBlbmQ6IDB4MDAwMDAwMDgyMDAwMDAwMCwgdHlw
ZTogMHg2DQo+PiAyOiBzdGFydDogMHgwMDAwMDJmMTAwMDBjMDAwLCBlbmQ6IDB4MDAwMDAz
YmYwMDAwYzAwMCwgdHlwZTogMHgyDQo+PiAzOiBzdGFydDogMHgwMDAwMDNiZjAwMDBjMDAw
LCBlbmQ6IDB4MDAwMTlmYzAwMDAwMTAwMCwgdHlwZTogMHgwDQo+PiA0OiBzdGFydDogMHgw
MDAxOWZjMDAwMDAxMDAwLCBlbmQ6IDB4MDAwMWRmMmQwMDAwMTAwMCwgdHlwZTogMHgyDQo+
IA0KPiBUaGUgbWFwIHdvdWxkIHJlZmxlY3QgaGFyZHdhcmUgYmVoYXZpb3IuIFR5cGUgMCB3
aW5zIGluIGNhc2Ugb2Ygb3ZlcmxhcHBpbmcNCj4gTVRSUnMuDQo+IA0KPj4gTm93IEkgdGhp
bmsgcmlnaHQgYWJvdXQgbm93IHdlIHNob3VsZCd2ZSBzY3JlYW1lZCBsb3VkbHkuDQo+IA0K
PiBOb3cgdGhpcyBpcyBhbm90aGVyIHJlcXVpcmVtZW50LCByaWdodD8gVG9kYXkncyBNVFJS
IGNvZGUgd291bGRuJ3Qgc2NyZWFtDQo+IGVpdGhlci4NCj4gDQo+PiBJIGtub3cgSSBrbm93
LCB0aGlzIHNob3VsZCBuZXZlciBoYXBwZW4sIHJpZ2h0PyBBbmQgZmlybXdhcmUgcHJvZ3Jh
bW1pbmcNCj4+IHRob3NlIE1UUlJzIGRvZXNuJ3QgbWFrZSBtaXN0YWtlcy4uLg0KPiANCj4g
QXQgbGVhc3Qgd2UgZG9uJ3QgY29ycmVjdCBzdWNoIG1pc3Rha2VzIHRvZGF5LiBEbyB5b3Ug
dGhpbmsgd2Ugc2hvdWxkIGNoYW5nZQ0KPiB0aGF0Pw0KPiANCj4+IEhvd2V2ZXIsIHdlIHNo
b3VsZCBiZSBsb3VkIGhlcmUgYW5kIHNjcmVhbSB3aGVuIGEgTVRSUiByYW5nZSBkaXNhcHBl
YXJzDQo+PiBsaWtlIHRoYXQuDQo+Pg0KPj4gUmlnaHQ/DQo+IA0KPiBUQkgsIEkgZG9uJ3Qg
a25vdy4NCg0KQmFoLCBmb3Jnb3QgdGhlIGxpbms6DQoNClsxXTogaHR0cHM6Ly9saXN0cy5s
bHZtLm9yZy9waXBlcm1haWwvbGx2bS1kZXYvMjAwNy1PY3RvYmVyLzAxMTA3MC5odG1sDQoN
Cg0KSnVlcmdlbg0KDQo=
--------------0Nxf1FpFhJv3X0nvsxQJxwry
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0Nxf1FpFhJv3X0nvsxQJxwry--

--------------08X48LioTnPhy49mHF52MVFn--

--------------jkXldnmeREWrO8YEiI5nev89
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRBMIAFAwAAAAAACgkQsN6d1ii/Ey84
xQf/WqljVF4daFJp1UMJLqEP7IqvVnOyf2Phl8QwJulXuAIEA765q6MCon1uLPmgYOQEotCabgAa
7SQGrusjCOvbCqamf55LAD3uvkXwBCU1gtRFV1d/II8xe5RDxNsvdsc4oxNvfsSVwAvE1eW4LD4O
0VeDy/R3ExzMtd5LW4HoCmi3LUBFS/fSCJ1j0ph1hLofp0auKc+GBKke+PQ/gXj7V6J91Nhk1wHv
eaI0KpOJbj3SKf3dr+6aaVyQHj28mNaPoYVNm+rc0QdwB6ntABlyHebDTOguJC811Ssl65HzQY0j
m5zQm6Yj4Hn9EYQHzII940jUk4JjGvY2uhU6m17NYQ==
=nUGq
-----END PGP SIGNATURE-----

--------------jkXldnmeREWrO8YEiI5nev89--
