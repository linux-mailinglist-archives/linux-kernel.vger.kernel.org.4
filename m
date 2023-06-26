Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A173E018
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFZNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:05:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309AB9;
        Mon, 26 Jun 2023 06:05:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A3B221864;
        Mon, 26 Jun 2023 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687784713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+g/GMqyOz9lm9pTM8+oSAfP3jml3Motfjlaje+sFNS8=;
        b=Fy8ZOWM5Ds+zQ9FLCw0RR4SEDSoe2XZ+bQSV3K+huO+mXgko+vlqmZaFpRaCO7KE/Nm6lZ
        zpQoZ1FjaqZ6vhu+MsmG/Jxhjvsnko1H1PWcWPkUMoFrxvmKoLSUqm2wIU0Z0MrWkeUeRX
        L+8uGc7Wv0IMxOLO0ZsVDd0+jefjQH0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C27B513483;
        Mon, 26 Jun 2023 13:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mKnRLQiNmWT3WwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 26 Jun 2023 13:05:12 +0000
Message-ID: <d3d135ae-b726-d019-9690-9f71c421e4f5@suse.com>
Date:   Mon, 26 Jun 2023 15:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org
References: <20230624205624.1817-1-demi@invisiblethingslab.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] xen: speed up grant-table reclaim
In-Reply-To: <20230624205624.1817-1-demi@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mHeC0WOb7yJmfde0byhVaLMj"
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
--------------mHeC0WOb7yJmfde0byhVaLMj
Content-Type: multipart/mixed; boundary="------------ebp0q1YcSwFAPG6JD0b6JUuK";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jan Beulich <JBeulich@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen developer discussion <xen-devel@lists.xenproject.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>, stable@vger.kernel.org
Message-ID: <d3d135ae-b726-d019-9690-9f71c421e4f5@suse.com>
Subject: Re: [PATCH v3] xen: speed up grant-table reclaim
References: <20230624205624.1817-1-demi@invisiblethingslab.com>
In-Reply-To: <20230624205624.1817-1-demi@invisiblethingslab.com>

--------------ebp0q1YcSwFAPG6JD0b6JUuK
Content-Type: multipart/mixed; boundary="------------mIrZ7XrDfqM0HIVUtnWjfwgm"

--------------mIrZ7XrDfqM0HIVUtnWjfwgm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDYuMjMgMjI6NTYsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gV2hlbiBh
IGdyYW50IGVudHJ5IGlzIHN0aWxsIGluIHVzZSBieSB0aGUgcmVtb3RlIGRvbWFpbiwgTGlu
dXggbXVzdCBwdXQNCj4gaXQgb24gYSBkZWZlcnJlZCBsaXN0LiAgTm9ybWFsbHksIHRoaXMg
bGlzdCBpcyB2ZXJ5IHNob3J0LCBiZWNhdXNlDQo+IHRoZSBQViBuZXR3b3JrIGFuZCBibG9j
ayBwcm90b2NvbHMgZXhwZWN0IHRoZSBiYWNrZW5kIHRvIHVubWFwIHRoZSBncmFudA0KPiBm
aXJzdC4gIEhvd2V2ZXIsIFF1YmVzIE9TJ3MgR1VJIHByb3RvY29sIGlzIHN1YmplY3QgdG8g
dGhlIGNvbnN0cmFpbnRzDQo+IG9mIHRoZSBYIFdpbmRvdyBTeXN0ZW0sIGFuZCBhcyBzdWNo
IHdpbmRzIHVwIHdpdGggdGhlIGZyb250ZW5kIHVubWFwcGluZw0KPiB0aGUgd2luZG93IGZp
cnN0LiAgQXMgYSByZXN1bHQsIHRoZSBsaXN0IGNhbiBncm93IHZlcnkgbGFyZ2UsIHJlc3Vs
dGluZw0KPiBpbiBhIG1hc3NpdmUgbWVtb3J5IGxlYWsgYW5kIGV2ZW50dWFsIFZNIGZyZWV6
ZS4NCj4gDQo+IFRvIHBhcnRpYWxseSBzb2x2ZSB0aGlzIHByb2JsZW0sIG1ha2UgdGhlIG51
bWJlciBvZiBlbnRyaWVzIHRoYXQgdGhlIFZNDQo+IHdpbGwgYXR0ZW1wdCB0byBmcmVlIGF0
IGVhY2ggaXRlcmF0aW9uIHR1bmFibGUuICBUaGUgZGVmYXVsdCBpcyBzdGlsbA0KPiAxMCwg
YnV0IGl0IGNhbiBiZSBvdmVycmlkZGVuIGF0IGNvbXBpbGUtdGltZSAodmlhIEtjb25maWcp
LCBib290LXRpbWUNCj4gKHZpYSBhIGtlcm5lbCBjb21tYW5kLWxpbmUgb3B0aW9uKSwgb3Ig
cnVudGltZSAodmlhIHN5c2ZzKS4NCg0KVXNpbmcgS2NvbmZpZyBoYXMgYmVlbiBkcm9wcGVk
Lg0KDQo+IA0KPiBUaGlzIGlzIENjOiBzdGFibGUgYmVjYXVzZSAod2hlbiBjb21iaW5lZCB3
aXRoIGFwcHJvcHJpYXRlIHVzZXJzcGFjZQ0KPiBjaGFuZ2VzKSBpdCBmaXhlcyBhIHNldmVy
ZSBwZXJmb3JtYW5jZSBhbmQgc3RhYmlsaXR5IHByb2JsZW0gZm9yIFF1YmVzDQo+IE9TIHVz
ZXJzLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogRGVtaSBNYXJpZSBPYmVub3VyIDxkZW1pQGludmlzaWJsZXRoaW5nc2xhYi5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMveGVuL2dyYW50LXRhYmxlLmMgfCA0MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQxIGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMveGVuL2dyYW50LXRhYmxlLmMgYi9kcml2ZXJzL3hlbi9ncmFudC10YWJsZS5jDQo+IGlu
ZGV4IGUxZWM3MjVjMjgxOWQ0ZDVkZWRlMDYzZWIwMGQ4NmE2ZDUyOTQ0YzAuLmZhNjY2YWE2
YWJjM2U3ODZkZGRjOTRmODk1NjQxNTA1ZWMwYjIzZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMveGVuL2dyYW50LXRhYmxlLmMNCj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtdGFibGUu
Yw0KPiBAQCAtNDk4LDE0ICs0OTgsMjAgQEAgc3RhdGljIExJU1RfSEVBRChkZWZlcnJlZF9s
aXN0KTsNCj4gICBzdGF0aWMgdm9pZCBnbnR0YWJfaGFuZGxlX2RlZmVycmVkKHN0cnVjdCB0
aW1lcl9saXN0ICopOw0KPiAgIHN0YXRpYyBERUZJTkVfVElNRVIoZGVmZXJyZWRfdGltZXIs
IGdudHRhYl9oYW5kbGVfZGVmZXJyZWQpOw0KPiAgIA0KPiArc3RhdGljIGF0b21pYzY0X3Qg
ZGVmZXJyZWRfY291bnQ7DQo+ICtzdGF0aWMgYXRvbWljNjRfdCBsZWFrZWRfY291bnQ7DQo+
ICtzdGF0aWMgdW5zaWduZWQgaW50IGZyZWVfcGVyX2l0ZXJhdGlvbiA9IDEwOw0KPiArDQo+
ICAgc3RhdGljIHZvaWQgZ250dGFiX2hhbmRsZV9kZWZlcnJlZChzdHJ1Y3QgdGltZXJfbGlz
dCAqdW51c2VkKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBpbnQgbnIgPSAxMDsNCj4gKwl1bnNp
Z25lZCBpbnQgbnIgPSBSRUFEX09OQ0UoZnJlZV9wZXJfaXRlcmF0aW9uKTsNCj4gKwljb25z
dCBib29sIGlnbm9yZV9saW1pdCA9IG5yID09IDA7DQo+ICAgCXN0cnVjdCBkZWZlcnJlZF9l
bnRyeSAqZmlyc3QgPSBOVUxMOw0KPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCXNp
emVfdCBmcmVlZCA9IDA7DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZnbnR0YWJf
bGlzdF9sb2NrLCBmbGFncyk7DQo+IC0Jd2hpbGUgKG5yLS0pIHsNCj4gKwl3aGlsZSAoKGln
bm9yZV9saW1pdCB8fCBuci0tKSAmJiAhbGlzdF9lbXB0eSgmZGVmZXJyZWRfbGlzdCkpIHsN
Cj4gICAJCXN0cnVjdCBkZWZlcnJlZF9lbnRyeSAqZW50cnkNCj4gICAJCQk9IGxpc3RfZmly
c3RfZW50cnkoJmRlZmVycmVkX2xpc3QsDQo+ICAgCQkJCQkgICBzdHJ1Y3QgZGVmZXJyZWRf
ZW50cnksIGxpc3QpOw0KPiBAQCAtNTE1LDEwICs1MjEsMTMgQEAgc3RhdGljIHZvaWQgZ250
dGFiX2hhbmRsZV9kZWZlcnJlZChzdHJ1Y3QgdGltZXJfbGlzdCAqdW51c2VkKQ0KPiAgIAkJ
bGlzdF9kZWwoJmVudHJ5LT5saXN0KTsNCj4gICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmdudHRhYl9saXN0X2xvY2ssIGZsYWdzKTsNCj4gICAJCWlmIChfZ250dGFiX2VuZF9mb3Jl
aWduX2FjY2Vzc19yZWYoZW50cnktPnJlZikpIHsNCj4gKwkJCXVpbnQ2NF90IHJldCA9IGF0
b21pYzY0X3N1Yl9yZXR1cm4oMSwgJmRlZmVycmVkX2NvdW50KTsNCg0KVXNlIGF0b21pYzY0
X2RlY19yZXR1cm4oKT8NCg0KUGxlYXNlIGFkZCBhbiBlbXB0eSBsaW5lIGhlcmUuDQoNCj4g
ICAJCQlwdXRfZnJlZV9lbnRyeShlbnRyeS0+cmVmKTsNCj4gLQkJCXByX2RlYnVnKCJmcmVl
aW5nIGcuZS4gJSN4IChwZm4gJSNseClcbiIsDQo+IC0JCQkJIGVudHJ5LT5yZWYsIHBhZ2Vf
dG9fcGZuKGVudHJ5LT5wYWdlKSk7DQo+ICsJCQlwcl9kZWJ1ZygiZnJlZWluZyBnLmUuICUj
eCAocGZuICUjbHgpLCAlbGx1IHJlbWFpbmluZ1xuIiwNCj4gKwkJCQkgZW50cnktPnJlZiwg
cGFnZV90b19wZm4oZW50cnktPnBhZ2UpLA0KPiArCQkJCSAodW5zaWduZWQgbG9uZyBsb25n
KXJldCk7DQo+ICAgCQkJcHV0X3BhZ2UoZW50cnktPnBhZ2UpOw0KPiArCQkJZnJlZWQrKzsN
Cj4gICAJCQlrZnJlZShlbnRyeSk7DQo+ICAgCQkJZW50cnkgPSBOVUxMOw0KPiAgIAkJfSBl
bHNlIHsNCj4gQEAgLTUzMCwyMSArNTM5LDIyIEBAIHN0YXRpYyB2b2lkIGdudHRhYl9oYW5k
bGVfZGVmZXJyZWQoc3RydWN0IHRpbWVyX2xpc3QgKnVudXNlZCkNCj4gICAJCXNwaW5fbG9j
a19pcnFzYXZlKCZnbnR0YWJfbGlzdF9sb2NrLCBmbGFncyk7DQo+ICAgCQlpZiAoZW50cnkp
DQo+ICAgCQkJbGlzdF9hZGRfdGFpbCgmZW50cnktPmxpc3QsICZkZWZlcnJlZF9saXN0KTsN
Cj4gLQkJZWxzZSBpZiAobGlzdF9lbXB0eSgmZGVmZXJyZWRfbGlzdCkpDQo+IC0JCQlicmVh
azsNCj4gICAJfQ0KPiAtCWlmICghbGlzdF9lbXB0eSgmZGVmZXJyZWRfbGlzdCkgJiYgIXRp
bWVyX3BlbmRpbmcoJmRlZmVycmVkX3RpbWVyKSkgew0KPiArCWlmIChsaXN0X2VtcHR5KCZk
ZWZlcnJlZF9saXN0KSkNCj4gKwkJV0FSTl9PTihhdG9taWM2NF9yZWFkKCZkZWZlcnJlZF9j
b3VudCkpOw0KPiArCWVsc2UgaWYgKCF0aW1lcl9wZW5kaW5nKCZkZWZlcnJlZF90aW1lcikp
IHsNCj4gICAJCWRlZmVycmVkX3RpbWVyLmV4cGlyZXMgPSBqaWZmaWVzICsgSFo7DQo+ICAg
CQlhZGRfdGltZXIoJmRlZmVycmVkX3RpbWVyKTsNCj4gICAJfQ0KPiAgIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZnbnR0YWJfbGlzdF9sb2NrLCBmbGFncyk7DQo+ICsJcHJfZGVidWco
IkZyZWVkICV6dSByZWZlcmVuY2VzIiwgZnJlZWQpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0
aWMgdm9pZCBnbnR0YWJfYWRkX2RlZmVycmVkKGdyYW50X3JlZl90IHJlZiwgc3RydWN0IHBh
Z2UgKnBhZ2UpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZGVmZXJyZWRfZW50cnkgKmVudHJ5Ow0K
PiAgIAlnZnBfdCBnZnAgPSAoaW5fYXRvbWljKCkgfHwgaXJxc19kaXNhYmxlZCgpKSA/IEdG
UF9BVE9NSUMgOiBHRlBfS0VSTkVMOw0KPiAtCWNvbnN0IGNoYXIgKndoYXQgPSBLRVJOX1dB
Uk5JTkcgImxlYWtpbmciOw0KPiArCXVpbnQ2NF90IGxlYWtlZCwgZGVmZXJyZWQ7DQo+ICAg
DQo+ICAgCWVudHJ5ID0ga21hbGxvYyhzaXplb2YoKmVudHJ5KSwgZ2ZwKTsNCj4gICAJaWYg
KCFwYWdlKSB7DQo+IEBAIC01NjcsMTIgKzU3NywyMCBAQCBzdGF0aWMgdm9pZCBnbnR0YWJf
YWRkX2RlZmVycmVkKGdyYW50X3JlZl90IHJlZiwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICAg
CQkJYWRkX3RpbWVyKCZkZWZlcnJlZF90aW1lcik7DQo+ICAgCQl9DQo+ICAgCQlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZnbnR0YWJfbGlzdF9sb2NrLCBmbGFncyk7DQo+IC0JCXdoYXQg
PSBLRVJOX0RFQlVHICJkZWZlcnJpbmciOw0KPiArCQlkZWZlcnJlZCA9IGF0b21pYzY0X2Fk
ZF9yZXR1cm4oMSwgJmRlZmVycmVkX2NvdW50KTsNCg0KVXNlIGF0b21pYzY0X2luY19yZXR1
cm4oKSAoc2FtZSBiZWxvdyk/DQoNCj4gKwkJbGVha2VkID0gYXRvbWljNjRfcmVhZCgmbGVh
a2VkX2NvdW50KTsNCj4gKwkJcHJfZGVidWcoImRlZmVycmluZyBnLmUuICUjeCAocGZuICUj
bHgpICh0b3RhbCBkZWZlcnJlZCAlbGx1LCB0b3RhbCBsZWFrZWQgJWxsdSlcbiIsDQo+ICsJ
CQkgcmVmLCBwYWdlID8gcGFnZV90b19wZm4ocGFnZSkgOiAtMSwgZGVmZXJyZWQsIGxlYWtl
ZCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJZGVmZXJyZWQgPSBhdG9taWM2NF9yZWFkKCZkZWZl
cnJlZF9jb3VudCk7DQo+ICsJCWxlYWtlZCA9IGF0b21pYzY0X2FkZF9yZXR1cm4oMSwgJmxl
YWtlZF9jb3VudCk7DQo+ICsJCXByX3dhcm4oImxlYWtpbmcgZy5lLiAlI3ggKHBmbiAlI2x4
KSAodG90YWwgZGVmZXJyZWQgJWxsdSwgdG90YWwgbGVha2VkICVsbHUpXG4iLA0KPiArCQkJ
cmVmLCBwYWdlID8gcGFnZV90b19wZm4ocGFnZSkgOiAtMSwgZGVmZXJyZWQsIGxlYWtlZCk7
DQo+ICAgCX0NCj4gLQlwcmludGsoIiVzIGcuZS4gJSN4IChwZm4gJSNseClcbiIsDQo+IC0J
ICAgICAgIHdoYXQsIHJlZiwgcGFnZSA/IHBhZ2VfdG9fcGZuKHBhZ2UpIDogLTEpOw0KPiAg
IH0NCj4gICANCj4gK21vZHVsZV9wYXJhbShmcmVlX3Blcl9pdGVyYXRpb24sIHVpbnQsIDA2
MDApOw0KPiArDQoNCkFzIHNhaWQgZm9yIHYyIGFscmVhZHk6IHBsZWFzZSBtb3ZlIHRoaXMg
Y2xvc2VyIHRvIHRoZSByZWxhdGVkIHZhcmlhYmxlDQpkZWZpbml0aW9uLg0KDQo+ICAgaW50
IGdudHRhYl90cnlfZW5kX2ZvcmVpZ25fYWNjZXNzKGdyYW50X3JlZl90IHJlZikNCj4gICB7
DQo+ICAgCWludCByZXQgPSBfZ250dGFiX2VuZF9mb3JlaWduX2FjY2Vzc19yZWYocmVmKTsN
Cg0KDQpKdWVyZ2VuDQo=
--------------mIrZ7XrDfqM0HIVUtnWjfwgm
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------mIrZ7XrDfqM0HIVUtnWjfwgm--

--------------ebp0q1YcSwFAPG6JD0b6JUuK--

--------------mHeC0WOb7yJmfde0byhVaLMj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSZjQgFAwAAAAAACgkQsN6d1ii/Ey9n
rwgAl9aj+/RACmJfgKRH3lah4xrX0a2jqW1I4fOkGIUknEQkHfyVIyjip3+AJCcIw9XRVbx8aDqt
U22ktQekf6n0tVwAy2SKbxgzSqyvoYWrcBjpkeb3GtsMRDGtU5GJKgImFcCKDEB+PFPMdGiUisMv
nQx8CC7fHcb6JvI6Slw5cwZAjMPvSOQ1iD0zKRKCcvHp/r6SuQbhIhWIK5myLKljSpkJGBYkGd5U
eubdCk9pX733hzXRKkIyTqHkbKzvvVgjoYyfAN2pvLZrrr4LiyJ9nAeNOrm6VgxDxZDjzRrNXvej
/Dkr1wzQQC31oOChMHt+r7lQRH95Hy6+EoZFtvDHlg==
=hjdC
-----END PGP SIGNATURE-----

--------------mHeC0WOb7yJmfde0byhVaLMj--
