Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD71694B63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBMPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBMPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:38:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBA1A64E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:38:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC5EB1F8A3;
        Mon, 13 Feb 2023 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676302715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aP8MoTcXldOtkjJVyZxNGZTI+G/6BSZkETJURU03Np0=;
        b=D02GCZ6dssuIno7oX7J/RYqYIQ3FvHLOgg7T47CjfcJrxgXyZKaPD0OpwebtQqh2onVR48
        3yooK6JOnMQLN4mlTCFk1M8MDuFeXtczPH7BbW+YeW9GPcZiu2CuP/5T6Fp0Pxps9tNLGa
        FeV4HWnHrvDFo1+2oofi56Pi/HIWkhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 954551391B;
        Mon, 13 Feb 2023 15:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0fmnIntZ6mM9KAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 15:38:35 +0000
Message-ID: <d9fd5c97-7ef1-b7b1-30a2-0c617841fdf2@suse.com>
Date:   Mon, 13 Feb 2023 16:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <23b851db-a2a6-a854-94fc-a747f360d509@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <23b851db-a2a6-a854-94fc-a747f360d509@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pDBwy2UnXDgHMaHvz58kg6ic"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pDBwy2UnXDgHMaHvz58kg6ic
Content-Type: multipart/mixed; boundary="------------3UhyzQdidhO7UIiT2jQ0RV8Z";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>
Message-ID: <d9fd5c97-7ef1-b7b1-30a2-0c617841fdf2@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <23b851db-a2a6-a854-94fc-a747f360d509@intel.com>
In-Reply-To: <23b851db-a2a6-a854-94fc-a747f360d509@intel.com>

--------------3UhyzQdidhO7UIiT2jQ0RV8Z
Content-Type: multipart/mixed; boundary="------------14ky1hx6JueEsowu30uK7x10"

--------------14ky1hx6JueEsowu30uK7x10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTY6MjcsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiAyLzEzLzIzIDA3
OjExLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBNb24sIEZlYiAxMywgMjAyMyBh
dCAwNDowMzowN1BNICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4+IFdvdWxk
bid0ICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpIGJlIGVu
b3VnaD8NCj4+Pj4NCj4+Pj4gSSdtIG5vdCBzdXJlIHdlIHdvbid0IG5lZWQgdGhhdCBmb3Ig
VERYIGd1ZXN0cywgdG9vLg0KPj4+IFNlZSwgdGhhdCdzIHRoZSBwcm9ibGVtLiBJIHdhbm5h
IGhhdmUgaXQgc2ltcGxlIHRvby4gTGVtbWUgY2hlY2sgd2l0aA0KPj4+IGRoYW5zZW4uDQo+
PiBIZSBzYXlzIE1UUlJzIGFyZSBlbmFibGVkIGluIFREWCBndWVzdHM6ICJYODZfRkVBVFVS
RV9NVFJSIGlzIGZpeGVkIHRvDQo+PiAxIGluIFREWCBndWVzdHMuIg0KPj4NCj4+IFNvIHdl
IHdpbGwgaGF2ZSB0byBkbyB0aGUgbW9yZSBmaW5lci1ncmFpbmVkIGNoZWNrIEkgZ3Vlc3Mu
DQo+IA0KPiBZZXMsIFREWCBndWVzdHMgc2VlIE1UUlJzIGFzIGJlaW5nIHN1cHBvcnRlZC4g
IEJ1dCwgdGhlIFREWCBtb2R1bGUgYWxzbw0KPiBhcHBlYXJzIHRvIGluamVjdCBhICNWRSBm
b3IgYWxsIFJETVNSIG9yIFdSTVNSJ3MgdG8gdGhlIE1UUlJzLiAgVGhhdA0KPiBtYWtlcyB0
aGVtIGVmZmVjdGl2ZWx5IHVzZWxlc3MuDQo+IA0KPiBJIGFjdHVhbGx5IGRvbid0IGtub3cg
d2hhdCB0aGUgaGVjayBURFggZ3Vlc3RzIGFyZSBzdXBwb3NlZCB0byBkbyBpZg0KPiB0aGV5
IGZlZWwgbGlrZSBtdWNraW5nIHdpdGggdGhlIE1TUnMuICBUaGUgYXJjaGl0ZWN0dXJlIChD
UFVJRCkgaXMNCj4gZXNzZW50aWFsbHkgdGVsbGluZyB0aGVtOiAiU3VyZSwgZ28gYWhlYWQg
TVRSUnMgYXJlIGZpaWlpaWlpbmUiLiAgQnV0DQo+IHRoZSBURFggbW9kdWxlIGlzIHNpdHRp
bmcgdGhlcmUgdGhyb3dpbmcgZXhjZXB0aW9ucyAoI1ZFKSBpZiB0aGUgZ3Vlc3QNCj4gdHJp
ZXMgdG8gdG91Y2ggTVRSUnMuDQo+IA0KPiBJdCBzb3VuZHMgbGlrZSB0aGVyZSBhcmUgc29t
ZSBndWVzdDwtPmhvc3QgQUJJcyBvbiBYZW4gdG8gaGVscCB0aGUNCj4gZ3Vlc3RzIGRvIHRo
aXMuICBCdXQgSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhlIFREWCAiR0hDSSIgYWJvdXQg
aXQuDQoNClRoaXMgaXMgaW4gbGluZSBvZiB0aGUgUEFUIGluaXQgc2VxdWVuY2Ugb2YgVERY
IGd1ZXN0cy4gUEFUIGlzIHNhaWQgdG8NCmJlIHN1cHBvcnRlZCwgYnV0IGEgVERYIGd1ZXN0
IGNhbid0IHVzZSB0aGUgc2VxdWVuY2UgYXMgd3JpdHRlbiBpbiB0aGUNClNETSBmb3Igc2V0
dGluZyB0aGUgUEFUIE1TUiAoZGlzYWJsZSBjYWNoZXMsIGV0Yy4pLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------14ky1hx6JueEsowu30uK7x10
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

--------------14ky1hx6JueEsowu30uK7x10--

--------------3UhyzQdidhO7UIiT2jQ0RV8Z--

--------------pDBwy2UnXDgHMaHvz58kg6ic
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqWXsFAwAAAAAACgkQsN6d1ii/Ey/s
KAf+NhbK3eBxuspF38rQM8BxGIEf7S54Vc0ja88WG+6FvQmX5d/vmGTGRg4R52et/Plbjmsa2ju1
UorBkQrBah+A/FdWIepOp4eFWoWJDlRAmGTE/NVtwm8R2FGTRgwA0P7D/9iQppTBZS9+x2X3rWkS
8sfktSFbMY49Acjrt8emApDpJGxU6ypwW3uZGvZ6bniNbysEYkVAevbQeanQi+wkBOyDi0likkTi
mFUVgeMxAj4Qj5Ash8KncQVTPX6gV4bkO1uUy5+TlylsO6+UQnJJ2N51mepzrjL6mH0ov2/d9HSr
tsc++4LjR7tw1+CusGLgSyD5q524AA/jDVIAw1cVeQ==
=H5Bu
-----END PGP SIGNATURE-----

--------------pDBwy2UnXDgHMaHvz58kg6ic--
