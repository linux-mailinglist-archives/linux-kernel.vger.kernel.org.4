Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB0617DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKCNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiKCNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:22:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EB13EA6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:22:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 024A421CC5;
        Thu,  3 Nov 2022 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667481765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtYsfzILl9NFjCGNIVUBOY8T67uNUFh0psRXTfGqcis=;
        b=elGhjAFW5ss47byBOpk4ELod1blDLy/XCyHAgzAo7XZS4KMs6+hmUCJoWS/Zqs/luZptLr
        OEI65F4mehkANJFi3AtUkK/k/V0fnpsXbkipu2GTLJvGpb+ER8VzeDKMEBHDX3JI1YWYth
        YJcT7aeWygn4hYQNjRxSutasIJsypTE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B1713480;
        Thu,  3 Nov 2022 13:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbkUJqTAY2OSWgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 13:22:44 +0000
Message-ID: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
Date:   Thu, 3 Nov 2022 14:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] locking/paravirt: Fix performance regression on core
 bonded vCPU
Content-Language: en-US
To:     johnnyaiai <arafatms@outlook.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        johnnyaiai <johnnyaiai@tencent.com>
References: <MEYP282MB402614DB5A4625255B689F06C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <MEYP282MB402614DB5A4625255B689F06C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------btJwKHoQI5NXfyaxGDGNodDN"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------btJwKHoQI5NXfyaxGDGNodDN
Content-Type: multipart/mixed; boundary="------------NN7hXR4D40ZMGlq70IZotIEC";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: johnnyaiai <arafatms@outlook.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 johnnyaiai <johnnyaiai@tencent.com>
Message-ID: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
Subject: Re: [PATCH] locking/paravirt: Fix performance regression on core
 bonded vCPU
References: <MEYP282MB402614DB5A4625255B689F06C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB402614DB5A4625255B689F06C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>

--------------NN7hXR4D40ZMGlq70IZotIEC
Content-Type: multipart/mixed; boundary="------------ziqOgnjwh30plMs8D7OtdS02"

--------------ziqOgnjwh30plMs8D7OtdS02
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTEuMjIgMTM6MTMsIGpvaG5ueWFpYWkgd3JvdGU6DQo+IEZyb206IGpvaG5ueWFp
YWkgPGpvaG5ueWFpYWlAdGVuY2VudC5jb20+DQo+IA0KPiB2aXJ0X3NwaW5fbG9jaygpIGlz
IHByZWZlcnJlZCBvdmVyIG5hdGl2ZSBxc3BpbmxvY2sgd2hlbg0KPiB2Q1BVIGlzIHByZWVt
cHRlZC4gQnV0IGJyaW5ncyBhIGxvdCBvZiByZWdyZXNzaW9uIHdoaWxlDQo+IHZDUFUgaXMg
bm90IHByZWVtcHRlZC4gUHJvdmlkZSBhIGVhcmx5IHBhcmFtICdub3ZpcnRsb2NrJw0KPiB0
byBjaG9vc2Ugd291bGQgYmUgYmV0dGVyLg0KPiANCj4gd2lsbC1pdC1zY2FsZS9sb2NrMl90
aHJlYWRzIC1zIDEwIC10IDY0DQo+IGJhc2VsaW5lICAgIGFmdGVycGF0Y2gNCj4gNTU5OTM4
ICAgICAgIDIxNjYxMzUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGpvaG5ueWFpYWkgPGpvaG5u
eWFpYWlAdGVuY2VudC5jb20+DQoNClRoYXQgaXMgZXhhY3RseSB0aGUgcHVycG9zZSBvZiB0
aGUgZXhpc3Rpbmcgbm9wdnNwaW4gcGFyYW1ldGVyLg0KDQoNCkp1ZXJnZW4NCg==
--------------ziqOgnjwh30plMs8D7OtdS02
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ziqOgnjwh30plMs8D7OtdS02--

--------------NN7hXR4D40ZMGlq70IZotIEC--

--------------btJwKHoQI5NXfyaxGDGNodDN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNjwKQFAwAAAAAACgkQsN6d1ii/Ey9V
fwf/VuX3gqrDOiYvH85Jr/a02gIdch7et+ZzpO1pJGaG0cLENWl4AEn/cVVSRhdK/9Fd9DB7DoNO
bXT6PrUr4E7/wgu/W0GJsbGBOOrd6bbl7GhnPFzBWgkGYA3eLBIPHNhOQCHE9p/6RtsLNiDZq+7O
ZtV36TUGIeA3ejd6ZCWP+qE2aRit6iiUiiB59esRPujhcusDqeQglkBBElWOmSwcvZATk3MoB0+J
/Kh8bSYcRo03+BYLjR6Zj2Hw4ICpqIQuPu0RcjjgIODtkSUs3SoSrWT2iHHDRS1dhVMRF5u7/zdw
VeKjUY/8I/rd3VS4Sa0ElenVOx+buodyyTLbH+BWKg==
=bmVM
-----END PGP SIGNATURE-----

--------------btJwKHoQI5NXfyaxGDGNodDN--
