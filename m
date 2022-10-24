Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1260AECB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJXPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiJXPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:14:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EABBA277;
        Mon, 24 Oct 2022 06:52:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2691FD8E;
        Mon, 24 Oct 2022 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666616152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doG6HZnZCoVKaGw+wo/WVrDGL+eOY9VhqR01LjBiG/k=;
        b=HfxIHM2+JmZUl9g4XsZz67Ez89BG4CQew93Ibamd0l2IDF3ydJyH43+tX8csurg9RxBGFc
        IW+os+DmG7gY+T3mqa/3GQt87PE+wZNr91AROX7E2pGrtKnJ0uM8O/GxEeRoCDGGolffcV
        /5+K+/KQ9Vigv6UUppntuZaQGg/imcI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1898813A79;
        Mon, 24 Oct 2022 12:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEmOBFiLVmOeagAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 24 Oct 2022 12:55:52 +0000
Message-ID: <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
Date:   Mon, 24 Oct 2022 14:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Content-Language: en-US
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S7L73GZ7QwBj4qRYR6bALgT0"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S7L73GZ7QwBj4qRYR6bALgT0
Content-Type: multipart/mixed; boundary="------------8nAfY0HuTJjjgFAPh5D6KU35";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, sathya.prakash@broadcom.com,
 suganath-prabu.subramani@broadcom.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 adi@kriegisch.at
Message-ID: <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
In-Reply-To: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>

--------------8nAfY0HuTJjjgFAPh5D6KU35
Content-Type: multipart/mixed; boundary="------------cFpTspK8fz03bLJT6EfskpoB"

--------------cFpTspK8fz03bLJT6EfskpoB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTAuMjIgMTM6NTYsIFNyZWVrYW50aCBSZWRkeSB3cm90ZToNCj4gT24gU3VuLCBP
Y3QgMjMsIDIwMjIgYXQgNjo1NyBBTSBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNt
Lm9yZz4gd3JvdGU6DQo+Pg0KPj4gT24gMTAvMjEvMjIgMDI6MjIsIFNhbHZhdG9yZSBCb25h
Y2NvcnNvIHdyb3RlOg0KPj4+IFdlIGdvdCB0aGUgZm9sbG93aW5nIHJlcG9ydCBpbiBEZWJp
YW4gYWZ0ZXIgYW4gdXBkYXRlIGZyb20gNS4xMC4xNDAgdG8NCj4+PiB0aGUgY3VycmVudCA1
LjEwLjE0OS4gRnVsbCBxdW90aW5nIGJlbG93IChmcm9tDQo+Pj4gaHR0cHM6Ly9idWdzLmRl
Ymlhbi5vcmcvMTAyMjEyNikuIERvZXMgdGhpcyByaW5nIHNvbWUgYmVsbCBhYm91dCBrbm93
bg0KPj4+IHJlZ3Jlc3Npb25zPw0KPj4NCj4+IE9ubHkgdGhyZWUgbXB0M3NhcyBjaGFuZ2Vz
IGFyZSBuZXcgaW4gdjUuMTAuMTQ5IGNvbXBhcmVkIHRvIHY1LjEwLjE0MDoNCj4+ICQgZ2l0
IGxvZyAtLWZvcm1hdD1vbmVsaW5lIHY1LjEwLjE0MC4udjUuMTAuMTQ5DQo+PiAyYjlhYmEw
YzVkNThlMTQxZTMyYmIxYmI0YzdjZDkxZDE5ZjA3NWI4IHNjc2k6IG1wdDNzYXM6IEZpeCBy
ZXR1cm4gdmFsdWUgY2hlY2sgb2YgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCkNCj4+IGU3ZmFm
ZWY5ODMwYzRhMDFlNjBmNzZlMzg2MGE5YmVmMDI2MjM3OGQgc2NzaTogbXB0M3NhczogRm9y
Y2UgUENJZSBzY2F0dGVybGlzdCBhbGxvY2F0aW9ucyB0byBiZSB3aXRoaW4gc2FtZSA0IEdC
IHJlZ2lvbg0KPj4gZWExMGE2NTJhZDJhZTJjZjNlY2VkNmY2MzJhNWM5OGYyNjcyNzA1NyBz
Y3NpOiBtcHQzc2FzOiBGaXggdXNlLWFmdGVyLWZyZWUgd2FybmluZw0KPj4NCj4+IFNyZWVr
YW50aCBhbmQgU3VnYW5hdGgsIGNhbiB5b3UgaGVscCB3aXRoIGJpc2VjdGluZyB0aGlzIGlz
c3VlPyBGb3IgdGhlDQo+PiBmdWxsIHJlcG9ydCwgc2VlIGFsc28gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtc2NzaS9ZMUprdUtUalZZck9XYnZtQGVsZGFtYXIubGFuLy4NCj4g
DQo+IFRoaXMgaXNzdWUgaXMgZ2V0dGluZyBvYnNlcnZlZCBhZnRlciBoYXZpbmcgdGhlIGJl
bG93IHBhdGNoIGNoYW5nZXMsDQo+IDJiOWFiYTBjNWQ1OGUxNDFlMzJiYjFiYjRjN2NkOTFk
MTlmMDc1Yjggc2NzaTogbXB0M3NhczogRml4IHJldHVybg0KPiB2YWx1ZSBjaGVjayBvZiBk
bWFfZ2V0X3JlcXVpcmVkX21hc2soKQ0KPiANCj4gV2hhdCBpcyBoYXBwZW5pbmcgaXMgdGhh
dCBvbiBYZW4gaHlwZXJ2aXNvciwgdGhpcw0KPiBkbWFfZ2V0X3JlcXVpcmVkX21hc2soKSBB
UEkgYWx3YXlzIHJldHVybnMgYSAzMiBiaXQgRE1BIG1hc2suIEkuZS4gSXQNCj4gc2F5cyB0
aGF0IHRoZSBtaW5pbXVtIERNQSBtYXNrIHJlcXVpcmVkIHRvIGFjY2VzcyB0aGUgaG9zdCBt
ZW1vcnkgaXMNCj4gMzIgYml0IGFuZCBoZW5jZSBtcHQzc2FzIGRyaXZlciBpcyBzZXR0aW5n
IHRoZSBETUEgbWFzayB0byAzMmJpdC4gU28sDQo+IG9uIGEgNjQgYml0IG1hY2hpbmUsIGlm
IHRoZSBkcml2ZXIgc2V0J3MgdGhlIERNQSBtYXNrIHRvIDMyIGJpdCB0aGVuDQo+IFNXSU9U
TEIncyBib3VuY2UgYnVmZmVyIGNvbWVzIGludG8gcGljdHVyZSBkdXJpbmcgSU9zLiBTaW5j
ZSB0aGVzZQ0KPiBib3VuY2UgYnVmZmVycyBhcmUgbGltaXRlZCBpbiBzaXplIGFuZCBoZW5j
ZSB3ZSBvYnNlcnZlIHRoZSBJTyBoYW5nIGlmDQo+IHRoZSBsYXJnZSBJT3MgYXJlIGlzc3Vl
ZC4NCj4gDQo+IEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzIEFQSSdzIHJldHVybiB2YWx1
ZSBpcyBjb3JyZWN0IG9yIG5vdCBpbiB0aGUNCj4gWGVuIGVudmlyb25tZW50LiBJZiBpdCBp
cyBjb3JyZWN0IHRoZW4gSSBoYXZlIHRvIG1vZGlmeSB0aGUgZHJpdmVyIHRvDQo+IG5vdCB1
c2UgdGhpcyBBUEkgYW5kIGRpcmVjdGx5IHNldCB0aGUgRE1BIG1hc2sgdG8gNjQgYml0IGlm
IHRoZSBzeXN0ZW0NCj4gaXMgYSA2NGJpdCBtYWNoaW5lLg0KDQpQbGVhc2UgcmVjaGVjayB0
aGUgYmFja3BvcnRlZCBwYXRjaCBpbiA1LjEwLnkuIEl0IGlzIF93cm9uZ18uIFRoZSBiYWNr
cG9ydA0KaGFzOg0KDQotLS0gYS9kcml2ZXJzL3Njc2kvbXB0M3Nhcy9tcHQzc2FzX2Jhc2Uu
Yw0KKysrIGIvZHJpdmVycy9zY3NpL21wdDNzYXMvbXB0M3Nhc19iYXNlLmMNCkBAIC0yOTkz
LDcgKzI5OTMsNyBAQCBfYmFzZV9jb25maWdfZG1hX2FkZHJlc3Npbmcoc3RydWN0IE1QVDNT
QVNfQURBUFRFUiAqaW9jLCANCnN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KDQogICAgICAgICBp
ZiAoaW9jLT5pc19tY3B1X2VuZHBvaW50IHx8DQogICAgICAgICAgICAgc2l6ZW9mKGRtYV9h
ZGRyX3QpID09IDQgfHwgaW9jLT51c2VfMzJiaXRfZG1hIHx8DQotICAgICAgICAgICBkbWFf
Z2V0X3JlcXVpcmVkX21hc2soJnBkZXYtPmRldikgPD0gMzIpDQorICAgICAgICAgICBkbWFf
Z2V0X3JlcXVpcmVkX21hc2soJnBkZXYtPmRldikgPD0gRE1BX0JJVF9NQVNLKDMyKSkNCiAg
ICAgICAgICAgICAgICAgaW9jLT5kbWFfbWFzayA9IDMyOw0KICAgICAgICAgLyogU2V0IDYz
IGJpdCBETUEgbWFzayBmb3IgYWxsIFNBUzMgYW5kIFNBUzM1IGNvbnRyb2xsZXJzICovDQog
ICAgICAgICBlbHNlIGlmIChpb2MtPmhiYV9tcGlfdmVyc2lvbl9iZWxvbmdlZCA+IE1QSTJf
VkVSU0lPTikNCg0KV2hpbGUgdGhlIHVwc3RyZWFtIHBhdGNoIGhhczoNCg0KKyAgICAgICBp
ZiAoaW9jLT5pc19tY3B1X2VuZHBvaW50IHx8IHNpemVvZihkbWFfYWRkcl90KSA9PSA0IHx8
DQorICAgICAgICAgICBkbWFfZ2V0X3JlcXVpcmVkX21hc2soJnBkZXYtPmRldikgPD0gMzIp
IHsNCiAgICAgICAgICAgICAgICAgaW9jLT5kbWFfbWFzayA9IDMyOw0KKyAgICAgICAgICAg
ICAgIGNvaGVyZW50X2RtYV9tYXNrID0gZG1hX21hc2sgPSBETUFfQklUX01BU0soMzIpOw0K
DQoNCkp1ZXJnZW4NCg0K
--------------cFpTspK8fz03bLJT6EfskpoB
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

--------------cFpTspK8fz03bLJT6EfskpoB--

--------------8nAfY0HuTJjjgFAPh5D6KU35--

--------------S7L73GZ7QwBj4qRYR6bALgT0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNWi1cFAwAAAAAACgkQsN6d1ii/Ey9+
lwf/Yha8xaMGxH8Q4ckxdIAJvEQrji9rS53M62NlunVEMWVsKeUqsrmPASDUET/YhTByyi7+moWO
DDioRZgOVuaMudP+cIwEtQ8eYvUv30uFaIOvKlFwsO2li5l50mVCAT0/5dax0+H5vXWpKsVPlZ4z
SgcnpWUamA5goQNHUA0EoyFQpxucuiC1w7u7yBEIEVm2VmzyNrayou76j+GLEBGD+I/A9PzWHju/
8UOSLt3jYmY6t/RXCar2Rk5qaMQqoTCPM6rynWO1Lpy30dH+hMl4+tXW2o2p5EdJBpj/maCB02KB
W4KDn2wxmur5vSpRqI4Ha/OdjqmHe55PW1h5Mv/IFw==
=CPv9
-----END PGP SIGNATURE-----

--------------S7L73GZ7QwBj4qRYR6bALgT0--
