Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499DF6EDE51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjDYIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjDYIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:40:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF9146E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:38:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD4A1FDB8;
        Tue, 25 Apr 2023 08:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682411562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fUJpT4eSXUFtWZDp+c4s0vMvQ9WDc0MkOerGh85A7E=;
        b=Vp1bhtUM98M738pN2ugm3fpijEc0bC46Wp1nFIFbzmbRabPVHkcKVY4xp+Ag/u62LPqpen
        3oNJageaY+9yTuThfmmQy1BhNsrZYefAGQu/8qjVitVsCxMmMkbtyYnfC2DnDk2t54ucO+
        +hdnTU5zjs9v0694uXDCgTrxR/HFuDs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBA3413466;
        Tue, 25 Apr 2023 08:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mm5ANCmQR2Q8YAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 25 Apr 2023 08:32:41 +0000
Message-ID: <b7e75a64-6de4-504e-809d-d6dce192f430@suse.com>
Date:   Tue, 25 Apr 2023 10:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306123259.12461-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1QajHh30CYvvJ3lSjQxcBpjB"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1QajHh30CYvvJ3lSjQxcBpjB
Content-Type: multipart/mixed; boundary="------------eFKwYi9FwUmx4uAls7bYvGCP";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b7e75a64-6de4-504e-809d-d6dce192f430@suse.com>
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
References: <20230306123259.12461-1-jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>

--------------eFKwYi9FwUmx4uAls7bYvGCP
Content-Type: multipart/mixed; boundary="------------98MHwYpyewZmBcD0lkvDOhb8"

--------------98MHwYpyewZmBcD0lkvDOhb8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZz8NCg0KT24gMDYuMDMuMjMgMTM6MzIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE5v
cm1hbGx5IF9fc3dwX2VudHJ5X3RvX3B0ZSgpIGlzIG5ldmVyIGNhbGxlZCB3aXRoIGEgdmFs
dWUgdHJhbnNsYXRpbmcNCj4gdG8gYSB2YWxpZCBQVEUuIFRoZSBvbmx5IGtub3duIGV4Y2Vw
dGlvbiBpcyBwdGVfc3dhcF90ZXN0cygpLCByZXN1bHRpbmcNCj4gaW4gYSBXQVJOIHNwbGF0
IGluIFhlbiBQViBndWVzdHMsIGFzIF9fcHRlX3RvX3N3cF9lbnRyeSgpIGRpZA0KPiB0cmFu
c2xhdGUgdGhlIFBGTiBvZiB0aGUgdmFsaWQgUFRFIHRvIGEgZ3Vlc3QgbG9jYWwgUEZOLCB3
aGlsZQ0KPiBfX3N3cF9lbnRyeV90b19wdGUoKSBkb2Vzbid0IGRvIHRoZSBvcHBvc2l0ZSB0
cmFuc2xhdGlvbi4NCj4gDQo+IEZpeCB0aGF0IGJ5IHVzaW5nIF9fcHRlKCkgaW4gX19zd3Bf
ZW50cnlfdG9fcHRlKCkgaW5zdGVhZCBvZiBvcGVuDQo+IGNvZGluZyB0aGUgbmF0aXZlIHZh
cmlhbnQgb2YgaXQuDQo+IA0KPiBGb3IgY29ycmVjdG5lc3MgZG8gdGhlIHNpbWlsYXIgY29u
dmVyc2lvbiBmb3IgX19zd3BfZW50cnlfdG9fcG1kKCkuDQo+IA0KPiBGaXhlczogMDUyODk0
MDJkNzE3ICgibW0vZGVidWdfdm1fcGd0YWJsZTogYWRkIHRlc3RzIHZhbGlkYXRpbmcgYXJj
aCBoZWxwZXJzIGZvciBjb3JlIE1NIGZlYXR1cmVzIikNCj4gU2lnbmVkLW9mZi1ieTogSnVl
cmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiAtLS0NCj4gICBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZ3RhYmxlXzY0LmggfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Bn
dGFibGVfNjQuaA0KPiBpbmRleCA3OTI5MzI3YWJlMDAuLmE2MjliMWI5ZjY1YSAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oDQo+ICsrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBAQCAtMjM3LDggKzIzNyw4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBuYXRpdmVfcGdkX2NsZWFyKHBnZF90ICpwZ2QpDQo+ICAg
DQo+ICAgI2RlZmluZSBfX3B0ZV90b19zd3BfZW50cnkocHRlKQkJKChzd3BfZW50cnlfdCkg
eyBwdGVfdmFsKChwdGUpKSB9KQ0KPiAgICNkZWZpbmUgX19wbWRfdG9fc3dwX2VudHJ5KHBt
ZCkJCSgoc3dwX2VudHJ5X3QpIHsgcG1kX3ZhbCgocG1kKSkgfSkNCj4gLSNkZWZpbmUgX19z
d3BfZW50cnlfdG9fcHRlKHgpCQkoKHB0ZV90KSB7IC5wdGUgPSAoeCkudmFsIH0pDQo+IC0j
ZGVmaW5lIF9fc3dwX2VudHJ5X3RvX3BtZCh4KQkJKChwbWRfdCkgeyAucG1kID0gKHgpLnZh
bCB9KQ0KPiArI2RlZmluZSBfX3N3cF9lbnRyeV90b19wdGUoeCkJCShfX3B0ZSgoeCkudmFs
KSkNCj4gKyNkZWZpbmUgX19zd3BfZW50cnlfdG9fcG1kKHgpCQkoX19wbWQoKHgpLnZhbCkp
DQo+ICAgDQo+ICAgZXh0ZXJuIHZvaWQgY2xlYW51cF9oaWdobWFwKHZvaWQpOw0KPiAgIA0K
DQo=
--------------98MHwYpyewZmBcD0lkvDOhb8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------98MHwYpyewZmBcD0lkvDOhb8--

--------------eFKwYi9FwUmx4uAls7bYvGCP--

--------------1QajHh30CYvvJ3lSjQxcBpjB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRHkCkFAwAAAAAACgkQsN6d1ii/Ey9f
pwgAnOs/z703nzQRJkeXlNfxt7zvtwNhZSOzl5Y+muj1S/s3X5ITdKJeyTjr/0Ssh0CrGyT2aBxj
e21U+QXxwepE4Am+yvQBd8w8CydA6ncGtEhrQ/7L0HkOn6hQYIekAPXolWl41Tm2AncWvNq6evv9
ZL6i8QIG6p6uLLQcoKroEV0wcvCXKveg6MnMQ0wZV02fU8vTftYpgQNx1QFGEJORfmnZO403l1Zr
mNJ4UPctrfirKEcb8fpFYG7uVi4XR6pxLpdXsBn4hSblGJfgWTwQWH0BdDOsB/a/e5HCeNEWSPlf
QqJgDZG1zL0PNzZkATaV8sWD9CrjndUXjd8WI1XBmw==
=GCgO
-----END PGP SIGNATURE-----

--------------1QajHh30CYvvJ3lSjQxcBpjB--
