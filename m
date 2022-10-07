Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA445F7390
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJGEbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJGEbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:31:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83746FF8D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 21:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C14AB21981;
        Fri,  7 Oct 2022 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665117095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xB06VBd/Y49QFqBxqn3w68xF0j6t4V/2NhwVr0WnPi0=;
        b=bf4o3RKEk2QDKSV6hT3HIUe4YvyPgk1SvvSL7QhiGcoKdkbsTyvquMVKOUEsNR6kO9zEOO
        6I6cv44zn6yL3I9pALX4VWfQiarsc1CPR0TEwQIYZs2gnRobLOjeCxD9bhHSRliullxkn/
        hFhXGJKIGsdm9QYQsJhmOwVeoTCa33A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 669F513A3D;
        Fri,  7 Oct 2022 04:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gpBlF6erP2MPHgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 04:31:35 +0000
Message-ID: <4d2af823-072c-8d08-8fa0-a223fd29b7d5@suse.com>
Date:   Fri, 7 Oct 2022 06:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] xen/virtio: enable grant based virtio on x86
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-4-jgross@suse.com>
 <2e721170-6035-90e3-f929-79b0a07e1891@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <2e721170-6035-90e3-f929-79b0a07e1891@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tJMgqarFki0k550caoVqfGBp"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tJMgqarFki0k550caoVqfGBp
Content-Type: multipart/mixed; boundary="------------ZJJs5059ahbNeRfNxBy3DHk0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <4d2af823-072c-8d08-8fa0-a223fd29b7d5@suse.com>
Subject: Re: [PATCH 3/3] xen/virtio: enable grant based virtio on x86
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-4-jgross@suse.com>
 <2e721170-6035-90e3-f929-79b0a07e1891@epam.com>
In-Reply-To: <2e721170-6035-90e3-f929-79b0a07e1891@epam.com>

--------------ZJJs5059ahbNeRfNxBy3DHk0
Content-Type: multipart/mixed; boundary="------------HOQMds0X0nGhH6PWd608iNXu"

--------------HOQMds0X0nGhH6PWd608iNXu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMTg6MDQsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
T24gMDYuMTAuMjIgMTA6MTUsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IA0KPiANCj4gSGVs
bG8gSnVlcmdlbg0KPiANCj4+IFVzZSBhbiB4ODYtc3BlY2lmaWMgdmlydGlvX2NoZWNrX21l
bV9hY2NfY2IoKSBmb3IgWGVuIGluIG9yZGVyIHRvIHNldHVwDQo+PiB0aGUgY29ycmVjdCBE
TUEgb3BzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0Bz
dXNlLmNvbT4NCj4+IC0tLQ0KPj4gICAgYXJjaC94ODYveGVuL2VubGlnaHRlbl9odm0uYyB8
ICAyICstDQo+PiAgICBhcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMgIHwgIDIgKy0NCj4+
ICAgIGRyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyAgfCAxMCArKysrKysrKysrDQo+PiAg
ICBpbmNsdWRlL3hlbi94ZW4tb3BzLmggICAgICAgIHwgIDEgKw0KPj4gICAgNCBmaWxlcyBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jIGIvYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9odm0uYw0KPj4gaW5kZXggMWMxYWM0MTg0ODRiLi5jMWNkMjhlOTE1YTMgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jDQo+PiArKysgYi9h
cmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jDQo+PiBAQCAtMjEyLDcgKzIxMiw3IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCB4ZW5faHZtX2d1ZXN0X2luaXQodm9pZCkNCj4+ICAgIAkJcmV0
dXJuOw0KPj4gICAgDQo+PiAgICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9f
Rk9SQ0VfR1JBTlQpKQ0KPj4gLQkJdmlydGlvX3NldF9tZW1fYWNjX2NiKHZpcnRpb19yZXF1
aXJlX3Jlc3RyaWN0ZWRfbWVtX2FjYyk7DQo+PiArCQl2aXJ0aW9fc2V0X21lbV9hY2NfY2Io
eGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2MpOw0KPj4gICAgDQo+PiAgICAJaW5pdF9o
dm1fcHZfaW5mbygpOw0KPj4gICAgDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9wdi5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+PiBpbmRleCA5
YjFhNThkZGE5MzUuLjQ1YjI0YzFiNjQ2YSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L3hl
bi9lbmxpZ2h0ZW5fcHYuYw0KPj4gKysrIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5j
DQo+PiBAQCAtMTEyLDcgKzExMiw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB4ZW5fcHZfaW5p
dF9wbGF0Zm9ybSh2b2lkKQ0KPj4gICAgew0KPj4gICAgCS8qIFBWIGd1ZXN0cyBjYW4ndCBv
cGVyYXRlIHZpcnRpbyBkZXZpY2VzIHdpdGhvdXQgZ3JhbnRzLiAqLw0KPj4gICAgCWlmIChJ
U19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPKSkNCj4+IC0JCXZpcnRpb19zZXRfbWVtX2Fj
Y19jYih2aXJ0aW9fcmVxdWlyZV9yZXN0cmljdGVkX21lbV9hY2MpOw0KPj4gKwkJdmlydGlv
X3NldF9tZW1fYWNjX2NiKHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4+ICAg
IA0KPj4gICAgCXBvcHVsYXRlX2V4dHJhX3B0ZShmaXhfdG9fdmlydChGSVhfUEFSQVZJUlRf
Qk9PVE1BUCkpOw0KPj4gICAgDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZ3JhbnQt
ZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBpbmRleCBhMDAx
MTIyMzU4NzcuLjYwYTdhY2MzMzRlZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL2dy
YW50LWRtYS1vcHMuYw0KPj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+
PiBAQCAtMzcyLDYgKzM3MiwxNiBAQCB2b2lkIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgIAlkZXZfZXJyKGRldiwgIkNhbm5vdCBzZXQgdXAg
WGVuIGdyYW50IERNQSBvcHMsIHJldGFpbiBwbGF0Zm9ybSBETUEgb3BzXG4iKTsNCj4+ICAg
IH0NCj4+ICAgIA0KPj4gK2Jvb2wgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2Moc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKmRldikNCj4+ICt7DQo+PiArCWJvb2wgcmV0ID0geGVuX3Zp
cnRpb19tZW1fYWNjKGRldik7DQo+IA0KPiANCj4gVGhlIGdyYW50IHVzYWdlIGlzIG1hbmRh
dG9yeSBmb3IgUFYgZ3Vlc3RzLCByaWdodD8NCj4gDQo+IFRoZW4geGVuX3ZpcnRpb19tZW1f
YWNjKCkgc2hvdWxkIGFsd2F5cyByZXR1cm4gdHJ1ZSBmb3IgUFYgZ3Vlc3RzIChJDQo+IG1l
YW4gZXZlbiBpZiBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCBpcyBub3Qgc2V0KS4N
Cg0KWWVzLg0KDQo+IA0KPiANCj4gDQo+PiArDQo+PiArCWlmIChyZXQpDQo+PiArCQl4ZW5f
Z3JhbnRfc2V0dXBfZG1hX29wcyhkZXYtPmRldi5wYXJlbnQpOw0KPj4gKw0KPj4gKwlyZXR1
cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICAgIE1PRFVMRV9ERVNDUklQVElPTigiWGVuIGdy
YW50IERNQS1tYXBwaW5nIGxheWVyIik7DQo+PiAgICBNT0RVTEVfQVVUSE9SKCJKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Iik7DQo+PiAgICBNT0RVTEVfTElDRU5TRSgiR1BM
Iik7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4veGVuLW9wcy5oIGIvaW5jbHVkZS94
ZW4veGVuLW9wcy5oDQo+PiBpbmRleCBkYWUwZjM1MGM2NzguLjNkZDVhYTkzNmYxZCAxMDA2
NDQNCj4+IC0tLSBhL2luY2x1ZGUveGVuL3hlbi1vcHMuaA0KPj4gKysrIGIvaW5jbHVkZS94
ZW4veGVuLW9wcy5oDQo+PiBAQCAtMjE5LDYgKzIxOSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCB4ZW5fcHJlZW1wdGlibGVfaGNhbGxfZW5kKHZvaWQpIHsgfQ0KPj4gICAgdm9pZCB4ZW5f
Z3JhbnRfc2V0dXBfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPj4gICAgYm9vbCB4
ZW5faXNfZ3JhbnRfZG1hX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPj4gICAgYm9v
bCB4ZW5fdmlydGlvX21lbV9hY2Moc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7DQo+PiAr
Ym9vbCB4ZW5fdmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2FjYyhzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqZGV2KTsNCj4+ICAgICNlbHNlDQo+PiAgICBzdGF0aWMgaW5saW5lIHZvaWQgeGVuX2dy
YW50X3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gICAgew0KPiANCj4g
DQo+IEFuZCBwcm9iYWJseSBzdGF0aWMgaW5saW5lIHN0dWIgYWx3YXlzIHJldHVybmluZyBm
YWxzZSBpZg0KPiBDT05GSUdfWEVOX0dSQU5UX0RNQV9PUFMgaXMgbm90IHNldC4NCg0KSW5k
ZWVkLg0KDQoNCkp1ZXJnZW4NCg0K
--------------HOQMds0X0nGhH6PWd608iNXu
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------HOQMds0X0nGhH6PWd608iNXu--

--------------ZJJs5059ahbNeRfNxBy3DHk0--

--------------tJMgqarFki0k550caoVqfGBp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM/q6cFAwAAAAAACgkQsN6d1ii/Ey+Y
nAf/SoXch7HC7ctLGm9005qho84hIsztfnUGRi1rm3oGKBgZ7tPI3nFMkojucbcbYBiBSRxOVuvI
I5YpcwnEJ8w9vC/dS+qBpZ849dQGsJ9TqQVaAFIP+46isbT680vdOQm9vUDjV/47SMyX0vOkpY43
Mp+hpfkZBilmsjNZ+aDUPkjTgCKggY/u6cC47OLfFL4YoYhKuoiIEJwdruCdTsN6F9jODOsqc5hr
sn6AwtVJb/SIFUYW1NtdQkB2YSvQ1B8VcRp/RsvxStDB1bgaDLYpmM+tv1/N4VROSjBL/PLqFy/t
0dB4fSM2dS+j4OvH6Wo+tCqpwQJemFwByUN7ixDqDQ==
=guuC
-----END PGP SIGNATURE-----

--------------tJMgqarFki0k550caoVqfGBp--
