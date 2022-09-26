Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B545EACDE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIZQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIZQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:44:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4A8F961
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:33:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35F2021EC9;
        Mon, 26 Sep 2022 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664206394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WS2sEins4xVwRVYY8gCnqmOJ+eRJm5JiCaS2wCiNCk=;
        b=mDSOIoguJRZ7ksZ0ix5HY3FAHSQ3O4e0IqF5KPoXa3usKT1ch9TMQoPIB6LINwZue+325l
        S4LJkx4IPxyPEYm7DKPOPf8z5nvkdaYx6outmiEuG202yHmsW3QpqhUXpdIfN8CUdB8aRD
        NZ8mmlPKmam1wCYazOQOGQaqp49BsEI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC6E2139BD;
        Mon, 26 Sep 2022 15:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K0lCNDnGMWMIJwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 26 Sep 2022 15:33:13 +0000
Message-ID: <3f69b45d-d8c3-1e23-7fc9-87ffb436ad29@suse.com>
Date:   Mon, 26 Sep 2022 17:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] xen/pv: allow pmu msr accesses to cause GP
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220926141849.21805-1-jgross@suse.com>
 <20220926141849.21805-2-jgross@suse.com>
 <b3e43a0a-35cd-e695-0291-5d28616cc818@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <b3e43a0a-35cd-e695-0291-5d28616cc818@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PJ4Udd0XK2Rtt0I3S2SvuWIB"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PJ4Udd0XK2Rtt0I3S2SvuWIB
Content-Type: multipart/mixed; boundary="------------r3nF5HDYlE0AGuY25mLAcUj2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <3f69b45d-d8c3-1e23-7fc9-87ffb436ad29@suse.com>
Subject: Re: [PATCH 1/3] xen/pv: allow pmu msr accesses to cause GP
References: <20220926141849.21805-1-jgross@suse.com>
 <20220926141849.21805-2-jgross@suse.com>
 <b3e43a0a-35cd-e695-0291-5d28616cc818@suse.com>
In-Reply-To: <b3e43a0a-35cd-e695-0291-5d28616cc818@suse.com>

--------------r3nF5HDYlE0AGuY25mLAcUj2
Content-Type: multipart/mixed; boundary="------------AHBNTk7j2H0z0YTVyqy04fL6"

--------------AHBNTk7j2H0z0YTVyqy04fL6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDkuMjIgMTc6MjksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyNi4wOS4yMDIy
IDE2OjE4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gVG9kYXkgcG11X21zcl9yZWFkKCkg
YW5kIHBtdV9tc3Jfd3JpdGUoKSBmYWxsIGJhY2sgdG8gdGhlIHNhZmUgdmFyaWFudHMNCj4+
IG9mIHJlYWQvd3JpdGUgTVNSIGluIGNhc2UgdGhlIE1TUiBhY2Nlc3MgaXNuJ3QgZW11bGF0
ZWQgdmlhIFhlbi4gQWxsb3cNCj4+IHRoZSBjYWxsZXIgdG8gc2VsZWN0IHRoZSBwb3RlbnRp
YWxseSBmYXVsdGluZyB2YXJpYW50IGJ5IHBhc3NpbmcgTlVMTA0KPj4gZm9yIHRoZSBlcnJv
ciBwb2ludGVyLg0KPiANCj4gTWF5YmUgbWFrZSB0aGlzICJ0aGUgc29sZSBjYWxsZXIiIG9y
IHNvbWUgc3VjaD8gQmVjYXVzZSBpZiB0aGVyZSB3ZXJlDQo+IG11bHRpcGxlLCB0aGV5IG1p
Z2h0IGVhc2lseSBkaXNhZ3JlZSBvbiB3aGF0IHRoZSBiZXN0IG1lYW5pbmcgb2YgcGFzc2lu
Zw0KPiBOVUxMIGlzLg0KDQpPa2F5Lg0KDQo+IA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL3Bt
dS5jDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4vcG11LmMNCj4+IEBAIC0yOTMsMjIgKzI5Mywy
NCBAQCBzdGF0aWMgYm9vbCB4ZW5fYW1kX3BtdV9lbXVsYXRlKHVuc2lnbmVkIGludCBtc3Is
IHU2NCAqdmFsLCBib29sIGlzX3JlYWQpDQo+PiAgIGJvb2wgcG11X21zcl9yZWFkKHVuc2ln
bmVkIGludCBtc3IsIHVpbnQ2NF90ICp2YWwsIGludCAqZXJyKQ0KPj4gICB7DQo+PiAgIAlp
ZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwpIHsNCj4+
IC0JCWlmIChpc19hbWRfcG11X21zcihtc3IpKSB7DQo+PiAtCQkJaWYgKCF4ZW5fYW1kX3Bt
dV9lbXVsYXRlKG1zciwgdmFsLCAxKSkNCj4+IC0JCQkJKnZhbCA9IG5hdGl2ZV9yZWFkX21z
cl9zYWZlKG1zciwgZXJyKTsNCj4+IC0JCQlyZXR1cm4gdHJ1ZTsNCj4+ICsJCWlmICghaXNf
YW1kX3BtdV9tc3IobXNyKSkNCj4+ICsJCQlyZXR1cm4gZmFsc2U7DQo+PiArCQlpZiAoIXhl
bl9hbWRfcG11X2VtdWxhdGUobXNyLCB2YWwsIDEpKSB7DQo+PiArCQkJKnZhbCA9IGVyciA/
IG5hdGl2ZV9yZWFkX21zcl9zYWZlKG1zciwgZXJyKQ0KPj4gKwkJCQkgICA6IG5hdGl2ZV9y
ZWFkX21zcihtc3IpOw0KPj4gICAJCX0NCj4+ICsJCXJldHVybiB0cnVlOw0KPiANCj4gTWlu
b3IgcmVtYXJrOiBGb2xkIHRoaXMgYW5kIC4uLg0KPiANCj4+ICAgCX0gZWxzZSB7DQo+PiAg
IAkJaW50IHR5cGUsIGluZGV4Ow0KPj4gICANCj4+IC0JCWlmIChpc19pbnRlbF9wbXVfbXNy
KG1zciwgJnR5cGUsICZpbmRleCkpIHsNCj4+IC0JCQlpZiAoIXhlbl9pbnRlbF9wbXVfZW11
bGF0ZShtc3IsIHZhbCwgdHlwZSwgaW5kZXgsIDEpKQ0KPj4gLQkJCQkqdmFsID0gbmF0aXZl
X3JlYWRfbXNyX3NhZmUobXNyLCBlcnIpOw0KPj4gLQkJCXJldHVybiB0cnVlOw0KPj4gKwkJ
aWYgKCFpc19pbnRlbF9wbXVfbXNyKG1zciwgJnR5cGUsICZpbmRleCkpDQo+PiArCQkJcmV0
dXJuIGZhbHNlOw0KPj4gKwkJaWYgKCF4ZW5faW50ZWxfcG11X2VtdWxhdGUobXNyLCB2YWws
IHR5cGUsIGluZGV4LCAxKSkgew0KPj4gKwkJCSp2YWwgPSBlcnIgPyBuYXRpdmVfcmVhZF9t
c3Jfc2FmZShtc3IsIGVycikNCj4+ICsJCQkJICAgOiBuYXRpdmVfcmVhZF9tc3IobXNyKTsN
Cj4+ICAgCQl9DQo+PiArCQlyZXR1cm4gdHJ1ZTsNCj4gDQo+IC4uLiB0aGlzIGJ5IG1vdmlu
ZyB0aGVtIC4uLg0KPiANCj4+ICAgCX0NCj4+IC0NCj4+IC0JcmV0dXJuIGZhbHNlOw0KPj4g
ICB9DQo+IA0KPiAuLi4gYWJvdmUgaGVyZT8gWW91IG1pZ2h0IGV2ZW4gZGUtZHVwbGljYXRl
IHRoZSBuYXRpdmVfcmVhZF9tc3J7LF9zYWZlfSgpDQo+IGludm9jYXRpb25zIGJ5IG1vdmlu
ZyB0aGVtIG91dCBvZiB0aGUgaWYvZWxzZSAuLi4NCg0KT2gsIG5pY2UgaWRlYSENCg0KDQpK
dWVyZ2VuDQoNCg==
--------------AHBNTk7j2H0z0YTVyqy04fL6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------AHBNTk7j2H0z0YTVyqy04fL6--

--------------r3nF5HDYlE0AGuY25mLAcUj2--

--------------PJ4Udd0XK2Rtt0I3S2SvuWIB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMxxjkFAwAAAAAACgkQsN6d1ii/Ey+M
2Af+JVi2ilT/dU3IByPm+d8h6sSVZBiyiEc4zAaGKpDrcIG/o1LTGfd59vWAzw4lev/CnCdB7yu6
CSZK2r20WK8Nu4+f9s/Ka5CfnJEkyXJ4ffSOpU2+f04SSuLDNqq/5EMNV+9Hnd5NhiilJtBR+Xf+
HGecH3vNKBLS3HACAuw/9W8AOG8ihlzYL3biRqB9e5k9etZA+jjr3QjG7qVFtqAIWbDVAvebUDny
xU/jS3+zqZ4Oqzjwx5Vu+eVCCn/IXo5YaPWyoln1smH/+Wod90g4+BTqZ+MY2u2DBb9RSMjyEXgZ
6qqYA88SXFCkHdY7OEMIUhiTUxZZ65RlVgqObZeu5g==
=17Wf
-----END PGP SIGNATURE-----

--------------PJ4Udd0XK2Rtt0I3S2SvuWIB--
