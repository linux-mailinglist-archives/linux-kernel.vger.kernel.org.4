Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B26045B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiJSMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJSMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9552F039
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CEC5204A2;
        Wed, 19 Oct 2022 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666181787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMwCP1y+jkMNSz+PiPMxYx6ex7pA22XqkEQTY08/euQ=;
        b=mar24rJjo1/BuJagImAFGY6jG/SY3Mf6FVxXBtMY2u11dtjpiTKKVpTIZnJSYVWwgGAlpp
        IeL3V9W4tjAmcd57Y/JIGIZykfOJWwsAEIZU5x3TiDCLNc6MzTjuEh+f2IhfaxEjIB9p8Y
        VFDUMog8BLQx9ydVpLkxiNLTSDAuNdE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 378B113A36;
        Wed, 19 Oct 2022 12:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5hMPDJvqT2PBYwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 19 Oct 2022 12:16:27 +0000
Message-ID: <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
Date:   Wed, 19 Oct 2022 14:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Content-Language: en-US
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221019095035.10823-6-xin3.li@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ldVTzKC7U5AkGDPyUHm31m7j"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ldVTzKC7U5AkGDPyUHm31m7j
Content-Type: multipart/mixed; boundary="------------wpyo0rGt4EaP39B8WiN23RHz";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
 brgerst@gmail.com, chang.seok.bae@intel.com
Message-ID: <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
In-Reply-To: <20221019095035.10823-6-xin3.li@intel.com>

--------------wpyo0rGt4EaP39B8WiN23RHz
Content-Type: multipart/mixed; boundary="------------wXEROfvJnJHbgk7sSSF0Gayr"

--------------wXEROfvJnJHbgk7sSSF0Gayr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTAuMjIgMTE6NTAsIFhpbiBMaSB3cm90ZToNCj4gRnJvbTogIkguIFBldGVyIEFu
dmluIChJbnRlbCkiIDxocGFAenl0b3IuY29tPg0KPiANCj4gVGhlIExLR1MgaW5zdHJ1Y3Rp
b24gYXRvbWljYWxseSBsb2FkcyBhIHNlZ21lbnQgZGVzY3JpcHRvciBpbnRvIHRoZQ0KPiAl
Z3MgZGVzY3JpcHRvciByZWdpc3RlcnMsICpleGNlcHQqIHRoYXQgJWdzLmJhc2UgaXMgdW5j
aGFuZ2VkLCBhbmQgdGhlDQo+IGJhc2UgaXMgaW5zdGVhZCBsb2FkZWQgaW50byBNU1JfSUEz
Ml9LRVJORUxfR1NfQkFTRSwgd2hpY2ggaXMgZXhhY3RseQ0KPiB3aGF0IHdlIHdhbnQgdGhp
cyBmdW5jdGlvbiB0byBkby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEguIFBldGVyIEFudmlu
IChJbnRlbCkgPGhwYUB6eXRvci5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxz
dHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpbiBM
aSA8eGluMy5saUBpbnRlbC5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MzoN
Cj4gKiBXZSB3YW50IGxlc3MgQVNNIG5vdCBtb3JlLCB0aHVzIGtlZXAgbG9jYWxfaXJxX3Nh
dmUvcmVzdG9yZSgpIGluc2lkZQ0KPiAgICBuYXRpdmVfbG9hZF9nc19pbmRleCgpIChUaG9t
YXMgR2xlaXhuZXIpLg0KPiAqIEZvciBwYXJhdmlydCBlbmFibGVkIGtlcm5lbHMsIGluaXRp
YWxpemUgcHZfb3BzLmNwdS5sb2FkX2dzX2luZGV4IHRvDQo+ICAgIG5hdGl2ZV9sa2dzIChU
aG9tYXMgR2xlaXhuZXIpLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gKiBNYXJrIERJ
IGFzIGlucHV0IGFuZCBvdXRwdXQgKCtEKSBhcyBpbiBWMSwgc2luY2UgdGhlIGV4Y2VwdGlv
biBoYW5kbGVyDQo+ICAgIG1vZGlmaWVzIGl0IChCcmlhbiBHZXJzdCkuDQo+IA0KPiBDaGFu
Z2VzIHNpbmNlIFYxOg0KPiAqIFVzZSBFWF9UWVBFX1pFUk9fUkVHIGluc3RlYWQgb2YgZml4
dXAgY29kZSBpbiB0aGUgb2Jzb2xldGUgLmZpeHVwIGNvZGUNCj4gICAgc2VjdGlvbiAoUGV0
ZXIgWmlqbHN0cmEpLg0KPiAqIEFkZCBhIGNvbW1lbnQgdGhhdCBzdGF0ZXMgdGhlIExLR1Nf
REkgbWFjcm8gd2lsbCBiZSByZXBhbGNlZCB3aXRoICJsa2dzICVkaSINCj4gICAgb25jZSB0
aGUgYmludXRpbHMgc3VwcG9ydCB0aGUgTEtHUyBpbnN0cnVjdGlvbiAoUGV0ZXIgWmlqbHN0
cmEpLg0KPiAtLS0NCj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9nc3NlZy5oIHwgMzMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL2Nw
dS9jb21tb24uYyB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vZ3NzZWcuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dzc2VnLmgNCj4gaW5kZXgg
ZDE1NTc3YzM5ZThkLi5hYjZhNTk1Y2VhNzAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2dzc2VnLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZ3NzZWcu
aA0KPiBAQCAtMTQsMTcgKzE0LDQyIEBADQo+ICAgDQo+ICAgZXh0ZXJuIGFzbWxpbmthZ2Ug
dm9pZCBhc21fbG9hZF9nc19pbmRleCh1MTYgc2VsZWN0b3IpOw0KPiAgIA0KPiArLyogUmVw
bGFjZSB3aXRoICJsa2dzICVkaSIgb25jZSBiaW51dGlscyBzdXBwb3J0IExLR1MgaW5zdHJ1
Y3Rpb24gKi8NCj4gKyNkZWZpbmUgTEtHU19ESSBfQVNNX0JZVEVTKDB4ZjIsMHgwZiwweDAw
LDB4ZjcpDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBuYXRpdmVfbGtncyh1bnNpZ25l
ZCBpbnQgc2VsZWN0b3IpDQo+ICt7DQo+ICsJdTE2IHNlbCA9IHNlbGVjdG9yOw0KPiArCWFz
bV9pbmxpbmUgdm9sYXRpbGUoIjE6ICIgTEtHU19ESQ0KPiArCQkJICAgIF9BU01fRVhUQUJM
RV9UWVBFX1JFRygxYiwgMWIsIEVYX1RZUEVfWkVST19SRUcsICVrW3NlbF0pDQo+ICsJCQkg
ICAgOiBbc2VsXSAiK0QiIChzZWwpKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUg
dm9pZCBuYXRpdmVfbG9hZF9nc19pbmRleCh1bnNpZ25lZCBpbnQgc2VsZWN0b3IpDQo+ICAg
ew0KPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfTEtHUykpIHsNCj4gKwkJbmF0aXZlX2xrZ3Moc2VsZWN0b3IpOw0K
PiArCX0gZWxzZSB7DQo+ICsJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgDQo+IC0JbG9j
YWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiAtCWFzbV9sb2FkX2dzX2luZGV4KHNlbGVjdG9yKTsN
Cj4gLQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+ICsJCWxvY2FsX2lycV9zYXZlKGZs
YWdzKTsNCj4gKwkJYXNtX2xvYWRfZ3NfaW5kZXgoc2VsZWN0b3IpOw0KPiArCQlsb2NhbF9p
cnFfcmVzdG9yZShmbGFncyk7DQo+ICsJfQ0KPiAgIH0NCj4gICANCj4gICAjZW5kaWYgLyog
Q09ORklHX1g4Nl82NCAqLw0KPiAgIA0KPiArc3RhdGljIGlubGluZSB2b2lkIF9faW5pdCBs
a2dzX2luaXQodm9pZCkNCj4gK3sNCj4gKyNpZmRlZiBDT05GSUdfUEFSQVZJUlRfWFhMDQo+
ICsjaWZkZWYgQ09ORklHX1g4Nl82NA0KPiArCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4
Nl9GRUFUVVJFX0xLR1MpKQ0KPiArCQlwdl9vcHMuY3B1LmxvYWRfZ3NfaW5kZXggPSBuYXRp
dmVfbGtnczsNCg0KRm9yIHRoaXMgdG8gd29yayBjb3JyZWN0bHkgd2hlbiBydW5uaW5nIGFz
IGEgWGVuIFBWIGd1ZXN0LCB5b3UgbmVlZCB0byBhZGQNCg0KCXNldHVwX2NsZWFyX2NwdV9j
YXAoWDg2X0ZFQVRVUkVfTEtHUyk7DQoNCnRvIHhlbl9pbml0X2NhcGFiaWxpdGllcygpIGlu
IGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYywgYXMgb3RoZXJ3aXNlDQp0aGUgWGVuIHNw
ZWNpZmljIC5sb2FkX2dzX2luZGV4IHZlY3RvciB3aWxsIGJlIG92ZXJ3cml0dGVuLg0KDQoN
Ckp1ZXJnZW4NCg==
--------------wXEROfvJnJHbgk7sSSF0Gayr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wXEROfvJnJHbgk7sSSF0Gayr--

--------------wpyo0rGt4EaP39B8WiN23RHz--

--------------ldVTzKC7U5AkGDPyUHm31m7j
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNP6poFAwAAAAAACgkQsN6d1ii/Ey81
YwgAm1HFlpuhGRNOPt/a8qoTbxIEbX/ATctGuJWnjkKicucFFIeCP4rDL/Di54s/HecuVhV+VqoD
WfY9uxK1kZcrbPXaeSl6onxQAjLDdb+teZl9z1lSV2drO71cGuAILTVi2jiiqY1ZYtkudVlmo3/p
O8NjFGa15aNvGo9PpIL6CeJ2DZds2xfG6Q7T/H81qx/frSc6Usgkw4rnfaCkniKSSUvo5O7KM+sl
+X8YESS044UhTwK9l7LiXYTV38ubg74JR1sThoLfUaeLJTLb8rmOmyP1hWg9p4fgCiGlCvN2oL1z
xfDe9gpPlxiUhl7dwtOFrUFEcEN92+RAkqyKJyyCyg==
=3/87
-----END PGP SIGNATURE-----

--------------ldVTzKC7U5AkGDPyUHm31m7j--
