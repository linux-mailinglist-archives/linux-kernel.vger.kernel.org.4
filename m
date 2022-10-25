Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FA60C3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJYGib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJYGi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:38:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DA107CF0;
        Mon, 24 Oct 2022 23:38:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7436B22098;
        Tue, 25 Oct 2022 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666679903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6R8DV1I3DLA59p8MCxfr1ZPZBKIlTM1sKCHImg6KD0I=;
        b=qLk7xvs/Q3GGVLfl8+KQI/CfylZOZs4GnLnUBCkMLxGehesPWPpbZYCrIxFVwoAxb888TF
        05m5RERkfZj9A8uk49xjZRpLbMA6JZqt39ZZproFZl++5QArddWJ7GkQ/SOydgw7i2QXke
        iKK4S9dz45VZOhyNOiY7uPU2YuiW5FY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B1F1134CA;
        Tue, 25 Oct 2022 06:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SZExBV+EV2MCZgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 25 Oct 2022 06:38:23 +0000
Message-ID: <947cb58c-9b3b-c018-0b46-66122ea1ce46@suse.com>
Date:   Tue, 25 Oct 2022 08:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
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
 <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
In-Reply-To: <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8yuOl9h0grkLiTIM0SMWn7UE"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8yuOl9h0grkLiTIM0SMWn7UE
Content-Type: multipart/mixed; boundary="------------nM63vNz4QQMxJ1qOUEto0weU";
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
Message-ID: <947cb58c-9b3b-c018-0b46-66122ea1ce46@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
In-Reply-To: <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>

--------------nM63vNz4QQMxJ1qOUEto0weU
Content-Type: multipart/mixed; boundary="------------riRNKW1nBDfZOTdj5zDjO7LH"

--------------riRNKW1nBDfZOTdj5zDjO7LH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTAuMjIgMTQ6NTUsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDI0LjEwLjIy
IDEzOjU2LCBTcmVla2FudGggUmVkZHkgd3JvdGU6DQo+PiBPbiBTdW4sIE9jdCAyMywgMjAy
MiBhdCA2OjU3IEFNIEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPiB3cm90
ZToNCj4+Pg0KPj4+IE9uIDEwLzIxLzIyIDAyOjIyLCBTYWx2YXRvcmUgQm9uYWNjb3JzbyB3
cm90ZToNCj4+Pj4gV2UgZ290IHRoZSBmb2xsb3dpbmcgcmVwb3J0IGluIERlYmlhbiBhZnRl
ciBhbiB1cGRhdGUgZnJvbSA1LjEwLjE0MCB0bw0KPj4+PiB0aGUgY3VycmVudCA1LjEwLjE0
OS4gRnVsbCBxdW90aW5nIGJlbG93IChmcm9tDQo+Pj4+IGh0dHBzOi8vYnVncy5kZWJpYW4u
b3JnLzEwMjIxMjYpLiBEb2VzIHRoaXMgcmluZyBzb21lIGJlbGwgYWJvdXQga25vd24NCj4+
Pj4gcmVncmVzc2lvbnM/DQo+Pj4NCj4+PiBPbmx5IHRocmVlIG1wdDNzYXMgY2hhbmdlcyBh
cmUgbmV3IGluIHY1LjEwLjE0OSBjb21wYXJlZCB0byB2NS4xMC4xNDA6DQo+Pj4gJCBnaXQg
bG9nIC0tZm9ybWF0PW9uZWxpbmUgdjUuMTAuMTQwLi52NS4xMC4xNDkNCj4+PiAyYjlhYmEw
YzVkNThlMTQxZTMyYmIxYmI0YzdjZDkxZDE5ZjA3NWI4IHNjc2k6IG1wdDNzYXM6IEZpeCBy
ZXR1cm4gdmFsdWUgDQo+Pj4gY2hlY2sgb2YgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCkNCj4+
PiBlN2ZhZmVmOTgzMGM0YTAxZTYwZjc2ZTM4NjBhOWJlZjAyNjIzNzhkIHNjc2k6IG1wdDNz
YXM6IEZvcmNlIFBDSWUgDQo+Pj4gc2NhdHRlcmxpc3QgYWxsb2NhdGlvbnMgdG8gYmUgd2l0
aGluIHNhbWUgNCBHQiByZWdpb24NCj4+PiBlYTEwYTY1MmFkMmFlMmNmM2VjZWQ2ZjYzMmE1
Yzk4ZjI2NzI3MDU3IHNjc2k6IG1wdDNzYXM6IEZpeCB1c2UtYWZ0ZXItZnJlZSANCj4+PiB3
YXJuaW5nDQo+Pj4NCj4+PiBTcmVla2FudGggYW5kIFN1Z2FuYXRoLCBjYW4geW91IGhlbHAg
d2l0aCBiaXNlY3RpbmcgdGhpcyBpc3N1ZT8gRm9yIHRoZQ0KPj4+IGZ1bGwgcmVwb3J0LCBz
ZWUgYWxzbyANCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1zY3NpL1kxSmt1
S1RqVllyT1didm1AZWxkYW1hci5sYW4vLg0KPj4NCj4+IFRoaXMgaXNzdWUgaXMgZ2V0dGlu
ZyBvYnNlcnZlZCBhZnRlciBoYXZpbmcgdGhlIGJlbG93IHBhdGNoIGNoYW5nZXMsDQo+PiAy
YjlhYmEwYzVkNThlMTQxZTMyYmIxYmI0YzdjZDkxZDE5ZjA3NWI4IHNjc2k6IG1wdDNzYXM6
IEZpeCByZXR1cm4NCj4+IHZhbHVlIGNoZWNrIG9mIGRtYV9nZXRfcmVxdWlyZWRfbWFzaygp
DQo+Pg0KPj4gV2hhdCBpcyBoYXBwZW5pbmcgaXMgdGhhdCBvbiBYZW4gaHlwZXJ2aXNvciwg
dGhpcw0KPj4gZG1hX2dldF9yZXF1aXJlZF9tYXNrKCkgQVBJIGFsd2F5cyByZXR1cm5zIGEg
MzIgYml0IERNQSBtYXNrLiBJLmUuIEl0DQo+PiBzYXlzIHRoYXQgdGhlIG1pbmltdW0gRE1B
IG1hc2sgcmVxdWlyZWQgdG8gYWNjZXNzIHRoZSBob3N0IG1lbW9yeSBpcw0KPj4gMzIgYml0
IGFuZCBoZW5jZSBtcHQzc2FzIGRyaXZlciBpcyBzZXR0aW5nIHRoZSBETUEgbWFzayB0byAz
MmJpdC4gU28sDQo+PiBvbiBhIDY0IGJpdCBtYWNoaW5lLCBpZiB0aGUgZHJpdmVyIHNldCdz
IHRoZSBETUEgbWFzayB0byAzMiBiaXQgdGhlbg0KPj4gU1dJT1RMQidzIGJvdW5jZSBidWZm
ZXIgY29tZXMgaW50byBwaWN0dXJlIGR1cmluZyBJT3MuIFNpbmNlIHRoZXNlDQo+PiBib3Vu
Y2UgYnVmZmVycyBhcmUgbGltaXRlZCBpbiBzaXplIGFuZCBoZW5jZSB3ZSBvYnNlcnZlIHRo
ZSBJTyBoYW5nIGlmDQo+PiB0aGUgbGFyZ2UgSU9zIGFyZSBpc3N1ZWQuDQo+Pg0KPj4gSSBh
bSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMgQVBJJ3MgcmV0dXJuIHZhbHVlIGlzIGNvcnJlY3Qg
b3Igbm90IGluIHRoZQ0KPj4gWGVuIGVudmlyb25tZW50LiBJZiBpdCBpcyBjb3JyZWN0IHRo
ZW4gSSBoYXZlIHRvIG1vZGlmeSB0aGUgZHJpdmVyIHRvDQo+PiBub3QgdXNlIHRoaXMgQVBJ
IGFuZCBkaXJlY3RseSBzZXQgdGhlIERNQSBtYXNrIHRvIDY0IGJpdCBpZiB0aGUgc3lzdGVt
DQo+PiBpcyBhIDY0Yml0IG1hY2hpbmUuDQo+IA0KPiBQbGVhc2UgcmVjaGVjayB0aGUgYmFj
a3BvcnRlZCBwYXRjaCBpbiA1LjEwLnkuIEl0IGlzIF93cm9uZ18uIFRoZSBiYWNrcG9ydA0K
PiBoYXM6DQo+IA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvbXB0M3Nhcy9tcHQzc2FzX2Jhc2Uu
Yw0KPiArKysgYi9kcml2ZXJzL3Njc2kvbXB0M3Nhcy9tcHQzc2FzX2Jhc2UuYw0KPiBAQCAt
Mjk5Myw3ICsyOTkzLDcgQEAgX2Jhc2VfY29uZmlnX2RtYV9hZGRyZXNzaW5nKHN0cnVjdCBN
UFQzU0FTX0FEQVBURVIgKmlvYywgDQo+IHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiANCj4g
IMKgwqDCoMKgwqDCoMKgIGlmIChpb2MtPmlzX21jcHVfZW5kcG9pbnQgfHwNCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKGRtYV9hZGRyX3QpID09IDQgfHwgaW9jLT51c2Vf
MzJiaXRfZG1hIHx8DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfZ2V0X3JlcXVpcmVk
X21hc2soJnBkZXYtPmRldikgPD0gMzIpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFf
Z2V0X3JlcXVpcmVkX21hc2soJnBkZXYtPmRldikgPD0gRE1BX0JJVF9NQVNLKDMyKSkNCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb2MtPmRtYV9tYXNrID0gMzI7DQo+
ICDCoMKgwqDCoMKgwqDCoCAvKiBTZXQgNjMgYml0IERNQSBtYXNrIGZvciBhbGwgU0FTMyBh
bmQgU0FTMzUgY29udHJvbGxlcnMgKi8NCj4gIMKgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGlv
Yy0+aGJhX21waV92ZXJzaW9uX2JlbG9uZ2VkID4gTVBJMl9WRVJTSU9OKQ0KPiANCj4gV2hp
bGUgdGhlIHVwc3RyZWFtIHBhdGNoIGhhczoNCj4gDQo+ICvCoMKgwqDCoMKgwqAgaWYgKGlv
Yy0+aXNfbWNwdV9lbmRwb2ludCB8fCBzaXplb2YoZG1hX2FkZHJfdCkgPT0gNCB8fA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCZwZGV2LT5kZXYp
IDw9IDMyKSB7DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9jLT5kbWFf
bWFzayA9IDMyOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb2hlcmVudF9k
bWFfbWFzayA9IGRtYV9tYXNrID0gRE1BX0JJVF9NQVNLKDMyKTsNCg0KU29ycnkgZm9yIHRo
aXMgbWlzdGFrZSBvZiBtaW5lLCB3aGljaCBzZWVtcyB0byBoYXZlIGJlZW4gY2F1c2VkIGJ5
IGEgZ2l0DQppbmNvbnNpc3RlbmN5LCBhcyB0aGUgdXBzdHJlYW0gc291cmNlIGlzIHN0aWxs
IHNob3dpbmcgdGhlIGxpbmUNCg0KICAgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCZwZGV2LT5k
ZXYpIDw9IDMyDQoNCkkgZGlkbid0IGRvdWJsZSBjaGVjayB3aGljaCB1cHN0cmVhbSBwYXRj
aCB3YXMgcmVmZXJlbmNlZCBieSB0aGUgYmFja3BvcnQNCnBhdGNoLCBidXQgbG9va2VkIGF0
IHRoZSBvdXRwdXQgb2YgImdpdCBibGFtZSIgdG8gbG9vayBhdCB0aGUgbGFzdCBwYXRjaA0K
b2xkZXIgdGhhbiB0aGUgYmFja3BvcnQgY2hhbmdpbmcgdGhlIGxpbmUgaW4gcXVlc3Rpb24u
DQoNCkkgZGlkbid0IGV2ZW4gdGhpbmsgb2YgdGhlIHBvc3NpYmlsaXR5IHRoYXQgZ2l0IGNv
dWxkIGJlIHdyb25nLg0KDQoNCkp1ZXJnZW4NCg==
--------------riRNKW1nBDfZOTdj5zDjO7LH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------riRNKW1nBDfZOTdj5zDjO7LH--

--------------nM63vNz4QQMxJ1qOUEto0weU--

--------------8yuOl9h0grkLiTIM0SMWn7UE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNXhF4FAwAAAAAACgkQsN6d1ii/Ey+g
tgf8DuQqI6HCeB09SqhHX1fb3zsMHrAthxXwZ2ZKcIPPFCAk8J3Xh38yqqYNB2hzrNDYnaE1lVGq
RqDKSi8V1eb30EEyaLJ+m1Q7r4w1HmHhh7TvKQT7R7Mks/NhjjS2JY9eBXVtf70WT8rFHexv2H6v
TEfxeMIemy9+Fv/+JGE+k+YYdSqYnKyhswnP3nTglH10bJ3GDdPu4viK65nBxz0M4yBzFRbBJkfZ
vUoFuHq/Z/J+3UBUJu7+HfLTLMRfafilkmoLz7npAdHQA67yR2rU2prjqUAyYj5xMRoIJ6o0+MEl
R7aEREV+I3lt2VGVRgGMZMnM/82Nqt5+AJRGsoRSuQ==
=meIc
-----END PGP SIGNATURE-----

--------------8yuOl9h0grkLiTIM0SMWn7UE--
