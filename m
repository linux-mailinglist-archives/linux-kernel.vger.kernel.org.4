Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0413267770C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjAWJHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjAWJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:07:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB01C33D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:07:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D703E3369B;
        Mon, 23 Jan 2023 09:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674464837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqIdmqDHu5lFw+I1bu61tqy0auXjE2ZRRFUiRmSC9UU=;
        b=ZJcVqFjmIkdh86VEX3Bu0Ep5+ZUYHT05GgskJytKUFcF9tzKFAkACN58sfiz7Fdxzf2O0c
        xc0SjoVorO5bqjy2pPN1P9t1ltv2W+T7VpFzTagNRAR+ekIuTzw2cEMJ42337gXVkzLvrN
        JwUA4b+y7ZUHcjFBiJzQfbfmGDHfKJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674464837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqIdmqDHu5lFw+I1bu61tqy0auXjE2ZRRFUiRmSC9UU=;
        b=+0yxH0dvCgQacflrSVN5PhUGM9dN0umtjpX3hGMaqsh20PAB84Dh9f7IAQ0S0Mji4SoORh
        BmWOO4WbmsN0GcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C32F01357F;
        Mon, 23 Jan 2023 09:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8fyXLkVOzmNNagAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 23 Jan 2023 09:07:17 +0000
Message-ID: <e0637ab4-5165-6aa9-e85c-7b451db4c598@suse.de>
Date:   Mon, 23 Jan 2023 10:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Removal of mga driver from Linux 6.3
Content-Language: en-US
To:     Chris Rankin <rankincj@gmail.com>, daniel@ffwll.ch
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAK2bqVK1s2BLcR+HOnTn=i9s60GsREnVXWz2T9uUjYfQawUH9w@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAK2bqVK1s2BLcR+HOnTn=i9s60GsREnVXWz2T9uUjYfQawUH9w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DpyR0FzmlQZLup4nDfEtrH6T"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DpyR0FzmlQZLup4nDfEtrH6T
Content-Type: multipart/mixed; boundary="------------LMUb6yo1TSLaWsvuxrXzTRPU";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Chris Rankin <rankincj@gmail.com>, daniel@ffwll.ch
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <e0637ab4-5165-6aa9-e85c-7b451db4c598@suse.de>
Subject: Re: Removal of mga driver from Linux 6.3
References: <CAK2bqVK1s2BLcR+HOnTn=i9s60GsREnVXWz2T9uUjYfQawUH9w@mail.gmail.com>
In-Reply-To: <CAK2bqVK1s2BLcR+HOnTn=i9s60GsREnVXWz2T9uUjYfQawUH9w@mail.gmail.com>

--------------LMUb6yo1TSLaWsvuxrXzTRPU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjEuMDEuMjMgdW0gMjM6Mjggc2NocmllYiBDaHJpcyBSYW5raW46DQo+IEhp
LA0KPiANCj4gV2l0aCByZWZlcmVuY2UgdG8gdGhlIHJlY2VudCBkZWxldGlvbiBvZiB0aGUg
bWdhIGRyaXZlciBmcm9tIExpbnV4IDYuMzoNCj4gDQo+IEkgYWN0dWFsbHkgb3duIGFuIG9s
ZCBtYWNoaW5lIHRoYXQgc3RpbGwgY29udGFpbnMgYSBNYXRyb3ggTWlsbGVuaXVtIElJIA0K
PiBncmFwaGljcyBjYXJkLiBUaGlzIG1hY2hpbmUgaGFzIG5vdCBydW4gWCBmb3Igc2V2ZXJh
bCB5b25rcywgYW5kIHNvIHRoZSANCj4gbG9zcyBvZiBEUk0gc3VwcG9ydCBkb2Vzbid0IGNv
bmNlcm4gbWUuDQo+IA0KPiBXaGF0IHdvdWxkIGNvbmNlcm4gbWUgd291bGQgYmUgbG9zaW5n
IHRoZSBncmFwaGljcyBmcmFtZSBidWZmZXIgZGV2aWNlIA0KPiAobWF0cm94ZmIpLCBiZWNh
dXNlIGEgVkdBIGNvbnNvbGUgaXMganVzdCB0b28gc21hbGw7DQoNCk5vIHdvcnJpZXMuIFRo
ZSBtYXRyb3hmYiBkcml2ZXIgaXMgc3RpbGwgdGhlcmUgYW5kIHdpbGwgcmVtYWluLiBFdmVu
IA0KWG9yZyBzaG91bGQgd29yayBpbiBwcmluY2lwbGUuDQoNCldoYXQgaGFzIGJlZW4gcmVt
b3ZlZCBpcyB0aGUga2VybmVsIHNpZGUgZm9yIDNkIHN1cHBvcnQuIEJ1dCB0aGlzIGhhcyAN
CmJlZW4gbm9uLWZ1bmN0aW9uYWwgYW55d2F5LCBhcyB0aGUgcnNwIGNvZGUgaW4gTWVzYSBo
YWQgYmVlbiByZW1vdmVkIA0KbG9uZyBhZ28uDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoN
Cj4gDQo+IENPTkZJR19GQl9NQVRST1g9eQ0KPiBDT05GSUdfRkJfTUFUUk9YX01JTExFTklV
TT15DQo+ICMgQ09ORklHX0ZCX01BVFJPWF9NWVNUSVFVRSBpcyBub3Qgc2V0DQo+ICMgQ09O
RklHX0ZCX01BVFJPWF9HIGlzIG5vdCBzZXQNCj4gQ09ORklHX0ZCX01BVFJPWF9JMkM9eQ0K
PiANCj4gQ2hlZXJzLA0KPiBDaHJpcw0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0K
R3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihI
UkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYN
Cg==

--------------LMUb6yo1TSLaWsvuxrXzTRPU--

--------------DpyR0FzmlQZLup4nDfEtrH6T
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPOTkUFAwAAAAAACgkQlh/E3EQov+CM
7hAAidSiJjIGiBuHrzVuWXLfyAw37fn8vI/kblE7TW+9Vb5uwj9LZEt8IQFWYJw3KSnCFcfguC7t
2CXRgWP3fZA7Svgz9hdXCmal8qmz7+CxQmm2ZHth7LxPzFyH4BS3r11jKnxm2izDDojNmtiVwUOt
XUUyGVr/kEaBtb4L8qY0tyUY8tHf8+hJA09H6oiK9ih36kHzanZYpknDnRXr6Fd8xVV4iEwAZYkZ
Q7+DsPdKCkHsIRChqmjXIH1oLM/WwB46Kgw6tgKSVwZG9ltFsUl2Sgp22kh23gUuYTIqUhmltbOd
BRBxaMXiORGihD4caCv4KYT32vUnGzbWI467nYQEYQo9ZhuTHd8B1i7dkdOXH5lJ1iy2eLcPnRvJ
zhinALJjQpOwGNkuFnreN9oOmPo/Vkyu6hCxnN2qFINFoPCsm+CFJIMfHeHrUGpcleyltd6qqZoj
X5zkSOqIU5YMlBOq9jHPHw/e/Ff66uHNT8GG88KL1O7jUEDB8lJMhiODQ3F5OeUka2bNK4DVGkxE
P3m/KvYyZhrxbiBRFx2vsfiecR/7Y3BsWxDmqZEamAgQt901lX6HYW+O6jUvKYdI1Z+qUfX9EFaI
kqXvu2XgryOYRdx4xMqnneUVEX7YSuwYRO0kiuEF4ewRUqMQAQWbrBT6vXSNMfxNKty/R2CiOEyi
u0Q=
=TyHg
-----END PGP SIGNATURE-----

--------------DpyR0FzmlQZLup4nDfEtrH6T--
