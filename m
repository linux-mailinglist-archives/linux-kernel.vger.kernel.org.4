Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C170AC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 07:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEUFYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 01:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 01:24:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A86128;
        Sat, 20 May 2023 22:23:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDDF91FDD1;
        Sun, 21 May 2023 05:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684646636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jDs5PWzIb5j2h+LCKYMH/wWHxP24TZPVqLA4oF4S6B0=;
        b=hmlO21PfymYtxIpGjaJjrl2CNY1nDRPRorMyYg8IwWE0l9eDFEicEbuvDHVeaTJdJJ+9o1
        4eELv7aFLiRLKzPTD0v2W8k+yGUphta5Wmj5oSBnE9zEdKN/7EJ1ZDA8EFYABCnxDhGhsI
        VUvv2Db4IlJ5xyGlpSAXHo3ftfLkUvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BD321390B;
        Sun, 21 May 2023 05:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ycuwJOyqaWSFdAAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 21 May 2023 05:23:56 +0000
Message-ID: <73fd2741-3730-ca1d-7e23-0bf9cf10f423@suse.com>
Date:   Sun, 21 May 2023 07:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ir0cc06T7GC9xpBoU2Z6gt8d"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Ir0cc06T7GC9xpBoU2Z6gt8d
Content-Type: multipart/mixed; boundary="------------itRklF4GeRTx2kWh9ThwD0F6";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Message-ID: <73fd2741-3730-ca1d-7e23-0bf9cf10f423@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>

--------------itRklF4GeRTx2kWh9ThwD0F6
Content-Type: multipart/mixed; boundary="------------qMWMFDBW1utuPCbXAlZnm6nr"

--------------qMWMFDBW1utuPCbXAlZnm6nr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDUuMjMgMDM6MTksIE1hcnRpbiBLLiBQZXRlcnNlbiB3cm90ZToNCj4gDQo+IEpv
aG4sDQo+IA0KPj4gQE1hcnRpbiwgRG8geW91IGhhdmUgYW55IHByZWZlcmVuY2UgZm9yIHdo
YXQgd2UgZG8gbm93PyBUaGlzIGNvZGUNCj4+IHdoaWNoIGRvZXMgbm90IGNoZWNrIGZvciBl
cnJvciBhbmQgZG9lcyBub3QgcHJlLXplcm8gc3NoZHIgaXMNCj4+IGxvbmdzdGFuZGluZywg
c28gSSBhbSBub3Qgc3VyZSBpZiBKdWVyZ2VuJ3MgY2hhbmdlIGlzIHJlcXVpcmVkIGZvciBm
b3INCj4+IHY2LjQuIEknbSB0aGlua2luZyB0byBmaXggY2FsbGVycyBmb3IgdjYuNSBhbmQg
YWxzbyBtYXliZSBjaGFuZ2UgdGhlDQo+PiBBUEksIGFzIEkgZGVzY3JpYmVkLg0KPiANCj4g
QXMgSSBhbGx1ZGVkIHRvIGluIHRoZSB0cmFjaW5nIHRocmVhZCwgSSdkIGxpa2UgdG8gc2Vl
IFNLL0FTQy9BU0NRIGJlaW5nDQo+IGdlbmVyYWxseSBhdmFpbGFibGUgaW4gdGhlIHNjc2lf
Y21uZCByZXN1bHRzIGluc3RlYWQgb2YgYWxsIHRoaXMgc2Vuc2UNCj4gYnVmZmVyIGFuZCBz
ZW5zZSBoZWFkZXIgbWljcm9tYW5hZ2VtZW50IGluIGV2ZXJ5IGNhbGxlci4gVGhhdCdzIGEg
cHJldHR5DQo+IGhlYXZ5IGxpZnQsIHRob3VnaC4NCj4gDQo+IFNob3J0IHRlcm0gd2UgbmVl
ZCBhbGwgY2FsbGVycyB0byBiZSBmaXhlZCB1cC4gSSdtIG5vdCBhIHBhcnRpY3VsYXJseQ0K
PiBiaWcgZmFuIG9mIHNjc2lfZXhlY3V0ZV9jbWQoKSB6ZXJvaW5nIHNvbWV0aGluZyBiZWlu
ZyBwYXNzZWQgaW4uIEkNCj4gd29uZGVyIGlmIGl0IHdvdWxkIGJlIHdvcnRoIGhhdmluZyBh
IERFQ0xBUkVfU0VOU0VfSEVBREVSKCk/DQoNCnNzaGRyIGlzIG91dHB1dCBvbmx5IGRhdGEs
IHNvIHNldHRpbmcgaXQgYmVmb3JlIHJldHVybmluZyBzZWVtcyB0byBiZSBhDQpzZW5zaWJs
ZSB0aGluZyB0byBkby4NCg0KTGV0dGluZyB0aGUgY2FsbGVycyBkbyB0aGF0IGlzIGtpbmQg
b2YgYSBsYXllcmluZyB2aW9sYXRpb24gSU1ITywgYXMgdGhpcw0Kd291bGQgc3ByZWFkIHRo
ZSBrbm93bGVkZ2UgdGhhdCBzY3NpX2V4ZWN1dGVfY21kKCkgaXNuJ3Qgc2V0dGluZyBpdHMg
b3V0cHV0DQpkYXRhIGFsd2F5cy4NCg0KSW4gdGhlIGVuZCBpdHMgeW91ciBkZWNpc2lvbiwg
b2YgY291cnNlLg0KDQoNCkp1ZXJnZW4NCg==
--------------qMWMFDBW1utuPCbXAlZnm6nr
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

--------------qMWMFDBW1utuPCbXAlZnm6nr--

--------------itRklF4GeRTx2kWh9ThwD0F6--

--------------Ir0cc06T7GC9xpBoU2Z6gt8d
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRpquwFAwAAAAAACgkQsN6d1ii/Ey8x
LAgAlSEEWx6phlVBDVwkL8Egn49EPcK1OcA4VQ1QcSTHONRLA0q5QhY/GFiuYpqUB4Qmlk9dLrI4
08q9QMLab+C2yzJoRefXxBeDsMnhB+MLV0WCGIs3H59shBfe1zbDWs29t+6rDCJBG/KTDw8rlg1O
5SDeKh4mm7mvhziiQ89sBZVBNpK5956HbiN9BoXeoX6QdlRgnrFA2nMhlq5TkY4BXE4YPZmhkN0c
PgBSYznEi1gcVtl1h7R6021WRqvfibsuOZV3/lLG/ZI3bVPDuwlTWumLJUpsPh5HP2B5Ov10OWX5
JOdf80Euyf5YSrkE2VkkMxQRSK4KAZKzl8n7qUC6aQ==
=2FXn
-----END PGP SIGNATURE-----

--------------Ir0cc06T7GC9xpBoU2Z6gt8d--
