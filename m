Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4F647FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLIJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLIJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:04:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8B617C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:04:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FDCB337FE;
        Fri,  9 Dec 2022 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670576682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5M6mhTepNvubs5KJ1uAQrBpbdhbshLRIxZcGGcsTcJ8=;
        b=ievXP7EpI7qrCK+lCfxRTOfku1L9i2F+zFGN2oPRyWilCUqsxXUPjvHxqOpTd47ezuVakd
        7z40ASZX0xku7993fLDOFIRG2liIS1yTDKT2RZL7zLgZQhxSEjws1FKI0x4T+pbgYrQAyK
        +JklqRI7H/RqEgwa43SegNifbZZa2oI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B6413597;
        Fri,  9 Dec 2022 09:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /oNXEir6kmOjVwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Dec 2022 09:04:42 +0000
Message-ID: <15fff7b8-b030-edf9-5bff-073b9757cb2e@suse.com>
Date:   Fri, 9 Dec 2022 10:04:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20221202182254.784808-1-per.bilse@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
In-Reply-To: <20221202182254.784808-1-per.bilse@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o44iGprAE1ybSGGRvvu4Vakp"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o44iGprAE1ybSGGRvvu4Vakp
Content-Type: multipart/mixed; boundary="------------cyNnjJjpEBcsCCUfgkKqZZYu";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <15fff7b8-b030-edf9-5bff-073b9757cb2e@suse.com>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
References: <20221202182254.784808-1-per.bilse@citrix.com>
In-Reply-To: <20221202182254.784808-1-per.bilse@citrix.com>

--------------cyNnjJjpEBcsCCUfgkKqZZYu
Content-Type: multipart/mixed; boundary="------------2lg8QN7YDxMdGMHKvRG5DUba"

--------------2lg8QN7YDxMdGMHKvRG5DUba
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjIgMTk6MjIsIFBlciBCaWxzZSB3cm90ZToNCj4gL3Byb2MveGVuIGlzIGEg
bGVnYWN5IHBzZXVkbyBmaWxlc3lzdGVtIHdoaWNoIHByZWRhdGVzIFhlbiBzdXBwb3J0DQo+
IGdldHRpbmcgbWVyZ2VkIGludG8gTGludXguICBJdCBoYXMgbGFyZ2VseSBiZWVuIHJlcGxh
Y2VkIHdpdGggbW9yZQ0KPiBub3JtYWwgbG9jYXRpb25zIGZvciBkYXRhICgvc3lzL2h5cGVy
dmlzb3IvIGZvciBpbmZvLCAvZGV2L3hlbi8gZm9yDQo+IHVzZXIgZGV2aWNlcykuICBXZSB3
YW50IHRvIGNvbXBpbGUgeGVuZnMgc3VwcG9ydCBvdXQgb2YgdGhlIGRvbTAga2VybmVsLg0K
PiANCj4gVGhlcmUgaXMgb25lIGl0ZW0gd2hpY2ggb25seSBleGlzdHMgaW4gL3Byb2MveGVu
LCBuYW1lbHkNCj4gL3Byb2MveGVuL2NhcGFiaWxpdGllcyB3aXRoICJjb250cm9sX2QiIGJl
aW5nIHRoZSBzaWduYWwgb2YgInlvdSdyZSBpbg0KPiB0aGUgY29udHJvbCBkb21haW4iLiAg
VGhpcyB1bHRpbWF0ZWx5IGNvbWVzIGZyb20gdGhlIFNJRiBmbGFncyBwcm92aWRlZA0KPiBh
dCBWTSBzdGFydC4NCj4gDQo+IFRoaXMgcGF0Y2ggZXhwb3NlcyBhbGwgU0lGIGZsYWdzIGlu
IC9zeXMvaHlwZXJ2aXNvci9zdGFydF9mbGFncy8gYXMNCj4gYm9vbGVhbiBmaWxlcywgb25l
IGZvciBlYWNoIGJpdCwgcmV0dXJuaW5nICcxJyBpZiBzZXQsICcwJyBvdGhlcndpc2UuDQo+
IFR3byBrbm93biBmbGFncywgJ3ByaXZpbGVnZWQnIGFuZCAnaW5pdGRvbWFpbicsIGFyZSBl
eHBsaWNpdGx5IG5hbWVkLA0KPiBhbmQgYWxsIHJlbWFpbmluZyBmbGFncyBjYW4gYmUgYWNj
ZXNzZWQgdmlhIGdlbmVyaWNhbGx5IG5hbWVkIGZpbGVzLA0KPiBhcyBzdWdnZXN0ZWQgYnkg
QW5kcmV3IENvb3Blci4NCj4gDQo+IFRoaXMgcGF0Y2ggcmVwbGFjZXMgcHJldmlvdXMgc3Vn
Z2VzdGlvbiBmb3IgU0lGIGZsYWdzIGV4cG9zdXJlIGluIGl0cw0KPiBlbnRpcmV0eS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBlciBCaWxzZSA8cGVyLmJpbHNlQGNpdHJpeC5jb20+DQo+
IC0tLQ0KPiAgIERvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1oeXBlcnZpc29yLXhl
biB8ICA4ICsrKw0KPiAgIGRyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29yLmMgICAgICAgICAg
ICAgICAgICB8IDcwICsrKysrKysrKysrKysrKysrLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDc0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWh5cGVydmlzb3IteGVuIGIvRG9jdW1l
bnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWh5cGVydmlzb3IteGVuDQo+IGluZGV4IDc0ODU5
M2M2NDU2OC4uZjUyZjk4NTQ4MTg0IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FC
SS9zdGFibGUvc3lzZnMtaHlwZXJ2aXNvci14ZW4NCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9B
Qkkvc3RhYmxlL3N5c2ZzLWh5cGVydmlzb3IteGVuDQo+IEBAIC0xMjAsMyArMTIwLDExIEBA
IENvbnRhY3Q6CXhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KPiAgIERlc2NyaXB0
aW9uOglJZiBydW5uaW5nIHVuZGVyIFhlbjoNCj4gICAJCVRoZSBYZW4gdmVyc2lvbiBpcyBp
biB0aGUgZm9ybWF0IDxtYWpvcj4uPG1pbm9yPjxleHRyYT4NCj4gICAJCVRoaXMgaXMgdGhl
IDxtaW5vcj4gcGFydCBvZiBpdC4NCj4gKw0KPiArV2hhdDoJCS9zeXMvaHlwZXJ2aXNvci9z
dGFydF9mbGFncy8qDQo+ICtEYXRlOgkJRGVjZW1iZXIgMjAyMg0KPiArS2VybmVsVmVyc2lv
bjoJNi4xLjANCj4gK0NvbnRhY3Q6CXhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0K
PiArRGVzY3JpcHRpb246CUlmIHJ1bm5pbmcgdW5kZXIgWGVuOg0KPiArCQlBbGwgYml0cyBp
biBYZW4ncyBzdGFydC1mbGFncyBhcmUgcmVwcmVzZW50ZWQgYXMNCj4gKwkJYm9vbGVhbiBm
aWxlcywgcmV0dXJuaW5nICcxJyBpZiBzZXQsICcwJyBvdGhlcndpc2UuDQoNCkkgdGhpbmsg
YXQgbGVhc3QgdGhlIGZpbGVzIHdoaWNoIHdhbnQgdG8gYmUgdXNlZCBieSBlLmcuIHN5c3Rl
bWQNCigiaW5pdGRvbWFpbiIgYXMgcmVwbGFjZW1lbnQgZm9yIHRoZSAiY29udHJvbF9kIiBz
dHJpbmcgaW4gY2FwYWJpbGl0aWVzLA0KYnV0IEkgdGhpbmsgInByaXZpbGVnZWQiIGFzIHdl
bGwpIHNob3VsZCBiZSBleHBsaWNpdGx5IGFkZGVkIHRvIHRoaXMNCmRlc2NyaXB0aW9uLCBh
cyB0aG9zZSBhcmUgbWVhbnQgdG8gYmUgdXNlZCBhcyBhIHN0YWJsZSBBQkkuDQoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29yLmMgYi9kcml2ZXJzL3hlbi9z
eXMtaHlwZXJ2aXNvci5jDQo+IGluZGV4IGZjYjA3OTJmMDkwZS4uZTE1ZDNmZjJjNTZmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi9zeXMtaHlwZXJ2aXNvci5jDQo+ICsrKyBiL2Ry
aXZlcnMveGVuL3N5cy1oeXBlcnZpc29yLmMNCj4gQEAgLTMxLDcgKzMxLDEwIEBAIHN0cnVj
dCBoeXBfc3lzZnNfYXR0ciB7DQo+ICAgCXN0cnVjdCBhdHRyaWJ1dGUgYXR0cjsNCj4gICAJ
c3NpemVfdCAoKnNob3cpKHN0cnVjdCBoeXBfc3lzZnNfYXR0ciAqLCBjaGFyICopOw0KPiAg
IAlzc2l6ZV90ICgqc3RvcmUpKHN0cnVjdCBoeXBfc3lzZnNfYXR0ciAqLCBjb25zdCBjaGFy
ICosIHNpemVfdCk7DQo+IC0Jdm9pZCAqaHlwX2F0dHJfZGF0YTsNCj4gKwl1bmlvbiB7DQo+
ICsJCXZvaWQgKmh5cF9hdHRyX2RhdGE7DQo+ICsJCXVuc2lnbmVkIGxvbmcgaHlwX2F0dHJf
dmFsdWU7DQo+ICsJfTsNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBzc2l6ZV90IHR5cGVf
c2hvdyhzdHJ1Y3QgaHlwX3N5c2ZzX2F0dHIgKmF0dHIsIGNoYXIgKmJ1ZmZlcikNCj4gQEAg
LTM5OSw2ICs0MDIsNjEgQEAgc3RhdGljIGludCBfX2luaXQgeGVuX3N5c2ZzX3Byb3BlcnRp
ZXNfaW5pdCh2b2lkKQ0KPiAgIAlyZXR1cm4gc3lzZnNfY3JlYXRlX2dyb3VwKGh5cGVydmlz
b3Jfa29iaiwgJnhlbl9wcm9wZXJ0aWVzX2dyb3VwKTsNCj4gICB9DQo+ICAgDQo+ICsjZGVm
aW5lIEZMQUdfVU5BTUUgInVua25vd24iDQo+ICsjZGVmaW5lIEZMQUdfVU5BTUVfRk1UIEZM
QUdfVU5BTUUgIiUwMnUiDQo+ICsjZGVmaW5lIEZMQUdfVU5BTUVfTUFYIHNpemVvZihGTEFH
X1VOQU1FICJYWCIpDQo+ICsjZGVmaW5lIEZMQUdfQ09VTlQgKHNpemVvZih4ZW5fc3RhcnRf
ZmxhZ3MpICogQklUU19QRVJfQllURSkNCj4gK3N0YXRpY19hc3NlcnQoc2l6ZW9mKHhlbl9z
dGFydF9mbGFncykNCj4gKwkJPD0gc2l6ZW9mX2ZpZWxkKHN0cnVjdCBoeXBfc3lzZnNfYXR0
ciwgaHlwX2F0dHJfdmFsdWUpKTsNCj4gKw0KPiArc3RhdGljIHNzaXplX3QgZmxhZ19zaG93
KHN0cnVjdCBoeXBfc3lzZnNfYXR0ciAqYXR0ciwgY2hhciAqYnVmZmVyKQ0KPiArew0KPiAr
CWNoYXIgKnAgPSBidWZmZXI7DQo+ICsNCj4gKwkqcCsrID0gJzAnICsgKCh4ZW5fc3RhcnRf
ZmxhZ3MgJiBhdHRyLT5oeXBfYXR0cl92YWx1ZSkgIT0gMCk7DQo+ICsJKnArKyA9ICdcbic7
DQo+ICsJcmV0dXJuIHAgLSBidWZmZXI7DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsqIEFkZCBu
ZXcsIGtub3duIGZsYWdzIGhlcmUuICBObyBvdGhlciBjaGFuZ2VzIGFyZSByZXF1aXJlZCwg
YnV0DQo+ICsqIG5vdGUgdGhhdCBlYWNoIGtub3duIGZsYWcgd2FzdGVzIG9uZSBlbnRyeSBp
biBmbGFnX3VuYW1lc1tdLg0KPiArKiBUaGUgY29kZS9jb21wbGV4aXR5IG1hY2hpbmF0aW9u
cyB0byBhdm9pZCB0aGlzIGlzbid0IHdvcnRoIGl0DQo+ICsqIGZvciBhIGZldyBlbnRyaWVz
LCBidXQga2VlcCBpdCBpbiBtaW5kLg0KPiArKi8NCj4gK3N0YXRpYyBzdHJ1Y3QgaHlwX3N5
c2ZzX2F0dHIgZmxhZ19hdHRyc1tGTEFHX0NPVU5UXSA9IHsNCj4gKwlbaWxvZzIoU0lGX1BS
SVZJTEVHRUQpXSA9IHsNCj4gKwkJLmF0dHIgPSB7IC5uYW1lID0gInByaXZpbGVnZWQiLCAu
bW9kZSA9IDA0NDQgfSwNCj4gKwkJLnNob3cgPSBmbGFnX3Nob3csDQo+ICsJCS5oeXBfYXR0
cl92YWx1ZSA9IFNJRl9QUklWSUxFR0VEDQo+ICsJfSwNCg0KV2hhdCBhYm91dDoNCg0KI2Rl
ZmluZSBGTEFHX05PREUoYml0LCBub2RlKQkJCQkJXA0KCVtpbG9nMihiaXQpXSA9IHsJCQkJ
CVwNCgkJLmF0dHIgPSB7IC5uYW1lID0gI25vZGUsIC5tb2RlID0gMDQ0NCB9LAlcDQoJCS5z
aG93ID0gZmxhZ19zaG93LAkJCQlcDQoJCS5oeXBfYXR0cl92YWx1ZSA9IGJpdAkJCQlcDQoJ
fQ0KDQpGTEFHX05PREUoU0lGX1BSSVZJTEVHRUQsIHByaXZpbGVnZWQpLA0KRkxBR19OT0RF
KFNJRl9JTklURE9NQUlOLCBpbml0ZG9tYWluKQ0KDQo+ICsJW2lsb2cyKFNJRl9JTklURE9N
QUlOKV0gPSB7DQo+ICsJCS5hdHRyID0geyAubmFtZSA9ICJpbml0ZG9tYWluIiwgLm1vZGUg
PSAwNDQ0IH0sDQo+ICsJCS5zaG93ID0gZmxhZ19zaG93LA0KPiArCQkuaHlwX2F0dHJfdmFs
dWUgPSBTSUZfSU5JVERPTUFJTg0KPiArCX0NCg0KSW4gb3JkZXIgdG8gYXZvaWQgYSBjb25z
dW1lciBoYXZpbmcgdG8gbG9vayBpbnRvIHRoZSBzb3VyY2VzIGZvciBhbnkgb3RoZXINCnNl
dCBmbGFnLCBtYXliZSBhZGQgbmFtZXMgZm9yIGN1cnJlbnRseSBkZWZpbmVkIGZsYWdzLCB0
b28/IE9yIGp1c3Qgc2tpcA0KdGhlIG90aGVyIGZsYWdzIGFuZCBhZGQgYSBzaW5nbGUgYWRk
aXRpb25hbCBub2RlICgiZmxhZ3MiPykgd2l0aCB0aGUgd2hvbGUNCnZhbHVlIG9mIHhlbl9z
dGFydF9mbGFncyBlaXRoZXIgaW4gaGV4IG9yIGJpbmFyeSBmb3JtPw0KDQpQbGVhc2Ugbm90
ZSB0aGF0IHRoaXMgaXMgYSBzdWdnZXN0aW9uIG9ubHksIEknbSBub3QgaW5zaXN0aW5nIG9u
IGl0Lg0KDQoNCkp1ZXJnZW4NCg==
--------------2lg8QN7YDxMdGMHKvRG5DUba
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------2lg8QN7YDxMdGMHKvRG5DUba--

--------------cyNnjJjpEBcsCCUfgkKqZZYu--

--------------o44iGprAE1ybSGGRvvu4Vakp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOS+ikFAwAAAAAACgkQsN6d1ii/Ey+9
uwf/ZMHk+gTwWo8CMrkZCDPhihfWSTtRb024SS/rcW0OuMKWcwAizCliHXa2zZSpwyO84ZVFSAVZ
uEzEWo9nGimrOKKpNHYsZKtpmbxF20a8WD7uFFnIiqFXyaWOMVh4QSuWASh9yPfrMAoxzaeAFhxb
LqQh1JzqntmgnspEsflXIU0FKKM9raaPSYCAVdVQ2f/5NFlzWM8JxJULDh9qqwXHM2yDcLFh71be
xEEkwX6LOFJmDEFf2u3aW3j9yr4W7HTxOsI0TtA6OHOMqlpPsgcqTsrnkxSdMwc2mp21rz+HCzmQ
h5h3gq9t8VJb65AlbgO5GP7CTAOVAlgZpc5PoPJSoQ==
=JiQI
-----END PGP SIGNATURE-----

--------------o44iGprAE1ybSGGRvvu4Vakp--
