Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16766FF1F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjEKMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjEKMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:54:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBD197;
        Thu, 11 May 2023 05:54:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D75721C06;
        Thu, 11 May 2023 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683809684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZ2oHp4hPyY00F72pl5A2T/eP0JKivvRzv0m4ySdum0=;
        b=LWt1rXlAzrZwvwkBtPcnnJk/cmm2yrrGLICmqsDQ6Lieq5fe6dJP5SLB6ZtAN7kCmqH2yE
        bWYWyj1grtZf9vWoqDhxEj+w3ZgkQ2vpZj3zluirheuq5H4gUvTctDOOPkFn1w0DgCknLw
        133oyK22+toFbUveoSYoHCCCNE2qarI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09433138FA;
        Thu, 11 May 2023 12:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UZi7AJTlXGSqEwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 May 2023 12:54:44 +0000
Message-ID: <25e7e89f-d9d6-5c6a-d8f5-fb5d15ed7cbf@suse.com>
Date:   Thu, 11 May 2023 14:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <1d364245-f2ed-0354-702b-0ac745ef3e96@acm.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <1d364245-f2ed-0354-702b-0ac745ef3e96@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f88JXosyk6bGCv6bEW4vECd8"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f88JXosyk6bGCv6bEW4vECd8
Content-Type: multipart/mixed; boundary="------------3Tfj0XisR0nznNAs7sMsOjba";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
Message-ID: <25e7e89f-d9d6-5c6a-d8f5-fb5d15ed7cbf@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <1d364245-f2ed-0354-702b-0ac745ef3e96@acm.org>
In-Reply-To: <1d364245-f2ed-0354-702b-0ac745ef3e96@acm.org>

--------------3Tfj0XisR0nznNAs7sMsOjba
Content-Type: multipart/mixed; boundary="------------c80vMLcPKM2XLuPg3VPAnrC2"

--------------c80vMLcPKM2XLuPg3VPAnrC2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDUuMjMgMTQ6NDksIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNS8xMS8y
MyAwNTozNCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IFNvbWUgY2FsbGVycyBvZiBzY3Np
X2V4ZWN1dGVfY21kKCkgKGxpa2UgZS5nLiBzZF9zcGludXBfZGlzaygpKSBhcmUNCj4+IHBh
c3NpbmcgYW4gdW5pbml0aWFsaXplZCBzdHJ1Y3Qgc3NoZHIgYW5kIGRvbid0IGxvb2sgYXQg
dGhlIHJldHVybg0KPj4gdmFsdWUgb2Ygc2NzaV9leGVjdXRlX2NtZCgpIGJlZm9yZSBsb29r
aW5nIGF0IHRoZSBjb250ZW50cyBvZiB0aGF0DQo+PiBzdHJ1Y3QuDQo+IA0KPiBTaG91bGRu
J3QgdGhlIHNjc2lfZXhlY3V0ZV9jbWQoKSBjYWxsZXJzIGJlIGZpeGVkIGluc3RlYWQgb2Yg
bW9kaWZ5aW5nIA0KPiBzY3NpX2V4ZWN1dGVfY21kKCksIGUuZy4gYnkgemVyby1pbml0aWFs
aXppbmcgdGhlIHNzaGRyIHN0cnVjdHVyZT8NCg0KVGhpcyB3b3VsZCBiZSBwb3NzaWJsZSwg
eWVzLCBidXQgaW50cm9kdWNpbmcgbmV3IGJ1Z2d5IGNhbGxlcnMgY291bGQgaGFwcGVuLg0K
DQpBZGRpdGlvbmFsbHkgdGhlIGFtb3VudCBvZiBjb2RlIGNodXJuIHdvdWxkIGJlIG11Y2gg
bGFyZ2VyLg0KDQoNCkp1ZXJnZW4NCg0KDQo=
--------------c80vMLcPKM2XLuPg3VPAnrC2
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------c80vMLcPKM2XLuPg3VPAnrC2--

--------------3Tfj0XisR0nznNAs7sMsOjba--

--------------f88JXosyk6bGCv6bEW4vECd8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRc5ZMFAwAAAAAACgkQsN6d1ii/Ey9c
Ygf/YRCftBr80U1q1nCAu6xz7w0NpUvVtx7UEZvANCKkzvJAN1FoXxy64rmKf22g2/LvtGzMc/9S
CUyjnC2IuBgfQ0xVdxcezJazpqlOtEHMAWTo/x++Z9LqpiVzRzkPkLaeHrHeZNujCQ4h/VPB+47J
FeOF2gwEigznvMgZAV22/tVquY1aQxA49sqx5P608JFGGtwzFvKa3LWcWb5UZWgqVgqN/We5xfsa
ao575IUp27j/x+L/XXMR8MhR2GqpWiytrgioOW1ybH/S8u2jGLzQtS0wJflWc4/rXruKUk4+3RT1
/7Wjt1rlCrPDmRu0DH45UHoysUYF5ChvMQ7a6wpXHg==
=titM
-----END PGP SIGNATURE-----

--------------f88JXosyk6bGCv6bEW4vECd8--
