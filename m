Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83169A8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBQKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:14:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E723598
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:14:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A625D221E0;
        Fri, 17 Feb 2023 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676628864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtqJr1T+CGP9rb7JA3mT54A5DmAkVc5wZStbP6ZKdqs=;
        b=lc4kuOcSmIAqEmuJ/PDWb5DK0QequX5eaz+Tw+w1VfJ94NevN7tFqhdJp/O8ZesN1He5Hn
        aMlFYppVMpmf4cCLDhz6EaxEl6otgdXKXyUMQXrowl3uhdB80e+KD52zJAhv7uKuoo8U2h
        xUyEjJgL0CaPieYqMcNUL4/iEy+d/tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676628864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtqJr1T+CGP9rb7JA3mT54A5DmAkVc5wZStbP6ZKdqs=;
        b=Bf7zSj0FmFse2uCZniPCK75nGjDImmQT2Q7Pma1vrXruc3aMa8MMkjP1mNtVHz6qJSypZa
        K582rW6qBdWNwLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BB2B13274;
        Fri, 17 Feb 2023 10:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ekc6HYBT72M4KAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 17 Feb 2023 10:14:24 +0000
Message-ID: <8e5e9f5c-9793-1986-30a8-02c7aeddbe1c@suse.de>
Date:   Fri, 17 Feb 2023 11:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] gpu-drm-tiny-cirrus: Add NULL check of pointer
 pipe->plane.state->fb in cirrus_pipe_update()
Content-Language: en-US
To:     Alexander Sapozhnikov <alsp705@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Jani Nikula <jani.nikula@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230215171549.16305-1-alsp705@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230215171549.16305-1-alsp705@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------W0cMx7MCUswWmTiHclNOFViF"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------W0cMx7MCUswWmTiHclNOFViF
Content-Type: multipart/mixed; boundary="------------DzeF0Y8tHjgIb4CrfqDxM1Zd";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Alexander Sapozhnikov <alsp705@gmail.com>
Cc: linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jani Nikula <jani.nikula@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <8e5e9f5c-9793-1986-30a8-02c7aeddbe1c@suse.de>
Subject: Re: [PATCH] gpu-drm-tiny-cirrus: Add NULL check of pointer
 pipe->plane.state->fb in cirrus_pipe_update()
References: <20230215171549.16305-1-alsp705@gmail.com>
In-Reply-To: <20230215171549.16305-1-alsp705@gmail.com>

--------------DzeF0Y8tHjgIb4CrfqDxM1Zd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTUuMDIuMjMgdW0gMTg6MTUgc2NocmllYiBBbGV4YW5kZXIgU2Fwb3pobmlr
b3Y6DQo+IEZyb206IEFsZXhhbmRyIFNhcG96aG5pa292IDxhbHNwNzA1QGdtYWlsLmNvbT4N
Cj4gDQo+IEFmdGVyIGhhdmluZyBiZWVuIGNvbXBhcmVkIHRvIE5VTEwgdmFsdWUgYXQgY2ly
cnVzLmM6NDU1LCBwb2ludGVyICdwaXBlLT5wbGFuZS5zdGF0ZS0+ZmInIGlzIHBhc3NlZCBh
cw0KPiAxc3QgcGFyYW1ldGVyIGluIGNhbGwgdG8gZnVuY3Rpb24gJ2NpcnJ1c19mYl9ibGl0
X3JlY3QnIGF0IGNpcnJ1cy5jOjQ2MSwgd2hlcmUgaXQgaXMgZGVyZWZlcmVuY2VkIGF0IGNp
cnJ1cy5jOjMxNi4NCj4gDQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIg
KGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kciBTYXBvemhuaWtvdiA8YWxzcDcwNUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCg0KSSdsbCBhZGQg
eW91IHBhdGNoIHRvIGRybS1taXNjLWZpeGVzLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0K
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS90aW55L2NpcnJ1cy5jIHwgMiArLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aW55L2NpcnJ1cy5jIGIvZHJpdmVycy9n
cHUvZHJtL3RpbnkvY2lycnVzLmMNCj4gaW5kZXggNjc4YzJlZi4uZmZhN2U2MSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3RpbnkvY2lycnVzLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3RpbnkvY2lycnVzLmMNCj4gQEAgLTQ1NSw3ICs0NTUsNyBAQCBzdGF0aWMg
dm9pZCBjaXJydXNfcGlwZV91cGRhdGUoc3RydWN0IGRybV9zaW1wbGVfZGlzcGxheV9waXBl
ICpwaXBlLA0KPiAgIAlpZiAoc3RhdGUtPmZiICYmIGNpcnJ1cy0+Y3BwICE9IGNpcnJ1c19j
cHAoc3RhdGUtPmZiKSkNCj4gICAJCWNpcnJ1c19tb2RlX3NldChjaXJydXMsICZjcnRjLT5t
b2RlLCBzdGF0ZS0+ZmIpOw0KPiAgIA0KPiAtCWlmIChkcm1fYXRvbWljX2hlbHBlcl9kYW1h
Z2VfbWVyZ2VkKG9sZF9zdGF0ZSwgc3RhdGUsICZyZWN0KSkNCj4gKwlpZiAoc3RhdGUtPmZi
ICYmIGRybV9hdG9taWNfaGVscGVyX2RhbWFnZV9tZXJnZWQob2xkX3N0YXRlLCBzdGF0ZSwg
JnJlY3QpKQ0KPiAgIAkJY2lycnVzX2ZiX2JsaXRfcmVjdChzdGF0ZS0+ZmIsICZzaGFkb3df
cGxhbmVfc3RhdGUtPmRhdGFbMF0sICZyZWN0KTsNCj4gICB9DQo+ICAgDQoNCi0tIA0KVGhv
bWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8
aHJlcjogSXZvIFRvdGV2DQo=

--------------DzeF0Y8tHjgIb4CrfqDxM1Zd--

--------------W0cMx7MCUswWmTiHclNOFViF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPvU4AFAwAAAAAACgkQlh/E3EQov+DR
UxAAg2TaJc4Iu2+Ec6mFTEXu+bRbhitXaDeywYm/EzrluQZuV/MD+xtyVr3VF5NYfnhroMJgTqFK
hsdGCrnL2jPV15NLX5KyEbVm96uW3VpxxotH4oE5THq+cD5RbJ1cppb9HqpO+yb8CfLvT4wqjWZw
ZSQJxubcFMjx24qmPvDpvdULuswj6OTyz7NqEiDhUAJiesof8VaHUWStXtR9vzheN1tWfWs/0KLB
QGNR/SmE1tSdd35RKPE6AmGL8M3Nqbg1Hyt+DCmM4EBfKQjNXSaYP6e3M7UBbhhm404u14gfnDB9
nb0Q8jq/dFu82FB1wpF5nn+igqt/4SGlgu1pq3qpaBpi1T8IodzfIDXDSIJyuq865tmuPMVkleGr
9+jJs6Zcj/uaTqADD21aMqfZr4nCHAICS1OJ/ohwhiCkkQjGsCna6mQvnxw9acbstdGXzvl629JY
1niUk6rl4oM21evQ+GhutD70ICo5TKmzWGkVCsWP1JiLnWZ1jqwtjGaes8SxlFomu9pfdTOWrHfp
yVIcjz0zVJL/Ly0tgmshoyvnY2yc95CFPSTaqTBRxkMejT4ja6TpDhP5lvxvJ4/ElSs5PTt1owSu
k4MoM+coTy/Y7D725iDOZOwp7STw6IctFjzd1ax4YaXFyAsgYTc8RimhfLKCpgiSoUk4oBla4Nx4
vpk=
=YaT7
-----END PGP SIGNATURE-----

--------------W0cMx7MCUswWmTiHclNOFViF--
