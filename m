Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4961A625AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiKKMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:44:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2A19C0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:44:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1DA220139;
        Fri, 11 Nov 2022 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668170659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHLVtlGvNUo2QbTFNdF4X8PIvYLZYIjqtQgebJXxiWc=;
        b=f4d3gKGf7D3Kfb273CsZYzqr/R7yLMLkO7JA/yUmyRCREZKkzwSH6t2a0wiG+MwPPJvSyN
        zZOuktfvMXa8cgDOMYsi3cn67yQBoFksldF32VnJR0kdq3Go4Yg555Prh/blaToYKR4JeU
        KyAUTROPTv09HX6kHv0Hk+SsXBy466w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6A213357;
        Fri, 11 Nov 2022 12:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIpMHKNDbmOvUgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Nov 2022 12:44:19 +0000
Message-ID: <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
Date:   Fri, 11 Nov 2022 13:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
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
 <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
In-Reply-To: <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RC0z0fZj2rQ40xWZ1MdQ0Lnn"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RC0z0fZj2rQ40xWZ1MdQ0Lnn
Content-Type: multipart/mixed; boundary="------------iWWawB60R0iaQYOmG0H0B83k";
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
Message-ID: <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
 <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
In-Reply-To: <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>

--------------iWWawB60R0iaQYOmG0H0B83k
Content-Type: multipart/mixed; boundary="------------bn0Y0emSpJJpT0zCz5kDR6cA"

--------------bn0Y0emSpJJpT0zCz5kDR6cA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMTEuMjIgMTA6MDEsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDA4LjExLjIy
IDE3OjI2LCBKYW4gQmV1bGljaCB3cm90ZToNCj4+IE9uIDAzLjExLjIwMjIgMTY6NDEsIEph
biBCZXVsaWNoIHdyb3RlOg0KPj4+IE9uIDAzLjExLjIwMjIgMTQ6MzgsIEphbiBCZXVsaWNo
IHdyb3RlOg0KPj4+PiBPbiAyOS4wNy4yMDIyIDA5OjA0LCBKYW5lIE1hbGFsYW5lIHdyb3Rl
Og0KPj4+Pj4gQEAgLTEyNSw2ICsxMzAsOSBAQCBERUZJTkVfSURURU5UUllfU1lTVkVDKHN5
c3ZlY194ZW5faHZtX2NhbGxiYWNrKQ0KPj4+Pj4gwqAgew0KPj4+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgcHRfcmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3JlZ3MocmVncyk7DQo+Pj4+PiAr
wqDCoMKgIGlmICh4ZW5fcGVyY3B1X3VwY2FsbCkNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBh
Y2tfQVBJQ19pcnEoKTsNCj4+Pj4+ICsNCj4+Pj4+IMKgwqDCoMKgwqAgaW5jX2lycV9zdGF0
KGlycV9odl9jYWxsYmFja19jb3VudCk7DQo+Pj4+PiDCoMKgwqDCoMKgIHhlbl9odm1fZXZ0
Y2huX2RvX3VwY2FsbCgpOw0KPj4+Pj4gQEAgLTE2OCw2ICsxNzYsMTUgQEAgc3RhdGljIGlu
dCB4ZW5fY3B1X3VwX3ByZXBhcmVfaHZtKHVuc2lnbmVkIGludCBjcHUpDQo+Pj4+PiDCoMKg
wqDCoMKgIGlmICgheGVuX2hhdmVfdmVjdG9yX2NhbGxiYWNrKQ0KPj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAwOw0KPj4+Pj4gK8KgwqDCoCBpZiAoeGVuX3BlcmNwdV91cGNh
bGwpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByYyA9IHhlbl9zZXRfdXBjYWxsX3ZlY3Rv
cihjcHUpOw0KPj4+Pg0KPj4+PiDCoEZyb20gYWxsIEkgY2FuIHRlbGwgYXQgbGVhc3QgZm9y
IEFQcyB0aGlzIGhhcHBlbnMgYmVmb3JlIHNldHVwX2xvY2FsX2FwaWMoKS4NCj4+Pj4gV2l0
aCB0aGVyZSBiZWluZyBBUElDIGludGVyYWN0aW9uIGluIHRoaXMgb3BlcmF0aW9uIG1vZGUs
IGFzIHNlZW4gZS5nLiBpbg0KPj4+PiB0aGUgZWFybGllciBodW5rIGFib3ZlLCBJIHRoaW5r
IHRoaXMgaXMgbG9naWNhbGx5IHdyb25nLiBBbmQgaXQgbGVhZHMgdG8NCj4+Pj4gYXBpY19w
ZW5kaW5nX2ludHJfY2xlYXIoKSBpc3N1aW5nIGl0cyB3YXJuaW5nOiBUaGUgdmVjdG9yIHJl
Z2lzdHJhdGlvbiwgYXMNCj4+Pj4gYW4gaW50ZW50aW9uYWwgc2lkZSBlZmZlY3QsIG1hcmtz
IHRoZSB2ZWN0b3IgYXMgcGVuZGluZy4gVW5sZXNzIElSUXMgd2VyZQ0KPj4+PiBlbmFibGVk
IGF0IGFueSBwb2ludCBiZXR3ZWVuIHRoZSByZWdpc3RyYXRpb24gYW5kIHRoZSBjaGVjaywg
dGhlcmUncw0KPj4+PiBzaW1wbHkgbm8gd2F5IGZvciB0aGUgY29ycmVzcG9uZGluZyBJUlIg
Yml0IHRvIGJlIGRlYWx0IHdpdGggKGJ5DQo+Pj4+IHByb3BhZ2F0aW5nIHRvIElTUiB3aGVu
IHRoZSBpbnRlcnJ1cHQgaXMgZGVsaXZlcmVkLCBhbmQgdGhlbiBiZWluZyBjbGVhcmVkDQo+
Pj4+IGZyb20gSVNSIGJ5IEVPSSkuDQo+Pj4NCj4+PiBXaXRoIFJvZ2VyJ3MgaGVscCBJIG5v
dyBoYXZlIGEgcG9pbnRlciB0byBvc3N0ZXN0IGFsc28gZXhwb3NpbmcgdGhlIGlzc3VlOg0K
Pj4+DQo+Pj4gaHR0cDovL2xvZ3MudGVzdC1sYWIueGVucHJvamVjdC5vcmcvb3NzdGVzdC9s
b2dzLzE3NDU5Mi90ZXN0LWFtZDY0LWFtZDY0LXhsLXB2aHYyLWludGVsL2h1eGVscmViZTAt
LS12YXItbG9nLXhlbi1jb25zb2xlLWd1ZXN0LWRlYmlhbi5ndWVzdC5vc3N0ZXN0LmxvZy5n
eg0KPj4NCj4+IEkndmUgbm90aWNlZCBvbmx5IG5vdyB0aGF0IG15IG1haWwgdG8gSmFuZSBi
b3VuY2VkLCBhbmQgSSdtIG5vdyB0b2xkDQo+PiBzaGUncyBubyBsb25nZXIgaW4gaGVyIHJv
bGUgYXQgQ2l0cml4LiBTaW5jZSBJIGRvbid0IGV4cGVjdCB0byBoYXZlIHRpbWUNCj4+IHRv
IGludmVzdGlnYXRlIGFuIGFwcHJvcHJpYXRlIHNvbHV0aW9uIGhlcmUsIG1heSBJIGFzayB3
aGV0aGVyIG9uZSBvZg0KPj4gdGhlIHR3byBvZiB5b3UgY291bGQgbG9vayBpbnRvIHRoaXMs
IGJlaW5nIHRoZSBtYWludGFpbmVycyBvZiB0aGlzIGNvZGU/DQo+IA0KPiBJIHRoaW5rIHRo
ZSBjb3JyZWN0IHdheSB0byBoYW5kbGUgdGhpcyB3b3VsZCBiZToNCj4gDQo+IC0gcmVuYW1l
IENQVUhQX0FQX0FSTV9YRU5fU1RBUlRJTkcgdG8gQ1BVSFBfQVBfWEVOX1NUQVJUSU5HDQo+
IC0gbW92ZSB0aGUgeGVuX3NldF91cGNhbGxfdmVjdG9yKCkgY2FsbCB0byBhIG5ldyBob3Rw
bHVnIGNhbGxiYWNrDQo+ICDCoCByZWdpc3RlcmVkIGZvciBDUFVIUF9BUF9YRU5fU1RBUlRJ
TkcgKHRoaXMgY2FuIGJlIGRvbmUgZXZlbg0KPiAgwqAgY29uZGl0aW9uYWxseSBvbmx5IGlm
IHhlbl9wZXJjcHVfdXBjYWxsIGlzIHNldCkNCj4gDQo+IFdyaXRpbmcgYSBwYXRjaCBub3cg
Li4uDQoNCkZvciB0aGUgQVBzIHRoaXMgaXMgd29ya2luZyBhcyBleHBlY3RlZC4NCg0KVGhl
IGJvb3QgcHJvY2Vzc29yIHNlZW1zIHRvIGJlIGhhcmRlciB0byBmaXguIFRoZSByZWxhdGVk
IG1lc3NhZ2UgaXMgYmVpbmcNCmlzc3VlZCBldmVuIHdpdGggaW50ZXJydXB0cyBiZWluZyBv
biB3aGVuIHNldHVwX2xvY2FsX0FQSUMoKSBpcyBjYWxsZWQuDQoNCkkndmUgdHJpZWQgdG8g
cmVnaXN0ZXIgdGhlIGNhbGxiYWNrIG9ubHkgYWZ0ZXIgdGhlIHNldHVwX2xvY2FsX0FQSUMo
KSBjYWxsLA0KYnV0IHRoaXMgcmVzdWx0cyBpbiBhIHN5c3RlbSBoYW5nIHdoZW4gdGhlIEFQ
cyBhcmUgc3RhcnRlZC4NCg0KQW55IGlkZWFzPw0KDQoNCkp1ZXJnZW4NCg==
--------------bn0Y0emSpJJpT0zCz5kDR6cA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------bn0Y0emSpJJpT0zCz5kDR6cA--

--------------iWWawB60R0iaQYOmG0H0B83k--

--------------RC0z0fZj2rQ40xWZ1MdQ0Lnn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNuQ6MFAwAAAAAACgkQsN6d1ii/Ey83
1QgAhQ6o6Gtpiho0auSQ1GHFKXoaL8gwudJwqh6sl3eSqa55ZqAPtIYuMqhesz1L/yXTDyohddPo
S9YPTA0ApT1dAJSV2bj5DTbTyYf/cFQlEXx+1kWKI7I+bfH3V14h1KauYeQHdDvxnRPSyhEjuSDT
n47RMH90ueVbZUvNFFw/0imZWO/fjp4f51mF1C8S2r1emOcOgScYxaqFDHIKHU9BzDImQMjyNdWR
2ax36MUeSh8Pze2zflrs3zIi8JIFWV2psLo8DbETK51Qmn+VO5ey4BhDqFuYjslHxxz7oA3H5TZG
LL1FC+kdDjcGM0Hacy4d2wk10ob4cNwTxPJCfCVsoQ==
=6X9E
-----END PGP SIGNATURE-----

--------------RC0z0fZj2rQ40xWZ1MdQ0Lnn--
