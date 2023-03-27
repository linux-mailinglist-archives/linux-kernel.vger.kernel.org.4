Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3B6C9B06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC0FoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0FoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:44:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93744C1B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:44:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BCA721CBA;
        Mon, 27 Mar 2023 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679895839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tr9RCaP4m+EWMqGXf8w97kQMfO94d0LYVb+/NnHsjYg=;
        b=C5mRYTTU7+Pzh1IWfiELnNClU2FqmLcf+dlKBi/kd3Ps2hbnh4pnNJTUkCl2icnPlxnQ2I
        5uKcUo3LKxebFRkVRQu347JWGonYp80aZ948Laryivlolj10LOlfgDaqK5PUdjuqOQ/tYU
        H198J/pIN2bFDDwyLwY5Mw+1bmj11Dg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C61413596;
        Mon, 27 Mar 2023 05:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pkEaAR8tIWTPfAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Mar 2023 05:43:59 +0000
Message-ID: <2bade717-4ee6-49ac-db3d-83937336dd9a@suse.com>
Date:   Mon, 27 Mar 2023 07:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-7-jgross@suse.com>
 <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 06/12] x86/mtrr: replace vendor tests in MTRR code
In-Reply-To: <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j0DMTCmYRXIZE5JIH60lPS8Q"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j0DMTCmYRXIZE5JIH60lPS8Q
Content-Type: multipart/mixed; boundary="------------8JZiRvnNr0qWKK2S0BVKDYIr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2bade717-4ee6-49ac-db3d-83937336dd9a@suse.com>
Subject: Re: [PATCH v4 06/12] x86/mtrr: replace vendor tests in MTRR code
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-7-jgross@suse.com>
 <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>
In-Reply-To: <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>

--------------8JZiRvnNr0qWKK2S0BVKDYIr
Content-Type: multipart/mixed; boundary="------------LFax1qSlCbJe4Hsv0k8ScTsz"

--------------LFax1qSlCbJe4Hsv0k8ScTsz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDMuMjMgMTc6NTYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMDYsIDIwMjMgYXQgMDU6MzQ6MTlQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE1vZGVybiBDUFVzIGFsbCBzaGFyZSB0aGUgc2FtZSBNVFJSIGludGVyZmFjZSBpbXBs
ZW1lbnRlZCB2aWENCj4+IGdlbmVyaWNfbXRycl9vcHMuDQo+Pg0KPj4gQXQgc2V2ZXJhbCBw
bGFjZXMgaW4gTVRSUiBjb2RlIHRoaXMgZ2VuZXJpYyBpbnRlcmZhY2UgaXMgZGVkdWNlZCB2
aWENCj4+IGlzX2NwdShJTlRFTCkgdGVzdHMsIHdoaWNoIGlzIG9ubHkgd29ya2luZyBkdWUg
dG8gWDg2X1ZFTkRPUl9JTlRFTA0KPj4gYmVpbmcgMCAodGhlIGlzX2NwdSgpIG1hY3JvIGlz
IHRlc3RpbmcgbXRycl9pZi0+dmVuZG9yLCB3aGljaCBpc24ndA0KPj4gZXhwbGljaXRseSBz
ZXQgaW4gZ2VuZXJpY19tdHJyX29wcykuDQo+Pg0KPj4gRml4IHRoYXQgYnkgcmVwbGFjaW5n
IHRoZSBpc19jcHUoSU5URUwpIHRlc3RzIHdpdGggdGVzdGluZyBmb3IgbXRycl9pZg0KPj4g
dG8gYmUgJmdlbmVyaWNfbXRycl9vcHMuDQo+IA0KPiBUd28gdGhpbmdzOg0KPiANCj4gKiBp
c19jcHUoKSBjaGVja3MgYWxzbyB3aGV0aGVyIG10cnJfaWYgaXMgc2V0LiBBbmQgd2UgZG9u
J3Qgc2V0IGl0IGZvcg0KPiBhbGwgdmVuZG9ycy4gSSB3YW50ZWQgdG8gcmVwbGFjZSB0aGF0
IHRoaW5nIHdpdGggYSB2ZW5kb3IgY2hlY2sgcmVjZW50bHkNCj4gYnV0IHRoZXJlJ3MgdGhh
dCBsaXR0bGUgaXNzdWUuDQoNClRoZSBpc19jcHUoKSBjaGVja3MgYXJlIGVpdGhlciBpbiBm
dW5jdGlvbnMgcmVhY2hhYmxlIG9ubHkgd2l0aCBtdHJyX2lmIGJlaW5nDQpzZXQsIG9yIGFy
ZSB0ZXN0aW5nIGZvciBJTlRFTCwgd2hpY2ggaXMgcmVwbGFjZWQgYnkgdGhlIHRlc3Qgb2Yg
bXRycl9pZiBiZWluZw0KJmdlbmVyaWNfbXRycl9vcHMgYXMgd3JpdHRlbiBpbiB0aGUgY29t
bWl0IG1lc3NhZ2UuDQoNCj4gSSBndWVzcyBmb3IgdGhlIGNhc2VzIHdoZXJlIHdlIGhhdmUg
dGhlIGdlbmVyaWMgTVRSUiBpbXBsZW1lbnRhdGlvbiwgd2UNCj4gY2FuIHNhZmVseSBhc3N1
bWUgdGhhdCBtdHJyX2lmIGlzIHNldC4gV2hpY2ggbGVhZHMgbWUgdG8gdGhlIHNlY29uZA0K
PiB0aGluZzoNCj4gDQo+ICogSWYgeW91J3JlIGdvaW5nIHRvIHRlc3QgZm9yICZnZW5lcmlj
X210cnJfb3BzLCB0aGVuIHlvdSBjYW4ganVzdCBhcw0KPiB3ZWxsIGRvDQo+IA0KPiAJY3B1
X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9NVFJSKQ0KPiANCj4gd2hpY2ggaXMgYSBs
b3QgbW9yZSB0ZWxsaW5nLg0KDQpZZXMsIEkgdGhpbmsgdGhpcyBpcyB0cnVlLg0KDQo+IA0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+PiBpbmRleCA1ZmU2MmVlMDM2MWIuLjBj
ODM5OTA1MDFmNSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9t
dHJyLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+IEBA
IC0xMDgsMTQgKzEwOCwxMiBAQCBzdGF0aWMgaW50IGhhdmVfd3Jjb21iKHZvaWQpDQo+PiAg
IC8qICBUaGlzIGZ1bmN0aW9uIHJldHVybnMgdGhlIG51bWJlciBvZiB2YXJpYWJsZSBNVFJS
cyAgKi8NCj4+ICAgc3RhdGljIHZvaWQgX19pbml0IHNldF9udW1fdmFyX3Jhbmdlcyhib29s
IHVzZV9nZW5lcmljKQ0KPj4gICB7DQo+PiAtCXVuc2lnbmVkIGxvbmcgY29uZmlnID0gMCwg
ZHVtbXk7DQo+PiArCXVuc2lnbmVkIGxvbmcgY29uZmlnLCBkdW1teTsNCj4+ICAgDQo+PiAg
IAlpZiAodXNlX2dlbmVyaWMpDQo+PiAgIAkJcmRtc3IoTVNSX01UUlJjYXAsIGNvbmZpZywg
ZHVtbXkpOw0KPj4gLQllbHNlIGlmIChpc19jcHUoQU1EKSB8fCBpc19jcHUoSFlHT04pKQ0K
Pj4gLQkJY29uZmlnID0gMjsNCj4+IC0JZWxzZSBpZiAoaXNfY3B1KENZUklYKSB8fCBpc19j
cHUoQ0VOVEFVUikpDQo+PiAtCQljb25maWcgPSA4Ow0KPj4gKwllbHNlDQo+PiArCQljb25m
aWcgPSBtdHJyX2lmLT52YXJfcmVnczsNCj4+ICAgDQo+PiAgIAludW1fdmFyX3JhbmdlcyA9
IGNvbmZpZyAmIDB4ZmY7DQo+PiAgIH0NCj4gDQo+IFNpbmNlIHlvdSdyZSB0b3VjaGluZyB0
aGlzIGZ1bmN0aW9uLCB5b3UgbWlnaHQgc2ltcGx5IGV4cGFuZCBpdHMgYm9keSBpbg0KPiBp
dHMgb25seSBjYWxsIHNpdGUgaW4gbXRycl9icF9pbml0KCksIHB1dCBhIGNvbW1lbnQgYWJv
dmUgdGhlIGV4cGFuZGVkDQo+IGNvZGUgYW5kIHJlbW92ZSB0aGF0IGZ1bmN0aW9uLg0KDQpP
a2F5Lg0KDQoNCkp1ZXJnZW4NCg==
--------------LFax1qSlCbJe4Hsv0k8ScTsz
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

--------------LFax1qSlCbJe4Hsv0k8ScTsz--

--------------8JZiRvnNr0qWKK2S0BVKDYIr--

--------------j0DMTCmYRXIZE5JIH60lPS8Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQhLR4FAwAAAAAACgkQsN6d1ii/Ey9i
0Qf+LWAGdEaFuMl5XpJ30za8F+oua20R8n3tf4yt+nY99SCYBmNrcYkTOrtEwOOnJrB8RcNIE8Kz
K6g91jZB9Q71wLpuVFwSXv9+pvlP2SA+DW5NiALBHPJC9gHZW6KvDKAcVimJ0d13lO06DeYAY9a+
FVEDmF2USAERRb/7G3cyGf5iJc6jB8S57JbveKAfvqtGyi0luH1r7jhF+bO7xTlTm1Ww2dsqU2lT
pfG9bTkXQND8yUNhiJ/GlkQrqLg+479vucdFKU5HzB/H/KA2id3+S+k5R8NgpJNBepA4rRyV6ouz
gZKk5PuQvxue4JGWrMuQtEY4rkHM1iDMNq82Ob4iOw==
=kQZz
-----END PGP SIGNATURE-----

--------------j0DMTCmYRXIZE5JIH60lPS8Q--
