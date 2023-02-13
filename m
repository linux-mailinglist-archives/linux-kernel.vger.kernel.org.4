Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F09693F68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBMISZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:18:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90549CA1F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:18:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BBF8376EC;
        Mon, 13 Feb 2023 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676276301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2OOk70gj51JdKCOUTv6xRulLiFPZbvw42JsAJ/KCk0=;
        b=BykbiMwgjH5Ns+dwUqZYygB/MzoGLyukxXdW5/xbivg9SlmphFebNboZbPAEekeRuqBCac
        SwuKrtayKeio8dQMXtCJqZCjDQB8sDEO0yKg2fjQLw0/fW2rR+bSyHi3v2nwx4nDEOGhnO
        9dK+rH2WzEJbCQmt4cikSydnCx53xNk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2C02138E6;
        Mon, 13 Feb 2023 08:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6V6pLUzy6WOZNQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 08:18:20 +0000
Message-ID: <51f4525e-7233-569f-f62d-07551c382deb@suse.com>
Date:   Mon, 13 Feb 2023 09:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next v3] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
References: <20221216162118.GB2633@templeofstupid.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221216162118.GB2633@templeofstupid.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------k9hLZD2BZbf0hFZ4lOz9NAKd"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------k9hLZD2BZbf0hFZ4lOz9NAKd
Content-Type: multipart/mixed; boundary="------------EWvDk0ef4AchGgsNDia3wk4B";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Krister Johansen <kjlx@templeofstupid.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori
 <aliguori@amazon.com>, David Reaver <me@davidreaver.com>,
 Brendan Gregg <brendan@intel.com>
Message-ID: <51f4525e-7233-569f-f62d-07551c382deb@suse.com>
Subject: Re: [PATCH linux-next v3] x86/xen/time: prefer tsc as clocksource
 when it is invariant
References: <20221216162118.GB2633@templeofstupid.com>
In-Reply-To: <20221216162118.GB2633@templeofstupid.com>

--------------EWvDk0ef4AchGgsNDia3wk4B
Content-Type: multipart/mixed; boundary="------------ySj6xqIXWWVvBswX3GYsWw0f"

--------------ySj6xqIXWWVvBswX3GYsWw0f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMTIuMjIgMTc6MjEsIEtyaXN0ZXIgSm9oYW5zZW4gd3JvdGU6DQo+IEt2bSBlbGVj
dHMgdG8gdXNlIHRzYyBpbnN0ZWFkIG9mIGt2bS1jbG9jayB3aGVuIGl0IGNhbiBkZXRlY3Qg
dGhhdCB0aGUNCj4gVFNDIGlzIGludmFyaWFudC4NCj4gDQo+IChBcyBvZiBjb21taXQgNzUz
OWIxNzRhZWY0ICgieDg2OiBrdm1ndWVzdDogdXNlIFRTQyBjbG9ja3NvdXJjZSBpZg0KPiBp
bnZhcmlhbnQgVFNDIGlzIGV4cG9zZWQiKSkuDQo+IA0KPiBOb3RhYmxlIGNsb3VkIHZlbmRv
cnNbMV0gYW5kIHBlcmZvcm1hbmNlIGVuZ2luZWVyc1syXSByZWNvbW1lbmQgdGhhdCBYZW4N
Cj4gdXNlcnMgcHJlZmVyZW50aWFsbHkgc2VsZWN0IHRzYyBvdmVyIHhlbi1jbG9ja3NvdXJj
ZSBkdWUgdGhlIHBlcmZvcm1hbmNlDQo+IHBlbmFsdHkgaW5jdXJyZWQgYnkgdGhlIGxhdHRl
ci4gIFRoZXNlIGFydGljbGVzIGFyZSBwZXJzdWFzaXZlIGFuZA0KPiB0YWlsb3JlZCB0byBz
cGVjaWZpYyB1c2UgY2FzZXMuICBJbiBvcmRlciB0byB1bmRlcnN0YW5kIHRoZSB0cmFkZW9m
ZnMNCj4gYXJvdW5kIHRoaXMgY2hvaWNlIG1vcmUgZnVsbHksIHRoaXMgYXV0aG9yIGhhZCB0
byByZWZlcmVuY2UgdGhlDQo+IGRvY3VtZW50ZWRbM10gY29tcGxleGl0aWVzIGFyb3VuZCB0
aGUgWGVuIGNvbmZpZ3VyYXRpb24sIGFzIHdlbGwgYXMgdGhlDQo+IGtlcm5lbCdzIGNsb2Nr
c291cmNlIHNlbGVjdGlvbiBhbGdvcml0aG0uICBNYW55IHVzZXJzIG1heSBub3QgYXR0ZW1w
dA0KPiB0aGlzIHRvIGNvcnJlY3RseSBjb25maWd1cmUgdGhlIHJpZ2h0IGNsb2NrIHNvdXJj
ZSBpbiB0aGVpciBndWVzdC4NCj4gDQo+IFRoZSBhcHByb2FjaCB0YWtlbiBpbiB0aGUga3Zt
LWNsb2NrIG1vZHVsZSBzcGFyZXMgdXNlcnMgdGhpcyBjb25mdXNpb24sDQo+IHdoZXJlIHBv
c3NpYmxlLg0KPiANCj4gQm90aCB0aGUgSW50ZWwgU0RNWzRdIGFuZCB0aGUgWGVuIHRzYyBk
b2N1bWVudGF0aW9uIGV4cGxhaW4gdGhhdCBtYXJraW5nDQo+IGEgdHNjIGFzIGludmFyaWFu
dCBtZWFucyB0aGF0IGl0IHNob3VsZCBiZSBjb25zaWRlcmVkIHN0YWJsZSBieSB0aGUgT1MN
Cj4gYW5kIGlzIGVsaWJpbGUgdG8gYmUgdXNlZCBhcyBhIHdhbGwgY2xvY2sgc291cmNlLg0K
PiANCj4gSW4gb3JkZXIgdG8gb2J0YWluIGJldHRlciBvdXQtb2YtdGhlLWJveCBwZXJmb3Jt
YW5jZSwgYW5kIHJlZHVjZSB0aGUNCj4gbmVlZCBmb3IgdXNlciB0dW5pbmcsIGZvbGxvdyBr
dm0ncyBhcHByb2FjaCBhbmQgZGVjcmVhc2UgdGhlIHhlbiBjbG9jaw0KPiByYXRpbmcgc28g
dGhhdCB0c2MgaXMgcHJlZmVyYWJsZSwgaWYgaXQgaXMgaW52YXJpYW50LCBzdGFibGUsIGFu
ZCB0aGUNCj4gdHNjIHdpbGwgbmV2ZXIgYmUgZW11bGF0ZWQuDQo+IA0KPiBbMV0gaHR0cHM6
Ly9hd3MuYW1hem9uLmNvbS9wcmVtaXVtc3VwcG9ydC9rbm93bGVkZ2UtY2VudGVyL21hbmFn
ZS1lYzItbGludXgtY2xvY2stc291cmNlLw0KPiBbMl0gaHR0cHM6Ly93d3cuYnJlbmRhbmdy
ZWdnLmNvbS9ibG9nLzIwMjEtMDktMjYvdGhlLXNwZWVkLW9mLXRpbWUuaHRtbA0KPiBbM10g
aHR0cHM6Ly94ZW5iaXRzLnhlbi5vcmcvZG9jcy91bnN0YWJsZS9tYW4veGVuLXRzY21vZGUu
Ny5odG1sDQo+IFs0XSBJbnRlbCA2NCBhbmQgSUEtMzIgQXJjaGl0ZWN0dXJlcyBTb2Z3YXJl
IERldmVsb3BlcidzIE1hbnVhbCBWb2x1bWUNCj4gICAgICAzYjogU3lzdGVtIFByb2dyYW1t
aW5nIEd1aWRlLCBQYXJ0IDIsIFNlY3Rpb24gMTcuMTcuMSwgSW52YXJpYW50IFRTQw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogS3Jpc3RlciBKb2hhbnNlbiA8a2pseEB0ZW1wbGVvZnN0dXBp
ZC5jb20+DQo+IENvZGUtcmV2aWV3ZWQtYnk6IERhdmlkIFJlYXZlciA8bWVAZGF2aWRyZWF2
ZXIuY29tPg0KDQpQdXNoZWQgdG86IHhlbi90aXAuZ2l0IGZvci1saW51cy02LjMNCg0KDQpK
dWVyZ2VuDQoNCg==
--------------ySj6xqIXWWVvBswX3GYsWw0f
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

--------------ySj6xqIXWWVvBswX3GYsWw0f--

--------------EWvDk0ef4AchGgsNDia3wk4B--

--------------k9hLZD2BZbf0hFZ4lOz9NAKd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp8kwFAwAAAAAACgkQsN6d1ii/Ey/P
Ugf/cHWNkviRNhBfPNMYGtQYKH71Xmu4xiw5D+mbOmNBgEA8v3N01KpdzvjXCMBWSzZ/wEkRWdTv
ncigdmPwxquNMMlQEVugAQxR9cDOlvDH42ORewkYnK6vArPzCKXNa4sbqGo77nxFO7DHmeSL/a6o
kDyfvqK3Zd/a8SQIn7GTW1p7gc37tJKdBVulKLiJ+MRLSgo830NKZmUejJY5q77+MHOQvSirvtJk
GZAA7R/YIW8+oDSts5TKxBskz1xDfD/CInMavCCqfeNlIEgadya5RDCp2MvV7JD1CYTOj8/953NE
WL+IQJMRhoViC5pqqDGYkwJp6xRsPC932aVMdQjDCw==
=Weww
-----END PGP SIGNATURE-----

--------------k9hLZD2BZbf0hFZ4lOz9NAKd--
