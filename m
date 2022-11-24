Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E563730E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKXHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKXHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:47:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91A18E21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:47:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CED84218B5;
        Thu, 24 Nov 2022 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669276067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07IDGF5XNYz6e2lhof5UOYSdrqi1+SlQuw31h3/bGvY=;
        b=hI+7oq1tJtgVOex9ofwvOQPQ1Sn8dbuWfvCQEkkpkYtx/CTfDNFW8SMNoFYWUtCz/c6C4l
        pmI5D3gG/+V9YjLK3+c0crpWkH6GiFqz8e9QjUa5CXJVeoUMEWjrKQGHeuP6nkrUGrvRvW
        QFxORetabqfFv52RS1jqlej4VlnGEjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78DE613AC9;
        Thu, 24 Nov 2022 07:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dp9wG6Mhf2OKVQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 07:47:47 +0000
Message-ID: <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
Date:   Thu, 24 Nov 2022 08:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: objtool warning for next-20221118
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
 <20221124023934.nft3udxelth4lvai@treble>
 <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
In-Reply-To: <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eljA8Dt0yylIHwiYAZnuZFCA"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eljA8Dt0yylIHwiYAZnuZFCA
Content-Type: multipart/mixed; boundary="------------0IclpDUqLeC6ZzwUmVegATIk";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Thomas Gleixner <tglx@linutronix.de>
Message-ID: <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
Subject: Re: objtool warning for next-20221118
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
 <20221124023934.nft3udxelth4lvai@treble>
 <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
In-Reply-To: <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>

--------------0IclpDUqLeC6ZzwUmVegATIk
Content-Type: multipart/mixed; boundary="------------EeNKth1XtNH0IGGGy8q3zBtC"

--------------EeNKth1XtNH0IGGGy8q3zBtC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMDY6MjgsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDI0LjExLjIy
IDAzOjM5LCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToNCj4+IE9uIFdlZCwgTm92IDIzLCAyMDIy
IGF0IDA5OjAzOjQwQU0gLTA4MDAsIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPj4+IE9uIFdl
ZCwgTm92IDIzLCAyMDIyIGF0IDEwOjUyOjA5QU0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3Jv
dGU6DQo+Pj4+PiBXZWxsLCBpZiB5b3UgcmV0dXJuIGZyb20gYXJjaF9jcHVfaWRsZV9kZWFk
KCkgeW91J3JlIGJhY2sgaW4gdGhlIGlkbGUNCj4+Pj4+IGxvb3AgLS0gZXhhY3RseSB3aGVy
ZSB5b3Ugd291bGQgYmUgaWYgeW91IHdlcmUgdG8gYm9vdHN0cmFwIHRoZSB3aG9sZQ0KPj4+
Pj4gQ1BVIC0tIHByb3ZpZGVkIHlvdSBoYXZlIGl0IHJlbWVtYmVyIHRoZSB3aG9sZSBzdGF0
ZSAoZWFzaWVyIHdpdGggYQ0KPj4+Pj4gdkNQVSkuDQo+Pj4NCj4+PiBwbGF5X2RlYWQoKSBy
ZWFsbHkgbmVlZHMgc2FuZSBzZW1hbnRpY3MuwqAgTm90IG9ubHkgZG9lcyBpdCBpbnRyb2R1
Y2UgYQ0KPj4+IHN1cnByaXNlIHRvIHRoZSBvZmZsaW5pbmcgY29kZSBpbiBkb19pZGxlKCks
IGl0IGFsc28gc2tpcHMgdGhlIGVudGlyZQ0KPj4+IGhvdHBsdWcgc3RhdGUgbWFjaGluZS7C
oCBOb3Qgc3VyZSBpZiB0aGF0IGludHJvZHVjZXMgYW55IGJ1Z3MsIGJ1dCBhdCB0aGUNCj4+
PiB2ZXJ5IGxlYXN0IGl0J3Mgc3VidGxlIGFuZCBzdXJwcmlzaW5nLg0KPj4+DQo+Pj4+PiBC
dXQgbWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nLCBsZXRzIGFkZCBYZW4gZm9sa3Mgb24u
DQo+Pj4+DQo+Pj4+IENhbGxpbmcgVkNQVU9QX2Rvd24gb24gb25lc2VsZiBhbHdheXMgc3Vj
Y2VlZHMsIGJ1dCBhbGwgaXQgZG9lcyBpcw0KPj4+PiBkZXNjaGVkdWxlIHRoZSB2Q1BVLg0K
Pj4+Pg0KPj4+PiBJdCBjYW4gYmUgdW5kb25lIGF0IGEgbGF0ZXIgcG9pbnQgYnkgYSBkaWZm
ZXJlbnQgdmNwdSBpc3N1aW5nIFZDUFVPUF91cA0KPj4+PiBhZ2FpbnN0IHRoZSBwcmV2aW91
c2x5LWRvd25lZCBDUFUsIGF0IHdoaWNoIHBvaW50IHRoZSB2Q1BVIGdldHMgcmVzY2hlZHVs
ZWQuDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgd2h5IHRoZSBWQ1BVT1BfZG93biBoeXBlcmNhbGwg
cmV0dXJucyBub3JtYWxseS7CoCBBbGwgc3RhdGUNCj4+Pj4gcmVhbGx5IGlzIGludGFjdC4N
Cj4+Pj4NCj4+Pj4gQXMgZm9yIHdoYXQgTGludXggZG9lcywgdGhpcyBpcyBob3cgeGVuX3B2
X2NwdV91cCgpIGN1cnJlbnRseSBiZWhhdmVzLg0KPj4+PiBJZiB5b3Ugd2FudCB0byBtYWtl
IFhlbiBiZWhhdmUgbW9yZSBldmVyeXRoaW5nIGVsc2UsIHRoZW4gYnVnIGEgQlVHKCkNCj4+
Pj4gYWZ0ZXIgVkNQVU9QX2Rvd24sIGFuZCBhZGp1c3QgeGVuX3B2X2NwdV91cCgpIHRvIHNr
aXAgaXRzIGluaXRpYWxpc2VkDQo+Pj4+IGNoZWNrIGFuZCBhbHdheXMgdXNlIFZDUFVPUF9p
bml0aWFsaXNlIHRvIGJyaW5nIHRoZSB2Q1BVIGJhY2sgb25saW5lLg0KPj4+DQo+Pj4gT3Ig
d2UgY291bGQgZG8gd2hhdCBzZXZfZXNfcGxheV9kZWFkKCkgZG9lcyBhbmQganVzdCBjYWxs
IHN0YXJ0X2NwdTAoKQ0KPj4+IGFmdGVyIHRoZSBoeXBlcmNhbGwgcmV0dXJucz8NCj4+DQo+
PiBTb21ldGhpbmcgbGlrZSBzbyAodW50ZXN0ZWQpLsKgIFRoaXMgaXMgb25seSB0aGUgeDg2
IGJpdHMuDQo+Pg0KPj4gSSB0aGluayBJIGNvbnZpbmNlZCBteXNlbGYgdGhhdCBzdGFydF9j
cHUwKCkgaXNuJ3QgYnVnZ3kuwqAgSSdtIGxvb2tpbmcNCj4+IGF0IG90aGVyIGNsZWFudXBz
LCBlLmcuIGNvbnZlcmdpbmcgY3B1X2JyaW5ndXBfYW5kX2lkbGUoKSB3aXRoDQo+PiBzdGFy
dF9zZWNvbmRhcnkoKS4NCj4+DQo+PiBJIGNhbiBwaWNrIGl0IHVwIGFnYWluIG5leHQgd2Vl
aywgcG9zdC10dXJrZXkuDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NtcC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc21wLmgNCj4+IGluZGV4IGI0ZGJi
MjBkYWIxYS4uZTZkMWQyODEwZTM4IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vc21wLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtcC5oDQo+PiBA
QCAtOTMsOSArOTMsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fY3B1X2RpZSh1bnNpZ25l
ZCBpbnQgY3B1KQ0KPj4gwqDCoMKgwqDCoCBzbXBfb3BzLmNwdV9kaWUoY3B1KTsNCj4+IMKg
IH0NCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgcGxheV9kZWFkKHZvaWQpDQo+PiArc3RhdGlj
IGlubGluZSB2b2lkIF9fbm9yZXR1cm4gcGxheV9kZWFkKHZvaWQpDQo+PiDCoCB7DQo+PiDC
oMKgwqDCoMKgIHNtcF9vcHMucGxheV9kZWFkKCk7DQo+PiArwqDCoMKgIEJVRygpOw0KPj4g
wqAgfQ0KPj4gwqAgc3RhdGljIGlubGluZSB2b2lkIHNtcF9zZW5kX3Jlc2NoZWR1bGUoaW50
IGNwdSkNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJj
aC94ODYva2VybmVsL3Byb2Nlc3MuYw0KPj4gaW5kZXggMjZlOGY1N2M3NWFkLi44ZTI4NDFk
ZWIxZWIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+PiBAQCAtNzAwLDcgKzcwMCw3IEBA
IEVYUE9SVF9TWU1CT0woYm9vdF9vcHRpb25faWRsZV9vdmVycmlkZSk7DQo+PiDCoCBzdGF0
aWMgdm9pZCAoKng4Nl9pZGxlKSh2b2lkKTsNCj4+IMKgICNpZm5kZWYgQ09ORklHX1NNUA0K
Pj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBwbGF5X2RlYWQodm9pZCkNCj4+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgX19ub3JldHVybiBwbGF5X2RlYWQodm9pZCkNCj4+IMKgIHsNCj4+IMKgwqDC
oMKgwqAgQlVHKCk7DQo+PiDCoCB9DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L3NtcGJvb3QuYyBiL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMNCj4+IGluZGV4IDU1Y2Fk
NzI3MTVkOS4uZDhiMTJhYzFhN2M1IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L3NtcGJvb3QuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYw0KPj4gQEAg
LTE4MzMsOSArMTgzMywxMiBAQCB2b2lkIG5hdGl2ZV9wbGF5X2RlYWQodm9pZCkNCj4+IMKg
wqDCoMKgwqAgcGxheV9kZWFkX2NvbW1vbigpOw0KPj4gwqDCoMKgwqDCoCB0Ym9vdF9zaHV0
ZG93bihUQl9TSFVURE9XTl9XRlMpOw0KPj4gLcKgwqDCoCBtd2FpdF9wbGF5X2RlYWQoKTvC
oMKgwqAgLyogT25seSByZXR1cm5zIG9uIGZhaWx1cmUgKi8NCj4+ICvCoMKgwqAgbXdhaXRf
cGxheV9kZWFkKCk7wqDCoMKgIC8qIE9ubHkgcmV0dXJucyBpZiBtd2FpdCBpcyBub3Qgc3Vw
cG9ydGVkICovDQo+PiArDQo+PiDCoMKgwqDCoMKgIGlmIChjcHVpZGxlX3BsYXlfZGVhZCgp
KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGhsdF9wbGF5X2RlYWQoKTsNCj4+ICsNCj4+ICvC
oMKgwqAgQlVHKCk7DQo+PiDCoCB9DQo+PiDCoCAjZWxzZSAvKiAuLi4gIUNPTkZJR19IT1RQ
TFVHX0NQVSAqLw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9zbXBfcHYuYyBiL2Fy
Y2gveDg2L3hlbi9zbXBfcHYuYw0KPj4gaW5kZXggNDgwYmU4MmU5YjdiLi4zMGRjOTA0Y2E5
OTAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vc21wX3B2LmMNCj4+ICsrKyBiL2Fy
Y2gveDg2L3hlbi9zbXBfcHYuYw0KPj4gQEAgLTM4NSwxNyArMzg1LDkgQEAgc3RhdGljIHZv
aWQgeGVuX3B2X3BsYXlfZGVhZCh2b2lkKSAvKiB1c2VkIG9ubHkgd2l0aCANCj4+IEhPVFBM
VUdfQ1BVICovDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHBsYXlfZGVhZF9jb21tb24oKTsN
Cj4+IMKgwqDCoMKgwqAgSFlQRVJWSVNPUl92Y3B1X29wKFZDUFVPUF9kb3duLCB4ZW5fdmNw
dV9ucihzbXBfcHJvY2Vzc29yX2lkKCkpLCBOVUxMKTsNCj4+IC3CoMKgwqAgY3B1X2JyaW5n
dXAoKTsNCj4+IC3CoMKgwqAgLyoNCj4+IC3CoMKgwqDCoCAqIGNvbW1pdCA0YjBjMGYyOTQg
KHRpY2s6IENsZWFudXAgTk9IWiBwZXIgY3B1IGRhdGEgb24gY3B1IGRvd24pDQo+PiAtwqDC
oMKgwqAgKiBjbGVhcnMgY2VydGFpbiBkYXRhIHRoYXQgdGhlIGNwdV9pZGxlIGxvb3AgKHdo
aWNoIGNhbGxlZCB1cw0KPj4gLcKgwqDCoMKgICogYW5kIHRoYXQgd2UgcmV0dXJuIGZyb20p
IGV4cGVjdHMuIFRoZSBvbmx5IHdheSB0byBnZXQgdGhhdA0KPj4gLcKgwqDCoMKgICogZGF0
YSBiYWNrIGlzIHRvIGNhbGw6DQo+PiAtwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqAgdGlja19u
b2h6X2lkbGVfZW50ZXIoKTsNCj4+IC3CoMKgwqAgdGlja19ub2h6X2lkbGVfc3RvcF90aWNr
X3Byb3RlY3RlZCgpOw0KPj4gLcKgwqDCoCBjcHVocF9vbmxpbmVfaWRsZShDUFVIUF9BUF9P
TkxJTkVfSURMRSk7DQo+PiArwqDCoMKgIC8qIEZJWE1FOiBjb252ZXJnZSBjcHVfYnJpbmd1
cF9hbmRfaWRsZSgpIGFuZCBzdGFydF9zZWNvbmRhcnkoKSAqLw0KPj4gK8KgwqDCoCBjcHVf
YnJpbmd1cF9hbmRfaWRsZSgpOw0KPiANCj4gSSB0aGluayB0aGlzIHdpbGwgbGVhayBzdGFj
ayBtZW1vcnkuIE11bHRpcGxlIGNwdSBvZmZsaW5lL29ubGluZSBjeWNsZXMgb2YNCj4gdGhl
IHNhbWUgY3B1IHdpbGwgZmluYWxseSBleGhhdXN0IHRoZSBpZGxlIHN0YWNrLg0KDQpUaGUg
YXR0YWNoZWQgcGF0Y2ggc2VlbXMgdG8gd29yayBmaW5lLg0KDQpUaGUgX19ub3JldHVybiBh
bm5vdGF0aW9uIHNlZW1zIHRvIHRyaWdnZXIgYW4gb2JqdG9vbCB3YXJuaW5nLCB0aG91Z2gs
IGluDQpzcGl0ZSBvZiB0aGUgYWRkZWQgQlVHKCkgYXQgdGhlIGVuZCBvZiB4ZW5fcHZfcGxh
eV9kZWFkKCk6DQoNCmFyY2gveDg2L3hlbi9zbXBfcHYubzogd2FybmluZzogb2JqdG9vbDog
eGVuX3B2X3BsYXlfZGVhZCgpIGZhbGxzIHRocm91Z2ggdG8gDQpuZXh0IGZ1bmN0aW9uIHhl
bl9wdl9jcHVfZGllKCkNCg0KDQpKdWVyZ2VuDQoNCg==
--------------EeNKth1XtNH0IGGGy8q3zBtC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-xen-don-t-let-xen_pv_play_dead-return.patch"
Content-Disposition: attachment;
 filename="0001-x86-xen-don-t-let-xen_pv_play_dead-return.patch"
Content-Transfer-Encoding: base64

RnJvbSA3ZWJiNzZlYzBlZDMyYjY1N2NlZGE1MzBiNjIwZWY1NjNhYzBmMjEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IFRodSwgMjQgTm92IDIwMjIgMDg6MDk6NDUgKzAxMDAKU3ViamVjdDogW1BBVENI
XSB4ODYveGVuOiBkb24ndCBsZXQgeGVuX3B2X3BsYXlfZGVhZCgpIHJldHVybgoKQSBmdW5j
dGlvbiBjYWxsZWQgdmlhIHRoZSBwYXJhdmlydCBwbGF5X2RlYWQoKSBob29rIHNob3VsZCBu
b3QgcmV0dXJuCnRvIHRoZSBjYWxsZXIuCgp4ZW5fcHZfcGxheV9kZWFkKCkgaGFzIGEgcHJv
YmxlbSBpbiB0aGlzIHJlZ2FyZCwgYXMgaXQgY3VycmVudGx5IHdpbGwKcmV0dXJuIGluIGNh
c2UgYW4gb2ZmbGluZWQgY3B1IGlzIGJyb3VnaHQgdG8gbGlmZSBhZ2Fpbi4gVGhpcyBjYW4g
YmUKY2hhbmdlZCBvbmx5IGJ5IGRvaW5nIGJhc2ljYWxseSBhIGxvbmdqbXAoKSB0byBjcHVf
YnJpbmd1cF9hbmRfaWRsZSgpLAphcyB0aGUgaHlwZXJjYWxsIGZvciBicmluZ2luZyBkb3du
IHRoZSBjcHUgd2lsbCBqdXN0IHJldHVybiB3aGVuIHRoZQpjcHUgaXMgY29taW5nIHVwIGFn
YWluLiBKdXN0IHJlLWluaXRpYWxpemluZyB0aGUgY3B1IGlzbid0IHBvc3NpYmxlLAphcyB0
aGUgWGVuIGh5cGVydmlzb3Igd2lsbCBkZW55IHRoYXQgb3BlcmF0aW9uLgoKU28gaW50cm9k
dWNlIHhlbl9jcHVfYnJpbmd1cF9hZ2FpbigpIHJlc2V0dGluZyB0aGUgc3RhY2sgYW5kIGNh
bGxpbmcKY3B1X2JyaW5ndXBfYW5kX2lkbGUoKSwgd2hpY2ggY2FuIGJlIGNhbGxlZCBhZnRl
ciBIWVBFUlZJU09SX3ZjcHVfb3AoKQppbiB4ZW5fcHZfcGxheV9kZWFkKCkuCgpBbm5vdGF0
ZSB4ZW5fcHZfcGxheV9kZWFkKCkgYW5kIHhlbl9jcHVfYnJpbmd1cF9hZ2FpbigpIHdpdGgK
Il9fbm9yZXR1cm4iLgoKU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuY29tPgotLS0KIGFyY2gveDg2L3hlbi9zbXAuaCAgICAgIHwgIDIgKysKIGFyY2gveDg2
L3hlbi9zbXBfcHYuYyAgIHwgMTcgKysrKy0tLS0tLS0tLS0tLS0KIGFyY2gveDg2L3hlbi94
ZW4taGVhZC5TIHwgIDcgKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vc21wLmgg
Yi9hcmNoL3g4Ni94ZW4vc21wLmgKaW5kZXggYmQwMmY5ZDUwMTA3Li4yMmZiOTgyZmY5NzEg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3hlbi9zbXAuaAorKysgYi9hcmNoL3g4Ni94ZW4vc21w
LmgKQEAgLTIxLDYgKzIxLDggQEAgdm9pZCB4ZW5fc21wX3NlbmRfcmVzY2hlZHVsZShpbnQg
Y3B1KTsKIHZvaWQgeGVuX3NtcF9zZW5kX2NhbGxfZnVuY3Rpb25faXBpKGNvbnN0IHN0cnVj
dCBjcHVtYXNrICptYXNrKTsKIHZvaWQgeGVuX3NtcF9zZW5kX2NhbGxfZnVuY3Rpb25fc2lu
Z2xlX2lwaShpbnQgY3B1KTsKIAordm9pZCBfX25vcmV0dXJuIHhlbl9jcHVfYnJpbmd1cF9h
Z2Fpbih1bnNpZ25lZCBsb25nIHN0YWNrKTsKKwogc3RydWN0IHhlbl9jb21tb25faXJxIHsK
IAlpbnQgaXJxOwogCWNoYXIgKm5hbWU7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vc21w
X3B2LmMgYi9hcmNoL3g4Ni94ZW4vc21wX3B2LmMKaW5kZXggNDgwYmU4MmU5YjdiLi41ODAx
ZjkzZDU2N2MgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3hlbi9zbXBfcHYuYworKysgYi9hcmNo
L3g4Ni94ZW4vc21wX3B2LmMKQEAgLTM4MSwyMSArMzgxLDEyIEBAIHN0YXRpYyB2b2lkIHhl
bl9wdl9jcHVfZGllKHVuc2lnbmVkIGludCBjcHUpCiAJfQogfQogCi1zdGF0aWMgdm9pZCB4
ZW5fcHZfcGxheV9kZWFkKHZvaWQpIC8qIHVzZWQgb25seSB3aXRoIEhPVFBMVUdfQ1BVICov
CitzdGF0aWMgdm9pZCBfX25vcmV0dXJuIHhlbl9wdl9wbGF5X2RlYWQodm9pZCkgLyogdXNl
ZCBvbmx5IHdpdGggSE9UUExVR19DUFUgKi8KIHsKIAlwbGF5X2RlYWRfY29tbW9uKCk7CiAJ
SFlQRVJWSVNPUl92Y3B1X29wKFZDUFVPUF9kb3duLCB4ZW5fdmNwdV9ucihzbXBfcHJvY2Vz
c29yX2lkKCkpLCBOVUxMKTsKLQljcHVfYnJpbmd1cCgpOwotCS8qCi0JICogY29tbWl0IDRi
MGMwZjI5NCAodGljazogQ2xlYW51cCBOT0haIHBlciBjcHUgZGF0YSBvbiBjcHUgZG93bikK
LQkgKiBjbGVhcnMgY2VydGFpbiBkYXRhIHRoYXQgdGhlIGNwdV9pZGxlIGxvb3AgKHdoaWNo
IGNhbGxlZCB1cwotCSAqIGFuZCB0aGF0IHdlIHJldHVybiBmcm9tKSBleHBlY3RzLiBUaGUg
b25seSB3YXkgdG8gZ2V0IHRoYXQKLQkgKiBkYXRhIGJhY2sgaXMgdG8gY2FsbDoKLQkgKi8K
LQl0aWNrX25vaHpfaWRsZV9lbnRlcigpOwotCXRpY2tfbm9oel9pZGxlX3N0b3BfdGlja19w
cm90ZWN0ZWQoKTsKLQotCWNwdWhwX29ubGluZV9pZGxlKENQVUhQX0FQX09OTElORV9JRExF
KTsKKwl4ZW5fY3B1X2JyaW5ndXBfYWdhaW4oKHVuc2lnbmVkIGxvbmcpdGFza19wdF9yZWdz
KGN1cnJlbnQpKTsKKwlCVUcoKTsKIH0KIAogI2Vsc2UgLyogIUNPTkZJR19IT1RQTFVHX0NQ
VSAqLwpAQCAtNDA5LDcgKzQwMCw3IEBAIHN0YXRpYyB2b2lkIHhlbl9wdl9jcHVfZGllKHVu
c2lnbmVkIGludCBjcHUpCiAJQlVHKCk7CiB9CiAKLXN0YXRpYyB2b2lkIHhlbl9wdl9wbGF5
X2RlYWQodm9pZCkKK3N0YXRpYyB2b2lkIF9fbm9yZXR1cm4geGVuX3B2X3BsYXlfZGVhZCh2
b2lkKQogewogCUJVRygpOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL3hlbi1oZWFk
LlMgYi9hcmNoL3g4Ni94ZW4veGVuLWhlYWQuUwppbmRleCBmZmFhNjIxNjdmNmUuLmUzNmVh
NDI2OGJkMiAxMDA2NDQKLS0tIGEvYXJjaC94ODYveGVuL3hlbi1oZWFkLlMKKysrIGIvYXJj
aC94ODYveGVuL3hlbi1oZWFkLlMKQEAgLTc2LDYgKzc2LDEzIEBAIFNZTV9DT0RFX1NUQVJU
KGFzbV9jcHVfYnJpbmd1cF9hbmRfaWRsZSkKIAogCWNhbGwgY3B1X2JyaW5ndXBfYW5kX2lk
bGUKIFNZTV9DT0RFX0VORChhc21fY3B1X2JyaW5ndXBfYW5kX2lkbGUpCisKK1NZTV9DT0RF
X1NUQVJUKHhlbl9jcHVfYnJpbmd1cF9hZ2FpbikKKwlVTldJTkRfSElOVF9GVU5DCisJbW92
CSVyZGksICVyc3AKKwlVTldJTkRfSElOVF9SRUdTCisJY2FsbAljcHVfYnJpbmd1cF9hbmRf
aWRsZQorU1lNX0NPREVfRU5EKHhlbl9jcHVfYnJpbmd1cF9hZ2FpbikKIC5wb3BzZWN0aW9u
CiAjZW5kaWYKICNlbmRpZgotLSAKMi4zNS4zCgo=
--------------EeNKth1XtNH0IGGGy8q3zBtC
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------EeNKth1XtNH0IGGGy8q3zBtC--

--------------0IclpDUqLeC6ZzwUmVegATIk--

--------------eljA8Dt0yylIHwiYAZnuZFCA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/IaMFAwAAAAAACgkQsN6d1ii/Ey+r
swf/T9WKJWbux7ecy27njG8CCPiHBw+2eSS7C9o30PZ/EUs/cqGWcjnsZfo7D6dqhudFoucaqi72
KGFhDy9nw7iYJh1mnGMi5k4riT9OBljSUdeSSMEUaAUCu8l9Q3x213hMxbm6uAYilGOuiLXrtFKY
AEWWXTtzpjE10Kfi4DVNEKbJzKEFiG+gd/f1MGMhyLJHNH1El6asJPTtiVlBa8rpORlZ1cGonsWH
fz+nScpHxDYKNEK9cdnow4CirwdoZ9mi5JcFFrjc4ZGrE6c//2WkfAF9YVeKNKS9L7nOi/oHBqKi
2B/yVGyaf5cN8Nr21cJjjYo4J7/hIAI3eLXZQj/GeQ==
=LCcO
-----END PGP SIGNATURE-----

--------------eljA8Dt0yylIHwiYAZnuZFCA--
