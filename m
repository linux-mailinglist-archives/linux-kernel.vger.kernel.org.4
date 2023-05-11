Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EC26FF291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjEKNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbjEKNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:19:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C4DDA5;
        Thu, 11 May 2023 06:17:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D14F31FEB4;
        Thu, 11 May 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683811032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iMhfZvDj0NGI278JYjNVeszBwfq1tj+s4eq96jOp2w=;
        b=IMFXLrzu38RJtSr+TkMBmQULbXeeqnPDhcv+ruQZdrjwdLoRpaHsgHymP+HwjFsnCTyXYv
        5Z7XF8WWpzyc7nbcX0nral5tr4AfsmTTKpleGAGpiNBM7+kKrPLU4DumygXB5NwTD1Iboa
        HrZBUm+ylAf2MPLcyYj327Kepgt/nWM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0E27138FA;
        Thu, 11 May 2023 13:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vBP2JdjqXGRoIAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 May 2023 13:17:12 +0000
Message-ID: <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
Date:   Thu, 11 May 2023 15:17:11 +0200
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
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7gXYYGueqmcnoCUgmI4t70oQ"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7gXYYGueqmcnoCUgmI4t70oQ
Content-Type: multipart/mixed; boundary="------------NAk6cfG0TC9UddvUigMXoCIC";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Martin Wilck <mwilck@suse.com>, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
Message-ID: <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
In-Reply-To: <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>

--------------NAk6cfG0TC9UddvUigMXoCIC
Content-Type: multipart/mixed; boundary="------------U6bidQnqbH3Zk90kg5a0ZpmI"

--------------U6bidQnqbH3Zk90kg5a0ZpmI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDUuMjMgMTU6MTAsIE1hcnRpbiBXaWxjayB3cm90ZToNCj4gT24gVGh1LCAyMDIz
LTA1LTExIGF0IDE0OjM0ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gU29tZSBj
YWxsZXJzIG9mIHNjc2lfZXhlY3V0ZV9jbWQoKSAobGlrZSBlLmcuIHNkX3NwaW51cF9kaXNr
KCkpIGFyZQ0KPj4gcGFzc2luZyBhbiB1bmluaXRpYWxpemVkIHN0cnVjdCBzc2hkciBhbmQg
ZG9uJ3QgbG9vayBhdCB0aGUgcmV0dXJuDQo+PiB2YWx1ZSBvZiBzY3NpX2V4ZWN1dGVfY21k
KCkgYmVmb3JlIGxvb2tpbmcgYXQgdGhlIGNvbnRlbnRzIG9mIHRoYXQNCj4+IHN0cnVjdC4N
Cj4+DQo+PiBUaGlzIGNhbiByZXN1bHQgaW4gZmFsc2UgcG9zaXRpdmVzIHdoZW4gbG9va2lu
ZyBmb3Igc3BlY2lmaWMgZXJyb3INCj4+IGNvbmRpdGlvbnMuDQo+Pg0KPj4gSW4gb3JkZXIg
dG8gZml4IHRoYXQgbGV0IHNjc2lfZXhlY3V0ZV9jbWQoKSB6ZXJvIHNzaGRyLQ0KPj4+IHJl
c3BvbnNlX2NvZGUsDQo+PiByZXN1bHRpbmcgaW4gc2NzaV9zZW5zZV92YWxpZCgpIHJldHVy
bmluZyBmYWxzZS4NCj4+DQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gRml4
ZXM6IDM5NDllMmYwNDI2MiAoInNjc2k6IHNpbXBsaWZ5IHNjc2lfZXhlY3V0ZV9yZXFfZmxh
Z3MiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KPj4gLS0tDQo+PiBJJ20gbm90IGF3YXJlIG9mIGFueSByZWFsIGVycm9yIGhhdmluZyBo
YXBwZW5lZCBkdWUgdG8gdGhpcyBwcm9ibGVtLA0KPj4gYnV0IEkgdGhvdWdodCBpdCBzaG91
bGQgYmUgZml4ZWQgYW55d2F5Lg0KPj4gSSBfdGhpbmtfIDM5NDllMmYwNDI2MiB3YXMgaW50
cm9kdWNpbmcgdGhlIHByb2JsZW0sIGJ1dCBJJ20gbm90IDEwMCUNCj4+IHN1cmUgaXQgaXMg
cmVhbGx5IHRoZSBjb21taXQgdG8gYmUgYmxhbWVkLg0KPj4gLS0tDQo+PiAgwqBkcml2ZXJz
L3Njc2kvc2NzaV9saWIuYyB8IDE0ICsrKysrKysrKystLS0tDQo+PiAgwqAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IE9uZSBuaXRw
aWNrIGJlbG93LCBvdGhlcndpc2UgaXQgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5jIGIvZHJpdmVycy9zY3NpL3Nj
c2lfbGliLmMNCj4+IGluZGV4IGI3YzU2OWE0MmFhNC4uOTIzMzM2NjIwYmZmIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9zY3NpL3Njc2lfbGliLmMNCj4+ICsrKyBiL2RyaXZlcnMvc2Nz
aS9zY3NpX2xpYi5jDQo+PiBAQCAtMjA5LDExICsyMDksMTcgQEAgaW50IHNjc2lfZXhlY3V0
ZV9jbWQoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2LA0KPj4gY29uc3QgdW5zaWduZWQgY2hh
ciAqY21kLA0KPj4gIMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2NzaV9jbW5kICpzY21kOw0K
Pj4gIMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0KPj4gICANCj4+IC3CoMKgwqDCoMKgwqDC
oGlmICghYXJncykNCj4+ICvCoMKgwqDCoMKgwqDCoGlmICghYXJncykgew0KPj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJncyA9ICZkZWZhdWx0X2FyZ3M7DQo+PiAt
wqDCoMKgwqDCoMKgwqBlbHNlIGlmIChXQVJOX09OX09OQ0UoYXJncy0+c2Vuc2UgJiYNCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhcmdzLT5zZW5zZV9sZW4gIT0NCj4+IFNDU0lfU0VOU0VfQlVGRkVSU0laRSkpDQo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+PiAr
wqDCoMKgwqDCoMKgwqB9IGVsc2Ugew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC8qIE1hcmsgc2Vuc2UgZGF0YSB0byBiZSBpbnZhbGlkLiAqLw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChhcmdzLT5zc2hkcikNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJncy0+c3NoZHItPnJlc3Bv
bnNlX2NvZGUgPSAwOw0KPiANCj4gV2Uga25vdyBmb3IgY2VydGFpbiB0aGF0IHNpemVvZigq
c3NoZHIpIGlzIDggYnl0ZXMsIGFuZCB3aWxsIG1vc3QNCj4gcHJvYmFibHkgcmVtYWluIHNv
LiBUaHVzDQo+IA0KPiAgICAgIG1lbXNldChzc2hkciwgMCwgc2l6ZW9mKCpzc2hkcikpDQo+
IA0KPiB3b3VsZCByZXN1bHQgaW4gbW9yZSBlZmZpY2llbnQgY29kZS4NCg0KSSBmYWlsIHRv
IHNlZSB3aHkgemVyb2luZyBhIHNpbmdsZSBieXRlIHdvdWxkIGJlIGxlc3MgZWZmaWNpZW50
IHRoYW4gemVyb2luZw0KYSBwb3NzaWJseSB1bmFsaWduZWQgOC1ieXRlIGFyZWEuDQoNCg0K
SnVlcmdlbg0K
--------------U6bidQnqbH3Zk90kg5a0ZpmI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------U6bidQnqbH3Zk90kg5a0ZpmI--

--------------NAk6cfG0TC9UddvUigMXoCIC--

--------------7gXYYGueqmcnoCUgmI4t70oQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRc6tgFAwAAAAAACgkQsN6d1ii/Ey+n
ZQf/ZzX/OUcQ0dUMt+EZ55CtyVzgnT3RBe3rSFAU2pT2pJCSTffr4OwVGlHAiMap4PeX5jrEGWXL
XKZ5V5pIfSsSZ/mjwn3l3TNdsmrPp7WtNAQmO17/274FeV/Zr1owxSW7azdUYUBUsf9gEgB28CAC
wMETFwND3SYJkWJBsO3ymTOmidIBDeu+/mlDYi8RwMMddXGIryGKUwcyuSpGWYmlzyGlMs3mIx4q
26aMmDX5qNFOQZqDCMNPiMCOSB34FPuV2/SPuQ/yDcCh5B4tsKtV4GzV0El50gS7Sh65Y2jlohxB
jmwQK+VVwA5Q62wbyn/07Gsy2NAtAJFUZuc90vSKPQ==
=u6Rf
-----END PGP SIGNATURE-----

--------------7gXYYGueqmcnoCUgmI4t70oQ--
