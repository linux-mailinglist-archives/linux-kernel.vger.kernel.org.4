Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DF70610A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEQHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEQHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:24:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72008110
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:24:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBB41222E3;
        Wed, 17 May 2023 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684308244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PiEFThpZMX1fwAg1ibrqioFtbtD24TZ4UiQ6URGOwI=;
        b=hPN+0nYUQXPLpyPWU8sgx0/1wMgnm97EmASRgEhdU7IgmasLaKrw5lfxRUSZeWfSxJy2tb
        WWVZ18kzEV3u1V+cV+fMB6uJj7RqEfgaJ+Yi77yjJ6Rt80Av2fvdkETaQfsDtbiV1dyRdX
        C11aS2xvDMKQe9Rc/B1heqrnmQ89l8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684308244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PiEFThpZMX1fwAg1ibrqioFtbtD24TZ4UiQ6URGOwI=;
        b=rYzcd5U8TOTVW8GahveUkbQmFBYRRYtaUdvw0wMMhDhEWwtTY6zb8YaBe4CHN2vG5fxS8D
        zJUK0XrwaozyNECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EEB113478;
        Wed, 17 May 2023 07:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T8ODJRSBZGTqCgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 17 May 2023 07:24:04 +0000
Message-ID: <40689882-6771-97c7-f771-d57ceefd052a@suse.de>
Date:   Wed, 17 May 2023 09:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] drm/drm_atomic_helper.c: fix a typo
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sui Jingfeng <15330273260@189.cn>
References: <20230517041602.3225325-1-suijingfeng@loongson.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230517041602.3225325-1-suijingfeng@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0iThGoVUUDEsQ0zbkacndXD4"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0iThGoVUUDEsQ0zbkacndXD4
Content-Type: multipart/mixed; boundary="------------Hbaqg3Tqaxl7stRw81ysETmF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <suijingfeng@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Sui Jingfeng <15330273260@189.cn>
Message-ID: <40689882-6771-97c7-f771-d57ceefd052a@suse.de>
Subject: Re: [PATCH] drm/drm_atomic_helper.c: fix a typo
References: <20230517041602.3225325-1-suijingfeng@loongson.cn>
In-Reply-To: <20230517041602.3225325-1-suijingfeng@loongson.cn>

--------------Hbaqg3Tqaxl7stRw81ysETmF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TWVyZ2VkLiBUaGFua3MgYSBsb3QuDQoNCkFtIDE3LjA1LjIzIHVtIDA2OjE2IHNjaHJpZWIg
U3VpIEppbmdmZW5nOg0KPiBGcm9tOiBTdWkgSmluZ2ZlbmcgPDE1MzMwMjczMjYwQDE4OS5j
bj4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN1aSBKaW5nZmVuZyA8c3VpamluZ2ZlbmdAbG9v
bmdzb24uY24+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBl
ci5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWlj
X2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMNCj4gaW5k
ZXggZTBhYjU1NWFhZDJjLi40MWI4MDY2ZjYxZmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9k
cm1fYXRvbWljX2hlbHBlci5jDQo+IEBAIC0zMTU0LDcgKzMxNTQsNyBAQCBpbnQgZHJtX2F0
b21pY19oZWxwZXJfdXBkYXRlX3BsYW5lKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiAg
IEVYUE9SVF9TWU1CT0woZHJtX2F0b21pY19oZWxwZXJfdXBkYXRlX3BsYW5lKTsNCj4gICAN
Cj4gICAvKioNCj4gLSAqIGRybV9hdG9taWNfaGVscGVyX2Rpc2FibGVfcGxhbmUgLSBIZWxw
ZXIgZm9yIHByaW1hcnkgcGxhbmUgZGlzYWJsZSB1c2luZyAqIGF0b21pYw0KPiArICogZHJt
X2F0b21pY19oZWxwZXJfZGlzYWJsZV9wbGFuZSAtIEhlbHBlciBmb3IgcHJpbWFyeSBwbGFu
ZSBkaXNhYmxlIHVzaW5nIGF0b21pYw0KPiAgICAqIEBwbGFuZTogcGxhbmUgdG8gZGlzYWJs
ZQ0KPiAgICAqIEBjdHg6IGxvY2sgYWNxdWlyZSBjb250ZXh0DQo+ICAgICoNCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYx
IE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRy
ZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcp
DQo=

--------------Hbaqg3Tqaxl7stRw81ysETmF--

--------------0iThGoVUUDEsQ0zbkacndXD4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRkgRQFAwAAAAAACgkQlh/E3EQov+BH
1xAAmDLLFNXBszMdvotO+u2QzOe1+3aeuRWyw3r6SyXtaVtuO2o7TCJv8huapWv6RwJVnM6Opk+Q
T+PltmOfR9nTVyfkCLr7QiQFfjzI+ZjmjiQIxh9LBJgRcIrIGWnQMU/tWuDt9grI63mhWwAzPF/j
qDS0HEIBCqyeUHdn7a1JyBbNRs5fh5NwAc/m3vOf2T/vIqY73AjmUoBXLOVP09eVXZu8Lom0in2I
AJFtYreQ6HGsTCe0hMqwmtf60SFpUlWOc8Bii6IcgnTQkb+3paCRaFtaDFfp/pxSRAOFcwuYOBlk
0hi6q+Bi5SKIbQUsZ2zmsPUZyLo1JBXqZnLDKV9yIb8kit0pjxKfIcKLhmPPT9ej8JvK4XXAOmqD
fFg0jQ5DrcHpbojaoVbl346yWVY0xgqlAY79eAoiTKALbVwWzIAfc2ciDDJt0z+qwG0Aon8XB2ES
8ocYmJjFXZgdQXl7QGvtVxN93UMDC5bonbeL9++u4FGzv6osOfJjffcrql3VBORl2nYpXn6mpB9g
17Aa47balptJsrCBGaNTY1/BPgGrFYj6qLVthySL2s/2BDMU4ajU/lVz1bi/wXYO2NayB9ahyjee
UFgdGldEhLi18xarvQUQ5lb4YE6f/IOkz/gv9zaq2mWkcghEgd4jiSVzi/zK3x7R2pedachEX3Xl
VAo=
=b5go
-----END PGP SIGNATURE-----

--------------0iThGoVUUDEsQ0zbkacndXD4--
