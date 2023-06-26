Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2057073D8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFZH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFZH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:56:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90141AC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:56:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00FDB218B0;
        Mon, 26 Jun 2023 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687766194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDMEcMqr7gQqX0LbHuLFjSeOaDzf9Kz/97P7WhlcQrs=;
        b=UGh5/5JcQh2mGnG7LUh3tarHogrLvdg5EM6I96IQmFOZTRNO8rkv7+WU9hG8Zrm4rGg081
        1Q6iOuefKIfoHch5ZlDyRTfsDW2S2SGPcla4f7UY1kc4MBO7R7JWSbeigeao9Lb6kXpCEo
        602SqN357IRmgZX2F391iUEWSuDafH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687766194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDMEcMqr7gQqX0LbHuLFjSeOaDzf9Kz/97P7WhlcQrs=;
        b=z5qdRoVfJK4KFp1iFn/qBXHdLamutcDN8f6AjNyPZRsGgBAubnRa1+j4AOdR0x/kya2hym
        Itc150/194PiFeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CE161391D;
        Mon, 26 Jun 2023 07:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bndXE7BEmWRtRQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 26 Jun 2023 07:56:32 +0000
Message-ID: <4672fc8d-ca95-6d00-1303-cb5968c51703@suse.de>
Date:   Mon, 26 Jun 2023 09:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm: Remove the deprecated drm_put_dev() function
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
References: <20230625050901.393055-1-suijingfeng@loongson.cn>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230625050901.393055-1-suijingfeng@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JFdSLqXHt9O0c0JRuXjClnvM"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JFdSLqXHt9O0c0JRuXjClnvM
Content-Type: multipart/mixed; boundary="------------2RkDms0vhUG72IC1rRbOoqhG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <suijingfeng@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Message-ID: <4672fc8d-ca95-6d00-1303-cb5968c51703@suse.de>
Subject: Re: [PATCH] drm: Remove the deprecated drm_put_dev() function
References: <20230625050901.393055-1-suijingfeng@loongson.cn>
In-Reply-To: <20230625050901.393055-1-suijingfeng@loongson.cn>

--------------2RkDms0vhUG72IC1rRbOoqhG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjUuMDYuMjMgdW0gMDc6MDkgc2NocmllYiBTdWkgSmluZ2Zlbmc6DQo+IEFz
IHRoaXMgZnVuY3Rpb24gY2FuIGJlIHJlcGxhY2VkIHdpdGggZHJtX2Rldl91bnJlZ2lzdGVy
KCkgKyBkcm1fZGV2X3B1dCgpLA0KPiBpdCBpcyBhbHJlYWR5IG1hcmtlZCBhcyBkZXByZWNh
dGVkLCBzbyByZW1vdmUgaXQuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU3VpIEppbmdmZW5nIDxzdWlqaW5nZmVuZ0Bsb29uZ3Nvbi5jbj4NCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9kcnYuYyAgICAgICAgICAgfCAyOCAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9wY2kuYyAg
ICAgICAgICAgfCAgMyArKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuYyB8ICAzICsrLQ0KPiAgIGluY2x1ZGUvZHJtL2RybV9kcnYuaCAgICAgICAgICAgICAg
IHwgIDEgLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzMSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2Rydi5j
IGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcnYuYw0KPiBpbmRleCAxMjY4N2RkOWUxYWMuLjUw
NTczMDdmZTIyYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcnYuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2Rydi5jDQo+IEBAIC00MDYsMzQgKzQwNiw2
IEBAIHZvaWQgZHJtX21pbm9yX3JlbGVhc2Uoc3RydWN0IGRybV9taW5vciAqbWlub3IpDQo+
ICAgICogcG9zc2libHkgbGVhdmluZyB0aGUgaGFyZHdhcmUgZW5hYmxlZC4NCj4gICAgKi8N
Cj4gICANCj4gLS8qKg0KPiAtICogZHJtX3B1dF9kZXYgLSBVbnJlZ2lzdGVyIGFuZCByZWxl
YXNlIGEgRFJNIGRldmljZQ0KPiAtICogQGRldjogRFJNIGRldmljZQ0KPiAtICoNCj4gLSAq
IENhbGxlZCBhdCBtb2R1bGUgdW5sb2FkIHRpbWUgb3Igd2hlbiBhIFBDSSBkZXZpY2UgaXMg
dW5wbHVnZ2VkLg0KPiAtICoNCj4gLSAqIENsZWFucyB1cCBhbGwgRFJNIGRldmljZSwgY2Fs
bGluZyBkcm1fbGFzdGNsb3NlKCkuDQo+IC0gKg0KPiAtICogTm90ZTogVXNlIG9mIHRoaXMg
ZnVuY3Rpb24gaXMgZGVwcmVjYXRlZC4gSXQgd2lsbCBldmVudHVhbGx5IGdvIGF3YXkNCj4g
LSAqIGNvbXBsZXRlbHkuICBQbGVhc2UgdXNlIGRybV9kZXZfdW5yZWdpc3RlcigpIGFuZCBk
cm1fZGV2X3B1dCgpIGV4cGxpY2l0bHkNCj4gLSAqIGluc3RlYWQgdG8gbWFrZSBzdXJlIHRo
YXQgdGhlIGRldmljZSBpc24ndCB1c2Vyc3BhY2UgYWNjZXNzaWJsZSBhbnkgbW9yZQ0KPiAt
ICogd2hpbGUgdGVhcmRvd24gaXMgaW4gcHJvZ3Jlc3MsIGVuc3VyaW5nIHRoYXQgdXNlcnNw
YWNlIGNhbid0IGFjY2VzcyBhbg0KPiAtICogaW5jb25zaXN0ZW50IHN0YXRlLg0KPiAtICov
DQo+IC12b2lkIGRybV9wdXRfZGV2KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpDQo+IC17DQo+
IC0JRFJNX0RFQlVHKCJcbiIpOw0KPiAtDQo+IC0JaWYgKCFkZXYpIHsNCj4gLQkJRFJNX0VS
Uk9SKCJjbGVhbnVwIGNhbGxlZCBubyBkZXZcbiIpOw0KPiAtCQlyZXR1cm47DQo+IC0JfQ0K
PiAtDQo+IC0JZHJtX2Rldl91bnJlZ2lzdGVyKGRldik7DQo+IC0JZHJtX2Rldl9wdXQoZGV2
KTsNCj4gLX0NCj4gLUVYUE9SVF9TWU1CT0woZHJtX3B1dF9kZXYpOw0KPiAtDQo+ICAgLyoq
DQo+ICAgICogZHJtX2Rldl9lbnRlciAtIEVudGVyIGRldmljZSBjcml0aWNhbCBzZWN0aW9u
DQo+ICAgICogQGRldjogRFJNIGRldmljZQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9wY2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fcGNpLmMNCj4gaW5kZXggMzlk
MzVmYzNhNDNiLi5iM2E2OGE5MmVhYTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fcGNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9wY2kuYw0KPiBAQCAt
MjU3LDcgKzI1Nyw4IEBAIHZvaWQgZHJtX2xlZ2FjeV9wY2lfZXhpdChjb25zdCBzdHJ1Y3Qg
ZHJtX2RyaXZlciAqZHJpdmVyLA0KPiAgIAkJCQkJIGxlZ2FjeV9kZXZfbGlzdCkgew0KPiAg
IAkJCWlmIChkZXYtPmRyaXZlciA9PSBkcml2ZXIpIHsNCj4gICAJCQkJbGlzdF9kZWwoJmRl
di0+bGVnYWN5X2Rldl9saXN0KTsNCj4gLQkJCQlkcm1fcHV0X2RldihkZXYpOw0KPiArCQkJ
CWRybV9kZXZfdW5yZWdpc3RlcihkZXYpOw0KPiArCQkJCWRybV9kZXZfcHV0KGRldik7DQo+
ICAgCQkJfQ0KPiAgIAkJfQ0KPiAgIAkJbXV0ZXhfdW5sb2NrKCZsZWdhY3lfZGV2X2xpc3Rf
bG9jayk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jDQo+IGluZGV4IGU0
Mzc0ODE0ZjBlZi4uYTQ5NTVhZTEwNjU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kcnYuYw0KPiBAQCAtMzU3LDcgKzM1Nyw4IEBAIHJhZGVvbl9wY2lfcmVtb3Zl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiAgIHsNCj4gICAJc3RydWN0IGRybV9kZXZpY2Ug
KmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gICANCj4gLQlkcm1fcHV0X2Rldihk
ZXYpOw0KDQpEaWQgeW91IHZlcmlmeSB0aGF0IGRldiBjYW5ub3QgYmUgTlVMTCBoZXJlPyBU
aGVyZSB3YXMgYSBjaGVjayBpbiANCmRybV9wdXRfZGV2KCkgZm9yICFkZXYuDQoNCkJlc3Qg
cmVnYXJkcw0KVGhvbWFzDQoNCj4gKwlkcm1fZGV2X3VucmVnaXN0ZXIoZGV2KTsNCj4gKwlk
cm1fZGV2X3B1dChkZXYpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZA0KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2Rydi5oIGIvaW5jbHVkZS9kcm0vZHJtX2Rydi5o
DQo+IGluZGV4IDg5ZTI3MDZjYWM1Ni4uMjg5Yzk3YjEyZTgyIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2RybS9kcm1fZHJ2LmgNCj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2Rydi5oDQo+
IEBAIC01MTEsNyArNTExLDYgQEAgdm9pZCBkcm1fZGV2X3VucmVnaXN0ZXIoc3RydWN0IGRy
bV9kZXZpY2UgKmRldik7DQo+ICAgDQo+ICAgdm9pZCBkcm1fZGV2X2dldChzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2KTsNCj4gICB2b2lkIGRybV9kZXZfcHV0KHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYpOw0KPiAtdm9pZCBkcm1fcHV0X2RldihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KTsN
Cj4gICBib29sIGRybV9kZXZfZW50ZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgaW50ICpp
ZHgpOw0KPiAgIHZvaWQgZHJtX2Rldl9leGl0KGludCBpZHgpOw0KPiAgIHZvaWQgZHJtX2Rl
dl91bnBsdWcoc3RydWN0IGRybV9kZXZpY2UgKmRldik7DQoNCi0tIA0KVGhvbWFzIFppbW1l
cm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcs
IEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxk
LCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------2RkDms0vhUG72IC1rRbOoqhG--

--------------JFdSLqXHt9O0c0JRuXjClnvM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSZRK4FAwAAAAAACgkQlh/E3EQov+C2
3w//a8HjDztWC5ghdQzorI4Op+HxBhyun2Wvs5zvAiXYiySPhgSIhpm5BUidLJzFgw90r07Ttmrn
XL8wGIMHyvg5id986W8ldTflDcuhEvxPVTi/nQWsfBh6bEjmKbo2wO5pIOPtuv6qpOMFXDwkpBhF
uJwhLGMFaznNI4ImEh116qJpqMLYEcOJpOhPCdPTbwxfq2I42OF/DCvcWxMKKgk1skJb7kDuoGrx
gLz0yA7EyN+iuTEKu0LysoJvGQ2DkHQsAhrLKMFHUCanWWJ/EwdrMLm8A74fZLXTWn92tY1lMsb8
HJSEklK/YSQcxCUaID9VNX8bVDoabVJYZH4XgmD0ZzpphS+tHFzc/ydEm+xifmq67IPOQ6wl5wCw
JvE+o/cs2jzJaC7Pj7n17BUmqGntGCPI+hW+2D8jme6sDxFyYUnN1m2QRe8PfXCgKZl377WgqDRF
gFL7DKwrSrjuryu0mWKc8YsEJahiXg9YGTlEcEQly6HJfpCfr0RMfylO3OdYv3KiRgmekT9h8isz
cZPKq8VwJC/sSlIWTnvTel0/SlpuQp7pnujcgy4B5epxq5byvkQ5ymJzD7/nsDdZfjBfJ7z80d2a
K6a42oi8jTtebNOEHKmcx0ABs8+43j5e4tIbBfrY44JRwsYjKZJR91oFVTAALh8UCPuNxAOC/Xah
B9Y=
=m6lP
-----END PGP SIGNATURE-----

--------------JFdSLqXHt9O0c0JRuXjClnvM--
