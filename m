Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A33693E28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBMGT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBMGTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:19:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80D8696
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:19:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52E4020543;
        Mon, 13 Feb 2023 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676269159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSir8/yt0gwWtzSakvPMsLeLv/PuS7hHLugwW/NeDkQ=;
        b=j4Gn67qSNIsOfWNiWXpj5Tq0UEFWOJfUqcoXU1ppb/MiWs4Kif9/gD8QFCa8+yWus4YfG1
        x9QiJMVN8DoMY++vnXlGzEp7ESOQZUqtUAsoQyB7IIe+5l3qqaEifsMsD5IUi28wudGPxg
        ZueBrAvdLXW1tR+sXdx6Fj5bbTeeAd4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09B391391B;
        Mon, 13 Feb 2023 06:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WqrsAGfW6WMgAgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:19:19 +0000
Message-ID: <469f2d34-7a14-b3c1-66d2-18557a9700a9@suse.com>
Date:   Mon, 13 Feb 2023 07:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-2-jgross@suse.com> <Y+dpJ5BY1gI9jaI2@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/8] x86/mtrr: split off physical address size
 calculation
In-Reply-To: <Y+dpJ5BY1gI9jaI2@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kenPgAdma3wW6x1tRWPCvhr1"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kenPgAdma3wW6x1tRWPCvhr1
Content-Type: multipart/mixed; boundary="------------TmK0nHV7x8coVHBuv0eX0xMP";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <469f2d34-7a14-b3c1-66d2-18557a9700a9@suse.com>
Subject: Re: [PATCH v2 1/8] x86/mtrr: split off physical address size
 calculation
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-2-jgross@suse.com> <Y+dpJ5BY1gI9jaI2@zn.tnic>
In-Reply-To: <Y+dpJ5BY1gI9jaI2@zn.tnic>

--------------TmK0nHV7x8coVHBuv0eX0xMP
Content-Type: multipart/mixed; boundary="------------1jgZrRFvRuV06C1HPzmoWM2j"

--------------1jgZrRFvRuV06C1HPzmoWM2j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDIuMjMgMTE6MDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBG
ZWIgMDksIDIwMjMgYXQgMDg6MjI6MTNBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEBAIC02NTQsNDIgKzYzOCw1NCBAQCB2b2lkIF9faW5pdCBtdHJyX2JwX2luaXQodm9p
ZCkNCj4+ICAgCQkJICAgIChib290X2NwdV9kYXRhLng4Nl9zdGVwcGluZyA9PSAweDMgfHwN
Cj4+ICAgCQkJICAgICBib290X2NwdV9kYXRhLng4Nl9zdGVwcGluZyA9PSAweDQpKQ0KPj4g
ICAJCQkJcGh5c19hZGRyID0gMzY7DQo+PiAtDQo+PiAtCQkJc2l6ZV9vcl9tYXNrID0gU0la
RV9PUl9NQVNLX0JJVFMocGh5c19hZGRyKTsNCj4+IC0JCQlzaXplX2FuZF9tYXNrID0gfnNp
emVfb3JfbWFzayAmIDB4ZmZmZmYwMDAwMFVMTDsNCj4+ICAgCQl9IGVsc2UgaWYgKGJvb3Rf
Y3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0NFTlRBVVIgJiYNCj4+ICAgCQkJ
ICAgYm9vdF9jcHVfZGF0YS54ODYgPT0gNikgew0KPj4gICAJCQkvKg0KPj4gICAJCQkgKiBW
SUEgQyogZmFtaWx5IGhhdmUgSW50ZWwgc3R5bGUgTVRSUnMsDQo+PiAgIAkJCSAqIGJ1dCBk
b24ndCBzdXBwb3J0IFBBRQ0KPj4gICAJCQkgKi8NCj4+IC0JCQlzaXplX29yX21hc2sgPSBT
SVpFX09SX01BU0tfQklUUygzMik7DQo+PiAtCQkJc2l6ZV9hbmRfbWFzayA9IDA7DQo+PiAg
IAkJCXBoeXNfYWRkciA9IDMyOw0KPj4gICAJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gKwlzaXpl
X29yX21hc2sgPSB+KCgxVUxMIDw8ICgocGh5c19hZGRyKSAtIFBBR0VfU0hJRlQpKSAtIDEp
Ow0KPiANCj4gVG9vIG1hbnkgYnJhY2tldHMgYmVjYXVzZSB5b3UndmUgdGFrZW4gdGhlIG1h
Y3JvIGFuZCBwdXQgaW4gdGhlIGFyZ3VtZW50DQo+IGRpcmVjdGx5Lg0KDQpPaCwgeWVzLg0K
DQo+IEluIGFueSBjYXNlLCByZXZpZXdpbmcgcGF0Y2hlcyB3aGljaCBkbyBjb2RlIG1vdmVt
ZW50ICphbmQqIGNoYW5nZXMgaW4NCj4gdGhlIHNhbWUgZGlmZiBpcyBhbHdheXMgdW5uZWNl
c3NhcmlseSBuYXN0eS4gUGxlYXNlIGRvIHRoZSBtZWNoYW5pY2FsDQo+IGNvZGUgbW92ZW1l
bnQgb25seSAtIGNsZWFudXBzIGNvbWUgb250b3AuDQoNCk9rYXkuDQoNCg0KSnVlcmdlbg0K

--------------1jgZrRFvRuV06C1HPzmoWM2j
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1jgZrRFvRuV06C1HPzmoWM2j--

--------------TmK0nHV7x8coVHBuv0eX0xMP--

--------------kenPgAdma3wW6x1tRWPCvhr1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp1mYFAwAAAAAACgkQsN6d1ii/Ey//
xwf/ZhFwv4EG9CCJXFbVHYPhiEGw6YDZJfgZI1YQWxtB4xBg2znGY3n+HAj2Q01WQa55Kj/QUp7o
xHObr0gUqIBUq0ZSiKlx8/61GaHEzPEsWGh6FID26VIzHZLmH3bMcvltHoKckGvwwwfUVEYWcdgc
2TvNGM5k8uJtEkNJGi9vcXYAaIvObOTfTpdOvqplje9YoIAoBso03pqIGipgzscY49K37HxRtXJE
7HY7DHzc/u8Gsepfv3L+UPWnoPeWXjtYFRmYOREcKlceDOVi1kiwLg+1N26pEt00k/ziNdVApcA0
gp+X3U3gDmbOLW9NuH9MmpVe5y89zGHEbRii59bGug==
=NxT9
-----END PGP SIGNATURE-----

--------------kenPgAdma3wW6x1tRWPCvhr1--
