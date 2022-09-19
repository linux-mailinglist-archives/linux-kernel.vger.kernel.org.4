Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BDD5BC9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiISKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiISKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:46:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B279B875
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:32:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39A4B220F4;
        Mon, 19 Sep 2022 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663583571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mvLW9LotoDgDB6BsSj7jpHjmR0P2hhEFaL5fVZtX90=;
        b=sDu7boVgTSMd4sISRSooQBNhyVK6FxYZXxZYs87cUz93bxIsnTWlWk5bQ6IOQs8yu6ie9q
        kEQ9i1HbTNdFFqXLLgaYbdRPZXPQ2ceE7YoJwF7zkQRLpnS80K0yrJyzgOPGmA5huv7IF7
        99CocNJxi4A47f3/efq37TL8vzvfjTA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8DEF13A96;
        Mon, 19 Sep 2022 10:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1hBHN1JFKGPrcgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 19 Sep 2022 10:32:50 +0000
Message-ID: <d9d20448-13b0-86bd-4dbb-50d8a98024d0@suse.com>
Date:   Mon, 19 Sep 2022 12:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] xen/gntdev: Accommodate VMA splitting
Content-Language: en-US
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220912040002.198191-1-m.v.b@runbox.com>
 <20220912040002.198191-3-m.v.b@runbox.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220912040002.198191-3-m.v.b@runbox.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------taO9UrUHsRh2N1i26QA65PFP"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------taO9UrUHsRh2N1i26QA65PFP
Content-Type: multipart/mixed; boundary="------------6q5orJvlsQYaVIVVg9B4f2nF";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "M. Vefa Bicakci" <m.v.b@runbox.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d9d20448-13b0-86bd-4dbb-50d8a98024d0@suse.com>
Subject: Re: [PATCH 2/2] xen/gntdev: Accommodate VMA splitting
References: <20220912040002.198191-1-m.v.b@runbox.com>
 <20220912040002.198191-3-m.v.b@runbox.com>
In-Reply-To: <20220912040002.198191-3-m.v.b@runbox.com>

--------------6q5orJvlsQYaVIVVg9B4f2nF
Content-Type: multipart/mixed; boundary="------------WLb5L0dbJE4aWejsnRRU0psh"

--------------WLb5L0dbJE4aWejsnRRU0psh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDkuMjIgMDY6MDAsIE0uIFZlZmEgQmljYWtjaSB3cm90ZToNCj4gUHJpb3IgdG8g
dGhpcyBjb21taXQsIHRoZSBnbnRkZXYgZHJpdmVyIGNvZGUgZGlkIG5vdCBoYW5kbGUgdGhl
DQo+IGZvbGxvd2luZyBzY2VuYXJpbyBjb3JyZWN0bHk6DQo+IA0KPiAqIFVzZXIgcHJvY2Vz
cyBzZXRzIHVwIGEgZ250ZGV2IG1hcHBpbmcgY29tcG9zZWQgb2YgdHdvIGdyYW50IG1hcHBp
bmdzDQo+ICAgIChpLmUuLCB0d28gcGFnZXMgc2hhcmVkIGJ5IGFub3RoZXIgWGVuIGRvbWFp
bikuDQo+ICogVXNlciBwcm9jZXNzIG11bm1hcCgpcyBvbmUgb2YgdGhlIHBhZ2VzLg0KPiAq
IFVzZXIgcHJvY2VzcyBtdW5tYXAoKXMgdGhlIHJlbWFpbmluZyBwYWdlLg0KPiAqIFVzZXIg
cHJvY2VzcyBleGl0cy4NCj4gDQo+IEluIHRoZSBzY2VuYXJpbyBhYm92ZSwgdGhlIHVzZXIg
cHJvY2VzcyB3b3VsZCBjYXVzZSB0aGUga2VybmVsIHRvIGxvZw0KPiB0aGUgZm9sbG93aW5n
IG1lc3NhZ2VzIGluIGRtZXNnIGZvciB0aGUgZmlyc3QgbXVubWFwKCksIGFuZCB0aGUgc2Vj
b25kDQo+IG11bm1hcCgpIGNhbGwgd291bGQgcmVzdWx0IGluIHNpbWlsYXIgbG9nIG1lc3Nh
Z2VzOg0KPiANCj4gICAgQlVHOiBCYWQgcGFnZSBtYXAgaW4gcHJvY2VzcyBkb3VibGVtYXAu
dGVzdCAgcHRlOi4uLiBwbWQ6Li4uDQo+ICAgIHBhZ2U6MDAwMDAwMDA1N2M5N2JmZiByZWZj
b3VudDoxIG1hcGNvdW50Oi0xIFwNCj4gICAgICBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAg
aW5kZXg6MHgwIHBmbjouLi4NCj4gICAgLi4uDQo+ICAgIHBhZ2UgZHVtcGVkIGJlY2F1c2U6
IGJhZCBwdGUNCj4gICAgLi4uDQo+ICAgIGZpbGU6Z250ZGV2IGZhdWx0OjB4MCBtbWFwOmdu
dGRldl9tbWFwIFt4ZW5fZ250ZGV2XSByZWFkcGFnZToweDANCj4gICAgLi4uDQo+ICAgIENh
bGwgVHJhY2U6DQo+ICAgICA8VEFTSz4NCj4gICAgIGR1bXBfc3RhY2tfbHZsKzB4NDYvMHg1
ZQ0KPiAgICAgcHJpbnRfYmFkX3B0ZS5jb2xkKzB4NjYvMHhiNg0KPiAgICAgdW5tYXBfcGFn
ZV9yYW5nZSsweDdlNS8weGRjMA0KPiAgICAgdW5tYXBfdm1hcysweDc4LzB4ZjANCj4gICAg
IHVubWFwX3JlZ2lvbisweGE4LzB4MTEwDQo+ICAgICBfX2RvX211bm1hcCsweDFlYS8weDRl
MA0KPiAgICAgX192bV9tdW5tYXArMHg3NS8weDEyMA0KPiAgICAgX194NjRfc3lzX211bm1h
cCsweDI4LzB4NDANCj4gICAgIGRvX3N5c2NhbGxfNjQrMHgzOC8weDkwDQo+ICAgICBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2MS8weGNiDQo+ICAgICAuLi4NCj4gDQo+
IEZvciBlYWNoIG11bm1hcCgpIGNhbGwsIHRoZSBYZW4gaHlwZXJ2aXNvciAoaWYgYnVpbHQg
d2l0aCBDT05GSUdfREVCVUcpDQo+IHdvdWxkIHByaW50IG91dCB0aGUgZm9sbG93aW5nIGFu
ZCB0cmlnZ2VyIGEgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGluDQo+IGRvbTA6DQo+IA0K
PiAgICAoWEVOKSBkMHYuLi4gQXR0ZW1wdCB0byBpbXBsaWNpdGx5IHVubWFwIGQwJ3MgZ3Jh
bnQgUFRFIC4uLg0KPiAgICAoWEVOKSBkMHYuLi4gQXR0ZW1wdCB0byBpbXBsaWNpdGx5IHVu
bWFwIGQwJ3MgZ3JhbnQgUFRFIC4uLg0KPiANCj4gQXMgb2YgdGhpcyB3cml0aW5nLCBnbnRk
ZXZfZ3JhbnRfbWFwIHN0cnVjdHVyZSdzIHZtYSBmaWVsZCAocmVmZXJyZWQgdG8NCj4gYXMg
bWFwLT52bWEgYmVsb3cpIGlzIG1haW5seSB1c2VkIGZvciBjaGVja2luZyB0aGUgc3RhcnQg
YW5kIGVuZA0KPiBhZGRyZXNzZXMgb2YgbWFwcGluZ3MuIEhvd2V2ZXIsIHdpdGggc3BsaXQg
Vk1BcywgdGhlc2UgbWF5IGNoYW5nZSwgYW5kDQo+IHRoZXJlIGNvdWxkIGJlIG1vcmUgdGhh
biBvbmUgVk1BIGFzc29jaWF0ZWQgd2l0aCBhIGdudGRldiBtYXBwaW5nLg0KPiBIZW5jZSwg
cmVtb3ZlIHRoZSB1c2Ugb2YgbWFwLT52bWEgYW5kIHJlbHkgb24gbWFwLT5wYWdlc192bV9z
dGFydCBmb3INCj4gdGhlIG9yaWdpbmFsIHN0YXJ0IGFkZHJlc3MgYW5kIG9uIChtYXAtPmNv
dW50IDw8IFBBR0VfU0hJRlQpIGZvciB0aGUNCj4gb3JpZ2luYWwgbWFwcGluZyBzaXplLiBM
ZXQgdGhlIGludmFsaWRhdGUoKSBhbmQgZmluZF9zcGVjaWFsX3BhZ2UoKQ0KPiBob29rcyB1
c2UgdGhlc2UuDQo+IA0KPiBBbHNvLCBnaXZlbiB0aGF0IHRoZXJlIGNhbiBiZSBtdWx0aXBs
ZSBWTUFzIGFzc29jaWF0ZWQgd2l0aCBhIGdudGRldg0KPiBtYXBwaW5nLCBtb3ZlIHRoZSAi
bW11X2ludGVydmFsX25vdGlmaWVyX3JlbW92ZSgmbWFwLT5ub3RpZmllcikiIGNhbGwgdG8N
Cj4gdGhlIGVuZCBvZiBnbnRkZXZfcHV0X21hcCwgc28gdGhhdCB0aGUgTU1VIG5vdGlmaWVy
IGlzIG9ubHkgcmVtb3ZlZA0KPiBhZnRlciB0aGUgY2xvc2luZyBvZiB0aGUgbGFzdCByZW1h
aW5pbmcgVk1BLg0KPiANCj4gRmluYWxseSwgdXNlIGFuIGF0b21pYyB0byBwcmV2ZW50IGlu
YWR2ZXJ0ZW50IGdudGRldiBtYXBwaW5nIHJlLXVzZSwNCj4gaW5zdGVhZCBvZiB1c2luZyB0
aGUgbWFwLT5saXZlX2dyYW50cyBhdG9taWMgY291bnRlciBhbmQvb3IgdGhlIG1hcC0+dm1h
DQo+IHBvaW50ZXIgKHRoZSBsYXR0ZXIgb2Ygd2hpY2ggaXMgbm93IHJlbW92ZWQpLiBUaGlz
IHByZXZlbnRzIHRoZQ0KPiB1c2Vyc3BhY2UgZnJvbSBtbWFwKCknaW5nICh3aXRoIE1BUF9G
SVhFRCkgYSBnbnRkZXYgbWFwcGluZyBvdmVyIHRoZQ0KPiBzYW1lIGFkZHJlc3MgcmFuZ2Ug
YXMgYSBwcmV2aW91c2x5IHNldCB1cCBnbnRkZXYgbWFwcGluZy4gVGhpcyBzY2VuYXJpbw0K
PiBjYW4gYmUgc3VtbWFyaXplZCB3aXRoIHRoZSBmb2xsb3dpbmcgY2FsbC10cmFjZSwgd2hp
Y2ggd2FzIHZhbGlkIHByaW9yDQo+IHRvIHRoaXMgY29tbWl0Og0KPiANCj4gICAgbW1hcA0K
PiAgICAgIGdudGRldl9tbWFwDQo+ICAgIG1tYXAgKHJlcGVhdCBtbWFwIHdpdGggTUFQX0ZJ
WEVEIG92ZXIgdGhlIHNhbWUgYWRkcmVzcyByYW5nZSkNCj4gICAgICBnbnRkZXZfaW52YWxp
ZGF0ZQ0KPiAgICAgICAgdW5tYXBfZ3JhbnRfcGFnZXMgKHNldHMgJ2JlaW5nX3JlbW92ZWQn
IGVudHJpZXMgdG8gdHJ1ZSkNCj4gICAgICAgICAgZ250dGFiX3VubWFwX3JlZnNfYXN5bmMN
Cj4gICAgICB1bm1hcF9zaW5nbGVfdm1hDQo+ICAgICAgZ250ZGV2X21tYXAgKG1hcHMgdGhl
IHNoYXJlZCBwYWdlcyBhZ2FpbikNCj4gICAgbXVubWFwDQo+ICAgICAgZ250ZGV2X2ludmFs
aWRhdGUNCj4gICAgICAgIHVubWFwX2dyYW50X3BhZ2VzDQo+ICAgICAgICAgIChuby1vcCBi
ZWNhdXNlICdiZWluZ19yZW1vdmVkJyBlbnRyaWVzIGFyZSB0cnVlKQ0KPiAgICAgIHVubWFw
X3NpbmdsZV92bWEgKFhlbiByZXBvcnRzIHRoYXQgYSBncmFudGVkIHBhZ2UgaXMgYmVpbmcN
Cj4gICAgICAgIHVubWFwcGVkIGFuZCB0cmlnZ2VycyBhIGdlbmVyYWwgcHJvdGVjdGlvbiBm
YXVsdCBpbiBkb20wDQo+ICAgICAgICBpZiBYZW4gd2FzIGJ1aWx0IHdpdGggQ09ORklHX0RF
QlVHKQ0KPiANCj4gVGhlIGZpeCBmb3IgdGhpcyBsYXN0IHNjZW5hcmlvIGNvdWxkIGJlIHdv
cnRoIGl0cyBvd24gY29tbWl0LCBidXQgd2UNCj4gb3B0ZWQgZm9yIGEgc2luZ2xlIGNvbW1p
dCwgYmVjYXVzZSByZW1vdmluZyB0aGUgZ250ZGV2X2dyYW50X21hcA0KPiBzdHJ1Y3R1cmUn
cyB2bWEgZmllbGQgcmVxdWlyZXMgZ3VhcmRpbmcgdGhlIGVudHJ5IHRvIGdudGRldl9tbWFw
KCksIGFuZA0KPiB0aGUgbGl2ZV9ncmFudHMgYXRvbWljIGNvdW50ZXIgaXMgbm90IHN1ZmZp
Y2llbnQgb24gaXRzIG93biB0byBwcmV2ZW50DQo+IHRoZSBtbWFwKCkgb3ZlciBhIHByZS1l
eGlzdGluZyBtYXBwaW5nLg0KPiANCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL1F1YmVz
T1MvcXViZXMtaXNzdWVzL2lzc3Vlcy83NjMxDQo+IEZpeGVzOiBhYjMxNTIzYzJmY2EgKCJ4
ZW4vZ250ZGV2OiBhbGxvdyB1c2VybW9kZSB0byBtYXAgZ3JhbnRlZCBwYWdlcyIpDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE0uIFZlZmEgQmlj
YWtjaSA8bS52LmJAcnVuYm94LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------WLb5L0dbJE4aWejsnRRU0psh
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WLb5L0dbJE4aWejsnRRU0psh--

--------------6q5orJvlsQYaVIVVg9B4f2nF--

--------------taO9UrUHsRh2N1i26QA65PFP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMoRVIFAwAAAAAACgkQsN6d1ii/Ey8o
XwgAl4AT7Yj7lhtuq6ecnq/Zj8+/sUnv1oVssk4oS6NSlyVUlu+wyB0rCVXOSu4LLsRN6XW7ZCeU
hG8scPfJiM+5/fC806wGuAlMWciJzu2JeizRclnE7Q5+FzHwvOYelUdrjydXNZRC964WCJEXGNgJ
YRMN7OEGRtatkjibRubq/uIGSAokfG85sF9J9BfkHu7QGIOb/xf5tMSff6spHDhinth/eQAJwQK8
wlymY5veUNIDoErxri564T7vuiAN3YXoHAg2iB0qT31H0oAs3xjY5s4KmwiRDmoneP/N/KpEbAEh
B36XsvXZHpGk8rB8KSiaLZMyj4NUFwgLfxlJeHoVIQ==
=650t
-----END PGP SIGNATURE-----

--------------taO9UrUHsRh2N1i26QA65PFP--
