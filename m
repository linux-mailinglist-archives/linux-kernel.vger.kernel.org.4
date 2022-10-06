Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244695F6451
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJFKY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:24:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410E895D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:24:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50B121F8B0;
        Thu,  6 Oct 2022 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665051861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3fHVkVxTAWcYkVXviVrHSDtYowg1Eq007d+zP0+0r14=;
        b=apBWFh/dNkA2V7M7Cs0J40QYDiStbw1/fi9zRSQ7SePeJcAYQDFW6HyPapH4hdupuftUYc
        TUW3RF7RO9XeBvvVhXMReod9AbEIzSh+aLWScHLb9LEgVmm4EkiSYPZpcdtgFv/t+NxjWv
        TSd/iLQlqGAfAosCGipDZQa6jDIY84w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E4BA13AC8;
        Thu,  6 Oct 2022 10:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XhznBdWsPmPCbgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 10:24:21 +0000
Message-ID: <df17af24-632c-6087-43e0-9e4079959437@suse.com>
Date:   Thu, 6 Oct 2022 12:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20221005174823.1800761-1-olekstysh@gmail.com>
 <20221005174823.1800761-2-olekstysh@gmail.com>
 <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
 <85471e4e-086a-6229-7fd1-e1d5556b94ed@suse.com>
 <CAPD2p-kuXfeQ8G63tSwi4H1Wz8ygwJnp3q1ZXFHi+k+knwT-EA@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAPD2p-kuXfeQ8G63tSwi4H1Wz8ygwJnp3q1ZXFHi+k+knwT-EA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QJQ0BzZYEd7W3FpBoBrwyC4J"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QJQ0BzZYEd7W3FpBoBrwyC4J
Content-Type: multipart/mixed; boundary="------------VBQYfDk6VWcgYtEKBXvgrLOD";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <df17af24-632c-6087-43e0-9e4079959437@suse.com>
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
References: <20221005174823.1800761-1-olekstysh@gmail.com>
 <20221005174823.1800761-2-olekstysh@gmail.com>
 <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
 <85471e4e-086a-6229-7fd1-e1d5556b94ed@suse.com>
 <CAPD2p-kuXfeQ8G63tSwi4H1Wz8ygwJnp3q1ZXFHi+k+knwT-EA@mail.gmail.com>
In-Reply-To: <CAPD2p-kuXfeQ8G63tSwi4H1Wz8ygwJnp3q1ZXFHi+k+knwT-EA@mail.gmail.com>

--------------VBQYfDk6VWcgYtEKBXvgrLOD
Content-Type: multipart/mixed; boundary="------------Bp8ijxsi8icv2zMYc0WPinxX"

--------------Bp8ijxsi8icv2zMYc0WPinxX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMTI6MTQsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIFRodSwgT2N0IDYsIDIwMjIgYXQgMTE6MDUgQU0gSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tIA0KPiA8bWFpbHRvOmpncm9zc0BzdXNlLmNvbT4+IHdyb3RlOg0KPiAN
Cj4gICAgIE9uIDA2LjEwLjIyIDA5OjM1LCBYZW5pYSBSYWdpYWRha291IHdyb3RlOg0KPiAN
Cj4gDQo+IA0KPiBIZWxsb8KgWGVuaWEswqBKdWVyZ2VuDQo+IA0KPiBbc29ycnkgZm9yIHRo
ZSBwb3NzaWJsZSBmb3JtYXQgaXNzdWVzXQ0KPiANCj4gICAgICA+DQo+ICAgICAgPiBPbiAx
MC81LzIyIDIwOjQ4LCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4gICAgICA+PiBG
cm9tOiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5j
b20NCj4gICAgIDxtYWlsdG86b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+Pg0KPiAg
ICAgID4+DQo+ICAgICAgPj4gVGFrZSBwYWdlIG9mZnNldCBpbnRvIHRoZSBhY2NvdW50IHdo
ZW4gY2FsY3VsYXRpbmcgdGhlIG51bWJlciBvZiBwYWdlcw0KPiAgICAgID4+IHRvIGJlIGdy
YW50ZWQuDQo+ICAgICAgPj4NCj4gICAgICA+PiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIg
VHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20NCj4gICAgIDxtYWls
dG86b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+Pg0KPiAgICAgID4+IEZpeGVzOiBk
NmFjYTM1MDRjN2QgKCJ4ZW4vZ3JhbnQtZG1hLW9wczogQWRkIG9wdGlvbiB0byByZXN0cmlj
dCBtZW1vcnkNCj4gICAgIGFjY2Vzcw0KPiAgICAgID4+IHVuZGVyIFhlbiIpDQo+ICAgICAg
Pj4gLS0tDQo+ICAgICAgPj4gwqAgZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jIHwgNSAr
KystLQ0KPiAgICAgID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ICAgICAgPj4NCj4gICAgICA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy94ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+
ICAgICAgPj4gaW5kZXggODk3M2ZjMWU5Y2NjLi4xOTk4ZDBlOGNlODIgMTAwNjQ0DQo+ICAg
ICAgPj4gLS0tIGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+ICAgICAgPj4gKysr
IGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+ICAgICAgPj4gQEAgLTE1Myw3ICsx
NTMsNyBAQCBzdGF0aWMgZG1hX2FkZHJfdCB4ZW5fZ3JhbnRfZG1hX21hcF9wYWdlKHN0cnVj
dCBkZXZpY2UNCj4gICAgICA+PiAqZGV2LCBzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4gICAgICA+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIGF0dHJzKQ0KPiAgICAgID4+IMKgIHsNCj4gICAgICA+PiDCoMKgwqDCoMKgIHN0
cnVjdCB4ZW5fZ3JhbnRfZG1hX2RhdGEgKmRhdGE7DQo+ICAgICAgPj4gLcKgwqDCoCB1bnNp
Z25lZCBpbnQgaSwgbl9wYWdlcyA9IFBGTl9VUChzaXplKTsNCj4gICAgICA+PiArwqDCoMKg
IHVuc2lnbmVkIGludCBpLCBuX3BhZ2VzID0gUEZOX1VQKG9mZnNldCArIHNpemUpOw0KPiAg
ICAgID4NCj4gICAgICA+IEhlcmUsIHdoeSBkbyB3ZSB1c2UgUEZOX1VQIGFuZCBub3QgWEVO
X1BGTl9VUD8NCj4gICAgICA+IEFsc28sIHNpbmNlIHRoZSB2YXJpYWJsZSAnbl9wYWdlcycg
c2VlbXMgdG8gcmVmZXIgdG8gdGhlIG51bWJlciBvZiBncmFudHMNCj4gICAgICA+ICh1bmxl
c3MgSSBnb3QgaXQgYWxsIGVudGlyZWx5IHdyb25nIC4uLiksIHdvdWxkbid0IGl0IGJlIG1v
cmUgc3VpdGFibGUgdG8NCj4gICAgIGNhbGwNCj4gICAgICA+IGV4cGxpY2l0bHkgZ250dGFi
X2NvdW50X2dyYW50KCk/DQo+IA0KPiAgICAgR29vZCBwb2ludC4NCj4gDQo+IA0KPiArMQ0K
PiANCj4gDQo+ICAgICBJIHRoaW5rIHRoaXMgd2lsbCBuZWVkIGFub3RoZXIgcGF0Y2ggZm9y
IHN3aXRjaGluZyBncmFudC1kbWEtb3BzLmMgdG8NCj4gICAgIHVzZSBYRU5fUEFHRV9TSVpF
IGFuZCBYRU5fUEFHRV9TSElGVC4NCj4gDQo+IA0KPiArMQ0KPiANCj4gSSBjYW4gY3JlYXRl
IGEgc2VwYXJhdGUgcGF0Y2ggZm9yIGNvbnZlcnRpbmcgb24gdG9wIG9mIHRoaXMgc2VyaWVz
LCBpdCB3b3VsZCBiZSANCj4gbmljZSB0byBjbGFyaWZ5IG9uZcKgcG9pbnQuDQo+IA0KPiBT
byBJIHdpbGwgY29udmVydCBQQUdFX1NJWkUvUEFHRV9TSElGVCB0byBYRU5fUEFHRV9TSVpF
L1hFTl9QQUdFX1NISUZUIA0KPiByZXNwZWN0aXZlbHkgKHdoZXJlIGFwcHJvcHJpYXRlKS4N
Cg0KWWVzLCB0aGF0IHdvdWxkIGJlIHRoZSBpZGVhLg0KDQo+IFNob3VsZCB0aGUgUEZOX1VQ
IGJlwqBjb252ZXJ0ZWQgdG8gWEVOX1BGTl9VUCAqb3IqIHVzZSANCj4gZ250dGFiX2NvdW50
X2dyYW50KCnCoGV4cGxpY2l0bHk/IFBlcnNvbmFsbHkgSSB3b3VsZCBwcmVmZXIgdGhlIGZv
cm1lciwgYnV0IHdvdWxkIA0KPiBhbHNvIGJlIG9rIHdpdGggdGhlIGxhdHRlci4NCg0KSSBh
Z3JlZSBYRU5fUEZOX1VQIHdvdWxkIGJlIGJldHRlciwgZXNwZWNpYWxseSBhcyBYRU5fUEFH
RV9TSVpFL1hFTl9QQUdFX1NISUZUDQp3aWxsIGJlIHVzZWQgaW4gdGhlIHNhbWUgZnVuY3Rp
b25zLg0KDQoNCkp1ZXJnZW4NCg==
--------------Bp8ijxsi8icv2zMYc0WPinxX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Bp8ijxsi8icv2zMYc0WPinxX--

--------------VBQYfDk6VWcgYtEKBXvgrLOD--

--------------QJQ0BzZYEd7W3FpBoBrwyC4J
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM+rNQFAwAAAAAACgkQsN6d1ii/Ey9W
1Af/XIsM2iwWM+ozYhxCwR01i0jqkLtvW3nB3Y01DLub/jopoGswxB4E/OpzF7dMmkI1X4LA8Zs6
Gtjr4kIndL/nHYLLkKQl5JG2Wf0EBr2T96c9L8e2l3Liv4HhofZn1AuU/5IYTVJq512xkFtLw4C5
NAnKgmPhvwSiBsTPlH1CgUGXsUA1GaMPDkyjpZOLCnQaIzAecUnyQdNgLprM4KmB7alOisPNil9e
zybQEcUAo+0mVvlx9GNGYoaadcOVGmGp+9hm+TwHaqOOw4aojG2vu3cHRVzeKiHv0CiHob7hSnHX
1WfG1Zxh6aPm52LbRPWPJ9VzqnC+1p0n2FiIVDNsTA==
=ZOVZ
-----END PGP SIGNATURE-----

--------------QJQ0BzZYEd7W3FpBoBrwyC4J--
