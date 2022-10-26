Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0826A60DFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiJZLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiJZLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:45:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AE631C3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:43:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 058641FD49;
        Wed, 26 Oct 2022 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666784633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ys4xNvzZzoV6NhjjKTKeJNUpYb8jx3gdrJfys6MihAM=;
        b=NODA1qYx5RkjBiNYo4GO2kvxMI5xRG3xzM/KhpGMqCv/GYJIS1Yo8gbAn/EcVNFzlGDjdg
        DlMB7ZUKYhrkujn+O9OJNdnkmpmj1dfFHFV9H7e5r1ywfkzQv7rV2dfOFHck18/OqasOfo
        RUwfyYIKagIRTAmr+5OS91UQ9zHYMbY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEAE713A6E;
        Wed, 26 Oct 2022 11:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GZ70LHgdWWOEKQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 26 Oct 2022 11:43:52 +0000
Message-ID: <52410187-f277-a4a0-f369-9390d25a70f6@suse.com>
Date:   Wed, 26 Oct 2022 13:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 07/16] x86/mtrr: split generic_set_all()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-8-jgross@suse.com> <Y1kOAUDYW7HpRvfl@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y1kOAUDYW7HpRvfl@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------40xD8u4HgTOwFnkBfPeRElUj"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------40xD8u4HgTOwFnkBfPeRElUj
Content-Type: multipart/mixed; boundary="------------kBD4300sd5ABaEpB20YFVWOG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <52410187-f277-a4a0-f369-9390d25a70f6@suse.com>
Subject: Re: [PATCH v4 07/16] x86/mtrr: split generic_set_all()
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-8-jgross@suse.com> <Y1kOAUDYW7HpRvfl@zn.tnic>
In-Reply-To: <Y1kOAUDYW7HpRvfl@zn.tnic>

--------------kBD4300sd5ABaEpB20YFVWOG
Content-Type: multipart/mixed; boundary="------------XaXytphsQQ0uuBUCatGKR9hr"

--------------XaXytphsQQ0uuBUCatGKR9hr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMTAuMjIgMTI6MzcsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDQsIDIwMjIgYXQgMTA6MTA6MTRBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFNwbGl0IGdlbmVyaWNfc2V0X2FsbCgpIGludG8gbXVsdGlwbGUgcGFydHMsIHdoaWxl
IG1vdmluZyB0aGUgbWFpbg0KPj4gZnVuY3Rpb24gYm9keSBpbnRvIGNhY2hlaW5mby5jLg0K
Pj4NCj4+IFByZXBhcmUgdGhlIHN1cHBvcnQgb2YgUEFUIHdpdGhvdXQgbmVlZGluZyBNVFJS
IHN1cHBvcnQgYnkNCj4+IG1vdmluZyB0aGUgbWFpbiBmdW5jdGlvbiBib2R5IG9mIGdlbmVy
aWNfc2V0X2FsbCgpIGludG8gY2FjaGVpbmZvLmMNCj4+IHdoaWxlIHJlbmFtaW5nIGl0IHRv
IGNhY2hlX2NwdV9pbml0KCkuIFRoZSBNVFJSIHNwZWNpZmljIHBhcnRzIGFyZQ0KPj4gbW92
ZWQgaW50byBhIGRlZGljYXRlZCBzbWFsbCBmdW5jdGlvbiBjYWxsZWQgYnkgY2FjaGVfY3B1
X2luaXQoKSBpbg0KPj4gb3JkZXIgdG8gbWFrZSBjYWNoZV9jcHVfaW5pdCgpIGFzIE1UUlIg
YWdub3N0aWMgYXMgcG9zc2libGUuDQo+Pg0KPj4gVGhlIHNldHRpbmcgb2Ygc21wX2NoYW5n
ZXNfbWFzayBpcyBtZXJnZWQgaW50byB0aGUgKG5ldykgZnVuY3Rpb24NCj4+IG10cnJfZ2Vu
ZXJpY19zZXRfc3RhdGUoKSB1c2VkIHRvIGNhbGwgc2V0X210cnJfc3RhdGUoKS4gSXQgd2Fz
DQo+PiBwcm9iYWJseSBzcGxpdCBpbiBhbmNpZW50IHRpbWVzLCBhcyBhdG9taWMgb3BlcmF0
aW9ucyB3aGlsZSBydW5uaW5nDQo+PiB1bmNhY2hlZCBtaWdodCBiZSBxdWl0ZSBleHBlbnNp
dmUsIGJ1dCBPVE9IIG9ubHkgc3lzdGVtcyB3aXRoIGENCj4+IGJyb2tlbiBCSU9TIHNob3Vs
ZCBldmVyIHJlcXVpcmUgdG8gc2V0IGFueSBiaXQgaW4gc21wX2NoYW5nZXNfbWFzaywNCj4+
IHNvIGp1c3QgaHVydGluZyB0aG9zZSBkZXZpY2VzIHdpdGggYSBwZW5hbHR5IG9mIGEgZmV3
IG1pY3Jvc2Vjb25kcw0KPj4gZHVyaW5nIGJvb3Qgc2hvdWxkbid0IGJlIGEgcmVhbCBpc3N1
ZS4NCj4gDQo+IFRoaXMgc3RpbGwgbmVlZHMgYWRkcmVzc2luZw0KPiANCj4gIlNvIHRoZSBj
b21taXQgbWVzc2FnZSBzaG91bGQgbm90IHNheSB3aGF0IHlvdSdyZSBkb2luZyAtIHRoYXQg
c2hvdWxkDQo+IGJlIHZpc2libGUgZnJvbSB0aGUgZGlmZiBpdHNlbGYuIEl0IHNob3VsZCB0
YWxrIG1vcmUgYWJvdXQgdGhlICp3aHkqDQo+IHlvdSdyZSBkb2luZyBpdC4iDQo+IA0KDQpU
aGUgcmVhc29uIGlzICJQcmVwYXJlIHRoZSBzdXBwb3J0IG9mIFBBVCB3aXRob3V0IG5lZWRp
bmcgTVRSUiBzdXBwb3J0Ii4NCg0KRFlNIEkgc2hvdWxkIGp1c3QgcmVtb3ZlIHRoZSByZXN0
IG9mIHRoZSBjb21taXQgbWVzc2FnZT8NCg0KDQpKdWVyZ2VuDQo=
--------------XaXytphsQQ0uuBUCatGKR9hr
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

--------------XaXytphsQQ0uuBUCatGKR9hr--

--------------kBD4300sd5ABaEpB20YFVWOG--

--------------40xD8u4HgTOwFnkBfPeRElUj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNZHXgFAwAAAAAACgkQsN6d1ii/Ey9l
KAgAmZACeS5E+b+pZQxZbTNDmNChwZCsXeKg8WC+/pNt2pTz/qQHc7gZ4pvlArdXV2U82O6n9rs6
wElMnoPMF2+pIZKr9soEy8628qORATU3M4/JlhKrHb/F3hW7xLDkdrws1xFVtSkxpxB4gZemSsa6
S7GzV2YcRqK3Q6xQSy1qjCvcxr56hmy1F/G+mx3SOYQiuVRxV/fDIRH0htTkwHAY+PFiTLNRCuU6
Z0MZpMLo0wBqxUCJS6e26FAQShcjk9WHhbCcGk+an63a1Xhg+2uhKzr6zeru2g4wFNFLtkjrE4f0
LBA75cyUuJs2pPqCmsCcf3olRzL5Ho7SLEH8m3rRsg==
=8IMF
-----END PGP SIGNATURE-----

--------------40xD8u4HgTOwFnkBfPeRElUj--
