Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22C6638C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAJFti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjAJFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:48:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4C40C28
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:47:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF75E4DC62;
        Tue, 10 Jan 2023 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673329677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6nR2J48veGxgqbDtj3mpE0l8hzEZ8e4y9D3DftLzn5w=;
        b=sQmGPAehePLtDdoBg7Pz/MNCfPqEDN2lQqd0h1bQhgM/4WgUu/kr39MOv8woNuhkfOlpwO
        Cdd39ALB9rCo2dyWVve2DeT4dFriFkOAo0xf0q5zCtkku7XqiMjSW4G+52+Nl509NSwvee
        XZxc0R38z/drh22FG/QIYp617jXQAKU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3B3713458;
        Tue, 10 Jan 2023 05:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uVKCJg38vGNyRgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 05:47:57 +0000
Message-ID: <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
Date:   Tue, 10 Jan 2023 06:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Jan Beulich <jbeulich@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------s2hryonzbwnhOTjl3olsUKO7"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------s2hryonzbwnhOTjl3olsUKO7
Content-Type: multipart/mixed; boundary="------------Az9IynJ4vGV7ZPasu5p0pfX8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Andrew Lutomirski <luto@kernel.org>, Jan Beulich <jbeulich@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <03edcbc5-2dd7-1ddb-bafe-8412d8fc95aa@suse.com>
Subject: Re: Problem with pat_enable() and commit 72cbc8f04fe2
References: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------Az9IynJ4vGV7ZPasu5p0pfX8
Content-Type: multipart/mixed; boundary="------------PVNmTecz6Ude3kl9G08cGM1s"

--------------PVNmTecz6Ude3kl9G08cGM1s
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDEuMjMgMTk6MjgsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEkn
dmUgY29tZSBhY3Jvc3MgYSBjYXNlIHdpdGggYSBWTSBydW5uaW5nIG9uIEh5cGVyLVYgdGhh
dCBkb2Vzbid0IGdldA0KPiBNVFJScywgYnV0IHRoZSBQQVQgaXMgZnVuY3Rpb25hbC4gIChU
aGlzIGlzIGEgQ29uZmlkZW50aWFsIFZNIHVzaW5nDQo+IEFNRCdzIFNFVi1TTlAgZW5jcnlw
dGlvbiB0ZWNobm9sb2d5IHdpdGggdGhlIHZUT00gb3B0aW9uLikgIEluIHRoaXMNCj4gY2Fz
ZSwgdGhlIGNoYW5nZXMgaW4gY29tbWl0IDcyY2JjOGYwNGZlMiAoIng4Ni9QQVQ6IEhhdmUg
cGF0X2VuYWJsZWQoKQ0KPiBwcm9wZXJseSByZWZsZWN0IHN0YXRlIHdoZW4gcnVubmluZyBv
biBYZW4iKSBhcHBseS4gICBwYXRfZW5hYmxlZCgpIHJldHVybnMNCj4gInRydWUiLCBidXQg
dGhlIE1UUlJzIGFyZSBub3QgZW5hYmxlZC4NCj4gDQo+IEJ1dCB3aXRoIHRoaXMgY29tbWl0
LCB0aGVyZSdzIGEgcHJvYmxlbS4gIENvbnNpZGVyIG1lbXJlbWFwKCkgb24gYSBSQU0NCj4g
cmVnaW9uLCBjYWxsZWQgd2l0aCBNRU1SRU1BUF9XQiBwbHVzIE1FTVJFTUFQX0RFQyBhcyB0
aGUgM3JkDQo+IGFyZ3VtZW50LiBCZWNhdXNlIG9mIHRoZSByZXF1ZXN0IGZvciBhIGRlY3J5
cHRlZCBtYXBwaW5nLA0KPiBhcmNoX21lbXJlbWFwX2Nhbl9yYW1fcmVtYXAoKSByZXR1cm5z
IGZhbHNlLCBhbmQgYSBuZXcgbWFwcGluZw0KPiBtdXN0IGJlIGNyZWF0ZWQsIHdoaWNoIGlz
IGFwcHJvcHJpYXRlLg0KPiANCj4gVGhlIGZvbGxvd2luZyBjYWxsIHN0YWNrIHJlc3VsdHM6
DQo+IA0KPiAgICBtZW1yZW1hcCgpDQo+ICAgIGFyY2hfbWVtcmVtYXBfd2IoKQ0KPiAgICBp
b3JlbWFwX2NhY2hlKCkNCj4gICAgX19pb3JlbWFwX2NhbGxlcigpDQo+ICAgIG1lbXR5cGVf
cmVzZXJ2ZSgpICA8LS0tIHBjbSBpcyBfUEFHRV9DQUNIRV9NT0RFX1dCDQo+ICAgIHBhdF94
X210cnJfdHlwZSgpICA8LS0gb25seSBjYWxsZWQgYWZ0ZXIgY29tbWl0IDcyY2JjOGYwNGZl
Mg0KPiANCj4gcGF0X3hfbXRycl90eXBlKCkgcmV0dXJucyBfUEFHRV9DQUNIRV9NT0RFX1VD
X01JTlVTIGJlY2F1c2UNCj4gbXRycl90eXBlX2xvb2t1cCgpIGZhaWxzLiAgQXMgYSByZXN1
bHQsIG1lbXJlbWFwKCkgZXJyb25lb3VzbHkgY3JlYXRlcyB0aGUNCj4gbmV3IG1hcHBpbmcg
YXMgdW5jYWNoZWQuICAgVGhpcyB1bmNhY2hlZCBtYXBwaW5nIGlzIGNhdXNpbmcgYSBzaWdu
aWZpY2FudA0KPiBwZXJmb3JtYW5jZSBwcm9ibGVtIGluIGNlcnRhaW4gSHlwZXItViBDb25m
aWRlbnRpYWwgVk0gY29uZmlndXJhdGlvbnMuDQo+IA0KPiBBbnkgdGhvdWdodHMgb24gcmVz
b2x2aW5nIHRoaXM/ICBTaG91bGQgbWVtdHlwZV9yZXNlcnZlKCkgYmUgY2hlY2tpbmcNCj4g
Ym90aCBwYXRfZW5hYmxlZCgpICphbmQqIHdoZXRoZXIgTVRSUnMgYXJlIGVuYWJsZWQgYmVm
b3JlIGNhbGxpbmcNCj4gcGF0X3hfbXRycl90eXBlKCk/ICBPciBkb2VzIHRoYXQgZGVmZWF0
IHRoZSBwdXJwb3NlIG9mIGNvbW1pdA0KPiA3MmNiYzhmMDRmZTIgaW4gdGhlIFhlbiBlbnZp
cm9ubWVudD8NCg0KSSB0aGluayBwYXRfeF9tdHJyX3R5cGUoKSBzaG91bGQgcmV0dXJuIF9Q
QUdFX0NBQ0hFX01PREVfVUNfTUlOVVMgb25seSBpZg0KbXRycl90eXBlX2xvb2t1cCgpIGlz
IG5vdCBmYWlsaW5nIGFuZCBpcyByZXR1cm5pbmcgYSBtb2RlIG90aGVyIHRoYW4gV0IuDQoN
CkknbGwgc2VuZCBhIHBhdGNoLg0KDQo+IEknbSBhbHNvIGxvb2tpbmcgYXQgaG93IHRvIGF2
b2lkIHRoaXMgY29tYmluYXRpb24gaW4gYSBIeXBlci1WIENvbmZpZGVudGlhbA0KPiBWTSwg
YnV0IHRoYXQgZG9lc24ndCBhZGRyZXNzIHVuZGVybHlpbmcgdGhlIGZsYXcuDQoNClllcy4N
Cg0KDQpKdWVyZ2VuDQo=
--------------PVNmTecz6Ude3kl9G08cGM1s
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PVNmTecz6Ude3kl9G08cGM1s--

--------------Az9IynJ4vGV7ZPasu5p0pfX8--

--------------s2hryonzbwnhOTjl3olsUKO7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO8/A0FAwAAAAAACgkQsN6d1ii/Ey+E
XQf9FXFccfJOnG/tmPwFInZjxEORcoptE0XtMp96Sp5kVPsgPzBj4Tgmx1bVlxG8UNrAtIl18Txy
7M6k2SbkWOsoLPqM2USmvmYDlBAhjbUDvrSh16HTzQDrfAO8YT5MDAIrwtcBNJ6D6mggFIOAbg7G
9rfHHcuA6U1+zNXOlvZWIcjOEqRLkOYH21eYczxBQZYf+nbgA31kOPqf7l58RQBHbn1ThUIzsEDl
2PS4cxMwwgIsvFeXP586iuaBTMIS+YFkJ4haajpguYMWtql0332j9a0eWSwlHUomWFbrSGConyrS
WgAgSWeC7BNIT7B19vM3UKZXnQsAcrr/d0NWC36cxA==
=lv3X
-----END PGP SIGNATURE-----

--------------s2hryonzbwnhOTjl3olsUKO7--
