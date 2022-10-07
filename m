Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCD5F739D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJGEqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJGEqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:46:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA9BC44B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 21:46:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34920218F2;
        Fri,  7 Oct 2022 04:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665117990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5GmztskPSP9trLxr89A3zS7Fs4dtcvgwytq+j/McAg=;
        b=CpuMZ4ZUkvUrYkTrqEl3bnkg0d8fikhwjlSmGWY6BhR1hSIj5QIO08FtRXP0mUZp8QYlYk
        SMwunmxrRLe9SeG57W5Nhqf71gPH+ObpJMdMTc/te87wWgrawXIIAtNhRFqqE5uib+csfG
        p78+4/ZXYb5ajxYtXySXd57i28SPvf4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1C6213A3D;
        Fri,  7 Oct 2022 04:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qj9EOSWvP2OoIgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 04:46:29 +0000
Message-ID: <8c65d2dc-9901-5863-62a4-054f6fb7c1f3@suse.com>
Date:   Fri, 7 Oct 2022 06:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20221006120912.1948459-1-olekstysh@gmail.com>
 <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
 <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PGEokmL5m26k4CjCo2iaZBpW"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PGEokmL5m26k4CjCo2iaZBpW
Content-Type: multipart/mixed; boundary="------------mTk9N4f3pIuOuR6J0791ynGM";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <8c65d2dc-9901-5863-62a4-054f6fb7c1f3@suse.com>
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
References: <20221006120912.1948459-1-olekstysh@gmail.com>
 <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
 <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
In-Reply-To: <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>

--------------mTk9N4f3pIuOuR6J0791ynGM
Content-Type: multipart/mixed; boundary="------------3L1m4uUGS1CEl6uVBf0RuMMF"

--------------3L1m4uUGS1CEl6uVBf0RuMMF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMjM6MTMsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
T24gMDYuMTAuMjIgMjA6NTksIFhlbmlhIFJhZ2lhZGFrb3Ugd3JvdGU6DQo+IA0KPiBIZWxs
byBYZW5pYQ0KPiANCj4+DQo+PiBPbiAxMC82LzIyIDE1OjA5LCBPbGVrc2FuZHIgVHlzaGNo
ZW5rbyB3cm90ZToNCj4+PiBGcm9tOiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRy
X3R5c2hjaGVua29AZXBhbS5jb20+DQo+Pj4NCj4+PiBBbHRob3VnaCBYRU5fUEFHRV9TSVpF
IGlzIGVxdWFsIHRvIFBBR0VfU0laRSAoNEtCKSBmb3Igbm93LCBpdCB3b3VsZA0KPj4+IGJl
IG1vcmUgY29ycmVjdCB0byB1c2UgWGVuIHNwZWNpZmljICNkZWZpbmUtcyBhcyBYRU5fUEFH
RV9TSVpFIGNhbg0KPj4+IGJlIGNoYW5nZWQgYXQgc29tZSBwb2ludCBpbiB0aGUgZnV0dXJl
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtz
YW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KDQouLi4NCg0KPj4gU28sIHRoZSBjYWxjdWxh
dGVkIG51bWJlciBvZiBncmFudHMgbWF5IGRpZmZlci4NCj4gDQo+IEdvb2QgcG9pbnQsIEkg
dGhpbmsgeW91IGFyZSByaWdodCwgc28gd2UgbmVlZCB0byBhZGRpdGlvbmFsbHkgdXNlDQo+
IHhlbl9vZmZzZXRfaW5fcGFnZSgpIG1hY3JvIGluIHhlbl9ncmFudF9kbWFfbWFwX3BhZ2Uo
KSwNCj4gDQo+IHNvbWV0aGluZyBsaWtlIHRoYXQgdG8gYmUgc3F1YXNoZWQgd2l0aCBjdXJy
ZW50IHBhdGNoOg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ncmFudC1k
bWEtb3BzLmMgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gaW5kZXggOWQ1ZWNh
NmQ2MzhhLi5iYjk4NGRjMDVkZWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gQEAg
LTE2OSw3ICsxNjksNyBAQCBzdGF0aWMgZG1hX2FkZHJfdCB4ZW5fZ3JhbnRfZG1hX21hcF9w
YWdlKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhdHRycykNCj4gICDCoHsN
Cj4gICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpkYXRhOw0K
PiAtwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpLCBuX3BhZ2VzID0gWEVOX1BGTl9VUChv
ZmZzZXQgKyBzaXplKTsNCj4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdl
cyA9IFhFTl9QRk5fVVAoeGVuX29mZnNldF9pbl9wYWdlKG9mZnNldCkNCj4gKyBzaXplKTsN
Cg0KSSdkIHJhdGhlciBpbnRyb2R1Y2UgYW5vdGhlciBsb2NhbCB2YXJpYWJsZSAieGVuX29m
ZnNldCIsIGFzIGl0IGlzIHVzZWQNCnR3aWNlLg0KDQoNCg==
--------------3L1m4uUGS1CEl6uVBf0RuMMF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------3L1m4uUGS1CEl6uVBf0RuMMF--

--------------mTk9N4f3pIuOuR6J0791ynGM--

--------------PGEokmL5m26k4CjCo2iaZBpW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM/ryUFAwAAAAAACgkQsN6d1ii/Ey+u
2Qf/ddqDOr0XbrZGjZKCCqOOTcahTi5rSCq0H9zjuWno7AGdf5UZec4WzuLy6wmQ2AGHtRvjBeOO
gMoUIGLVBhtPxhNp9RqNmUlWwzxFQ47ir046S6+/CJza1snGZkBDxWZGp+TGqes7uup/p0OR2Orh
u/DwfCVoD5sbE3FJSiV5kpdNTmsJc9YrHVOovshAxJa7d9EPPaG9zNKqFYEd4IHwHSta9DK29sTM
xhUZY8M/ZgyERI79RhktAD30+QYIPKGowtXE5bZAjm2fVHL5988eAYnP4fI0b3cKz2xztRT5L/QG
J25bESjoWpPpuDt4RlHbTq06Sb5svH+joHZyRCfHYg==
=YKkI
-----END PGP SIGNATURE-----

--------------PGEokmL5m26k4CjCo2iaZBpW--
