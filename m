Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C496FF2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjEKNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbjEKNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:33:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C222700;
        Thu, 11 May 2023 06:32:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF6071FEB4;
        Thu, 11 May 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683811953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9Gw89LsVWDXknjK9wsazx8tUQuttNJKAyf5DBRTkFo=;
        b=b6bRdGzsaAVEankWlRffwcd9ratTCqqyuX/vw1ZZrCqLC0Ohw5AUN+JMiTQvFjX/CBqVTI
        3kXFKPPRA7S2M76RWpS8fqo1xdLTePW+dv00l0zk/o3HBe73/aIU71esF6TsCtaviPg8RI
        qgR5dWJWjqT9vP1G29RdyovDvK2eYTU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89E18138FA;
        Thu, 11 May 2023 13:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /UAaIHHuXGQEKQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 May 2023 13:32:33 +0000
Message-ID: <45d127c4-71e9-2959-b69c-d31c46ec721e@suse.com>
Date:   Thu, 11 May 2023 15:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     Martin Wilck <mwilck@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
 <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
 <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AmTzaEmwjNDFarnUqUcdU2He"
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
--------------AmTzaEmwjNDFarnUqUcdU2He
Content-Type: multipart/mixed; boundary="------------8VleNbXuViHE90YbagetCfNQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Martin Wilck <mwilck@suse.com>, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
Message-ID: <45d127c4-71e9-2959-b69c-d31c46ec721e@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
 <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
 <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>
In-Reply-To: <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>

--------------8VleNbXuViHE90YbagetCfNQ
Content-Type: multipart/mixed; boundary="------------ZCDTGmwg4WcLL3ym70Z0wmG0"

--------------ZCDTGmwg4WcLL3ym70Z0wmG0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDUuMjMgMTU6MjMsIE1hcnRpbiBXaWxjayB3cm90ZToNCj4gT24gVGh1LCAyMDIz
LTA1LTExIGF0IDE1OjE3ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+DQo+Pj4g
V2Uga25vdyBmb3IgY2VydGFpbiB0aGF0IHNpemVvZigqc3NoZHIpIGlzIDggYnl0ZXMsIGFu
ZCB3aWxsIG1vc3QNCj4+PiBwcm9iYWJseSByZW1haW4gc28uIFRodXMNCj4+Pg0KPj4+ICDC
oMKgwqDCoCBtZW1zZXQoc3NoZHIsIDAsIHNpemVvZigqc3NoZHIpKQ0KPj4+DQo+Pj4gd291
bGQgcmVzdWx0IGluIG1vcmUgZWZmaWNpZW50IGNvZGUuDQo+Pg0KPj4gSSBmYWlsIHRvIHNl
ZSB3aHkgemVyb2luZyBhIHNpbmdsZSBieXRlIHdvdWxkIGJlIGxlc3MgZWZmaWNpZW50IHRo
YW4NCj4+IHplcm9pbmcNCj4+IGEgcG9zc2libHkgdW5hbGlnbmVkIDgtYnl0ZSBhcmVhLg0K
PiANCj4gSSBkb24ndCB0aGluayBpdCBjYW4gYmUgdW5hbGlnbmVkLiBnY2Mgc2VlbXMgdG8g
dGhpbmsgdGhlIHNhbWUuIEl0DQo+IGNvbXBpbGVzIHRoZSBtZW1zZXQoc3NoZHIsIC4uLikg
aW4gc2NzaV9ub3JtYWxpemVfc2Vuc2UoKSBpbnRvIGEgc2luZ2xlDQo+IGluc3RydWN0aW9u
IG9uIHg4Nl82NC4NCj4gDQo+IDB4ZmZmZmZmZmY4MTc3ZTlkMCA8c2NzaV9ub3JtYWxpemVf
c2Vuc2U+OiAgICAgIG5vcGwgICAweDAoJXJheCwlcmF4LDEpIFtGVFJBQ0UgTk9QXQ0KPiAw
eGZmZmZmZmZmODE3N2U5ZDUgPHNjc2lfbm9ybWFsaXplX3NlbnNlKzU+OiAgICB0ZXN0ICAg
JXJkaSwlcmRpDQo+IDB4ZmZmZmZmZmY4MTc3ZTlkOCA8c2NzaV9ub3JtYWxpemVfc2Vuc2Ur
OD46ICAgIG1vdnEgICAkMHgwLCglcmR4KQ0KDQpBIHN0cnVjdCB3aXRoIDggInU4IiBmaWVs
ZHMgY2FuIGJlIHVuYWxpZ25lZC4NCg0KeDg2XzY0IGNhbiBkbyB1bmFsaWduZWQgOC1ieXRl
IHN0b3Jlcy4NCg0KT3RoZXIgYXJjaGl0ZWN0dXJlcyBjYW4ndCAoZS5nLiBNSVBTKS4gQW5k
IDMyLWJpdCBhcmNoaXRlY3R1cmVzIG1pZ2h0IG5lZWQNCjIgc3RvcmVzLg0KDQoNCkp1ZXJn
ZW4NCg==
--------------ZCDTGmwg4WcLL3ym70Z0wmG0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ZCDTGmwg4WcLL3ym70Z0wmG0--

--------------8VleNbXuViHE90YbagetCfNQ--

--------------AmTzaEmwjNDFarnUqUcdU2He
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRc7nEFAwAAAAAACgkQsN6d1ii/Ey95
xAf9ELMwKAp13ydHnLPOCZcsC+W1qCni+ViTkFbkZODuOumkWTv1uUIRmLePebmTClzcx7VhsNpj
a048uAX7Bvj/ij0ie2ZQG22u4thOiLw41W6X5DpMS2JUKxi3QdPGHUEUsjqkYYDk1J2A0mmF6jjt
UZlb/sUbuQY3/ZvbSxdeT7oubWd9/D6PFlnTICyAVC4tiG1n79l/ylmjygHULaqA6W22HWGYRWAB
1DUq/BocRTTZzzSPqT56ukMt6IwdWQlCUP/DYs7SHLpdBx8ZcrQXKF9GsD8nNshGCDZyDbW1avbp
drVP7KuOckqmecbeyiYQMgEJVBoQiD/ASuGt7Tx8xw==
=fNLa
-----END PGP SIGNATURE-----

--------------AmTzaEmwjNDFarnUqUcdU2He--
