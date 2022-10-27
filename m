Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5360F883
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiJ0NJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiJ0NI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:08:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39901793A7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:08:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A908421BB8;
        Thu, 27 Oct 2022 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666876134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K/Yhcp3BRAe+TUlSIZuPkdOAfuzDLT+iTdrW+amplZI=;
        b=Xnaxdd95z7IMRprPeIHRTK4gWu7CsTm/SqcYEbAYDwiwmdA8d+FEoCFtcWP3wWEEeB5i/f
        OO52JA7TUEg9pFmBAvdB8cAysEj7EzXajLvtfy16N/BSRcWSgFuV5iWRFCg4GUu3hGM95V
        OTYF5GiCUJtAYfbtplL2NAsplg5P8wE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70284134CA;
        Thu, 27 Oct 2022 13:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bJfwGeaCWmONYAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 27 Oct 2022 13:08:54 +0000
Message-ID: <bdf0b33f-b332-1597-3922-2ff4fa768929@suse.com>
Date:   Thu, 27 Oct 2022 15:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 11/16] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-12-jgross@suse.com> <Y1p2+4W+tydH4peD@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y1p2+4W+tydH4peD@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EFk36EcWhVtEafcFrw2nGxEF"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EFk36EcWhVtEafcFrw2nGxEF
Content-Type: multipart/mixed; boundary="------------uKZVDM2fvmJwd9TTDSAn7hUH";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <bdf0b33f-b332-1597-3922-2ff4fa768929@suse.com>
Subject: Re: [PATCH v4 11/16] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-12-jgross@suse.com> <Y1p2+4W+tydH4peD@zn.tnic>
In-Reply-To: <Y1p2+4W+tydH4peD@zn.tnic>

--------------uKZVDM2fvmJwd9TTDSAn7hUH
Content-Type: multipart/mixed; boundary="------------PFP3hquqNMqa5zuVXRBFcv06"

--------------PFP3hquqNMqa5zuVXRBFcv06
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMTAuMjIgMTQ6MTgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDQsIDIwMjIgYXQgMTA6MTA6MThBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jIGIvYXJj
aC94ODYva2VybmVsL2NwdS9jYWNoZWluZm8uYw0KPj4gaW5kZXggNDliNjBhNDI3ZmM5Li4z
MzBhYTQxMmJlNjMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hl
aW5mby5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jDQo+PiBA
QCAtMTEzNywzICsxMTM3LDEwIEBAIHZvaWQgY2FjaGVfY3B1X2luaXQodm9pZCkNCj4+ICAg
CWNhY2hlX2VuYWJsZSgpOw0KPj4gICAJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPj4g
ICB9DQo+PiArDQo+PiArYm9vbCBjYWNoZV9hcHNfZGVsYXllZF9pbml0Ow0KPiANCj4gV2h5
IGlzbid0IHRoYXQgc3RhdGljIGFuZCBvbmx5IHRoZSBhY2Nlc3NvcnMgc2V0IGl0IG9yIGNs
ZWFyIGl0Pw0KPiANCj4+ICt2b2lkIHNldF9jYWNoZV9hcHNfZGVsYXllZF9pbml0KHZvaWQp
DQo+PiArew0KPj4gKwljYWNoZV9hcHNfZGVsYXllZF9pbml0ID0gdHJ1ZTsNCj4+ICt9DQo+
IA0KPiBPdGhlcndpc2UsIHRoZXJlJ3Mgbm8gcG9pbnQgZm9yIHRoaXMgdGhpbmcuDQoNCkht
bSwgcmlnaHQuDQoNCkknbGwgYWRkIGEgZ2V0X2NhY2hlX2Fwc19kZWxheWVkX2luaXQoKSBh
Y2Nlc3Nvci4NCg0KDQpKdWVyZ2VuDQo=
--------------PFP3hquqNMqa5zuVXRBFcv06
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

--------------PFP3hquqNMqa5zuVXRBFcv06--

--------------uKZVDM2fvmJwd9TTDSAn7hUH--

--------------EFk36EcWhVtEafcFrw2nGxEF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNaguYFAwAAAAAACgkQsN6d1ii/Ey9d
vgf/QG+j047I21Nb6OaQmXEYXOnxwLuJQ6DQ1ngUWg9vqSp/4Okl5zKUSeAJMdCo3VAMKnd/4VGq
fNKO40gnvSzJSkRSoY8XaaR8V6zpDKNsUOmTrbGzH/JpPGZD0Cv9icekjwAdcDgy3YK6646OWzwi
iF/WjzOhBy44SdzpO0J84hF2W0Idm42Pp7RPFAN8YIwyWgsk5iEF5YJRzGM8a2YL8Fbf2RpA+c/8
Wd0B2bZ60+m1f5Yhi10ianfz7G5RG4DBeWUaKD6WKhRoWyd15wHmhvTJEAzIuoedyiHpyycr0YUP
LKMDxqOOl9akQ7q2smx0gmojqzrdvG7O1TsxsvYs4A==
=fBZH
-----END PGP SIGNATURE-----

--------------EFk36EcWhVtEafcFrw2nGxEF--
