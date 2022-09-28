Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A75EE1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiI1Qc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI1QcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:32:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B122284
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:32:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9896A1FA3B;
        Wed, 28 Sep 2022 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664382741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avuMj/GjAiWAqD95oSoKmVjHPWspt7PyvQByNGgpCKw=;
        b=ddaf34g91msQetgL8LBNHM2jDMS/zH8ESQt/AR0wtazTK2+6+lY6tjxzO/jgZA/ALU7XNf
        pzajwf0R7byrSQZH47YGHPJ2OSKo2NQQHYbW+IzQVecqQE79KPgYRKAYcrlWQ3m6K6QJr3
        +NeNJCFxq4ULepSmbgtlgwll8lNczVk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BD3813677;
        Wed, 28 Sep 2022 16:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dx+KFBV3NGNZKwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 16:32:21 +0000
Message-ID: <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
Date:   Wed, 28 Sep 2022 18:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com> <YzRyaLRqWd6YSgeJ@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YzRyaLRqWd6YSgeJ@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Qw47xpZy2e9ty4bWAzvZJ5v6"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Qw47xpZy2e9ty4bWAzvZJ5v6
Content-Type: multipart/mixed; boundary="------------SgMxD9WlHfYsoGKxfP7JRczD";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com> <YzRyaLRqWd6YSgeJ@zn.tnic>
In-Reply-To: <YzRyaLRqWd6YSgeJ@zn.tnic>

--------------SgMxD9WlHfYsoGKxfP7JRczD
Content-Type: multipart/mixed; boundary="------------39xnXyBXO94r7sm0Ta7XyWgv"

--------------39xnXyBXO94r7sm0Ta7XyWgv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMTg6MTIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBT
ZXAgMjgsIDIwMjIgYXQgMDM6NDM6NTZQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFdvdWxkIHlvdSBmZWVsIGJldHRlciB3aXRoIGFkZGluZyBhIG5ldyBlbnVtIG1lbWJl
ciBDUFVIUF9BUF9DQUNIRUNUUkxfT05MSU5FPw0KPj4NCj4+IFRoaXMgd291bGQgYXZvaWQg
YSBwb3NzaWJsZSBzb3VyY2Ugb2YgZmFpbHVyZSBkdXJpbmcgcmVzdW1lIGluIGNhc2Ugbm8g
c2xvdA0KPj4gZm9yIENQVUhQX0FQX09OTElORV9EWU4gaXMgZm91bmQgKHF1aXRlIGltcHJv
YmFibGUsIGJ1dCBpbiB0aGVvcnkgcG9zc2libGUpLg0KPiANCj4gTGV0J3Mga2VlcCB0aGF0
IGluIHRoZSBiYWcgZm9yIHRoZSB0aW1lIHdoZW4gd2UgZ2V0IHRvIGNyb3NzIHRoYXQgYnJp
ZGdlLg0KPiANCj4+IFlvdSB3b3VsZG4ndCB3YW50IHRvIGRvIHRoYXQgdGhlcmUsIGFzIHRo
ZXJlIGFyZSBtdWx0aXBsZSBwbGFjZXMgd2hlcmUNCj4+IHBtX3NsZWVwX2VuYWJsZV9zZWNv
bmRhcnlfY3B1cygpIGlzIGJlaW5nIGNhbGxlZC4NCj4gDQo+IFdlIHdhbnQgYWxsIG9mIHRo
ZW0sIEknZCBzYXkuIFRoZXkncmUgYWxsIHNvbWUgc29ydCBvZiBzdXNwZW5kIEFGQUlDVC4N
Cj4gQnV0IHllcywgaWYgd2UgZ2V0IHRvIGRvIGl0LCB0aGF0IHdvdWxkIG5lZWQgYSBwcm9w
ZXIgYXVkaXQuDQo+IA0KPj4gQWRkaXRpb25hbGx5IG5vdCBhbGwgY2FzZXMgYXJlIGNvbWlu
ZyBpbiB2aWENCj4+IHBtX3NsZWVwX2VuYWJsZV9zZWNvbmRhcnlfY3B1cygpLCBhcyB0aGVy
ZSBpcyBlLmcuIGEgY2FsbCBvZg0KPj4gc3VzcGVuZF9lbmFibGVfc2Vjb25kYXJ5X2NwdXMo
KSBmcm9tIGtlcm5lbF9rZXhlYygpLCB3aGljaCB3YW50cyB0bw0KPj4gaGF2ZSB0aGUgc2Ft
ZSBoYW5kbGluZy4NCj4gDQo+IFdoaWNoIG1lYW5zLCBtb3JlIGhhaXJ5Lg0KPiANCj4+IGFy
Y2hfdGhhd19zZWNvbmRhcnlfY3B1c19iZWdpbigpIGFuZCBhcmNoX3RoYXdfc2Vjb25kYXJ5
X2NwdXNfZW5kKCkgYXJlDQo+PiB0aGUgZnVuY3Rpb25zIHRvIG1hcmsgc3RhcnQgYW5kIGVu
ZCBvZiB0aGUgc3BlY2lhbCByZWdpb24gd2hlcmUgdGhlDQo+PiBkZWxheWVkIE1UUlIgc2V0
dXAgc2hvdWxkIGhhcHBlbi4NCj4gDQo+IFlhcCwgaXQgc2VlbXMgbGlrZSB0aGUgYmVzdCBz
b2x1dGlvbiBhdCB0aGUgbW9tZW50LiBXYW50IG1lIHRvIGRvIGENCj4gcHJvcGVyIHBhdGNo
IGFuZCB0ZXN0IGl0IG9uIHJlYWwgaHc/DQoNCkkgY2FuIGRvIHRoYXQuDQoNCg0KSnVlcmdl
bg0KDQo=
--------------39xnXyBXO94r7sm0Ta7XyWgv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------39xnXyBXO94r7sm0Ta7XyWgv--

--------------SgMxD9WlHfYsoGKxfP7JRczD--

--------------Qw47xpZy2e9ty4bWAzvZJ5v6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM0dxUFAwAAAAAACgkQsN6d1ii/Ey/S
8ggAjkI9Wmvj7KWjaTdCrsG2CBD6Ax98ew3PIY+ak8M8Av6JHgAB4qvilw40t6xH8pYLXK8ocGeD
r4rLjA1vFhFAWOTDjTHXK0aU5hyPdoyrAh5IPdrFZEvoaj1LU09BlYvrnH5cUEgZh7igRtV7BXhj
GaSbMFXwDtUwdHyhcqUowoahUVwvIkg/T8+P4ws6sqXkLf0r4cuv8hz42stqsPH77YOY0sF3WkXt
Ym2L6AkCExFNrvlbggER/LZP7Gfx6x67888byh7GVnakzm/EgraDul5z/igix3SZa042hFHGFmNa
DODxrcHWtp/oEHcxUCvmyBEGDN7hIrQEB0DKx+Px0g==
=TwA/
-----END PGP SIGNATURE-----

--------------Qw47xpZy2e9ty4bWAzvZJ5v6--
