Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DE6CA9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjC0P47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0P45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:56:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FC30F5;
        Mon, 27 Mar 2023 08:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC3111FE21;
        Mon, 27 Mar 2023 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679932613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uK5PiHKOP+JB2i+NhlEd3BFq8oEXePzqoGGlsAL2PvA=;
        b=Z9hZfWol5PtY3tt7qnofWE0xsNHCYqSu52+xRrvuizxpPESqdqzSr6ugHmw61Hv+4XY230
        zzUAolWjTAyEQk2J6aPF8fmCgDT9oKkUW19MjjDURL423ffax3ZPbreislUhQv+SvpHMOE
        QrDVYsR9y/E3t7Lq0ZRPfIonsN2wKrE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84F2513329;
        Mon, 27 Mar 2023 15:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UdfaHcW8IWRQRwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Mar 2023 15:56:53 +0000
Message-ID: <4d1bad2e-d5cb-2596-6c74-2f5a3a087a91@suse.com>
Date:   Mon, 27 Mar 2023 17:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
References: <20230321141904.49177-1-roger.pau@citrix.com>
 <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
 <ZCG686t8tPDNPFbX@Air-de-Roger>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ZCG686t8tPDNPFbX@Air-de-Roger>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hShQEHSO0RyU3NIgXMN7ktOr"
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
--------------hShQEHSO0RyU3NIgXMN7ktOr
Content-Type: multipart/mixed; boundary="------------VZL0QXJysSjcJgzrpiodEUI5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, Stefano Stabellini
 <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
 Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Message-ID: <4d1bad2e-d5cb-2596-6c74-2f5a3a087a91@suse.com>
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
References: <20230321141904.49177-1-roger.pau@citrix.com>
 <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
 <ZCG686t8tPDNPFbX@Air-de-Roger>
In-Reply-To: <ZCG686t8tPDNPFbX@Air-de-Roger>

--------------VZL0QXJysSjcJgzrpiodEUI5
Content-Type: multipart/mixed; boundary="------------1FQl0KddX4seM7BoEiUPiRoY"

--------------1FQl0KddX4seM7BoEiUPiRoY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDMuMjMgMTc6NDksIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIE1vbiwg
TWFyIDI3LCAyMDIzIGF0IDAzOjU4OjI2UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+PiBPbiAyMS4wMy4yMyAxNToxOSwgUm9nZXIgUGF1IE1vbm5lIHdyb3RlOg0KPj4+IElu
IEFDUEkgc3lzdGVtcywgdGhlIE9TIGNhbiBkaXJlY3QgcG93ZXIgbWFuYWdlbWVudCwgYXMg
b3Bwb3NlZCB0byB0aGUNCj4+PiBmaXJtd2FyZS4gIFRoaXMgT1MtZGlyZWN0ZWQgUG93ZXIg
TWFuYWdlbWVudCBpcyBjYWxsZWQgT1NQTS4gIFBhcnQgb2YNCj4+PiB0ZWxsaW5nIHRoZSBm
aXJtd2FyZSB0aGF0IHRoZSBPUyBnb2luZyB0byBkaXJlY3QgcG93ZXIgbWFuYWdlbWVudCBp
cw0KPj4+IG1ha2luZyBBQ1BJICJfUERDIiAoUHJvY2Vzc29yIERyaXZlciBDYXBhYmlsaXRp
ZXMpIGNhbGxzLiAgVGhlc2UgX1BEQw0KPj4+IG1ldGhvZHMgbXVzdCBiZSBldmFsdWF0ZWQg
Zm9yIGV2ZXJ5IHByb2Nlc3NvciBvYmplY3QuICBJZiB0aGVzZSBfUERDDQo+Pj4gY2FsbHMg
YXJlIG5vdCBjb21wbGV0ZWQgZm9yIGV2ZXJ5IHByb2Nlc3NvciBpdCBjYW4gbGVhZCB0bw0K
Pj4+IGluY29uc2lzdGVuY3kgYW5kIGxhdGVyIGZhaWx1cmVzIGluIHRoaW5ncyBsaWtlIHRo
ZSBDUFUgZnJlcXVlbmN5DQo+Pj4gZHJpdmVyLg0KPj4+DQo+Pj4gSW4gYSBYZW4gc3lzdGVt
LCB0aGUgZG9tMCBrZXJuZWwgaXMgcmVzcG9uc2libGUgZm9yIHN5c3RlbS13aWRlIHBvd2Vy
DQo+Pj4gbWFuYWdlbWVudC4gIFRoZSBkb20wIGtlcm5lbCBpcyBpbiBjaGFyZ2Ugb2YgT1NQ
TS4gIEhvd2V2ZXIsIHRoZQ0KPj4+IG51bWJlciBvZiBDUFVzIGF2YWlsYWJsZSB0byBkb20w
IGNhbiBiZSBkaWZmZXJlbnQgdGhhbiB0aGUgbnVtYmVyIG9mDQo+Pj4gQ1BVcyBwaHlzaWNh
bGx5IHByZXNlbnQgb24gdGhlIHN5c3RlbS4NCj4+Pg0KPj4+IFRoaXMgbGVhZHMgdG8gYSBw
cm9ibGVtOiB0aGUgZG9tMCBrZXJuZWwgbmVlZHMgdG8gZXZhbHVhdGUgX1BEQyBmb3INCj4+
PiBhbGwgdGhlIHByb2Nlc3NvcnMsIGJ1dCBpdCBjYW4ndCBhbHdheXMgc2VlIHRoZW0uDQo+
Pj4NCj4+PiBJbiBkb20wIGtlcm5lbHMsIGlnbm9yZSB0aGUgZXhpc3RpbmcgQUNQSSBtZXRo
b2QgZm9yIGRldGVybWluaW5nIGlmIGENCj4+PiBwcm9jZXNzb3IgaXMgcGh5c2ljYWxseSBw
cmVzZW50IGJlY2F1c2UgaXQgbWlnaHQgbm90IGJlIGFjY3VyYXRlLg0KPj4+IEluc3RlYWQs
IGFzayB0aGUgaHlwZXJ2aXNvciBmb3IgdGhpcyBpbmZvcm1hdGlvbi4NCj4+Pg0KPj4+IEZp
eCB0aGlzIGJ5IGludHJvZHVjaW5nIGEgY3VzdG9tIGZ1bmN0aW9uIHRvIHVzZSB3aGVuIHJ1
bm5pbmcgYXMgWGVuDQo+Pj4gZG9tMCBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyIGEgcHJv
Y2Vzc29yIG9iamVjdCBtYXRjaGVzIGEgQ1BVIHRoYXQncw0KPj4+IG9ubGluZS4gIFN1Y2gg
Y2hlY2tpbmcgaXMgZG9uZSB1c2luZyB0aGUgZXhpc3RpbmcgaW5mb3JtYXRpb24gZmV0Y2hl
ZA0KPj4+IGJ5IHRoZSBYZW4gcENQVSBzdWJzeXN0ZW0sIGV4dGVuZGluZyBpdCB0byBhbHNv
IHN0b3JlIHRoZSBBQ1BJIElELg0KPj4+DQo+Pj4gVGhpcyBlbnN1cmVzIHRoYXQgX1BEQyBt
ZXRob2QgZ2V0cyBldmFsdWF0ZWQgZm9yIGFsbCBwaHlzaWNhbGx5IG9ubGluZQ0KPj4+IENQ
VXMsIHJlZ2FyZGxlc3Mgb2YgdGhlIG51bWJlciBvZiBDUFVzIG1hZGUgYXZhaWxhYmxlIHRv
IGRvbTAuDQo+Pj4NCj4+PiBGaXhlczogNWQ1NTRhN2JiMDY0ICgnQUNQSTogcHJvY2Vzc29y
OiBhZGQgaW50ZXJuYWwgcHJvY2Vzc29yX3BoeXNpY2FsbHlfcHJlc2VudCgpJykNCj4+PiBT
aWduZWQtb2ZmLWJ5OiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4N
Cj4+PiAtLS0NCj4+PiBDaGFuZ2VzIHNpbmNlIHY0Og0KPj4+ICAgIC0gTW92ZSBkZWZpbml0
aW9uL2RlY2xhcmF0aW9uIG9mIHhlbl9wcm9jZXNzb3JfcHJlc2VudCgpIHRvIGRpZmZlcmVu
dA0KPj4+ICAgICAgaGVhZGVyLg0KPj4+ICAgIC0gRm9sZCBzdWJqZWN0IGVkaXQuDQo+Pj4N
Cj4+PiBDaGFuZ2VzIHNpbmNlIHYzOg0KPj4+ICAgIC0gUHJvdGVjdCB4ZW5fcHJvY2Vzc29y
X3ByZXNlbnQoKSBkZWZpbml0aW9uIHdpdGggQ09ORklHX0FDUEkuDQo+Pj4NCj4+PiBDaGFu
Z2VzIHNpbmNlIHYyOg0KPj4+ICAgIC0gRXh0ZW5kIGFuZCB1c2UgdGhlIGV4aXN0aW5nIHBj
cHUgZnVuY3Rpb25hbGl0eS4NCj4+Pg0KPj4+IENoYW5nZXMgc2luY2UgdjE6DQo+Pj4gICAg
LSBSZXdvcmQgY29tbWl0IG1lc3NhZ2UuDQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvcl9wZGMuYyB8IDExICsrKysrKysrKysrDQo+Pj4gICAgZHJpdmVycy94ZW4v
cGNwdS5jICAgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+Pj4gICAgaW5j
bHVkZS94ZW4veGVuLmggICAgICAgICAgICB8IDEwICsrKysrKysrKysNCj4+PiAgICAzIGZp
bGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BkYy5jIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9w
ZGMuYw0KPj4+IGluZGV4IDhjM2Y4MmM5ZmZmMy4uMThmYjA0NTIzZjkzIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfcGRjLmMNCj4+PiArKysgYi9kcml2ZXJz
L2FjcGkvcHJvY2Vzc29yX3BkYy5jDQo+Pj4gQEAgLTE0LDYgKzE0LDggQEANCj4+PiAgICAj
aW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPj4+ICAgICNpbmNsdWRlIDxhY3BpL3Byb2Nlc3Nv
ci5oPg0KPj4+ICsjaW5jbHVkZSA8eGVuL3hlbi5oPg0KPj4+ICsNCj4+PiAgICAjaW5jbHVk
ZSAiaW50ZXJuYWwuaCINCj4+PiAgICBzdGF0aWMgYm9vbCBfX2luaXQgcHJvY2Vzc29yX3Bo
eXNpY2FsbHlfcHJlc2VudChhY3BpX2hhbmRsZSBoYW5kbGUpDQo+Pj4gQEAgLTQ3LDYgKzQ5
LDE1IEBAIHN0YXRpYyBib29sIF9faW5pdCBwcm9jZXNzb3JfcGh5c2ljYWxseV9wcmVzZW50
KGFjcGlfaGFuZGxlIGhhbmRsZSkNCj4+PiAgICAJCXJldHVybiBmYWxzZTsNCj4+PiAgICAJ
fQ0KPj4+ICsJaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpKQ0KPj4+ICsJCS8qDQo+Pj4gKwkJ
ICogV2hlbiBydW5uaW5nIGFzIGEgWGVuIGRvbTAgdGhlIG51bWJlciBvZiBwcm9jZXNzb3Jz
IExpbnV4DQo+Pj4gKwkJICogc2VlcyBjYW4gYmUgZGlmZmVyZW50IGZyb20gdGhlIHJlYWwg
bnVtYmVyIG9mIHByb2Nlc3NvcnMgb24NCj4+PiArCQkgKiB0aGUgc3lzdGVtLCBhbmQgd2Ug
c3RpbGwgbmVlZCB0byBleGVjdXRlIF9QREMgZm9yIGFsbCBvZg0KPj4+ICsJCSAqIHRoZW0u
DQo+Pj4gKwkJICovDQo+Pj4gKwkJcmV0dXJuIHhlbl9wcm9jZXNzb3JfcHJlc2VudChhY3Bp
X2lkKTsNCj4+PiArDQo+Pj4gICAgCXR5cGUgPSAoYWNwaV90eXBlID09IEFDUElfVFlQRV9E
RVZJQ0UpID8gMSA6IDA7DQo+Pj4gICAgCWNwdWlkID0gYWNwaV9nZXRfY3B1aWQoaGFuZGxl
LCB0eXBlLCBhY3BpX2lkKTsNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vcGNwdS5j
IGIvZHJpdmVycy94ZW4vcGNwdS5jDQo+Pj4gaW5kZXggZmQzYTY0NGIwODU1Li4xODE0Zjg3
NjJmNTQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy94ZW4vcGNwdS5jDQo+Pj4gKysrIGIv
ZHJpdmVycy94ZW4vcGNwdS5jDQo+Pj4gQEAgLTU4LDYgKzU4LDcgQEAgc3RydWN0IHBjcHUg
ew0KPj4+ICAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQo+Pj4gICAgCXN0cnVjdCBkZXZp
Y2UgZGV2Ow0KPj4+ICAgIAl1aW50MzJfdCBjcHVfaWQ7DQo+Pj4gKwl1aW50MzJfdCBhY3Bp
X2lkOw0KPj4+ICAgIAl1aW50MzJfdCBmbGFnczsNCj4+PiAgICB9Ow0KPj4+IEBAIC0yNDks
NiArMjUwLDcgQEAgc3RhdGljIHN0cnVjdCBwY3B1ICpjcmVhdGVfYW5kX3JlZ2lzdGVyX3Bj
cHUoc3RydWN0IHhlbnBmX3BjcHVpbmZvICppbmZvKQ0KPj4+ICAgIAlJTklUX0xJU1RfSEVB
RCgmcGNwdS0+bGlzdCk7DQo+Pj4gICAgCXBjcHUtPmNwdV9pZCA9IGluZm8tPnhlbl9jcHVp
ZDsNCj4+PiArCXBjcHUtPmFjcGlfaWQgPSBpbmZvLT5hY3BpX2lkOw0KPj4+ICAgIAlwY3B1
LT5mbGFncyA9IGluZm8tPmZsYWdzOw0KPj4+ICAgIAkvKiBOZWVkIGhvbGQgb24geGVuX3Bj
cHVfbG9jayBiZWZvcmUgcGNwdSBsaXN0IG1hbmlwdWxhdGlvbnMgKi8NCj4+PiBAQCAtMzgx
LDMgKzM4MywyMSBAQCBzdGF0aWMgaW50IF9faW5pdCB4ZW5fcGNwdV9pbml0KHZvaWQpDQo+
Pj4gICAgCXJldHVybiByZXQ7DQo+Pj4gICAgfQ0KPj4+ICAgIGFyY2hfaW5pdGNhbGwoeGVu
X3BjcHVfaW5pdCk7DQo+Pj4gKw0KPj4+ICsjaWZkZWYgQ09ORklHX0FDUEkNCj4+PiArYm9v
bCBfX2luaXQgeGVuX3Byb2Nlc3Nvcl9wcmVzZW50KHVpbnQzMl90IGFjcGlfaWQpDQo+Pj4g
K3sNCj4+PiArCXN0cnVjdCBwY3B1ICpwY3B1Ow0KPj4+ICsJYm9vbCBvbmxpbmUgPSBmYWxz
ZTsNCj4+PiArDQo+Pj4gKwltdXRleF9sb2NrKCZ4ZW5fcGNwdV9sb2NrKTsNCj4+PiArCWxp
c3RfZm9yX2VhY2hfZW50cnkocGNwdSwgJnhlbl9wY3B1cywgbGlzdCkNCj4+PiArCQlpZiAo
cGNwdS0+YWNwaV9pZCA9PSBhY3BpX2lkKSB7DQo+Pj4gKwkJCW9ubGluZSA9IHBjcHUtPmZs
YWdzICYgWEVOX1BDUFVfRkxBR1NfT05MSU5FOw0KPj4+ICsJCQlicmVhazsNCj4+PiArCQl9
DQo+Pj4gKwltdXRleF91bmxvY2soJnhlbl9wY3B1X2xvY2spOw0KPj4+ICsNCj4+PiArCXJl
dHVybiBvbmxpbmU7DQo+Pj4gK30NCj4+PiArI2VuZGlmDQo+Pj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUveGVuL3hlbi5oIGIvaW5jbHVkZS94ZW4veGVuLmgNCj4+PiBpbmRleCA3YWRmNTk4
MzdjMjUuLjQ0MTBlNzRmM2ViNSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3hlbi94ZW4u
aA0KPj4+ICsrKyBiL2luY2x1ZGUveGVuL3hlbi5oDQo+Pj4gQEAgLTcxLDQgKzcxLDE0IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fZnJlZV91bnBvcHVsYXRlZF9wYWdlcyh1bnNpZ25l
ZCBpbnQgbnJfcGFnZXMsDQo+Pj4gICAgfQ0KPj4+ICAgICNlbmRpZg0KPj4+ICsjaWYgZGVm
aW5lZChDT05GSUdfWEVOX0RPTTApICYmIGRlZmluZWQoQ09ORklHX0FDUEkpICYmIGRlZmlu
ZWQoQ09ORklHX1g4NikNCj4+PiArYm9vbCBfX2luaXQgeGVuX3Byb2Nlc3Nvcl9wcmVzZW50
KHVpbnQzMl90IGFjcGlfaWQpOw0KPj4+ICsjZWxzZQ0KPj4+ICtzdGF0aWMgaW5saW5lIGJv
b2wgeGVuX3Byb2Nlc3Nvcl9wcmVzZW50KHVpbnQzMl90IGFjcGlfaWQpDQo+Pj4gK3sNCj4+
PiArCUJVRygpOw0KPj4NCj4+IElzIHRoaXMgcmVhbGx5IGEgZ29vZCBpZGVhPw0KPj4NCj4+
IEFybTY0IHN1cHBvcnRzIEFDUEksIHRvbywgYXMgd2VsbCBhcyBYRU5fRE9NMC4gSSB0aGlu
ayB5b3UgZWl0aGVyIG5lZWQgdG8NCj4+IHByb3ZpZGUgYSBzdHViIGZvciB0aGF0IGNhc2Us
IHRvbywgb3IgeW91IG5lZWQgbWFrZSB0aGlzIHN0dWIgbm9uLWZhdGFsDQo+PiBmb3IgY2Fs
bGVycyAoSSBndWVzcyByZXR1cm5pbmcgZmFsc2UgaXMgZmluZSwgYXMgY3VycmVudGx5IHRo
ZXJlIGFyZSBubw0KPj4gaHlwZXJjYWxscyBvbiBBcm0gd2hpY2ggd291bGQgYWxsb3cgdG8g
Y29udHJvbCBwaHlzaWNhbCBDUFVzIGJhc2VkIG9uDQo+PiBBQ1BJLUlkKS4NCj4gDQo+IEN1
cnJlbnRseSBDT05GSUdfQVJDSF9NSUdIVF9IQVZFX0FDUElfUERDIGlzIG9ubHkgc2VsZWN0
ZWQgZm9yIHg4NiBhbmQNCj4gaWE2NCwgc28gSSBhc3N1bWVkIGlmIHdlIGV2ZXIgbmVlZGVk
IHRoaXMgZm9yIEFybSBzb21lb25lIHdvdWxkIGhhdmUNCj4gdG8gd3JpdGUgYSBwcm9wZXIg
aGFuZGxlciBmb3IgaXQgZm9yIFhlbi4NCg0KQWgsIG9rYXksIEkgZGlkbid0IGNoZWNrIHRo
YXQuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UsDQoNCg0KSnVlcmdlbg0KDQo=
--------------1FQl0KddX4seM7BoEiUPiRoY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1FQl0KddX4seM7BoEiUPiRoY--

--------------VZL0QXJysSjcJgzrpiodEUI5--

--------------hShQEHSO0RyU3NIgXMN7ktOr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQhvMUFAwAAAAAACgkQsN6d1ii/Ey9/
wAgAlV9K/d9ZKhpLRJ7huTNMrd12UmRpOc78b/okIjH6m4xOVoQ6V08gkkFshKXh865U24TTAs24
/qZnPM3RhSGd7boG3mMxDsBoRU+j8nb8i/Asm3Nv3Rao132wULu1Utn5y+kGq4vW5dfex7jpyd8p
vDLwfX33h5CA6DWAG0GTOPAIUs0sq+FvfkNOMCCIAkxlLujGsFUl2PpFqWni2tWTY9h/WUWxXuTi
/dqkC29FNUlidTbawx+8wgiZZ+dMdrVYdyYR/qdfPBSoDhT1VZnMF0FdozvVNdnQEJRjtwWXWKfK
zNoPMtKH4ZJy0+4OKoSAhDwu/sN6IGAVH+n4aGs+sA==
=yh66
-----END PGP SIGNATURE-----

--------------hShQEHSO0RyU3NIgXMN7ktOr--
