Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA626B369F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCJGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCJGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:24:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC9104918
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 22:24:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1DDF226DD;
        Fri, 10 Mar 2023 06:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678429457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8lP7jcBLyhGrqPSMQBaFsjfgY/agrJPqmTdzxjBeXQ=;
        b=LRNsgfkuw/saxlLp4u9LAOmvi10CRVreMXMRlLsO7Hj1GJgcFZ2OTloSzkgqhY/m/clG6+
        SIbYUsyRYwYC++Bmd7TcTFwSel3fZVh5FFpFUIh7cawwThybh7W7lTuVzm1DmX5kh31nn/
        Kg5lBQ5TLtE5cFsNskoUJ46kbTB61Io=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C4A134F7;
        Fri, 10 Mar 2023 06:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U0gYJBHNCmTtYQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 10 Mar 2023 06:24:17 +0000
Message-ID: <e7e42a4b-cf0d-d6ad-2f66-0f52898e818a@suse.com>
Date:   Fri, 10 Mar 2023 07:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230308154210.18454-1-jgross@suse.com>
 <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eox0B9bkaZ5uewweFWmZOYIf"
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
--------------eox0B9bkaZ5uewweFWmZOYIf
Content-Type: multipart/mixed; boundary="------------YOgKkC0T2GEL2c5kViSv0S72";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e7e42a4b-cf0d-d6ad-2f66-0f52898e818a@suse.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
References: <20230308154210.18454-1-jgross@suse.com>
 <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
In-Reply-To: <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>

--------------YOgKkC0T2GEL2c5kViSv0S72
Content-Type: multipart/mixed; boundary="------------SxhORv7i7BctHoocd7IS7xzV"

--------------SxhORv7i7BctHoocd7IS7xzV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDMuMjMgMTQ6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMDgsIDIwMjMgYXQgMDQ6NDI6MTBQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEFsbCBmdW5jdGlvbnMgcmVmZXJlbmNlZCB2aWEgX19QVl9JU19DQUxMRUVfU0FWRSgp
IG5lZWQgdG8gYmUgYXNzZW1ibGVyDQo+PiBmdW5jdGlvbnMsIGFzIHRob3NlIGZ1bmN0aW9u
cyBjYWxscyBhcmUgaGlkZGVuIGZyb20gZ2NjLiBJbiBjYXNlIHRoZQ0KPj4ga2VybmVsIGlz
IGNvbXBpbGVkIHdpdGggIi1memVyby1jYWxsLXVzZWQtcmVncyIgdGhlIGNvbXBpbGVyIHdp
bGwNCj4+IGNsb2JiZXIgY2FsbGVyLXNhdmVkIHJlZ2lzdGVycyBhdCB0aGUgZW5kIG9mIEMg
ZnVuY3Rpb25zLCB3aGljaCB3aWxsDQo+PiByZXN1bHQgaW4gdW5leHBlY3RlZGx5IHplcm9l
ZCByZWdpc3RlcnMgYXQgdGhlIGNhbGwgc2l0ZSBvZiB0aGUNCj4+IHJlbGF0ZWQgcGFyYXZp
cnQgZnVuY3Rpb25zLg0KPj4NCj4+IFJlcGxhY2UgdGhlIEMgZnVuY3Rpb25zIHdpdGggREVG
SU5FX1BBUkFWSVJUX0FTTSgpIGNvbnN0cnVjdHMgdXNpbmcNCj4+IHRoZSBzYW1lIGluc3Ry
dWN0aW9ucyBhcyB0aGUgcmVsYXRlZCBwYXJhdmlydCBjYWxscyBpbiB0aGUNCj4+IFBWT1Bf
QUxUX1tWXUNBTExFRSooKSBtYWNyb3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3BhcmF2aXJ0X3R5cGVzLmggfCAgOCArKysrKysrLQ0KPj4gICBhcmNoL3g4Ni9r
ZXJuZWwvcGFyYXZpcnQuYyAgICAgICAgICAgIHwgMjcgKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMjIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBSaWdodCwgd29ya3Mgd2l0aCBteSBwYXJ0aWN1bGFyIHJlcHJv
ZHVjZXIuDQo+IA0KPiBUdXJuaW5nIHRoZW0gaW50byBhc20gcHJldmVudHMgdGhlIGNvbXBp
bGVyIGZyb20gZG9pbmcgdGhlDQo+IGNhbGxlZS1jbG9iYmVyZWQgemVyb2luZyBhbmQgdGhh
dCdzIGZpbmUgYXMgdGhpcyB3aG9sZSBwYXJhdmlydCBndW5rIGlzDQo+IGhpZGluZyB0aGUg
IkNBTEwiIGluc24gZnJvbSBpdCBhbmQgeW91IHB1dHRpbmcgdGhlbSBpbiBhc20gaXMgaW4g
bGluZQ0KPiB3aXRoIHRoaXMuDQo+IA0KPiBBbmQgYSBuZWdhdGl2ZSBkaWZmc3RhdC4uDQo+
IA0KPiBTbyB5ZWFoLCBJJ2xsIHF1ZXVlIGl0IHNvb24gdW5sZXNzIHNvbWVvbmUgb2JqZWN0
cy4NCg0KVGhhbmtzLg0KDQo+IExvbmcgdGVybSwgSSB0aGluayB3ZSBzaG91bGQgY29udGlu
dWUgc3dpdGNoaW5nIGFsbCB0aGF0IHB2IHN0dWZmIHRvDQo+IHVzaW5nIHRoZSBhbHRlcm5h
dGl2ZXMuDQoNClRoZSAibm9ybWFsIiBjYXNlcyBub3QgdXNpbmcgYWx0ZXJuYXRpdmVzIHNo
b3VsZCByYXRoZXIgYmUgc3dpdGNoZWQgdG8NCnN0YXRpYyBjYWxscy4NCg0KV2hldGhlciBp
dCBpcyBwb3NzaWJsZSB0byBtaXggYSBzdGF0aWMgY2FsbCB3aXRoIGFsdGVybmF0aXZlcyBu
ZWVkcyB0bw0KYmUgZXZhbHVhdGVkLg0KDQoNCkp1ZXJnZW4NCg==
--------------SxhORv7i7BctHoocd7IS7xzV
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------SxhORv7i7BctHoocd7IS7xzV--

--------------YOgKkC0T2GEL2c5kViSv0S72--

--------------eox0B9bkaZ5uewweFWmZOYIf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQKzREFAwAAAAAACgkQsN6d1ii/Ey9c
oAf6AidXjdl0B66qlmKTk97OI7cgYdGLZa7k2/7ET/mEkG3qhO5Rprmm3wESegWlka1vIAX23WpI
DrlUeHP/0RBN+7OnRxfXSVNG+nuKRsE8GhzEeZ6mABXULPgT3sylCuo+891uDNsu0ep1OzlCWptq
LQjkXAj89/EXk8yrK8aVeXXglrUz0wUu2/LnIRuUzHBNBq2W8GuLhBDSsp+d7ZjS3Jk+ObaD9SIK
SA38+wdKBj9037hH/wkgRBwVn/2tDlWJsHuuPRgOJeyt1chBUfk7sOf5GuUsN7cyYjgkCkjCT0zw
xwNPSu7vBpcJDcINtO/cDibXPH5tiQMXZ1CHgiMiKw==
=9yr7
-----END PGP SIGNATURE-----

--------------eox0B9bkaZ5uewweFWmZOYIf--
