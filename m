Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AAB5F73DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJGFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGFRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:17:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD9BC4596
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 22:17:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CE761F8CA;
        Fri,  7 Oct 2022 05:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665119862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zrm6Wc+cYsGICXIrvOSQaUWN6L6oSr49mpVFNBqOZrg=;
        b=XA0ODdRJ+yVw3qcB6zwsGKKwVieknSmf0qC7HnLqfoEmS2wItOP0HWIsk79OyiB/HOUyU9
        jXbug179Mfkjxo3huHtS5FIlLX1kZxwnGr3fIArbnohoTvNjWqF81+5+vYiQLwN4NsK8rf
        e/Lskrmn/+lgL/2nn/yGdAZ0A8H8BAs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD9DA13345;
        Fri,  7 Oct 2022 05:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dRBMHW2P2PgLAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 05:17:41 +0000
Message-ID: <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
Date:   Fri, 7 Oct 2022 07:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] xen/gntdev: Fixes for leaks and VMA splitting
Content-Language: en-US
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20221002222006.2077-1-m.v.b@runbox.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221002222006.2077-1-m.v.b@runbox.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XVXLrARPWfnvGr02GkSvkKP9"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XVXLrARPWfnvGr02GkSvkKP9
Content-Type: multipart/mixed; boundary="------------8CduX9LunJEd0aizjbOGzcP3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "M. Vefa Bicakci" <m.v.b@runbox.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
Subject: Re: [PATCH v2 0/2] xen/gntdev: Fixes for leaks and VMA splitting
References: <20221002222006.2077-1-m.v.b@runbox.com>
In-Reply-To: <20221002222006.2077-1-m.v.b@runbox.com>

--------------8CduX9LunJEd0aizjbOGzcP3
Content-Type: multipart/mixed; boundary="------------MS0Hml100OrkEs5C7vmMaYEN"

--------------MS0Hml100OrkEs5C7vmMaYEN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTAuMjIgMDA6MjAsIE0uIFZlZmEgQmljYWtjaSB3cm90ZToNCj4gSGkgYWxsLA0K
PiANCj4gRmlyc3Qgb2YgYWxsLCBzb3JyeSBmb3IgdGhlIGRlbGF5IQ0KPiANCj4gVGhlc2Ug
cGF0Y2hlcyBjb250aW51ZSB0aGUgY29kZSByZXZpZXcgZm9yIHRoZSBmb2xsb3dpbmcgcGF0
Y2hlczoNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzIwMjIwOTEy
MDQwMDAyLjE5ODE5MS0xLW0udi5iQHJ1bmJveC5jb20vdC8jdQ0KPiANCj4gVGhlIG9yaWdp
bmFsIGRlc2NyaXB0aW9uIG9mIHRoZSBwYXRjaCBzZXQgaXMgYXMgZm9sbG93czoNCj4gDQo+
ICAgICJUaGUgY2hhbmdlcyBpbiB0aGlzIHBhdGNoIHNlcmllcyBpbnRlbmQgdG8gZml4IHRo
ZSBYZW4gZ3JhbnQgZGV2aWNlDQo+ICAgIGRyaXZlciwgc28gdGhhdCBncmFudCBtYXBwaW5n
IGxlYWtzIGNhdXNlZCBieSBwYXJ0aWFsbHkgZmFpbGVkIGdyYW50DQo+ICAgIG1hcHBpbmcg
b3BlcmF0aW9ucyBhcmUgYXZvaWRlZCB3aXRoIHRoZSBmaXJzdCBwYXRjaCwgYW5kIHNvIHRo
YXQgdGhlDQo+ICAgIHNwbGl0dGluZyBvZiBWTUFzIGRvZXMgbm90IHJlc3VsdCBpbiBpbmNv
cnJlY3RseSB1bm1hcHBlZCBncmFudCBwYWdlcw0KPiAgICB3aXRoIHRoZSBzZWNvbmQgcGF0
Y2guIFRoZSBzZWNvbmQgcGF0Y2ggYWxzbyBwcmV2ZW50cyBhIHNpbWlsYXIgaXNzdWUNCj4g
ICAgaW4gYSBkb3VibGUtbWFwcGluZyBzY2VuYXJpbywgd2hlcmUgbW1hcCgpIGlzIHVzZWQg
d2l0aCBNQVBfRklYRUQgdG8NCj4gICAgbWFwIGdyYW50cyBvdmVyIGFuIGV4aXN0aW5nIG1h
cHBpbmcgY3JlYXRlZCB3aXRoIHRoZSBzYW1lIGdyYW50cywgYW5kDQo+ICAgIHdoZXJlIGdy
YW50IHBhZ2VzIGFyZSB1bm1hcHBlZCBpbmNvcnJlY3RseSBhcyB3ZWxsLiINCj4gDQo+IEEg
c3VtbWFyeSBvZiB0aGUgY2hhbmdlcyBmcm9tIHYxIGlzIGFzIGZvbGxvd3M6DQo+IC0gQWRk
cmVzc2VkIEp1ZXJnZW4ncyBjb2RlIHJldmlldyBjb21tZW50IHJlZ2FyZGluZyB0aGUgZmly
c3QgcGF0Y2guDQo+IC0gQW1lbmRlZCB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIHNlY29uZCBw
YXRjaCB0byBub3RlIHRoYXQgdGhlIGRlc2NyaWJlZA0KPiAgICBpc3N1ZXMgYXJlIGVuY291
bnRlcmVkIHdpdGggUFYgZG9tYWlucy4NCj4gDQo+IFZlcmlmaWNhdGlvbiBub3RlczoNCj4g
DQo+IC0gSSBoYXZlIHRlc3RlZCB0aGVzZSBjb21taXRzIG9uIHRvcCBvZiBMaW51eCB2NS4x
NS43MCBhbmQgdjUuMTUuNzEsIGFuZA0KPiAgICBJIHZlcmlmaWVkIHRoYXQgdGhleSBjb21w
aWxlIHN1Y2Nlc3NmdWxseSBvbiB0b3Agb2YgdGhlIHRhZw0KPiAgICAibmV4dC0yMDIyMDkz
MCIsIHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZSBiYXNlIGNvbW1pdCBJRCBpbmNsdWRlZCBh
dA0KPiAgICB0aGUgYm90dG9tIG9mIHRoaXMgZS1tYWlsLg0KPiANCj4gLSBNeSB0ZXN0cyBj
b25zaXN0IG9mIHVzaW5nIGEga2VybmVsIHdpdGggUXViZXMgT1MgdjQuMSdzIHBhdGNoZXMg
YW5kDQo+ICAgIHRoZXNlIHBhdGNoZXMgb24gbXkgbWFpbiBjb21wdXRlciBmb3IgZGF5LXRv
LWRheSB0YXNrcywgaW4gY29uanVuY3Rpb24NCj4gICAgd2l0aCBRdWJlcyBPUydzIHZlcnNp
b24gb2YgdGhlIFhlbiBoeXBlcnZpc29yIHY0LjE0LjUsIHdpdGggdGhlIGxhdHRlcg0KPiAg
ICBjdXN0b20tY29tcGlsZWQgd2l0aCBDT05GSUdfREVCVUcuDQo+IA0KPiAtIEkgdXNlZCBh
IHRlc3QgcHJvZ3JhbSB0aGF0IHZlcmlmaWVzIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zIHdp
dGggYW4NCj4gICAgdW5wcml2aWxlZ2VkIHBhcmF2aXJ0dWFsaXplZCAoUFYpIFhlbiBkb21h
aW46DQo+IA0KPiAgICAtIEEgcHJvZ3JhbSBtbWFwKClzIHR3byBwYWdlcyBmcm9tIGFub3Ro
ZXIgWGVuIGRvbWFpbiBhbmQgbXVubWFwKClzDQo+ICAgICAgdGhlIHBhZ2VzIG9uZSBieSBv
bmUuIFRoaXMgdXNlZCB0byByZXN1bHQgaW4gaW1wbGljaXQgdW5tYXAgZXJyb3JzDQo+ICAg
ICAgdG8gYmUgcmVwb3J0ZWQgYnkgWGVuIGFuZCBhIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVs
dCB0byBiZSB0cmlnZ2VyZWQNCj4gICAgICBieSBYZW4gaW4gdGhlIGFmZmVjdGVkIGRvbWFp
biwgYnV0IG5vdyB3b3JrcyBhcyBleHBlY3RlZC4NCj4gICAgLSBBIHByb2dyYW0gbW1hcCgp
cyB0d28gcGFnZXMgZnJvbSBhbm90aGVyIFhlbiBkb21haW4gYW5kIHRoZW4NCj4gICAgICBh
dHRlbXB0cyB0byByZW1hcCAodmlhIE1BUF9GSVhFRCkgdGhlIHNhbWUgbWFwcGluZyBhZ2Fp
biBvdmVyIHRoZQ0KPiAgICAgIHNhbWUgdmlydHVhbCBhZGRyZXNzLiBUaGlzIHVzZWQgdG8g
cmVzdWx0IGluIHNpbWlsYXIgaXNzdWVzDQo+ICAgICAgKGltcGxpY2l0IHVubWFwIGVycm9y
cyBhbmQgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0KSwgYnV0IG5vdyBpcw0KPiAgICAgIHJl
amVjdGVkIGJ5IHRoZSBrZXJuZWwuDQo+ICAgIC0gQSBwcm9ncmFtIG1tYXAoKXMgdHdvIHBh
Z2VzIGZyb20gYW5vdGhlciBYZW4gZG9tYWluIGFuZCB0aGVuDQo+ICAgICAgYXR0ZW1wdHMg
dG8gbW1hcCgpIHRoZSBzYW1lIG1hcHBpbmcgYWdhaW4gdG8gYSBkaWZmZXJlbnQgdmlydHVh
bA0KPiAgICAgIGFkZHJlc3MsIGJ5IHBhc3NpbmcgTlVMTCBhcyBtbWFwKCkncyBmaXJzdCBh
cmd1bWVudC4gVGhpcyB1c2VkIHRvIGJlDQo+ICAgICAgcmVqZWN0ZWQgYnkgdGhlIGtlcm5l
bCwgYW5kIGl0IGNvbnRpbnVlcyB0byBiZSByZWplY3RlZCBieSB0aGUNCj4gICAgICBrZXJu
ZWwuDQo+IA0KPiAtIFVucHJpdmlsZWdlZCBQVkggWGVuIGRvbWFpbnMgd2VyZSBhbHNvIHNh
bml0eSB0ZXN0ZWQgd2l0aCB0aGUgc2FtZQ0KPiAgICB0ZXN0IHByb2dyYW0uIEkgc2hvdWxk
IG5vdGUgdGhhdCBQVkggZG9tYWlucyB3b3JrZWQgYXMgZXhwZWN0ZWQNCj4gICAgd2l0aG91
dCB0aGVzZSBwYXRjaGVzIHRvby4NCj4gDQo+IC0gRmluYWxseSwgSSBoYXZlIHZlcmlmaWVk
IHRoYXQgdGhlIG9yaWdpbmFsICJnLmUuIDB4MTIzNCBzdGlsbCBwZW5kaW5nIg0KPiAgICBp
c3N1ZSBkb2VzIG5vdCBhcHBlYXIgYWZ0ZXIgcmFwaWRseSByZXNpemluZyBHVUkgd2luZG93
cyBpbiBRdWJlcyBPUw0KPiAgICB2NC4xLg0KDQpTZXJpZXMgcHVzaGVkIHRvIHhlbi90aXAu
Z2l0IGZvci1saW51cy02LjENCg0KDQpKdWVyZ2VuDQoNCg==
--------------MS0Hml100OrkEs5C7vmMaYEN
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------MS0Hml100OrkEs5C7vmMaYEN--

--------------8CduX9LunJEd0aizjbOGzcP3--

--------------XVXLrARPWfnvGr02GkSvkKP9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM/tnUFAwAAAAAACgkQsN6d1ii/Ey9s
9wf+PcgWSXtUZ0T6HsJ/UghG07f8HEcW11vT6tZ3+FjPs2GDMiIJfvpAnlys6Syh0DWST2MK4VC+
JJzLvwCkNkPfMEFdohWuRtLyju3LStD4NcVQ4vdFM/U9a36iBNpb/+H+1SrSgy2Lm47GQGCyV/fO
4T34mtZy5q4Cyx/2FswlK1eOb5hDjpEum6rgl1rWgz+zmEs+zki6dFHppWFLYzFvMKmyAkBGXtGc
t6kBq2ajBYS5C7zMTyHDHuE7OrB/HWu3PyYiERZOQ9P8WRXtLJ9rzL2/HHHKPPBKeJ+CUNlt6A6+
tOpDxnlqyjMNFgRe8c+l1k8Bk2hN0skCppcBeoOHlA==
=Eelx
-----END PGP SIGNATURE-----

--------------XVXLrARPWfnvGr02GkSvkKP9--
