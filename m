Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83525637771
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKXLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:18:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B3C764
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:18:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B040C1FD63;
        Thu, 24 Nov 2022 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669288710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7Oi306SnFkkOGq94/VRYf5uLWEXKQ4BMkxIMwQ+nxw=;
        b=JUh8Oo9LStrhLLhpDd5WdysCcqeZ2L8PWqGRzf82lS9z8UZGkcV87emQn+gm0MN68UQEPR
        yPd6s9CVDd//sYd92SS5cBZXiVHSxkHXPITeUj1GWhPSrQJwhJiZ/vfHdFaBfo909O/6fK
        Ng0XxW6ef/enG9HlF2UZq3FE/lDJJXE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A4E513B4F;
        Thu, 24 Nov 2022 11:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VEO7DAZTf2PeXAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 11:18:30 +0000
Message-ID: <f2b89349-b41a-ae3a-6974-9f74f6791822@suse.com>
Date:   Thu, 24 Nov 2022 12:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] x86/paravirt: Use relative reference for original
 instruction
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        virtualization@lists.linux-foundation.org
References: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
 <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
 <20221124110653.GA88913@k08j02272.eu95sqa>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221124110653.GA88913@k08j02272.eu95sqa>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Jpe3dMAeWai110dg6h3E9p8f"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Jpe3dMAeWai110dg6h3E9p8f
Content-Type: multipart/mixed; boundary="------------Y8GAedUP2EVEU6K8eugROtAr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: linux-kernel@vger.kernel.org,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 Nadav Amit <namit@vmware.com>, virtualization@lists.linux-foundation.org
Message-ID: <f2b89349-b41a-ae3a-6974-9f74f6791822@suse.com>
Subject: Re: [PATCH] x86/paravirt: Use relative reference for original
 instruction
References: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
 <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
 <20221124110653.GA88913@k08j02272.eu95sqa>
In-Reply-To: <20221124110653.GA88913@k08j02272.eu95sqa>

--------------Y8GAedUP2EVEU6K8eugROtAr
Content-Type: multipart/mixed; boundary="------------TzMz201WCXBlbxQNRPizG4tj"

--------------TzMz201WCXBlbxQNRPizG4tj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMTI6MDYsIEhvdSBXZW5sb25nIHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAy
NCwgMjAyMiBhdCAxMToxODo1MkFNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4g
T24gMjQuMTEuMjIgMDk6NTEsIEhvdSBXZW5sb25nIHdyb3RlOg0KPj4+IFNpbWlsYXIgdG8g
dGhlIGFsdGVybmF0aXZlIHBhdGNoaW5nLCB1c2UgcmVsYXRpdmUgcmVmZXJlbmNlIGZvciBv
cmlnaW5hbA0KPj4+IGluc3RydWN0aW9uIHJhdGhlciB0aGFuIGFic29sdXRlIG9uZSwgd2hp
Y2ggc2F2ZXMgOCBieXRlcyBmb3Igb25lIGVudHJ5DQo+Pj4gb24geDg2XzY0LiAgQW5kIGl0
IGNvdWxkIGdlbmVyYXRlIFJfWDg2XzY0X1BDMzIgcmVsb2NhdGlvbiBpbnN0ZWFkIG9mDQo+
Pg0KPj4gOCBieXRlcyBzYXZlZD8gSSB0aGluayB0aG9zZSBhcmUgNCBieXRlcyBvbmx5Lg0K
Pj4NCj4gVGhlIGNvcnJlc3BvbmRpbmcgQyBzdHJ1Y3R1cmUgcGFyYXZpcnRfcGF0Y2hfc2l0
ZSBpcyBub3QgcGFja2VkLCBCZWZvcmUgdGhpcywNCj4gaXRzIHNpemUgaXMgMTYgYnl0ZXMg
aW4geDg2XzY077yMZHVlIHRvIHRoZSBhbGlnbm1lbnQgb2YgOCBieXRlcy4gTm93IHRoZSBh
bGlnbm1lbnQNCj4gaXMgNCBieXRlcywgc28gdGhlIHNpemUgaXMgOCBieXRlcy4NCg0KT2gs
IEkndmUgbG9va2VkIGF0IExpbnVzJyB0cmVlLiBZb3Ugc2VlbSB0byBoYXZlIGJhc2VkIHlv
dXIgcmVhc29uaW5nIG9uDQp0aGUgdGlwL3BhcmF2aXJ0IGJyYW5jaCwgd2hpY2ggaXMgZmlu
ZS4NCg0KPiANCj4+PiBSX1g4Nl82NF82NCByZWxvY2F0aW9uLCB3aGljaCBhbHNvIHJlZHVj
ZXMgcmVsb2NhdGlvbiBtZXRhZGF0YSBvbg0KPj4+IHJlbG9jYXRhYmxlIGJ1aWxkcy4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEhvdSBXZW5sb25nIDxob3V3ZW5sb25nLmh3bEBhbnRn
cm91cC5jb20+DQo+Pj4gLS0tDQo+Pj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmly
dC5oICAgICAgIHwgNiArKystLS0NCj4+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2
aXJ0X3R5cGVzLmggfCA0ICsrLS0NCj4+PiAgIGFyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2
ZS5jICAgICAgICAgfCA4ICsrKysrLS0tDQo+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Bh
cmF2aXJ0LmgNCj4+PiBpbmRleCAyODUxYmMyMzM5ZDUuLjJjYmU5YjY0ZTEwMyAxMDA2NDQN
Cj4+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oDQo+Pj4gKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaA0KPj4+IEBAIC03MzUsMTMgKzczNSwx
MyBAQCBleHRlcm4gdm9pZCBkZWZhdWx0X2Jhbm5lcih2b2lkKTsNCj4+PiAgICNlbHNlICAv
KiBfX0FTU0VNQkxZX18gKi8NCj4+PiAtI2RlZmluZSBfUFZTSVRFKHB0eXBlLCBvcHMsIHdv
cmQsIGFsZ24pCQlcDQo+Pj4gKyNkZWZpbmUgX1BWU0lURShwdHlwZSwgb3BzLCBhbGduKQkJ
XA0KPj4NCj4+IFdvdWxkIHlvdSBwbGVhc2UgZHJvcCB0aGUgYWxnbiBwYXJhbWV0ZXIsIHRv
bz8gSXQgaXNuJ3QgbmVlZGVkIGFueW1vcmUNCj4+IGFzIHRoZSBhbGlnbm1lbnQgY2FuIGJl
IGhhcmQgY29kZWQgdG8gYmUgNCBub3cuIFRoaXMgd291bGQgbmVlZCB0byBiZQ0KPj4gYWRq
dXN0ZWQgaW4gdGhlIF9wYXJhdmlydF9hbHQoKSBtYWNybywgdG9vLg0KPj4NCj4gT0ssIHNp
bmNlIHRoZSBhbGlnbWVudCBpcyA0IGJ5dGVzIG5vdywgaXQgc2VlbXMgdGhhdCBfQVNNX0FM
SUdOIGNvdWxkDQo+IGJlIGRyb3BwZWQgdG9vPw0KDQpUaGF0J3Mgd2hhdCBJIG1lYW50IHdp
dGggdGhlIGFkanVzdG1lbnQgb2YgX3BhcmF2aXJ0X2FsdCgpLg0KDQpJIHdvdWxkbid0IGRy
b3AgX0FTTV9BTElHTiwgYnV0IHJlcGxhY2UgaXQgd2l0aCAiLmFsaWduIDQiLg0KDQoNCkp1
ZXJnZW4NCg==
--------------TzMz201WCXBlbxQNRPizG4tj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TzMz201WCXBlbxQNRPizG4tj--

--------------Y8GAedUP2EVEU6K8eugROtAr--

--------------Jpe3dMAeWai110dg6h3E9p8f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/UwUFAwAAAAAACgkQsN6d1ii/Ey/H
Xwf+OCezGeWEH0dnglpk9PeiXbiEf+l8LruyUsmHEV63B3aM0E5eASgJ5fCKyS8Y5u08CFQXLGyE
NJyo7fSesgQ+wtANVb5RH10zraHGIpPe9HCpWX//RlSm59Ft0FCApoH13T0Qt/+R/f+mbjg0mDYC
uWYmGN1+LVEy5xgnXaZ6bud9zXbKl/gafUDelbJ35EYF50FiQ2NXA6D2v7DgzOYYL2Fy3dwFMceK
+TX9f/D2PjtH0npKhnd8/+2pvB/r44FlAvk4PSZPG7yesy4o+D1qnlWYqyr1FkqDKtmXosa+unQ9
zSd3uc5AH9NCa4VBhZbO4+KLWvK1tO750vbwb2ob1w==
=wEXd
-----END PGP SIGNATURE-----

--------------Jpe3dMAeWai110dg6h3E9p8f--
