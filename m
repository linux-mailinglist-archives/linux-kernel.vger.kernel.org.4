Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36CA6178E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKCIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:40:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6FBF68;
        Thu,  3 Nov 2022 01:40:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76966219C3;
        Thu,  3 Nov 2022 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667464833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bQf+zayucqbyO7dwj1iRvWukyivM0DZIR4s33rXgcU=;
        b=owL11lY3nPitW1qUg/OxfGZPyhmhbUQj9bnn7TuYgUNMsvq46UBGeTcKASwrRfEzku8xRk
        YG0BtLS0ovGKnkk6OiRkTZSBOqyFog+5OEHMiDfPImtwiWm4oWnGbsm2UUnFa6RZomGOx9
        ffsZN9jEsAKJX5Olt7Otzti9qpovvKs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22D2013480;
        Thu,  3 Nov 2022 08:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eoSlBoF+Y2OnQAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 08:40:33 +0000
Message-ID: <a9c1ba97-340e-ed7b-ccdc-44a1aaff6d6d@suse.com>
Date:   Thu, 3 Nov 2022 09:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 00/16] x86: make PAT and MTRR independent from each
 other
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221102074713.21493-1-jgross@suse.com>
 <Y2KxSGWllUPTikJv@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y2KxSGWllUPTikJv@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N4Cl7R7bF3xqhiqQGDkEbU0R"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N4Cl7R7bF3xqhiqQGDkEbU0R
Content-Type: multipart/mixed; boundary="------------CFTQuLfB0XzzrRuxaVt4YV0p";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <a9c1ba97-340e-ed7b-ccdc-44a1aaff6d6d@suse.com>
Subject: Re: [PATCH v5 00/16] x86: make PAT and MTRR independent from each
 other
References: <20221102074713.21493-1-jgross@suse.com>
 <Y2KxSGWllUPTikJv@zn.tnic>
In-Reply-To: <Y2KxSGWllUPTikJv@zn.tnic>

--------------CFTQuLfB0XzzrRuxaVt4YV0p
Content-Type: multipart/mixed; boundary="------------azArCveb1AUWWtevdrZ3gd44"

--------------azArCveb1AUWWtevdrZ3gd44
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTEuMjIgMTk6MDQsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBO
b3YgMDIsIDIwMjIgYXQgMDg6NDY6NTdBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRvZGF5IFBBVCBjYW4ndCBiZSB1c2VkIHdpdGhvdXQgTVRSUiBiZWluZyBhdmFpbGFi
bGUsIHVubGVzcyBNVFJSIGlzIGF0DQo+PiBsZWFzdCBjb25maWd1cmVkIHZpYSBDT05GSUdf
TVRSUiBhbmQgdGhlIHN5c3RlbSBpcyBydW5uaW5nIGFzIFhlbiBQVg0KPj4gZ3Vlc3QuIElu
IHRoaXMgY2FzZSBQQVQgaXMgYXV0b21hdGljYWxseSBhdmFpbGFibGUgdmlhIHRoZSBoeXBl
cnZpc29yLA0KPj4gYnV0IHRoZSBQQVQgTVNSIGNhbid0IGJlIG1vZGlmaWVkIGJ5IHRoZSBr
ZXJuZWwgYW5kIE1UUlIgaXMgZGlzYWJsZWQuDQo+Pg0KPj4gVGhlIHNhbWUgYXBwbGllcyB0
byBhIGtlcm5lbCBidWlsdCB3aXRoIG5vIE1UUlIgc3VwcG9ydDogaXQgd29uJ3QNCj4+IGFs
bG93IHRvIHVzZSB0aGUgUEFUIE1TUiwgZXZlbiBpZiB0aGVyZSBpcyBubyB0ZWNobmljYWwg
cmVhc29uIGZvcg0KPj4gdGhhdCwgb3RoZXIgdGhhbiBzZXR0aW5nIHVwIFBBVCBvbiBhbGwg
Q1BVcyB0aGUgc2FtZSB3YXkgKHdoaWNoIGlzIGENCj4+IHJlcXVpcmVtZW50IG9mIHRoZSBw
cm9jZXNzb3IncyBjYWNoZSBtYW5hZ2VtZW50KSBpcyByZWx5aW5nIG9uIHNvbWUNCj4+IE1U
UlIgc3BlY2lmaWMgY29kZS4NCj4+DQo+PiBGaXggYWxsIG9mIHRoYXQgYnk6DQo+IA0KPiBP
bmUgb2YgdGhlIEFNRCB0ZXN0IGJveGVzIGhlcmUgc2F5cyB3aXRoIHRoaXM6DQo+IA0KPiAu
Li4NCj4gWyAgICAwLjg2MzQ2Nl0gUENJOiBub3QgdXNpbmcgTU1DT05GSUcNCj4gWyAgICAw
Ljg2MzQ3NV0gUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBmb3IgYmFzZSBhY2Nl
c3MNCj4gWyAgICAwLjg2MzQ3OF0gUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBm
b3IgZXh0ZW5kZWQgYWNjZXNzDQo+IFsgICAgMC44NjY3MzNdIG10cnI6IHlvdXIgQ1BVcyBo
YWQgaW5jb25zaXN0ZW50IE1UUlJkZWZUeXBlIHNldHRpbmdzDQo+IFsgICAgMC44NjY3Mzdd
IG10cnI6IHByb2JhYmx5IHlvdXIgQklPUyBkb2VzIG5vdCBzZXR1cCBhbGwgQ1BVcy4NCj4g
WyAgICAwLjg2Njc0MF0gbXRycjogY29ycmVjdGVkIGNvbmZpZ3VyYXRpb24uDQo+IFsgICAg
MC44NjkzNTBdIGtwcm9iZXM6IGtwcm9iZSBqdW1wLW9wdGltaXphdGlvbiBpcyBlbmFibGVk
LiBBbGwga3Byb2JlcyBhcmUgb3B0aW1pemVkIGlmIHBvc3NpYmxlLg0KPiAuLi4NCj4gDQo+
IFByZXZpb3VzIGxvZ3MgZG9uJ3QgaGF2ZSBpdDoNCj4gDQo+IFBDSTogbm90IHVzaW5nIE1N
Q09ORklHDQo+IFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEgZm9yIGJhc2UgYWNj
ZXNzDQo+IFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEgZm9yIGV4dGVuZGVkIGFj
Y2Vzcw0KPiBrcHJvYmVzOiBrcHJvYmUganVtcC1vcHRpbWl6YXRpb24gaXMgZW5hYmxlZC4g
QWxsIGtwcm9iZXMgYXJlIG9wdGltaXplZCBpZiBwb3NzaWJsZS4NCj4gDQoNCldlaXJkLiBJ
IGNhbid0IHNwb3QgYW55IG1vZGlmaWNhdGlvbiB3aGljaCBjb3VsZCBoYXZlIGNhdXNlZCB0
aGF0Lg0KDQpXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBpZGVudGlmeSB0aGUgcGF0Y2ggY2F1
c2luZyB0aGF0Pw0KDQoNCkp1ZXJnZW4NCg==
--------------azArCveb1AUWWtevdrZ3gd44
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

--------------azArCveb1AUWWtevdrZ3gd44--

--------------CFTQuLfB0XzzrRuxaVt4YV0p--

--------------N4Cl7R7bF3xqhiqQGDkEbU0R
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNjfoAFAwAAAAAACgkQsN6d1ii/Ey9Q
pgf9FMDqYVKu7+g0fBT6oUsL+nUDWwh5ZHjI9xtyxSVYej19jKTj8M4hHBcSFtl6lfLH8Dl2puTo
PbxFLRxd7PPAs4VUkgv/gOtfdlMqpJMXqgLl4ODL04OQxOPFVok2KrmN6V01HZ0zNthenw5QWpL0
/vUmTjPQb+dUWGq0VdiLBVFHGV+9nju/N3ObgO2UtSZhwbDeBJ7Jl5aqSbqi12VEFK31NcdOdAg9
TL1C20HQ5uUeiE67S7PexgAukYAWiAVglN+r+AX6600NfywbuXiEVPu7Nw/Y58t/Ec/BRP79Mmir
bmhkFD479UVDA/G62gwFKOxZSdZy17RISw4xJquxDA==
=YsxI
-----END PGP SIGNATURE-----

--------------N4Cl7R7bF3xqhiqQGDkEbU0R--
