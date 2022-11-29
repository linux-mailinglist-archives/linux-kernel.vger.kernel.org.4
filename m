Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E263C3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiK2P1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiK2P1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:27:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313301A39E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:27:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C12211FDDE;
        Tue, 29 Nov 2022 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669735648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXlM+yvFockFzQWFJtuOywTcr68TPYdF51NVeHyrMC4=;
        b=ic12lZLyUebEjX1uRTMeugjus9W7CYPinxpKDtCtrjkhTsYeuE0mg11xX2lQRP+RvvrAlB
        v4TAHTB5A7rxopdhmvDeK2ydiD0s5/PPYYyae+KeRAJsZF5WB7S/7NLZQSF82iETqN0toX
        f78tSyWqwVfQmOvDPhB2Y9J6noNdpGo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8613113AF6;
        Tue, 29 Nov 2022 15:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V+ETH+AkhmMzcwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 29 Nov 2022 15:27:28 +0000
Message-ID: <358e49fa-8ce7-67ce-8e0b-e523dee9ea19@suse.com>
Date:   Tue, 29 Nov 2022 16:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20221129150058.266943-1-per.bilse@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
In-Reply-To: <20221129150058.266943-1-per.bilse@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bX2PESQviO3CpgKBjxM6PRjP"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bX2PESQviO3CpgKBjxM6PRjP
Content-Type: multipart/mixed; boundary="------------X8D0eoeDEr15NPcmqFQSmGVr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jan Beulich
 <jbeulich@suse.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <358e49fa-8ce7-67ce-8e0b-e523dee9ea19@suse.com>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
References: <20221129150058.266943-1-per.bilse@citrix.com>
In-Reply-To: <20221129150058.266943-1-per.bilse@citrix.com>

--------------X8D0eoeDEr15NPcmqFQSmGVr
Content-Type: multipart/mixed; boundary="------------LNhIUa17THGTpfpqC5kv1FfE"

--------------LNhIUa17THGTpfpqC5kv1FfE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMTEuMjIgMTY6MDAsIFBlciBCaWxzZSB3cm90ZToNCj4gL3Byb2MveGVuIGlzIGEg
bGVnYWN5IHBzZXVkbyBmaWxlc3lzdGVtIHdoaWNoIHByZWRhdGVzIFhlbiBzdXBwb3J0DQo+
IGdldHRpbmcgbWVyZ2VkIGludG8gTGludXguICBJdCBoYXMgbGFyZ2VseSBiZWVuIHJlcGxh
Y2VkIHdpdGggbW9yZQ0KPiBub3JtYWwgbG9jYXRpb25zIGZvciBkYXRhICgvc3lzL2h5cGVy
dmlzb3IvIGZvciBpbmZvLCAvZGV2L3hlbi8gZm9yDQo+IHVzZXIgZGV2aWNlcykuICBXZSB3
YW50IHRvIGNvbXBpbGUgeGVuZnMgc3VwcG9ydCBvdXQgb2YgdGhlIGRvbTAga2VybmVsLg0K
PiANCj4gVGhlcmUgaXMgb25lIGl0ZW0gd2hpY2ggb25seSBleGlzdHMgaW4gL3Byb2MveGVu
LCBuYW1lbHkNCj4gL3Byb2MveGVuL2NhcGFiaWxpdGllcyB3aXRoICJjb250cm9sX2QiIGJl
aW5nIHRoZSBzaWduYWwgb2YgInlvdSdyZSBpbg0KPiB0aGUgY29udHJvbCBkb21haW4iLiAg
VGhpcyB1bHRpbWF0ZWx5IGNvbWVzIGZyb20gdGhlIFNJRiBmbGFncyBwcm92aWRlZA0KPiBh
dCBWTSBzdGFydC4NCj4gDQo+IFRoaXMgcGF0Y2ggZXhwb3NlcyBhbGwgU0lGIGZsYWdzIGlu
IC9zeXMvaHlwZXJ2aXNvci9wcm9wZXJ0aWVzL2ZsYWdzLA0KPiB3aGljaCB3aWxsIGNvZXhp
c3Qgd2l0aCAvcHJvYy94ZW4gd2hpbGUgZGVwZW5kZW5jaWVzIGFyZSBiZWluZyBtaWdyYXRl
ZC4NCj4gUG9zc2libGUgdmFsdWVzIGFyZSAicHJpdmlsZWdlZCIsICJpbml0ZG9tYWluIiwg
Im11bHRpYm9vdCIsDQo+ICJtb2Rfc3RhcnRfcGZuIiwgYW5kICJ2aXJ0bWFwIiwgd2l0aCAi
aW5pdGRvbWFpbiIgYmVpbmcgdGhlIGVxdWl2YWxlbnQNCj4gb2YgImNvbnRyb2xfZCIuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXIgQmlsc2UgPHBlci5iaWxzZUBjaXRyaXguY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL3hlbi9zeXMtaHlwZXJ2aXNvci5jIHwgMjYgKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL3hlbi9pbnRlcmZhY2UveGVuLmggIHwg
MTMgKysrKysrKystLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9zeXMt
aHlwZXJ2aXNvci5jIGIvZHJpdmVycy94ZW4vc3lzLWh5cGVydmlzb3IuYw0KPiBpbmRleCBm
Y2IwNzkyZjA5MGUuLjczOTNlMDRiZGI2ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4v
c3lzLWh5cGVydmlzb3IuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9zeXMtaHlwZXJ2aXNvci5j
DQo+IEBAIC0zNzksNiArMzc5LDMxIEBAIHN0YXRpYyBzc2l6ZV90IGJ1aWxkaWRfc2hvdyhz
dHJ1Y3QgaHlwX3N5c2ZzX2F0dHIgKmF0dHIsIGNoYXIgKmJ1ZmZlcikNCj4gICANCj4gICBI
WVBFUlZJU09SX0FUVFJfUk8oYnVpbGRpZCk7DQo+ICAgDQo+ICtzdGF0aWMgc3NpemVfdCBm
bGFnc19zaG93KHN0cnVjdCBoeXBfc3lzZnNfYXR0ciAqYXR0ciwgY2hhciAqYnVmZmVyKQ0K
PiArew0KPiArCXN0YXRpYyBjaGFyIGNvbnN0ICpjb25zdCBzaWZzdHJbU0lGTl9OVU1fU0lG
Tl0gPSB7DQo+ICsJCVtTSUZOX1BSSVZdICA9ICJwcml2aWxlZ2VkIiwNCj4gKwkJW1NJRk5f
SU5JVF0gID0gImluaXRkb21haW4iLA0KPiArCQlbU0lGTl9NVUxUSV0gPSAibXVsdGlib290
IiwNCj4gKwkJW1NJRk5fUEZOXSAgID0gIm1vZF9zdGFydF9wZm4iLA0KPiArCQlbU0lGTl9W
SVJUXSAgPSAidmlydG1hcCINCj4gKwl9Ow0KPiArCXVuc2lnbmVkIHNpZm51bSwgc2lmbWFz
azsNCj4gKwlzc2l6ZV90IHJldCA9IDA7DQo+ICsNCj4gKwlzaWZtYXNrID0gfih+MFUgPDwg
U0lGTl9OVU1fU0lGTik7ICAvLyAuLi4wMDAwMTExLi4uDQo+ICsJaWYgKHhlbl9kb21haW4o
KSAmJiAoeGVuX3N0YXJ0X2ZsYWdzICYgc2lmbWFzaykgIT0gMCkgew0KPiArCQlmb3IgKHNp
Zm51bSA9IDA7IHNpZm51bSAhPSBTSUZOX05VTV9TSUZOOyBzaWZudW0rKykgew0KPiArCQkJ
aWYgKCh4ZW5fc3RhcnRfZmxhZ3MgJiAoMTw8c2lmbnVtKSkgIT0gMCkNCj4gKwkJCQlyZXQg
Kz0gc3ByaW50ZihidWZmZXIrcmV0LCAiJXMgIiwgc2lmc3RyW3NpZm51bV0pOw0KPiArCQl9
DQo+ICsJCWJ1ZmZlcltyZXQtMV0gPSAnXG4nOw0KPiArCX0NCj4gKwlyZXR1cm4gcmV0Ow0K
PiArfQ0KPiArDQo+ICtIWVBFUlZJU09SX0FUVFJfUk8oZmxhZ3MpOw0KPiArDQo+ICAgc3Rh
dGljIHN0cnVjdCBhdHRyaWJ1dGUgKnhlbl9wcm9wZXJ0aWVzX2F0dHJzW10gPSB7DQo+ICAg
CSZjYXBhYmlsaXRpZXNfYXR0ci5hdHRyLA0KPiAgIAkmY2hhbmdlc2V0X2F0dHIuYXR0ciwN
Cj4gQEAgLTM4Niw2ICs0MTEsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqeGVuX3By
b3BlcnRpZXNfYXR0cnNbXSA9IHsNCj4gICAJJnBhZ2VzaXplX2F0dHIuYXR0ciwNCj4gICAJ
JmZlYXR1cmVzX2F0dHIuYXR0ciwNCj4gICAJJmJ1aWxkaWRfYXR0ci5hdHRyLA0KPiArCSZm
bGFnc19hdHRyLmF0dHIsDQo+ICAgCU5VTEwNCj4gICB9Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3hlbi5oIGIvaW5jbHVkZS94ZW4vaW50ZXJmYWNl
L3hlbi5oDQo+IGluZGV4IDBjYTIzZWNhMmE5Yy4uNzYyYTM0OGFiZTNlIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL3hlbi9pbnRlcmZhY2UveGVuLmgNCj4gKysrIGIvaW5jbHVkZS94ZW4v
aW50ZXJmYWNlL3hlbi5oDQo+IEBAIC02NDgsMTEgKzY0OCwxNCBAQCBzdHJ1Y3Qgc3RhcnRf
aW5mbyB7DQo+ICAgfTsNCj4gICANCj4gICAvKiBUaGVzZSBmbGFncyBhcmUgcGFzc2VkIGlu
IHRoZSAnZmxhZ3MnIGZpZWxkIG9mIHN0YXJ0X2luZm9fdC4gKi8NCj4gLSNkZWZpbmUgU0lG
X1BSSVZJTEVHRUQgICAgICAoMTw8MCkgIC8qIElzIHRoZSBkb21haW4gcHJpdmlsZWdlZD8g
Ki8NCj4gLSNkZWZpbmUgU0lGX0lOSVRET01BSU4gICAgICAoMTw8MSkgIC8qIElzIHRoaXMg
dGhlIGluaXRpYWwgY29udHJvbCBkb21haW4/ICovDQo+IC0jZGVmaW5lIFNJRl9NVUxUSUJP
T1RfTU9EICAgKDE8PDIpICAvKiBJcyBtb2Rfc3RhcnQgYSBtdWx0aWJvb3QgbW9kdWxlPyAq
Lw0KPiAtI2RlZmluZSBTSUZfTU9EX1NUQVJUX1BGTiAgICgxPDwzKSAgLyogSXMgbW9kX3N0
YXJ0IGEgUEZOPyAqLw0KPiAtI2RlZmluZSBTSUZfVklSVF9QMk1fNFRPT0xTICgxPDw0KSAg
LyogRG8gWGVuIHRvb2xzIHVuZGVyc3RhbmQgYSB2aXJ0LiBtYXBwZWQgKi8NCj4gKy8qIFRl
eHQgc3RyaW5ncyBhcmUgcHJpbnRlZCBvdXQgaW4gc3lzLWh5cGVydmlzb3IuYywgd2UgZ3Vh
cmQgICAqLw0KPiArLyogYWdhaW5zdCBtaXgtdXBzIGFuZCBlcnJvcnMgYnkgZW51bWVyYXRp
bmcgdGhlIGZsYWdzLiAgICAgICAgICovDQo+ICtlbnVtIHsgU0lGTl9QUklWLCBTSUZOX0lO
SVQsIFNJRk5fTVVMVEksIFNJRk5fUEZOLCBTSUZOX1ZJUlQsIFNJRk5fTlVNX1NJRk4gfTsN
Cj4gKyNkZWZpbmUgU0lGX1BSSVZJTEVHRUQgICAgICAoMTw8U0lGTl9QUklWKSAgLyogSXMg
dGhlIGRvbWFpbiBwcml2aWxlZ2VkPyAqLw0KPiArI2RlZmluZSBTSUZfSU5JVERPTUFJTiAg
ICAgICgxPDxTSUZOX0lOSVQpICAvKiBJcyB0aGlzIHRoZSBpbml0aWFsIGNvbnRyb2wgZG9t
YWluPyAqLw0KPiArI2RlZmluZSBTSUZfTVVMVElCT09UX01PRCAgICgxPDxTSUZOX01VTFRJ
KSAvKiBJcyBtb2Rfc3RhcnQgYSBtdWx0aWJvb3QgbW9kdWxlPyAqLw0KPiArI2RlZmluZSBT
SUZfTU9EX1NUQVJUX1BGTiAgICgxPDxTSUZOX1BGTikgICAvKiBJcyBtb2Rfc3RhcnQgYSBQ
Rk4/ICovDQo+ICsjZGVmaW5lIFNJRl9WSVJUX1AyTV80VE9PTFMgKDE8PFNJRk5fVklSVCkg
IC8qIERvIFhlbiB0b29scyB1bmRlcnN0YW5kIGEgdmlydC4gbWFwcGVkICovDQoNClBsZWFz
ZSBkb24ndCBjaGFuZ2UgdGhpcyBoZWFkZXIsIGFzIGl0IGlzIGJhc2VkIG9uIGl0cyBtYXN0
ZXINCmxvY2F0ZWQgaW4gdGhlIFhlbiByZXBvc2l0b3J5Lg0KDQpBbiBhY2NlcHRhYmxlIHNv
bHV0aW9uIHdvdWxkIGJlIHRvIHNlbmQgYSBYZW4gcGF0Y2ggZmlyc3QgZG9pbmcgdGhlDQp4
ZW4uaCBjaGFuZ2VzLCBhbmQgd2hlbiB0aGF0IHBhdGNoIGhhcyBiZWVuIHRha2VuIHRvIG1v
ZGlmeSB0aGUNCnJlbGF0ZWQgTGludXggaGVhZGVyIGFjY29yZGluZ2x5Lg0KDQpJbiBjYXNl
IHlvdSB3YW50IHRvIGdvIHRoYXQgcm91dGUsIHBsZWFzZSBhZGQgYSAiWEVOXyIgcHJlZml4
IHRvIHRoZQ0KZW51bSBtZW1iZXJzLg0KDQoNCkp1ZXJnZW4NCg==
--------------LNhIUa17THGTpfpqC5kv1FfE
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------LNhIUa17THGTpfpqC5kv1FfE--

--------------X8D0eoeDEr15NPcmqFQSmGVr--

--------------bX2PESQviO3CpgKBjxM6PRjP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOGJOAFAwAAAAAACgkQsN6d1ii/Ey/X
Owf/aua5Zg2x6wG1EtP8f+LPoE4S7CXMbNsPRuJc3lrxAJy2A3cRWPRhcCxTD7Rhg5+Deg/hmK9F
Kg9QZ/hn+OX8uRYWCe1drmegBHbZdzsN80+gj2sCLAiZ498b34yi+wsH+mLbqbxCH1On2FThaStv
/Oo+GuuHTkBeUmfle6JSWWmaN6IHzo5O4R5JoUTjceSH8euhBxbBvPkQ7GzG+PxOfbk6P2LtdXGd
oogYxsYxoVtnhvgEs7Tiw9V9DaeVTHN/aV5rqhAoFBC6HZ32i6W0CUFteW0+gLbHCqQ8ZD971aO7
Kr0yVPtS5wfiBF/FeTWC36Yd1pI1GGIb+aFimHJSyg==
=3//U
-----END PGP SIGNATURE-----

--------------bX2PESQviO3CpgKBjxM6PRjP--
