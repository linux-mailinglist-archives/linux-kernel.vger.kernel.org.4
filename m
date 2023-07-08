Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49ED74BE90
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGHRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 13:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 13:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05EFE45;
        Sat,  8 Jul 2023 10:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3E760DD6;
        Sat,  8 Jul 2023 17:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4160C433C8;
        Sat,  8 Jul 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688836748;
        bh=obPszca9HUUm39m5DN//rZarmmI8Vk++L/cwyjiHZIk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kI2M35eS+cw6Fn29keKYSvOWLrCP4dIqGPVPita2Ful/ophTkK5JdWM7Shte1F/ov
         ijsAKvz9NwcqwoIQNleGAKEsl64YVPEC1fqaSEFp7DJAMoySmc9KBxGzYQc6+PV6Fe
         rixmx0s5JOKmBJvGPgstbziv1jgbTy8t4Yj4qbWCNm2wK7kgRd4C9mYZiM4tFXDsCs
         57AJj6IoXK62ULhit/QH516zpa91wkt7xRa86nc4DMuACVmpwLbaKJHgHsWLCK0bid
         hldeysMHy8wXJlZLImsJnyQwW/77HkMmoUQJ5uu4WrgFZz+5Fu9d65X1g7Pavw5gLT
         vE4xy+kl/YU/A==
Message-ID: <0b4048d4-e80d-a80c-d16d-3fbb301cf698@kernel.org>
Date:   Sat, 8 Jul 2023 19:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] proc.5: Clarify that boot arguments can be embedded in
 image
Content-Language: en-US
To:     paulmck@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc:     mtk.manpages@gmail.com, corbet@lwn.net, akpm@linux-foundation.org,
        ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org
References: <433d742b-743b-4335-878f-1ca0f45698f7@paulmck-laptop>
 <20230704215932.c9cab0af086528e52ca0bfbb@kernel.org>
 <d3057de8-39ca-4d2a-aa03-9134f916fac9@paulmck-laptop>
From:   Alejandro Colomar <alx@kernel.org>
In-Reply-To: <d3057de8-39ca-4d2a-aa03-9134f916fac9@paulmck-laptop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0hNmHNIBNB4tyNxQxz770Y1k"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0hNmHNIBNB4tyNxQxz770Y1k
Content-Type: multipart/mixed; boundary="------------EfxjfJRe60ewWmyBXc7L6Yfm";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: paulmck@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc: mtk.manpages@gmail.com, corbet@lwn.net, akpm@linux-foundation.org,
 ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org
Message-ID: <0b4048d4-e80d-a80c-d16d-3fbb301cf698@kernel.org>
Subject: Re: [PATCH] proc.5: Clarify that boot arguments can be embedded in
 image
References: <433d742b-743b-4335-878f-1ca0f45698f7@paulmck-laptop>
 <20230704215932.c9cab0af086528e52ca0bfbb@kernel.org>
 <d3057de8-39ca-4d2a-aa03-9134f916fac9@paulmck-laptop>
In-Reply-To: <d3057de8-39ca-4d2a-aa03-9134f916fac9@paulmck-laptop>

--------------EfxjfJRe60ewWmyBXc7L6Yfm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUGF1bCENCg0KT24gNy81LzIzIDIyOjMzLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwOTo1OTozMlBNICswOTAwLCBNYXNhbWkgSGly
YW1hdHN1IHdyb3RlOg0KPj4gT24gRnJpLCAzMCBKdW4gMjAyMyAxNjozMzoyOCAtMDcwMA0K
Pj4gIlBhdWwgRS4gTWNLZW5uZXkiIDxwYXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4N
Cj4+PiBXaXRoIHRoZSBhZHZlbnQgb2YgdGhlIENPTkZJR19CT09UX0NPTkZJRyBLY29uZmln
IG9wdGlvbiwga2VybmVsIGJvb3QNCj4+PiBhcmd1bWVudHMgY2FuIG5vdyBiZSBlbWJlZGRl
ZCBpbiB0aGUga2VybmVsIGltYWdlLCBlaXRoZXIgYXR0YWNoZWQNCj4+PiB0byB0aGUgZW5k
IG9mIGluaXRyYW1mcyBvciBlbWJlZGRlZCBpbiB0aGUga2VybmVsIGl0c2VsZi4gIERvY3Vt
ZW50DQo+Pj4gdGhpcyBwb3NzaWJpbGl0eSBpbiB0aGUgL3Byb2MvY21kbGluZSBlbnRyeSBv
ZiBwcm9jLjUuDQo+Pg0KPj4gVGhhbmtzIGZvciB1cGRhdGUhDQo+Pg0KPj4gUmV2aWV3ZWQt
Ynk6IE1hc2FtaSBIaXJhbWF0c3UgKEdvb2dsZSkgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+
IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchICBUYWcgYWRkZWQuDQoNCj4gVGhhbmsgeW91
LCBNYXNhbWkhDQo+IA0KPiBBZGRpbmcgQWxlamFuZHJvIGFuZCBsaW51eC1tYW4gb24gQ0Mu
DQo+IA0KPiAJCQkJCQkJVGhhbngsIFBhdWwNCj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPj4+IENjOiBNaWNoYWVsIEtl
cnJpc2sgPG10ay5tYW5wYWdlc0BnbWFpbC5jb20+DQo+Pj4gQ2M6IE1hc2FtaSBIaXJhbWF0
c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29y
YmV0QGx3bi5uZXQ+DQo+Pj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc+DQo+Pj4gQ2M6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29n
bGUuY29tPg0KPj4+IENjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KPj4+
IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4+Pg0KDQpUaGFu
a3MhICBQYXRjaCBhcHBsaWVkLg0KDQpDaGVlcnMsDQpBbGV4DQoNCj4+PiBkaWZmIC0tZ2l0
IGEvbWFuNS9wcm9jLjUgYi9tYW41L3Byb2MuNQ0KPj4+IGluZGV4IGM2Njg0NjIwZS4uMTQx
YTI5ODNjIDEwMDY0NA0KPj4+IC0tLSBhL21hbjUvcHJvYy41DQo+Pj4gKysrIGIvbWFuNS9w
cm9jLjUNCj4+PiBAQCAtMzEwMCw2ICszMTAwLDkgQEAgT2Z0ZW4gZG9uZSB2aWEgYSBib290
IG1hbmFnZXIgc3VjaCBhcw0KPj4+ICAgLkJSIGxpbG8gKDgpDQo+Pj4gICBvcg0KPj4+ICAg
LkJSIGdydWIgKDgpLg0KPj4+ICtBbnkgYXJndW1lbnRzIGVtYmVkZGVkIGluIHRoZSBrZXJu
ZWwgaW1hZ2Ugb3IgaW5pdHJhbWZzIHZpYQ0KPj4+ICsuQiBDT05GSUdfQk9PVF9DT05GSUcN
Cj4+PiArd2lsbCBhbHNvIGJlIGRpc3BsYXllZC4NCj4+PiAgIC5UUA0KPj4+ICAgLklSIC9w
cm9jL2NvbmZpZy5neiAiIChzaW5jZSBMaW51eCAyLjYpIg0KPj4+ICAgVGhpcyBmaWxlIGV4
cG9zZXMgdGhlIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyB0aGF0IHdlcmUgdXNlZA0KPj4NCj4+
DQo+PiAtLSANCj4+IE1hc2FtaSBIaXJhbWF0c3UgKEdvb2dsZSkgPG1oaXJhbWF0QGtlcm5l
bC5vcmc+DQoNCi0tIA0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0KR1BH
IGtleSBmaW5nZXJwcmludDogQTkzNDg1OTRDRTMxMjgzQTgyNkZCREQ4RDU3NjMzRDQ0MUUy
NUJCNQ0KDQo=

--------------EfxjfJRe60ewWmyBXc7L6Yfm--

--------------0hNmHNIBNB4tyNxQxz770Y1k
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmSpmoYACgkQnowa+77/
2zLaAw/9GZ44D9oqBv/3PZ7DPzamy+1S94JAgMufrbV5SOSMXpIZhVHLSLR8CI0i
MAV+vOp06f5lDuowwlCU/QetZK5OylyEy1G+7WuB+hY3/Qjtf7bblTDp+lrAISQn
VyN9N/yJM1LPumsmwPwM2ifzTQ/xviTDWg4JeDAr0tE8G+R6Q42uXEfwl+F9W+sP
6zWRWi4gPQw2/6iqZiJk5dm0M+xajjt+iFKp2z8UOaPXLDJzAWcnPozuyl8M4k5M
/yRyzJpq3eqSAkpYzJVruMpcVcLhzh28iLOkSAH5OjNuZlxGPXbYHZCV+fUqcS7q
XkZlgmkbahcYTMm/92jHAMvoD4YWnuPt5Ol6t0m12lvl25KfOkH+F28mp7n1YupR
Y1TJUoc/ciVFiWBtgEY5i1pbiVqYIIEypN51QOb00CLCalyzQgD0MOPbMQgD4KiP
ZZh3gL/Z0PRL4hRgV58U6WnWzSo55uQxCdrL6tcms1go+6PxELf1T3QCc2Jih714
6iJ55BxnBiKCwqXOtGgZIDbKLBd4S5hZYVffFaqyaNem5srvZnNEmfeSJn00dvsh
rSe6S4Hjvju93AgVay86dEy9Uk/92a64A6EHXc/9m167sp7hyVjmacg24M1G0Tll
pByrjpjoCEHiWkxI0VlMfJkGN7BCtrMqDKeg/+mmL3oiwZduEDU=
=pJ9c
-----END PGP SIGNATURE-----

--------------0hNmHNIBNB4tyNxQxz770Y1k--
