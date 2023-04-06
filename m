Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB36D94D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbjDFLPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDFLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:15:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A6E6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:15:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 528D51FED2;
        Thu,  6 Apr 2023 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680779728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24m7oiUZdERwR0bAk2uGjiiwrQhLKxWnRTtyLj8jgLQ=;
        b=XW2ZGOKx2vjC9rjn/4YizCkqnL09EiNgGT89mB16A4EsGCU09bZOHptuMr5kfc58zhVYCN
        M3lIxMX0oNyKg6jrjy3Jke5FmHh3KFWEs6Ztx9AzEzDy7K0L6988cOO2v5tyz/2Y9kvnXQ
        Lcv0nxugAQMwZuOUDYNEjaV5k/fCVfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680779728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24m7oiUZdERwR0bAk2uGjiiwrQhLKxWnRTtyLj8jgLQ=;
        b=BhClUP3VzliyflcBv138s6m4SyboTRx6OvHUNb4A2LBpDwdVVAJuerivhvYxTZQkJLz90T
        CyqdOa0+NQh2Q2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C83E133E5;
        Thu,  6 Apr 2023 11:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LaTOBdCpLmS5PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Apr 2023 11:15:28 +0000
Message-ID: <b1945325-d662-dece-93bd-af77c92a2cdc@suse.de>
Date:   Thu, 6 Apr 2023 13:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] drm/vkms: A couple of trivial cleanups
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230406110235.3092055-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NRXLk0sQbn05CuutGW2uWRhu"
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NRXLk0sQbn05CuutGW2uWRhu
Content-Type: multipart/mixed; boundary="------------Z04pnDURB9kYva3fNMUXMM0E";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
 Marius Vlad <marius.vlad@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 dri-devel@lists.freedesktop.org
Message-ID: <b1945325-d662-dece-93bd-af77c92a2cdc@suse.de>
Subject: Re: [PATCH 0/2] drm/vkms: A couple of trivial cleanups
References: <20230406110235.3092055-1-javierm@redhat.com>
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>

--------------Z04pnDURB9kYva3fNMUXMM0E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KDQpmb3IgdGhlIHNlcmllcy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KQW0g
MDYuMDQuMjMgdW0gMTM6MDIgc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2FuaWxsYXM6DQo+
IEhlbGxvLA0KPiANCj4gVGhpcyBzZXJpZXMgY29udGFpbnMgdHdvIHRyaXZpYWwgY2xlYW51
cHMgZm9yIHRoZSB2a21zIGRyaXZlci4NCj4gDQo+IFBhdGNoICMxIGp1c3QgZ2V0cyByaWQg
b2YgYSB3cmFwcGVyIGhlbHBlciB0aGF0IHdhc24ndCByZWFsbHkgYWRkaW5nIHRoYXQNCj4g
bXVjaCB2YWx1ZSBhbmQgcGF0Y2ggIzIgZHJvcHMgdGhlIDxkcm0vZHJtX3NpbXBsZV9rbXNf
aGVscGVyLmg+IGhlYWRlcg0KPiB0aGF0IHdhcyBvbmx5IHVzZWQgdG8gY2FsbCB0aGUgZHJt
X3NpbXBsZV9lbmNvZGVyX2luaXQoKSBmdW5jdGlvbiBoZWxwZXIuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEphdmllcg0KPiANCj4gDQo+IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyAo
Mik6DQo+ICAgIGRybS92a21zOiBEcm9wIHZrbXNfY29ubmVjdG9yX2Rlc3Ryb3koKSB3cmFw
cGVyDQo+ICAgIGRybS92a21zOiBSZW1vdmUgPGRybS9kcm1fc2ltcGxlX2ttc19oZWxwZXIu
aD4gaW5jbHVkZQ0KPiANCj4gICBkcml2ZXJzL2dwdS9kcm0vdmttcy92a21zX291dHB1dC5j
IHwgMTUgKysrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiBiYXNlLWNvbW1pdDogNzdkMDhhMmRl
NmE0MzUyMWY1YTAyODQ4ZjExMTg1YjZmNDZhZjIxYw0KDQotLSANClRob21hcyBaaW1tZXJt
YW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFu
eQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBU
b3Rldg0K

--------------Z04pnDURB9kYva3fNMUXMM0E--

--------------NRXLk0sQbn05CuutGW2uWRhu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQuqc8FAwAAAAAACgkQlh/E3EQov+CZ
pxAAl2ymufGdLxPIFGZa9gXVj1mjMWs757j+OGe0hMrGkDUHWfVlyhV0gbJb1OkhGny5CdRpToZf
t6NJXPq9TiZPJImjZ2+pCk8dQrXsc/Q1RN4S7pQet6FecETSqA2+dsTIKyxbSMLi5bIusvABokK8
PbbmcrW9EskxBgxGyUmRJU+2Go2kCBrwt4BQS+tbzMDL6Pn5/kPPp/dCwbQeVNgyyZ6Sv3+b5bBS
QgQmgKBjutHHgZu9BY+nkmaEwKG8QcJ1T9T8WWbmVv0uaNI9mvoPFlHZMSXaUd147Bzb3jWBGSQ3
mzQ/RaBHxhg+YcIynO5XVefbsueXxqRVdE/4ixnREIymKlukmTaASlyXxI1UzQNiBB26VHFDZ+WJ
3GegPCnr7JzcZW5jHYCqsH0JbYnH0JDA9ZKohgwScnkbHLrZl63vawXQwF9MB/jUoGeH/nyzgXAr
AyKZ5AG7Gyt9fs4psxz8ndUTDgASH715sGv2qLH9C0ak7NhDm/ODP2IwhuCDeI9v7FebM29/tura
n+6aDbMrvdoqPSpZnHhfD0Hu8MjwMjiZ+ZCSwe1KL592qjitUlb2XxKMvcWLwDzZDRQFWt9w8Uo2
RFIh4aW2W6Q/MFjdc55qZgzsbZ3ELlIck9hyAnA67zXpFWin+aQRiIA1AtZCZbphHiixENSNIIBl
4RM=
=Kk5B
-----END PGP SIGNATURE-----

--------------NRXLk0sQbn05CuutGW2uWRhu--
