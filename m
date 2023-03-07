Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3836AE1A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCGOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25487D0A2;
        Tue,  7 Mar 2023 06:06:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4718D1FDD1;
        Tue,  7 Mar 2023 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678197971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kf+wSYlu37HIvliDXrRtx+MDVuxmYYF8KfwKZAyv1mg=;
        b=ro/LC/JfdgXCvy7zbRwZyB8Eatvxc4d8LEqCbPBN0aWAe6nvL0xV/ubL0SqhJsrAb2xbm/
        EH+ONlMe9Pv1XHpetbi633kIwdCVsB8EeYQxbRQGGDWprfFT3jc4kanEOVdI/TB4v+w6jo
        E/HBG+C3ffPk3kVxwN03MWxYDI3U3qk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D32A113440;
        Tue,  7 Mar 2023 14:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nyKuMdJEB2RdbgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Mar 2023 14:06:10 +0000
Message-ID: <33118f0b-6752-7e4c-49a3-a8c9345f02a1@suse.com>
Date:   Tue, 7 Mar 2023 15:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 20/20] irqdomain: Switch to per-domain locking
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel <xen-devel@lists.xenproject.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
 <20230213104302.17307-21-johan+linaro@kernel.org>
 <f149fe1eb3836c14655e3e7eaa4032298ae68545.camel@infradead.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <f149fe1eb3836c14655e3e7eaa4032298ae68545.camel@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w9ucrDayWOH8tsGwTzYVKhmL"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w9ucrDayWOH8tsGwTzYVKhmL
Content-Type: multipart/mixed; boundary="------------xRzMZYK008SexuahzDyWucOO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Johan Hovold <johan+linaro@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 xen-devel <xen-devel@lists.xenproject.org>
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Message-ID: <33118f0b-6752-7e4c-49a3-a8c9345f02a1@suse.com>
Subject: Re: [PATCH v6 20/20] irqdomain: Switch to per-domain locking
References: <20230213104302.17307-1-johan+linaro@kernel.org>
 <20230213104302.17307-21-johan+linaro@kernel.org>
 <f149fe1eb3836c14655e3e7eaa4032298ae68545.camel@infradead.org>
In-Reply-To: <f149fe1eb3836c14655e3e7eaa4032298ae68545.camel@infradead.org>

--------------xRzMZYK008SexuahzDyWucOO
Content-Type: multipart/mixed; boundary="------------1brh0jylh4ikgokNQLJKaWUi"

--------------1brh0jylh4ikgokNQLJKaWUi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDMuMjMgMTQ6NTEsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4gT24gTW9uLCAy
MDIzLTAyLTEzIGF0IDExOjQzICswMTAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+PiBUaGUg
SVJRIGRvbWFpbiBzdHJ1Y3R1cmVzIGFyZSBjdXJyZW50bHkgcHJvdGVjdGVkIGJ5IHRoZSBn
bG9iYWwNCj4+IGlycV9kb21haW5fbXV0ZXguIFN3aXRjaCB0byB1c2luZyBtb3JlIGZpbmUt
Z3JhaW5lZCBwZXItZG9tYWluIGxvY2tpbmcsDQo+PiB3aGljaCBjYW4gc3BlZWQgdXAgcGFy
YWxsZWwgcHJvYmluZyBieSByZWR1Y2luZyBsb2NrIGNvbnRlbnRpb24uDQo+Pg0KPj4gT24g
YSByZWNlbnQgYXJtNjQgbGFwdG9wLCB0aGUgdG90YWwgdGltZSBzcGVudCB3YWl0aW5nIGZv
ciB0aGUgbG9ja3MNCj4+IGR1cmluZyBib290IGRyb3BzIGZyb20gMTYwIHRvIDQwIG1zIG9u
IGF2ZXJhZ2UsIHdoaWxlIHRoZSBtYXhpbXVtDQo+PiBhZ2dyZWdhdGUgd2FpdCB0aW1lIGRy
b3BzIGZyb20gNTUwIHRvIDkwIG1zIG92ZXIgdGVuIHJ1bnMgZm9yIGV4YW1wbGUuDQo+Pg0K
Pj4gTm90ZSB0aGF0IHRoZSBkb21haW4gbG9jayBvZiB0aGUgcm9vdCBkb21haW4gKGlubmVy
bW9zdCBkb21haW4pIG11c3QgYmUNCj4+IHVzZWQgZm9yIGhpZXJhcmNoaWNhbCBkb21haW5z
LiBGb3Igbm9uLWhpZXJhcmNoaWNhbCBkb21haW5zIChhcyBmb3Igcm9vdA0KPj4gZG9tYWlu
cyksIHRoZSBuZXcgcm9vdCBwb2ludGVyIGlzIHNldCB0byB0aGUgZG9tYWluIGl0c2VsZiBz
byB0aGF0DQo+PiAmZG9tYWluLT5yb290LT5tdXRleCBhbHdheXMgcG9pbnRzIHRvIHRoZSBy
aWdodCBsb2NrLg0KPj4NCj4+IEFsc28gbm90ZSB0aGF0IGhpZXJhcmNoaWNhbCBkb21haW5z
IHNob3VsZCBiZSBjb25zdHJ1Y3RlZCB1c2luZw0KPj4gaXJxX2RvbWFpbl9jcmVhdGVfaGll
cmFyY2h5KCkgKG9yIGlycV9kb21haW5fYWRkX2hpZXJhcmNoeSgpKSB0byBhdm9pZA0KPj4g
aGF2aW5nIHJhY2luZyBhbGxvY2F0aW9ucyBhY2Nlc3MgYSBub3QgZnVsbHkgaW5pdGlhbGlz
ZWQgZG9tYWluLiBBcyBhDQo+PiBzYWZlZ3VhcmQsIHRoZSBsb2NrZGVwIGFzc2VydGlvbiBp
biBpcnFfZG9tYWluX3NldF9tYXBwaW5nKCkgd2lsbCBjYXRjaA0KPj4gYW55IG9mZmVuZGVy
cyB0aGF0IGFsc28gZmFpbCB0byBzZXQgdGhlIHJvb3QgZG9tYWluIHBvaW50ZXIuDQo+Pg0K
Pj4gVGVzdGVkLWJ5OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQo+PiBU
ZXN0ZWQtYnk6IE1hcmstUEsgVHNhaSA8bWFyay1way50c2FpQG1lZGlhdGVrLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtlcm5lbC5vcmc+
DQo+IA0KPiBCcm9rZSBYZW4uDQoNCkZpeGVkIHdpdGggY29tbWl0IGFkMzJhYjk2MDRmMi4N
Cg0KDQpKdWVyZ2VuDQo=
--------------1brh0jylh4ikgokNQLJKaWUi
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

--------------1brh0jylh4ikgokNQLJKaWUi--

--------------xRzMZYK008SexuahzDyWucOO--

--------------w9ucrDayWOH8tsGwTzYVKhmL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQHRNIFAwAAAAAACgkQsN6d1ii/Ey9I
lwf9ES5dmEFfcLOojH7ZzPGUjs5d7HGdnwvcVTeRMrN7SLOTpfm2+Eudbjq9Q1BXD7WvmqD918sH
FEs/BqLb0MSbYYSE1Xjt2ZJ/iO+lH0RwFSTffO4fin2sxeMwpOuBffi9B6MQHmPfAHpawlldwygi
HWms/vUKqJUb5+tdwFHK0Z8nFxkuKVsux0ybfMJ0c5Ao9bVnxHimU9F8t0SygKY31qMMTb89LtRv
VWpHS/aPdmlmWyS/7K6hEdN043pL4uGHQ0HsWlz0a1wj+XocWQ5UOC6tYp6cmK0mLnAE0bs8QfAC
Z9zI+/jn7/foax/h021MmFlMy1Gg2mB62IG3ktaJGA==
=PkV3
-----END PGP SIGNATURE-----

--------------w9ucrDayWOH8tsGwTzYVKhmL--
