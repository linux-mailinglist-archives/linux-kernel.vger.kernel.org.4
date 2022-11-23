Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE863635F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiKWPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiKWPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:23:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44302DEC9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:23:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97C9B2189C;
        Wed, 23 Nov 2022 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669217017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jKl/2n9Duri+V7Xv3uOwwgRb3uvvikmr0ukBZFQf1Mk=;
        b=SpMCIN1fG4zdYwA/9m9VIQZEsDVepCuyJHYGstcGmykqeWS6jCqp7+BOGK79IM5AQGTEBu
        xFV8ML12tBpahAUOoPbp0I65GxNG+mwhuQs+BibU0sN8y+1W6mFjTlyGi+wOPb7TV4i9N2
        6aaekmcqjA+klYD/+yQS+M65v2Xow80=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDD413A37;
        Wed, 23 Nov 2022 15:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SAFNDfk6fmPzPAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Nov 2022 15:23:37 +0000
Message-ID: <33b9d446-9907-ded6-114e-ce6c43cc3446@suse.com>
Date:   Wed, 23 Nov 2022 16:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] x86/xen: Fix memory leak issue
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, boris.ostrovsky@oracle.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jeremy@goop.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20221119085923.114889-1-xiujianfeng@huawei.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221119085923.114889-1-xiujianfeng@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N0DXiimiY7GNPY1AcmXVm3jz"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N0DXiimiY7GNPY1AcmXVm3jz
Content-Type: multipart/mixed; boundary="------------1NYcsdjiV7vBEFvXxW2W3UAe";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>, boris.ostrovsky@oracle.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, jeremy@goop.org
Cc: x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <33b9d446-9907-ded6-114e-ce6c43cc3446@suse.com>
Subject: Re: [PATCH 0/2] x86/xen: Fix memory leak issue
References: <20221119085923.114889-1-xiujianfeng@huawei.com>
In-Reply-To: <20221119085923.114889-1-xiujianfeng@huawei.com>

--------------1NYcsdjiV7vBEFvXxW2W3UAe
Content-Type: multipart/mixed; boundary="------------gcK0ynbRDzFYOLkNi00ebDV5"

--------------gcK0ynbRDzFYOLkNi00ebDV5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTEuMjIgMDk6NTksIFhpdSBKaWFuZmVuZyB3cm90ZToNCj4gVGhlIG5ldyBzdHJp
bmcgYWxsb2NhdGVkIGJ5IGthc3ByaW50ZigpIGlzIGxlYWtlZCBvbiBlcnJvciBwYXRoDQo+
IA0KPiBYaXUgSmlhbmZlbmcgKDIpOg0KPiAgICB4ODYveGVuOiBGaXggbWVtb3J5IGxlYWsg
aW4geGVuX3NtcF9pbnRyX2luaXR7X3B2fSgpDQo+ICAgIHg4Ni94ZW46IEZpeCBtZW1vcnkg
bGVhayBpbiB4ZW5faW5pdF9sb2NrX2NwdSgpDQo+IA0KPiAgIGFyY2gveDg2L3hlbi9zbXAu
YyAgICAgIHwgMTYgKysrKysrKysrKysrLS0tLQ0KPiAgIGFyY2gveDg2L3hlbi9zbXBfcHYu
YyAgIHwgIDggKysrKysrLS0NCj4gICBhcmNoL3g4Ni94ZW4vc3BpbmxvY2suYyB8ICAzICsr
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gDQoNCkhtbSwgSSB0aGluayBpdCB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UgdG8gYWx3
YXlzIHN0b3JlIHRoZSBuYW1lIGdlbmVyYXRlZA0KdmlhIGthc3ByaW50ZigpIGluIHRoZSBw
ZXJjcHUgdmFyaWFibGUgKGluZGVwZW5kZW50bHkgZnJvbSBzdWNjZWVkaW5nIHRvDQpiaW5k
IHRoZSBpcnEpLCBhbmQgaW4gdGhlIHJlbGF0ZWQgZnJlZSBmdW5jdGlvbiB0byBhbHdheXMg
a2ZyZWUoKSBpdCBhbmQNCnNldCBpdCB0byBOVUxMIGFnYWluLg0KDQpUaGlzIHdvdWxkIHJl
c3VsdCBpbiBsZXNzIGNvZGUuDQoNCg0KSnVlcmdlbg0K
--------------gcK0ynbRDzFYOLkNi00ebDV5
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

--------------gcK0ynbRDzFYOLkNi00ebDV5--

--------------1NYcsdjiV7vBEFvXxW2W3UAe--

--------------N0DXiimiY7GNPY1AcmXVm3jz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN+OvgFAwAAAAAACgkQsN6d1ii/Ey8f
6Qf+La6ZMkz0ZDoFJuXcyC/fOUM3aKhp9xRv7KTtSs2t2eodYiFenV0E2n1nMMCOpxHyGo0EqcEe
AGd5YxjEo2CD09e3UyEFfDLr3ikFePLQXNuCHaMU5Yoeje6Ut253GUmI5ju+zkbe7fmmmdpLikdv
MwuAOcGtaEBlhiNjUGMFdVsGT98gwAn1EV/3V3yqPI8/xTHTrmsuD+K2UmEmzrklo4reoKSPJGVu
rRwFof65d74gPHNbnRTJjOhPN70rl4hVfljFvyEJ0viZfAllKQ1N803CM9PLD10Yyf5bbX5Ra71a
t+25zCFcNorbPav7VPn0vwSIvJnTQrcuOUbqAPViZA==
=nikX
-----END PGP SIGNATURE-----

--------------N0DXiimiY7GNPY1AcmXVm3jz--
