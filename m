Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCF6E8C95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjDTIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDTIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:22:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C32230E9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:22:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30B031FDB3;
        Thu, 20 Apr 2023 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681978941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdKvbquDS/CsFW/uOkc8CFrMIK9VnKvKrkCFOHzW5RI=;
        b=dlVBXcVl8B/pcaD7A71rBnqMJN9vkgrah2P7dAayGomoNY7HBIiAG18RODlEvm+5RXjog1
        OHh1nmmyfQbk9wLDnKM/eyoBFRR/cMiIK0zrX7cZ6vKlxn1HP8pXQJ8zqseruyH0mV0LIK
        Mv4JTFj59xHF46s3FJc2mBwJxNrpGrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681978941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdKvbquDS/CsFW/uOkc8CFrMIK9VnKvKrkCFOHzW5RI=;
        b=mv1IhiG0Kbz6168AklnrIZ5mKoEe0Pslypx106poD5WpqWqC5/uJ9EHgR73s6CeTpfbuey
        kbwoBBOpaAnugPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 093781333C;
        Thu, 20 Apr 2023 08:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VYNgAT32QGSIawAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 20 Apr 2023 08:22:21 +0000
Message-ID: <a52e80e0-7fa4-ea5c-1bde-d84331908161@suse.de>
Date:   Thu, 20 Apr 2023 10:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] firmware/sysfb: Fix VESA format selection
Content-Language: en-US
To:     Pierre Asselin <pa@panix.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230419044834.10816-1-pa@panix.com>
 <26277a0c-abda-c13a-80bf-528b9e167c21@suse.de>
 <f201c5490b4c8001fd0599118aad4292.squirrel@mail.panix.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <f201c5490b4c8001fd0599118aad4292.squirrel@mail.panix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iS2qoFX12PhvnF02JhJa07g0"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iS2qoFX12PhvnF02JhJa07g0
Content-Type: multipart/mixed; boundary="------------N9B3qhjRtcc81E3I0I6ZkvSl";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Pierre Asselin <pa@panix.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <a52e80e0-7fa4-ea5c-1bde-d84331908161@suse.de>
Subject: Re: [PATCH v2] firmware/sysfb: Fix VESA format selection
References: <20230419044834.10816-1-pa@panix.com>
 <26277a0c-abda-c13a-80bf-528b9e167c21@suse.de>
 <f201c5490b4c8001fd0599118aad4292.squirrel@mail.panix.com>
In-Reply-To: <f201c5490b4c8001fd0599118aad4292.squirrel@mail.panix.com>

--------------N9B3qhjRtcc81E3I0I6ZkvSl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTkuMDQuMjMgdW0gMjI6Mjcgc2NocmllYiBQaWVycmUgQXNzZWxpbjoNCj4g
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4gQW0g
MTkuMDQuMjMgdW0gMDY6NDggc2NocmllYiBQaWVycmUgQXNzZWxpbjoNCj4+Pg0KPj4+IHYy
IGZpeGVzIHRoZSB3YXJuaW5ncyBmcm9tIGEgbWF4MygpIG1hY3JvIHdpdGggYXJndW1lbnRz
IG9mIGRpZmZlcmVudA0KPj4+IHR5cGVzOyAgc3BsaXQgdGhlIGJpdHNfcGVyX3BpeGVsIGFz
c2lnbm1lbnQgdG8gYXZvaWQgdWdseWZpbmcgdGhlIGNvZGUNCj4+PiB3aXRoIHRvbyBtYW55
IHR5cGVjYXN0cy4NCj4+DQo+PiBXaGF0IGV4YWN0bHkgd2FzIHRoYXQgd2FybmluZz8NCj4g
DQo+IEEgZnJpZW5kbHkgbm90ZSBmcm9tIGEgcm9ib3Q7IG1ha2UgVz0xIHN5c2ZiX3NpbXBs
ZWZiLm8gLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyMzA0MTgx
ODMzMjUuMjMyNy0xLXBhQHBhbml4LmNvbS9ULyNtMzhlODU5MzU0MzI5YWI5Zjc1NmRhOTFl
OTliNTQ2ZTNiMTQwZmE5MQ0KPiANCj4gDQo+PiBJIGxpa2VkIHRoZSBhbGwtaW4tb25lIGFz
c2lnbm1lbnQgb2YgdGhlIG9yaWdpbmFsIHBhdGNoLiBTbyBJJ2QgcmF0aGVyDQo+PiBnbyBi
YWNrIHRvIHYxIGFuZCBjb3B5IHNpLT5sZmJfZGVwdGggdG8gdGhlIGNvcnJlY3QgdHlwZSwg
bGlrZSB0aGlzOg0KPj4NCj4+ICAgICB1MzIgZGVwdGggPSBzaS0+bGZiX2RlcHRoOw0KPj4g
ICAgIGJpdHNfcGVyX3BpeGVsID0gbWF4MyhtYXgzKGNvbG9ycyksDQo+PiAgICAgCQkgICAg
ICAgIHJzdmQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlcHRoKTsNCj4gDQo+
IFdvdWxkIHRoYXQgd29yaz8gIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgbWF4MygpIGNo
ZWNrcyB0aGF0IGFsbCBhcmdzDQo+IGhhdmUgdGhlIHNhbWUgdHlwZS4gIHtyZWQsZ3JlZW4s
Ymx1ZSxyc3ZkfS57c2l6ZSxwb3N9IGFyZSBhbGwgdTggd2hpbGUNCj4gbGZiX2RlcHRoIGlz
IHUxNi4gIFRoZSBiZXN0IEkgY2FuIGRvIGlzDQoNCk1heWJlIG1ha2UgdGhlIGRlcHRoIHZh
cmlhYmxlIGEgdTggdGhlbiB3aXRoIGEgY2xhbXBfdCgpLWJhc2VkIGNhc3QgdGhlcmU6DQoN
CiAgIHU4IGRlcHRoID0gY2xhbXBfdCh1OCwgc2ktPmxmYl9kZXB0aCwgMSwgMzIpOw0KDQpU
aGVyZSdzIGN1cnJlbnRseSBubyB3YXkgdGhhdCBsZmJfZGVwdGggd291bGQgYmUgb3V0c2lk
ZSB0aGUgWzEsIDMyXSByYW5nZS4NCg0KPiANCj4gICAgICBiaXRzX3Blcl9waXhlbCA9IG1h
eDMoKHUxNiltYXgzKHNpLT5yZWRfc2l6ZSArIHNpLT5yZWRfcG9zLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ktPmdyZWVuX3NpemUgKyBzaS0+Z3JlZW5f
cG9zLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ktPmJsdWVf
c2l6ZSArIHNpLT5ibHVlX3BvcyksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1
MTYpKHNpLT5yc3ZkX3NpemUgKyBzaS0+cnN2ZF9wb3MpLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaS0+bGZiX2RlcHRoKTsNCj4gDQo+IFRoYXQgY29tcGlsZXMgcXVpZXRs
eSB3aXRoIFc9MSBidXQgdGhvc2UgdHdvIGNhc3RzIGFyZSB1Z2x5Lg0KPiBJZiBJIGRvIHRo
YXQsIHdvdWxkIEsmUi1vbi1wYXJlbnRoZXNlcyByZWFkIGJldHRlciA/DQo+IA0KPiAgICAg
IGJpdHNfcGVyX3BpeGVsID0gbWF4MygNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
KHUxNiltYXgzKA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpLT5y
ZWRfc2l6ZSArIHNpLT5yZWRfcG9zLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpLT5ncmVlbl9zaXplICsgc2ktPmdyZWVuX3BvcywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaS0+Ymx1ZV9zaXplICsgc2ktPmJsdWVfcG9zDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICksDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICh1MTYpKHNpLT5yc3ZkX3NpemUgKyBzaS0+cnN2ZF9wb3MpLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaS0+bGZiX2RlcHRoDQo+ICAgICAgICAgICAgICAgICAg
ICAgICApOw0KPiANCj4gSSB0aGluayBpdCdzIGNsZWFyZXIsIGJ1dCBub3Qga2VybmVsIHN0
eWxlIGFuZCBzdGlsbCB1Z2x5Lg0KPiANCj4+IE9yLCBpZiB5b3Ugd2FudCB0byBnZXQgZmFu
Y3ksIHlvdSBjb3VsZCBhZGQgbWF4M190KCkgdG8gPGxpbnV4L21pbm1heC5oPg0KPj4NCj4+
ICAgICAjZGVmaW5lIG1heDNfdCh0eXBlLCB4LCB5LCB6KSAgIG1heF90KHR5cGUsIG1heF90
KHR5cGUsIHgsIHkpLCB6KQ0KPj4NCj4+IGFuZCBkbw0KPj4NCj4+ICAgICBiaXRzX3Blcl9w
aXhlbCA9IG1heDNfdCh1MzIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4
Myhjb2xvcnMpLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJzdmQsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ktPmxmYl9kZXB0aCkNCj4+DQo+PiBZb3Ug
Y291bGQgYWxzbyBhZGQgYSBtYXg0X3QodHlwZSwgeCwgeSwgeiwgdykgdG8gPGxpbnV4L21p
bm1heC5oPiBhbmQNCj4+IGNvbXBhcmUgYWxsIHZhbHVlcyB3aXRoIG1heDRfdCgpLg0KPiAN
Cj4gVGhhdCB3b3VsZCBiZSBhIHR3by1wYXRjaCBzZXJpZXMuICBJJ2QgcmF0aGVyIGtlZXAg
aXQgdG8gdGhlIHN0cmljdA0KPiBtaW5pbXVtIHRoYXQgZml4ZXMgdGhlIHJlZ3Jlc3Npb24u
ICAoWW91IHRydXN0IG1lIHRvIGV2ZW4gKmxvb2sqIGF0IGENCj4ga2VybmVsIGhlYWRlciBh
bmQgbm90IGJyZWFrIGl0ID8gIERhbmdlcm91cyBhc3N1bXB0aW9uISkNCj4gDQo+IEknbSBu
ZXcgYXQgdGhpcy4gIFR3byBtb250aHMgYWdvIEkgZGlkbid0IGtub3cgd2hhdCB0byB0eXBl
IGEgdGhlDQo+IGNvbW1hbmQgbGluZSBhZnRlciAiZ2l0Ii4NCg0KV2VsY29tZSB0byB0aGUg
a2VybmVsIGNvbW11bml0eS4gOikNCg0KPiANCj4gSW5jaWRlbnRhbGx5LCBzaG91bGQgSSBz
ZW5kIHYzIGFzIGEgbmV3IGVtYWlsIG9yIHJlcGx5IHRvIHRoZSBjaGFpbj8NCg0KQXMgYSBu
ZXcgbWFpbCwgcGxlYXNlLiBJdCdzIGVhc2llciBmb3IgcmVhZGVycyBhbmQgdG9vbHMuDQoN
CkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IC0tUEENCj4gDQoNCi0tIA0KVGhvbWFz
IFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVy
bmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1j
RG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------N9B3qhjRtcc81E3I0I6ZkvSl--

--------------iS2qoFX12PhvnF02JhJa07g0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRA9jwFAwAAAAAACgkQlh/E3EQov+CH
eBAAm8tn0LmnjvWIo4rIrnAyV2DIJQNDQ9MPHik6qDavQKTvey7QKJCAYjYeD5ytnxN8DTKJ3S/h
bdU8T2/fO0c/VLkCeTpiEoDqme89LOw1OOrtNbIjZ5BsoxzO4xa/WEFmHdFTduyQ1tgsotB0FTwS
jOSru3hFW5pagAVPyUoO/ATYdAc3yYrqE+FdUbKviwHXYRZOV6GizAMW8XrbgFqXqUxM14BmF5xf
GSOe1NCKbPFMg8Lq2o9a3es5Bya5k16l0fQGdTjkF/4xDkxVG/6Gm3IUipSyUIBOk0W78R3uAqCr
chaEnMwSdYLk0dvycjdfQIRe2IGY+iGN4N8jKaTBiOscnt7fMf3I1V08oquHdtbWOyTg5yMh1TgL
IbEOA4nxiD81JX7XksudR9EXywALN6/hSXhCFeByB8wYLLLG+z/7hjTBrhAHshdibml9W5A/Uh3T
xd0xD36tavRnI/ilXAwPu6CVVQt0ymtSvubiSNUvjJr7qk2Ilg5W9YHWpzQbu3A0sRtOScbrMVWG
rDSdFe/Q2UU8mxtL8ptWEJAtnQochytJD3XYDYkkXZMckJg0W5o7dEK3YYq/3Vd+kUvgwGsS0qC/
oxobL4OBS7Dd4zDQezLmGeWQJ/yC3ufEA5ALuT66bFhYplKysC7vqFPqll3AYNmodwxoJwiGKy/O
6AY=
=+7px
-----END PGP SIGNATURE-----

--------------iS2qoFX12PhvnF02JhJa07g0--
