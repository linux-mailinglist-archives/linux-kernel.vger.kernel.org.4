Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF74705F00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjEQEyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjEQEyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:54:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC91BF;
        Tue, 16 May 2023 21:54:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1511226E7;
        Wed, 17 May 2023 04:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684299278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWZkKDly6UrF08WFSKFIM5mwpzlYOxjZ3ccxBqQ7tTA=;
        b=IZUSMQGAYqiU1h9saN+9cLI2IsD7bkNt8t30RbeQe7bCSKnDH0f2mTRE1kZM33cubBrDv+
        udIpzmHbapOMnd0SYKxWIJ2wHJNtAd1YfkZpGGY/Jtop0YN41xJ3Wl4TAE2RmqQ1M3tHXl
        uyJL6byqtMM2oAsG7uUICDM0iTQN5co=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8594C13478;
        Wed, 17 May 2023 04:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WpZ6Hw5eZGRwSAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 17 May 2023 04:54:38 +0000
Message-ID: <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
Date:   Wed, 17 May 2023 06:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
In-Reply-To: <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VynfZeR0Zs3FLfUChVryoRdd"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VynfZeR0Zs3FLfUChVryoRdd
Content-Type: multipart/mixed; boundary="------------65tiF7x8ki04pxuY1LvH4n4V";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Message-ID: <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>

--------------65tiF7x8ki04pxuY1LvH4n4V
Content-Type: multipart/mixed; boundary="------------1IVi3w3S37QiPdQWBMzpyRGs"

--------------1IVi3w3S37QiPdQWBMzpyRGs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjMgMDQ6MDYsIE1hcnRpbiBLLiBQZXRlcnNlbiB3cm90ZToNCj4gDQo+IEp1
ZXJnZW4sDQo+IA0KPj4gU29tZSBjYWxsZXJzIG9mIHNjc2lfZXhlY3V0ZV9jbWQoKSAobGlr
ZSBlLmcuIHNkX3NwaW51cF9kaXNrKCkpIGFyZQ0KPj4gcGFzc2luZyBhbiB1bmluaXRpYWxp
emVkIHN0cnVjdCBzc2hkciBhbmQgZG9uJ3QgbG9vayBhdCB0aGUgcmV0dXJuDQo+PiB2YWx1
ZSBvZiBzY3NpX2V4ZWN1dGVfY21kKCkgYmVmb3JlIGxvb2tpbmcgYXQgdGhlIGNvbnRlbnRz
IG9mIHRoYXQNCj4+IHN0cnVjdC4NCj4gDQo+IFdoaWNoIGNhbGxlcnM/IHNkX3NwaW51cF9k
aXNrKCkgYXBwZWFycyB0byBkbyB0aGUgcmlnaHQgdGhpbmcuLi4NCj4gDQoNCk5vdCByZWFs
bHkuIEl0IGlzIGNhbGxpbmcgbWVkaWFfbm90X3ByZXNlbnQoKSBkaXJlY3RseSBhZnRlciB0
aGUgY2FsbCBvZg0Kc2NzaV9leGVjdXRlX2NtZCgpIHdpdGhvdXQgY2hlY2tpbmcgdGhlIHJl
c3VsdC4gbWVkaWFfbm90X3ByZXNlbnQoKSBpcyBsb29raW5nDQphdCBzc2hkciwgd2hpY2gg
aXMgdW5pbml0aWFsaXplZCBpbiBjYXNlIG9mIGFuIGVhcmx5IGVycm9yIGluDQpzY3NpX2V4
ZWN1dGVfY21kKCkuIFRoZSBzYW1lIGFwcGxpZXMgdG8gcmVhZF9jYXBhY2l0eV8xWzA2XSgp
Lg0KDQpzY3NpX3Rlc3RfdW5pdF9yZWFkeSgpIGFuZCBzY3NpX3JlcG9ydF9sdW5fc2Nhbigp
IGhhdmUgdGhlIHByb2JsZW0sIHRvby4NCg0KRG8gSSBuZWVkIHRvIGZpbmQgb3RoZXIgZXhh
bXBsZXM/DQoNCg0KSnVlcmdlbg0K
--------------1IVi3w3S37QiPdQWBMzpyRGs
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1IVi3w3S37QiPdQWBMzpyRGs--

--------------65tiF7x8ki04pxuY1LvH4n4V--

--------------VynfZeR0Zs3FLfUChVryoRdd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRkXg4FAwAAAAAACgkQsN6d1ii/Ey+9
mQgAkLJQrMbOGzMBl5aEvua4miR6hM6GPt5iGqAkD2psjHz1ebim7nN7W5cCgjjlOyShQkDCTbIZ
BFY9c+CVvyngHE6BwA6rpqy2FWa0QkJCr7Z1f819iPm+HAfqqmfS7HyC4Ut+3cJtCk09Ydk+Bvgv
H8Gzi6CWgY2BCcjjhjhE50uURPkotL6eYRbXw9Uxt/uCf9T62C6XGsfH7u9859PHReyLc5P6qiDj
CbH0Wt12LG4j92mlh6g7h3pQ7SP5uc80QraT6QRTP+MDpqHwjD73yF5wZLmnIb6B+crz/Tn3Oti5
r97s8XODsGH98SilY1tegVNfm28GeeQTV1J5euAVrg==
=NEFs
-----END PGP SIGNATURE-----

--------------VynfZeR0Zs3FLfUChVryoRdd--
