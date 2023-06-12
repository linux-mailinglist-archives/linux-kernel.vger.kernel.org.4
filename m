Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA072B8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjFLHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjFLHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:36:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4ED19B0;
        Mon, 12 Jun 2023 00:34:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1097D227D0;
        Mon, 12 Jun 2023 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686552323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYWXjFrPo85cxoAmNrQTWchVBMHopnG9ukMCkLHioSk=;
        b=nlwzU7iqHbbYidqVuZqFDovRgIC93gm0DFUkEZ0IglH7hdfwlKmuLq1FweX7GT6apcctvz
        N3IA8ohvF4Teh0geQw1MZ0YHdB7zHBkvwX2c7nMoFUI3VfN9YoEB7cgYI2jVdVyKlNyX0t
        Tk02UTRrB3FkMvIPz1L2Nk0puG5ZCaU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFABD138EC;
        Mon, 12 Jun 2023 06:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BAJXLQK/hmTJUgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 12 Jun 2023 06:45:22 +0000
Message-ID: <79d2fe19-f2fa-7df6-3833-81bd0b171fa1@suse.com>
Date:   Mon, 12 Jun 2023 08:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20230610153232.1859-1-demi@invisiblethingslab.com>
 <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
Subject: Re: [PATCH] xen: speed up grant-table reclaim
In-Reply-To: <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oI0vJUGw0t02o0Rq0ETOzPnU"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oI0vJUGw0t02o0Rq0ETOzPnU
Content-Type: multipart/mixed; boundary="------------4Tg7aXmcSJSFW0Yk9Agg7cDd";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jan Beulich <JBeulich@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen developer discussion <xen-devel@lists.xenproject.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Message-ID: <79d2fe19-f2fa-7df6-3833-81bd0b171fa1@suse.com>
Subject: Re: [PATCH] xen: speed up grant-table reclaim
References: <20230610153232.1859-1-demi@invisiblethingslab.com>
 <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
In-Reply-To: <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>

--------------4Tg7aXmcSJSFW0Yk9Agg7cDd
Content-Type: multipart/mixed; boundary="------------Y5iyrpaHlYcX9CvvZXosIuM4"

--------------Y5iyrpaHlYcX9CvvZXosIuM4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDYuMjMgMDg6MjcsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDEwLjA2LjIz
IDE3OjMyLCBEZW1pIE1hcmllIE9iZW5vdXIgd3JvdGU6DQo+PiBXaGVuIGEgZ3JhbnQgZW50
cnkgaXMgc3RpbGwgaW4gdXNlIGJ5IHRoZSByZW1vdGUgZG9tYWluLCBMaW51eCBtdXN0IHB1
dA0KPj4gaXQgb24gYSBkZWZlcnJlZCBsaXN0Lg0KPiANCj4gVGhpcyBsYWNrcyBxdWl0ZSBz
b21lIGNvbnRleHQuDQo+IA0KPiBUaGUgbWFpbiBwcm9ibGVtIGlzIHJlbGF0ZWQgdG8gdGhl
IGdyYW50IG5vdCBoYXZpbmcgYmVlbiB1bm1hcHBlZCBhZnRlcg0KPiB0aGUgZW5kIG9mIGEg
cmVxdWVzdCwgYnV0IHRoZSBzaWRlIGdyYW50aW5nIHRoZSBhY2Nlc3MgaXMgYXNzdW1pbmcg
dGhpcw0KPiBzaG91bGQgYmUgdGhlIGNhc2UuDQo+IA0KPiBJbiBnZW5lcmFsIHRoaXMgbWVh
bnMgdGhhdCB0aGUgdHdvIHNpZGVzIGltcGxlbWVudGluZyB0aGUgcHJvdG9jb2wgZG9uJ3QN
Cj4gYWdyZWUgaG93IGl0IHNob3VsZCB3b3JrLCBvciB0aGF0IHRoZSBwcm90b2NvbCBpdHNl
bGYgaGFzIGEgZmxhdy4NCj4gDQo+ICA+IE5vcm1hbGx5LCB0aGlzIGxpc3QgaXMgdmVyeSBz
aG9ydCwgYmVjYXVzZQ0KPj4gdGhlIFBWIG5ldHdvcmsgYW5kIGJsb2NrIHByb3RvY29scyBl
eHBlY3QgdGhlIGJhY2tlbmQgdG8gdW5tYXAgdGhlIGdyYW50DQo+PiBmaXJzdC4NCj4gDQo+
IE5vcm1hbGx5IHRoZSBsaXN0IGlzIGp1c3QgZW1wdHkuIE9ubHkgaW4gdmVyeSByYXJlIGNh
c2VzIGxpa2UgcHJlbWF0dXJlDQo+IFBWIGZyb250ZW5kIG1vZHVsZSB1bmxvYWRpbmcgaXQg
aXMgZXhwZWN0ZWQgdG8gc2VlIGNhc2VzIG9mIGRlZmVycmVkDQo+IGdyYW50IHJlY2xhaW1z
Lg0KPiANCj4+IEhvd2V2ZXIsIFF1YmVzIE9TJ3MgR1VJIHByb3RvY29sIGlzIHN1YmplY3Qg
dG8gdGhlIGNvbnN0cmFpbnRzDQo+PiBvZiB0aGUgWCBXaW5kb3cgU3lzdGVtLCBhbmQgYXMg
c3VjaCB3aW5kcyB1cCB3aXRoIHRoZSBmcm9udGVuZCB1bm1hcHBpbmcNCj4+IHRoZSB3aW5k
b3cgZmlyc3QuwqAgQXMgYSByZXN1bHQsIHRoZSBsaXN0IGNhbiBncm93IHZlcnkgbGFyZ2Us
IHJlc3VsdGluZw0KPj4gaW4gYSBtYXNzaXZlIG1lbW9yeSBsZWFrIGFuZCBldmVudHVhbCBW
TSBmcmVlemUuDQo+IA0KPiBJIGRvIHVuZGVyc3RhbmQgdGhhdCBpdCBpcyBkaWZmaWN1bHQg
dG8gY2hhbmdlIHRoZSBwcm90b2NvbCBhbmQvb3INCj4gYmVoYXZpb3IgYWZ0ZXIgdGhlIGZh
Y3QsIG9yIHRoYXQgcGVyZm9ybWFuY2UgY29uc2lkZXJhdGlvbnMgYXJlIGluIHRoZQ0KPiB3
YXkgb2YgZG9pbmcgc28uDQo+IA0KPj4gVG8gcGFydGlhbGx5IHNvbHZlIHRoaXMgcHJvYmxl
bSwgbWFrZSB0aGUgbnVtYmVyIG9mIGVudHJpZXMgdGhhdCB0aGUgVk0NCj4+IHdpbGwgYXR0
ZW1wdCB0byBmcmVlIGF0IGVhY2ggaXRlcmF0aW9uIHR1bmFibGUuwqAgVGhlIGRlZmF1bHQg
aXMgc3RpbGwNCj4+IDEwLCBidXQgaXQgY2FuIGJlIG92ZXJyaWRkZW4gYXQgY29tcGlsZS10
aW1lICh2aWEgS2NvbmZpZyksIGJvb3QtdGltZQ0KPj4gKHZpYSBhIGtlcm5lbCBjb21tYW5k
LWxpbmUgb3B0aW9uKSwgb3IgcnVudGltZSAodmlhIHN5c2ZzKS4NCj4gDQo+IElzIHRoZXJl
IHJlYWxseSBhIG5lZWQgdG8gaGF2ZSBhbm90aGVyIEtjb25maWcgb3B0aW9uIGZvciB0aGlz
PyBBRkFJQ1MNCj4gb25seSBRdWJlc09TIGlzIGFmZmVjdGVkIGJ5IHRoZSBwcm9ibGVtIHlv
dSBhcmUgdHJ5aW5nIHRvIHNvbHZlLiBJIGRvbid0DQo+IHNlZSB3aHkgeW91IGNhbid0IHVz
ZSB0aGUgY29tbWFuZC1saW5lIG9wdGlvbiBvciBzeXNmcyBub2RlIHRvIHNldCB0aGUNCj4g
aGlnaGVyIHJlY2xhaW0gYmF0Y2ggc2l6ZS4NCj4gDQo+Pg0KPj4gRml4ZXM6IDU2OWNhNWIz
Zjk0YyAoInhlbi9nbnR0YWI6IGFkZCBkZWZlcnJlZCBmcmVlaW5nIGxvZ2ljIikNCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgdGhpcyAiRml4ZXM6IiB0YWcgaXMgYXBwcm9wcmlhdGUuIFRoZSBt
ZW50aW9uZWQgY29tbWl0IGRpZG4ndA0KPiBoYXZlIGEgYnVnLiBZb3UgYXJlIGFkZGluZyBu
ZXcgZnVuY3Rpb25hbGl0eSBvbiB0b3Agb2YgaXQuDQo+IA0KPj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IERlbWkgTWFyaWUgT2Jlbm91ciA8ZGVt
aUBpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL3hlbi9L
Y29uZmlnwqDCoMKgwqDCoMKgIHwgMTIgKysrKysrKysrKysrDQo+PiDCoCBkcml2ZXJzL3hl
bi9ncmFudC10YWJsZS5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9LY29uZmlnIGIv
ZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4gaW5kZXggDQo+PiBkNWQ3YzQwMmI2NTExMmI4NTky
YmExMGJkM2ZkMTczMmMyNmI3NzFlLi44Zjk2ZTEzNTllYjEwMmQ2NDIwNzc1YjY2ZTc4MDUw
MDRhNGNlOWZlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4gKysr
IGIvZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4gQEAgLTY1LDYgKzY1LDE4IEBAIGNvbmZpZyBY
RU5fTUVNT1JZX0hPVFBMVUdfTElNSVQNCj4+IMKgwqDCoMKgwqDCoMKgIFRoaXMgdmFsdWUg
aXMgdXNlZCB0byBhbGxvY2F0ZSBlbm91Z2ggc3BhY2UgaW4gaW50ZXJuYWwNCj4+IMKgwqDC
oMKgwqDCoMKgIHRhYmxlcyBuZWVkZWQgZm9yIHBoeXNpY2FsIG1lbW9yeSBhZG1pbmlzdHJh
dGlvbi4NCj4+ICtjb25maWcgWEVOX0dSQU5UU19SRUNMQUlNX1BFUl9JVEVSQVRJT04NCj4+
ICvCoMKgwqAgaW50ICJEZWZhdWx0IG51bWJlciBvZiBncmFudCBlbnRyaWVzIHRvIHJlY2xh
aW0gcGVyIGl0ZXJhdGlvbiINCj4+ICvCoMKgwqAgZGVmYXVsdCAxMA0KPj4gK8KgwqDCoCBy
YW5nZSAxMCA0Mjk0OTY3Mjk1DQo+PiArwqDCoMKgIGhlbHANCj4+ICvCoMKgwqDCoMKgIFRo
aXMgc2V0cyB0aGUgZGVmYXVsdCB2YWx1ZSBmb3IgdGhlIGdyYW50X3RhYmxlLmZyZWVfcGVy
X2l0ZXJhdGlvbg0KPj4gK8KgwqDCoMKgwqAga2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb24s
IHdoaWNoIHNldHMgdGhlIG51bWJlciBvZiBncmFudHMgdGhhdA0KPj4gK8KgwqDCoMKgwqAg
TGludXggd2lsbCB0cnkgdG8gcmVjbGFpbSBhdCBvbmNlLsKgIFRoZSBkZWZhdWx0IGlzIDEw
LCBidXQNCj4+ICvCoMKgwqDCoMKgIHdvcmtsb2FkcyB0aGF0IG1ha2UgaGVhdnkgdXNlIG9m
IGdudGFsbG9jIHdpbGwgbGlrZWx5IHdhbnQgdG8NCj4+ICvCoMKgwqDCoMKgIGluY3JlYXNl
IHRoaXMuwqAgVGhlIGN1cnJlbnQgdmFsdWUgY2FuIGJlIGFjY2Vzc2VkIGFuZC9vciBtb2Rp
ZmllZA0KPj4gK8KgwqDCoMKgwqAgdmlhIC9zeXMvbW9kdWxlL2dyYW50X3RhYmxlL3BhcmFt
ZXRlcnMvZnJlZV9wZXJfaXRlcmF0aW9uLg0KPj4gKw0KPiANCj4gQXBhcnQgZnJvbSB0aGUg
ZmFjdCB0aGF0IEkgZG9uJ3QgbGlrZSBhZGRpbmcgYSBuZXcgS2NvbmZpZyBvcHRpb24sIHRo
ZSBoZWxwDQo+IHRleHQgaXMgbm90IHRlbGxpbmcgdGhlIHRydWUgc3RvcnkuIEhlYXZ5IHVz
ZSBvZiBnbnRhbGxvYyBpc24ndCB0byBibGFtZSwgYnV0DQo+IHRoZSBmYWN0IHRoYXQgeW91
ciBQVi1kZXZpY2UgaW1wbGVtZW50YXRpb24gaXMgYmFzZWQgb24gdGhlIHJlY2xhaW0NCj4g
ZnVuY3Rpb25hbGl0eS4gVEJILCBzb21lb25lIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBncmFu
dCByZWNsYWltIHdpbGwgaGF2ZSBubw0KPiBjaGFuY2UgdG8gc2VsZWN0IGEgc2Vuc2libGUg
dmFsdWUgYmFzZWQgb24geW91ciBoZWxwIHRleHQuDQo+IA0KPj4gwqAgY29uZmlnIFhFTl9T
Q1JVQl9QQUdFU19ERUZBVUxUDQo+PiDCoMKgwqDCoMKgIGJvb2wgIlNjcnViIHBhZ2VzIGJl
Zm9yZSByZXR1cm5pbmcgdGhlbSB0byBzeXN0ZW0gYnkgZGVmYXVsdCINCj4+IMKgwqDCoMKg
wqAgZGVwZW5kcyBvbiBYRU5fQkFMTE9PTg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVu
L2dyYW50LXRhYmxlLmMgYi9kcml2ZXJzL3hlbi9ncmFudC10YWJsZS5jDQo+PiBpbmRleCAN
Cj4+IGUxZWM3MjVjMjgxOWQ0ZDVkZWRlMDYzZWIwMGQ4NmE2ZDUyOTQ0YzAuLmZhNjY2YWE2
YWJjM2U3ODZkZGRjOTRmODk1NjQxNTA1ZWMwYjIzZDggMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL3hlbi9ncmFudC10YWJsZS5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi9ncmFudC10YWJs
ZS5jDQo+PiBAQCAtNDk4LDE0ICs0OTgsMjAgQEAgc3RhdGljIExJU1RfSEVBRChkZWZlcnJl
ZF9saXN0KTsNCj4+IMKgIHN0YXRpYyB2b2lkIGdudHRhYl9oYW5kbGVfZGVmZXJyZWQoc3Ry
dWN0IHRpbWVyX2xpc3QgKik7DQo+PiDCoCBzdGF0aWMgREVGSU5FX1RJTUVSKGRlZmVycmVk
X3RpbWVyLCBnbnR0YWJfaGFuZGxlX2RlZmVycmVkKTsNCj4+ICtzdGF0aWMgYXRvbWljNjRf
dCBkZWZlcnJlZF9jb3VudDsNCj4+ICtzdGF0aWMgYXRvbWljNjRfdCBsZWFrZWRfY291bnQ7
DQo+PiArc3RhdGljIHVuc2lnbmVkIGludCBmcmVlX3Blcl9pdGVyYXRpb24gPSANCj4+IENP
TkZJR19YRU5fR1JBTlRTX1JFQ0xBSU1fUEVSX0lURVJBVElPTjsNCj4+ICsNCj4+IMKgIHN0
YXRpYyB2b2lkIGdudHRhYl9oYW5kbGVfZGVmZXJyZWQoc3RydWN0IHRpbWVyX2xpc3QgKnVu
dXNlZCkNCj4+IMKgIHsNCj4+IC3CoMKgwqAgdW5zaWduZWQgaW50IG5yID0gMTA7DQo+PiAr
wqDCoMKgIHVuc2lnbmVkIGludCBuciA9IFJFQURfT05DRShmcmVlX3Blcl9pdGVyYXRpb24p
Ow0KDQpUd28gYWRkaXRpb25hbCByZW1hcmtzOg0KDQpJIHdvdWxkbid0IGJlIG9wcG9zZWQg
dG8gcmFpc2UgdGhlIGRlZmF1bHQgbnVtYmVyIG9mIHJlY2xhaW1zIHRvIGEgaGlnaGVyDQpu
dW1iZXIsIGUuZy4gMTAwLg0KDQpBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBtb3ZlIHRo
ZSByZWNsYWltIGhhbmRsaW5nIGludG8gYSB3b3JrcXVldWUgYW5kDQp0cnkgdG8gcmVjbGFp
bSBhcyBtYW55IGdyYW50cyBhcyBwb3NzaWJsZSBpbiBvbmUgZ28gd2l0aCBhIGNvbmRfcmVz
Y2hlZCgpDQpjYWxsIGV2ZXJ5IGUuZy4gMTAwIHJlY2xhaW1zLiBUaGlzIHdvdWxkIHJlbW92
ZSB0aGUgbmVlZCBmb3IgaGF2aW5nIGENCnJlY2xhaW0gdXBwZXIgYm91bmQuDQoNCg0KSnVl
cmdlbg0K
--------------Y5iyrpaHlYcX9CvvZXosIuM4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Y5iyrpaHlYcX9CvvZXosIuM4--

--------------4Tg7aXmcSJSFW0Yk9Agg7cDd--

--------------oI0vJUGw0t02o0Rq0ETOzPnU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSGvwIFAwAAAAAACgkQsN6d1ii/Ey/X
dQf/WQhtMefuM++X+5JuqY+39mJgw86WUiRxRMMXMdkbFZ4ogiy7qcbEeoaljf3bEULRHbWq6I7F
TvOQThRbG/qhq6yHq1hv4pLg21b+VKDHU11VTLVSWSXdH5NdpTyjbYKPj5p6D2n0mUQWUrUtuYOy
I+TZ00vUqP4M2qLsELkTPUtP6CBL3AKvxc9xFWAQCHsEi1YWvKMLqPsy15muOu6elldCa4HACyLm
3n4Z3mHf11O48I8eTFUrXLfU4U6BBaLgeTlr5goEyj/sysxYZtQvskEe5nXa0WHYBbF5zpHlmnK+
ukhzJiYvAURNqIgjdjtNZjkw4lqv4D8PTHS+0RoYWA==
=A2dU
-----END PGP SIGNATURE-----

--------------oI0vJUGw0t02o0Rq0ETOzPnU--
