Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB3666001
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbjAKQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjAKQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:05:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02332E83;
        Wed, 11 Jan 2023 08:05:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04C25226AA;
        Wed, 11 Jan 2023 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673453109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XCPUL+3EDU7sS82iSeaj98yFJtfzVgZENcHzMyVDX4=;
        b=Oc1Qki9eqWYxHzfp5MdvSfizQ8nw9DE4TtRgi795Imkho+OnwzauP0nXuSMeUWRnDeJxwI
        jU4wOZhOvBPKsudnVnDC93kL94AHG58s0gN8ZhxeOVrtdEKHqFnYLnagrXodQ8+gPAbISs
        Jpa0PL4Ayoi+H7WJoP8ECtKdNQgfICo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673453109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XCPUL+3EDU7sS82iSeaj98yFJtfzVgZENcHzMyVDX4=;
        b=x5NPQHeQSGXLMhrT05NcMeSY8UjdfJd3vBzfoGj3H2I3UWRSOYyXwzHvlh1i0RYORDcTSX
        yizqVaeaVXCIhZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB67F1358A;
        Wed, 11 Jan 2023 16:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2GCjMDTevmOjRwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 11 Jan 2023 16:05:08 +0000
Message-ID: <589bfc44-1f0b-bc47-fa6d-82c649103157@suse.de>
Date:   Wed, 11 Jan 2023 17:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/11] staging/lynxfb: Use pci aperture helper
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-6-daniel.vetter@ffwll.ch>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230111154112.90575-6-daniel.vetter@ffwll.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rTFfI0YmBvq3sJgXEDg0LdE8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rTFfI0YmBvq3sJgXEDg0LdE8
Content-Type: multipart/mixed; boundary="------------gH6OK02xNlN0cQm8NAddKGWH";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Vetter
 <daniel.vetter@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org
Message-ID: <589bfc44-1f0b-bc47-fa6d-82c649103157@suse.de>
Subject: Re: [PATCH 06/11] staging/lynxfb: Use pci aperture helper
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-6-daniel.vetter@ffwll.ch>
In-Reply-To: <20230111154112.90575-6-daniel.vetter@ffwll.ch>

--------------gH6OK02xNlN0cQm8NAddKGWH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDEuMjMgdW0gMTY6NDEgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBJ
dCBleGlzdHMhIE5vdGUgdGhhdCBzaW5jZSB0aGlzIGlzIGFuIGV4YWN0IGNvcHksIHRoZXJl
IHNob3VsZG4ndCBiZQ0KPiBhbnkgZnVuY3Rpb25hbCBkaWZmZXJlbmNlIGhlcmUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNv
bT4NCj4gQ2M6IFN1ZGlwIE11a2hlcmplZSA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+
DQo+IENjOiBUZWRkeSBXYW5nIDx0ZWRkeS53YW5nQHNpbGljb25tb3Rpb24uY29tPg0KPiBD
YzogbGludXgtZmJkZXZAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3Rh
Z2luZy9zbTc1MGZiL3NtNzUwLmMgfCAxNiArLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvc203NTBmYi9zbTc1MC5jIGIvZHJpdmVycy9zdGFn
aW5nL3NtNzUwZmIvc203NTAuYw0KPiBpbmRleCBlZmZjN2ZjYzM3MDMuLjIyYWNlMzE2ODcy
MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3NtNzUwZmIvc203NTAuYw0KPiAr
KysgYi9kcml2ZXJzL3N0YWdpbmcvc203NTBmYi9zbTc1MC5jDQo+IEBAIC05ODksMjAgKzk4
OSw2IEBAIHN0YXRpYyBpbnQgc203NTBmYl9mcmFtZWJ1ZmZlcl9hbGxvYyhzdHJ1Y3Qgc203
NTBfZGV2ICpzbTc1MF9kZXYsIGludCBmYmlkeCkNCj4gICAJcmV0dXJuIGVycjsNCj4gICB9
DQo+ICAgDQo+IC1zdGF0aWMgaW50IGx5bnhmYl9raWNrX291dF9maXJtd2FyZV9mYihzdHJ1
Y3QgcGNpX2RldiAqcGRldikNCj4gLXsNCj4gLQlyZXNvdXJjZV9zaXplX3QgYmFzZSA9IHBj
aV9yZXNvdXJjZV9zdGFydChwZGV2LCAwKTsNCj4gLQlyZXNvdXJjZV9zaXplX3Qgc2l6ZSA9
IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgMCk7DQo+IC0JYm9vbCBwcmltYXJ5ID0gZmFsc2U7
DQo+IC0NCj4gLSNpZmRlZiBDT05GSUdfWDg2DQo+IC0JcHJpbWFyeSA9IHBkZXYtPnJlc291
cmNlW1BDSV9ST01fUkVTT1VSQ0VdLmZsYWdzICYNCj4gLQkJCQkJSU9SRVNPVVJDRV9ST01f
U0hBRE9XOw0KPiAtI2VuZGlmDQo+IC0NCj4gLQlyZXR1cm4gYXBlcnR1cmVfcmVtb3ZlX2Nv
bmZsaWN0aW5nX2RldmljZXMoYmFzZSwgc2l6ZSwgcHJpbWFyeSwgInNtNzUwX2ZiMSIpOw0K
DQpUaGlzIHN0aWxsIGhhZCB0aGUgcHJpbWFyeSBhcmd1bWVudCwgaXQgbmVlZHMgdG8gYmUg
aGFuZGxlZCBpbiBhbiBlYXJseSANCnBhdGNoIGluIHNvbWUgd2F5Lg0KDQo+IC19DQo+IC0N
Cj4gICBzdGF0aWMgaW50IGx5bnhmYl9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
DQo+ICAgCQkJICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQo+ICAgew0K
PiBAQCAtMTAxMSw3ICs5OTcsNyBAQCBzdGF0aWMgaW50IGx5bnhmYl9wY2lfcHJvYmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsDQo+ICAgCWludCBmYmlkeDsNCj4gICAJaW50IGVycjsNCj4g
ICANCj4gLQllcnIgPSBseW54ZmJfa2lja19vdXRfZmlybXdhcmVfZmIocGRldik7DQo+ICsJ
ZXJyID0gYXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX3BjaV9kZXZpY2VzKHBkZXYsICJz
bTc1MF9mYjEiKTsNCj4gICAJaWYgKGVycikNCj4gICAJCXJldHVybiBlcnI7DQo+ICAgDQoN
Ci0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNj
aMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------gH6OK02xNlN0cQm8NAddKGWH--

--------------rTFfI0YmBvq3sJgXEDg0LdE8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmO+3jQFAwAAAAAACgkQlh/E3EQov+Cc
Vw//brjFyTpMYks/M9yZZZbWP30cyO7nusq3XS6pvb4vYAlErb9NOKl31dsd1OrASobM4Y262Om/
pNzbDoYy5Dx4sOmjIm07dKt1EHT98th/g40LWLPI5uPYjh8K9NrjfxuW+ooTOa1szTexHYjQADjK
i37R9OUeWhmTjQnTR9FKvIn39qd0dkmegLimQotw5tI/T1S1ypZxlhEjaanQ69z5DqqRX34YgOp4
leXJkDJf3YVoFBH3glt+P8TB2ohBzuxMqUVkMbqYySDGKIf0AHgmW5uOk5Xl2M7edoWU0e8cPIv7
9VRfbdT9b5hN3qqOdEi4SNTArjH5zwzq6W9dpIuSwp/SisSrtWMGKGkJnjfbuOsPmMUOieMx44Fg
SIqD11bq2rvgjFvUzRnYbLXAOlHArfyCbZ6tzOhxL+faT1leXsZD6FgvMrbOl15HxIfh78nekXEo
lFGT/LHFogGeJcBor9RP9U2I7PRVVeqP9gXzNsjhCif0o7r8cUpF1/qjF2PA15Rjnx2PUZgmm19t
nkEqEzhjBKTdgZReNMcjM52RDwACHEyUYsaVhm8iYaU9hdfMHgxVL6ASdcJU4yDWN7PMOv1xzEl2
YV73d+bI4tgoCaONipNEA4bPoN7MNpDJ7Y2JdeE+1OeQzXCx2SLAwVAix2DHSt3zHqjHKWCgivOH
kkw=
=gr1x
-----END PGP SIGNATURE-----

--------------rTFfI0YmBvq3sJgXEDg0LdE8--
