Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141974D399
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGJKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGJKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:36:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8DB2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:36:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E0E221FA9;
        Mon, 10 Jul 2023 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688985381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LV1LKUmvIMNh2Vo0jzMN3j+vETkIgXfvGP1+vvdJuZI=;
        b=qlKDSk1lomfaoqwWXDiHidh7pLSk2Crtqh3+C9qPa4Z3bjo1emaiuqpzUSSX+d77ylIbMr
        XUF9/0huTuw1yk3R0OnKMVErOw+CtAm+hxG0Gkq9P0qJJJ+pDjes2uCb+YgJ3MtNlWjd6B
        yX4Oc13tmyt20w0zTnOTyq+cKt0NegQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688985381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LV1LKUmvIMNh2Vo0jzMN3j+vETkIgXfvGP1+vvdJuZI=;
        b=XMM5w6o7QBMWkexxyMfObAJa1R/i0dPdAVm/AwXB2+96dfQNtXiC1M4nVYoEe7huqSu4tE
        u4WMv+Oq5vPnveDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5490413A05;
        Mon, 10 Jul 2023 10:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FI2+EyXfq2TJRwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 10 Jul 2023 10:36:21 +0000
Message-ID: <3742bddc-51b5-71c9-4d4a-ec15d17a515a@suse.de>
Date:   Mon, 10 Jul 2023 12:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/loongson: Fix two warnings because of passing wrong
 type
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230710100931.255234-1-suijingfeng@loongson.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230710100931.255234-1-suijingfeng@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------H0lHvJ02IpdYkLeJ8hNpr7pB"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------H0lHvJ02IpdYkLeJ8hNpr7pB
Content-Type: multipart/mixed; boundary="------------ua0IFvBBwBv1Ofknimgs1SDJ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <suijingfeng@loongson.cn>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn, kernel test robot <lkp@intel.com>
Message-ID: <3742bddc-51b5-71c9-4d4a-ec15d17a515a@suse.de>
Subject: Re: [PATCH] drm/loongson: Fix two warnings because of passing wrong
 type
References: <20230710100931.255234-1-suijingfeng@loongson.cn>
In-Reply-To: <20230710100931.255234-1-suijingfeng@loongson.cn>

--------------ua0IFvBBwBv1Ofknimgs1SDJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTAuMDcuMjMgdW0gMTI6MDkgc2NocmllYiBTdWkgSmluZ2Zlbmc6DQo+IFdo
ZW4gYWNjZXNzaW5nIEkvTyBtZW1vcnksIHdlIHNob3VsZCBwYXNzICdfX2lvbWVtIConIHR5
cGUgaW5zdGVhZCBvZg0KPiAndm9pZCAqJyBzaW1wbHksIG90aGVyd2lzZSBzcGFyc2UgdGVz
dHMgd2lsbCBjb21wbGFpbi4gQWZ0ZXIgYXBwbGllZA0KPiB0aGlzIHBhdGNoLCB0aGUgZm9s
bG93aW5nIHR3byBzcGFyc2Ugd2FybmluZ3MgZ290IGZpeGVkLg0KPiANCj4gMSkgZHJpdmVy
cy9ncHUvZHJtL2xvb25nc29uL2xzZGNfYmVuY2htYXJrLmM6Mjc6MzU6DQo+ICAgICBzcGFy
c2U6ICAgICBleHBlY3RlZCB2b2lkIHZvbGF0aWxlIFtub2RlcmVmXSBfX2lvbWVtICoNCj4g
ICAgIHNwYXJzZTogICAgIGdvdCB2b2lkICprcHRyDQo+IA0KPiAyKSBkcml2ZXJzL2dwdS9k
cm0vbG9vbmdzb24vbHNkY19iZW5jaG1hcmsuYzo0Mjo1MToNCj4gICAgIHNwYXJzZTogICAg
IGV4cGVjdGVkIHZvaWQgY29uc3Qgdm9sYXRpbGUgW25vZGVyZWZdIF9faW9tZW0gKg0KPiAg
ICAgc3BhcnNlOiAgICAgZ290IHZvaWQgKmtwdHINCj4gDQo+IFJlcG9ydGVkLWJ5OiBrZXJu
ZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwNzEwMDI0My52M2h2NmFlcy1sa3BAaW50
ZWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1aWppbmdmZW5nQGxv
b25nc29uLmNuPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vbG9vbmdzb24vbHNkY19i
ZW5jaG1hcmsuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2xvb25nc29uL2xzZGNfYmVuY2htYXJrLmMgYi9kcml2ZXJzL2dwdS9kcm0vbG9vbmdzb24v
bHNkY19iZW5jaG1hcmsuYw0KPiBpbmRleCBiMDg4NjQ2YTJmZjkuLjM2ZTM1MjgyMGJkYiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2xvb25nc29uL2xzZGNfYmVuY2htYXJr
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2xvb25nc29uL2xzZGNfYmVuY2htYXJrLmMN
Cj4gQEAgLTI0LDcgKzI0LDcgQEAgc3RhdGljIHZvaWQgbHNkY19jb3B5X2d0dF90b192cmFt
X2NwdShzdHJ1Y3QgbHNkY19ibyAqc3JjX2JvLA0KPiAgIAlsc2RjX2JvX2ttYXAoZHN0X2Jv
KTsNCj4gICANCj4gICAJd2hpbGUgKG4tLSkNCj4gLQkJbWVtY3B5X3RvaW8oZHN0X2JvLT5r
cHRyLCBzcmNfYm8tPmtwdHIsIHNpemUpOw0KPiArCQltZW1jcHlfdG9pbygodm9pZCBfX2lv
bWVtICopZHN0X2JvLT5rcHRyLCBzcmNfYm8tPmtwdHIsIHNpemUpOw0KDQpJZiB0aGlzIGlz
IEkvTyBtZW1vcnksIGJldHRlciBhZGQgdGhlIF9faW9tZW0gcXVhbGlmaWVyIHRvIGRzdF9i
by0+a3B0ciANCnJhdGhlciB0aGFuIGNhc3RpbmcgaGVyZS4gSWYgaWYgY2FuIGJlIGJvdGgs
IHlvdSBjb3VsZCB1c2UgYW4gdW5uYW1lZCANCnVuaW9uIGxpa2UgdGhpczoNCg0Kc3RydWN0
IGxzY2RfYm8gew0KICAgdW5pb24gew0KICAgICB2b2lkIF9faW9tZW0gKmtwdHJfaW9tZW07
DQogICAgIHZvaWQgKmtwdHI7DQogICB9Ow0KfTsNCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMN
Cg0KPiAgIA0KPiAgIAlsc2RjX2JvX2t1bm1hcChzcmNfYm8pOw0KPiAgIAlsc2RjX2JvX2t1
bm1hcChkc3RfYm8pOw0KPiBAQCAtMzksNyArMzksNyBAQCBzdGF0aWMgdm9pZCBsc2RjX2Nv
cHlfdnJhbV90b19ndHRfY3B1KHN0cnVjdCBsc2RjX2JvICpzcmNfYm8sDQo+ICAgCWxzZGNf
Ym9fa21hcChkc3RfYm8pOw0KPiAgIA0KPiAgIAl3aGlsZSAobi0tKQ0KPiAtCQltZW1jcHlf
ZnJvbWlvKGRzdF9iby0+a3B0ciwgc3JjX2JvLT5rcHRyLCBzaXplKTsNCj4gKwkJbWVtY3B5
X2Zyb21pbyhkc3RfYm8tPmtwdHIsICh2b2lkIF9faW9tZW0gKilzcmNfYm8tPmtwdHIsIHNp
emUpOw0KPiAgIA0KPiAgIAlsc2RjX2JvX2t1bm1hcChzcmNfYm8pOw0KPiAgIAlsc2RjX2Jv
X2t1bm1hcChkc3RfYm8pOw0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBE
cml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgN
CkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZv
IFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFu
DQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------ua0IFvBBwBv1Ofknimgs1SDJ--

--------------H0lHvJ02IpdYkLeJ8hNpr7pB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSr3yQFAwAAAAAACgkQlh/E3EQov+DB
4BAAgwDl8dkac/6+Schhr9P/9NNbkMep5bqGCqe5m7KFSIGuM910n6ZoX1ZrBKpJ7mu8JWLcouT/
PdyV6LftWuUNpeWFYJ7mrQuULgBtvbeltHWreM+BR6w4Ivvl6qmOo51TtB0NxtGYLHjxUflcF+ID
r7j006jnRBzdLoQvjSHMMVfzoPMkTr7kWIRdBvfKGUmrZgAfYXNuVYZk+WEfQlKAVpVi/h0AMSpc
IHNekEuHzGCXLrzjjGKq/fDUOZnZihKA/7n0ka96sfrYYR320KhqnZ7DVT4fT/xscyPsjbRyqiSs
831Lqacfbq1M2VYgP6u0RiE8dSuWidkHNU+fJYSp3NJDYf2mvN7rsrdTfbrNILrzUtEjAJJXzjod
a3mM+72eY8EOOUyiplKdry706U0iVEMLvV17Npyv2Mry2DpKkPp+2kb4C+Khao9THsdix+3rDuAX
yE0u17Ag8XIMOB3gNZoD4xtw6vAwvn7lKVFT4hnJJN7QfYflrt6U1HGH+81lNLlT8hTddNOJXamq
b7HVEX2B9lrvc2UOPKAqHKTkKOKirlsldPtYPkvVOFc+EqjJ0GINldB9E5cmU5YO1AG++H1jXxda
CctOOlwMWnFJ8cCnKIiEQxlBr9LZ4oRnIRxoRyxr1n2yt76CVBhiRSWUg1aAuhXPBhrBooj21B+e
EoA=
=dlJA
-----END PGP SIGNATURE-----

--------------H0lHvJ02IpdYkLeJ8hNpr7pB--
