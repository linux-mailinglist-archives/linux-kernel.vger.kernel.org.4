Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6F617EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKCOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKCOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:09:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A3DEF4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:09:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9BE9219F6;
        Thu,  3 Nov 2022 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667484548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9g1+AtDFOixD8PknPSmERcbSgAYMFOmjgKfRr2HrFg=;
        b=ual0pbdLxcJ7g3HiMJtIFDJ5KOGu5pVmBfI28C6hj67BrnE2i+kWXR/EDp8wSnsFBcEWeJ
        Sh9MZUuc9A1p0ico/dVtbubyMIfqilkt2jFl6BS7na0wTuKGBhQqKswf3i35/drZeae4UO
        iu/bDbDxi0VZGCDGoSuWx92wvB7oN7k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7675913480;
        Thu,  3 Nov 2022 14:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZctwG4TLY2NucwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 14:09:08 +0000
Message-ID: <1472097d-327f-ac46-acf5-76ef3571922a@suse.com>
Date:   Thu, 3 Nov 2022 15:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     johnnyaiai <arafatms@outlook.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        johnnyaiai@tencent.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org
References: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
 <MEYP282MB4026FF84EBFFBEB36C9E1682C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] locking/paravirt: Fix performance regression on core
 bonded vCPU
In-Reply-To: <MEYP282MB4026FF84EBFFBEB36C9E1682C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fphuyaHaZ9haXwK41pzRoSjF"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fphuyaHaZ9haXwK41pzRoSjF
Content-Type: multipart/mixed; boundary="------------obIWnaX2Bmw9e8z0lqlT376k";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: johnnyaiai <arafatms@outlook.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 johnnyaiai@tencent.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, virtualization@lists.linux-foundation.org
Message-ID: <1472097d-327f-ac46-acf5-76ef3571922a@suse.com>
Subject: Re: [PATCH] locking/paravirt: Fix performance regression on core
 bonded vCPU
References: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
 <MEYP282MB4026FF84EBFFBEB36C9E1682C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB4026FF84EBFFBEB36C9E1682C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>

--------------obIWnaX2Bmw9e8z0lqlT376k
Content-Type: multipart/mixed; boundary="------------JPgMGU4rIP2OcMooy68Hwq9C"

--------------JPgMGU4rIP2OcMooy68Hwq9C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTEuMjIgMTQ6NTgsIGpvaG5ueWFpYWkgd3JvdGU6DQo+IFRoYW5rcyBmb3IgcmVw
bHkhIEkgdGhpbmsgbm9wdnNwaW4gcGFyYW1ldGVycyBjb250cm9scw0KPiBwdnNwaW5sb2Nr
IG9yIG5hdGl2ZSBzcGlubG9jay4gYSB2bSBndWVzdCBhbHdheXMgcnVubmluZw0KPiBvbiB2
aXJ0c3BpbiB3aGVhdGhlciBub3B2c3BpbiBzZXRzIG9yIG5vdCB3aGVuIEVYSVRTX0hBTFQN
Cj4gbm90IHN1cHBvcnRlZCBieSBoeXBlcnZpc29yLiBTbyBwcm92aWRlIGEgbWlzc2luZyBw
YXJhbWV0ZXINCj4gJ25vdmlydHNwaW4nLg0KDQpZb3VyIHBhdGNoIGlzIGRvaW5nOg0KDQog
ICAgIHN0YXRpY19icmFuY2hfZGlzYWJsZSgmdmlydF9zcGluX2xvY2tfa2V5KTsNCg0KaW4g
Y2FzZSB5b3VyIHBhcmFtZXRlciBoYXMgYmVlbiBzcGVjaWZpZWQuDQoNCldoZW4gcnVubmlu
ZyBhcyBYZW4gZ3Vlc3QgdGhlIHJlbGF0ZWQgY29kaW5nIGlzIGRvaW5nOg0KDQogICAgIHN0
YXRpY19icmFuY2hfZGlzYWJsZSgmdmlydF9zcGluX2xvY2tfa2V5KTsNCg0KT25seSB3aGVu
IHJ1bm5pbmcgYXMgS1ZNIGd1ZXN0IHRoZXJlIGlzIGEgZGlmZmVyZW5jZSwgYnV0IHRoaXMg
Y291bGQgYmUgY2hhbmdlZA0KYnkgbW9kaWZ5aW5nIGt2bV9zcGlubG9ja19pbml0KCkuDQoN
CkhhdmluZyB0d28gcGFyYW1ldGVycyB3aXRoIHRoZSBzYW1lIG9yIHZlcnkgc2ltaWxhciBz
ZW1hbnRpY3MgaXMgbm90IGEgZ29vZA0KaWRlYSBJTU8uDQoNCg0KSnVlcmdlbg0K
--------------JPgMGU4rIP2OcMooy68Hwq9C
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JPgMGU4rIP2OcMooy68Hwq9C--

--------------obIWnaX2Bmw9e8z0lqlT376k--

--------------fphuyaHaZ9haXwK41pzRoSjF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNjy4QFAwAAAAAACgkQsN6d1ii/Ey8C
sAf/XiY0N1NjlyeYXiPvGE9VNVM67ezFGk0LtRQ92kWRF0LefNZEkdyz/HOhgtubJk8Cvn4+qtkb
jF9cm8v7E7YtgZl2YDbGMCFQCyOrINWjj7oJJYS8Kw85dGVawjLnnZOCifCkYc5xsspsyfrg6UJz
GoTEgWzfoNOwHMQ5ihZH3Sax2iPM6PddnR0QLiLzLIw1WFRdUdAPCJ4GrYJXhgkRGgToDS/dVO4d
2D1v2GGdPbIPfCtD7rAqCEumEW89gGCqkWBWrJoGYKjh/YqqkHB1OKHOE/7/PzISxtA1fVoQ1tgL
KfyXr0gu1Rx2dHF5n/ufTt6A3kUYVhPriLjOMWV6gQ==
=w/v5
-----END PGP SIGNATURE-----

--------------fphuyaHaZ9haXwK41pzRoSjF--
