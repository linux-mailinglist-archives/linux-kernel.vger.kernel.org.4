Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398EB6CA6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjC0N6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjC0N63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:58:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5976E40CB;
        Mon, 27 Mar 2023 06:58:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1384521DDF;
        Mon, 27 Mar 2023 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679925507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQSiCcEXSkpYT9fhztoHKNvKaF57XnxAqH14JZgYCzs=;
        b=tA2ZbM21zCgveBO0yUGH9kFopNQU3D87O37+Rqu4FTLjGdxSHJ7cNdMgnb4ESKyXGrTet6
        wwCeyGMYtA3nJvSNiVEkQWyPzKLc25ZWzOJrBcaCHfYfLtoJo9eMXUXv6bCDL8HdKxJ2GZ
        Pet0vtAtuzQfdIHJqKm6RkzXMQlg9pA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B94CE13482;
        Mon, 27 Mar 2023 13:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gPXfKwKhIWSoAgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Mar 2023 13:58:26 +0000
Message-ID: <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
Date:   Mon, 27 Mar 2023 15:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
References: <20230321141904.49177-1-roger.pau@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
In-Reply-To: <20230321141904.49177-1-roger.pau@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VW9ntCdcYgSOKUVi8GYJOibu"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VW9ntCdcYgSOKUVi8GYJOibu
Content-Type: multipart/mixed; boundary="------------YyIPNzdADYYt07Gjw8fVWR2D";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
 Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Message-ID: <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
References: <20230321141904.49177-1-roger.pau@citrix.com>
In-Reply-To: <20230321141904.49177-1-roger.pau@citrix.com>

--------------YyIPNzdADYYt07Gjw8fVWR2D
Content-Type: multipart/mixed; boundary="------------JTcERGkYVZmOtTjYqZLsK8LM"

--------------JTcERGkYVZmOtTjYqZLsK8LM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDMuMjMgMTU6MTksIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gSW4gQUNQSSBz
eXN0ZW1zLCB0aGUgT1MgY2FuIGRpcmVjdCBwb3dlciBtYW5hZ2VtZW50LCBhcyBvcHBvc2Vk
IHRvIHRoZQ0KPiBmaXJtd2FyZS4gIFRoaXMgT1MtZGlyZWN0ZWQgUG93ZXIgTWFuYWdlbWVu
dCBpcyBjYWxsZWQgT1NQTS4gIFBhcnQgb2YNCj4gdGVsbGluZyB0aGUgZmlybXdhcmUgdGhh
dCB0aGUgT1MgZ29pbmcgdG8gZGlyZWN0IHBvd2VyIG1hbmFnZW1lbnQgaXMNCj4gbWFraW5n
IEFDUEkgIl9QREMiIChQcm9jZXNzb3IgRHJpdmVyIENhcGFiaWxpdGllcykgY2FsbHMuICBU
aGVzZSBfUERDDQo+IG1ldGhvZHMgbXVzdCBiZSBldmFsdWF0ZWQgZm9yIGV2ZXJ5IHByb2Nl
c3NvciBvYmplY3QuICBJZiB0aGVzZSBfUERDDQo+IGNhbGxzIGFyZSBub3QgY29tcGxldGVk
IGZvciBldmVyeSBwcm9jZXNzb3IgaXQgY2FuIGxlYWQgdG8NCj4gaW5jb25zaXN0ZW5jeSBh
bmQgbGF0ZXIgZmFpbHVyZXMgaW4gdGhpbmdzIGxpa2UgdGhlIENQVSBmcmVxdWVuY3kNCj4g
ZHJpdmVyLg0KPiANCj4gSW4gYSBYZW4gc3lzdGVtLCB0aGUgZG9tMCBrZXJuZWwgaXMgcmVz
cG9uc2libGUgZm9yIHN5c3RlbS13aWRlIHBvd2VyDQo+IG1hbmFnZW1lbnQuICBUaGUgZG9t
MCBrZXJuZWwgaXMgaW4gY2hhcmdlIG9mIE9TUE0uICBIb3dldmVyLCB0aGUNCj4gbnVtYmVy
IG9mIENQVXMgYXZhaWxhYmxlIHRvIGRvbTAgY2FuIGJlIGRpZmZlcmVudCB0aGFuIHRoZSBu
dW1iZXIgb2YNCj4gQ1BVcyBwaHlzaWNhbGx5IHByZXNlbnQgb24gdGhlIHN5c3RlbS4NCj4g
DQo+IFRoaXMgbGVhZHMgdG8gYSBwcm9ibGVtOiB0aGUgZG9tMCBrZXJuZWwgbmVlZHMgdG8g
ZXZhbHVhdGUgX1BEQyBmb3INCj4gYWxsIHRoZSBwcm9jZXNzb3JzLCBidXQgaXQgY2FuJ3Qg
YWx3YXlzIHNlZSB0aGVtLg0KPiANCj4gSW4gZG9tMCBrZXJuZWxzLCBpZ25vcmUgdGhlIGV4
aXN0aW5nIEFDUEkgbWV0aG9kIGZvciBkZXRlcm1pbmluZyBpZiBhDQo+IHByb2Nlc3NvciBp
cyBwaHlzaWNhbGx5IHByZXNlbnQgYmVjYXVzZSBpdCBtaWdodCBub3QgYmUgYWNjdXJhdGUu
DQo+IEluc3RlYWQsIGFzayB0aGUgaHlwZXJ2aXNvciBmb3IgdGhpcyBpbmZvcm1hdGlvbi4N
Cj4gDQo+IEZpeCB0aGlzIGJ5IGludHJvZHVjaW5nIGEgY3VzdG9tIGZ1bmN0aW9uIHRvIHVz
ZSB3aGVuIHJ1bm5pbmcgYXMgWGVuDQo+IGRvbTAgaW4gb3JkZXIgdG8gY2hlY2sgd2hldGhl
ciBhIHByb2Nlc3NvciBvYmplY3QgbWF0Y2hlcyBhIENQVSB0aGF0J3MNCj4gb25saW5lLiAg
U3VjaCBjaGVja2luZyBpcyBkb25lIHVzaW5nIHRoZSBleGlzdGluZyBpbmZvcm1hdGlvbiBm
ZXRjaGVkDQo+IGJ5IHRoZSBYZW4gcENQVSBzdWJzeXN0ZW0sIGV4dGVuZGluZyBpdCB0byBh
bHNvIHN0b3JlIHRoZSBBQ1BJIElELg0KPiANCj4gVGhpcyBlbnN1cmVzIHRoYXQgX1BEQyBt
ZXRob2QgZ2V0cyBldmFsdWF0ZWQgZm9yIGFsbCBwaHlzaWNhbGx5IG9ubGluZQ0KPiBDUFVz
LCByZWdhcmRsZXNzIG9mIHRoZSBudW1iZXIgb2YgQ1BVcyBtYWRlIGF2YWlsYWJsZSB0byBk
b20wLg0KPiANCj4gRml4ZXM6IDVkNTU0YTdiYjA2NCAoJ0FDUEk6IHByb2Nlc3NvcjogYWRk
IGludGVybmFsIHByb2Nlc3Nvcl9waHlzaWNhbGx5X3ByZXNlbnQoKScpDQo+IFNpZ25lZC1v
ZmYtYnk6IFJvZ2VyIFBhdSBNb25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KPiAtLS0N
Cj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gICAtIE1vdmUgZGVmaW5pdGlvbi9kZWNsYXJhdGlv
biBvZiB4ZW5fcHJvY2Vzc29yX3ByZXNlbnQoKSB0byBkaWZmZXJlbnQNCj4gICAgIGhlYWRl
ci4NCj4gICAtIEZvbGQgc3ViamVjdCBlZGl0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MzoN
Cj4gICAtIFByb3RlY3QgeGVuX3Byb2Nlc3Nvcl9wcmVzZW50KCkgZGVmaW5pdGlvbiB3aXRo
IENPTkZJR19BQ1BJLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gICAtIEV4dGVuZCBh
bmQgdXNlIHRoZSBleGlzdGluZyBwY3B1IGZ1bmN0aW9uYWxpdHkuDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHYxOg0KPiAgIC0gUmV3b3JkIGNvbW1pdCBtZXNzYWdlLg0KPiAtLS0NCj4gICBk
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BkYy5jIHwgMTEgKysrKysrKysrKysNCj4gICBkcml2
ZXJzL3hlbi9wY3B1LmMgICAgICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4g
ICBpbmNsdWRlL3hlbi94ZW4uaCAgICAgICAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9wcm9jZXNzb3JfcGRjLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Bk
Yy5jDQo+IGluZGV4IDhjM2Y4MmM5ZmZmMy4uMThmYjA0NTIzZjkzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BkYy5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9w
cm9jZXNzb3JfcGRjLmMNCj4gQEAgLTE0LDYgKzE0LDggQEANCj4gICAjaW5jbHVkZSA8bGlu
dXgvYWNwaS5oPg0KPiAgICNpbmNsdWRlIDxhY3BpL3Byb2Nlc3Nvci5oPg0KPiAgIA0KPiAr
I2luY2x1ZGUgPHhlbi94ZW4uaD4NCj4gKw0KPiAgICNpbmNsdWRlICJpbnRlcm5hbC5oIg0K
PiAgIA0KPiAgIHN0YXRpYyBib29sIF9faW5pdCBwcm9jZXNzb3JfcGh5c2ljYWxseV9wcmVz
ZW50KGFjcGlfaGFuZGxlIGhhbmRsZSkNCj4gQEAgLTQ3LDYgKzQ5LDE1IEBAIHN0YXRpYyBi
b29sIF9faW5pdCBwcm9jZXNzb3JfcGh5c2ljYWxseV9wcmVzZW50KGFjcGlfaGFuZGxlIGhh
bmRsZSkNCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICAJfQ0KPiAgIA0KPiArCWlmICh4ZW5f
aW5pdGlhbF9kb21haW4oKSkNCj4gKwkJLyoNCj4gKwkJICogV2hlbiBydW5uaW5nIGFzIGEg
WGVuIGRvbTAgdGhlIG51bWJlciBvZiBwcm9jZXNzb3JzIExpbnV4DQo+ICsJCSAqIHNlZXMg
Y2FuIGJlIGRpZmZlcmVudCBmcm9tIHRoZSByZWFsIG51bWJlciBvZiBwcm9jZXNzb3JzIG9u
DQo+ICsJCSAqIHRoZSBzeXN0ZW0sIGFuZCB3ZSBzdGlsbCBuZWVkIHRvIGV4ZWN1dGUgX1BE
QyBmb3IgYWxsIG9mDQo+ICsJCSAqIHRoZW0uDQo+ICsJCSAqLw0KPiArCQlyZXR1cm4geGVu
X3Byb2Nlc3Nvcl9wcmVzZW50KGFjcGlfaWQpOw0KPiArDQo+ICAgCXR5cGUgPSAoYWNwaV90
eXBlID09IEFDUElfVFlQRV9ERVZJQ0UpID8gMSA6IDA7DQo+ICAgCWNwdWlkID0gYWNwaV9n
ZXRfY3B1aWQoaGFuZGxlLCB0eXBlLCBhY3BpX2lkKTsNCj4gICANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMveGVuL3BjcHUuYyBiL2RyaXZlcnMveGVuL3BjcHUuYw0KPiBpbmRleCBmZDNh
NjQ0YjA4NTUuLjE4MTRmODc2MmY1NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vcGNw
dS5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL3BjcHUuYw0KPiBAQCAtNTgsNiArNTgsNyBAQCBz
dHJ1Y3QgcGNwdSB7DQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCj4gICAJc3RydWN0
IGRldmljZSBkZXY7DQo+ICAgCXVpbnQzMl90IGNwdV9pZDsNCj4gKwl1aW50MzJfdCBhY3Bp
X2lkOw0KPiAgIAl1aW50MzJfdCBmbGFnczsNCj4gICB9Ow0KPiAgIA0KPiBAQCAtMjQ5LDYg
KzI1MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGNwdSAqY3JlYXRlX2FuZF9yZWdpc3Rlcl9wY3B1
KHN0cnVjdCB4ZW5wZl9wY3B1aW5mbyAqaW5mbykNCj4gICANCj4gICAJSU5JVF9MSVNUX0hF
QUQoJnBjcHUtPmxpc3QpOw0KPiAgIAlwY3B1LT5jcHVfaWQgPSBpbmZvLT54ZW5fY3B1aWQ7
DQo+ICsJcGNwdS0+YWNwaV9pZCA9IGluZm8tPmFjcGlfaWQ7DQo+ICAgCXBjcHUtPmZsYWdz
ID0gaW5mby0+ZmxhZ3M7DQo+ICAgDQo+ICAgCS8qIE5lZWQgaG9sZCBvbiB4ZW5fcGNwdV9s
b2NrIGJlZm9yZSBwY3B1IGxpc3QgbWFuaXB1bGF0aW9ucyAqLw0KPiBAQCAtMzgxLDMgKzM4
MywyMSBAQCBzdGF0aWMgaW50IF9faW5pdCB4ZW5fcGNwdV9pbml0KHZvaWQpDQo+ICAgCXJl
dHVybiByZXQ7DQo+ICAgfQ0KPiAgIGFyY2hfaW5pdGNhbGwoeGVuX3BjcHVfaW5pdCk7DQo+
ICsNCj4gKyNpZmRlZiBDT05GSUdfQUNQSQ0KPiArYm9vbCBfX2luaXQgeGVuX3Byb2Nlc3Nv
cl9wcmVzZW50KHVpbnQzMl90IGFjcGlfaWQpDQo+ICt7DQo+ICsJc3RydWN0IHBjcHUgKnBj
cHU7DQo+ICsJYm9vbCBvbmxpbmUgPSBmYWxzZTsNCj4gKw0KPiArCW11dGV4X2xvY2soJnhl
bl9wY3B1X2xvY2spOw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkocGNwdSwgJnhlbl9wY3B1
cywgbGlzdCkNCj4gKwkJaWYgKHBjcHUtPmFjcGlfaWQgPT0gYWNwaV9pZCkgew0KPiArCQkJ
b25saW5lID0gcGNwdS0+ZmxhZ3MgJiBYRU5fUENQVV9GTEFHU19PTkxJTkU7DQo+ICsJCQli
cmVhazsNCj4gKwkJfQ0KPiArCW11dGV4X3VubG9jaygmeGVuX3BjcHVfbG9jayk7DQo+ICsN
Cj4gKwlyZXR1cm4gb25saW5lOw0KPiArfQ0KPiArI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3hlbi94ZW4uaCBiL2luY2x1ZGUveGVuL3hlbi5oDQo+IGluZGV4IDdhZGY1OTgz
N2MyNS4uNDQxMGU3NGYzZWI1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3hlbi94ZW4uaA0K
PiArKysgYi9pbmNsdWRlL3hlbi94ZW4uaA0KPiBAQCAtNzEsNCArNzEsMTQgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHhlbl9mcmVlX3VucG9wdWxhdGVkX3BhZ2VzKHVuc2lnbmVkIGludCBu
cl9wYWdlcywNCj4gICB9DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsjaWYgZGVmaW5lZChDT05G
SUdfWEVOX0RPTTApICYmIGRlZmluZWQoQ09ORklHX0FDUEkpICYmIGRlZmluZWQoQ09ORklH
X1g4NikNCj4gK2Jvb2wgX19pbml0IHhlbl9wcm9jZXNzb3JfcHJlc2VudCh1aW50MzJfdCBh
Y3BpX2lkKTsNCj4gKyNlbHNlDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgeGVuX3Byb2Nlc3Nv
cl9wcmVzZW50KHVpbnQzMl90IGFjcGlfaWQpDQo+ICt7DQo+ICsJQlVHKCk7DQoNCklzIHRo
aXMgcmVhbGx5IGEgZ29vZCBpZGVhPw0KDQpBcm02NCBzdXBwb3J0cyBBQ1BJLCB0b28sIGFz
IHdlbGwgYXMgWEVOX0RPTTAuIEkgdGhpbmsgeW91IGVpdGhlciBuZWVkIHRvDQpwcm92aWRl
IGEgc3R1YiBmb3IgdGhhdCBjYXNlLCB0b28sIG9yIHlvdSBuZWVkIG1ha2UgdGhpcyBzdHVi
IG5vbi1mYXRhbA0KZm9yIGNhbGxlcnMgKEkgZ3Vlc3MgcmV0dXJuaW5nIGZhbHNlIGlzIGZp
bmUsIGFzIGN1cnJlbnRseSB0aGVyZSBhcmUgbm8NCmh5cGVyY2FsbHMgb24gQXJtIHdoaWNo
IHdvdWxkIGFsbG93IHRvIGNvbnRyb2wgcGh5c2ljYWwgQ1BVcyBiYXNlZCBvbg0KQUNQSS1J
ZCkuDQoNClN0ZWZhbm8sIGNhbiB5b3UgY29uZmlybSB0aGlzPw0KDQoNCkp1ZXJnZW4NCg==

--------------JTcERGkYVZmOtTjYqZLsK8LM
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JTcERGkYVZmOtTjYqZLsK8LM--

--------------YyIPNzdADYYt07Gjw8fVWR2D--

--------------VW9ntCdcYgSOKUVi8GYJOibu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQhoQIFAwAAAAAACgkQsN6d1ii/Ey9k
wAf+NNFcmhfd1rrcHx0K//8HQqwncoIKBJq1CwhZ9uxBQzs0LJIt5RaikRDi+ri+Z3BH6WXIAjLe
NaL9ZtXk2NQWonBB9AfcbSbTxZ8a+dHOW5Tn0NLwkDmPa+JXbILgG3YmLZYJ6Ahuquv0gJSu79wc
gcn6tqoSPAqAoH5zgfBELidBuyqY1PvEuZzVKrj9NitRgNzFaixmhS9fnfstGpjO5vCHmwpw06F+
EvD4/bmDJYRb8vQ9PEMgJCM1zjGnS1BCgPkn4NE46pt4ZTwkpl+YndeUOR45d2IMVXyC/E41OgI0
iSJcEkXe5tIhgU6yyjhmMFuIPk33FL/s2lucUu1LiA==
=ox1l
-----END PGP SIGNATURE-----

--------------VW9ntCdcYgSOKUVi8GYJOibu--
