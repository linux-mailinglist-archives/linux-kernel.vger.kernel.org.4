Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3B694C96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBMQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjBMQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:25:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36302D5B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:24:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC5811F8B9;
        Mon, 13 Feb 2023 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676305438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3KZsWS9yq587wT8ZzVLFMR8Ts3cCsLRIsEUUms7WOI=;
        b=LTMij1N3N8Lb+4bkpAC9VeC1wsKsxXm9gkPHTABZ9ajCXFmfYVnsCUo+OYgSbSW0H5SwYX
        FYvjcwJ6ujggFk1lta3UbvMgbJAjgtmgkf0byiecwAGP6IMe2uprQfbXx+BxaCE8tEwENT
        eqXZxiRkboXk3js3oAfwrPGsu1Qzdp0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5985E138E6;
        Mon, 13 Feb 2023 16:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lQVlFB5k6mP2QAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 16:23:58 +0000
Message-ID: <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
Date:   Mon, 13 Feb 2023 17:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
Content-Language: en-US
To:     Christian Kujau <lists@nerdbynature.de>, mikelley@microsoft.com
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZpXCMa5vtEEn05cd52m0ectS"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZpXCMa5vtEEn05cd52m0ectS
Content-Type: multipart/mixed; boundary="------------d1gUdTw0OLkvmENL1ViLh1yA";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christian Kujau <lists@nerdbynature.de>, mikelley@microsoft.com
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
In-Reply-To: <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>

--------------d1gUdTw0OLkvmENL1ViLh1yA
Content-Type: multipart/mixed; boundary="------------mPY7KgYP8W0xmk0oWL40WHYi"

--------------mPY7KgYP8W0xmk0oWL40WHYi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTI6NDYsIENocmlzdGlhbiBLdWphdSB3cm90ZToNCj4gT24gTW9uLCAx
MyBGZWIgMjAyMywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDEwLjAyLjIzIDE5OjU5
LCBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykgd3JvdGU6
DQo+Pj4gSGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2Vy
Lg0KPj4+DQo+Pj4gT24gMDkuMDIuMjMgMDg6MjIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
Pj4+IENvbW1pdCA5MGI5MjZlNjhmNTAgKCJ4ODYvcGF0OiBGaXggcGF0X3hfbXRycl90eXBl
KCkgZm9yIE1UUlIgZGlzYWJsZWQNCj4+Pj4gY2FzZSIpIGhhcyBpbnRyb2R1Y2VkIGEgcmVn
cmVzc2lvbiB3aXRoIFhlbi4NCj4+Pj4NCj4+Pj4gUmV2ZXJ0IHRoZSBwYXRjaC4NCj4+Pg0K
Pj4+IFRoYXQgcmVncmVzc2lvbiB5b3UgcmVmZXIgdG8gaXMgYWZhaWNzIG9uZSBJJ20gdHJh
Y2tpbmdbMV0gdGhhdCB3YXMNCj4+PiBpbnRyb2R1Y2VkIHRoaXMgY3ljbGUuIFRoYXQgbWFr
ZXMgbWUgd29uZGVyOiBjb3VsZCB0aGlzIHBhdGNoIGJlIGFwcGxpZWQNCj4+PiBkaXJlY3Rs
eSB0byBmaXggdGhlIGlzc3VlIHF1aWNrbHk/IE9yIGFyZSBwYXRjaGVzIDEgdG8gNCBuZWVk
ZWQgYXMgd2VsbA0KPj4+IChvciB0aGUgd2hvbGUgc2VyaWVzPykgdG8gYXZvaWQgb3RoZXIg
cHJvYmxlbXM/DQo+Pg0KPj4gUGF0Y2hlcyAxLTQgYXJlIG5lZWRlZCwgdG9vLCBhcyBvdGhl
cndpc2UgdGhlIGlzc3VlIGNsYWltZWQgdG8gYmUgZml4ZWQNCj4+IHdpdGggcGF0Y2ggNSB3
b3VsZCBzaG93IHVwIGFnYWluLg0KPiANCj4gVGhlIChsYXN0PykgLXJjOCB2ZXJzaW9uIHdh
cyByZWxlYXNlZCB5ZXN0ZXJkYXkuIFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvDQo+IGluY2x1
ZGUgYXQgbGVhc3QgKG9ubHkpIHRoZSByZXZlcnQgaW4gbWFpbmxpbmUgc28gdGhhdCA2LjIg
d2lsbCBiZQ0KPiByZWxlYXNlZCB3aXRoIGEgd29ya2luZyBzdG9yYWdlIGNvbmZpZ3VyYXRp
b24gdW5kZXIgWGVuPw0KDQpIbW0sIHRoaXMgd291bGQgbWFrZSBIeXBlci1WIFNFVi1TTlAg
Z3Vlc3RzIHNsb3cgYWdhaW4uDQoNCkknbSBub3QgY29tcGxldGVseSBhZ2FpbnN0IGl0LCBi
dXQgT1RPSCBJJ20gYSBsaXR0bGUgYml0IGJpYXNlZCBhcyB0aGUNCm1haW50YWluZXIgb2Yg
dGhlIFhlbiBjb2RlLiA6LSkNCg0KTWljaGFlbCwgd291bGQgeW91IHNlZSBtYWpvciBwcm9i
bGVtcyB3aXRoIGRvaW5nIHRoZSByZXZlcnQgYmVmb3JlIGhhdmluZw0KdGhlIGZpbmFsIHBh
dGNoZXMgZm9yIGZpeGluZyB5b3VyIGlzc3VlLCB0b28/DQoNCj4gT3RoZXJ3aXNlIG9uZSB3
b3VsZCBoYXZlIHRvIGNhcnJ5IGFyb3VuZCB0aGF0IHNpbmdsZSByZXZlcnQgbWFudWFsbHkg
dW50aWwNCj4gdGhpcyBwYXRjaCBzZXJpZXMgaGFzIGxhbmRlZCBpbiBtYWlubGluZSwgb3Ig
Y29udmluY2UgYWxsIHRoZQ0KPiBkaXN0cmlidXRpb25zIHRvIGRvIHNvIDotXA0KPiANCj4g
QW55d2F5LCB0aGFua3MgZm9yIGZpeGluZyB0aGlzIHByb2JsZW0sIEkgZGlkIG5vdCBleHBl
Y3QgdGhpcyB0byBiZSBzdWNoIGENCj4gY29tcGxpY2F0ZWQgaXNzdWUgd2hlbiBJIHJlcG9y
dGVkIHRoYXQgdGhpbmcgOi0pDQoNClllcywgSSBoYXZlIG9wZW5lZCBhIGNhbiBvZiB3b3Jt
cyB3aXRoIG15IE1UUlIvUEFUIGRpc2VudGFuZ2xpbmcuDQoNCg0KSnVlcmdlbg0K
--------------mPY7KgYP8W0xmk0oWL40WHYi
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

--------------mPY7KgYP8W0xmk0oWL40WHYi--

--------------d1gUdTw0OLkvmENL1ViLh1yA--

--------------ZpXCMa5vtEEn05cd52m0ectS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqZB0FAwAAAAAACgkQsN6d1ii/Ey/N
AQf+IJ4HaUBDT91Q5o0DXnpsa/A1qUj9iQGBaPhgpGU1EqgQuJ6WrQXwLptI5qh9V/HGO9dKEWOA
YtsMA6YVk5Qv8Rkumg4tCb7PYw74DqAu2LdEdi9PazkxvnZTLMCmKnkekK56c5gu/BGaDpXWJ+ks
XrPVkd9vopn18gwsXmUTxcaD3QMTzM92KBN48JjAG03/J5uW2+wzg2Yi4iKU8IhpG9dNBJvURmSJ
bXks1NpnjmAuqaevG8vbGoACZagoNW8WzxZt3vzf82+B6pplinWi/M+8vwQLyo0gJ+wihZXUCVqO
npS1bnedB0eqpf6Nn2cKxfb0bZAGuOIrLHd+06K9YQ==
=BA4R
-----END PGP SIGNATURE-----

--------------ZpXCMa5vtEEn05cd52m0ectS--
