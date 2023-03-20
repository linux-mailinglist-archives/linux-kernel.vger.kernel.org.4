Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD136C13F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjCTNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjCTNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:49:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7397EE7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:49:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66EB61F85D;
        Mon, 20 Mar 2023 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679320188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0qbMNGoZ5ydUq4fb1CHHN6IQglPsi+jQ6Y2bqEKyPE=;
        b=hxU0dwZgF6+vnQhz8al3XfmVFS9Pb6XERj75dNw53QbyeUlq79iWfvEKzI2fc1MKY2X87B
        rhT95GJS/H//yDADficCd5PDU1tFl1GHyfgsDvNz1K2k56auBJGVOFvVjgHYOTbhwa7UDb
        ed8jWnlzjHPIjA/yj9I+SfBIsKNW/wM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BC0313416;
        Mon, 20 Mar 2023 13:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1XlmBHxkGGTwDAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Mar 2023 13:49:48 +0000
Message-ID: <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
Date:   Mon, 20 Mar 2023 14:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TNqLU0d7naCI9S0JRM6kp3UW"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TNqLU0d7naCI9S0JRM6kp3UW
Content-Type: multipart/mixed; boundary="------------XmqxIT0gKV0MBOt9K6SK5q6E";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Huang, Kai" <kai.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Message-ID: <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
In-Reply-To: <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>

--------------XmqxIT0gKV0MBOt9K6SK5q6E
Content-Type: multipart/mixed; boundary="------------OrMGJS9OCE8candCqN2q2kFT"

--------------OrMGJS9OCE8candCqN2q2kFT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDMuMjMgMTM6MjUsIEh1YW5nLCBLYWkgd3JvdGU6DQo+IE9uIE1vbiwgMjAyMy0w
My0wNiBhdCAxNzozNCArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IFRoZSBtdHJy
X3ZhbHVlW10gYXJyYXkgaXMgYSBzdGF0aWMgdmFyaWFibGUsIHdoaWNoIGlzIHVzZWQgb25s
eSBpbiBhDQo+PiBmZXcgY29uZmlndXJhdGlvbnMuIENvbnN1bWluZyA2a0IgaXMgcmlkaWN1
bG91cyBmb3IgdGhpcyBjYXNlLA0KPj4gZXNwZWNpYWxseSBhcyB0aGUgYXJyYXkgZG9lc24n
dCBuZWVkIHRvIGJlIHRoYXQgbGFyZ2UgYW5kIGl0IGNhbiBlYXNpbHkNCj4+IGJlIGFsbG9j
YXRlZCBkeW5hbWljYWxseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3Nz
IDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9t
dHJyL210cnIuYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL210cnIuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+
IGluZGV4IDBjODM5OTA1MDFmNS4uNTBjZDIyODdiNmUxIDEwMDY0NA0KPj4gLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL210cnIuYw0KPj4gQEAgLTU4MSw3ICs1ODEsNyBAQCBzdHJ1Y3QgbXRycl92
YWx1ZSB7DQo+PiAgIAl1bnNpZ25lZCBsb25nCWxzaXplOw0KPj4gICB9Ow0KPj4gICANCj4+
IC1zdGF0aWMgc3RydWN0IG10cnJfdmFsdWUgbXRycl92YWx1ZVtNVFJSX01BWF9WQVJfUkFO
R0VTXTsNCj4+ICtzdGF0aWMgc3RydWN0IG10cnJfdmFsdWUgKm10cnJfdmFsdWU7DQo+PiAg
IA0KPj4gICBzdGF0aWMgaW50IG10cnJfc2F2ZSh2b2lkKQ0KPj4gICB7DQo+PiBAQCAtNzUw
LDYgKzc1MCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG10cnJfaW5pdF9maW5pYWxpemUodm9p
ZCkNCj4+ICAgCSAqIFRCRDogaXMgdGhlcmUgYW55IHN5c3RlbSB3aXRoIHN1Y2ggQ1BVIHdo
aWNoIHN1cHBvcnRzDQo+PiAgIAkgKiBzdXNwZW5kL3Jlc3VtZT8gSWYgbm8sIHdlIHNob3Vs
ZCByZW1vdmUgdGhlIGNvZGUuDQo+PiAgIAkgKi8NCj4+ICsJbXRycl92YWx1ZSA9IGtjYWxs
b2MobnVtX3Zhcl9yYW5nZXMsIHNpemVvZigqbXRycl92YWx1ZSksIEdGUF9LRVJORUwpOw0K
PiANCj4gVGhlb3JldGljYWxseSBkeW5hbWljIGFsbG9jYXRpb24gY2FuIGZhaWwsIGFsdGhv
dWdoIGl0IHNob3VsZCBub3QgaGFwcGVuIGFzIHRoaXMNCj4gaGFwcGVucyBkdXJpbmcga2Vy
bmVsIGJvb3QgYW5kIHRoZSBzaXplIGlzIHNtYWxsLiAgTWF5YmUgYSBXQVJOKCk/DQoNCkZp
bmUgd2l0aCBtZS4NCg0KDQpKdWVyZ2VuDQo=
--------------OrMGJS9OCE8candCqN2q2kFT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------OrMGJS9OCE8candCqN2q2kFT--

--------------XmqxIT0gKV0MBOt9K6SK5q6E--

--------------TNqLU0d7naCI9S0JRM6kp3UW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQYZHsFAwAAAAAACgkQsN6d1ii/Ey+o
KQf/SI8CL1icdHpLK6sTYAuJot5Zfe6QCVWg+AYBtnvKlmEuVtqGNaPNEw+fZK9U+6YjAh20xsAg
Ib+wMCWtvpHLaWgG3o+J2nkjfgQc+OFMJcKmcB4DeUtJbYAZaBkQyWVcU/tUOtuKOZ2zCSlYE3az
Gl4b/zmcyPlJpU+0i/D2nzshpAxnsTbbs8w3fg2mt9HojV2Trz5Nq6FcjnwXozCsySBRw3udDo5Q
kgGGUhjwsEOy+Rlrn+16R6mfMqcSRTEKCW/GrdtCEqiKUTZyvW/j+PHGLJ9E+DHBCrZhC2c9RLO9
H1lQQ8Y3/pETsobYnbllQxXwFD2CKGDuqWXPGWb6fQ==
=jLYh
-----END PGP SIGNATURE-----

--------------TNqLU0d7naCI9S0JRM6kp3UW--
