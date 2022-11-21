Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7486631D54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKUJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiKUJup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:50:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCDE5F841
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:50:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 064B9220C8;
        Mon, 21 Nov 2022 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669024231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcLFCyS4FY7KFWX1B824/toDVatds/xkTR8A+ifH8fU=;
        b=CJwr7xOpgEvkTZ/8mNcpEaD8nmS7iA/eco7flDyS6KUyL0fhbRbljAx7SW0wVOxTBmv3H1
        rc3JlxCeQk790Plx6CSnmJoXoNpUptEUc8QrTtn6mh8TzYa0DnZ1u1rYIfdgRqOfS6m6yb
        yh8VRdhb/3AyAlr9vALOqyoTzYO1Nso=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4C5B1377F;
        Mon, 21 Nov 2022 09:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ssy2JuZJe2P5eAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 21 Nov 2022 09:50:30 +0000
Message-ID: <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
Date:   Mon, 21 Nov 2022 10:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm: introduce arch_has_hw_pmd_young()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc:     yuzhao@google.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>
References: <20221121093245.4587-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221121093245.4587-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yjPp9xt7uTuCq80xr0s6g0tF"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yjPp9xt7uTuCq80xr0s6g0tF
Content-Type: multipart/mixed; boundary="------------U1g5olvEBtDiP9eY8wgDeKGU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc: yuzhao@google.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
Subject: Re: [PATCH] mm: introduce arch_has_hw_pmd_young()
References: <20221121093245.4587-1-jgross@suse.com>
In-Reply-To: <20221121093245.4587-1-jgross@suse.com>

--------------U1g5olvEBtDiP9eY8wgDeKGU
Content-Type: multipart/mixed; boundary="------------WmYEHFrUvwgQmf5ejH3p700p"

--------------WmYEHFrUvwgQmf5ejH3p700p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMTEuMjIgMTA6MzIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFdoZW4gcnVubmlu
ZyBhcyBhIFhlbiBQViBndWVzdHMgY29tbWl0IGVlZDlhMzI4YWExYSAoIm1tOiB4ODY6IGFk
ZA0KPiBDT05GSUdfQVJDSF9IQVNfTk9OTEVBRl9QTURfWU9VTkciKSBjYW4gY2F1c2UgYSBw
cm90ZWN0aW9uIHZpb2xhdGlvbg0KPiBpbiBwbWRwX3Rlc3RfYW5kX2NsZWFyX3lvdW5nKCk6
DQo+IA0KPiAgIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNz
OiBmZmZmODg4MDA4MzM3NGQwDQo+ICAgI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBp
biBrZXJuZWwgbW9kZQ0KPiAgICNQRjogZXJyb3JfY29kZSgweDAwMDMpIC0gcGVybWlzc2lv
bnMgdmlvbGF0aW9uDQo+ICAgUEdEIDMwMjYwNjcgUDREIDMwMjYwNjcgUFVEIDMwMjcwNjcg
UE1EIDdmZWU1MDY3IFBURSA4MDEwMDAwMDA4MzM3MDY1DQo+ICAgT29wczogMDAwMyBbIzFd
IFBSRUVNUFQgU01QIE5PUFRJDQo+ICAgQ1BVOiA3IFBJRDogMTU4IENvbW06IGtzd2FwZDAg
Tm90IHRhaW50ZWQgNi4xLjAtcmM1LTIwMjIxMTE4LWRvZmxyKyAjMQ0KPiAgIFJJUDogZTAz
MDpwbWRwX3Rlc3RfYW5kX2NsZWFyX3lvdW5nKzB4MjUvMHg0MA0KPiANCj4gVGhpcyBoYXBw
ZW5zIGJlY2F1c2UgdGhlIFhlbiBoeXBlcnZpc29yIGNhbid0IGVtdWxhdGUgZGlyZWN0IHdy
aXRlcyB0bw0KPiBwYWdlIHRhYmxlIGVudHJpZXMgb3RoZXIgdGhhbiBQVEVzLg0KPiANCj4g
VGhpcyBjYW4gZWFzaWx5IGJlIGZpeGVkIGJ5IGludHJvZHVjaW5nIGFyY2hfaGFzX2h3X3Bt
ZF95b3VuZygpDQo+IHNpbWlsYXIgdG8gYXJjaF9oYXNfaHdfcHRlX3lvdW5nKCkgYW5kIHRl
c3QgdGhhdCBpbnN0ZWFkIG9mDQo+IENPTkZJR19BUkNIX0hBU19OT05MRUFGX1BNRF9ZT1VO
Ry4NCg0KSSBqdXN0IHNwb3R0ZWQgdGhhdCBJIG1pc3NlZCB0byB1cGRhdGUgbXkgY29tbWl0
IG1lc3NhZ2UgdG8gbWF0Y2ggdGhlDQpwYXRjaDoNCg0Kcy9hcmNoX2hhc19od19wbWRfeW91
bmcvYXJjaF9oYXNfaHdfbm9ubGVhZl9wbWRfeW91bmcvDQoNCkknbGwgd2FpdCB3aXRoIGEg
cmVzZW5kIGluIG9yZGVyIHRvIGdldCBzb21lIGZlZWRiYWNrIGZpcnN0Lg0KDQoNCkp1ZXJn
ZW4NCg0KPiANCj4gRml4ZXM6IGVlZDlhMzI4YWExYSAoIm1tOiB4ODY6IGFkZCBDT05GSUdf
QVJDSF9IQVNfTk9OTEVBRl9QTURfWU9VTkciKQ0KPiBSZXBvcnRlZC1ieTogU2FuZGVyIEVp
a2VsZW5ib29tIDxsaW51eEBlaWtlbGVuYm9vbS5pdD4NCj4gU2lnbmVkLW9mZi1ieTogSnVl
cmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiAtLS0NCj4gICBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZ3RhYmxlLmggfCAgOCArKysrKysrKw0KPiAgIGluY2x1ZGUvbGludXgvcGd0
YWJsZS5oICAgICAgICB8IDExICsrKysrKysrKysrDQo+ICAgbW0vdm1zY2FuLmMgICAgICAg
ICAgICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjQg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3Rh
YmxlLmgNCj4gaW5kZXggNTA1OTc5OWJlYmUzLi5jNTY3YTZlZDE3Y2UgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gQEAgLTE0MzgsNiArMTQzOCwxNCBAQCBzdGF0aWMg
aW5saW5lIGJvb2wgYXJjaF9oYXNfaHdfcHRlX3lvdW5nKHZvaWQpDQo+ICAgCXJldHVybiB0
cnVlOw0KPiAgIH0NCj4gICANCj4gKyNpZmRlZiBDT05GSUdfWEVOX1BWDQo+ICsjZGVmaW5l
IGFyY2hfaGFzX2h3X25vbmxlYWZfcG1kX3lvdW5nIGFyY2hfaGFzX2h3X25vbmxlYWZfcG1k
X3lvdW5nDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYXJjaF9oYXNfaHdfbm9ubGVhZl9wbWRf
eW91bmcodm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2
X0ZFQVRVUkVfWEVOUFYpOw0KPiArfQ0KPiArI2VuZGlmDQo+ICsNCj4gICAjaWZkZWYgQ09O
RklHX1BBR0VfVEFCTEVfQ0hFQ0sNCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgcHRlX3VzZXJf
YWNjZXNzaWJsZV9wYWdlKHB0ZV90IHB0ZSkNCj4gICB7DQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3BndGFibGUuaCBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oDQo+IGluZGV4
IGExMDhiNjBhNjk2Mi4uNThmYzdlMmQ5NTc1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3BndGFibGUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3BndGFibGUuaA0KPiBAQCAt
MjYwLDYgKzI2MCwxNyBAQCBzdGF0aWMgaW5saW5lIGludCBwbWRwX2NsZWFyX2ZsdXNoX3lv
dW5nKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAgICNlbmRpZiAvKiBDT05GSUdf
VFJBTlNQQVJFTlRfSFVHRVBBR0UgKi8NCj4gICAjZW5kaWYNCj4gICANCj4gKyNpZm5kZWYg
YXJjaF9oYXNfaHdfbm9ubGVhZl9wbWRfeW91bmcNCj4gKy8qDQo+ICsgKiBSZXR1cm4gd2hl
dGhlciB0aGUgYWNjZXNzZWQgYml0IGluIG5vbi1sZWFmIFBNRCBlbnRyaWVzIGlzIHN1cHBv
cnRlZCBvbiB0aGUNCj4gKyAqIGxvY2FsIENQVS4NCj4gKyAqLw0KPiArc3RhdGljIGlubGlu
ZSBib29sIGFyY2hfaGFzX2h3X25vbmxlYWZfcG1kX3lvdW5nKHZvaWQpDQo+ICt7DQo+ICsJ
cmV0dXJuIElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX05PTkxFQUZfUE1EX1lPVU5HKTsN
Cj4gK30NCj4gKyNlbmRpZg0KPiArDQo+ICAgI2lmbmRlZiBhcmNoX2hhc19od19wdGVfeW91
bmcNCj4gICAvKg0KPiAgICAqIFJldHVybiB3aGV0aGVyIHRoZSBhY2Nlc3NlZCBiaXQgaXMg
c3VwcG9ydGVkIG9uIHRoZSBsb2NhbCBDUFUuDQo+IGRpZmYgLS1naXQgYS9tbS92bXNjYW4u
YyBiL21tL3Ztc2Nhbi5jDQo+IGluZGV4IDA0ZDhiODhlNTIxNi4uYTA0YWMzYjE4MzI2IDEw
MDY0NA0KPiAtLS0gYS9tbS92bXNjYW4uYw0KPiArKysgYi9tbS92bXNjYW4uYw0KPiBAQCAt
Mzk3NSw3ICszOTc1LDcgQEAgc3RhdGljIHZvaWQgd2Fsa19wbWRfcmFuZ2VfbG9ja2VkKHB1
ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgbmV4dCwgc3RydWN0IHZtX2FyZWENCj4gICAJCQln
b3RvIG5leHQ7DQo+ICAgDQo+ICAgCQlpZiAoIXBtZF90cmFuc19odWdlKHBtZFtpXSkpIHsN
Cj4gLQkJCWlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19OT05MRUFGX1BNRF9ZT1VO
RykgJiYNCj4gKwkJCWlmIChhcmNoX2hhc19od19ub25sZWFmX3BtZF95b3VuZygpICYmDQo+
ICAgCQkJICAgIGdldF9jYXAoTFJVX0dFTl9OT05MRUFGX1lPVU5HKSkNCj4gICAJCQkJcG1k
cF90ZXN0X2FuZF9jbGVhcl95b3VuZyh2bWEsIGFkZHIsIHBtZCArIGkpOw0KPiAgIAkJCWdv
dG8gbmV4dDsNCj4gQEAgLTQwNzMsMTQgKzQwNzMsMTQgQEAgc3RhdGljIHZvaWQgd2Fsa19w
bWRfcmFuZ2UocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9u
ZyBlbmQsDQo+ICAgI2VuZGlmDQo+ICAgCQl3YWxrLT5tbV9zdGF0c1tNTV9OT05MRUFGX1RP
VEFMXSsrOw0KPiAgIA0KPiAtI2lmZGVmIENPTkZJR19BUkNIX0hBU19OT05MRUFGX1BNRF9Z
T1VORw0KPiAtCQlpZiAoZ2V0X2NhcChMUlVfR0VOX05PTkxFQUZfWU9VTkcpKSB7DQo+ICsJ
CWlmIChhcmNoX2hhc19od19ub25sZWFmX3BtZF95b3VuZygpICYmDQo+ICsJCSAgICBnZXRf
Y2FwKExSVV9HRU5fTk9OTEVBRl9ZT1VORykpIHsNCj4gICAJCQlpZiAoIXBtZF95b3VuZyh2
YWwpKQ0KPiAgIAkJCQljb250aW51ZTsNCj4gICANCj4gICAJCQl3YWxrX3BtZF9yYW5nZV9s
b2NrZWQocHVkLCBhZGRyLCB2bWEsIGFyZ3MsIGJpdG1hcCwgJnBvcyk7DQo+ICAgCQl9DQo+
IC0jZW5kaWYNCj4gKw0KPiAgIAkJaWYgKCF3YWxrLT5mb3JjZV9zY2FuICYmICF0ZXN0X2Js
b29tX2ZpbHRlcih3YWxrLT5scnV2ZWMsIHdhbGstPm1heF9zZXEsIHBtZCArIGkpKQ0KPiAg
IAkJCWNvbnRpbnVlOw0KPiAgIA0KPiBAQCAtNTM1NCw3ICs1MzU0LDcgQEAgc3RhdGljIHNz
aXplX3Qgc2hvd19lbmFibGVkKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3Qga29ial9h
dHRyaWJ1dGUgKmF0dHIsIGMNCj4gICAJaWYgKGFyY2hfaGFzX2h3X3B0ZV95b3VuZygpICYm
IGdldF9jYXAoTFJVX0dFTl9NTV9XQUxLKSkNCj4gICAJCWNhcHMgfD0gQklUKExSVV9HRU5f
TU1fV0FMSyk7DQo+ICAgDQo+IC0JaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX05P
TkxFQUZfUE1EX1lPVU5HKSAmJiBnZXRfY2FwKExSVV9HRU5fTk9OTEVBRl9ZT1VORykpDQo+
ICsJaWYgKGFyY2hfaGFzX2h3X25vbmxlYWZfcG1kX3lvdW5nKCkgJiYgZ2V0X2NhcChMUlVf
R0VOX05PTkxFQUZfWU9VTkcpKQ0KPiAgIAkJY2FwcyB8PSBCSVQoTFJVX0dFTl9OT05MRUFG
X1lPVU5HKTsNCj4gICANCj4gICAJcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAi
MHglMDR4XG4iLCBjYXBzKTsNCg0K
--------------WmYEHFrUvwgQmf5ejH3p700p
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WmYEHFrUvwgQmf5ejH3p700p--

--------------U1g5olvEBtDiP9eY8wgDeKGU--

--------------yjPp9xt7uTuCq80xr0s6g0tF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN7SeYFAwAAAAAACgkQsN6d1ii/Ey8v
swf/cFO0y8CZZkv/aR/hnsRRH69ijYRsEA0qkwiNIhXrzPSyRbYAVHKu9fnqKpICjJ5Cl6H580g5
4n/8iAgtEmzLOz1oWa9WNJdg+ty3h5bboVcCy8NBR6bOJp0V3lIgLXGAaLdTrZYj7qau9ZhZyDRV
8lQl500pNVnlvTaVxXI1yCEu7OnPs/JyyQMFD6nTi/wjdPgm4M7cVwirjELx3sNtHMgDZ2/wIdmV
gGpYm9oJrP2/Mk6j+XfOiK48D/rvX/kPdP7wQb7v0keRrtk9s+XVNE2TqCH11wl/OBdEEteIOlbq
1Jek6fMtsxZBcFLpiRCOqU1+PIbHRuEzLstqB6Vytw==
=IdJo
-----END PGP SIGNATURE-----

--------------yjPp9xt7uTuCq80xr0s6g0tF--
