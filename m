Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F666BB2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjCOMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjCOMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:39:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6CA4027;
        Wed, 15 Mar 2023 05:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 568A9218FC;
        Wed, 15 Mar 2023 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678883899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz1UYNHzB0o6BXo5GffcomeCEXsJ+DMQo9fO9Q6cdIc=;
        b=qsUE1t8TiSjAdgzXhEM46HRYZzrxCp9OTGOxb3nFWun9nRqatd0hi3flsSWFq9XO8+aKTQ
        yUfHpiNqqlMuTvdoZFsmfIDt+hilwP4DfcvLV4t1x2PSZj9dDOJul+kKlB9G3RIgfjsBlh
        Q7ArBtnrKvTltt2wg17c5e8F3wbGyxk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1C9C13A00;
        Wed, 15 Mar 2023 12:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BL+JNTq8EWRvDwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Mar 2023 12:38:18 +0000
Message-ID: <c9eec213-3c93-62ba-1f46-1e502f121eac@suse.com>
Date:   Wed, 15 Mar 2023 13:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
References: <20230315121031.22450-1-roger.pau@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230315121031.22450-1-roger.pau@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gWtvAgNznabXuhhlhnZWKwSs"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gWtvAgNznabXuhhlhnZWKwSs
Content-Type: multipart/mixed; boundary="------------uYrqKpVGnLGwiBL102kr3Hq0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
 Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Message-ID: <c9eec213-3c93-62ba-1f46-1e502f121eac@suse.com>
Subject: Re: [PATCH v2] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
References: <20230315121031.22450-1-roger.pau@citrix.com>
In-Reply-To: <20230315121031.22450-1-roger.pau@citrix.com>

--------------uYrqKpVGnLGwiBL102kr3Hq0
Content-Type: multipart/mixed; boundary="------------teTPZZU0EqzfsCNfmTdsoPkW"

--------------teTPZZU0EqzfsCNfmTdsoPkW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDMuMjMgMTM6MTAsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gSW4gQUNQSSBz
eXN0ZW1zLCB0aGUgT1MgY2FuIGRpcmVjdCBwb3dlciBtYW5hZ2VtZW50LCBhcyBvcHBvc2Vk
IHRvIHRoZQ0KPiBmaXJtd2FyZS4gIFRoaXMgT1MtZGlyZWN0ZWQgUG93ZXIgTWFuYWdlbWVu
dCBpcyBjYWxsZWQgT1NQTS4gIFBhcnQgb2YNCj4gdGVsbGluZyB0aGUgZmlybXdhcmUgdGhh
dCB0aGUgT1MgZ29pbmcgdG8gZGlyZWN0IHBvd2VyIG1hbmFnZW1lbnQgaXMNCj4gbWFraW5n
IEFDUEkgIl9QREMiIChQcm9jZXNzb3IgRHJpdmVyIENhcGFiaWxpdGllcykgY2FsbHMuICBU
aGVzZSBfUERDDQo+IG1ldGhvZHMgbXVzdCBiZSBldmFsdWF0ZWQgZm9yIGV2ZXJ5IHByb2Nl
c3NvciBvYmplY3QuICBJZiB0aGVzZSBfUERDDQo+IGNhbGxzIGFyZSBub3QgY29tcGxldGVk
IGZvciBldmVyeSBwcm9jZXNzb3IgaXQgY2FuIGxlYWQgdG8NCj4gaW5jb25zaXN0ZW5jeSBh
bmQgbGF0ZXIgZmFpbHVyZXMgaW4gdGhpbmdzIGxpa2UgdGhlIENQVSBmcmVxdWVuY3kNCj4g
ZHJpdmVyLg0KPiANCj4gSW4gYSBYZW4gc3lzdGVtLCB0aGUgZG9tMCBrZXJuZWwgaXMgcmVz
cG9uc2libGUgZm9yIHN5c3RlbS13aWRlIHBvd2VyDQo+IG1hbmFnZW1lbnQuICBUaGUgZG9t
MCBrZXJuZWwgaXMgaW4gY2hhcmdlIG9mIE9TUE0uICBIb3dldmVyLCB0aGUNCj4gbnVtYmVy
IG9mIENQVXMgYXZhaWxhYmxlIHRvIGRvbTAgY2FuIGJlIGRpZmZlcmVudCB0aGFuIHRoZSBu
dW1iZXIgb2YNCj4gQ1BVcyBwaHlzaWNhbGx5IHByZXNlbnQgb24gdGhlIHN5c3RlbS4NCj4g
DQo+IFRoaXMgbGVhZHMgdG8gYSBwcm9ibGVtOiB0aGUgZG9tMCBrZXJuZWwgbmVlZHMgdG8g
ZXZhbHVhdGUgX1BEQyBmb3INCj4gYWxsIHRoZSBwcm9jZXNzb3JzLCBidXQgaXQgY2FuJ3Qg
YWx3YXlzIHNlZSB0aGVtLg0KPiANCj4gSW4gZG9tMCBrZXJuZWxzLCBpZ25vcmUgdGhlIGV4
aXN0aW5nIEFDUEkgbWV0aG9kIGZvciBkZXRlcm1pbmluZyBpZiBhDQo+IHByb2Nlc3NvciBp
cyBwaHlzaWNhbGx5IHByZXNlbnQgYmVjYXVzZSBpdCBtaWdodCBub3QgYmUgYWNjdXJhdGUu
DQo+IEluc3RlYWQsIGFzayB0aGUgaHlwZXJ2aXNvciBmb3IgdGhpcyBpbmZvcm1hdGlvbi4N
Cj4gDQo+IEZpeCB0aGlzIGJ5IGludHJvZHVjaW5nIGEgY3VzdG9tIGZ1bmN0aW9uIHRvIHVz
ZSB3aGVuIHJ1bm5pbmcgYXMgWGVuDQo+IGRvbTAgaW4gb3JkZXIgdG8gY2hlY2sgd2hldGhl
ciBhIHByb2Nlc3NvciBvYmplY3QgbWF0Y2hlcyBhIENQVSB0aGF0J3MNCj4gb25saW5lLg0K
PiANCj4gVGhpcyBlbnN1cmVzIHRoYXQgX1BEQyBtZXRob2QgZ2V0cyBldmFsdWF0ZWQgZm9y
IGFsbCBwaHlzaWNhbGx5IG9ubGluZQ0KPiBDUFVzLCByZWdhcmRsZXNzIG9mIHRoZSBudW1i
ZXIgb2YgQ1BVcyBtYWRlIGF2YWlsYWJsZSB0byBkb20wLg0KPiANCj4gRml4ZXM6IDVkNTU0
YTdiYjA2NCAoJ0FDUEk6IHByb2Nlc3NvcjogYWRkIGludGVybmFsIHByb2Nlc3Nvcl9waHlz
aWNhbGx5X3ByZXNlbnQoKScpDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBhdSBNb25uw6kg
PHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4g
ICAtIFJld29yZCBjb21taXQgbWVzc2FnZS4NCj4gLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVk
ZS9hc20veGVuL2h5cGVydmlzb3IuaCB8IDEwICsrKysrKysrKysNCj4gICBhcmNoL3g4Ni94
ZW4vZW5saWdodGVuLmMgICAgICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9wZGMuYyAgICAgICAgICB8IDEx
ICsrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20veGVuL2h5cGVydmlzb3Iu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9oeXBlcnZpc29yLmgNCj4gaW5kZXggNWZj
MzVmODg5Y2QxLi5mMTRlMzliY2UyY2IgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3hlbi9oeXBlcnZpc29yLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
eGVuL2h5cGVydmlzb3IuaA0KPiBAQCAtNjMsNCArNjMsMTQgQEAgdm9pZCBfX2luaXQgeGVu
X3B2aF9pbml0KHN0cnVjdCBib290X3BhcmFtcyAqYm9vdF9wYXJhbXMpOw0KPiAgIHZvaWQg
X19pbml0IG1lbV9tYXBfdmlhX2hjYWxsKHN0cnVjdCBib290X3BhcmFtcyAqYm9vdF9wYXJh
bXNfcCk7DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX1hFTl9ET00wDQo+
ICtib29sIF9faW5pdCB4ZW5fcHJvY2Vzc29yX3ByZXNlbnQodWludDMyX3QgYWNwaV9pZCk7
DQo+ICsjZWxzZQ0KPiArc3RhdGljIGlubGluZSBib29sIHhlbl9wcm9jZXNzb3JfcHJlc2Vu
dCh1aW50MzJfdCBhY3BpX2lkKQ0KPiArew0KPiArCUJVRygpOw0KPiArCXJldHVybiBmYWxz
ZTsNCj4gK30NCj4gKyNlbmRpZg0KPiArDQo+ICAgI2VuZGlmIC8qIF9BU01fWDg2X1hFTl9I
WVBFUlZJU09SX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW4u
YyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW4uYw0KPiBpbmRleCBiOGRiMjE0OGMwN2QuLmQ0
YzQ0MzYxYTI2YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbi5jDQo+
ICsrKyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW4uYw0KPiBAQCAtMzQ2LDMgKzM0NiwzMCBA
QCB2b2lkIHhlbl9hcmNoX3VucmVnaXN0ZXJfY3B1KGludCBudW0pDQo+ICAgfQ0KPiAgIEVY
UE9SVF9TWU1CT0woeGVuX2FyY2hfdW5yZWdpc3Rlcl9jcHUpOw0KPiAgICNlbmRpZg0KPiAr
DQo+ICsjaWZkZWYgQ09ORklHX1hFTl9ET00wDQo+ICtib29sIF9faW5pdCB4ZW5fcHJvY2Vz
c29yX3ByZXNlbnQodWludDMyX3QgYWNwaV9pZCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBpbnQg
aSwgbWF4aWQ7DQo+ICsJc3RydWN0IHhlbl9wbGF0Zm9ybV9vcCBvcCA9IHsNCj4gKwkJLmNt
ZCA9IFhFTlBGX2dldF9jcHVpbmZvLA0KPiArCQkuaW50ZXJmYWNlX3ZlcnNpb24gPSBYRU5Q
Rl9JTlRFUkZBQ0VfVkVSU0lPTiwNCj4gKwl9Ow0KPiArCWludCByZXQgPSBIWVBFUlZJU09S
X3BsYXRmb3JtX29wKCZvcCk7DQo+ICsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZmFs
c2U7DQo+ICsNCj4gKwltYXhpZCA9IG9wLnUucGNwdV9pbmZvLm1heF9wcmVzZW50Ow0KPiAr
CWZvciAoaSA9IDA7IGkgPD0gbWF4aWQ7IGkrKykgew0KPiArCQlvcC51LnBjcHVfaW5mby54
ZW5fY3B1aWQgPSBpOw0KPiArCQlyZXQgPSBIWVBFUlZJU09SX3BsYXRmb3JtX29wKCZvcCk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQljb250aW51ZTsNCj4gKwkJaWYgKG9wLnUucGNwdV9p
bmZvLmFjcGlfaWQgPT0gYWNwaV9pZCkNCj4gKwkJCXJldHVybiBvcC51LnBjcHVfaW5mby5m
bGFncyAmIFhFTl9QQ1BVX0ZMQUdTX09OTElORTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4g
ZmFsc2U7DQo+ICt9DQo+ICsjZW5kaWYNCg0KRGlkIHlvdSBjb25zaWRlciBub3QgdG8gZG8g
dGhlIGh5cGVyY2FsbCBhZ2FpbiBhbmQgYWdhaW4sIGJ1dCB0byByZXVzZSB0aGUNCnBjcHUg
bGlzdCBmcm9tIGRyaXZlcnMveGVuL3BjcHUuYyBpbnN0ZWFkPyBZb3UnZCBuZWVkIHRvIHN0
b3JlIHRoZSBhY3BpX2lkDQppbiB0aGlzIGxpc3QsIG9mIGNvdXJzZS4NCg0KDQpKdWVyZ2Vu
DQo=
--------------teTPZZU0EqzfsCNfmTdsoPkW
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------teTPZZU0EqzfsCNfmTdsoPkW--

--------------uYrqKpVGnLGwiBL102kr3Hq0--

--------------gWtvAgNznabXuhhlhnZWKwSs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQRvDoFAwAAAAAACgkQsN6d1ii/Ey+H
eAf9F/IC8YDKBqY8EV61gkEqzpoZdao/jB/5rFKUHMJRV9VvvYn8sRHPnnCevJPl0G77QRK6uM5R
J9ZZ5jwTQzsymS1maQS/Vr58GFBWPBt8FquF18CAZrPoyPzsV6CP7zJvfgvCEgFflUr3+5iw1BWG
hf+MnyDc0h6XsWo+6g0YJfHji016AuGeQ8gBE55xWpzGEfdlgTkyh98U1blwEPHeo+0RZFxfn9M/
52fhyhTFN/pHNE+eUFv3iSIadmfcepWATPyv/nnVi6/JknUHENp0cwn1vNmgUVmc0VEhjc6RH0tv
d9ipryWfVN62skmBjLlOcxpIzg/fuPWBWT5Pzz/eUQ==
=xp4g
-----END PGP SIGNATURE-----

--------------gWtvAgNznabXuhhlhnZWKwSs--
