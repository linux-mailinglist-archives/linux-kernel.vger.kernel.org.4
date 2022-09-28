Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997C5ED48E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiI1GRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI1GQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:16:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B01114FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:16:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A11D21E53;
        Wed, 28 Sep 2022 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664345814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bre+DACPL2mKV+lMG7Cg7u1j2iWJJkOeH2RR1YE7xeg=;
        b=DmXbcKp0Rggx7RChK7O6eERRyj7I7G1Qpg3ec/BUB6LVwPKqYSL+1W9eULnWrBiz3Y/b3Q
        pIUlFyiM282BKpxKF56geLUZ3JkQRU+8rU4gkdmwsC+zu2JLcrPKAdgd8owFYayD8LDPMx
        2fSiXEzfeoeizt/+R6n5j0PX2HZoBkw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 014C013A84;
        Wed, 28 Sep 2022 06:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D1a1OtXmM2NdHAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 06:16:53 +0000
Message-ID: <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
Date:   Wed, 28 Sep 2022 08:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com> <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com> <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com> <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
In-Reply-To: <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OyiQnYzmXwBUQx7SGaqrZO6w"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OyiQnYzmXwBUQx7SGaqrZO6w
Content-Type: multipart/mixed; boundary="------------HLeIqo78kA0MCawMBb4mVCdu";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com> <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com> <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com> <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
In-Reply-To: <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>

--------------HLeIqo78kA0MCawMBb4mVCdu
Content-Type: multipart/mixed; boundary="------------TfV3sPvPUEdgVZGQjT3iXMvs"

--------------TfV3sPvPUEdgVZGQjT3iXMvs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMDc6MzAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDI4LjA5LjIy
IDAxOjE2LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBUdWUsIFNlcCAyNywgMjAy
MiBhdCAwMjoyMToxN1BNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IFNvIHJl
cGxhY2luZyB0aGUgYm9vbCB3aXRoICIoc3lzdGVtX3N0YXRlICE9IFNZU1RFTV9SVU5OSU5H
KSIgaXMgZmluZQ0KPj4+IHdpdGggeW91IHJpZ2h0IG5vdz8gV2UgY2FuIGxhdGVyIHN3aXRj
aCB0aGF0IHRvIHRoZSAibW9yZSBlbGVnYW50Ig0KPj4+IHNvbHV0aW9uIHdoZW4gaXQgc2hv
d3MgdXAuDQo+Pg0KPj4gT2ssIEkgdGhpbmsgSSBoYXZlIHNvbWV0aGluZy4gQW5kIGl0IHdh
cyBzdGFyaW5nIG1lIHN0cmFpZ2h0IGluIHRoZQ0KPj4gZmFjZSBidXQgSSBkaWRuJ3Qgc2Vl
IGl0OiB0aGUgTVRSUiBjb2RlIG5lZWRzIGEgaG90cGx1ZyBub3RpZmllci4gSW4NCj4+IHRo
YXQgbm90aWZpZXIgaXQgY2FuIGRvIHRoZSBpbW1lZGlhdGUsIGkuZS4sIG5vbi1kZWxheWVk
IGluaXQgd2hpbGUgdGhlDQo+PiBkZWxheWVkIGluaXQgYmVjb21lcyB0aGUgZGVmYXVsdCwg
c2VlIGJlbG93Lg0KPj4NCj4+IEFuZCBpZ25vcmUgdGhlIHByX2luZm8gZGVidWdnaW5nIGd1
bmsgcGxzLg0KPj4NCj4+IG10cnJfYXBfaW5pdCgpIGJlY29tZXMgdGhlIG5vdGlmaWVyIGNh
bGxiYWNrLiBJdCBkb2Vzbid0IG5lZWQgdG8gYmUNCj4+IGNhbGxlZCBpbiBpZGVudGlmeV9z
ZWNvbmRhcnlfY3B1KCkgYW55bW9yZSBhcyBpbiB0aGUgaW5pdCBjYXNlIHRoYXQNCj4+IGZ1
bmN0aW9uIGRvZXNuJ3QgZG8gYW55dGhpbmcgLSBkZWxheWVkPXRydWUgLSBhbmQgaW4gdGhl
IGhvdHBsdWcgY2FzZQ0KPj4gdGhlIG5vdGlmaWVyIHJ1bnMuDQo+IA0KPiBBcmUgc3VyZSB0
aGUgaG90cGx1ZyBub3RpZmllciBkb2Vzbid0IGdldCBjYWxsZWQgaW4gdGhlIGJvb3QgYW5k
IGluIHRoZQ0KPiByZXN1bWUgY2FzZXM/IEkgZG9uJ3Qgc2VlIGhvdyB0aG9zZSBjYWxscyBh
cmUgYmVpbmcgbm90IGRvbmUgb3IgcmVzdWx0aW5nIGluDQo+IG5vdCBkb2luZyBhbnl0aGlu
Zy4NCg0KSW4gY2FzZSBteSBzdXNwaWNpb24gaXMgY29ycmVjdDogdGhpcyBjYW4gc3RpbGwg
YmUgc29sdmVkIGJ5IGFkZGluZyB0aGUNCmhvdHBsdWcgbm90aWZpZXIgb25seSBpbiBtdHJy
X2Fwc19pbml0KCksIGFuZCByZW1vdmluZyBpdCBhZ2FpbiBpbg0KYXJjaF90aGF3X3NlY29u
ZGFyeV9jcHVzX2JlZ2luKCkuDQoNCg0KSnVlcmdlbg0KDQo=
--------------TfV3sPvPUEdgVZGQjT3iXMvs
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TfV3sPvPUEdgVZGQjT3iXMvs--

--------------HLeIqo78kA0MCawMBb4mVCdu--

--------------OyiQnYzmXwBUQx7SGaqrZO6w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMz5tUFAwAAAAAACgkQsN6d1ii/Ey82
twgAhOoiZGhrh8PAUW4TmAIk4c94ArAo5sbdmO+5AeQ06eh9Kiq9lhx3W1gqc3Iq0/0JS1SuJ+6E
5hjtM0CHeJnHIRmXEB3uQS1cickhWk2J8yj58aiHy7EszYQ2qEuQAEvzpPksboOgOwnOpwouR5Rn
E9ISb0EXB6z3j0bUUBhk38VWI7lhUiZL3OQ+t5/aJJJlnX+pu+dsKxdfguEgRA6CBDidMWyC2Cf0
mONXin+UMkQ/2oRpmer7UrehkWo9baabcOa4vizyfdXRf233N2ejVdB3QdqKHPFQHhSGZDZ7jdnN
LerUx+0yZ/eiCehS19N+QulKR34lULiEzOIZihJWBw==
=ZU6t
-----END PGP SIGNATURE-----

--------------OyiQnYzmXwBUQx7SGaqrZO6w--
