Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8946F42E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjEBLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:38:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151630FD
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:38:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F10A61F8C8;
        Tue,  2 May 2023 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683027491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vg3ilmux994uQVP9pUiRzObZ/HrPSDXb/pSMeDN9tzc=;
        b=o4EJCk1q0u1bWlfg731xVCwjyfZU+CEeZxg5LDxKe3URHTbMeJRyh05/S6uUGsPj3pfuKI
        L8GFcPMkjUhY+sGBsS7+feuXi3ysavtXYL8ZEtOzz9zn/W5azrSd/A7NPmbkZFqUhp14Ya
        ahuATm9SwT2MV6vYoxc7WApjkWRwafA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683027491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vg3ilmux994uQVP9pUiRzObZ/HrPSDXb/pSMeDN9tzc=;
        b=zj9mjLa/R7sxWKN/y13cb3UZp6TvyNdWJVRG20WI4M1XdoYFtC6dh8ArO4M56FnefJlm/N
        hlfEtz7h6Jy1vWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C96DE139C3;
        Tue,  2 May 2023 11:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zt0VMCP2UGSlHQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 02 May 2023 11:38:11 +0000
Message-ID: <542af717-b889-3eea-a819-1d2a2cf4729d@suse.de>
Date:   Tue, 2 May 2023 13:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn: can
 'unode' even be NULL?
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EVSzAhBkd5taqjK4Ui02i7ws"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EVSzAhBkd5taqjK4Ui02i7ws
Content-Type: multipart/mixed; boundary="------------L0ZJUilhUfPmvz3bTtxyvRw7";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Takashi Iwai <tiwai@suse.de>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <542af717-b889-3eea-a819-1d2a2cf4729d@suse.de>
Subject: Re: drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn: can
 'unode' even be NULL?
References: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>
In-Reply-To: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>

--------------L0ZJUilhUfPmvz3bTtxyvRw7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDIuMDUuMjMgdW0gMTM6MTkgc2NocmllYiBEYW4gQ2FycGVudGVyOg0KPiB0
cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdCBtYXN0ZXINCj4gaGVhZDogICAyY2FlZWI5ZDRhMWJjY2Q5
MjNiNzkxODQyN2Y5ZTllZjcxNTFkZGQ4DQo+IGNvbW1pdDogYzVjMzU0YTNhNDcyODA0NWUx
MzQyMTY2Mzk0YzYxNWQ3NWQ0NTM3NyBkcm0vdWRsOiBGaXggaW5jb25zaXN0ZW50IHVyYnMu
Y291bnQgdmFsdWUgZHVyaW5nIHVkbF9mcmVlX3VyYl9saXN0KCkNCj4gY29uZmlnOiBwYXJp
c2MtcmFuZGNvbmZpZy1tMDMxLTIwMjMwNDIxIChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8w
ZGF5LWNpL2FyY2hpdmUvMjAyMzA0MjMvMjAyMzA0MjMwODAxLm5jb0cxWERyLWxrcEBpbnRl
bC5jb20vY29uZmlnKQ0KPiBjb21waWxlcjogaHBwYS1saW51eC1nY2MgKEdDQykgMTIuMS4w
DQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
IHdoZXJlIGFwcGxpY2FibGUNCj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+IHwgUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9y
MjdAZ21haWwuY29tPg0KPiB8IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
MzA0MjMwODAxLm5jb0cxWERyLWxrcEBpbnRlbC5jb20vDQo+IA0KPiBzbWF0Y2ggd2Fybmlu
Z3M6DQo+IGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX21haW4uYzoyNTkgdWRsX2dldF91cmJf
bG9ja2VkKCkgd2FybjogY2FuICd1bm9kZScgZXZlbiBiZSBOVUxMPw0KDQpJdCBjYW4ndC4g
U2VuZCBhIGZpeCwgaWYgeW91IGxpa2UuIE9UT0ggaXQncyBub3QgbXVjaCBvZiBhIHByb2Js
ZW0gZWl0aGVyLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiB2aW0gKy91bm9k
ZSArMjU5IGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX21haW4uYw0KPiANCj4gYzVjMzU0YTNh
NDcyODAgVGFrYXNoaSBJd2FpIDIwMjItMDktMDggIDIzNiAgc3RhdGljIHN0cnVjdCB1cmIg
KnVkbF9nZXRfdXJiX2xvY2tlZChzdHJ1Y3QgdWRsX2RldmljZSAqdWRsLCBsb25nIHRpbWVv
dXQpDQo+IDUzMjA5MThiOWE4Nzg2IERhdmUgQWlybGllICAyMDEwLTEyLTE1ICAyMzcgIHsN
Cj4gYzVjMzU0YTNhNDcyODAgVGFrYXNoaSBJd2FpIDIwMjItMDktMDggIDIzOCAgCXN0cnVj
dCB1cmJfbm9kZSAqdW5vZGU7DQo+IDUzMjA5MThiOWE4Nzg2IERhdmUgQWlybGllICAyMDEw
LTEyLTE1ICAyMzkNCj4gYzVjMzU0YTNhNDcyODAgVGFrYXNoaSBJd2FpIDIwMjItMDktMDgg
IDI0MCAgCWFzc2VydF9zcGluX2xvY2tlZCgmdWRsLT51cmJzLmxvY2spOw0KPiA1MzIwOTE4
YjlhODc4NiBEYXZlIEFpcmxpZSAgMjAxMC0xMi0xNSAgMjQxDQo+IGFjZDQ1YzU2NzkwYTNi
IFRha2FzaGkgSXdhaSAyMDIyLTA4LTA0ICAyNDIgIAkvKiBXYWl0IGZvciBhbiBpbi1mbGln
aHQgYnVmZmVyIHRvIGNvbXBsZXRlIGFuZCBnZXQgcmUtcXVldWVkICovDQo+IGFjZDQ1YzU2
NzkwYTNiIFRha2FzaGkgSXdhaSAyMDIyLTA4LTA0ICAyNDMgIAlpZiAoIXdhaXRfZXZlbnRf
bG9ja19pcnFfdGltZW91dCh1ZGwtPnVyYnMuc2xlZXAsDQo+IGM1YzM1NGEzYTQ3MjgwIFRh
a2FzaGkgSXdhaSAyMDIyLTA5LTA4ICAyNDQgIAkJCQkJICF1ZGwtPnVyYnMuY291bnQgfHwN
Cj4gYWNkNDVjNTY3OTBhM2IgVGFrYXNoaSBJd2FpIDIwMjItMDgtMDQgIDI0NSAgCQkJCQkg
IWxpc3RfZW1wdHkoJnVkbC0+dXJicy5saXN0KSwNCj4gYWNkNDVjNTY3OTBhM2IgVGFrYXNo
aSBJd2FpIDIwMjItMDgtMDQgIDI0NiAgCQkJCQkgdWRsLT51cmJzLmxvY2ssIHRpbWVvdXQp
KSB7DQo+IGFjZDQ1YzU2NzkwYTNiIFRha2FzaGkgSXdhaSAyMDIyLTA4LTA0ICAyNDcgIAkJ
RFJNX0lORk8oIndhaXQgZm9yIHVyYiBpbnRlcnJ1cHRlZDogYXZhaWxhYmxlOiAlZFxuIiwN
Cj4gYWNkNDVjNTY3OTBhM2IgVGFrYXNoaSBJd2FpIDIwMjItMDgtMDQgIDI0OCAgCQkJIHVk
bC0+dXJicy5hdmFpbGFibGUpOw0KPiBjNWMzNTRhM2E0NzI4MCBUYWthc2hpIEl3YWkgMjAy
Mi0wOS0wOCAgMjQ5ICAJCXJldHVybiBOVUxMOw0KPiBhY2Q0NWM1Njc5MGEzYiBUYWthc2hp
IEl3YWkgMjAyMi0wOC0wNCAgMjUwICAJfQ0KPiA1MzIwOTE4YjlhODc4NiBEYXZlIEFpcmxp
ZSAgMjAxMC0xMi0xNSAgMjUxDQo+IGM1YzM1NGEzYTQ3MjgwIFRha2FzaGkgSXdhaSAyMDIy
LTA5LTA4ICAyNTIgIAlpZiAoIXVkbC0+dXJicy5jb3VudCkNCj4gYzVjMzU0YTNhNDcyODAg
VGFrYXNoaSBJd2FpIDIwMjItMDktMDggIDI1MyAgCQlyZXR1cm4gTlVMTDsNCj4gYzVjMzU0
YTNhNDcyODAgVGFrYXNoaSBJd2FpIDIwMjItMDktMDggIDI1NA0KPiBhY2Q0NWM1Njc5MGEz
YiBUYWthc2hpIEl3YWkgMjAyMi0wOC0wNCAgMjU1ICAJdW5vZGUgPSBsaXN0X2ZpcnN0X2Vu
dHJ5KCZ1ZGwtPnVyYnMubGlzdCwgc3RydWN0IHVyYl9ub2RlLCBlbnRyeSk7DQo+IA0KPiBV
c2UgbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCkgaWYgdGhpcyBsaXN0IGNhbiBiZSBlbXB0
eS4NCj4gDQo+IGVkOTYwNWE2NmI2MmYyIFRha2FzaGkgSXdhaSAyMDIyLTA5LTA4ICAyNTYg
IAlsaXN0X2RlbF9pbml0KCZ1bm9kZS0+ZW50cnkpOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5e
Xl5eDQo+IGRlcmVmZXJlbmNlLg0KPiANCj4gNTMyMDkxOGI5YTg3ODYgRGF2ZSBBaXJsaWUg
IDIwMTAtMTItMTUgIDI1NyAgCXVkbC0+dXJicy5hdmFpbGFibGUtLTsNCj4gNTMyMDkxOGI5
YTg3ODYgRGF2ZSBBaXJsaWUgIDIwMTAtMTItMTUgIDI1OA0KPiBhY2Q0NWM1Njc5MGEzYiBU
YWthc2hpIEl3YWkgMjAyMi0wOC0wNCBAMjU5ICAJcmV0dXJuIHVub2RlID8gdW5vZGUtPnVy
YiA6IE5VTEw7DQo+IA0KPiBSZXR1cm5zIGZyb20gbGlzdF9maXJzdF9lbnRyeSgpIHNob3Vs
ZCBuZXZlciBiZSBjaGVja2VkIGZvciBOVUxMLg0KPiANCj4gNTMyMDkxOGI5YTg3ODYgRGF2
ZSBBaXJsaWUgIDIwMTAtMTItMTUgIDI2MCAgfQ0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVy
bWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywg
R2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQs
IEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------L0ZJUilhUfPmvz3bTtxyvRw7--

--------------EVSzAhBkd5taqjK4Ui02i7ws
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRQ9iMFAwAAAAAACgkQlh/E3EQov+BZ
Kw/+MKTIkoOnL3OGqLTHGtklPiFCd25GTVcQa1MdcasSqjkK5i+WxkH7qW/bL5CfXCNnsSV1MR1J
H6swsguBFJyKmogNfa+XH8G+WHfP1T3NO9n69HqmNCvXK8olA4MSiPSSQrAw+J4t42jbHmTGU01k
kqZOdnb/7kAjFNoXqbu6tWPXigMmgu38ASysoeRJSpG1Ls0ufrVOeIv39qj/Ll2COVICQFJRz3Wf
YnFw2eO2ofpMlJrb6KDc+GfrssGfqjfjolH8L6F9LWW0InIBTB/pEWU2EzaqPf8bqND8cqSaB1e+
KR9sXqRCFzOKzaUQv4TONUwIobXd1rAd2oomjkF80Se4PctCbsx4hR/5/zAkR3Zbq55sgVkUnPiw
/viZa47grKX4kRX1m/m3KAuvrhAq2u1pEg3/bzhUSWGcEHbYJa+xBws1VRK9EcyB80jA6awgRcUv
QciFIqjrJm1OzgUvLDOiTXw8Qiq+/vqf6+a3FRNvb6Dwa64QIT9qulYmHp+h8Igvga9M79MYvXzx
Lz/gYiKtyIf6yaaoZVJ3OmaA8HDUIH901nYU2QVsc7Xxk/2ALF+dCjQ5r9BJ0j+llgVxuk5nqzs4
NsV4fgnFxkoFa/YCPjpd9+dikeNf6Nd4agLlVRZMFajYAa8nAVcIGf309KWE5RsYNP7r4d58os6L
UM4=
=fmiS
-----END PGP SIGNATURE-----

--------------EVSzAhBkd5taqjK4Ui02i7ws--
