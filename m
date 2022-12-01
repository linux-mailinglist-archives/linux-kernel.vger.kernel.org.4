Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2663F552
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiLAQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiLAQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:33:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B7A95B8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:33:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7918321B50;
        Thu,  1 Dec 2022 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669912409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQBCgRtNwjpMVX06HttfDC1rrQdpVuhxKCeeWmLG3BM=;
        b=jVHOMh4nZ1CSjAtMP9/EarGO4bviHQ5OdPoxy8FdaYsZfin8+1YwcxUgn9DR+IfkfC2rau
        dw8G1guShDzc37XFubFUTjFi4HCwZ+KvhSsB+Lb4lFVwyaiw8tPg3vH4Sd43YiTZQqlFKh
        ZRxzmGIQhlCPZFsFOWzF6bZ817tdNDc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2DF8C1320E;
        Thu,  1 Dec 2022 16:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xWBnCVnXiGONdAAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 01 Dec 2022 16:33:29 +0000
Message-ID: <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
Date:   Thu, 1 Dec 2022 17:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SHy2yd5K00j8as9NgyPSOPSV"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SHy2yd5K00j8as9NgyPSOPSV
Content-Type: multipart/mixed; boundary="------------pUsBNUjjT3z3WMLFulHrpovs";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
In-Reply-To: <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>

--------------pUsBNUjjT3z3WMLFulHrpovs
Content-Type: multipart/mixed; boundary="------------PNcRKuxBkzdEC4HvHP3ep8H7"

--------------PNcRKuxBkzdEC4HvHP3ep8H7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMTIuMjIgMTc6MjYsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gV2Vk
LCBOb3YgMDIsIDIwMjIgYXQgMDg6NDc6MTBBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IFRvZGF5IFBBVCBpcyB1c2FibGUgb25seSB3aXRoIE1UUlIgYmVpbmcgYWN0aXZl
LCB3aXRoIHNvbWUgbmFzdHkgdHdlYWtzDQo+PiB0byBtYWtlIFBBVCB1c2FibGUgd2hlbiBy
dW5uaW5nIGFzIFhlbiBQViBndWVzdCwgd2hpY2ggZG9lc24ndCBzdXBwb3J0DQo+PiBNVFJS
Lg0KPj4NCj4+IFRoZSByZWFzb24gZm9yIHRoaXMgY291cGxpbmcgaXMsIHRoYXQgYm90aCwg
UEFUIE1TUiBjaGFuZ2VzIGFuZCBNVFJSDQo+PiBjaGFuZ2VzLCByZXF1aXJlIGEgc2ltaWxh
ciBzZXF1ZW5jZSBhbmQgc28gZnVsbCBQQVQgc3VwcG9ydCB3YXMgYWRkZWQNCj4+IHVzaW5n
IHRoZSBhbHJlYWR5IGF2YWlsYWJsZSBNVFJSIGhhbmRsaW5nLg0KPj4NCj4+IFhlbiBQViBQ
QVQgaGFuZGxpbmcgY2FuIHdvcmsgd2l0aG91dCBNVFJSLCBhcyBpdCBqdXN0IG5lZWRzIHRv
IGNvbnN1bWUNCj4+IHRoZSBQQVQgTVNSIHNldHRpbmcgZG9uZSBieSB0aGUgaHlwZXJ2aXNv
ciB3aXRob3V0IHRoZSBhYmlsaXR5IGFuZCBuZWVkDQo+PiB0byBjaGFuZ2UgaXQuIFRoaXMg
aW4gdHVybiBoYXMgcmVzdWx0ZWQgaW4gYSBjb252b2x1dGVkIGluaXRpYWxpemF0aW9uDQo+
PiBzZXF1ZW5jZSBhbmQgd3JvbmcgZGVjaXNpb25zIHJlZ2FyZGluZyBjYWNoZSBtb2RlIGF2
YWlsYWJpbGl0eSBkdWUgdG8NCj4+IG1pc2d1aWRpbmcgUEFUIGF2YWlsYWJpbGl0eSBmbGFn
cy4NCj4+DQo+PiBGaXggYWxsIG9mIHRoYXQgYnkgYWxsb3dpbmcgdG8gdXNlIFBBVCB3aXRo
b3V0IE1UUlIgYW5kIGJ5IHJld29ya2luZw0KPj4gdGhlIGN1cnJlbnQgUEFUIGluaXRpYWxp
emF0aW9uIHNlcXVlbmNlIHRvIG1hdGNoIGJldHRlciB3aXRoIHRoZSBuZXdseQ0KPj4gaW50
cm9kdWNlZCBnZW5lcmljIGNhY2hlIGluaXRpYWxpemF0aW9uLg0KPj4NCj4+IFRoaXMgcmVt
b3ZlcyB0aGUgbmVlZCBvZiB0aGUgcmVjZW50bHkgYWRkZWQgcGF0X2ZvcmNlX2Rpc2FibGVk
IGZsYWcsIHNvDQo+PiByZW1vdmUgdGhlIHJlbW5hbnRzIG9mIHRoZSBwYXRjaCBhZGRpbmcg
aXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KPiANCj4gVGhpcyBwYXRjaCBicmVha3MgYm9vdCBmb3IgVERYIGd1ZXN0Lg0KPiAN
Cj4gS2VybmVsIG5vdyB0cmllcyB0byBzZXQgQ1IwLkNEIHdoaWNoIGlzIGZvcmJpZGRlbiBp
biBURFggZ3Vlc3RbMV0gYW5kDQo+IGNhdXNlcyAjVkU6DQo+IA0KPiAJdGR4OiBVbmV4cGVj
dGVkICNWRTogMjgNCj4gCVZFIGZhdWx0OiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkN
Cj4gCUNQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA2LjEuMC1yYzEt
MDAwMTUtZ2FkZmU3NTEyZTFkMCAjMjY0Ng0KPiAJSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMC4wLjAgMDIvMDYvMjAxNQ0KPiAJ
UklQOiAwMDEwOm5hdGl2ZV93cml0ZV9jcjAgKGFyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9u
LmM6NDI3KQ0KPiAJIENhbGwgVHJhY2U6DQo+IAkgIDxUQVNLPg0KPiAJID8gY2FjaGVfZGlz
YWJsZSAoYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oOjE3MyBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NhY2hlaW5mby5jOjEwODUpDQo+IAkgPyBjYWNoZV9jcHVfaW5pdCAoYXJj
aC94ODYva2VybmVsL2NwdS9jYWNoZWluZm8uYzoxMTMyIChkaXNjcmltaW5hdG9yIDMpKQ0K
PiAJID8gc2V0dXBfYXJjaCAoYXJjaC94ODYva2VybmVsL3NldHVwLmM6MTA3OSkNCj4gCSA/
IHN0YXJ0X2tlcm5lbCAoaW5pdC9tYWluLmM6Mjc5IChkaXNjcmltaW5hdG9yIDMpIGluaXQv
bWFpbi5jOjQ3NyAoZGlzY3JpbWluYXRvciAzKSBpbml0L21haW4uYzo5NjAgKGRpc2NyaW1p
bmF0b3IgMykpDQo+IAkgPyBsb2FkX3Vjb2RlX2JzcCAoYXJjaC94ODYva2VybmVsL2NwdS9t
aWNyb2NvZGUvY29yZS5jOjE1NSkNCj4gCSA/IHNlY29uZGFyeV9zdGFydHVwXzY0X25vX3Zl
cmlmeSAoYXJjaC94ODYva2VybmVsL2hlYWRfNjQuUzozNTgpDQo+IAkgIDwvVEFTSz4NCj4g
DQo+IEFueSBzdWdnZXN0aW9uIGhvdyB0byBmaXggaXQ/DQo+IA0KPiBbMV0gU2VjdGlvbiAx
MC42LjEuICJDUjAiLCBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVu
dC83MzM1NjgNCg0KV2hhdCB3YXMgdGhlIHNvbHV0aW9uIGJlZm9yZT8NCg0KSSBndWVzcyBN
VFJSIHdhcyBkaXNhYmxlZCwgc28gdGhlcmUgd2FzIG5vIFBBVCwgdG9vPw0KDQpJZiB0aGlz
IGlzIHRoZSBjYXNlLCB5b3UgY2FuIGdvIHRoZSBzYW1lIHJvdXRlIGFzIFhlbiBQViBndWVz
dHMgZG8uDQoNCg0KSnVlcmdlbg0K
--------------PNcRKuxBkzdEC4HvHP3ep8H7
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

--------------PNcRKuxBkzdEC4HvHP3ep8H7--

--------------pUsBNUjjT3z3WMLFulHrpovs--

--------------SHy2yd5K00j8as9NgyPSOPSV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOI11gFAwAAAAAACgkQsN6d1ii/Ey9L
yggAnSlGoWtvwDBsTJtTbNRBn+/WwC8QpUeKd/i5mHZcvY7aTL9bemCOj2nuMHKV7KX56aTryVM6
s2r8u+sKgmPHMLaIdxE4YXQnNFgkeAscZuuXZz26t8XRAme39MYZY0dK1G4IuvvZP8wx4B1sGzoE
kyISe+++tl4LhxyjhT9oivEzfB5opLANbm0JyKer9pT9iuB7EuX72fQGsspEddzquBYCMt2Eg0IT
ClHg3E966oJn5bS7CurP5dwvyly9WyzL4r2DDdyGNd+p7qt6WlSOGMeb8VpLeZ3IVGOpB20XQFb/
GjX9VDagM7CZhD5sLhnQ5UpE35S46nwdQJJyg0+M+Q==
=jOk1
-----END PGP SIGNATURE-----

--------------SHy2yd5K00j8as9NgyPSOPSV--
