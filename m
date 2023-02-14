Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31742695992
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBNHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjBNHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:04:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE815545
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:04:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5452933A9F;
        Tue, 14 Feb 2023 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676358288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjJb3+/W9nJ8Dx5Kc4uHpoaS5F8BZ+Oz8w5QerGkJ6U=;
        b=Vd19yIX/JAPS5j7Rxntmd9iB1ODr/j2NGhaX7bdDx6UdQPliZ9+maif9Emnuy0IFvb9ce4
        LuPJZ/JlXwG+uW46eIC8sLWIwYa9vJ1f2XVxZ3ih0sire6wGMKPynESPdnVTH/WBHpsiKc
        NvZDIDWdG/TSwRBdLQsTa6/YzjxpMYY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00BDC13A21;
        Tue, 14 Feb 2023 07:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pz8pOo8y62PECgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Feb 2023 07:04:47 +0000
Message-ID: <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
Date:   Tue, 14 Feb 2023 08:04:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic> <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y+qHMsZhYaYEmtTo@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fM1HzvdQ6bS2oRCkXg0hphEs"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fM1HzvdQ6bS2oRCkXg0hphEs
Content-Type: multipart/mixed; boundary="------------CVcGO7WJ0Dd9x2vkU4pTauX6";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic> <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic>
In-Reply-To: <Y+qHMsZhYaYEmtTo@zn.tnic>

--------------CVcGO7WJ0Dd9x2vkU4pTauX6
Content-Type: multipart/mixed; boundary="------------hv6O61v0ZZ4LeNDZ58yDNFYc"

--------------hv6O61v0ZZ4LeNDZ58yDNFYc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTk6NTMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMTMsIDIwMjMgYXQgMDQ6NDQ6MDlQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9rYXksIGFuZCBpdCBoYXMgTVRSUnMgZW5hYmxlZCAoYXMgSHlwZXItViBTRVYtU05Q
IGd1ZXN0cyksIHNvIEkgc2hvdWxkbid0DQo+PiB0ZXN0IHRoYXQsIEkgZ3Vlc3MgKG9yIHdl
IHNob3VsZCBkaXNhYmxlIHRoZSBmZWF0dXJlIGJlZm9yZSBjYWxsaW5nIHRoZQ0KPj4gb3Zl
cndyaXRlIGZ1bmN0aW9uKS4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGhhbmRsZSBURFgg
dGhlIHNhbWUgd2F5IC0gYXMgaWYgdGhlIE1UUlJzIGFyZQ0KPiByZWFkLW9ubHkgdGhlcmUu
IFNvIHlvdSBjYW4gY2hlY2sgWDg2X0ZFQVRVUkVfVERYX0dVRVNUIGluIGFkZGl0aW9uLg0K
DQpPa2F5LCBpZiB5b3UgcmVhbGx5IHdhbnQgdG8gZGljdGF0ZSB0aGUgYWxsb3dlZCB1c2Ug
Y2FzZXMgKHRoaXMgc2VlbXMgdG8gYmUNCmEgbGF5ZXJpbmcgdmlvbGF0aW9uKSwgYnV0IHlv
dSBhcmUgdGhlIG1haW50YWluZXIgb2YgdGhhdCBjb2RlLg0KDQoNCkp1ZXJnZW4NCg0K
--------------hv6O61v0ZZ4LeNDZ58yDNFYc
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

--------------hv6O61v0ZZ4LeNDZ58yDNFYc--

--------------CVcGO7WJ0Dd9x2vkU4pTauX6--

--------------fM1HzvdQ6bS2oRCkXg0hphEs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPrMo8FAwAAAAAACgkQsN6d1ii/Ey+y
5gf+MJyofrU/8tfS6/PSup2HnYhCQ18zDd0jquuw6TVZvX8Jx/Qez/TgGkl/ZiQuW0p4y1qV9qjA
XFQuV1MaoVUzUCWjSG/9Ot2EMoy7veBv6hVWKyBxOlZpMd9G8RqLv3R1cFtvVn3auW6knFSnlgRZ
+1DgL06Gm0+rhyIfiJQ9jL7nu8DNh4VmfpgRJBT54g1hYkRa2ySgPG14DSllki/G+rtfuv/0+Q2z
zbujz+6KbMCuuGuEoq8uhNl8m2ixUK8b77XFLAQqgrjZYlNfpMSQq0aQkypBDqp/Z1SdiIr7FmoD
9QxeVyYjy0Y+02ySLQma9GQnKdFCuexjchlho8w2qQ==
=f6d4
-----END PGP SIGNATURE-----

--------------fM1HzvdQ6bS2oRCkXg0hphEs--
