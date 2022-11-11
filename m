Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A92625622
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiKKJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKKJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:03:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441610B6F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:01:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5A5A1F37C;
        Fri, 11 Nov 2022 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668157268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lspCkDNCYN0BihwrR2TfrBJPIdxMA5VNPOiPc3CMUQ=;
        b=P7/ZX+SygRJNACjEgHO0GZadvRJq2WHDmLHQURI5/CjQMC2TLFgvGXo4eroK/eXmzKd9Bx
        sxv0fHMrSq9myc7T34BODP3Ve/+kQ4BI7wAHXAp51MJX527srKG2z2mXhgN7iDyf3l9MHD
        W6KcowZBxFzj5scnovMv6xN3Y8P72f8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7813D13357;
        Fri, 11 Nov 2022 09:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uMXXG1QPbmOCUgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Nov 2022 09:01:08 +0000
Message-ID: <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
Date:   Fri, 11 Nov 2022 10:01:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org, LKML <linux-kernel@vger.kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C1r5uw2pnvVs2iKcq7dJOozD"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C1r5uw2pnvVs2iKcq7dJOozD
Content-Type: multipart/mixed; boundary="------------DEY2bd0n5CFo0bkhFII07cP0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Maximilian Heyne <mheyne@amazon.de>, xen-devel@lists.xenproject.org,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
In-Reply-To: <9ab99257-844b-de15-cd20-7cda61295186@suse.com>

--------------DEY2bd0n5CFo0bkhFII07cP0
Content-Type: multipart/mixed; boundary="------------tf1QLtQu4n1YEyi0ELgOlR0F"

--------------tf1QLtQu4n1YEyi0ELgOlR0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMTEuMjIgMTc6MjYsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAwMy4xMS4yMDIy
IDE2OjQxLCBKYW4gQmV1bGljaCB3cm90ZToNCj4+IE9uIDAzLjExLjIwMjIgMTQ6MzgsIEph
biBCZXVsaWNoIHdyb3RlOg0KPj4+IE9uIDI5LjA3LjIwMjIgMDk6MDQsIEphbmUgTWFsYWxh
bmUgd3JvdGU6DQo+Pj4+IEBAIC0xMjUsNiArMTMwLDkgQEAgREVGSU5FX0lEVEVOVFJZX1NZ
U1ZFQyhzeXN2ZWNfeGVuX2h2bV9jYWxsYmFjaykNCj4+Pj4gICB7DQo+Pj4+ICAgCXN0cnVj
dCBwdF9yZWdzICpvbGRfcmVncyA9IHNldF9pcnFfcmVncyhyZWdzKTsNCj4+Pj4gICANCj4+
Pj4gKwlpZiAoeGVuX3BlcmNwdV91cGNhbGwpDQo+Pj4+ICsJCWFja19BUElDX2lycSgpOw0K
Pj4+PiArDQo+Pj4+ICAgCWluY19pcnFfc3RhdChpcnFfaHZfY2FsbGJhY2tfY291bnQpOw0K
Pj4+PiAgIA0KPj4+PiAgIAl4ZW5faHZtX2V2dGNobl9kb191cGNhbGwoKTsNCj4+Pj4gQEAg
LTE2OCw2ICsxNzYsMTUgQEAgc3RhdGljIGludCB4ZW5fY3B1X3VwX3ByZXBhcmVfaHZtKHVu
c2lnbmVkIGludCBjcHUpDQo+Pj4+ICAgCWlmICgheGVuX2hhdmVfdmVjdG9yX2NhbGxiYWNr
KQ0KPj4+PiAgIAkJcmV0dXJuIDA7DQo+Pj4+ICAgDQo+Pj4+ICsJaWYgKHhlbl9wZXJjcHVf
dXBjYWxsKSB7DQo+Pj4+ICsJCXJjID0geGVuX3NldF91cGNhbGxfdmVjdG9yKGNwdSk7DQo+
Pj4NCj4+PiAgRnJvbSBhbGwgSSBjYW4gdGVsbCBhdCBsZWFzdCBmb3IgQVBzIHRoaXMgaGFw
cGVucyBiZWZvcmUgc2V0dXBfbG9jYWxfYXBpYygpLg0KPj4+IFdpdGggdGhlcmUgYmVpbmcg
QVBJQyBpbnRlcmFjdGlvbiBpbiB0aGlzIG9wZXJhdGlvbiBtb2RlLCBhcyBzZWVuIGUuZy4g
aW4NCj4+PiB0aGUgZWFybGllciBodW5rIGFib3ZlLCBJIHRoaW5rIHRoaXMgaXMgbG9naWNh
bGx5IHdyb25nLiBBbmQgaXQgbGVhZHMgdG8NCj4+PiBhcGljX3BlbmRpbmdfaW50cl9jbGVh
cigpIGlzc3VpbmcgaXRzIHdhcm5pbmc6IFRoZSB2ZWN0b3IgcmVnaXN0cmF0aW9uLCBhcw0K
Pj4+IGFuIGludGVudGlvbmFsIHNpZGUgZWZmZWN0LCBtYXJrcyB0aGUgdmVjdG9yIGFzIHBl
bmRpbmcuIFVubGVzcyBJUlFzIHdlcmUNCj4+PiBlbmFibGVkIGF0IGFueSBwb2ludCBiZXR3
ZWVuIHRoZSByZWdpc3RyYXRpb24gYW5kIHRoZSBjaGVjaywgdGhlcmUncw0KPj4+IHNpbXBs
eSBubyB3YXkgZm9yIHRoZSBjb3JyZXNwb25kaW5nIElSUiBiaXQgdG8gYmUgZGVhbHQgd2l0
aCAoYnkNCj4+PiBwcm9wYWdhdGluZyB0byBJU1Igd2hlbiB0aGUgaW50ZXJydXB0IGlzIGRl
bGl2ZXJlZCwgYW5kIHRoZW4gYmVpbmcgY2xlYXJlZA0KPj4+IGZyb20gSVNSIGJ5IEVPSSku
DQo+Pg0KPj4gV2l0aCBSb2dlcidzIGhlbHAgSSBub3cgaGF2ZSBhIHBvaW50ZXIgdG8gb3Nz
dGVzdCBhbHNvIGV4cG9zaW5nIHRoZSBpc3N1ZToNCj4+DQo+PiBodHRwOi8vbG9ncy50ZXN0
LWxhYi54ZW5wcm9qZWN0Lm9yZy9vc3N0ZXN0L2xvZ3MvMTc0NTkyL3Rlc3QtYW1kNjQtYW1k
NjQteGwtcHZodjItaW50ZWwvaHV4ZWxyZWJlMC0tLXZhci1sb2cteGVuLWNvbnNvbGUtZ3Vl
c3QtZGViaWFuLmd1ZXN0Lm9zc3Rlc3QubG9nLmd6DQo+IA0KPiBJJ3ZlIG5vdGljZWQgb25s
eSBub3cgdGhhdCBteSBtYWlsIHRvIEphbmUgYm91bmNlZCwgYW5kIEknbSBub3cgdG9sZA0K
PiBzaGUncyBubyBsb25nZXIgaW4gaGVyIHJvbGUgYXQgQ2l0cml4LiBTaW5jZSBJIGRvbid0
IGV4cGVjdCB0byBoYXZlIHRpbWUNCj4gdG8gaW52ZXN0aWdhdGUgYW4gYXBwcm9wcmlhdGUg
c29sdXRpb24gaGVyZSwgbWF5IEkgYXNrIHdoZXRoZXIgb25lIG9mDQo+IHRoZSB0d28gb2Yg
eW91IGNvdWxkIGxvb2sgaW50byB0aGlzLCBiZWluZyB0aGUgbWFpbnRhaW5lcnMgb2YgdGhp
cyBjb2RlPw0KDQpJIHRoaW5rIHRoZSBjb3JyZWN0IHdheSB0byBoYW5kbGUgdGhpcyB3b3Vs
ZCBiZToNCg0KLSByZW5hbWUgQ1BVSFBfQVBfQVJNX1hFTl9TVEFSVElORyB0byBDUFVIUF9B
UF9YRU5fU1RBUlRJTkcNCi0gbW92ZSB0aGUgeGVuX3NldF91cGNhbGxfdmVjdG9yKCkgY2Fs
bCB0byBhIG5ldyBob3RwbHVnIGNhbGxiYWNrDQogICByZWdpc3RlcmVkIGZvciBDUFVIUF9B
UF9YRU5fU1RBUlRJTkcgKHRoaXMgY2FuIGJlIGRvbmUgZXZlbg0KICAgY29uZGl0aW9uYWxs
eSBvbmx5IGlmIHhlbl9wZXJjcHVfdXBjYWxsIGlzIHNldCkNCg0KV3JpdGluZyBhIHBhdGNo
IG5vdyAuLi4NCg0KDQpKdWVyZ2VuDQo=
--------------tf1QLtQu4n1YEyi0ELgOlR0F
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------tf1QLtQu4n1YEyi0ELgOlR0F--

--------------DEY2bd0n5CFo0bkhFII07cP0--

--------------C1r5uw2pnvVs2iKcq7dJOozD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNuD1QFAwAAAAAACgkQsN6d1ii/Ey+G
PQf+LP86UAyDjkJFsH+4lklRY+EQX/COMzwb+/vd6CjA1Q4jgerLOyJxpcJ1z4R6kB+QCIfR+2ks
lnZ5FYZ5XrH+GA6/IeHHk6/9EGPB10Ftk78v3seLMVjDzR4wurIfrEM4jzFQC2Jq7qUqyhApbcPM
aAPJYuPlE34bSpG6R25N9Vpk2ZJls6y8hsgz84gS+U8fvO8cXCwb4kz5C8zZpOjifXsNNMFvD+zI
sMlCRDkzSAFdFTOssGmuwgh93ChLKa+hunEGyX5lvX+EjORC3xGsBZmZzOS5vijjxa+u1HETVGeZ
Y3O74CGsmVeMatk83oJGUVc2R5Af4af6wXh5v8c78g==
=xu0e
-----END PGP SIGNATURE-----

--------------C1r5uw2pnvVs2iKcq7dJOozD--
