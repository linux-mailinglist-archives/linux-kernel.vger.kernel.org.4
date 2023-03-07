Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B766AD93A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCGIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCGIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:25:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9972ED61;
        Tue,  7 Mar 2023 00:24:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09E8F21A3A;
        Tue,  7 Mar 2023 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678177498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJjCMR/7W7W6fsxhbPmeCPoCzzj8LVhiJpZUXqYpJHg=;
        b=jxNaHdRIuxKgQUO69Tn/RhntQcsEEvE8OdmsJmCL4SbQF7hSm0czRn+bJ7QMM3V54uVeUe
        5Kd+He9KwFanfdzrMKqX862RG8riZ/EkwQwuC+LHiSruevZSNQ/N02AZa900ji32NZNWBJ
        FqUtseevIc6KWMVnbnHarWa3ydCjXrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678177498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJjCMR/7W7W6fsxhbPmeCPoCzzj8LVhiJpZUXqYpJHg=;
        b=S/6yXrAGSF+9++abVia5koz3DUC4779UWgL4gVHGJu1LfbfAKNIxPtUu59d54BVX9G/bjP
        DXyUCyFaJkkOMWBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA3161341F;
        Tue,  7 Mar 2023 08:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i1RNKNn0BmRZFgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 07 Mar 2023 08:24:57 +0000
Message-ID: <c6d2e7db-f728-c867-2f14-528895e99927@suse.de>
Date:   Tue, 7 Mar 2023 09:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/99] fbdev/aty: Duplicate video-mode option string
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230306160016.4459-1-tzimmermann@suse.de>
 <20230306160016.4459-12-tzimmermann@suse.de>
 <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fVN03Z44mY6detn63Uep34gh"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fVN03Z44mY6detn63Uep34gh
Content-Type: multipart/mixed; boundary="------------njgFiRo1LRq96NsWAc32i50R";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
 linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
 adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
 mbroemme@libmpq.org, thomas@winischhofer.net,
 James.Bottomley@hansenpartnership.com, spock@gentoo.org,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 geert+renesas@glider.be, corbet@lwn.net, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <c6d2e7db-f728-c867-2f14-528895e99927@suse.de>
Subject: Re: [PATCH 11/99] fbdev/aty: Duplicate video-mode option string
References: <20230306160016.4459-1-tzimmermann@suse.de>
 <20230306160016.4459-12-tzimmermann@suse.de>
 <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>
In-Reply-To: <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>

--------------njgFiRo1LRq96NsWAc32i50R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDYuMDMuMjMgdW0gMTc6MTMgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46
DQo+IEhpIFRob21hcywNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+IE9u
IE1vbiwgTWFyIDYsIDIwMjMgYXQgNTowMOKAr1BNIFRob21hcyBaaW1tZXJtYW5uIDx0emlt
bWVybWFubkBzdXNlLmRlPiB3cm90ZToNCj4+IEFzc3VtZSB0aGF0IHRoZSBkcml2ZXIgZG9l
cyBub3Qgb3duIHRoZSBvcHRpb24gc3RyaW5nIG9yIGl0cyBzdWJzdHJpbmdzDQo+PiBhbmQg
aGVuY2UgZHVwbGljYXRlIHRoZSBvcHRpb24gc3RyaW5nIGZvciB0aGUgdmlkZW8gbW9kZS4g
VGhlIGRyaXZlciBvbmx5DQo+PiBwYXJzZXMgdGhlIG9wdGlvbiBzdHJpbmcgb25jZSBhcyBw
YXJ0IG9mIG1vZHVsZSBpbml0aWFsaXphdGlvbiwgc28gdXNlDQo+PiBhIHN0YXRpYyBidWZm
ZXIgdG8gc3RvcmUgdGhlIGR1cGxpY2F0ZWQgbW9kZSBvcHRpb24uIExpbnV4IGF1dG9tYXRp
Y2FsbHkNCj4+IGZyZWVzIHRoZSBtZW1vcnkgdXBvbiByZWxlYXNpbmcgdGhlIG1vZHVsZS4N
Cj4gDQo+IEFyZSB5b3Ugc3VyZSBhYm91dCB0aGF0Pw0KPiBBbGwgb2YgdGhpcyBjb2RlIGlz
IGluc2lkZSAiI2lmbmRlZiBNT0RVTEUiLg0KPiBJbiB0aGUgYXR5MTI4ZmIgY2FzZSwgdGhl
IGZ1bmN0aW9uIGlzIG5vdCBtYXJrZWQgX19pbml0Lg0KPiBFbmFibGluZyB0aGVzZSAzIGRy
aXZlcnMgYWRkcyAzeDI1NiBieXRlcyBvZiBzdGF0aWMgYnVmZmVyLCBtb3JlDQo+IGlmIHlv
dSBlbmFibGUgbW9yZSBmYmRldiBkcml2ZXJzLg0KDQpSaWdodC4gUGxlYXNlIHNlZSBteSBy
ZXBseSB0byBbMDAvOTldLg0KDQo+IA0KPj4gRG9uZSBpbiBwcmVwYXJhdGlvbiBvZiBzd2l0
Y2hpbmcgdGhlIGRyaXZlciB0byBzdHJ1Y3Qgb3B0aW9uX2l0ZXIgYW5kDQo+PiBjb25zdGlm
eWluZyB0aGUgb3B0aW9uIHN0cmluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMg
WmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gDQo+PiAtLS0gYS9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L2F0eS9hdHkxMjhmYi5jDQo+PiArKysgYi9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L2F0eS9hdHkxMjhmYi5jDQo+PiBAQCAtMTcyMyw3ICsxNzIzLDE3IEBAIHN0YXRpYyBp
bnQgYXR5MTI4ZmJfc2V0dXAoY2hhciAqb3B0aW9ucykNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4+ICAgICAgICAgICAgICAgICAgfQ0KPj4gICAjZW5kaWYg
LyogQ09ORklHX1BQQ19QTUFDICovDQo+PiAtICAgICAgICAgICAgICAgbW9kZV9vcHRpb24g
PSB0aGlzX29wdDsNCj4+ICsgICAgICAgICAgICAgICB7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICBzdGF0aWMgY2hhciBtb2RlX29wdGlvbl9idWZbMjU2XTsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSBzbnByaW50Zihtb2RlX29wdGlvbl9idWYsIHNpemVvZihtb2RlX29wdGlv
bl9idWYpLCAiJXMiLCB0aGlzX29wdCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoV0FSTihyZXQgPCAwLCAiYXR5MTI4OiBpZ25vcmluZyBpbnZhbGlkIG9wdGlvbiwgcmV0
PSVkXG4iLCByZXQpKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChXQVJOKHJldCA+PSBzaXpl
b2YobW9kZV9vcHRpb25fYnVmKSwgImF0eTEyOGZiOiBvcHRpb24gdG9vIGxvbmdcbiIpKQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIG1vZGVfb3B0aW9uID0gbW9kZV9vcHRpb25fYnVmOw0KPj4g
KyAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgIH0NCj4+ICAgICAgICAgIHJldHVybiAw
Ow0KPj4gICB9DQo+IGV0dXJuIDA7DQo+PiAgIH0NCj4gDQo+IEdye29ldGplLGVldGluZ31z
LA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KDQotLSANClRo
b21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bD
vGhyZXI6IEl2byBUb3Rldg0K

--------------njgFiRo1LRq96NsWAc32i50R--

--------------fVN03Z44mY6detn63Uep34gh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQG9NkFAwAAAAAACgkQlh/E3EQov+A1
rxAAwDtvCmNWSogCnBKo7P+vbnHZdaKaHvcKpdY0yNu5N8m3s/KJqXNKv4T5vUeQxSHdMgcTLr7Y
//6angohv9ejGjcbiF/pk55ryZIoJZ9qU1VHg/jiUS4mMyzyHDR9W5xY+27UhBC9Se3BwlN9Swcs
c+Q/oR3TL3e7dHagZDcgbf4INDlYYoQUj8yFu9AVw7yIRtUgYliMVU5sC9b2eBEIkH/fbVMvgE9o
MQYvyI46ZlzUxF6ZrtvuLyYHQL85hkl84HZKE5eldrjPv/rXdZcYKWuPDJRBYdzUdjWFBoJbuIPB
fDx9EMduOvm7WYeIscA/4tbgGcPtDLlAmQwFx4gn9wJ61oJeqsqn2U9gY2zxr9/FHX0iyBabXWxG
OoeCo6E0q+7hXb4HGUAaL5gMpf3vkYzta308HTQOfUI3idlmdiFwOp4WjEjPzHOYsr6GHUhtximI
dZP5Dho2R3WMJADi7viz8QmHJWVrtEgXFwDMhxlHQwU7xvnsXTFrA8HI0fHJ4sYcyLE/Hme/RH4s
Iv07Ja9OIM4yaIgpwzJsy/EEva/ySNdPgiADmGMlEp7kNDLOyMS1K/Y9zIzbCblZbTvetexSc3l4
DftnC5XQ+rPYa25KHWjBcIg0DsSe4yZQMxfZySLHqfY8M2fzOuJZHDDOC999Qt714ehCKlUuPSBj
7Qo=
=gUgK
-----END PGP SIGNATURE-----

--------------fVN03Z44mY6detn63Uep34gh--
