Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C86E944A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjDTMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjDTMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:30:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859E6A42
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:30:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1DA71FDD2;
        Thu, 20 Apr 2023 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681993810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wEiHWvQBONs0OFlrZm+sR+VakDQSgNxKfJBu4QYwS8=;
        b=PD589jXXsSLxCpfFkv/Rq6/WriocsRskn6X8yb2OrHTB8U7/jSLYfWYjcPAf0aoIPYhqYa
        T+XUzOXI8ANgSlg8bE1mLFGIbiLSZg8hxfzsk8YIw1OD3Lit24803ZqbiKVlCuWYj/UoRF
        2UNVV9v7737/hooNbl+7ByY/JcA6zp0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7127E1333C;
        Thu, 20 Apr 2023 12:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nwOxGVIwQWQQegAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Apr 2023 12:30:10 +0000
Message-ID: <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
Date:   Thu, 20 Apr 2023 14:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
In-Reply-To: <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------73kxAlDq7xXltR3WUj7YK0vc"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------73kxAlDq7xXltR3WUj7YK0vc
Content-Type: multipart/mixed; boundary="------------1F0VanY0cwyCce8CZQdVoRjH";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
In-Reply-To: <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>

--------------1F0VanY0cwyCce8CZQdVoRjH
Content-Type: multipart/mixed; boundary="------------0JO0itpdjfT4t0zV48LDJU2a"

--------------0JO0itpdjfT4t0zV48LDJU2a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjMgMTQ6MTUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
cHIgMDEsIDIwMjMgYXQgMDg6MzY6NDhBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+ICtzdGF0aWMgdm9pZCBybV9tYXBfZW50cnlfYXQoaW50IGlkeCkNCj4+ICt7DQo+PiAr
CWNhY2hlX21hcF9uLS07DQo+IA0KPiBMZXQncyBub3QgY2FsbCBtZW1tb3ZlKCkgd2hlbiBj
YWNoZV9tYXBfbiA9PSBpZHguDQo+IA0KPiBCZWxvdyB0b28uDQo+IA0KPiBFc3BlY2lhbGx5
IHNpbmNlIGNhY2hlX21hcCArIGlkeCArIDEgaXMgbm90IHZhbGlkIGFuZCBJIHdvdWxkbid0
IHdhbnQgaXQNCj4gZ2V0dGluZyBwcmVmZXRjaGVkIGZyb20gJXJzaSBpbiB0aGUgaHcgd2hl
biB0aGVyZSdzIG5vIHJlYXNvbiBmb3IgaXQgYW5kDQo+IGFsc28gdGhlIFJFVCBldmVuIGZy
b20gYSBmdW5jdGlvbiB3aGljaCBkb2Vzbid0IGRvIGFueXRoaW5nLCBjb3N0cy4NCg0KT1RP
SCB0aGUgYWRkaXRpb25hbCBjb21wYXJlIHRvIDAgaGFzIGNvc3RzLCB0b28sIGFuZCB0aGlz
IGNvc3QgaXMgc3BlbnQgZm9yDQpBTEwgY2FsbHMsIHdoaWxlIHRoZSB6ZXJvIHNpemUgY2Fs
bCBpcyBhIHJhdGhlciByYXJlIGNhc2UuDQoNClJlZ2FyZGluZyAiY2FjaGVfbWFwICsgaWR4
ICsgMSBpcyBub3QgdmFsaWQiOiB0aGUgc3RhbmRhcmQgY2xlYXJseSBwb2ludHMNCm91dCB0
aGF0IGEgY2FsbCB3aXRoIHNpemUgMCBpcyB2YWxpZCBhbmQgd29uJ3QgY29weSBhbnl0aGlu
ZyBbMV0uDQoNCj4gDQo+PiArCW1lbW1vdmUoY2FjaGVfbWFwICsgaWR4LCBjYWNoZV9tYXAg
KyBpZHggKyAxLA0KPj4gKwkJc2l6ZW9mKCpjYWNoZV9tYXApICogKGNhY2hlX21hcF9uIC0g
aWR4KSk7DQo+PiArfQ0KPiANCj4gT2ssIGZpcnN0IHdlaXJkIGlzc3VlIEkgZW5jb3VudGVy
ZWQgd2hpbGUgcGxheWluZyB3aXRoIG15IGNhcnZlZCBvdXQNCj4gcHJvZ3JhbSB0byBleGVy
Y2lzZSB0aGlzIGNhY2hlX21hcCBoYW5kbGluZyB0aGluZy4gSSBjYW4gc2hhcmUgaXQgaWYg
eW91DQo+IHdhbnQgaXQgLSBpdCBpcyB1Z2x5IGJ1dCBpdCB3b3Jrcy4NCj4gDQo+IFNvIHdo
aWxlIHJlYnVpbGRpbmcgdGhlIG1hcCwgSSBoYXZlIHRoZXNlIGN1cnJlbnQgcmVnaW9ucyBp
biB0aGUgbWFwLCBhdA0KPiBvbmUgcG9pbnQgaW4gdGltZToNCj4gDQo+IEN1cnJlbnQgbWFw
Og0KPiAwOiBzdGFydDogMHgwMDAwMDAwMDAwMDAwMDAwLCBlbmQ6IDB4MDAwMDAwMDAwMDEw
MDAwMCwgdHlwZTogMHgwDQo+IDE6IHN0YXJ0OiAweDAwMDAwMDAxMDAwMDAwMDAsIGVuZDog
MHgwMDAwMDAwODIwMDAwMDAwLCB0eXBlOiAweDYNCj4gMjogc3RhcnQ6IDB4MDAwMDAyZjEw
MDAwYzAwMCwgZW5kOiAweDAwMDAwM2JmMDAwMGMwMDAsIHR5cGU6IDB4Mg0KPiAzOiBzdGFy
dDogMHgwMDAwMDNiZjAwMDBjMDAwLCBlbmQ6IDB4MDAwMDBkNGIwMDAwYzAwMCwgdHlwZTog
MHgxDQo+IDQ6IHN0YXJ0OiAweDAwMDAwZDRiMDAwMGMwMDAsIGVuZDogMHgwMDAxOWZjMDAw
MDAxMDAwLCB0eXBlOiAweDANCj4gNTogc3RhcnQ6IDB4MDAwMTlmYzAwMDAwMTAwMCwgZW5k
OiAweDAwMDFkZjJkMDAwMDEwMDAsIHR5cGU6IDB4Mg0KPiANCj4gbm90ZSBlbnRyeSAjMy4N
Cj4gDQo+IE5vdyB0aGUgbmV4dCBvbmUgaXQgaW5zZXJ0cyBpczoNCj4gDQo+IGFkZF9tYXBf
ZW50cnlfYXQ6IHN0YXJ0OiAweDNiZjAwMDBjMDAwLCBlbmQ6IDB4ZDRiMDAwMGMwMDAsIHR5
cGU6IDB4MCwgaWR4OiAzDQo+ICAgbWVyZ2VfcHJldiAwOiBwcmV2LT5maXhlZDogMCwgcHJl
di0+ZW5kOiAweDNiZjAwMDBjMDAwLCBwcmV2LT50eXBlOiAweDINCj4gICBtZXJnZV9uZXh0
OiAxLCBuZXh0LT5maXhlZDogMCwgbmV4dC0+c3RhcnQ6IDB4ZDRiMDAwMGMwMDAsIG5leHQt
PnR5cGU6IDB4MA0KPiBhZGRfbWFwX2VudHJ5X2F0OiByZXQ6IDENCj4gDQo+IE5vdGUgaG93
IGl0IGlzIHRoZSBzYW1lIGFzIGVudHJ5IG51bWJlciAjMyAtIGp1c3QgYSBkaWZmZXJlbnQg
dHlwZS4NCj4gDQo+IFdoYXQgaXQgZW5kcyB1cCBkb2luZyBpcywgaXQgc2ltcGx5IG92ZXJ3
cml0ZXMgdGhlIHByZXZpb3VzIG9uZSBhbmQNCj4gbWVyZ2VzIGl0IHdpdGggdGhlIG5leHQ6
DQo+IA0KPiBDdXJyZW50IG1hcDoNCj4gMDogc3RhcnQ6IDB4MDAwMDAwMDAwMDAwMDAwMCwg
ZW5kOiAweDAwMDAwMDAwMDAxMDAwMDAsIHR5cGU6IDB4MA0KPiAxOiBzdGFydDogMHgwMDAw
MDAwMTAwMDAwMDAwLCBlbmQ6IDB4MDAwMDAwMDgyMDAwMDAwMCwgdHlwZTogMHg2DQo+IDI6
IHN0YXJ0OiAweDAwMDAwMmYxMDAwMGMwMDAsIGVuZDogMHgwMDAwMDNiZjAwMDBjMDAwLCB0
eXBlOiAweDINCj4gMzogc3RhcnQ6IDB4MDAwMDAzYmYwMDAwYzAwMCwgZW5kOiAweDAwMDE5
ZmMwMDAwMDEwMDAsIHR5cGU6IDB4MA0KPiA0OiBzdGFydDogMHgwMDAxOWZjMDAwMDAxMDAw
LCBlbmQ6IDB4MDAwMWRmMmQwMDAwMTAwMCwgdHlwZTogMHgyDQoNClRoZSBtYXAgd291bGQg
cmVmbGVjdCBoYXJkd2FyZSBiZWhhdmlvci4gVHlwZSAwIHdpbnMgaW4gY2FzZSBvZiBvdmVy
bGFwcGluZw0KTVRSUnMuDQoNCj4gTm93IEkgdGhpbmsgcmlnaHQgYWJvdXQgbm93IHdlIHNo
b3VsZCd2ZSBzY3JlYW1lZCBsb3VkbHkuDQoNCk5vdyB0aGlzIGlzIGFub3RoZXIgcmVxdWly
ZW1lbnQsIHJpZ2h0PyBUb2RheSdzIE1UUlIgY29kZSB3b3VsZG4ndCBzY3JlYW0NCmVpdGhl
ci4NCg0KPiBJIGtub3cgSSBrbm93LCB0aGlzIHNob3VsZCBuZXZlciBoYXBwZW4sIHJpZ2h0
PyBBbmQgZmlybXdhcmUgcHJvZ3JhbW1pbmcNCj4gdGhvc2UgTVRSUnMgZG9lc24ndCBtYWtl
IG1pc3Rha2VzLi4uDQoNCkF0IGxlYXN0IHdlIGRvbid0IGNvcnJlY3Qgc3VjaCBtaXN0YWtl
cyB0b2RheS4gRG8geW91IHRoaW5rIHdlIHNob3VsZCBjaGFuZ2UNCnRoYXQ/DQoNCj4gSG93
ZXZlciwgd2Ugc2hvdWxkIGJlIGxvdWQgaGVyZSBhbmQgc2NyZWFtIHdoZW4gYSBNVFJSIHJh
bmdlIGRpc2FwcGVhcnMNCj4gbGlrZSB0aGF0Lg0KPiANCj4gUmlnaHQ/DQoNClRCSCwgSSBk
b24ndCBrbm93Lg0KDQoNCkp1ZXJnZW4NCg==
--------------0JO0itpdjfT4t0zV48LDJU2a
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

--------------0JO0itpdjfT4t0zV48LDJU2a--

--------------1F0VanY0cwyCce8CZQdVoRjH--

--------------73kxAlDq7xXltR3WUj7YK0vc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRBMFEFAwAAAAAACgkQsN6d1ii/Ey8/
2Af+J/ef7q87YetxIDLKa/4r1riunfU7Cwyz9bCYrivpqA2XCI/AXetcjED2pS/OJrT+mGtCKvfT
/c+uI5X+OMPyK+gchHz4v6BhpgwRbWheUIv3/SXuC1K9e0sVwOqc+8uHbs1pP1R9fojVdqaFE6Xr
iSkHInSb7nHgWt53WdOFBpWj3J1ORxClA9sIp+482cSAYkFJMUvkjmh3lCTpbcwopOq1RY4aVRb5
hjZVEOMQmXPnmXQsyCRNtP7TyeIFmdhQU7wlWBY3k69WrCwbptu4pR9CX5x7QzlltyLzrvxwn5Aq
5evjYkHI0KPIG1ImUZPp0v6zxWJGv/BgdY7ucyRqUA==
=a/qG
-----END PGP SIGNATURE-----

--------------73kxAlDq7xXltR3WUj7YK0vc--
