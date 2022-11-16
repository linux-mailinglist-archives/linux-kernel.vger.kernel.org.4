Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6E62B6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiKPJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiKPJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:40:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E802A72D;
        Wed, 16 Nov 2022 01:40:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4276336F0;
        Wed, 16 Nov 2022 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668591610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/X2nK8ikBpvrCgNSRXtJgM86JjBV4/Rkx2QajeAFT0=;
        b=UBFvbD+agRHbD91x8CSH3dzjUQJeCTCdayzd/DQ85O/z0Omkg8hpry9jhbv1zkywLywP/I
        obBy1voKhPnzLlLTkfZ95/OtcYRE4UmGdWwkKuA0Ovf8BQTIdXO1g8GMN41xPcuxZ/13ix
        UWT7Bnt5ln817vnXocdrae0hO5Cal+U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B67B0134CE;
        Wed, 16 Nov 2022 09:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xNQzK/qvdGN+OwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 16 Nov 2022 09:40:10 +0000
Message-ID: <64372250-a413-076e-3b6d-2d263ee9c7f2@suse.com>
Date:   Wed, 16 Nov 2022 10:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [tip: locking/urgent] locking: Fix qspinlock/x86 inline asm error
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Guo Jin <guoj17@chinatelecom.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org
References: <20221108060126.2505-1-guoj17@chinatelecom.cn>
 <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5fG1cFs5K7SeC2tABgH3Dx7Z"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5fG1cFs5K7SeC2tABgH3Dx7Z
Content-Type: multipart/mixed; boundary="------------NrKot2iyKhMn0dxG5T3hepPx";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Guo Jin <guoj17@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org
Message-ID: <64372250-a413-076e-3b6d-2d263ee9c7f2@suse.com>
Subject: Re: [tip: locking/urgent] locking: Fix qspinlock/x86 inline asm error
References: <20221108060126.2505-1-guoj17@chinatelecom.cn>
 <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>
In-Reply-To: <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>

--------------NrKot2iyKhMn0dxG5T3hepPx
Content-Type: multipart/mixed; boundary="------------ZKO1DIAyjWE0K2QT6D1hu5lX"

--------------ZKO1DIAyjWE0K2QT6D1hu5lX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMTEuMjIgMTA6MjEsIHRpcC1ib3QyIGZvciBHdW8gSmluIHdyb3RlOg0KPiBUaGUg
Zm9sbG93aW5nIGNvbW1pdCBoYXMgYmVlbiBtZXJnZWQgaW50byB0aGUgbG9ja2luZy91cmdl
bnQgYnJhbmNoIG9mIHRpcDoNCj4gDQo+IENvbW1pdC1JRDogICAgIDIzZGYzOWZjNmEzNjE4
M2FmNWU2ZTRmNDc1MjNmMWFkMmNkYzFkMzANCj4gR2l0d2ViOiAgICAgICAgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy90aXAvMjNkZjM5ZmM2YTM2MTgzYWY1ZTZlNGY0NzUyM2YxYWQyY2Rj
MWQzMA0KPiBBdXRob3I6ICAgICAgICBHdW8gSmluIDxndW9qMTdAY2hpbmF0ZWxlY29tLmNu
Pg0KPiBBdXRob3JEYXRlOiAgICBUdWUsIDA4IE5vdiAyMDIyIDE0OjAxOjI2ICswODowMA0K
PiBDb21taXR0ZXI6ICAgICBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
DQo+IENvbW1pdHRlckRhdGU6IFdlZCwgMTYgTm92IDIwMjIgMTA6MTg6MDkgKzAxOjAwDQo+
IA0KPiBsb2NraW5nOiBGaXggcXNwaW5sb2NrL3g4NiBpbmxpbmUgYXNtIGVycm9yDQo+IA0K
PiBXaGVuIGNvbXBpbGluZyBsaW51eCA2LjEuMC1yYzMgY29uZmlndXJlZCB3aXRoIENPTkZJ
R182NEJJVD15IGFuZA0KPiBDT05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tTPXkgb24geDg2XzY0
IHVzaW5nIExMVk0gMTEuMCwgYW4gZXJyb3I6DQo+ICI8aW5saW5lIGFzbT4gZXJyb3I6IGNo
YW5nZWQgc2VjdGlvbiBmbGFncyBmb3IgLnNwaW5sb2NrLnRleHQsDQo+IGV4cGVjdGVkOjog
MHg2IiBvY2N1cnJlZC4NCj4gDQo+IFRoZSByZWFzb24gaXMgdGhlIC5zcGlubG9jay50ZXh0
IGluIGtlcm5lbC9sb2NraW5nL3FzcGlubG9jay5vDQo+IGlzIHVzZWQgbWFueSB0aW1lcywg
YnV0IGl0cyBmbGFncyBhcmUgb21pdHRlZCBpbiBzdWJzZXF1ZW50IHVzZS4NCj4gDQo+IExM
Vk0gMTEuMCBhc3NlbWJsZXIgZGlkbid0IHBlcm1pdCB0bw0KPiBsZWF2ZSBvdXQgZmxhZ3Mg
aW4gc3Vic2VxdWVudCB1c2VzIG9mIHRoZSBzYW1lIHNlY3Rpb25zLg0KPiANCj4gU28gdGhp
cyBwYXRjaCBhZGRzIHRoZSBjb3JyZXNwb25kaW5nIGZsYWdzIHRvIGF2b2lkIGFib3ZlIGVy
cm9yLg0KPiANCj4gRml4ZXM6IDUwMWY3ZjY5YmNhMSAoImxvY2tpbmc6IEFkZCBfX2xvY2tm
dW5jIHRvIHNsb3cgcGF0aCBmdW5jdGlvbnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBHdW8gSmlu
IDxndW9qMTdAY2hpbmF0ZWxlY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWps
c3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IE5h
dGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4gTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDIyMTEwODA2MDEyNi4yNTA1LTEtZ3VvajE3QGNoaW5hdGVs
ZWNvbS5jbg0KDQpXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gdGFrZSBteSBtb3JlIGdlbmVy
aWMgcGF0Y2ggWzFdIGluc3RlYWQ/DQoNClsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIyMTEwOTEzNDQxOC42NTE2LTEtamdyb3NzQHN1c2UuY29tLw0KDQoNCkp1ZXJn
ZW4NCg0K
--------------ZKO1DIAyjWE0K2QT6D1hu5lX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ZKO1DIAyjWE0K2QT6D1hu5lX--

--------------NrKot2iyKhMn0dxG5T3hepPx--

--------------5fG1cFs5K7SeC2tABgH3Dx7Z
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN0r/oFAwAAAAAACgkQsN6d1ii/Ey+w
Owf/fr5JgHNLFiR4anCtHSieh8aJyvdFS1/X32DINUSfOR2+fLM4wvZmbZDZrdl+IRdMcDLg1E8F
rTOMZMv9KWtqvyndxPzxfWPcUmQF5JRhrtNtRP5BHKw+uGVPyXHWapb7EWKh8a28ffWcOSEc4Ixp
8wH5gesyPn9hMxRbSO8tA9z3W3ojM0MWJ+zdStUwYThkxm9EkVLx7KOP0LRlGDpOr0FIw2wy4lVJ
5t2PGcd5S2S8KTm3MA158HT0pmzSxISjvVUBKHHIY3nhalyueTEmB6Z3AaG62rxMfcWnVeb1nUxL
m2dxdHpP3oAbm41vuJ68m9TXv+Kx/vGr726XUlWD3A==
=SE6t
-----END PGP SIGNATURE-----

--------------5fG1cFs5K7SeC2tABgH3Dx7Z--
