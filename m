Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F46B3F15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCJMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCJMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:21:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1B111691;
        Fri, 10 Mar 2023 04:21:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2694F210DD;
        Fri, 10 Mar 2023 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678450913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txdMXazJe/w2RiTmqoGGAR5d1Z3iQQ5FZ0iN2ESM4fg=;
        b=lN9b2dVedKRNTqS8TafdVb3LDcVkPJjVcGjSiZWdKL3aKUAaYt2vPm1L8xKKy6OtNAW7lP
        T7N+0gVKnJl2qpRL1dc4OQRqdO6TCr0RaMKUt1EhWGSwKWHO95D4U5gRImZB8chhGvbJa/
        hs044rNmCXiFQ3dFlpspD4p4P9iYaxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678450913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txdMXazJe/w2RiTmqoGGAR5d1Z3iQQ5FZ0iN2ESM4fg=;
        b=8a5CKUXkJoMxzC0SRQBx2MRF2goHThVtixCEUQ55zH6KlBJJ8bxpH4CZhzEUyiA67z3jv7
        xCU3ynwC/RUbHZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B74F213592;
        Fri, 10 Mar 2023 12:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WtPPK+AgC2TeGwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 10 Mar 2023 12:21:52 +0000
Message-ID: <ae4c373b-1f85-4f85-6fe5-70676de72b54@suse.de>
Date:   Fri, 10 Mar 2023 13:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 061/101] fbdev/ps3fb: Duplicate video-mode option
 string
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     deller@gmx.de, timur@kernel.org, rdunlap@infradead.org,
        paulus@samba.org, benh@kernel.crashing.org, linux@armlinux.org.uk,
        pjones@redhat.com, adaplas@gmail.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230309160201.5163-1-tzimmermann@suse.de>
 <20230309160201.5163-62-tzimmermann@suse.de>
 <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------v1i3Wd0vXURbZ1IAGhQJGqSe"
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
--------------v1i3Wd0vXURbZ1IAGhQJGqSe
Content-Type: multipart/mixed; boundary="------------mvuyIrYfCE0BpCUjVgrXik22";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, timur@kernel.org, rdunlap@infradead.org, paulus@samba.org,
 benh@kernel.crashing.org, linux@armlinux.org.uk, pjones@redhat.com,
 adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
 mbroemme@libmpq.org, thomas@winischhofer.net,
 James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com, corbet@lwn.net, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <ae4c373b-1f85-4f85-6fe5-70676de72b54@suse.de>
Subject: Re: [PATCH v2 061/101] fbdev/ps3fb: Duplicate video-mode option
 string
References: <20230309160201.5163-1-tzimmermann@suse.de>
 <20230309160201.5163-62-tzimmermann@suse.de>
 <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>
In-Reply-To: <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>

--------------mvuyIrYfCE0BpCUjVgrXik22
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR2VlcnQNCg0KQW0gMTAuMDMuMjMgdW0gMDk6MTggc2NocmllYiBHZWVydCBVeXR0ZXJo
b2V2ZW46DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIFRodSwgTWFyIDksIDIwMjMgYXQgNTow
MuKAr1BNIFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPiB3cm90ZToN
Cj4+IEFzc3VtZSB0aGF0IHRoZSBkcml2ZXIgZG9lcyBub3Qgb3duIHRoZSBvcHRpb24gc3Ry
aW5nIG9yIGl0cyBzdWJzdHJpbmdzDQo+PiBhbmQgaGVuY2UgZHVwbGljYXRlIHRoZSBvcHRp
b24gc3RyaW5nIGZvciB0aGUgdmlkZW8gbW9kZS4gQWxsb2NhdGUgdGhlDQo+PiBjb3B5J3Mg
bWVtb3J5IHdpdGgga3N0cmR1cCgpIGFuZCBmcmVlIGl0IGluIHRoZSBtb2R1bGUncyBleGl0
IGZ1bmN0aW9uLg0KPj4NCj4+IERvbmUgaW4gcHJlcGFyYXRpb24gb2Ygc3dpdGNoaW5nIHRo
ZSBkcml2ZXIgdG8gc3RydWN0IG9wdGlvbl9pdGVyIGFuZA0KPj4gY29uc3RpZnlpbmcgdGhl
IG9wdGlvbiBzdHJpbmcuDQo+Pg0KPj4gdjI6DQo+PiAgICAgICAgICAqIHJlcGxhY2Ugc3Rh
dGljIG1lbW9yeSB3aXRoIGtzdHJkdXAoKS9rZnJlZSgpIChHZWVydCkNCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIHVwb2RhdGUhDQo+IA0KPj4gLS0tIGEvZHJpdmVycy92aWRl
by9mYmRldi9wczNmYi5jDQo+PiArKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3BzM2ZiLmMN
Cj4+IEBAIC0yNjAsNiArMjYwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmYl92aWRlb21v
ZGUgcHMzZmJfbW9kZWRiW10gPSB7DQo+PiAgIHN0YXRpYyBpbnQgcHMzZmJfbW9kZTsNCj4+
ICAgbW9kdWxlX3BhcmFtKHBzM2ZiX21vZGUsIGludCwgMCk7DQo+Pg0KPj4gK3N0YXRpYyBj
aGFyICptb2RlX29wdGlvbl9idWY7DQo+IA0KPiBEbyB5b3UgcmVhbGx5IG5lZWQgdGhpcyB2
YXJpYWJsZT8gSXQgY29udGFpbnMgdGhlIHNhbWUgdmFsdWUNCj4gYXMgbW9kZV9vcHRpb24g
YmVsb3cuDQo+IFRoaXMgaXMgYSBjb21tb24gcGF0dGVybiBpbiBzZXZlcmFsIHBhdGNoZXMu
DQoNCkluIG1vc3QgY2FzZXMsIHRoZSBleHRyYSB2YXJpYWJsZSBpcyBuZWNlc3NhcnkuIG1v
ZGVfb3B0aW9uLCBvciBhIA0Kc2ltaWxhciB2YXJpYWJsZSwgaXMgb2Z0ZW4gYWxzbyB1c2Vk
IHRvIHN0b3JlIG1vZHVsZSBwYXJhbWV0ZXJzIG9yIGlzIA0KaW5pdGlhbGl6ZWQgZnJvbSBh
IHN0YXRpYyBzdHJpbmcuIEluIHRob3NlIGNhc2VzIHdlIG9idmlvdXNseSBjYW5ub3QgDQpm
cmVlIHRoZSBtZW1vcnkuIEhlbmNlIHRoZSBhZGRpdGlvbmFsIHZhcmlhYmxlIGZvciB0aGUg
ZnJlZWluZyB0aGUgDQphbGxvY2F0aW9uLg0KDQpJIHJldmlld2VkIHRoZSBwYXRjaGVzIGFu
ZCBpdCBsb29rcyBsaWtlIGt5cm9mYiwgcHMzZmIsIGFuZCBzbTcxMmZiIA0KbWlnaHQgYmUg
YWJsZSB0byB3b3JrIHdpdGhvdXQgdGhlIF9idWYgdmFyaWFibGUuIEknbGwgdHJ5IHRvIHVw
ZGF0ZSB0aG9zZS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4+ICAgc3RhdGlj
IGNoYXIgKm1vZGVfb3B0aW9uOw0KPj4NCj4+ICAgc3RhdGljIGludCBwczNmYl9jbXBfbW9k
ZShjb25zdCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICp2bW9kZSwNCj4+IEBAIC0xMjc2LDggKzEy
NzcsMTEgQEAgc3RhdGljIGludCBfX2luaXQgcHMzZmJfc2V0dXAodm9pZCkNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICAgICAgICAgICAgICAgICAgaWYg
KCFzdHJuY21wKHRoaXNfb3B0LCAibW9kZToiLCA1KSkNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBwczNmYl9tb2RlID0gc2ltcGxlX3N0cnRvdWwodGhpc19vcHQgKyA1LCBOVUxM
LCAwKTsNCj4+IC0gICAgICAgICAgICAgICBlbHNlDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICBtb2RlX29wdGlvbiA9IHRoaXNfb3B0Ow0KPj4gKyAgICAgICAgICAgICAgIGVsc2Ug
ew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUobW9kZV9vcHRpb25fYnVmKTsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG1vZGVfb3B0aW9uX2J1ZiA9IGtzdHJkdXAo
dGhpc19vcHQsIEdGUF9LRVJORUwpOyAvLyBpZ25vcmUgZXJyb3JzDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBtb2RlX29wdGlvbiA9IG1vZGVfb3B0aW9uX2J1ZjsNCj4+ICsgICAg
ICAgICAgICAgICB9DQo+PiAgICAgICAgICB9DQo+PiAgICAgICAgICByZXR1cm4gMDsNCj4+
ICAgfQ0KPj4gQEAgLTEyOTQsNiArMTI5OCw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBwczNm
Yl9leGl0KHZvaWQpDQo+PiAgIHsNCj4+ICAgICAgICAgIHByX2RlYnVnKCIgLT4gJXM6JWRc
biIsIF9fZnVuY19fLCBfX0xJTkVfXyk7DQo+PiAgICAgICAgICBwczNfc3lzdGVtX2J1c19k
cml2ZXJfdW5yZWdpc3RlcigmcHMzZmJfZHJpdmVyKTsNCj4+ICsgICAgICAga2ZyZWUobW9k
ZV9vcHRpb25fYnVmKTsNCj4+ICAgICAgICAgIHByX2RlYnVnKCIgPC0gJXM6JWRcbiIsIF9f
ZnVuY19fLCBfX0xJTkVfXyk7DQo+PiAgIH0NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0K
PiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KDQotLSANClRob21h
cyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhy
ZXI6IEl2byBUb3Rldg0K

--------------mvuyIrYfCE0BpCUjVgrXik22--

--------------v1i3Wd0vXURbZ1IAGhQJGqSe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQLIN8FAwAAAAAACgkQlh/E3EQov+Cl
Sw/8DkbaRxbYZF4tRwk2SgRLqzsf1/7VfsDs2PGgIe6PP4dRU9IgltLU7JfbeWhTcvf547hlnzZm
+LmtYvWuqpWO9+EVuWHVe0IFwth7reC1erBwiMZ/H5vahmT7yEzoaPRdAQ1aP0CL9qydv2h8sPtv
+8x24ITUfFtME+44eZD+PlEmZct8vWAa0BQe3MdZKeCSdqlaRQzdsYHvydf5YCKwY+f1fZZWvOAh
DxAb/lC12MFlKQ6E9pK53ZiRzm9m5QZD6Zd+9zLEFb6ZqQv7c1r6RI/nU4y0OUYBjJ/tQNxmpGsC
7QZlYYGQ1hqvY81k67C/9ph4lNAmDtRT/KoCSJQaZ7XnpKJtXLx/sEqqogs80YbiXwLYtLFeF3CQ
K32XFQD7P+aAGX07tAZBonytJhSiunmTPvWwa9YENofnTN4ojFU5rMpWK7C/2ISBxJPVvNYxhHCV
SS8tAa1ZHE+O5/128WVYIvnfPA4lZWox5a7eRw9wJHLMB9bYaRDBsdfogYWBi1XnRWm/W43KxlBc
DlZ/BwqE3BNhZVj8T0YT/fBsNB4nUc2ByUNK3wi+RLr5UcWa3uULMN5bV9lC21A5pGaLzbu1KLrg
UqnmwX2P1kyaqMszwNAWf+beA/6iz5f/YOMuyfP6kd7S1XN3tIkadfkRJsrZ0etYvz43pZPOl5VN
NxI=
=o9Wi
-----END PGP SIGNATURE-----

--------------v1i3Wd0vXURbZ1IAGhQJGqSe--
