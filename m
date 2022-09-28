Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCD5ED43F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiI1Faa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI1FaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:30:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B31CFBB2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:30:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 543F221A74;
        Wed, 28 Sep 2022 05:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664343021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=591slOQocz3ngdqtE3H7RHke8TQLSdgTdQjqzUWhzjM=;
        b=K0P/PNW3DKSGCZCpgbRsy8D1JwHUvAxabYOMVJg3c0fzW9YLR3NCMW97cNjDhVALZbWdLz
        bX9DrdoF14c7Mp0FKkdUfydPc/CIHyj+ECt3wIgZhzRpepq+MBm0fCeMBl66Oz9DD2eVeV
        hCn6/JiGDpCE9+8dM9ImJLusWyZe4x0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DACB13677;
        Wed, 28 Sep 2022 05:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qk77Be3bM2OoCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 05:30:21 +0000
Message-ID: <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
Date:   Wed, 28 Sep 2022 07:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
In-Reply-To: <YzOEYsqM0UEsiFuS@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pApUDlOPKOM3yi0arxqoORwb"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pApUDlOPKOM3yi0arxqoORwb
Content-Type: multipart/mixed; boundary="------------nOdhPYwk0z37KeDD2mybzqmO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com> <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com> <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com> <YzOEYsqM0UEsiFuS@zn.tnic>
In-Reply-To: <YzOEYsqM0UEsiFuS@zn.tnic>

--------------nOdhPYwk0z37KeDD2mybzqmO
Content-Type: multipart/mixed; boundary="------------0PIhfvS50QHBH0ohTlAHXzC0"

--------------0PIhfvS50QHBH0ohTlAHXzC0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMDE6MTYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBT
ZXAgMjcsIDIwMjIgYXQgMDI6MjE6MTdQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFNvIHJlcGxhY2luZyB0aGUgYm9vbCB3aXRoICIoc3lzdGVtX3N0YXRlICE9IFNZU1RF
TV9SVU5OSU5HKSIgaXMgZmluZQ0KPj4gd2l0aCB5b3UgcmlnaHQgbm93PyBXZSBjYW4gbGF0
ZXIgc3dpdGNoIHRoYXQgdG8gdGhlICJtb3JlIGVsZWdhbnQiDQo+PiBzb2x1dGlvbiB3aGVu
IGl0IHNob3dzIHVwLg0KPiANCj4gT2ssIEkgdGhpbmsgSSBoYXZlIHNvbWV0aGluZy4gQW5k
IGl0IHdhcyBzdGFyaW5nIG1lIHN0cmFpZ2h0IGluIHRoZQ0KPiBmYWNlIGJ1dCBJIGRpZG4n
dCBzZWUgaXQ6IHRoZSBNVFJSIGNvZGUgbmVlZHMgYSBob3RwbHVnIG5vdGlmaWVyLiBJbg0K
PiB0aGF0IG5vdGlmaWVyIGl0IGNhbiBkbyB0aGUgaW1tZWRpYXRlLCBpLmUuLCBub24tZGVs
YXllZCBpbml0IHdoaWxlIHRoZQ0KPiBkZWxheWVkIGluaXQgYmVjb21lcyB0aGUgZGVmYXVs
dCwgc2VlIGJlbG93Lg0KPiANCj4gQW5kIGlnbm9yZSB0aGUgcHJfaW5mbyBkZWJ1Z2dpbmcg
Z3VuayBwbHMuDQo+IA0KPiBtdHJyX2FwX2luaXQoKSBiZWNvbWVzIHRoZSBub3RpZmllciBj
YWxsYmFjay4gSXQgZG9lc24ndCBuZWVkIHRvIGJlDQo+IGNhbGxlZCBpbiBpZGVudGlmeV9z
ZWNvbmRhcnlfY3B1KCkgYW55bW9yZSBhcyBpbiB0aGUgaW5pdCBjYXNlIHRoYXQNCj4gZnVu
Y3Rpb24gZG9lc24ndCBkbyBhbnl0aGluZyAtIGRlbGF5ZWQ9dHJ1ZSAtIGFuZCBpbiB0aGUg
aG90cGx1ZyBjYXNlDQo+IHRoZSBub3RpZmllciBydW5zLg0KDQpBcmUgc3VyZSB0aGUgaG90
cGx1ZyBub3RpZmllciBkb2Vzbid0IGdldCBjYWxsZWQgaW4gdGhlIGJvb3QgYW5kIGluIHRo
ZQ0KcmVzdW1lIGNhc2VzPyBJIGRvbid0IHNlZSBob3cgdGhvc2UgY2FsbHMgYXJlIGJlaW5n
IG5vdCBkb25lIG9yIHJlc3VsdGluZyBpbg0Kbm90IGRvaW5nIGFueXRoaW5nLg0KDQoNCkp1
ZXJnZW4NCg==
--------------0PIhfvS50QHBH0ohTlAHXzC0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0PIhfvS50QHBH0ohTlAHXzC0--

--------------nOdhPYwk0z37KeDD2mybzqmO--

--------------pApUDlOPKOM3yi0arxqoORwb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMz2+wFAwAAAAAACgkQsN6d1ii/Ey/6
dgf+KHty3N+NQlsxlB+dsqE/SLOW6Tee7Q2uBokhTrAlVd/C0YXkEe4bN4DJnwGcmMUzxyz0zi2+
UXxBejSNdWsZNWldTyq8Yk/WRsyMMDsDRCunb56n+vV030xD38VQfPUGX5KLIOvCyzeNFcQHk4e2
M9bAMRE1DlixNkm7LP3Q45DwAkw+UO0fB+I0lXZZ4Omppj8fNW+1Eop8ajp+zYuaocZ3qf1tH8ar
IpG0EMoz/HTPxSy43ZRmJe9DQhw1jZO0m4KmvXO51G7pLBkG7tvBesrufETXtjgkpcRXEhQj0Dwg
3WKq+zjEe95ldaMTbygwdykc7F+7LkWynXuMHTgpCg==
=ETI+
-----END PGP SIGNATURE-----

--------------pApUDlOPKOM3yi0arxqoORwb--
