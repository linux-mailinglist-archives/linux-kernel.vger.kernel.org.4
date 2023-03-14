Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153116B9830
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjCNOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCNOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:42:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA259E524;
        Tue, 14 Mar 2023 07:41:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03C4321C6E;
        Tue, 14 Mar 2023 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ijl+wMxkUG8QWAXHj6uxwD5E3sbhf3ed0PHU4a3LeM=;
        b=GgUzFjUaPH+Eu2EIexNJCHkEW0CvofmomOlKjgcnHAg0AtCCnEjnhm0PCkgaRyk/FOgciX
        bb67VVr551P49+vhF3ezpuKqCj/hf+zqKExrzQacuNh8spdg/3Iskc/QL5zGSMpClFw/J+
        oEEj//3loyu+/qg14Faw8rYiQZtk/ik=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C726313A26;
        Tue, 14 Mar 2023 14:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +y/wLrCHEGQIJgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 14:41:52 +0000
Message-ID: <e2e81547-e1a1-9743-16b2-ff78ab67efbb@suse.com>
Date:   Tue, 14 Mar 2023 15:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] xen/blkback: move blkif_get_x86_*_req() into
 blkback.c
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20230314142741.24917-1-jgross@suse.com>
 <20230314142741.24917-5-jgross@suse.com>
 <a4b422c6-eb08-89e5-9c97-4e0c4d0f8f01@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <a4b422c6-eb08-89e5-9c97-4e0c4d0f8f01@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n9iNOJwt0R0fqoF8Vp6gy0OC"
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
--------------n9iNOJwt0R0fqoF8Vp6gy0OC
Content-Type: multipart/mixed; boundary="------------FOk1qaSv01TC1C12afP5Laln";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Message-ID: <e2e81547-e1a1-9743-16b2-ff78ab67efbb@suse.com>
Subject: Re: [PATCH v2 4/4] xen/blkback: move blkif_get_x86_*_req() into
 blkback.c
References: <20230314142741.24917-1-jgross@suse.com>
 <20230314142741.24917-5-jgross@suse.com>
 <a4b422c6-eb08-89e5-9c97-4e0c4d0f8f01@suse.com>
In-Reply-To: <a4b422c6-eb08-89e5-9c97-4e0c4d0f8f01@suse.com>

--------------FOk1qaSv01TC1C12afP5Laln
Content-Type: multipart/mixed; boundary="------------qTwKcS191XFvVpeaSmV16np9"

--------------qTwKcS191XFvVpeaSmV16np9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDMuMjMgMTU6MzMsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxNC4wMy4yMDIz
IDE1OjI3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gVjI6DQo+PiAtIGFkZCBjb25zdCwg
dXNlIHVuc2lnbmVkIGludCBmb3IgbG9vcCBjb3VudGVycyAoUm9nZXIgUGF1IE1vbm7DqSkN
Cj4gDQo+IEhtbSwgLi4uDQo+IA0KPj4gLS0tIGEvZHJpdmVycy9ibG9jay94ZW4tYmxrYmFj
ay9ibGtiYWNrLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2svYmxrYmFj
ay5jDQo+PiBAQCAtMTA3Miw3ICsxMDcyLDExMSBAQCBzdGF0aWMgdm9pZCBlbmRfYmxvY2tf
aW9fb3Aoc3RydWN0IGJpbyAqYmlvKQ0KPj4gICAJYmlvX3B1dChiaW8pOw0KPj4gICB9DQo+
PiAgIA0KPj4gK3N0YXRpYyB2b2lkIGJsa2lmX2dldF94ODZfMzJfcmVxKHN0cnVjdCBibGtp
Zl9yZXF1ZXN0ICpkc3QsDQo+PiArCQkJCSBjb25zdCBzdHJ1Y3QgYmxraWZfeDg2XzMyX3Jl
cXVlc3QgKnNyYykNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGludCBpLCBuOw0KPiANCj4gLi4u
IGhlcmUgeW91IGRpZCwgYnV0IC4uLg0KPiANCj4+ICtzdGF0aWMgdm9pZCBibGtpZl9nZXRf
eDg2XzY0X3JlcShzdHJ1Y3QgYmxraWZfcmVxdWVzdCAqZHN0LA0KPj4gKwkJCQkgc3RydWN0
IGJsa2lmX3g4Nl82NF9yZXF1ZXN0ICpzcmMpDQo+PiArew0KPj4gKwlpbnQgaSwgbjsNCj4g
DQo+IC4uLiB3aGF0IGFib3V0IHRoZXNlPw0KDQpPaCwgaW5kZWVkLiBJIGNvdWxkIHNheSBS
b2dlciBjb21tZW50ZWQgb25seSBvbiBibGtpZl9nZXRfeDg2XzMyX3JlcSgpLCBidXQgdGhp
cw0Kd291bGQgYmUgYSByYXRoZXIgbGFtZSBleGN1c2UuIDstKQ0KDQpJJ2xsIHJlc2VuZCB0
aGF0IGxhc3QgcGF0Y2guDQoNCg0KSnVlcmdlbg0KDQo=
--------------qTwKcS191XFvVpeaSmV16np9
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------qTwKcS191XFvVpeaSmV16np9--

--------------FOk1qaSv01TC1C12afP5Laln--

--------------n9iNOJwt0R0fqoF8Vp6gy0OC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQQh7AFAwAAAAAACgkQsN6d1ii/Ey+s
Lwf/W1GZkuCUcl//iOtOAJJ673B8AUDNKd/uo91bd/aJNJchgms7HaNX8vjQUju1yHnMLFvySB8N
QOpn1XrOx1e76ngnkVt3Jc5SeQA66g4nJfmKIiduvQM9DxLjp05FfprUgKJPuqUWY3LvE2wf2c5T
w1W+umV0rus9+jQRg8wB5+3AlZcCLYhdaZkubDfw9WBwFRueKp9il4IDfcpApKn1ERBvJ9Yli/hQ
rYTcXK0YYkWGHChTESow0uzw3eG5sjxJGfcMgAzlDwamdoAuG8PDuG/dacroe0EIadft7Nc9tIxD
ugph9LIJOTuH6TBhswDR/XrZTpcDrJz/ymIMaIU7hA==
=Jlsu
-----END PGP SIGNATURE-----

--------------n9iNOJwt0R0fqoF8Vp6gy0OC--
