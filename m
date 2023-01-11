Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E884665DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjAKO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjAKONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:13:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE11918689
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:13:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6148637F8B;
        Wed, 11 Jan 2023 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673446391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zW6IH8u1j0oxMPa86Yerh2cAeUK7W93SAjwADEwIV/A=;
        b=N57ovwqxWbl2fk43d1G5rqHs5AQj13WTNHHdcIG24zopf/Wrz9n5woXV92UItGDxg+4YxI
        W1md8r1MaCRf8exK+6RF0HqpsTAQuiyLVc8A9xqLbXp4oqzm0uadjubUK16c6HWIOpps4h
        5JUxoJEvVB+g8Pu8j3Hk27pmCbegDHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673446391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zW6IH8u1j0oxMPa86Yerh2cAeUK7W93SAjwADEwIV/A=;
        b=Xq32uZSpCR9IdXETv1hM2XY4GH6fOasYN1ZHCYMS+cD2zAb8blr/iLwOr0P29izOg2BW4F
        CYFGpVitYMqWmkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 349CF1358A;
        Wed, 11 Jan 2023 14:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xm+kC/fDvmMlCAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 11 Jan 2023 14:13:11 +0000
Message-ID: <1d31c923-2f0a-b0c3-6763-f58605bb5315@suse.de>
Date:   Wed, 11 Jan 2023 15:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/9] drm/vc4: hdmi: Rename full range helper
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221207-rpi-hdmi-improvements-v1-0-6b15f774c13a@cerno.tech>
 <20221207-rpi-hdmi-improvements-v1-4-6b15f774c13a@cerno.tech>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20221207-rpi-hdmi-improvements-v1-4-6b15f774c13a@cerno.tech>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xKQvYyngF3JG5mxw0ZQ0S57L"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xKQvYyngF3JG5mxw0ZQ0S57L
Content-Type: multipart/mixed; boundary="------------rvewgrP6s4yR5qrCzeX1yrtj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Message-ID: <1d31c923-2f0a-b0c3-6763-f58605bb5315@suse.de>
Subject: Re: [PATCH 4/9] drm/vc4: hdmi: Rename full range helper
References: <20221207-rpi-hdmi-improvements-v1-0-6b15f774c13a@cerno.tech>
 <20221207-rpi-hdmi-improvements-v1-4-6b15f774c13a@cerno.tech>
In-Reply-To: <20221207-rpi-hdmi-improvements-v1-4-6b15f774c13a@cerno.tech>

--------------rvewgrP6s4yR5qrCzeX1yrtj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDA3LjEyLjIyIHVtIDE3OjA3IHNjaHJpZWIgTWF4aW1lIFJpcGFyZDoNCj4gRnJv
bTogRGF2ZSBTdGV2ZW5zb24gPGRhdmUuc3RldmVuc29uQHJhc3BiZXJyeXBpLmNvbT4NCj4g
DQo+IFRoZSBWQzQgSERNSSBkcml2ZXIgaGFzIGEgaGVscGVyIGZ1bmN0aW9uIHRvIGZpZ3Vy
ZSBvdXQgd2hldGhlciBmdWxsDQo+IHJhbmdlIG9yIGxpbWl0ZWQgcmFuZ2UgUkdCIGlzIGJl
aW5nIHVzZWQgY2FsbGVkDQo+IHZjNF9oZG1pX2lzX2Z1bGxfcmFuZ2VfcmdiKCkuDQo+IA0K
PiBXZSdsbCBuZWVkIGl0IHRvIHN1cHBvcnQgb3RoZXIgY29sb3JzcGFjZXMsIHNvIGxldCdz
IHJlbmFtZSBpdCB0bw0KPiB2YzRfaGRtaV9pc19mdWxsX3JhbmdlKCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZlIFN0ZXZlbnNvbiA8ZGF2ZS5zdGV2ZW5zb25AcmFzcGJlcnJ5cGku
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgUmlwYXJkIDxtYXhpbWVAY2Vybm8udGVj
aD4NCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2hkbWkuYyB8IDEw
ICsrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92YzQvdmM0
X2hkbWkuYyBiL2RyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2hkbWkuYw0KPiBpbmRleCA0ODhh
NDAxMmQ0MjIuLjUxNDY5OTM5YThiNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3ZjNC92YzRfaGRtaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2hkbWku
Yw0KPiBAQCAtMTQ5LDggKzE0OSw4IEBAIHN0YXRpYyBib29sIHZjNF9oZG1pX21vZGVfbmVl
ZHNfc2NyYW1ibGluZyhjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSwNCj4g
ICAJcmV0dXJuIGNsb2NrID4gSERNSV8xNF9NQVhfVE1EU19DTEs7DQo+ICAgfQ0KPiAgIA0K
PiAtc3RhdGljIGJvb2wgdmM0X2hkbWlfaXNfZnVsbF9yYW5nZV9yZ2Ioc3RydWN0IHZjNF9o
ZG1pICp2YzRfaGRtaSwNCj4gLQkJCQkgICAgICAgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5
X21vZGUgKm1vZGUpDQo+ICtzdGF0aWMgYm9vbCB2YzRfaGRtaV9pc19mdWxsX3JhbmdlKHN0
cnVjdCB2YzRfaGRtaSAqdmM0X2hkbWksDQo+ICsJCQkJICAgY29uc3Qgc3RydWN0IGRybV9k
aXNwbGF5X21vZGUgKm1vZGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZHJtX2Rpc3BsYXlfaW5m
byAqZGlzcGxheSA9ICZ2YzRfaGRtaS0+Y29ubmVjdG9yLmRpc3BsYXlfaW5mbzsNCj4gICAN
Cj4gQEAgLTg5Miw3ICs4OTIsNyBAQCBzdGF0aWMgdm9pZCB2YzRfaGRtaV9zZXRfYXZpX2lu
Zm9mcmFtZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpDQo+ICAgDQo+ICAgCWRybV9o
ZG1pX2F2aV9pbmZvZnJhbWVfcXVhbnRfcmFuZ2UoJmZyYW1lLmF2aSwNCj4gICAJCQkJCSAg
IGNvbm5lY3RvciwgbW9kZSwNCj4gLQkJCQkJICAgdmM0X2hkbWlfaXNfZnVsbF9yYW5nZV9y
Z2IodmM0X2hkbWksIG1vZGUpID8NCj4gKwkJCQkJICAgdmM0X2hkbWlfaXNfZnVsbF9yYW5n
ZSh2YzRfaGRtaSwgbW9kZSkgPw0KPiAgIAkJCQkJICAgSERNSV9RVUFOVElaQVRJT05fUkFO
R0VfRlVMTCA6DQo+ICAgCQkJCQkgICBIRE1JX1FVQU5USVpBVElPTl9SQU5HRV9MSU1JVEVE
KTsNCj4gICAJZHJtX2hkbWlfYXZpX2luZm9mcmFtZV9jb2xvcmltZXRyeSgmZnJhbWUuYXZp
LCBjc3RhdGUpOw0KPiBAQCAtMTE0NSw3ICsxMTQ1LDcgQEAgc3RhdGljIHZvaWQgdmM0X2hk
bWlfY3NjX3NldHVwKHN0cnVjdCB2YzRfaGRtaSAqdmM0X2hkbWksDQo+ICAgCWNzY19jdGwg
PSBWQzRfU0VUX0ZJRUxEKFZDNF9IRF9DU0NfQ1RMX09SREVSX0JHUiwNCj4gICAJCQkJVkM0
X0hEX0NTQ19DVExfT1JERVIpOw0KPiAgIA0KPiAtCWlmICghdmM0X2hkbWlfaXNfZnVsbF9y
YW5nZV9yZ2IodmM0X2hkbWksIG1vZGUpKSB7DQo+ICsJaWYgKCF2YzRfaGRtaV9pc19mdWxs
X3JhbmdlKHZjNF9oZG1pLCBtb2RlKSkgew0KPiAgIAkJLyogQ0VBIFZJQ3Mgb3RoZXIgdGhh
biAjMSByZXF1cmUgbGltaXRlZCByYW5nZSBSR0INCj4gICAJCSAqIG91dHB1dCB1bmxlc3Mg
b3ZlcnJpZGRlbiBieSBhbiBBVkkgaW5mb2ZyYW1lLg0KPiAgIAkJICogQXBwbHkgYSBjb2xv
cnNwYWNlIGNvbnZlcnNpb24gdG8gc3F1YXNoIDAtMjU1IGRvd24NCj4gQEAgLTEyOTgsNyAr
MTI5OCw3IEBAIHN0YXRpYyB2b2lkIHZjNV9oZG1pX2NzY19zZXR1cChzdHJ1Y3QgdmM0X2hk
bWkgKnZjNF9oZG1pLA0KPiAgIAljYXNlIFZDNF9IRE1JX09VVFBVVF9SR0I6DQo+ICAgCQlp
Zl94YmFyID0gMHgzNTQwMjE7DQo+ICAgDQo+IC0JCWlmICghdmM0X2hkbWlfaXNfZnVsbF9y
YW5nZV9yZ2IodmM0X2hkbWksIG1vZGUpKQ0KPiArCQlpZiAoIXZjNF9oZG1pX2lzX2Z1bGxf
cmFuZ2UodmM0X2hkbWksIG1vZGUpKQ0KPiAgIAkJCXZjNV9oZG1pX3NldF9jc2NfY29lZmZz
KHZjNF9oZG1pLCB2YzVfaGRtaV9jc2NfZnVsbF9yZ2JfdG9fbGltaXRlZF9yZ2IpOw0KPiAg
IAkJZWxzZQ0KPiAgIAkJCXZjNV9oZG1pX3NldF9jc2NfY29lZmZzKHZjNF9oZG1pLCB2YzVf
aGRtaV9jc2NfZnVsbF9yZ2JfdW5pdHkpOw0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFu
bg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkN
CihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90
ZXYNCg==

--------------rvewgrP6s4yR5qrCzeX1yrtj--

--------------xKQvYyngF3JG5mxw0ZQ0S57L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmO+w/YFAwAAAAAACgkQlh/E3EQov+CK
kxAArnH5uWn11sJi+zGskdqUndHnKsKYYJ9WiaSQdkaoumbzQpEAe+J1tsbhRDuMPhlFCQCRDjgd
iCrpCEiJAlhQimRuXmhKHcy15VfLpZDigu7rk2IV+2D3dEiGS9pxAj4Z8euefHhqdNBD+f0PbqtK
5QzrI0fnoS0/EyX8xnHLVS6RiPYqk+3yKLbRtagePKaOgJ5iEjO/0cuSvkW6XGO0Ay6J+QKlvXx4
NTdLVmwNJcVYxbPRmkQmmMVUCxYEBpWykhHhKNaneUryRl+y7khu+wLtLlJL5YRXDYZMbmIF2M13
XDHhpskZfiCGpxO7VWcUv4ZIDDLKWM/7aO5l8m9ZcG/SNck2Zpglp2Z+2/HiAg0/Eu3NRUg26uSh
q6Nf+UUopnshsdn4E6yl2o2twS5ANiPuYvAe6QNAax8cGC1LwfzqHdOQaRf38/nfwhp6qIX3KGq+
jdKGoeEYSGlBz9LX8m51HRWWNMX46NdNMRDFWaImOZ6oCs9kQoy0Gmi+zvzt5jDeGiabgK23qnKw
0ngLBfXJ9tL3UjhsHv9jg2+7pJ/ShCe9EhPNdvBFKyU8/g/iNt6DF8gZq9ddKygu4pI2R5BIp2dg
PFtMIW8y66P1I7erpJHV2SJJPF3vopH8Y6mczDt+TSVyL6O3cM+ZHNErgWVjXeJw6jv7PZFMliXM
5kQ=
=Y8+s
-----END PGP SIGNATURE-----

--------------xKQvYyngF3JG5mxw0ZQ0S57L--
