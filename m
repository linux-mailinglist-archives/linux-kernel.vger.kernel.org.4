Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240C68B5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBFGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:34:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC41BAFB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:33:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3DF43EFDE;
        Mon,  6 Feb 2023 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675665237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GG32f18g6BEwzQF/w3NNG1k513RZQlWY2gbIJhdYx/w=;
        b=ByhPKDd0RIHts3Atz3N9psH4aocpTZys19ATaC3yH5Bl0JTbojH++S+mbI8uQasPWLr2Yn
        QFlEoK7Tyi5fFFN9vdlupqfEGe4BY3JevpCbQ4ANgsAWOA2PKeQuTLDgDsskXtWc1ADGXB
        K8M+09liVApBoXQ7JWdcBjdNNT3qSYk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73A2D138E4;
        Mon,  6 Feb 2023 06:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YzI1GlWf4GMKOQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Feb 2023 06:33:57 +0000
Message-ID: <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>
Date:   Mon, 6 Feb 2023 07:33:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
 <Y9+tDmLAlqg37TS+@zn.tnic>
 <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
In-Reply-To: <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7SEZ0zJGV9NqNt12YrobcSPy"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7SEZ0zJGV9NqNt12YrobcSPy
Content-Type: multipart/mixed; boundary="------------aluOi6PUr1NnJYQsMabbiJl2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Michael Kelley <mikelley@microsoft.com>, linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Message-ID: <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
 <Y9+tDmLAlqg37TS+@zn.tnic>
 <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
In-Reply-To: <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>

--------------aluOi6PUr1NnJYQsMabbiJl2
Content-Type: multipart/mixed; boundary="------------vSLe0GjPzNvm1Qy8unQiP8O5"

--------------vSLe0GjPzNvm1Qy8unQiP8O5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDIuMjMgMjE6MjEsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiBPbiBTdW4sIEZl
YiA1LCAyMDIzIGF0IDU6MjAgQU0gQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+IHdy
b3RlOg0KPj4NCj4+IEBAIC01Myw3ICs1Myw4IEBAIHN0YXRpYyBpbmxpbmUgdTggbXRycl90
eXBlX2xvb2t1cCh1NjQgYWRkciwNCj4+ICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgKiBS
ZXR1cm4gbm8tTVRSUnM6DQo+PiAgICAgICAgICAgKi8NCj4+IC0gICAgICAgcmV0dXJuIE1U
UlJfVFlQRV9JTlZBTElEOw0KPj4gKyAgICAgICAqdW5pZm9ybSA9IDE7DQo+PiArICAgICAg
IHJldHVybiBNVFJSX1RZUEVfVU5DQUNIQUJMRTsNCj4gDQo+IFNvIHRoaXMgaXMgdGhlIG9u
ZSBJJ2QgYWxtb3N0IGxlYXZlIGFsb25lLg0KPiANCj4gQmVjYXVzZSB0aGlzIGlzIG5vdCBh
ICJ0aGVyZSBhcmUgbm8gTVRSUidzIiBzaXR1YXRpb24sIHRoaXMgaXMgYSAiSQ0KPiBoYXZl
bid0IGVuYWJsZWQgQ09ORklHX01UUlIsIHNvIEkgZG9uJ3QgX2tub3dfIGlmIHRoZXJlIGFy
ZSBhbnkgTVRSUidzDQo+IG9yIG5vdC4NCg0KWWVzLg0KDQo+IEFuZCByZXR1cm5pbmcgTVRS
Ul9UWVBFX1VOQ0FDSEFCTEUgd2lsbCB0aGVuIGRpc2FibGUgdGhpbmdzIGxpa2UNCj4gbGFy
Z2VwYWdlcyBldGMsIHNvIHRoaXMgY2hhbmdlIHdvdWxkIGVmZmVjdGl2ZWx5IG1lYW4gdGhh
dCBpZg0KPiBDT05GSUdfTVRSUiBpcyBvZmYsIGl0IHdvdWxkIHR1cm4gb2ZmIGh1Z2VwYWdl
IHN1cHBvcnQgdG9vLg0KDQpDb3JyZWN0Lg0KDQo+IA0KPiBCdXQgbWF5YmUgdGhhdCB3YXMg
dGhlIG9ubHkgdGhpbmcgdGhhdCBjYXJlZCwgYW5kIHdlIGhhdmU6DQo+IA0KPj4gQEAgLTcy
MSw4ICs3MjEsOSBAQCBpbnQgcHVkX3NldF9odWdlKHB1ZF90ICpwdWQsIHBoeXNfYWRkcl90
IGFkZHIsIHBncHJvdF90IHByb3QpDQo+PiAgICAgICAgICB1OCBtdHJyLCB1bmlmb3JtOw0K
Pj4NCj4+ICAgICAgICAgIG10cnIgPSBtdHJyX3R5cGVfbG9va3VwKGFkZHIsIGFkZHIgKyBQ
VURfU0laRSwgJnVuaWZvcm0pOw0KPj4gLSAgICAgICBpZiAoKG10cnIgIT0gTVRSUl9UWVBF
X0lOVkFMSUQpICYmICghdW5pZm9ybSkgJiYNCj4+IC0gICAgICAgICAgIChtdHJyICE9IE1U
UlJfVFlQRV9XUkJBQ0spKQ0KPj4gKyAgICAgICBpZiAobXRyciAhPSBNVFJSX1RZUEVfVU5D
QUNIQUJMRSAmJg0KPj4gKyAgICAgICAgICAgbXRyciAhPSBNVFJSX1RZUEVfV1JCQUNLICYm
DQo+PiArICAgICAgICAgICAhdW5pZm9ybSkNCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+IA0KPiBIZXJlIHlvdSBtYWtlIHVwIGZvciBpdCwgYnV0IEkgZG9uJ3QgYWN0dWFs
bHkgdW5kZXJzdGFuZCB3aHkgdGhlc2UNCj4gY2hlY2tzIGV4aXN0IGF0IGFsbC4NCj4gDQo+
IEkgKnRoaW5rKiB0aGF0IHdoYXQgdGhlIGNoZWNrIHNob3VsZCBkbyBpcyBqdXN0IGNoZWNr
IGZvciB1bmlmb3JtaXR5Lg0KPiANCj4gV2h5IHdvdWxkIHRoZSBsYXJnZXBhZ2UgY29kZSBv
dGhlcndpc2UgY2FyZT8NCg0KSSBhZ3JlZS4gVGhlIHJlYXNvbmluZyBpbiB0aGUgY29tbWVu
dCBhYm92ZSBwdWRfc2V0X2h1Z2UoKSBpcyBub25zZW5zZSwgYXMNCml0IGlzIG5vdCBzcGVj
aWZpYyB0byBodWdlIHBhZ2VzOg0KDQogICogLSBNVFJScyBhcmUgZW5hYmxlZCBhbmQgdGhl
IGNvcnJlc3BvbmRpbmcgTVRSUiBtZW1vcnkgdHlwZSBpcyBXQiwgd2hpY2gNCiAgKiAgIGhh
cyBubyBlZmZlY3Qgb24gdGhlIHJlcXVlc3RlZCBQQVQgbWVtb3J5IHR5cGUuDQoNCkFueSBv
dGhlciBNVFJSIG1lbW9yeSB0eXBlIHdvdWxkIGludGVyZmVyZSB3aXRoIHRoZSByZXF1ZXN0
ZWQgUEFUIG1lbW9yeQ0KdHlwZSBpbiB1bmRlc2lyZWQgd2F5cywgYnV0IHRoaXMgaXMgc3Rp
bGwgdHJ1ZSB3aGVuIHVzaW5nIHNtYWxsIHBhZ2VzDQpvbmx5Lg0KDQo+IE90aGVyIE1UUlIg
dHlwZXMgYXJlIGV4cGxpY2l0bHkgZmluZSwgYW5kIEkgdGhpbmsgdGhpbmdzIGxpa2UgdGhl
IFgNCj4gc2VydmVyIG1pZ2h0IGV2ZW4gd2FudCB0byBkbyB3cml0ZS1jb21iaW5pbmcgd2l0
aCBsYXJnZSBwYWdlcyBldGMuDQo+IA0KPiBTbyBJIHRoaW5rIHRoZSBodWdlcGFnZSBjb2Rl
IHNob3VsZCBvbmx5IGRvDQo+IA0KPiAgICAgICBpZiAoIXVuaWZvcm0pDQo+ICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+IA0KPiBvciB0aGVyZSBzaG91bGQgYmUgc29tZSBleHBsYW5hdGlv
biBmb3Igd2h5IHRob3NlIHR5cGVzIGFyZSBzcGVjaWFsPw0KDQpBcyB3cml0dGVuIGFib3Zl
OiB0aGVyZSBpcyBhbiBleHBsYW5hdGlvbiwgYnV0IGl0IGRvZXNuJ3QgbWFrZSBtdWNoIHNl
bnNlDQpJTUhPLg0KDQo+IA0KPj4+IEBAIC03NDgsOCArNzQ5LDkgQEAgaW50IHBtZF9zZXRf
aHVnZShwbWRfdCAqcG1kLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdCBwcm90KQ0KPj4g
ICAgICAgICAgdTggbXRyciwgdW5pZm9ybTsNCj4+DQo+PiAgICAgICAgICBtdHJyID0gbXRy
cl90eXBlX2xvb2t1cChhZGRyLCBhZGRyICsgUE1EX1NJWkUsICZ1bmlmb3JtKTsNCj4+IC0g
ICAgICAgaWYgKChtdHJyICE9IE1UUlJfVFlQRV9JTlZBTElEKSAmJiAoIXVuaWZvcm0pICYm
DQo+PiAtICAgICAgICAgICAobXRyciAhPSBNVFJSX1RZUEVfV1JCQUNLKSkgew0KPj4gKyAg
ICAgICBpZiAobXRyciAhPSBNVFJSX1RZUEVfVU5DQUNIQUJMRSAmJg0KPj4gKyAgICAgICAg
ICAgbXRyciAhPSBNVFJSX1RZUEVfV1JCQUNLICYmDQo+PiArICAgICAgICAgICAhdW5pZm9y
bSkgew0KPiANCj4gU2FtZSBoZXJlLg0KPiANCj4gQWdhaW4sIEkgKnRoaW5rKiB0aGF0IHRo
ZSByZWFzb24gaXQgdXNlZCB0byBkbyB0aGF0ICJjaGVjayB0d28gdHlwZXMiDQo+IHRoaW5n
IGlzIHNpbXBseSBiZWNhdXNlICJ1bmlmb3JtIiB3YXNuJ3Qgc2V0IGNvcnJlY3RseS4NCg0K
VGhpcyBtaWdodCB2ZXJ5IHdlbGwgYmUgdGhlIHJlYXNvbiwgeWVzLg0KDQpJIHN0aWxsIGRv
bid0IHNlZSB3aHkgdGhlIG9yaWdpbmFsIHJlcG9ydCBvZiBDaHJpc3RpYW4gaXMgbWFraW5n
IHNlbnNlOg0KDQpBY2NvcmRpbmcgdG8gdGhlIGVycm9yIG1lc3NhZ2UsIHRoZSBfcmVxdWVz
dGVkXyBtZW1vcnkgdHlwZSB3YXMgVUMtLCBidXQNCnRoZSByZXZlcnRlZCBwYXRjaCBvbmx5
IGFmZmVjdHMgY2FzZXMgd2hlcmUgdGhlIHJlcXVlc3RlZCB0eXBlIGlzIFdCLiBTbw0Kd2h5
IGRvZXMgYSByZXZlcnQgb2YgOTBiOTI2ZTY4ZjUwIGlzIGhlbHBpbmcgdG8gbWFrZSB0aGlz
IG1lc3NhZ2UgZ28gYXdheT8NClRoZSBtZXNzYWdlIHdhczoNCg0KICAgaW9yZW1hcCBlcnJv
ciBmb3IgMHhmMjUyMDAwMC0weGYyNTMwMDAwLCByZXF1ZXN0ZWQgMHgyLCBnb3QgMHgwDQoN
Ck1lYW53aGlsZSBJJ3ZlIGZvdW5kIGEgc3lzdGVtIHdoaWNoIGlzIGlzc3Vpbmcgc3VjaCBh
IG1lc3NhZ2UgdW5kZXIgWGVuLg0KSSdsbCBpbnZlc3RpZ2F0ZSBmdXJ0aGVyIF93aHlfIGEg
cmVxdWVzdCBvZiBVQy0gZW5kcyB1cCB0byBnZXQgV0IuDQoNCg0KSnVlcmdlbg0K
--------------vSLe0GjPzNvm1Qy8unQiP8O5
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------vSLe0GjPzNvm1Qy8unQiP8O5--

--------------aluOi6PUr1NnJYQsMabbiJl2--

--------------7SEZ0zJGV9NqNt12YrobcSPy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPgn1QFAwAAAAAACgkQsN6d1ii/Ey+S
WAf+MtsULoXKPqy6CGVwzQo6F3KdWjtgDoJKo7rxQBae2jwVSjY7M34sNDgDho+YxRCjgh+PC8rT
e/8CLMHejgFAh/e1fSR6WC3TZ1fq/jaXSYLt+shTpqJvJUTGVk6Pf+6mf0nW0hZPQGkZqmCz7mH2
/48c39zrXfaBKEQ6GkqlkrjUPH85bHmHAoPbsyqQLECrHMA4dSpjwBVwWrDNBLtXhT78kMJgTak1
BFQNqQWwmtfCQ32HGXPLjt8Kq8Oa0ITFZ/SbxkXilFzpdFVjQCIRROJYlP0u5a6tMri60oKrtTl0
HxYw1ElHyex8qqUYd4iITIpfOpLNij9ll84e8PDBUg==
=4dJF
-----END PGP SIGNATURE-----

--------------7SEZ0zJGV9NqNt12YrobcSPy--
