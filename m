Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F587664C83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjAJT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjAJT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:28:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F776BC9E;
        Tue, 10 Jan 2023 11:28:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o15so9545630wmr.4;
        Tue, 10 Jan 2023 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogQqGa/zMUkiqlJzpPnC47rh7tkOePjRpIkhCuzSQnI=;
        b=VimGyA3dksUeUGnm7ZYC72V9xTe/3xKF/dq/Kllo61wWHxfL9ewxTR/21UpzDOnMIr
         QUueIp2EppH5lDVoKJS+XJWjJS0htgJntIpyKV78gG0mM94NW/kwC/yoh9oYuR73L0Rc
         liwfiJ8VeMQRAjkwBfZZhYAavtrvkOQOFQC/twL5WI3F74aVOYuuudf6BLeGJy2iz6xz
         5/vDxBdCWJM3QFMKmBgJnHVaQWr0oa8CtUDg78qRBXmiC8EfBpP8v8U7oHOKDZeEq8G3
         U7iVePDEdKPCaa769bpRfkJWpbmsT1t1d2VdsMZdpCe0UrDxzQw1oWsxSWMvvLUUnmTU
         D6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ogQqGa/zMUkiqlJzpPnC47rh7tkOePjRpIkhCuzSQnI=;
        b=3qhBYm4pkNlgJDs8JDah+wCVPK2anJ4tVmeb50h1IeL96I0wvHMstgjQ3w7E2NPuwy
         uF9imCYGceLLFPcKkCwrX9uTBFFpbp7fTRSoIsv8HdP4zkqoLfm5vOLrwc7D1HbZA/1l
         iTcT49npNSJsFbEplraU2WPP05/UdIUTuSmcIaYVaBBgQj8EguBLletOs6FYSuyfl+VW
         itAwlwJc7WvHyY8aDABZ2NLB/+ah7O1GbM/u+HjHoZZ1VTqAcOXg2oLjMDFgOg4RIit3
         u0ToKzwWqmnKMM8gqLKdJn6DttLmTy3z2J+COhSXTqwU7S8OISHi8vr1777EVP7+P/Ny
         hP1Q==
X-Gm-Message-State: AFqh2krOIxJ+Pk66W7nspBDRif8qU7JMfJFIS49GzLpJEnvltJJNgyhz
        fLG36trGXLiPntLwyLSH2je8hK507fA=
X-Google-Smtp-Source: AMrXdXvMplOU9MpVP7lRR0EZxqgcd3QqJWJECOML1r44flvhTILRLXEdsUqX/eIt092W1b2GdzICQg==
X-Received: by 2002:a05:600c:3502:b0:3d9:e75c:756c with SMTP id h2-20020a05600c350200b003d9e75c756cmr10112577wmq.12.1673378923602;
        Tue, 10 Jan 2023 11:28:43 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0ad200b003d9c97d82f2sm15717741wmr.8.2023.01.10.11.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:28:43 -0800 (PST)
Message-ID: <71ea2fa3-e593-e1ae-7abd-377bdf302d24@gmail.com>
Date:   Tue, 10 Jan 2023 20:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq(2) man page
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>
References: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
 <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
 <71b43f20-5d6d-f3f8-b3cd-786dfbc8d34d@gmail.com>
 <c8cb6136-6924-4fae-f4bb-981dec2e1952@efficios.com>
 <71e6728d-c2a8-e646-5c6c-2de8dfa982cc@gmail.com>
 <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jlE2rgOjTHkdEuS4D8a1Nx0Y"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jlE2rgOjTHkdEuS4D8a1Nx0Y
Content-Type: multipart/mixed; boundary="------------C5hnTBVRBRN3VuETDc00N05b";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 paulmck <paulmck@kernel.org>
Message-ID: <71ea2fa3-e593-e1ae-7abd-377bdf302d24@gmail.com>
Subject: Re: rseq(2) man page
References: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
 <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
 <71b43f20-5d6d-f3f8-b3cd-786dfbc8d34d@gmail.com>
 <c8cb6136-6924-4fae-f4bb-981dec2e1952@efficios.com>
 <71e6728d-c2a8-e646-5c6c-2de8dfa982cc@gmail.com>
 <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>
In-Reply-To: <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>

--------------C5hnTBVRBRN3VuETDc00N05b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDEvMTAvMjMgMTc6NTQsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KDQpbLi4u
XQ0KDQpbRUZBVUxUIC8gU0VHVl0NCg0KPiANCj4gT0ssIGxldCdzIGtlZXAgdGhpcyBmb3Ig
YSBzZXBhcmF0ZSBkaXNjdXNzaW9uLg0KDQpTdXJlLg0KDQpbLi4uXQ0KDQo+PiBJIGZvcmdv
dDsgdGhlcmUncyBhIG5ldyBzZWN0aW9uOiBMSUJSQVJZLg0KPj4NCj4+IEl0IHNwZWNpZmll
cyB0aGUgbGlicmFyeSBpbiB3aGljaCB0aGUgZnVuY3Rpb24gaXMgZGVmaW5lZCwgb3IgaW4g
dGhlIGNhc2Ugb2YgDQo+PiBzeXNjYWxscywgdGhlIHdyYXBwZXIgKHNpbmNlIHdlIGNhbGwg
aXQgdGhyb3VnaCBzeXNjYWxsKDIpLCBpdCB3b3VsZCBiZSBsaWJjKS4NCj4gDQo+IE9LLiBT
aW1pbGFyIHRvIGZ1dGV4KDIpLg0KDQpZZXAuDQoNCj4gDQo+Pg0KPj4gQlRXLCBJIHdvbmRl
ciB3aGF0IGxpYnJzZXEgaXMuwqAgSXMgbGlicnNlcSBzb21ldGhpbmcgdGhhdCB1c2VycyBz
aG91bGQgY2FyZSANCj4+IGFib3V0Pw0KPiANCj4gVXNlcnMgYXJlIG5vdCByZXF1aXJlZCB0
byB1c2UgbGlicnNlcSB0byB1c2UgdGhlIHJzZXEgc3lzdGVtIGNhbGwsDQo+IGJ1dCBpdCdz
IHZlcnkgY29udmVuaWVudCB0byB1c2UgdGhpcyBDLWxldmVsIEFQSSByYXRoZXIgdGhhbiBo
YXZlDQo+IGVhY2ggdXNlciByZWltcGxlbWVudCB0aGUgcGVyLWFyY2hpdGVjdHVyZSBhc3Nl
bWJseSBjb2RlIHJlcXVpcmVkIHRvDQo+IGNyZWF0ZSB0aGUgUlNFUSBjcml0aWNhbCBzZWN0
aW9ucy4NCj4gDQo+IGxpYnJzZXEgZGlkIG5vdCBoYXZlIGFuIG9mZmljaWFsIHJlbGVhc2Ug
eWV0LCBzbyB0aGF0J3MgbWFpbmx5IHdoeSBJDQo+IHRoaW5rIGl0IHRvbyBlYXJseSB0byBy
ZWZlciB0byBpdCBpbiBtYW51YWwgcGFnZXMuDQoNCk9rYXk7IHdoZW4geW91IGZlZWwgaXQn
cyByZWFkeSwgeW91IGNvdWxkIGRvY3VtZW50IGl0IGxpa2UgbGlia2V5dXRpbHMgaW4ga2V5
Y3RsKDIpLg0KDQo+IA0KPj4NCj4+PiAuU0ggU1lOT1BTSVMNCj4+PiAubmYNCj4+PiAuUFAN
Cj4+PiAuQlIgIiNpbmNsdWRlIDxsaW51eC9yc2VxLmg+IiBcDQo+Pj4gIiAvKiBEZWZpbml0
aW9uIG9mICIgUlNFUV8qICIgY29uc3RhbnRzIGFuZCByc2VxIHR5cGVzICovIg0KPj4NCj4+
IFRoZSBsaW5lIGFib3ZlIGdvZXMgYmV5b25kIGNvbHVtbiA4MCBpbiBmb3JtYXR0ZWQgb3V0
cHV0LsKgIFRoYXQncyBhIGhhcmQgbGltaXQgDQo+PiBmb3IgbWFudWFsIHBhZ2VzLsKgIElm
IHlvdSBhZGQgdGhpcyBwYWdlIHRvIHRoZSBsaW51eCBtYW4tcGFnZXMgcmVwbywgYW5kIHJ1
biANCj4+IHRoZSBsaW50ZXJzLCB5b3UnbGwgc2VlIGEgd2FybmluZyBhYm91dCB0aGF0LsKg
IEluIGNhc2UgeW91J3JlIGludGVyZXN0ZWQgaW4gDQo+PiBsaW50aW5nIG1hbnVhbCBwYWdl
cyBpbiB0aGUgZnV0dXJlLCB5b3UgY2FuIGRvIHNvbWV0aGluZyBzaW1pbGFyIHRvIHdoYXQg
SSBkbyANCj4+IGluIHRoZSBtYW4tcGFnZXNbMl0NCj4gDQo+IE9LLiBJJ3ZlIHVzZWQgaXQs
IGl0J3MgcXVpdGUgdXNlZnVsISBJIGhhdmUgZml4ZWQgYWxsIHdhcm5pbmdzIGV4Y2VwdCBm
b3INCj4gIm1hbmRvYzogbWFuMi9yc2VxLjI6NToxMjogV0FSTklORzogY2Fubm90IHBhcnNl
IGRhdGUsIHVzaW5nIGl0IHZlcmJhdGltOiAoZGF0ZSkiDQo+IHdoaWNoIEkgc3VzcGVjdCBp
cyBleHBlY3RlZC4NCg0KVWhoLCBJIGhhZCB0aGF0IG9uZSBleHBsaWNpdGx5IHNpbGVuY2Vk
Og0KDQokIG1ha2UgbGludC1tYW4tbWFuZG9jIFY9MQ0KTElOVCAobWFuZG9jKQl0bXAvbGlu
dC9tYW4yL3BlcmZfZXZlbnRfb3Blbi4yLmxpbnQtbWFuLm1hbmRvYy50b3VjaA0KISAobWFu
ZG9jIC1tYW4gLVRsaW50ICBtYW4yL3BlcmZfZXZlbnRfb3Blbi4yIDI+JjEgXA0KICAgIHwg
Z3JlcCAtdiAnU1RZTEU6IGxvd2VyIGNhc2UgY2hhcmFjdGVyIGluIGRvY3VtZW50IHRpdGxl
OicgXA0KICAgIHwgZ3JlcCAtdiAnVU5TVVBQOiBpZ25vcmluZyBtYWNybyBpbiB0YWJsZTon
IFwNCiAgICB8IGdyZXAgLXYgJ1dBUk5JTkc6IGNhbm5vdCBwYXJzZSBkYXRlLCB1c2luZyBp
dCB2ZXJiYXRpbTogVEggKGRhdGUpJyBcDQogICAgfCBncmVwIC12ICdXQVJOSU5HOiBlbXB0
eSBibG9jazogVVInIFwNCiAgICB8fDo7IFwNCikgXA0KfCBncmVwICcuJyA+JjINCnRvdWNo
IHRtcC9saW50L21hbjIvcGVyZl9ldmVudF9vcGVuLjIubGludC1tYW4ubWFuZG9jLnRvdWNo
DQoNCg0KRm9yIHNvbWUgcmVhc29uIHlvdSBkaWRuJ3QgaGF2ZSAiVEgiIGluIHRoZSBlcnJv
ciBtZXNzYWdlLCB3aGljaCBpcyB3aHkgbXkgZ3JlcCANCmRpZG4ndCBkaXNjYXJkIGl0Lg0K
DQpbLi4uXQ0KDQo+Pj4gLkJJICJpbnQgc3lzY2FsbChTWVNfcnNlcSwgc3RydWN0IHJzZXEg
Kl9OdWxsYWJsZSAiIHJzZXEgIiwgdWludDMyX3QgIiANCj4+PiByc2VxX2xlbiBcDQo+Pg0K
Pj4gV2hhdCdzIHRoZSBtZWFuaW5nIGZvciBOVUxMP8KgIERvZXMgaXQgaGF2ZSBhIHZhbGlk
IHNlbnRpbmVsIG1lYW5pbmcsIG9yIGlzIGl0IA0KPj4gYW4gaW52YWxpZCBhZGRyZXNzP8Kg
IElmIGl0J3MganVzdCBpbnRlcnByZXRlZCBhcyBhbiBpbnZhbGlkIGFkZHJlc3MgKGZvciB3
aGljaCANCj4+IGZyb20gYSB1c2VyLXNwYWNlIHBlcnNwZWN0aXZlIGEgY3Jhc2ggd291bGQg
YmUgbGVnaXRpbWF0ZSksIHRoZW4gSSdkIHJlbW92ZSANCj4+IF9OdWxsYWJsZS4NCj4gDQo+
IFdpdGggdGhlIGZsYWdzIHRoYXQgYXJlIGN1cnJlbnRseSBpbXBsZW1lbnRlZCAoMCBvciBS
U0VRX0ZMQUdfVU5SRUdJU1RFUiksDQo+IHRoZSByc2VxIGFyZ3VtZW50IGlzIG5vdCBleHBl
Y3RlZCB0byBiZSBsZWdpdGltYXRlbHkgTlVMTCAoaXQgd291bGQgcmV0dXJuDQo+IC0xLCBl
cnJubz1FRkFVTFQgb24gcmVnaXN0cmF0aW9uLCBvciAtMSwgZXJybm89RUlOVkFMIG9uIHVu
cmVnaXN0ZXIgYXR0ZW1wdCkuDQo+IA0KPiBXZSBtYXkgYWRkIG5ldyBmbGFncyBpbiB0aGUg
ZnV0dXJlIHdoaWNoIHdvdWxkIG5vdCBjYXJlIGFib3V0IHRoZSByc2VxIGFkZHJlc3MNCj4g
KGl0IGNvdWxkIHZlcnkgd2VsbCBiZSBudWxsIHRoZW4pLiBEbyB5b3UgcmVjb21tZW5kIHRo
YXQgd2Ugb25seSBhZGQgdGhlDQo+IF9OdWxsYWJsZSB0YWcgd2hlbiB0aGlzIG9jY3VycyA/
DQoNClllczsgc2luY2UgaXQncyB3aGF0IHRoZSB1c2VyIGNhbiBwYXNzLCBpdCBtYWtlcyBz
ZW5zZSB0byBiZSBhcyBjb25zdHJhaW5lZCBhcyANCnBvc3NpYmxlLiAgSWYgaXQgd2VyZSBz
b21lIHJldHVybiB0aGF0IHRoZSB1c2VyIHdvdWxkIGhhdmUgdG8gaW5zcGVjdCwgaXQgd291
bGQgDQptYWtlIHNlbnNlIHRvIGJlIGNhdXRpb3VzIG9uIHRoZSBOVUxMIHNpZGUgb2YgdGhp
bmdzIGFuIHVzZSBfTnVsbGFibGUgDQpwcmV2ZW50aXZlbHksIGJ1dCBmb3IgYW4gaW5wdXQs
IG5vbi1udWxsIGlzIHByZWZlcnJlZCBmb3Igbm93Lg0KDQoNClsuLi5dDQoNCj4gDQo+IFVw
ZGF0ZWQgdmVyc2lvbiBiYXNlZCBvbiB5b3VyIGNvbW1lbnRzIHB1c2hlZCBpbnRvIG15IHJl
cG8sIHRoYW5rcyENCg0KQ29vbCEgSSdsbCBoYXZlIGEgbG9vay4NCg0KQ2hlZXJzLA0KDQpB
bGV4DQoNCj4gDQo+IE1hdGhpZXUNCj4gDQo+IA0KDQotLSANCjxodHRwOi8vd3d3LmFsZWph
bmRyby1jb2xvbWFyLmVzLz4NCg==

--------------C5hnTBVRBRN3VuETDc00N05b--

--------------jlE2rgOjTHkdEuS4D8a1Nx0Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmO9vGMACgkQnowa+77/
2zIvNw//Xw6eBXLFD7+qaoR0K5puVaZDT/UjvFU326JHvlk4OsnL6R32r2XRrj3C
ooqVxxHyfs3rbDZQEErapJe5jh0skr58M0FiFal98pozAdpPnyzIknYzpWFXMKHr
Mb6/4+GBamPjgNQcVAu0EOIvyqIaME7VXFcFVK/5JN7PbpSoTtod/uGaY3RfEo8F
Bdx4KcFToxFnvOK76vXA0NXqgh/56NUM1FqYhDCFOOSLZlLgQFGMZLOPMpmLpNSZ
Yk0bqwMPWZS0aw1hhVp11Z6bVVvWZMwhPdl5GDUvMTRZjNXkAMS1WLiiRYT88JXd
XV+FkT9ljB0w62P3ci5hAJHydZigi/iqpz5Ugaj7J0YTgKrNrj5BdpZc6DrTSDpn
GzavOccU8ObncCsbEE6qBBkGszXNhzgP/vXPL7gSw9x4VAmG6Ktgh3Y/+f7b89t0
kDWngiBQD+4Cxg+YKsdjo0pShAVZdNhiOp/OpIQ/l942cQKtXbmLFNs8R/t+kz6F
eHKGsMcUdMnrqhozPaYRGxRzCDSN00B9YZbWOx+0ea0Cg+9UGZ71QWznW/tsBarO
wpxpsg/W6zcWVuExmV9t5xZl+zpp56voAWM9nK/9Pevm6jU1yuXdt9we/C/WtWV5
zLDrQoQYl0DFMRtww+yF1B2Qm9386i4axGGM4krCJuEJFmNoG6Y=
=taSY
-----END PGP SIGNATURE-----

--------------jlE2rgOjTHkdEuS4D8a1Nx0Y--
