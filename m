Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA25B6C1ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCTQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjCTP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:59:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E512847
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:49:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8E0E1F899;
        Mon, 20 Mar 2023 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679327367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9ZCkVbN+vGQwLtZZl9RowXDTyQRoltcbu4S3aQgOyk=;
        b=q9RwDi6g/o3wla4mLMKkDoAAe2daJjUa1LurWZ2jGjecEMYWATaUoSR3I672wsNf9246yb
        5d+dLGHePTAwnjRVDtlDfGS4nSOIH58BfJKCAkC6o6EWq4jmqNvk9cu271snxaEixyp3sc
        fnlrUpUDa7svWjUYG2vNcLDEEo9KS6M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79B9B13416;
        Mon, 20 Mar 2023 15:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2AgiHIeAGGTkUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Mar 2023 15:49:27 +0000
Message-ID: <5990f0a0-eca2-7715-8d10-ce170686a133@suse.com>
Date:   Mon, 20 Mar 2023 16:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
 <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
 <422b2b56-499e-da5c-b071-7c5f2cd27569@intel.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
In-Reply-To: <422b2b56-499e-da5c-b071-7c5f2cd27569@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CMZ2YYDTA5KwKw4FMnkcrD0U"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CMZ2YYDTA5KwKw4FMnkcrD0U
Content-Type: multipart/mixed; boundary="------------Ww540q1NbtO6wrPJmvZYR0X0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Message-ID: <5990f0a0-eca2-7715-8d10-ce170686a133@suse.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
 <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
 <422b2b56-499e-da5c-b071-7c5f2cd27569@intel.com>
In-Reply-To: <422b2b56-499e-da5c-b071-7c5f2cd27569@intel.com>

--------------Ww540q1NbtO6wrPJmvZYR0X0
Content-Type: multipart/mixed; boundary="------------RkQGWMpdqHYgmRpYR05vPdZ0"

--------------RkQGWMpdqHYgmRpYR05vPdZ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDMuMjMgMTY6MzEsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiAzLzIwLzIzIDA2
OjQ5LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+Pg0KPj4+PiBAQCAtNzUwLDYgKzc1MCw3
IEBAIHN0YXRpYyBpbnQgX19pbml0IG10cnJfaW5pdF9maW5pYWxpemUodm9pZCkNCj4+Pj4g
IMKgwqDCoMKgwqDCoCAqIFRCRDogaXMgdGhlcmUgYW55IHN5c3RlbSB3aXRoIHN1Y2ggQ1BV
IHdoaWNoIHN1cHBvcnRzDQo+Pj4+ICDCoMKgwqDCoMKgwqAgKiBzdXNwZW5kL3Jlc3VtZT8g
SWYgbm8sIHdlIHNob3VsZCByZW1vdmUgdGhlIGNvZGUuDQo+Pj4+ICDCoMKgwqDCoMKgwqAg
Ki8NCj4+Pj4gK8KgwqDCoCBtdHJyX3ZhbHVlID0ga2NhbGxvYyhudW1fdmFyX3Jhbmdlcywg
c2l6ZW9mKCptdHJyX3ZhbHVlKSwNCj4+Pj4gR0ZQX0tFUk5FTCk7DQo+Pj4NCj4+PiBUaGVv
cmV0aWNhbGx5IGR5bmFtaWMgYWxsb2NhdGlvbiBjYW4gZmFpbCwgYWx0aG91Z2ggaXQgc2hv
dWxkIG5vdA0KPj4+IGhhcHBlbiBhcyB0aGlzDQo+Pj4gaGFwcGVucyBkdXJpbmcga2VybmVs
IGJvb3QgYW5kIHRoZSBzaXplIGlzIHNtYWxsLsKgIE1heWJlIGEgV0FSTigpPw0KPj4NCj4+
IEZpbmUgd2l0aCBtZS4NCj4gDQo+IFdoYXQgKmFjdHVhbGx5KiBoYXBwZW5zIGlmIHRoZSBz
eXN0ZW0gaXMgcnVubmluZyBvdXQgb2YgbWVtb3J5IGFuZCB0aGlzDQo+IGlzIHRoZSBfZmly
c3RfIGZhaWx1cmU/ICBEb2VzIGEgV0FSTl9PTigpIGhlcmUgaGVscCBzb21lb25lIGRlYnVn
IHdoYXQNCj4gaXMgZ29pbmcgb24/DQoNCkdvb2QgcXVlc3Rpb24uIEVzcGVjaWFsbHkgYXMg
d2UgZG9uJ3Qgc2V0IF9fR0ZQX05PV0FSTiBoZXJlLg0KDQoNCkp1ZXJnZW4NCg==
--------------RkQGWMpdqHYgmRpYR05vPdZ0
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

--------------RkQGWMpdqHYgmRpYR05vPdZ0--

--------------Ww540q1NbtO6wrPJmvZYR0X0--

--------------CMZ2YYDTA5KwKw4FMnkcrD0U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQYgIcFAwAAAAAACgkQsN6d1ii/Ey+T
WQf/a2COya/Avnkrf7hwg/IU9VM1CqUSp3qeQMy/KAgWHT1P80dM8oFnprNJQ02fVuzuN4EFGIWr
eji2kkI7c8u3LNbDxLACcpap8fX86hG/Fw5s5DUVTCk3OjUgeC5YVb2W3q9jvUpacLgZFjnsxeTe
Yu0fJL0M1VO/bSM1u5kAXfqT6LwogqPXmhBIUUzXssjC8tzbr44rnUQnCw5bFWIdDRZS1inOR9JH
j8xrfZcM7SJs68JiuUJG5UkEBIx27L2BC7Fk0LUc685OSUFH4SV+OgmW0Hk8od/rZYTrQ/qgYgXR
8Xp7PFto6MhabDHG4ous3xxh+Kf3Js7aok96yP+J1g==
=F1/b
-----END PGP SIGNATURE-----

--------------CMZ2YYDTA5KwKw4FMnkcrD0U--
