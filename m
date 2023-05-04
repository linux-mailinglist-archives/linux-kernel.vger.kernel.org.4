Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE76F6CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEDNZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:25:48 -0400
Received: from www484.your-server.de (www484.your-server.de [78.47.237.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E0CF;
        Thu,  4 May 2023 06:25:46 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www484.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <k.graefe@gateware.de>)
        id 1puYxp-0002qp-4j; Thu, 04 May 2023 15:25:41 +0200
Received: from [2003:ca:6730:e8f8:81f6:311d:d80b:43c1]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <k.graefe@gateware.de>)
        id 1puYxo-000E7H-UN; Thu, 04 May 2023 15:25:40 +0200
Message-ID: <69e232c0-56ff-268c-43c4-ff40f5b00568@gateware.de>
Date:   Thu, 4 May 2023 15:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
 <ZFEAq7r-awo0OYzp@alley>
Content-Language: en-US
From:   =?UTF-8?Q?Konrad_Gr=c3=a4fe?= <k.graefe@gateware.de>
In-Reply-To: <ZFEAq7r-awo0OYzp@alley>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0rBkBiV7ZMJJRdrXNy5M0vcT"
X-Authenticated-Sender: k.graefe@gateware.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26896/Thu May  4 09:24:50 2023)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0rBkBiV7ZMJJRdrXNy5M0vcT
Content-Type: multipart/mixed; boundary="------------QcARM0qlBrvLPKSgK8cV8oH0";
 protected-headers="v1"
From: =?UTF-8?Q?Konrad_Gr=c3=a4fe?= <k.graefe@gateware.de>
To: Petr Mladek <pmladek@suse.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Felipe Balbi
 <balbi@ti.com>, stable@vger.kernel.org
Message-ID: <69e232c0-56ff-268c-43c4-ff40f5b00568@gateware.de>
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
 <ZFEAq7r-awo0OYzp@alley>
In-Reply-To: <ZFEAq7r-awo0OYzp@alley>

--------------QcARM0qlBrvLPKSgK8cV8oH0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDUuMjMgMTQ6MjMsIFBldHIgTWxhZGVrIHdyb3RlOg0KPiBPbiBGcmkgMjAyMy0w
NC0yOCAwODo1Njo1OSwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+IE9uIDI3LzA0LzIw
MjMgMTMuNTEsIEtvbnJhZCBHcsOkZmUgd3JvdGU6DQo+Pj4gVGhlIENEQy1FQ00gc3BlY2lm
aWNhdGlvbiByZXF1aXJlcyBhbiBVU0IgZ2FkZ2V0IHRvIHNlbmQgdGhlIGhvc3QgTUFDDQo+
Pj4gYWRkcmVzcyBhcyB1cHBlcmNhc2UgaGV4IHN0cmluZy4gVGhpcyBjaGFuZ2UgYWRkcyB0
aGUgYXBwcm9wcmlhdGUNCj4+PiBtb2RpZmllci4NCj4+DQo+PiBUaGlua2luZyBtb3JlIGFi
b3V0IGl0LCBJJ20gbm90IHN1cmUgdGhpcyBpcyBhcHByb3ByaWF0ZSwgbm90IGZvciBhDQo+
PiBzaW5nbGUgdXNlciBsaWtlIHRoaXMuIHZzcHJpbnRmKCkgc2hvdWxkIG5vdCBhbmQgY2Fu
bm90IHNhdGlzZnkgYWxsDQo+PiBwb3NzaWJsZSBzdHJpbmcgZm9ybWF0dGluZyByZXF1aXJl
bWVudHMgZm9yIHRoZSB3aG9sZSBrZXJuZWwuIFRoZSAlcFgNCj4+IGV4dGVuc2lvbnMgYXJl
IGNvbnZlbmllbnQgZm9yIHVzZSB3aXRoIHByaW50aygpIGFuZCBmcmllbmRzIHdoZXJlIG9u
ZQ0KPj4gbmVlZHMgd2hhdCBpbiBvdGhlciBsYW5ndWFnZXMgd291bGQgYmUgInN0cmluZyBp
bnRlcnBvbGF0aW9uIiAoYmVjYXVzZQ0KPj4gdGhlbiB0aGUgY2FsbGVyIGRvZXNuJ3QgbmVl
ZCB0byBkZWFsIHdpdGggdGVtcG9yYXJ5IHN0YWNrIGJ1ZmZlcnMgYW5kDQo+PiBwYXNzIHRo
ZW0gYXMgJXMgYXJndW1lbnRzKSwgYnV0IGZvciBzaW5nbGUgaXRlbXMgbGlrZSB0aGlzLCBz
bnByaW50ZigpDQo+PiBpcyBub3QgbmVjZXNzYXJpbHkgdGhlIHJpZ2h0IHRvb2wgZm9yIHRo
ZSBqb2IuDQo+Pg0KPj4gSW4gdGhpcyBjYXNlLCB0aGUgY2FsbGVyIGNhbiBqdXN0IGFzIHdl
bGwgY2FsbCBzdHJpbmdfdXBwZXIoKSBvbiB0aGUNCj4+IHJlc3VsdA0KPiANCj4gSSB0ZW5k
IHRvIGFncmVlIHdpdGggUmFzbXVzLiBzdHJpbmdfdXBwZXIoKSBpcyBhIHN1cGVyLWVhc3kg
c29sdXRpb24uDQo+IE9uZSB1c2VyIGRvZXMgbm90IGxvb2sgd29ydGggYWRkaW5nIGFsbCB0
aGUgY2h1cm4gaW50byB2c3ByaW50ZigpLg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBQZXRy
DQoNCkkgZG8gYWdyZWUgYXMgd2VsbC4gVGhhdCB3b3VsZCBiYXNpY2FsbHkgYmUgdjEgWzFd
IHdpdGhvdXQgdGhlIA0KaGFuZC1jcmFmdGVkIHN0cmluZ191cHBlcigpLiAoSSBkaWRuJ3Qg
a25vdyB0aGUgZnVuY3Rpb24uKQ0KDQpSZWdhcmRzLA0KS29ucmFkDQoNClsxXTogDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvOTRhZmQ2ZTAtNzMwMC1lOGY0LWQ1MmUt
YzIxYWNlYzA0ZjViQGdhdGV3YXJlLmRlLw0K

--------------QcARM0qlBrvLPKSgK8cV8oH0--

--------------0rBkBiV7ZMJJRdrXNy5M0vcT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEUA99m0xJ9cFn0k9bgJOZiyvdweQFAmRTslQFAwAAAAAACgkQgJOZiyvdweT9
zxAAoD8iG56zIdUyKV97cMYu+mfgxAg5tg7HVcw6oiHUy03pf0eR56WOEbTKzO18J9p1EPnefLU/
FJ7gOlbz2aFUV5gGMN0tPj2CrgH17a6UFd3qalMmL9Q8rtL3rh4/Lg7KVlDnB9sWGXH+h5ZpEHe/
2XPD2qL3aQMWSZxv5bms28X/OlJnxV6fR9hKUQ4mJd52zHzS5dlYWtM8Z8V29P0JiQIB4f0z81Sv
WrVCKR3sIIDkVL+GVTMwhlKcNV194/FNDUYLEox8zgqQDBlM39UafL5aMKea/RiPIPUn+Xbbj6Ro
bgqmS9WGYKKp9h6568L1pmwtuSDuZobFv0EeM1rahxwXX6/SIcI4Uf9OwwGwJmmJOFmCm/xg02u7
4houue1QIpLaPs9YOzG8fJkA3jogKUevqa/fHyvZ6sUw546M/vhSki1Jtf6ICSd6TmvgD7BZNqMz
ZXgBDeQkYmHZtJbLQLpG0Hp4Qw9yl+vnHfDw+KY8FDCAd6aSNP9kk5lJsCHaN+rnEOcET+SryNu1
PD72QfWaNICK5PDVecurAHNHAETqu2/7btXAFXvPqq00zY0tSIcCDaJEacil+PQprTfc8JdVXkoA
XjizXpRU9iAJo3RJ6Kcv/8vakChjf7saMzmwQ9Z1boSH1nd71INxa9kc4VQqu19S4hXNP7Pvud0f
gXk=
=u/N7
-----END PGP SIGNATURE-----

--------------0rBkBiV7ZMJJRdrXNy5M0vcT--
