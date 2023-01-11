Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3092665B45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjAKMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbjAKL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:58:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B11DF84
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:52:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03CF433F62;
        Wed, 11 Jan 2023 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673437962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyKHJt0XyxdV3o0O95R9Xt3mVE89AKAlNhUG5sx1lSI=;
        b=IesUeC39TOXWXOyj238ggBhQpJdmOsKpAp2TOP+zAbTtM+MsLBJRSLcXMFT7VKnKSMEAj8
        0l7+DKd7cuqx57jrgsS87Ku0gbOduZwnXRMoWfYvOj1DWtgmxjnNu4WrKHfJFQRfcvOsi1
        QTIImDS68XNQceys32OGAATkLwBfaBo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C02DA1358A;
        Wed, 11 Jan 2023 11:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xEJLQmjvmNgNQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 11 Jan 2023 11:52:41 +0000
Message-ID: <baa1b55b-8415-0c33-a6e5-f568c48f455f@suse.com>
Date:   Wed, 11 Jan 2023 12:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Peter Zijlstra <peterz@infradead.org>,
        Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
In-Reply-To: <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------KeWc7dJhUG5zoM6TPru5imBx"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------KeWc7dJhUG5zoM6TPru5imBx
Content-Type: multipart/mixed; boundary="------------70GzbESFEEqiEFS5CFaBQvzN";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Joan Bruguera <joanbrugueram@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <baa1b55b-8415-0c33-a6e5-f568c48f455f@suse.com>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>

--------------70GzbESFEEqiEFS5CFaBQvzN
Content-Type: multipart/mixed; boundary="------------XFV50QPnkpJCqO0GakvcZe6r"

--------------XFV50QPnkpJCqO0GakvcZe6r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDEuMjMgMTI6MjAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEph
biAwOSwgMjAyMyBhdCAwNDowNTozMUFNICswMDAwLCBKb2FuIEJydWd1ZXJhIHdyb3RlOg0K
Pj4gVGhpcyBmaXhlcyB3YWtldXAgZm9yIG1lIG9uIGJvdGggUUVNVSBhbmQgcmVhbCBIVw0K
Pj4gKGp1c3QgYSBwcm9vZiBvZiBjb25jZXB0LCBkb24ndCBtZXJnZSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYyBiL2FyY2gveDg2L2tlcm5l
bC9jYWxsdGh1bmtzLmMNCj4+IGluZGV4IGZmZWE5OGY5MDY0Yi4uODcwNGJjYzBjZTMyIDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYw0KPj4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYw0KPj4gQEAgLTcsNiArNyw3IEBADQo+PiAg
ICNpbmNsdWRlIDxsaW51eC9tZW1vcnkuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZWxvYWRlci5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvc3RhdGljX2NhbGwuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvc3VzcGVuZC5oPg0KPj4gICANCj4+ICAgI2luY2x1ZGUgPGFzbS9h
bHRlcm5hdGl2ZS5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2FzbS1vZmZzZXRzLmg+DQo+PiBA
QCAtMTUwLDYgKzE1MSwxMCBAQCBzdGF0aWMgYm9vbCBza2lwX2FkZHIodm9pZCAqZGVzdCkN
Cj4+ICAgCWlmIChkZXN0ID49ICh2b2lkICopaHlwZXJjYWxsX3BhZ2UgJiYNCj4+ICAgCSAg
ICBkZXN0IDwgKHZvaWQqKWh5cGVyY2FsbF9wYWdlICsgUEFHRV9TSVpFKQ0KPj4gICAJCXJl
dHVybiB0cnVlOw0KPj4gKyNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4+
ICsJaWYgKGRlc3QgPT0gcmVzdG9yZV9wcm9jZXNzb3Jfc3RhdGUpDQo+PiArCQlyZXR1cm4g
dHJ1ZTsNCj4+ICAgI2VuZGlmDQo+PiAgIAlyZXR1cm4gZmFsc2U7DQo+PiAgIH0NCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9wb3dlci9jcHUuYyBiL2FyY2gveDg2L3Bvd2VyL2NwdS5j
DQo+PiBpbmRleCAyMzY0NDdlZTliZWIuLmU2Njc4OTQ5MzZmNyAxMDA2NDQNCj4+IC0tLSBh
L2FyY2gveDg2L3Bvd2VyL2NwdS5jDQo+PiArKysgYi9hcmNoL3g4Ni9wb3dlci9jcHUuYw0K
Pj4gQEAgLTI4MSw2ICsyODEsOSBAQCBzdGF0aWMgdm9pZCBub3RyYWNlIF9fcmVzdG9yZV9w
cm9jZXNzb3Jfc3RhdGUoc3RydWN0IHNhdmVkX2NvbnRleHQgKmN0eHQpDQo+PiAgIC8qIE5l
ZWRlZCBieSBhcG0uYyAqLw0KPj4gICB2b2lkIG5vdHJhY2UgcmVzdG9yZV9wcm9jZXNzb3Jf
c3RhdGUodm9pZCkNCj4+ICAgew0KPj4gKwkvKiBSZXN0b3JlIEdTIGJlZm9yZSBjYWxsaW5n
IGFueXRoaW5nIHRvIGF2b2lkIGNyYXNoIG9uIGNhbGwgZGVwdGggYWNjb3VudGluZyAqLw0K
Pj4gKwluYXRpdmVfd3Jtc3JsKE1TUl9HU19CQVNFLCBzYXZlZF9jb250ZXh0Lmtlcm5lbG1v
ZGVfZ3NfYmFzZSk7DQo+PiArDQo+PiAgIAlfX3Jlc3RvcmVfcHJvY2Vzc29yX3N0YXRlKCZz
YXZlZF9jb250ZXh0KTsNCj4+ICAgfQ0KPiANCj4gWWVhaCwgSSBjYW4gc2VlIHdoeSwgYnV0
IEknbSBub3QgcmVhbGx5IGNvbWZvcnRhYmxlIHdpdGggdGhpcy4gVEJILCBJDQo+IGRvbid0
IHNlZSBob3cgdGhlIHdob2xlIHJlc3VtZSBjb2RlIGlzIGNvcnJlY3QgdG8gYmVnaW4gd2l0
aC4gQXQgdGhlDQo+IHZlcnkgbGVhc3QgaXQgbmVlZHMgYSBoZWF2eSBkb3NlIG9mIG5vaW5z
dHIuDQo+IA0KPiBSYWZhZWwsIHdoYXQgY3IzIGlzIGFjdGl2ZSB3aGVuIHdlIGNhbGwgcmVz
dG9yZV9wcm9jZXNzb3Jfc3RhdGUoKT8NCj4gDQo+IFNwZWNpZmljYWxseSwgdGhlIHByb2Js
ZW0gaXMgdGhhdCBJIGRvbid0IGZlZWwgY29tZm9ydGFibGUgZG9pbmcgYW55DQo+IHNvcnQg
b2Ygd2VpcmQgY29kZSB1bnRpbCBhbGwgdGhlIENSIGFuZCBzZWdtZW50IHJlZ2lzdGVycyBo
YXZlIGJlZW4NCj4gcmVzdG9yZWQsIGhvd2V2ZXIsIHdyaXRlX2NyKigpIGFyZSBwYXJhdmly
dCBmdW5jdGlvbnMgdGhhdCByZXN1bHQgaW4NCj4gQ0FMTCwgd2hpY2ggdGhlbiBnaXZlcyB1
cyBhIGJpdCBvZiBhIGNoZWNrZW4gYW5kIGVnZyBwcm9ibGVtLg0KDQpVbmRlciBYZW4gdGhl
IGh5cGVydmlzb3Igc2hvdWxkIGRvIGFsbCBuZWVkZWQgbG93IGxldmVsIHN0dWZmIHdoZW4N
CnJlc3VtaW5nLiBFdmVuIGRvbTAgaXMganVzdCBhIGd1ZXN0LCBzbyBJIGRvbid0IHNlZSBh
IHByb2JsZW0gd2l0aA0KUFYgZ3Vlc3RzLiBDUiBhbmQgc2VnbWVudCByZWdpc3RlcnMgc2hv
dWxkIGJlIGluIHRoZSB2Y3B1IHN0cnVjdHVyZShzKQ0KaW4gWGVuIGFuZCB0aGV5IHNob3Vs
ZCBiZSByZXN0b3JlZCBieSBYZW4gd2hlbiBhY3RpdmF0aW5nIHRoZSB2Y3B1cw0KYWZ0ZXIg
c3VzcGVuZC4gVGhlcmUgc2hvdWxkbid0IGJlIGFueSBuZWVkIHRvIGRvIHRoaXMgYWdhaW4g
aW4gdGhlDQprZXJuZWwuDQoNCkkgaGF2ZSB2ZXJpZmllZCB0aGF0IHRoZSBzdXNwZW5kIHBh
dGggd2hlbiBydW5uaW5nIGFzIFhlbiBQViBndWVzdA0KaXMgTk9UIGNhbGxpbmcgcmVzdG9y
ZV9wcm9jZXNzb3Jfc3RhdGUoKS4NCg0KPiBJJ20gYWxzbyB3b25kZXJpbmcgaG93IHdlbGwg
cmV0YmxlZWQ9c3R1ZmYgd29ya3Mgb24gWGVuLCBpZiBhdCBhbGwuIElmDQo+IHdlIGNhbiBp
Z25vcmUgWGVuLCB0aGluZ3MgYXJlIGEgbGl0dGxlIGVhcmllciBwZXJoYXBzLg0KDQpJbiBy
ZXN0b3JlX3Byb2Nlc3Nvcl9zdGF0ZSgpIHlvdSBzaG91bGQgYmUgYWJsZSB0byBpZ25vcmUg
WGVuLCB1bmxlc3MNCnRoZXJlIGFyZSBvdGhlciBjb2RlIHBhdGhzIGNhbGxpbmcgaXQgKGtl
eGVjIGNhbiBiZSBpZ25vcmVkLCB0b28sIGFzDQp0aGF0IGlzbid0IHN1cHBvcnRlZCBpbiBY
ZW4gUFYsIGFuZCBzdXNwZW5kIHRvIGRpc2sgc2hvdWxkbid0IHdvcmsNCmVpdGhlcikuDQoN
Cg0KSnVlcmdlbg0K
--------------XFV50QPnkpJCqO0GakvcZe6r
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------XFV50QPnkpJCqO0GakvcZe6r--

--------------70GzbESFEEqiEFS5CFaBQvzN--

--------------KeWc7dJhUG5zoM6TPru5imBx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO+owkFAwAAAAAACgkQsN6d1ii/Ey/H
dAf9FZbHXpb6BucOOmRagpzN+QSaZvDu0v7a7wwZ3eUl+fIdSzr5C4xYUVRx7GyrwLarwr5YOTpt
BfcRwDVQWs+bB1/OvrbSrS/tcsuYJrr+W6FfBB7CMHBX3eWidzTUyIt4Bkg316QQim5mAL1zcBq6
7/1PZDN+h9RKaeQLBtS9hJVhCTr/CGfShDdeWtqDyVkRkWkmIx6a0OyE5oobxRUBdGo6aAzFjLrV
ToTpbVxOCA4rU+oCwzIDm9vz4TivtXXL41RbcoNQ3cdGFqzK2MGLzS+ObCzFMt1lkHyLR2lZtgdo
IbhiZJ3sZi7mz6EzuM9oJxv9dIMlwA/hdDbFdsP5Lg==
=HCIl
-----END PGP SIGNATURE-----

--------------KeWc7dJhUG5zoM6TPru5imBx--
