Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9065F62D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJFIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJFIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:36:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE2894104
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BA2E1F8DB;
        Thu,  6 Oct 2022 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665045365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8OpqC5umbKgqiaka26/pXGCBnRqENWb8B6kLTdT2dc=;
        b=sgHRA37TgmSq54o9uDZxlpNBCFSajYwxT9XBkt9rGdIHXhcBKRRoU2jfz4FX1kE5HOoVHj
        c5tukEKYp0bmQ81AcNw+aKrfaGMQwXjHne+8sXkgEEkkRHKKE3UCtHNd4GAIW2tduKrIdX
        Xcb//cPZrVozbQmVrJMZsswevoq512E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6093213AC8;
        Thu,  6 Oct 2022 08:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 20tAFnWTPmP6OAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 08:36:05 +0000
Message-ID: <f75479fe-7435-0674-94b0-db15309c38ec@suse.com>
Date:   Thu, 6 Oct 2022 10:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] xen/gntdev: Accommodate VMA splitting
Content-Language: en-US
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <20221002222006.2077-3-m.v.b@runbox.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221002222006.2077-3-m.v.b@runbox.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YUf2JIU0T5hI2YUDORbtxdoq"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YUf2JIU0T5hI2YUDORbtxdoq
Content-Type: multipart/mixed; boundary="------------IjGgoXtuxp2V0zqgHSgK9e2I";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "M. Vefa Bicakci" <m.v.b@runbox.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <f75479fe-7435-0674-94b0-db15309c38ec@suse.com>
Subject: Re: [PATCH v2 2/2] xen/gntdev: Accommodate VMA splitting
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <20221002222006.2077-3-m.v.b@runbox.com>
In-Reply-To: <20221002222006.2077-3-m.v.b@runbox.com>

--------------IjGgoXtuxp2V0zqgHSgK9e2I
Content-Type: multipart/mixed; boundary="------------kjoMmuO0jETWZQqqeRFMErhi"

--------------kjoMmuO0jETWZQqqeRFMErhi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTAuMjIgMDA6MjAsIE0uIFZlZmEgQmljYWtjaSB3cm90ZToNCj4gUHJpb3IgdG8g
dGhpcyBjb21taXQsIHRoZSBnbnRkZXYgZHJpdmVyIGNvZGUgZGlkIG5vdCBoYW5kbGUgdGhl
DQo+IGZvbGxvd2luZyBzY2VuYXJpbyBjb3JyZWN0bHkgd2l0aCBwYXJhdmlydHVhbGl6ZWQg
KFBWKSBYZW4gZG9tYWluczoNCj4gDQo+ICogVXNlciBwcm9jZXNzIHNldHMgdXAgYSBnbnRk
ZXYgbWFwcGluZyBjb21wb3NlZCBvZiB0d28gZ3JhbnQgbWFwcGluZ3MNCj4gICAgKGkuZS4s
IHR3byBwYWdlcyBzaGFyZWQgYnkgYW5vdGhlciBYZW4gZG9tYWluKS4NCj4gKiBVc2VyIHBy
b2Nlc3MgbXVubWFwKClzIG9uZSBvZiB0aGUgcGFnZXMuDQo+ICogVXNlciBwcm9jZXNzIG11
bm1hcCgpcyB0aGUgcmVtYWluaW5nIHBhZ2UuDQo+ICogVXNlciBwcm9jZXNzIGV4aXRzLg0K
PiANCj4gSW4gdGhlIHNjZW5hcmlvIGFib3ZlLCB0aGUgdXNlciBwcm9jZXNzIHdvdWxkIGNh
dXNlIHRoZSBrZXJuZWwgdG8gbG9nDQo+IHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgaW4gZG1l
c2cgZm9yIHRoZSBmaXJzdCBtdW5tYXAoKSwgYW5kIHRoZSBzZWNvbmQNCj4gbXVubWFwKCkg
Y2FsbCB3b3VsZCByZXN1bHQgaW4gc2ltaWxhciBsb2cgbWVzc2FnZXM6DQo+IA0KPiAgICBC
VUc6IEJhZCBwYWdlIG1hcCBpbiBwcm9jZXNzIGRvdWJsZW1hcC50ZXN0ICBwdGU6Li4uIHBt
ZDouLi4NCj4gICAgcGFnZTowMDAwMDAwMDU3Yzk3YmZmIHJlZmNvdW50OjEgbWFwY291bnQ6
LTEgXA0KPiAgICAgIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOi4u
Lg0KPiAgICAuLi4NCj4gICAgcGFnZSBkdW1wZWQgYmVjYXVzZTogYmFkIHB0ZQ0KPiAgICAu
Li4NCj4gICAgZmlsZTpnbnRkZXYgZmF1bHQ6MHgwIG1tYXA6Z250ZGV2X21tYXAgW3hlbl9n
bnRkZXZdIHJlYWRwYWdlOjB4MA0KPiAgICAuLi4NCj4gICAgQ2FsbCBUcmFjZToNCj4gICAg
IDxUQVNLPg0KPiAgICAgZHVtcF9zdGFja19sdmwrMHg0Ni8weDVlDQo+ICAgICBwcmludF9i
YWRfcHRlLmNvbGQrMHg2Ni8weGI2DQo+ICAgICB1bm1hcF9wYWdlX3JhbmdlKzB4N2U1LzB4
ZGMwDQo+ICAgICB1bm1hcF92bWFzKzB4NzgvMHhmMA0KPiAgICAgdW5tYXBfcmVnaW9uKzB4
YTgvMHgxMTANCj4gICAgIF9fZG9fbXVubWFwKzB4MWVhLzB4NGUwDQo+ICAgICBfX3ZtX211
bm1hcCsweDc1LzB4MTIwDQo+ICAgICBfX3g2NF9zeXNfbXVubWFwKzB4MjgvMHg0MA0KPiAg
ICAgZG9fc3lzY2FsbF82NCsweDM4LzB4OTANCj4gICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDYxLzB4Y2INCj4gICAgIC4uLg0KPiANCj4gRm9yIGVhY2ggbXVubWFw
KCkgY2FsbCwgdGhlIFhlbiBoeXBlcnZpc29yIChpZiBidWlsdCB3aXRoIENPTkZJR19ERUJV
RykNCj4gd291bGQgcHJpbnQgb3V0IHRoZSBmb2xsb3dpbmcgYW5kIHRyaWdnZXIgYSBnZW5l
cmFsIHByb3RlY3Rpb24gZmF1bHQgaW4NCj4gdGhlIGFmZmVjdGVkIFhlbiBQViBkb21haW46
DQo+IA0KPiAgICAoWEVOKSBkMHYuLi4gQXR0ZW1wdCB0byBpbXBsaWNpdGx5IHVubWFwIGQw
J3MgZ3JhbnQgUFRFIC4uLg0KPiAgICAoWEVOKSBkMHYuLi4gQXR0ZW1wdCB0byBpbXBsaWNp
dGx5IHVubWFwIGQwJ3MgZ3JhbnQgUFRFIC4uLg0KPiANCj4gQXMgb2YgdGhpcyB3cml0aW5n
LCBnbnRkZXZfZ3JhbnRfbWFwIHN0cnVjdHVyZSdzIHZtYSBmaWVsZCAocmVmZXJyZWQgdG8N
Cj4gYXMgbWFwLT52bWEgYmVsb3cpIGlzIG1haW5seSB1c2VkIGZvciBjaGVja2luZyB0aGUg
c3RhcnQgYW5kIGVuZA0KPiBhZGRyZXNzZXMgb2YgbWFwcGluZ3MuIEhvd2V2ZXIsIHdpdGgg
c3BsaXQgVk1BcywgdGhlc2UgbWF5IGNoYW5nZSwgYW5kDQo+IHRoZXJlIGNvdWxkIGJlIG1v
cmUgdGhhbiBvbmUgVk1BIGFzc29jaWF0ZWQgd2l0aCBhIGdudGRldiBtYXBwaW5nLg0KPiBI
ZW5jZSwgcmVtb3ZlIHRoZSB1c2Ugb2YgbWFwLT52bWEgYW5kIHJlbHkgb24gbWFwLT5wYWdl
c192bV9zdGFydCBmb3INCj4gdGhlIG9yaWdpbmFsIHN0YXJ0IGFkZHJlc3MgYW5kIG9uICht
YXAtPmNvdW50IDw8IFBBR0VfU0hJRlQpIGZvciB0aGUNCj4gb3JpZ2luYWwgbWFwcGluZyBz
aXplLiBMZXQgdGhlIGludmFsaWRhdGUoKSBhbmQgZmluZF9zcGVjaWFsX3BhZ2UoKQ0KPiBo
b29rcyB1c2UgdGhlc2UuDQo+IA0KPiBBbHNvLCBnaXZlbiB0aGF0IHRoZXJlIGNhbiBiZSBt
dWx0aXBsZSBWTUFzIGFzc29jaWF0ZWQgd2l0aCBhIGdudGRldg0KPiBtYXBwaW5nLCBtb3Zl
IHRoZSAibW11X2ludGVydmFsX25vdGlmaWVyX3JlbW92ZSgmbWFwLT5ub3RpZmllcikiIGNh
bGwgdG8NCj4gdGhlIGVuZCBvZiBnbnRkZXZfcHV0X21hcCwgc28gdGhhdCB0aGUgTU1VIG5v
dGlmaWVyIGlzIG9ubHkgcmVtb3ZlZA0KPiBhZnRlciB0aGUgY2xvc2luZyBvZiB0aGUgbGFz
dCByZW1haW5pbmcgVk1BLg0KPiANCj4gRmluYWxseSwgdXNlIGFuIGF0b21pYyB0byBwcmV2
ZW50IGluYWR2ZXJ0ZW50IGdudGRldiBtYXBwaW5nIHJlLXVzZSwNCj4gaW5zdGVhZCBvZiB1
c2luZyB0aGUgbWFwLT5saXZlX2dyYW50cyBhdG9taWMgY291bnRlciBhbmQvb3IgdGhlIG1h
cC0+dm1hDQo+IHBvaW50ZXIgKHRoZSBsYXR0ZXIgb2Ygd2hpY2ggaXMgbm93IHJlbW92ZWQp
LiBUaGlzIHByZXZlbnRzIHRoZQ0KPiB1c2Vyc3BhY2UgZnJvbSBtbWFwKCknaW5nICh3aXRo
IE1BUF9GSVhFRCkgYSBnbnRkZXYgbWFwcGluZyBvdmVyIHRoZQ0KPiBzYW1lIGFkZHJlc3Mg
cmFuZ2UgYXMgYSBwcmV2aW91c2x5IHNldCB1cCBnbnRkZXYgbWFwcGluZy4gVGhpcyBzY2Vu
YXJpbw0KPiBjYW4gYmUgc3VtbWFyaXplZCB3aXRoIHRoZSBmb2xsb3dpbmcgY2FsbC10cmFj
ZSwgd2hpY2ggd2FzIHZhbGlkIHByaW9yDQo+IHRvIHRoaXMgY29tbWl0Og0KPiANCj4gICAg
bW1hcA0KPiAgICAgIGdudGRldl9tbWFwDQo+ICAgIG1tYXAgKHJlcGVhdCBtbWFwIHdpdGgg
TUFQX0ZJWEVEIG92ZXIgdGhlIHNhbWUgYWRkcmVzcyByYW5nZSkNCj4gICAgICBnbnRkZXZf
aW52YWxpZGF0ZQ0KPiAgICAgICAgdW5tYXBfZ3JhbnRfcGFnZXMgKHNldHMgJ2JlaW5nX3Jl
bW92ZWQnIGVudHJpZXMgdG8gdHJ1ZSkNCj4gICAgICAgICAgZ250dGFiX3VubWFwX3JlZnNf
YXN5bmMNCj4gICAgICB1bm1hcF9zaW5nbGVfdm1hDQo+ICAgICAgZ250ZGV2X21tYXAgKG1h
cHMgdGhlIHNoYXJlZCBwYWdlcyBhZ2FpbikNCj4gICAgbXVubWFwDQo+ICAgICAgZ250ZGV2
X2ludmFsaWRhdGUNCj4gICAgICAgIHVubWFwX2dyYW50X3BhZ2VzDQo+ICAgICAgICAgIChu
by1vcCBiZWNhdXNlICdiZWluZ19yZW1vdmVkJyBlbnRyaWVzIGFyZSB0cnVlKQ0KPiAgICAg
IHVubWFwX3NpbmdsZV92bWEgKEZvciBQViBkb21haW5zLCBYZW4gcmVwb3J0cyB0aGF0IGEg
Z3JhbnRlZCBwYWdlDQo+ICAgICAgICBpcyBiZWluZyB1bm1hcHBlZCBhbmQgdHJpZ2dlcnMg
YSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQgaW4gdGhlDQo+ICAgICAgICBhZmZlY3RlZCBk
b21haW4sIGlmIFhlbiB3YXMgYnVpbHQgd2l0aCBDT05GSUdfREVCVUcpDQo+IA0KPiBUaGUg
Zml4IGZvciB0aGlzIGxhc3Qgc2NlbmFyaW8gY291bGQgYmUgd29ydGggaXRzIG93biBjb21t
aXQsIGJ1dCB3ZQ0KPiBvcHRlZCBmb3IgYSBzaW5nbGUgY29tbWl0LCBiZWNhdXNlIHJlbW92
aW5nIHRoZSBnbnRkZXZfZ3JhbnRfbWFwDQo+IHN0cnVjdHVyZSdzIHZtYSBmaWVsZCByZXF1
aXJlcyBndWFyZGluZyB0aGUgZW50cnkgdG8gZ250ZGV2X21tYXAoKSwgYW5kDQo+IHRoZSBs
aXZlX2dyYW50cyBhdG9taWMgY291bnRlciBpcyBub3Qgc3VmZmljaWVudCBvbiBpdHMgb3du
IHRvIHByZXZlbnQNCj4gdGhlIG1tYXAoKSBvdmVyIGEgcHJlLWV4aXN0aW5nIG1hcHBpbmcu
DQo+IA0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vUXViZXNPUy9xdWJlcy1pc3N1ZXMv
aXNzdWVzLzc2MzENCj4gRml4ZXM6IGFiMzE1MjNjMmZjYSAoInhlbi9nbnRkZXY6IGFsbG93
IHVzZXJtb2RlIHRvIG1hcCBncmFudGVkIHBhZ2VzIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTS4gVmVmYSBCaWNha2NpIDxtLnYuYkBydW5i
b3guY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KDQoNCkp1ZXJnZW4NCg==
--------------kjoMmuO0jETWZQqqeRFMErhi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------kjoMmuO0jETWZQqqeRFMErhi--

--------------IjGgoXtuxp2V0zqgHSgK9e2I--

--------------YUf2JIU0T5hI2YUDORbtxdoq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM+k3UFAwAAAAAACgkQsN6d1ii/Ey9I
3wf/dobIWMjnzJ+7ZVzarL+TpoeVHIIZoipqIIxkjSbXjqaHNk+PbBC0hoPRUStK2cCwkjGrLNE4
QjQnoGoBOijwoLqudDoDO3zFlSV1OW9MBRSYgwsCfqwwjFdDa3S9rHbAPz5jhDbpKDCH0xgYxsTo
RpVyeLE1BylH15wZG1kKSGnhh50tsrwS65cxLZyF7aowrhuXx9NcsXNXeEwXCjqCWwGPPgC3Xtxr
pDYPsYYBX/cuaXKNo6fmauysAJqmnIxXKyhEzRNQ4ozTzXVgx9OnGtnsnFj3tcYbZuVVBZIA/uQ6
rmOUOpa+Z1m5ly7TpDVn7o2GjWbhORMnfbUPMJpWQg==
=SNzz
-----END PGP SIGNATURE-----

--------------YUf2JIU0T5hI2YUDORbtxdoq--
