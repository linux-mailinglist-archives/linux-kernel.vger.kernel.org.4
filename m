Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F868294C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAaJoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjAaJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:43:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0E6A63;
        Tue, 31 Jan 2023 01:43:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 928A9204DC;
        Tue, 31 Jan 2023 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675158160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vatAf4PA7oDC3qG6Ue8FoZZjsEq4Bdh1B0/k8ZQrTUg=;
        b=gMhWmTrc01TgLLV8/IeGhnFBJM4GcUYvw4lY4dB1//uRSyA/Gg5OACxbr1kveVnuJANNPG
        4J0JY8QnzqABcd7bhm28E78+rsyHH2TTlcKBv/CSUD4kBycejiP6IrTv7rhyLtLf68CgB7
        Y2sMD7oWVorTHewyxaIYO7EZDk0ME4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675158160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vatAf4PA7oDC3qG6Ue8FoZZjsEq4Bdh1B0/k8ZQrTUg=;
        b=GLY2i5COFd94mFE4jR18lrRkUMnnzt9idGAB9CoC3pHu3qqdeEh0kSlhsoOuUg+/+Q6NAd
        uTz6Ov8dMKEExpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB6F138E8;
        Tue, 31 Jan 2023 09:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6jAfEpDi2GMAOgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 31 Jan 2023 09:42:40 +0000
Message-ID: <6f63f1cc-ba33-2253-cd90-e01285bc6ff1@suse.de>
Date:   Tue, 31 Jan 2023 10:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/2] SimpleDRM: allow configuring physical width and
 height
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20230126182435.70544-1-rayyan@ansari.sh>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230126182435.70544-1-rayyan@ansari.sh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vKdGn7SnPXKMfMFUmfsmOGd5"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vKdGn7SnPXKMfMFUmfsmOGd5
Content-Type: multipart/mixed; boundary="------------0RUuxtggqXskTXKOjH6pMaNX";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Rayyan Ansari <rayyan@ansari.sh>, dri-devel@lists.freedesktop.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
 janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>
Message-ID: <6f63f1cc-ba33-2253-cd90-e01285bc6ff1@suse.de>
Subject: Re: [PATCH v4 0/2] SimpleDRM: allow configuring physical width and
 height
References: <20230126182435.70544-1-rayyan@ansari.sh>
In-Reply-To: <20230126182435.70544-1-rayyan@ansari.sh>

--------------0RUuxtggqXskTXKOjH6pMaNX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCnRoYW5rcyBhIGxvdC4gSSd2ZSBhZGRlZCB5b3VyIHBhdGNoZXMgdG8gZHJtLW1p
c2MtbmV4dC4gVGhleSBzaG91bGQgYmUgDQppbiBMaW51eCB2Ni40Lg0KDQpCZXN0IHJlZ2Fy
ZHMNClRob21hcw0KDQpBbSAyNi4wMS4yMyB1bSAxOToyNCBzY2hyaWViIFJheXlhbiBBbnNh
cmk6DQo+IEhlbGxvLA0KPiANCj4gVGhlIGZvbGxvd2luZyBwYXRjaGVzOg0KPiAtIEFkZCBz
dXBwb3J0IGZvciBjb25maWd1cmluZyB0aGUgd2lkdGgtbW0gYW5kIGhlaWdodC1tbSBEUk0g
bW9kZQ0KPiAgICBwcm9wZXJ0aWVzIGluIHRoZSBTaW1wbGVEUk0gZHJpdmVyIHZpYSBEZXZp
Y2UgVHJlZQ0KPiAtIERvY3VtZW50IHRoZXNlIHR3byBuZXcgRGV2aWNlIFRyZWUgcHJvcGVy
dGllcw0KPiANCj4gVGhpcyBpcyB1c2VmdWwgZm9yIGFsbG93aW5nIGludGVyZmFjZXMgc3Vj
aCBhcyBQaG9zaCB0byBjYWxjdWxhdGUNCj4gcHJvcGVyIHNjYWxpbmcgdmFsdWVzIGFuZCBm
b3IgZWFybHkgYm9vdCBjb2RlIGtub3dpbmcgaWYgaGktZHBpDQo+IHJlbmRlcmluZyBpcyBu
ZWNlc3NhcnkuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiAtIFVzZSBwYW5lbCBub2Rl
DQo+IA0KPiBSYXl5YW4gQW5zYXJpICgyKToNCj4gICAgZHJtL3NpbXBsZWRybTogQWxsb3cg
cGh5c2ljYWwgd2lkdGggYW5kIGhlaWdodCBjb25maWd1cmF0aW9uIHZpYSBwYW5lbA0KPiAg
ICAgIG5vZGUNCj4gICAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IHNpbXBsZS1mcmFtZWJ1ZmZl
cjogRG9jdW1lbnQgdGhlIHBhbmVsIG5vZGUNCj4gDQo+ICAgLi4uL2JpbmRpbmdzL2Rpc3Bs
YXkvc2ltcGxlLWZyYW1lYnVmZmVyLnlhbWwgIHwgIDkgKysrKysrDQo+ICAgZHJpdmVycy9n
cHUvZHJtL3Rpbnkvc2ltcGxlZHJtLmMgICAgICAgICAgICAgIHwgMzIgKysrKysrKysrKysr
Ky0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZl
ciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBO
w7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------0RUuxtggqXskTXKOjH6pMaNX--

--------------vKdGn7SnPXKMfMFUmfsmOGd5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPY4o8FAwAAAAAACgkQlh/E3EQov+AE
dA//fz/G8qQwPJkI47+I8GMBOVSE0os63R/mcfTCuVXyWtQhEOUBELIoW99tguWlMkflPXxOMVfw
1H18lB5liJ1wmzTb8lOdXmvA8sgpdjWnyJ7buKNIZIKPGmorPF4fHa6Wxk+Uko9Qemz4f9r6z9eN
2OzEk+OPbUvApCF9tAm3q8+8Yazzb4O1gypgjzOmEA0cfP6plSNMJXTfSbFMUaZngHFNH0arC3OR
NnLhIqgt255hOJhr1isUebefE8Gj98QAnPuIqBQ2r7k6vVQ1qAt7kyuhcYuELaFuMS/koioVzgng
/oIejnRrCgw6Y9L/NWwA0RJB76Ju0CMs0kYYL7Pr6zr380TU7NN+hOq8op7lk8B7czIvgDg1hmi3
kBAeTnsuxnSdQA8POeOEgJWaPb15LsL5gBzFlZGmJnLmwRDJ9JLtvQ+ybiY9EUlDDr0nCXBN/fPy
Wn3tBkGEJ6D4LLB1z9FrRhJuEE/j1/4VFSNyUXbYIhpx5qsuPSulwIBr7fET/fyvCSp8O55mhOOb
2WDM9yUQXTnpPGsnQ9F0ZlKLMV4tIT/kt0FxVe230F+la3nVsUIbdMmU3e6dRRYsVFd8mWmPqonm
sY86vsrN/xjQOpDjRsJL8hImirw0ponZB4d4qXbTvGz/dVywnCOAriHDtAfmoM61EPVXUVkAK1qe
wu0=
=+yZq
-----END PGP SIGNATURE-----

--------------vKdGn7SnPXKMfMFUmfsmOGd5--
