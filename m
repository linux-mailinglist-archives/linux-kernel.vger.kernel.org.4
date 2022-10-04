Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B485F4690
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJDPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJDPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:22:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B365FADF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 234AC1F946;
        Tue,  4 Oct 2022 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664896955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztO8EC+dr3f2nMhi3IFt0zPBk4xyQJswjPDPygoUBFY=;
        b=FAI5ynOJEkMoD9sKCmKcMm1JYpp+HlCVAmbSm5bLkbUSZkyc3pTmlB1oaXkRJrP+SctDQJ
        YqIlA5tTgTpsNFraMFEqw47z/j8uLFebdGeV0fWAXNeRhQp0yi0VxEXstLYo3QuR1I7inf
        HXFdl6RuHgUcpCH17n1le/z2MXW1UI0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D29E7139D2;
        Tue,  4 Oct 2022 15:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jSc5MrpPPGPaDwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 15:22:34 +0000
Message-ID: <e5d0e772-ec9e-049a-da85-960c14520f8c@suse.com>
Date:   Tue, 4 Oct 2022 17:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221004084335.2838-1-jgross@suse.com>
 <20221004084335.2838-2-jgross@suse.com>
 <a070485a-1eed-420c-552f-16688e89d65f@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/3] xen/pv: allow pmu msr accesses to cause GP
In-Reply-To: <a070485a-1eed-420c-552f-16688e89d65f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ylOBkMi3KrIFlhK6qITfHmms"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ylOBkMi3KrIFlhK6qITfHmms
Content-Type: multipart/mixed; boundary="------------OHgQ8PYiZ0c5e82bKznoBttG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Message-ID: <e5d0e772-ec9e-049a-da85-960c14520f8c@suse.com>
Subject: Re: [PATCH v2 1/3] xen/pv: allow pmu msr accesses to cause GP
References: <20221004084335.2838-1-jgross@suse.com>
 <20221004084335.2838-2-jgross@suse.com>
 <a070485a-1eed-420c-552f-16688e89d65f@suse.com>
In-Reply-To: <a070485a-1eed-420c-552f-16688e89d65f@suse.com>

--------------OHgQ8PYiZ0c5e82bKznoBttG
Content-Type: multipart/mixed; boundary="------------rHvXbeQpZOqfBNJlLZAFH0yZ"

--------------rHvXbeQpZOqfBNJlLZAFH0yZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTAuMjIgMTI6NTgsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAwNC4xMC4yMDIy
IDEwOjQzLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gVG9kYXkgcG11X21zcl9yZWFkKCkg
YW5kIHBtdV9tc3Jfd3JpdGUoKSBmYWxsIGJhY2sgdG8gdGhlIHNhZmUgdmFyaWFudHMNCj4+
IG9mIHJlYWQvd3JpdGUgTVNSIGluIGNhc2UgdGhlIE1TUiBhY2Nlc3MgaXNuJ3QgZW11bGF0
ZWQgdmlhIFhlbi4gQWxsb3cNCj4+IHRoZSBjYWxsZXIgdG8gc2VsZWN0IHRoZSBwb3RlbnRp
YWxseSBmYXVsdGluZyB2YXJpYW50IGJ5IHBhc3NpbmcgTlVMTA0KPj4gZm9yIHRoZSBlcnJv
ciBwb2ludGVyLg0KPj4NCj4+IFJlc3RydWN0dXJlIHRoZSBjb2RlIHRvIG1ha2UgaXQgbW9y
ZSByZWFkYWJsZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IA0KPiBJIHRoaW5rIHRoZSB0aXRsZSAoYW5kIHRvIHNvbWUgZGVn
cmVlIGFsc28gdGhlIGRlc2NyaXB0aW9uKSBpcyBtaXNsZWFkaW5nOg0KPiBUaGUgcHJvcGVy
dHkgd2UgY2FyZSBhYm91dCBoZXJlIGlzbid0IHdoZXRoZXIgYW4gTVNSIGFjY2VzcyB3b3Vs
ZCByYWlzZQ0KPiAjR1AgKHdlIGNhbid0IGNvbnRyb2wgdGhhdCksIGJ1dCB3aGV0aGVyIHRo
YXQgI0dQIHdvdWxkIGJlIHJlY292ZXJlZCBmcm9tLg0KDQpXb3VsZCB5b3UgYmUgZmluZSB3
aXRoIGFkZGluZyAiZmF0YWwiIG9yICJ2aXNpYmxlIj8NCg0KPiANCj4+IC0tLSBhL2FyY2gv
eDg2L3hlbi9wbXUuYw0KPj4gKysrIGIvYXJjaC94ODYveGVuL3BtdS5jDQo+PiBAQCAtMTMx
LDYgKzEzMSw5IEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2V0X2ZhbTE1aF9hZGRyKHUz
MiBhZGRyKQ0KPj4gICANCj4+ICAgc3RhdGljIGlubGluZSBib29sIGlzX2FtZF9wbXVfbXNy
KHVuc2lnbmVkIGludCBtc3IpDQo+PiAgIHsNCj4+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2
X3ZlbmRvciA9PSBYODZfVkVORE9SX0lOVEVMKQ0KPj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAN
Cj4gSSB1bmRlcnN0YW5kIHRoaXMgYW5kIC4uLg0KPiANCj4+IEBAIC0xNDQsNiArMTQ3LDkg
QEAgc3RhdGljIGludCBpc19pbnRlbF9wbXVfbXNyKHUzMiBtc3JfaW5kZXgsIGludCAqdHlw
ZSwgaW50ICppbmRleCkNCj4+ICAgew0KPj4gICAJdTMyIG1zcl9pbmRleF9wbWM7DQo+PiAg
IA0KPj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5U
RUwpDQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAuLi4gdGhpcyBtYXRjaGVzIHByaW9y
IGJlaGF2aW9yLCBidXQgbWF5IEkgc3VnZ2VzdCB0aGF0IHdoaWxlIG1vdmluZw0KPiB0aGVz
ZSBoZXJlIHlvdSBhdCBsZWFzdCBhY2NvbXBhbnkgdGhlbSBieSBhIGNvbW1lbnQgY2xhcmlm
eWluZyB0aGF0DQo+IHRoZXNlIGFyZW4ndCByZWFsbHkgY29ycmVjdD8gV2UnZCBjb21lIGNs
b3NlciBpZiBpc19hbWRfcG11X21zcigpDQo+IGFjY2VwdGVkIEFNRCBhbmQgSHlnb24sIHdo
aWxlIGlzX2ludGVsX3BtdV9tc3IoKSBtYXkgd2FudCB0byBhY2NlcHQNCj4gSW50ZWwgYW5k
IENlbnRhdXIgKGJ1dCBJIHVuZGVyc3RhbmQgdGhpcyB3b3VsZCBiZSBsYXJnZWx5IG9ydGhv
Z29uYWwsDQo+IGhlbmNlIHRoZSBzdWdnZXN0aW9uIHRvd2FyZHMgY29tbWVudHMpLiBJbiB0
aGUgaHlwZXJ2aXNvciB3ZSBraW5kIG9mDQo+IGFsc28gc3VwcG9ydCBTaGFuZ2hhaSwgYnV0
IEkgd29uZGVyIHdoZXRoZXIgd2Ugd291bGRuJ3QgYmV0dGVyIHJpcA0KPiBvdXQgdGhhdCBj
b2RlIGFzIHVubWFpbnRhaW5lZC4NCg0KTWF5YmUgdGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8g
d291bGQgYmUgdG8gYWRkIGFub3RoZXIgcGF0Y2ggdG8gZml4DQppc18qX3BtdV9tc3IoKSBh
bG9uZyB0aGUgbGluZXMgeW91IGFyZSBzdWdnZXN0aW5nLg0KDQoNCkp1ZXJnZW4NCg==
--------------rHvXbeQpZOqfBNJlLZAFH0yZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------rHvXbeQpZOqfBNJlLZAFH0yZ--

--------------OHgQ8PYiZ0c5e82bKznoBttG--

--------------ylOBkMi3KrIFlhK6qITfHmms
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM8T7oFAwAAAAAACgkQsN6d1ii/Ey+q
wQgAjZm7tGCX48b2teXUYLXun4s3xNovmtBtNBgh/oD7sN15PaA+XbJERuFIqtjPLfxeii3QKXqu
BNorT6uhYhCOQEOmQF/Zi8UTn/R9mcrSXFTHMm9UP7SabIsxCVTVd7/iRFBZK4J4HaNu1uppqNKz
Da5aou+Kihm3YeEIHj98A3RkOqJkvXRH/Nov+VZ+/ooXHKVK63sN4XRUm3dc4a/9AcjUI1km7hM/
6JkIiSzGwNrWzofSVz6uyAAEewOsNHpa/iGZN0muq6nlGJoPTo3DDKD+SVqY8RSLbBGOGnY2ngK7
KWWyVGCB1P+Giw7wFNhHEBudEmrzb2LJ8CjpzVcKRg==
=+WhU
-----END PGP SIGNATURE-----

--------------ylOBkMi3KrIFlhK6qITfHmms--
