Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7122265AF95
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjABKda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjABKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:33:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DF101D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:33:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 632FA33CB9;
        Mon,  2 Jan 2023 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672655604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eJsI75I6VbxlBLahJnyhSDORTntl8iYiCh6UpDGQDg=;
        b=XsQUEXCvumvUT262KQ2TnE8E68dkxKw24C8f4cfhPAqy1N1Rjy0qRTARuGyA5YDc7ZpkfQ
        UmuI12hsL7Gk0pjbWeyNhGw0DVNaPtBpKrxck6BhE4J1leAOsU3C2SywbrWlOFSeP8uGoR
        beliBRVyyqYZhdykSqmcDsfJNHcrlOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672655604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eJsI75I6VbxlBLahJnyhSDORTntl8iYiCh6UpDGQDg=;
        b=eTkSufnMs6O53Bjsc6rFYGFG4747AgmbxhTcjaqzPQydrAQJ0m+lqtx75aupkbOt/Un4j7
        uu/dzs7zuI4w2QBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 274BB139C8;
        Mon,  2 Jan 2023 10:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GqSxCPSysmNdWAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 02 Jan 2023 10:33:24 +0000
Message-ID: <f130dcb9-6fe5-965c-c8fc-03b00f63dc62@suse.de>
Date:   Mon, 2 Jan 2023 11:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] drm/tiny: ili9486: Enable driver module
 autoloading
Content-Language: en-US
To:     Carlo Caione <ccaione@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
References: <20221116-s905x_spi_ili9486-v4-0-f86b4463b9e4@baylibre.com>
 <20221116-s905x_spi_ili9486-v4-1-f86b4463b9e4@baylibre.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20221116-s905x_spi_ili9486-v4-1-f86b4463b9e4@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7WWAL69xIlEamlHVjhWSj1Wb"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7WWAL69xIlEamlHVjhWSj1Wb
Content-Type: multipart/mixed; boundary="------------lFQiV1JmjYK2euoxfpbFl4rz";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Carlo Caione <ccaione@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Message-ID: <f130dcb9-6fe5-965c-c8fc-03b00f63dc62@suse.de>
Subject: Re: [PATCH v4 1/2] drm/tiny: ili9486: Enable driver module
 autoloading
References: <20221116-s905x_spi_ili9486-v4-0-f86b4463b9e4@baylibre.com>
 <20221116-s905x_spi_ili9486-v4-1-f86b4463b9e4@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v4-1-f86b4463b9e4@baylibre.com>

--------------lFQiV1JmjYK2euoxfpbFl4rz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTkuMTIuMjIgdW0gMTA6MDIgc2NocmllYiBDYXJsbyBDYWlvbmU6DQo+IFNQ
SSBkZXZpY2VzIHVzZSB0aGUgc3BpX2RldmljZV9pZCBmb3IgbW9kdWxlIGF1dG9sb2FkaW5n
IGV2ZW4gb24NCj4gc3lzdGVtcyB1c2luZyBkZXZpY2UgdHJlZS4NCj4gDQo+IEFkZCB0aGUg
c3BpX2RldmljZV9pZCBlbnRyeSB0byBlbmFibGUgYXV0b2xvYWRpbmcgZm9yIHRoZSAzLjVp
bmNoIFJQaQ0KPiBEaXNwbGF5IChycGktbGNkLTM1IGFuZCBwaXNjcmVlbikuDQo+IA0KPiBS
ZXZpZXdlZC1ieTogTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IENhcmxvIENhaW9uZSA8Y2NhaW9uZUBiYXlsaWJyZS5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS90aW55L2lsaTk0ODYuYyB8IDIgKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3RpbnkvaWxpOTQ4Ni5jIGIvZHJpdmVycy9ncHUvZHJtL3Rpbnkv
aWxpOTQ4Ni5jDQo+IGluZGV4IDFiYjg0NzQ2NmIxMC4uOGJmMGRjYTBiMDVkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGlueS9pbGk5NDg2LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3RpbnkvaWxpOTQ4Ni5jDQo+IEBAIC0xODMsNiArMTgzLDggQEAgTU9EVUxF
X0RFVklDRV9UQUJMRShvZiwgaWxpOTQ4Nl9vZl9tYXRjaCk7DQo+ICAgDQo+ICAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGlsaTk0ODZfaWRbXSA9IHsNCj4gICAJeyAi
aWxpOTQ4NiIsIDAgfSwNCj4gKwl7ICJycGktbGNkLTM1IiwgMCB9LA0KPiArCXsgInBpc2Ny
ZWVuIiwgMCB9LA0KDQpBbHBoYWJldGljYWwgc29ydGluZyBwbGVhc2UuDQoNCldpdGggdGhh
dDoNCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+ICAgCXsgfQ0KPiAgIH07DQo+ICAg
TU9EVUxFX0RFVklDRV9UQUJMRShzcGksIGlsaTk0ODZfaWQpOw0KPiANCg0KLS0gDQpUaG9t
YXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xo
cmVyOiBJdm8gVG90ZXYNCg==

--------------lFQiV1JmjYK2euoxfpbFl4rz--

--------------7WWAL69xIlEamlHVjhWSj1Wb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmOysvMFAwAAAAAACgkQlh/E3EQov+Cx
6Q/8C7H2mRrKBkyOcenR8/D31dmZKvfuYILszuUaFTw7vwuEJVYtLZr5312jyd81mbm2dCEqpsa0
HM6bsMdoLSb3+DRggr3lsKsq/Q9wAY3sc0psU1of8HodstBrxZ+z1Pyqi0irRVVAtl494RbXKqAX
lwXKfuQX16tkdeWLELAUePTjouTBvY/lebdIZJ1iNHDGIhVc0UBdN5cm62IJ6ysswIosbV1ZLL8U
ZsS1HnJ8M7fhLrYkaPkYjWU6YoNynzDifTxsULYG69w0h+98P67F564uNt2YC5ClqiIWnIdroTbY
vozAP8bM5EMGG9XqfTOy7WK+hHli7nPxJXpgNFCeVHt61hGQUalIGuRtGjzq42/qdioGE5EMgcOt
pOroZMnDNtvSz/OELridHwAs12iHwa/seFCLZkEi9gXQKlBtuZWfukD0fl9rPFQ01QiUf+1XtChU
glg5SlPvtMwQpG6YsDUoE+fQex/MiC42H5MN3x8ItMZse9PTavQd1CNMdVnuKIpxqVxHeTYIHcOa
v39clRVI669ZTt4jlBNTNey+SzmzUKFKOXqqhKgPrXdB+qn/qTYXwvKnIMLi8MGkNRmX4WoublT1
quPPwsLFNlYNYHzTrAu7kfwPivoXkv4pXIHUbaLqba0AJbClDD/hCqvdTyfZA3jyNpAHqu6Ikyjw
L24=
=cHPN
-----END PGP SIGNATURE-----

--------------7WWAL69xIlEamlHVjhWSj1Wb--
