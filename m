Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE565BC30C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:44:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391E1C937
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:44:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E65481FA7E;
        Mon, 19 Sep 2022 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663569860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gn+zgz3kIc+wDFdnrhBXWyfd8Cd2IToofEuWe3kVzy4=;
        b=j9yqxg2TMM3XBVh7jP9MBV0X5rbq0LDE3+1g6VDjzRKUeX5gSQKKNx7W1zPavVYTxqxXdz
        IXKAlLowJIxnsaIFBTK5vYeMcKLBFZq/XRa/83wNKjAMBQt4pBfmbKzCN5Zk2N0R8oXR2W
        BAN4dAuW7pMRS6KGJggyJIVN1ORfRT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663569860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gn+zgz3kIc+wDFdnrhBXWyfd8Cd2IToofEuWe3kVzy4=;
        b=CyOPtCUJlEzhz04bjhjWPO8h8xfgF+CIQX3XJWjETbhumAkrCUREYgusr3OljC1KcGpCit
        3+HZTjMbN+zojaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6D0A13A96;
        Mon, 19 Sep 2022 06:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 58xLN8MPKGO9DwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Sep 2022 06:44:19 +0000
Message-ID: <99314fcf-b886-a7bd-3866-241af6ac9831@suse.de>
Date:   Mon, 19 Sep 2022 08:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: use dirty framebuffer helper
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Cc:     Guchun Chen <guchun.chen@amd.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Fernando Ramos <greenfoo@u92.eu>
References: <20220906195721.143022-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220906195721.143022-1-hamza.mahfooz@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tCX2ivrNVIxf43pa5zK2V7v7"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tCX2ivrNVIxf43pa5zK2V7v7
Content-Type: multipart/mixed; boundary="------------mLZcpfYMWZ06L0dqaUWIhukt";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Cc: Guchun Chen <guchun.chen@amd.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Sean Paul <seanpaul@chromium.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Fernando Ramos <greenfoo@u92.eu>
Message-ID: <99314fcf-b886-a7bd-3866-241af6ac9831@suse.de>
Subject: Re: [PATCH] drm/amdgpu: use dirty framebuffer helper
References: <20220906195721.143022-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220906195721.143022-1-hamza.mahfooz@amd.com>

--------------mLZcpfYMWZ06L0dqaUWIhukt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDYuMDkuMjIgdW0gMjE6NTcgc2NocmllYiBIYW16YSBNYWhmb296Og0KPiBD
dXJyZW50bHksIHdlIGFyZW4ndCBoYW5kbGluZyBEUk1fSU9DVExfTU9ERV9ESVJUWUZCLiBT
bywgdXNlDQo+IGRybV9hdG9taWNfaGVscGVyX2RpcnR5ZmIoKSBhcyB0aGUgZGlydHkgY2Fs
bGJhY2sgaW4gdGhlIGFtZGdwdV9mYl9mdW5jcw0KPiBzdHJ1Y3QuDQoNCmRybV9hdG9taWNf
aGVscGVyX2RpcnR5ZmIoKSBjcmVhdGVzIGEgbmV3IGF0b21pYyBjb21taXQgZm9yIHRoZSAN
CmZyYW1idWZmZXIncyBwbGFuZXMuIERyaXZlcnMgY2FuIHRoZW4gdXBkYXRlcyB0aGVzZSBw
bGFuZXMnIG91dHB1dCANCihlLmcuLCB3cml0ZWJhY2sgdG8gdmlkZW8gbWVtb3J5KS4gSSB0
aG91Z2h0IHRoYXQgYW1kZ3B1IHNpbXBseSBzY2FucyANCm91dCBmcm9tIHRoZSBmcmFtZWJ1
ZmZlcidzIG1lbW9yeSByZWdpb25zIGluIFZSQU0uIFNvIEknbSBjdXJpb3VzIHdoeSANCnRo
aXMgcGF0Y2ggaXMgbmVjZXNzYXJ5Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIYW16YSBNYWhmb296IDxoYW16YS5tYWhmb296QGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5
LmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jDQo+IGlu
ZGV4IGMyMDkyMmE1YWY5Zi4uNWIwOWM4ZjRmZTk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMNCj4gQEAgLTM4LDYgKzM4LDcg
QEANCj4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3Bt
X3J1bnRpbWUuaD4NCj4gICAjaW5jbHVkZSA8ZHJtL2RybV9jcnRjX2hlbHBlci5oPg0KPiAr
I2luY2x1ZGUgPGRybS9kcm1fZGFtYWdlX2hlbHBlci5oPg0KPiAgICNpbmNsdWRlIDxkcm0v
ZHJtX2VkaWQuaD4NCj4gICAjaW5jbHVkZSA8ZHJtL2RybV9nZW1fZnJhbWVidWZmZXJfaGVs
cGVyLmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1fZmJfaGVscGVyLmg+DQo+IEBAIC00OTYs
NiArNDk3LDcgQEAgYm9vbCBhbWRncHVfZGlzcGxheV9kZGNfcHJvYmUoc3RydWN0IGFtZGdw
dV9jb25uZWN0b3IgKmFtZGdwdV9jb25uZWN0b3IsDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVj
dCBkcm1fZnJhbWVidWZmZXJfZnVuY3MgYW1kZ3B1X2ZiX2Z1bmNzID0gew0KPiAgIAkuZGVz
dHJveSA9IGRybV9nZW1fZmJfZGVzdHJveSwNCj4gICAJLmNyZWF0ZV9oYW5kbGUgPSBkcm1f
Z2VtX2ZiX2NyZWF0ZV9oYW5kbGUsDQo+ICsJLmRpcnR5ID0gZHJtX2F0b21pY19oZWxwZXJf
ZGlydHlmYiwNCj4gICB9Ow0KPiAgIA0KPiAgIHVpbnQzMl90IGFtZGdwdV9kaXNwbGF5X3N1
cHBvcnRlZF9kb21haW5zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KDQotLSANClRo
b21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bD
vGhyZXI6IEl2byBUb3Rldg0K

--------------mLZcpfYMWZ06L0dqaUWIhukt--

--------------tCX2ivrNVIxf43pa5zK2V7v7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmMoD8MFAwAAAAAACgkQlh/E3EQov+C7
Cg//SOlbly12jwKhN4c4Bxl/h6HrQiUFL8crVOXnp3rQMcA67Mg5TrGZgrcZAqN7NfeNAhyzy1pa
W6jBdtEkoW9MoiNO9tiW6iSIeEHoPfH07zICJ4lMpIau9RMjIH2WpKBomsd+HCM2wvlc4SDO5tD4
+uWlnMszGkxVqrZSPgcXkoBvKVKCaKPYZI42LJBPWoA7kdl6YpQT/cd1ykyy+9ychGPysbDYpmwq
rQhI5R1KTND0g3C6zPd00ZE3uJ3o1wbJw+yTdz6NgNJbY5h4h9zWJUkKvfH8a7Ayts5fvURN9Jh4
BQ3o7QEdXq66KzJ3cMk1S4D34d7WRDo55nmr5YHCD8hUXLwlrydlslHQOnzOjP3LoHQ4UEM2v0JY
mRTxn/G4sALuclSo4AXV3hMr5Odqp0U/Ci3OYHIEofUY3BKN0iWl9tA1bcEwzU2vYCmAPjajC66G
axsP4hSSdr+FMaBRYqIUB9b3yaJVA5if9RmuDlOSwMDzHTe8woki1CilbjzwNkbVYUDDcspR61bs
ght5LHC/13p6D6RTWS7c+jt6dc1DVreFyi344lF5DUf+2p6qFm1oCSHmB8SDFsWsDigDpv0fCpeN
QTQmdWe0vxOyTZ5QksAXMLeXC9GBwrvxPCjyQgcqhCizrHoT4xTxoxOi662PKtggG2eJDOxooTp1
8LM=
=0FZp
-----END PGP SIGNATURE-----

--------------tCX2ivrNVIxf43pa5zK2V7v7--
