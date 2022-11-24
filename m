Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E0637D23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKXPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKXPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082781173C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:39:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4EB421116;
        Thu, 24 Nov 2022 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669304386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVU414zfbUm2A5y1GOkaZ9BZzgZN37LCy+XUUBznaxY=;
        b=cYzDwpaI/9LjCBKGYfXmH3ZQkZ9vN3HHBWO7UR8awdBVreEAHQfsTz+AjL/uKmJ6uoQvXk
        JGoY96nQ6+G4+zjiLpg/N2HGyGGKawVBy36Ufjy5Ldkz5APSaTIDJMHt/1Id/X3c4LbBxY
        YRNJjOumJ1IWEJH+bbkhc5dS9engY7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E4A913B4F;
        Thu, 24 Nov 2022 15:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1oGOFUKQf2O0cAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 15:39:46 +0000
Message-ID: <d09dc29e-0f68-3a48-5d5c-f2d39debe9ef@suse.com>
Date:   Thu, 24 Nov 2022 16:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] x86/xen: Fix memory leak in
 xen_smp_intr_init{_pv}()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, boris.ostrovsky@oracle.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jeremy@goop.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20221123155858.11382-1-xiujianfeng@huawei.com>
 <20221123155858.11382-2-xiujianfeng@huawei.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221123155858.11382-2-xiujianfeng@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S35eaZd0j89mmKCyPx08j3kb"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S35eaZd0j89mmKCyPx08j3kb
Content-Type: multipart/mixed; boundary="------------whnj3FRMM09BBjAxi0ZWTByg";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>, boris.ostrovsky@oracle.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, jeremy@goop.org
Cc: x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <d09dc29e-0f68-3a48-5d5c-f2d39debe9ef@suse.com>
Subject: Re: [PATCH v2 1/2] x86/xen: Fix memory leak in
 xen_smp_intr_init{_pv}()
References: <20221123155858.11382-1-xiujianfeng@huawei.com>
 <20221123155858.11382-2-xiujianfeng@huawei.com>
In-Reply-To: <20221123155858.11382-2-xiujianfeng@huawei.com>

--------------whnj3FRMM09BBjAxi0ZWTByg
Content-Type: multipart/mixed; boundary="------------a9LCdkXEub1w0kVnalGgGY1q"

--------------a9LCdkXEub1w0kVnalGgGY1q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMTEuMjIgMTY6NTgsIFhpdSBKaWFuZmVuZyB3cm90ZToNCj4gVGhlc2UgbG9jYWwg
dmFyaWFibGVzIEB7cmVzY2hlZHxwbXV8Y2FsbGZ1bmMuLi59X25hbWUgc2F2ZXMgdGhlIG5l
dw0KPiBzdHJpbmcgYWxsb2NhdGVkIGJ5IGthc3ByaW50ZigpLCBhbmQgd2hlbiBiaW5kX3t2
fWlwaV90b19pcnFoYW5kbGVyKCkNCj4gZmFpbHMsIGl0IGdvZXMgdG8gdGhlIEBmYWlsIHRh
ZywgYW5kIGNhbGxzIHhlbl9zbXBfaW50cl9mcmVle19wdn0oKSB0bw0KPiBmcmVlIHJlc291
cmNlLCBob3dldmVyIHRoZSBuZXcgc3RyaW5nIGlzIG5vdCBzYXZlZCwgd2hpY2ggY2F1c2Ug
YSBtZW1vcnkNCj4gbGVhayBpc3N1ZS4gZml4IGl0Lg0KPiANCj4gRml4ZXM6IDk3MDI3ODVh
NzQ3YSAoImkzODY6IG1vdmUgeGVuIikNCj4gU2lnbmVkLW9mZi1ieTogWGl1IEppYW5mZW5n
IDx4aXVqaWFuZmVuZ0BodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg0K
--------------a9LCdkXEub1w0kVnalGgGY1q
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------a9LCdkXEub1w0kVnalGgGY1q--

--------------whnj3FRMM09BBjAxi0ZWTByg--

--------------S35eaZd0j89mmKCyPx08j3kb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/kEIFAwAAAAAACgkQsN6d1ii/Ey9A
Ngf+JW1FpJQ3Q/U1OwyMpz6NnvZJ0UaaHX7PCntua7xqGOiSsrZor4jNe9JH92ieett/gs33m9wK
DIY0qJSg7JqInXguaTMyxOOSfR2r2ziX+ce86Eo+ybaxO7UWIeFO0RmzstsRZq4tv/XQE2bvswF7
/KU+ZvCLLrvfp1+7TxMdAJEzRbgZF14Y74JuC9Z4F5BqxIr7EnGDIsSjthQgKnej4cBtQDXYyqhx
63zMbtzqqhOyTWfP3rHsiaoeXfuR8WUBzSdSVkUn3vrd4UY6XcRPS1NO/p0Jf5Am61mV8+RWUaA2
O1CfT0gWL9qe2rACNhWea6aLzStps6181AyUwltgbQ==
=gyfQ
-----END PGP SIGNATURE-----

--------------S35eaZd0j89mmKCyPx08j3kb--
