Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73AB6CD202
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjC2GVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2GVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:21:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902271FE0;
        Tue, 28 Mar 2023 23:20:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362E11FE00;
        Wed, 29 Mar 2023 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680070858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF5tiN4pJiDhfYy3HpUYqdCSveJtIUKnzfiikwybTCg=;
        b=oCKkGwdZQd25vu3lwQnEnN97MY8+LkWt7J0QmPCBjJsZArKaxypZ2DxIXqi5i3tCdDcj2/
        WvrkdVlQhdG6D/6KpBdokIPkrjGqi5blyuZ9ESdVIdoZHh/c5A7xaE6gwmLnEIvfshyFiR
        B+hVNCGiPy2L7oOsqQY/rINnvBw7Kdw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05844139D3;
        Wed, 29 Mar 2023 06:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tTh3O8nYI2TxGwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 29 Mar 2023 06:20:57 +0000
Message-ID: <38d97163-5c02-9193-5c20-ab3b5274bd51@suse.com>
Date:   Wed, 29 Mar 2023 08:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Dan Carpenter <error27@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230328084602.20729-1-jgross@suse.com>
 <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
In-Reply-To: <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------KkuCFGL7jBk3rYHaRTGCaHD7"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------KkuCFGL7jBk3rYHaRTGCaHD7
Content-Type: multipart/mixed; boundary="------------N0THAbnNAKLqB2Z0kJHF16FQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Dan Carpenter <error27@gmail.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <38d97163-5c02-9193-5c20-ab3b5274bd51@suse.com>
Subject: Re: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
References: <20230328084602.20729-1-jgross@suse.com>
 <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>
In-Reply-To: <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>

--------------N0THAbnNAKLqB2Z0kJHF16FQ
Content-Type: multipart/mixed; boundary="------------t8ySs607nzW2I72U1Z9Pv10N"

--------------t8ySs607nzW2I72U1Z9Pv10N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDMuMjMgMTc6NDcsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDI4LjAzLjIzIDExOjQ2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVs
bG8gSnVlcmdlbg0KPiANCj4+IHNjc2liYWNrX2ZyZWVfdHJhbnNsYXRpb25fZW50cnkoKSBz
aG91bGRuJ3QgYmUgY2FsbGVkIHVuZGVyIHNwaW5sb2NrLA0KPj4gYXMgaXQgY2FuIHNsZWVw
Lg0KPj4NCj4+IFRoaXMgcmVxdWlyZXMgdG8gc3BsaXQgcmVtb3ZpbmcgYSB0cmFuc2xhdGlv
biBlbnRyeSBmcm9tIHRoZSB2MnAgbGlzdA0KPj4gZnJvbSBhY3R1YWxseSBjYWxsaW5nIGty
ZWZfcHV0KCkgZm9yIHRoZSBlbnRyeS4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRGFuIENhcnBl
bnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQo+PiBMaW5rOiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZKkpVSWw2NFVEbWRrYm9o
QGthZGFtL19fO0t3ISFHRl8yOWRiY1FJVUJQQSEyM0lLZFZoYW1vRnE4cHRVbnByZF9UdWJE
TU9iai0wUUFhbHNHaWZmQkhDZUVkT3V3cnE3ejRvaGc5MlNqMG9sZ2wwbmg3M29YdlNyLWkx
enFYaFkkIFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL3hlbi94
ZW4tc2NzaWJhY2suYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPj4gICAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tc2NzaWJhY2suYyBiL2RyaXZlcnMv
eGVuL3hlbi1zY3NpYmFjay5jDQo+PiBpbmRleCA5NTQxODhiMGI4NTguLjI5NGYyOWNkYzdh
YSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jDQo+PiArKysg
Yi9kcml2ZXJzL3hlbi94ZW4tc2NzaWJhY2suYw0KPj4gQEAgLTEwMTAsMTIgKzEwMTAsNiBA
QCBzdGF0aWMgaW50IHNjc2liYWNrX2FkZF90cmFuc2xhdGlvbl9lbnRyeShzdHJ1Y3QgdnNj
c2lia19pbmZvICppbmZvLA0KPj4gICAgCXJldHVybiBlcnI7DQo+PiAgICB9DQo+PiAgICAN
Cj4+IC1zdGF0aWMgdm9pZCBfX3Njc2liYWNrX2RlbF90cmFuc2xhdGlvbl9lbnRyeShzdHJ1
Y3QgdjJwX2VudHJ5ICplbnRyeSkNCj4+IC17DQo+PiAtCWxpc3RfZGVsKCZlbnRyeS0+bCk7
DQo+PiAtCWtyZWZfcHV0KCZlbnRyeS0+a3JlZiwgc2NzaWJhY2tfZnJlZV90cmFuc2xhdGlv
bl9lbnRyeSk7DQo+PiAtfQ0KPj4gLQ0KPj4gICAgLyoNCj4+ICAgICAgRGVsZXRlIHRoZSB0
cmFuc2xhdGlvbiBlbnRyeSBzcGVjaWZpZWQNCj4+ICAgICovDQo+PiBAQCAtMTAyNCwxOCAr
MTAxOCwyMCBAQCBzdGF0aWMgaW50IHNjc2liYWNrX2RlbF90cmFuc2xhdGlvbl9lbnRyeShz
dHJ1Y3QgdnNjc2lia19pbmZvICppbmZvLA0KPj4gICAgew0KPj4gICAgCXN0cnVjdCB2MnBf
ZW50cnkgKmVudHJ5Ow0KPj4gICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiAtCWludCBy
ZXQgPSAwOw0KPj4gICAgDQo+PiAgICAJc3Bpbl9sb2NrX2lycXNhdmUoJmluZm8tPnYycF9s
b2NrLCBmbGFncyk7DQo+PiAgICAJLyogRmluZCBvdXQgdGhlIHRyYW5zbGF0aW9uIGVudHJ5
IHNwZWNpZmllZCAqLw0KPj4gICAgCWVudHJ5ID0gc2NzaWJhY2tfY2hrX3RyYW5zbGF0aW9u
X2VudHJ5KGluZm8sIHYpOw0KPj4gICAgCWlmIChlbnRyeSkNCj4+IC0JCV9fc2NzaWJhY2tf
ZGVsX3RyYW5zbGF0aW9uX2VudHJ5KGVudHJ5KTsNCj4+IC0JZWxzZQ0KPj4gLQkJcmV0ID0g
LUVOT0VOVDsNCj4+ICsJCWxpc3RfZGVsKCZlbnRyeS0+bCk7DQo+PiAgICANCj4+ICAgIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZpbmZvLT52MnBfbG9jaywgZmxhZ3MpOw0KPj4gLQly
ZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwlpZiAoIWVudHJ5KQ0KPj4gKwkJcmV0dXJuIC1FTk9F
TlQ7DQo+PiArDQo+PiArCWtyZWZfcHV0KCZlbnRyeS0+a3JlZiwgc2NzaWJhY2tfZnJlZV90
cmFuc2xhdGlvbl9lbnRyeSk7DQo+PiArCXJldHVybiAwOw0KPj4gICAgfQ0KPj4gICAgDQo+
PiAgICBzdGF0aWMgdm9pZCBzY3NpYmFja19kb19hZGRfbHVuKHN0cnVjdCB2c2NzaWJrX2lu
Zm8gKmluZm8sIGNvbnN0IGNoYXIgKnN0YXRlLA0KPj4gQEAgLTEyMzksMTQgKzEyMzUsMTkg
QEAgc3RhdGljIHZvaWQgc2NzaWJhY2tfcmVsZWFzZV90cmFuc2xhdGlvbl9lbnRyeShzdHJ1
Y3QgdnNjc2lia19pbmZvICppbmZvKQ0KPj4gICAgew0KPj4gICAgCXN0cnVjdCB2MnBfZW50
cnkgKmVudHJ5LCAqdG1wOw0KPj4gICAgCXN0cnVjdCBsaXN0X2hlYWQgKmhlYWQgPSAmKGlu
Zm8tPnYycF9lbnRyeV9saXN0cyk7DQo+PiArCXN0cnVjdCBsaXN0X2hlYWQgdG1wX2xpc3Q7
DQo+IA0KPiANCj4gSSB3b3VsZCB1c2UgTElTVF9IRUFEKHRtcF9saXN0KTsNCg0KVGhlcmUg
aXMgbm8gbmVlZCB0byBpbml0aWFsaXplIGl0LCBzbyBJIHRoaW5rIEkgd2lsbCBrZWVwIGl0
IGFzIGlzLg0KDQo+IA0KPj4gICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiAgICANCj4+
ICAgIAlzcGluX2xvY2tfaXJxc2F2ZSgmaW5mby0+djJwX2xvY2ssIGZsYWdzKTsNCj4+ICAg
IA0KPj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50cnksIHRtcCwgaGVhZCwgbCkN
Cj4+IC0JCV9fc2NzaWJhY2tfZGVsX3RyYW5zbGF0aW9uX2VudHJ5KGVudHJ5KTsNCj4+ICsJ
bGlzdF9jdXRfYmVmb3JlKCZ0bXBfbGlzdCwgaGVhZCwgaGVhZCk7DQo+IA0KPiBzbyB3ZSBq
dXN0IG1vdmUgYWxsIGVudHJpZXMgZnJvbSBoZWFkIHRvIHRtcF9saXN0IGhlcmUgdG8gYmUg
cHJvY2Vzc2VkLi4uDQoNCkNvcnJlY3QuDQoNCj4gDQo+PiAgICANCj4+ICAgIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZpbmZvLT52MnBfbG9jaywgZmxhZ3MpOw0KPiANCj4gLi4uIHdo
ZW4gdGhlIGxvY2sgaXMgbm90IGhlbGQsIG9rDQo+IA0KPiBQYXRjaCBMR1RNLCBidXQgb25l
IChtYXliZSBzdHVwaWQpIHF1ZXN0aW9uIHRvIGNsYXJpZnkuDQo+IA0KPiBXaHkgZG8gd2Ug
bmVlZCB0byB1c2UgYSBsb2NrIGhlcmUgaW4gdGhlIGZpcnN0IHBsYWNlPyBUaGUNCj4gc2Nz
aWJhY2tfcmVsZWFzZV90cmFuc2xhdGlvbl9lbnRyeSgpIGdldHMgY2FsbGVkIHdoZW4gdGhl
IGRyaXZlcg0KPiBpbnN0YW5jZSBpcyBhYm91dCB0byBiZSByZW1vdmVkIGFuZCAqYWZ0ZXIq
IHRoZSBkaXNjb25uZWN0aW9uIGZyb20NCj4gb3RoZXJlbmQgKHNvIG5vIHJlcXVlc3RzIGFy
ZSBleHBlY3RlZCksIHNvIHdoYXQgZWxzZSBtaWdodCBjYXVzZSB0aGlzDQo+IGxpc3QgdG8g
YmUgYWNjZXNzZWQgY29uY3VycmVudGx5Pw0KDQpNYXliZSBub3RoaW5nLCBidXQgSSB0aGlu
ayBpdCBpcyBnb29kIHByYWN0aWNlIHRvIGtlZXAgdGhlIGxvY2sgaW4gb3JkZXINCnRvIGF2
b2lkIGZ1dHVyZSBjb2RlIGNoYW5nZXMgdG8gY2F1c2UgcHJvYmxlbXMuDQoNCg0KSnVlcmdl
bg0KDQo=
--------------t8ySs607nzW2I72U1Z9Pv10N
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

--------------t8ySs607nzW2I72U1Z9Pv10N--

--------------N0THAbnNAKLqB2Z0kJHF16FQ--

--------------KkuCFGL7jBk3rYHaRTGCaHD7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQj2MkFAwAAAAAACgkQsN6d1ii/Ey9Q
nwgAh2roWMbyeLfm3rQu+e0ELkmG/8lZWYH15wQWk0EzXenPfJ0XtQ4vrL7Bb37/eoZdZvLKEtxE
Xj3FsX0hyr71+LBf4dVAks9qX0RxOkPv8TcscgjIhLQAEtkYHRhkTlCwdCYeqSKjqSwnxAMS/YEQ
4WgGCaQoLFvf66PUmV0jKrdahzf1IfpMUk/5ftPOn12Mm45xlCIixdq1C7zehozQjRb6MZLAfeN0
DR5Da9/aXfRzxbVdoFnhqkVP6PzRH/1E/3V+V5n9OSmmiHmA60NNHWdBe2xqTEB4VDfwR7qIiNVQ
bljElpfwXkTRyvCcvOvNt92BjviZlCsku5epOPeYFg==
=07qg
-----END PGP SIGNATURE-----

--------------KkuCFGL7jBk3rYHaRTGCaHD7--
