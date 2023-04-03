Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64496D3D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDCG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:57:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C35599
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:57:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD3E11F74B;
        Mon,  3 Apr 2023 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680505068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=faBGRyOp5mUV4taUZrpipbhNbxGYIN+vMii9li9zZls=;
        b=HpPiQTkqezFxP3mG4m8YYI+rYgx2PXJ8uE3/qQUlqdptSc42rVAMgl2EKf/TF+5rSxJctz
        MlBH4vCoOIjDacOhZs6DTx8WQio4lIfWiOepORiicGcTovahGtbegrGhBKuzsIl6lUyk9e
        HbcXFWVZV43UaG3IHgbWXWEJ2hWlBdQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A00AB13416;
        Mon,  3 Apr 2023 06:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nnh8Jex4KmTREAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 03 Apr 2023 06:57:48 +0000
Message-ID: <2703abe4-f164-2208-99ac-0935ebd41716@suse.com>
Date:   Mon, 3 Apr 2023 08:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
 <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
 <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
 <20230401142419.GCZCg+k9fgFPdAO4c/@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
In-Reply-To: <20230401142419.GCZCg+k9fgFPdAO4c/@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PKEtGoo4jZS4LWQCDwI0OAPY"
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PKEtGoo4jZS4LWQCDwI0OAPY
Content-Type: multipart/mixed; boundary="------------qXes6NyDnRIPArQJ0HyhWPht";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2703abe4-f164-2208-99ac-0935ebd41716@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
 <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
 <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
 <20230401142419.GCZCg+k9fgFPdAO4c/@fat_crate.local>
In-Reply-To: <20230401142419.GCZCg+k9fgFPdAO4c/@fat_crate.local>

--------------qXes6NyDnRIPArQJ0HyhWPht
Content-Type: multipart/mixed; boundary="------------NbeRw0GLfL67OxxHYDQtBjkr"

--------------NbeRw0GLfL67OxxHYDQtBjkr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDQuMjMgMTY6MjQsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gRnJpLCBN
YXIgMzEsIDIwMjMgYXQgMDM6MjM6MTNQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluIGdlbmVyYWwgdGhlIGNyaXRpY2FsIGNhc2UgaXMgYWRkX21hcF9lbnRyeV9hdCgp
IHJldHVybmluZyAyIChpbiB0aGUNCj4+IGNhc2UgaXQgaXMgcmV0dXJuaW5nIDEsIHRoZSBp
bmRleCBjYW4gYmUgc2V0IHRvIC0xLCBidXQgdGhlcmUgaXMgYWx3YXlzDQo+PiB0aGUgImNv
bnRpbnVlIiBzdGF0ZW1lbnQgcmlnaHQgYWZ0ZXIgdGhhdCwgd2hpY2ggd291bGQgZXhlY3V0
ZSB0aGUgImkrKyINCj4+IG9mIHRoZSAiZm9yIiBzdGF0ZW1lbnQpLg0KPj4NCj4+IGFkZF9t
YXBfZW50cnlfYXQoKSBjYW4gcmV0dXJuIDIgb25seSwgaWYgaXQgZGV0ZWN0cyAibWVyZ2Vf
cHJldiIgYW5kDQo+PiAibWVyZ2VfbmV4dCIuICJtZXJnZV9wcmV2IiBjYW4gYmUgc2V0IG9u
bHkgaWYgdGhlIGN1cnJlbnQgaW5kZXggd2FzID4gMCwNCj4+IHdoaWNoIG1ha2VzIGl0IGlt
cG9zc2libGUgdG8gcmV0dXJuIDIgaWYgdGhlIGluZGV4IHdhcyAwLg0KPiANCj4gWWVhaCwg
aW4gdGhlIG1lYW50aW1lIEkgZGlkIGFkZCBzb21lIGRlYnVnIHByaW50a3MgaW4gb3JkZXIg
dG8gZmluZCBteQ0KPiB3YXkgYXJvdW5kIHRoYXQgY29kZS4uLg0KPiANCj4+IEhvdyBzaG91
bGQgaXQgYmUgbmFtZWQ/IEFNRCBUT1BfTUVNMiBNU1I/DQo+IA0KPiBJdCBpcyBhbHJlYWR5
IGNhbGxlZCB0aGF0IHdheSAtIHNlZSAiZ2l0IGdyZXAgVE9QX01FTTIiIG91dHB1dC4NCj4g
DQo+PiBUaGUgcHJvYmxlbSBpc24ndCBhbiBhZGRlZCBNVFJSIHJlZ2lzdGVyLCBidXQgYSBw
b3NzaWJseSByZXBsYWNlZCBvciByZW1vdmVkDQo+PiBvbmUuIEhhbmRsaW5nIHRoYXQgaXMg
bXVjaCBtb3JlIGNvbXBsaWNhdGVkLCBzbyBJJ3ZlIGNob3NlbiB0byBkbyBpdCB0aGUgc2lt
cGxlDQo+PiB3YXkuDQo+IA0KPiBQbHMgcHV0IHRoYXQgYmx1cmIgb3ZlciB0aGUgZnVuY3Rp
b246IG5lZWRzIHRvIGJlIGNhbGxlZCB3aGVuIE1UUlJzIGdldA0KPiBtb2RpZmllZCBzbyB0
aGF0IHRoZSBtYXAgaXMga2VwdCB2YWxpZCwgeWFkZGEgeWFkZGEuLi4NCg0KT2theS4NCg0K
DQpKdWVyZ2VuDQo=
--------------NbeRw0GLfL67OxxHYDQtBjkr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NbeRw0GLfL67OxxHYDQtBjkr--

--------------qXes6NyDnRIPArQJ0HyhWPht--

--------------PKEtGoo4jZS4LWQCDwI0OAPY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQqeOwFAwAAAAAACgkQsN6d1ii/Ey9B
6Qf/ZFSxbBgV7Dxp+fmOXGIT+njdOStwoYdUqXxvlELyZ+4gi4T43s2wGl3ehOKSV6TyXVJSKsFj
KSLfQJEryYZaYoPoLtWskLXQUcE29HxUV8XlHiZE/ky+CeJR8ILRl8MCb6zJ/9s1ea/34H56LsBp
tZobNjEfgtAE1ag5u2zJYnljE2Vl31F/TbgbodkqkA2D4dWsKvV9+2FbntqEpkvsMpmZ+0c46VHL
2bq965DxyCyvpDroFA6KGcS7St29w4+H78o6hI9JtGYXkWgQCXU5dLCy/13Z69rTnD2mWlMVgvrE
KbCUfvlU7O5dlWXrkI4BQ09GVXv9CbBS938+nDEM5Q==
=m1yK
-----END PGP SIGNATURE-----

--------------PKEtGoo4jZS4LWQCDwI0OAPY--
