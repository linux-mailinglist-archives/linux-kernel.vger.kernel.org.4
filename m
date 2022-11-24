Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB36371C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXF2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXF2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:28:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35205A5706
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:28:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 702EF1F8C3;
        Thu, 24 Nov 2022 05:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669267711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHC3QMVP2dsqBrw+ffIbZT5m5877WUh37XjX0QWQ5ak=;
        b=rO+c9lmCpMOtGtw+7P0W46Re0QQROu30ukdbJCu9QWj92N2f1wqh9tqm4vPWCqPd0XM05n
        od7qh9g0hr3vuAoWUwbauto9ZI+1eOa7AdEoby/aqwrSAGB4+LEPoVSqznpp1zdXynfymx
        bndPhxCnaLPWFSh17P+TRTDPKp3UzWE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 236D213A8C;
        Thu, 24 Nov 2022 05:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2XE6B/8Af2MQHQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 05:28:31 +0000
Message-ID: <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
Date:   Thu, 24 Nov 2022 06:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: objtool warning for next-20221118
Content-Language: en-US
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
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221124023934.nft3udxelth4lvai@treble>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J91HyX3d0HxaiX4d5iHQildw"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------J91HyX3d0HxaiX4d5iHQildw
Content-Type: multipart/mixed; boundary="------------Yb0O9WWgPtOpttubFCw3SqPU";
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
Message-ID: <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
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
In-Reply-To: <20221124023934.nft3udxelth4lvai@treble>

--------------Yb0O9WWgPtOpttubFCw3SqPU
Content-Type: multipart/mixed; boundary="------------m558gBsABmONjLYeX9VRc305"

--------------m558gBsABmONjLYeX9VRc305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMDM6MzksIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiBPbiBXZWQsIE5v
diAyMywgMjAyMiBhdCAwOTowMzo0MEFNIC0wODAwLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToN
Cj4+IE9uIFdlZCwgTm92IDIzLCAyMDIyIGF0IDEwOjUyOjA5QU0gKzAwMDAsIEFuZHJldyBD
b29wZXIgd3JvdGU6DQo+Pj4+IFdlbGwsIGlmIHlvdSByZXR1cm4gZnJvbSBhcmNoX2NwdV9p
ZGxlX2RlYWQoKSB5b3UncmUgYmFjayBpbiB0aGUgaWRsZQ0KPj4+PiBsb29wIC0tIGV4YWN0
bHkgd2hlcmUgeW91IHdvdWxkIGJlIGlmIHlvdSB3ZXJlIHRvIGJvb3RzdHJhcCB0aGUgd2hv
bGUNCj4+Pj4gQ1BVIC0tIHByb3ZpZGVkIHlvdSBoYXZlIGl0IHJlbWVtYmVyIHRoZSB3aG9s
ZSBzdGF0ZSAoZWFzaWVyIHdpdGggYQ0KPj4+PiB2Q1BVKS4NCj4+DQo+PiBwbGF5X2RlYWQo
KSByZWFsbHkgbmVlZHMgc2FuZSBzZW1hbnRpY3MuICBOb3Qgb25seSBkb2VzIGl0IGludHJv
ZHVjZSBhDQo+PiBzdXJwcmlzZSB0byB0aGUgb2ZmbGluaW5nIGNvZGUgaW4gZG9faWRsZSgp
LCBpdCBhbHNvIHNraXBzIHRoZSBlbnRpcmUNCj4+IGhvdHBsdWcgc3RhdGUgbWFjaGluZS4g
IE5vdCBzdXJlIGlmIHRoYXQgaW50cm9kdWNlcyBhbnkgYnVncywgYnV0IGF0IHRoZQ0KPj4g
dmVyeSBsZWFzdCBpdCdzIHN1YnRsZSBhbmQgc3VycHJpc2luZy4NCj4+DQo+Pj4+IEJ1dCBt
YXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmcsIGxldHMgYWRkIFhlbiBmb2xrcyBvbi4NCj4+
Pg0KPj4+IENhbGxpbmcgVkNQVU9QX2Rvd24gb24gb25lc2VsZiBhbHdheXMgc3VjY2VlZHMs
IGJ1dCBhbGwgaXQgZG9lcyBpcw0KPj4+IGRlc2NoZWR1bGUgdGhlIHZDUFUuDQo+Pj4NCj4+
PiBJdCBjYW4gYmUgdW5kb25lIGF0IGEgbGF0ZXIgcG9pbnQgYnkgYSBkaWZmZXJlbnQgdmNw
dSBpc3N1aW5nIFZDUFVPUF91cA0KPj4+IGFnYWluc3QgdGhlIHByZXZpb3VzbHktZG93bmVk
IENQVSwgYXQgd2hpY2ggcG9pbnQgdGhlIHZDUFUgZ2V0cyByZXNjaGVkdWxlZC4NCj4+Pg0K
Pj4+IFRoaXMgaXMgd2h5IHRoZSBWQ1BVT1BfZG93biBoeXBlcmNhbGwgcmV0dXJucyBub3Jt
YWxseS7CoCBBbGwgc3RhdGUNCj4+PiByZWFsbHkgaXMgaW50YWN0Lg0KPj4+DQo+Pj4gQXMg
Zm9yIHdoYXQgTGludXggZG9lcywgdGhpcyBpcyBob3cgeGVuX3B2X2NwdV91cCgpIGN1cnJl
bnRseSBiZWhhdmVzLg0KPj4+IElmIHlvdSB3YW50IHRvIG1ha2UgWGVuIGJlaGF2ZSBtb3Jl
IGV2ZXJ5dGhpbmcgZWxzZSwgdGhlbiBidWcgYSBCVUcoKQ0KPj4+IGFmdGVyIFZDUFVPUF9k
b3duLCBhbmQgYWRqdXN0IHhlbl9wdl9jcHVfdXAoKSB0byBza2lwIGl0cyBpbml0aWFsaXNl
ZA0KPj4+IGNoZWNrIGFuZCBhbHdheXMgdXNlIFZDUFVPUF9pbml0aWFsaXNlIHRvIGJyaW5n
IHRoZSB2Q1BVIGJhY2sgb25saW5lLg0KPj4NCj4+IE9yIHdlIGNvdWxkIGRvIHdoYXQgc2V2
X2VzX3BsYXlfZGVhZCgpIGRvZXMgYW5kIGp1c3QgY2FsbCBzdGFydF9jcHUwKCkNCj4+IGFm
dGVyIHRoZSBoeXBlcmNhbGwgcmV0dXJucz8NCj4gDQo+IFNvbWV0aGluZyBsaWtlIHNvICh1
bnRlc3RlZCkuICBUaGlzIGlzIG9ubHkgdGhlIHg4NiBiaXRzLg0KPiANCj4gSSB0aGluayBJ
IGNvbnZpbmNlZCBteXNlbGYgdGhhdCBzdGFydF9jcHUwKCkgaXNuJ3QgYnVnZ3kuICBJJ20g
bG9va2luZw0KPiBhdCBvdGhlciBjbGVhbnVwcywgZS5nLiBjb252ZXJnaW5nIGNwdV9icmlu
Z3VwX2FuZF9pZGxlKCkgd2l0aA0KPiBzdGFydF9zZWNvbmRhcnkoKS4NCj4gDQo+IEkgY2Fu
IHBpY2sgaXQgdXAgYWdhaW4gbmV4dCB3ZWVrLCBwb3N0LXR1cmtleS4NCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zbXAuaCBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NtcC5oDQo+IGluZGV4IGI0ZGJiMjBkYWIxYS4uZTZkMWQyODEwZTM4IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zbXAuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9zbXAuaA0KPiBAQCAtOTMsOSArOTMsMTAgQEAgc3RhdGljIGlubGluZSB2
b2lkIF9fY3B1X2RpZSh1bnNpZ25lZCBpbnQgY3B1KQ0KPiAgIAlzbXBfb3BzLmNwdV9kaWUo
Y3B1KTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgcGxheV9kZWFkKHZv
aWQpDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19ub3JldHVybiBwbGF5X2RlYWQodm9pZCkN
Cj4gICB7DQo+ICAgCXNtcF9vcHMucGxheV9kZWFkKCk7DQo+ICsJQlVHKCk7DQo+ICAgfQ0K
PiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBzbXBfc2VuZF9yZXNjaGVkdWxlKGludCBj
cHUpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC94
ODYva2VybmVsL3Byb2Nlc3MuYw0KPiBpbmRleCAyNmU4ZjU3Yzc1YWQuLjhlMjg0MWRlYjFl
YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYw0KPiArKysgYi9h
cmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+IEBAIC03MDAsNyArNzAwLDcgQEAgRVhQT1JU
X1NZTUJPTChib290X29wdGlvbl9pZGxlX292ZXJyaWRlKTsNCj4gICBzdGF0aWMgdm9pZCAo
Kng4Nl9pZGxlKSh2b2lkKTsNCj4gICANCj4gICAjaWZuZGVmIENPTkZJR19TTVANCj4gLXN0
YXRpYyBpbmxpbmUgdm9pZCBwbGF5X2RlYWQodm9pZCkNCj4gK3N0YXRpYyBpbmxpbmUgdm9p
ZCBfX25vcmV0dXJuIHBsYXlfZGVhZCh2b2lkKQ0KPiAgIHsNCj4gICAJQlVHKCk7DQo+ICAg
fQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYyBiL2FyY2gveDg2
L2tlcm5lbC9zbXBib290LmMNCj4gaW5kZXggNTVjYWQ3MjcxNWQ5Li5kOGIxMmFjMWE3YzUg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMNCj4gKysrIGIvYXJj
aC94ODYva2VybmVsL3NtcGJvb3QuYw0KPiBAQCAtMTgzMyw5ICsxODMzLDEyIEBAIHZvaWQg
bmF0aXZlX3BsYXlfZGVhZCh2b2lkKQ0KPiAgIAlwbGF5X2RlYWRfY29tbW9uKCk7DQo+ICAg
CXRib290X3NodXRkb3duKFRCX1NIVVRET1dOX1dGUyk7DQo+ICAgDQo+IC0JbXdhaXRfcGxh
eV9kZWFkKCk7CS8qIE9ubHkgcmV0dXJucyBvbiBmYWlsdXJlICovDQo+ICsJbXdhaXRfcGxh
eV9kZWFkKCk7CS8qIE9ubHkgcmV0dXJucyBpZiBtd2FpdCBpcyBub3Qgc3VwcG9ydGVkICov
DQo+ICsNCj4gICAJaWYgKGNwdWlkbGVfcGxheV9kZWFkKCkpDQo+ICAgCQlobHRfcGxheV9k
ZWFkKCk7DQo+ICsNCj4gKwlCVUcoKTsNCj4gICB9DQo+ICAgDQo+ICAgI2Vsc2UgLyogLi4u
ICFDT05GSUdfSE9UUExVR19DUFUgKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9z
bXBfcHYuYyBiL2FyY2gveDg2L3hlbi9zbXBfcHYuYw0KPiBpbmRleCA0ODBiZTgyZTliN2Iu
LjMwZGM5MDRjYTk5MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYveGVuL3NtcF9wdi5jDQo+
ICsrKyBiL2FyY2gveDg2L3hlbi9zbXBfcHYuYw0KPiBAQCAtMzg1LDE3ICszODUsOSBAQCBz
dGF0aWMgdm9pZCB4ZW5fcHZfcGxheV9kZWFkKHZvaWQpIC8qIHVzZWQgb25seSB3aXRoIEhP
VFBMVUdfQ1BVICovDQo+ICAgew0KPiAgIAlwbGF5X2RlYWRfY29tbW9uKCk7DQo+ICAgCUhZ
UEVSVklTT1JfdmNwdV9vcChWQ1BVT1BfZG93biwgeGVuX3ZjcHVfbnIoc21wX3Byb2Nlc3Nv
cl9pZCgpKSwgTlVMTCk7DQo+IC0JY3B1X2JyaW5ndXAoKTsNCj4gLQkvKg0KPiAtCSAqIGNv
bW1pdCA0YjBjMGYyOTQgKHRpY2s6IENsZWFudXAgTk9IWiBwZXIgY3B1IGRhdGEgb24gY3B1
IGRvd24pDQo+IC0JICogY2xlYXJzIGNlcnRhaW4gZGF0YSB0aGF0IHRoZSBjcHVfaWRsZSBs
b29wICh3aGljaCBjYWxsZWQgdXMNCj4gLQkgKiBhbmQgdGhhdCB3ZSByZXR1cm4gZnJvbSkg
ZXhwZWN0cy4gVGhlIG9ubHkgd2F5IHRvIGdldCB0aGF0DQo+IC0JICogZGF0YSBiYWNrIGlz
IHRvIGNhbGw6DQo+IC0JICovDQo+IC0JdGlja19ub2h6X2lkbGVfZW50ZXIoKTsNCj4gLQl0
aWNrX25vaHpfaWRsZV9zdG9wX3RpY2tfcHJvdGVjdGVkKCk7DQo+ICAgDQo+IC0JY3B1aHBf
b25saW5lX2lkbGUoQ1BVSFBfQVBfT05MSU5FX0lETEUpOw0KPiArCS8qIEZJWE1FOiBjb252
ZXJnZSBjcHVfYnJpbmd1cF9hbmRfaWRsZSgpIGFuZCBzdGFydF9zZWNvbmRhcnkoKSAqLw0K
PiArCWNwdV9icmluZ3VwX2FuZF9pZGxlKCk7DQoNCkkgdGhpbmsgdGhpcyB3aWxsIGxlYWsg
c3RhY2sgbWVtb3J5LiBNdWx0aXBsZSBjcHUgb2ZmbGluZS9vbmxpbmUgY3ljbGVzIG9mDQp0
aGUgc2FtZSBjcHUgd2lsbCBmaW5hbGx5IGV4aGF1c3QgdGhlIGlkbGUgc3RhY2suDQoNCg0K
SnVlcmdlbg0K
--------------m558gBsABmONjLYeX9VRc305
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------m558gBsABmONjLYeX9VRc305--

--------------Yb0O9WWgPtOpttubFCw3SqPU--

--------------J91HyX3d0HxaiX4d5iHQildw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/AP4FAwAAAAAACgkQsN6d1ii/Ey/Q
Nwf/bg+mAIdFoOngfKVrRQ7DSFDPz0mee5UTbQaYVLGutmhqzXxx4Bp/F5AvVxVkFxSZ89cvja+9
M82mcK9UuA4fqtzoXwePbViczV2DFgbPAQppnYxhNcUjHk4k6Z3BAzW73lDFbcXyxt+BXbQ40dRk
OyjvSvJlxg4gXdUXBDrq0SqG7PjGNANKmwckhWFSXeBYywb16AI/B8RjcKvUGoTDIolKzVaPzJge
9ZIOJ/cdWp0K3De/siTGfsw421vN+txLywhLOcLTaqkSNnqLyflC5SQH3airfZtTEWNec1Y4bSYf
WSSvNjil0Db2D5aO0z270VKWIHXGPLwQE/AjTdp9Mw==
=pgVv
-----END PGP SIGNATURE-----

--------------J91HyX3d0HxaiX4d5iHQildw--
