Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2C63837F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKYFaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:30:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C02BB20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 21:30:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 264761FD75;
        Fri, 25 Nov 2022 05:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669354236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88uKl92ebkgW4xCfynUJfJUKnkrtYfGljU1DfjG9VQg=;
        b=gNQhFWS9haTEh+HmH6jPevmBycsdYIiFCyyZGGwAriCT/BN40ORV440WmJ/gudbMIlVlln
        bzDpqqeeuaqaOlu66XlMLnr0f72brPPpbWCxK7oKNeHh9nT6Q5GdnDHXjLY7OvC/qdhWm9
        t2kM9owU64e2UTc2LgqAbZ1/n/qqzpI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE9413A12;
        Fri, 25 Nov 2022 05:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TXt7MPtSgGMbWAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Nov 2022 05:30:35 +0000
Message-ID: <d047c478-d905-7022-0caa-c9b7b0780823@suse.com>
Date:   Fri, 25 Nov 2022 06:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: objtool warning for next-20221118
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
 <20221124023934.nft3udxelth4lvai@treble>
 <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
 <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
 <20221124163928.dof5ldfer6rswlnx@treble>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221124163928.dof5ldfer6rswlnx@treble>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hAyibYhyr4A7ecLZFcdKC0Nj"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hAyibYhyr4A7ecLZFcdKC0Nj
Content-Type: multipart/mixed; boundary="------------sgBAI0d3A9g4VqHeAPIzWML0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Thomas Gleixner <tglx@linutronix.de>
Message-ID: <d047c478-d905-7022-0caa-c9b7b0780823@suse.com>
Subject: Re: objtool warning for next-20221118
References: <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
 <20221124023934.nft3udxelth4lvai@treble>
 <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
 <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
 <20221124163928.dof5ldfer6rswlnx@treble>
In-Reply-To: <20221124163928.dof5ldfer6rswlnx@treble>

--------------sgBAI0d3A9g4VqHeAPIzWML0
Content-Type: multipart/mixed; boundary="------------sqdMXuE7w70eh96fVGaMpLu3"

--------------sqdMXuE7w70eh96fVGaMpLu3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMTc6MzksIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiBPbiBUaHUsIE5v
diAyNCwgMjAyMiBhdCAwODo0Nzo0N0FNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4+PiArKysgYi9hcmNoL3g4Ni94ZW4vc21wX3B2LmMNCj4+Pj4gQEAgLTM4NSwxNyArMzg1
LDkgQEAgc3RhdGljIHZvaWQgeGVuX3B2X3BsYXlfZGVhZCh2b2lkKSAvKiB1c2VkIG9ubHkN
Cj4+Pj4gd2l0aCBIT1RQTFVHX0NQVSAqLw0KPj4+PiAgwqAgew0KPj4+PiAgwqDCoMKgwqDC
oCBwbGF5X2RlYWRfY29tbW9uKCk7DQo+Pj4+ICDCoMKgwqDCoMKgIEhZUEVSVklTT1JfdmNw
dV9vcChWQ1BVT1BfZG93biwgeGVuX3ZjcHVfbnIoc21wX3Byb2Nlc3Nvcl9pZCgpKSwgTlVM
TCk7DQo+Pj4+IC3CoMKgwqAgY3B1X2JyaW5ndXAoKTsNCj4+Pj4gLcKgwqDCoCAvKg0KPj4+
PiAtwqDCoMKgwqAgKiBjb21taXQgNGIwYzBmMjk0ICh0aWNrOiBDbGVhbnVwIE5PSFogcGVy
IGNwdSBkYXRhIG9uIGNwdSBkb3duKQ0KPj4+PiAtwqDCoMKgwqAgKiBjbGVhcnMgY2VydGFp
biBkYXRhIHRoYXQgdGhlIGNwdV9pZGxlIGxvb3AgKHdoaWNoIGNhbGxlZCB1cw0KPj4+PiAt
wqDCoMKgwqAgKiBhbmQgdGhhdCB3ZSByZXR1cm4gZnJvbSkgZXhwZWN0cy4gVGhlIG9ubHkg
d2F5IHRvIGdldCB0aGF0DQo+Pj4+IC3CoMKgwqDCoCAqIGRhdGEgYmFjayBpcyB0byBjYWxs
Og0KPj4+PiAtwqDCoMKgwqAgKi8NCj4+Pj4gLcKgwqDCoCB0aWNrX25vaHpfaWRsZV9lbnRl
cigpOw0KPj4+PiAtwqDCoMKgIHRpY2tfbm9oel9pZGxlX3N0b3BfdGlja19wcm90ZWN0ZWQo
KTsNCj4+Pj4gLcKgwqDCoCBjcHVocF9vbmxpbmVfaWRsZShDUFVIUF9BUF9PTkxJTkVfSURM
RSk7DQo+Pj4+ICvCoMKgwqAgLyogRklYTUU6IGNvbnZlcmdlIGNwdV9icmluZ3VwX2FuZF9p
ZGxlKCkgYW5kIHN0YXJ0X3NlY29uZGFyeSgpICovDQo+Pj4+ICvCoMKgwqAgY3B1X2JyaW5n
dXBfYW5kX2lkbGUoKTsNCj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyB3aWxsIGxlYWsgc3RhY2sg
bWVtb3J5LiBNdWx0aXBsZSBjcHUgb2ZmbGluZS9vbmxpbmUgY3ljbGVzIG9mDQo+Pj4gdGhl
IHNhbWUgY3B1IHdpbGwgZmluYWxseSBleGhhdXN0IHRoZSBpZGxlIHN0YWNrLg0KPiANCj4g
RG9oISAgT2YgY291cnNlLi4uDQo+IA0KPiBJIHdhcyBhY3R1YWxseSB0aGlua2luZyBhaGVh
ZCwgdG8gd2hlcmUgZXZlbnR1YWxseSB4ZW5fcHZfcGxheV9kZWFkKCkNCj4gY2FuIGNhbGwg
c3RhcnRfY3B1MCgpLCB3aGljaCBjYW4gYmUgY2hhbmdlZCB0byBhdXRvbWF0aWNhbGx5IHJl
c2V0IHRoZQ0KPiBzdGFjayBwb2ludGVyIGxpa2UgdGhpczoNCj4gDQo+IFNZTV9DT0RFX1NU
QVJUKHN0YXJ0X2NwdTApDQo+IAlBTk5PVEFURV9OT0VOREJSDQo+IAlVTldJTkRfSElOVF9F
TVBUWQ0KPiAJbW92cQlQRVJfQ1BVX1ZBUihwY3B1X2hvdCArIFg4Nl90b3Bfb2Zfc3RhY2sp
LCAlcmF4DQo+IAlsZWFxCS1QVFJFR1NfU0laRSglcmF4KSwgJXJzcA0KPiAJam1wCS5ManVt
cF90b19DX2NvZGUNCj4gU1lNX0NPREVfRU5EKHN0YXJ0X2NwdTApDQo+IA0KPiBidXQgdGhh
dCB3b3VsZCBvbmx5IGJlIHBvc3NpYmxlIGJlIGFmdGVyIG1vcmUgY2xlYW51cHMgd2hpY2gg
Y29udmVyZ2UNCj4gY3B1X2JyaW5ndXBfYW5kX2lkbGUoKSB3aXRoIHN0YXJ0X3NlY29uZGFy
eSgpLg0KPiANCj4+IFRoZSBhdHRhY2hlZCBwYXRjaCBzZWVtcyB0byB3b3JrIGZpbmUuDQo+
IA0KPiBUaGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEl0IGRvZXNuJ3Qgc29s
dmUgUGF1bCdzIG9yaWdpbmFsIGlzc3VlIHdoZXJlIGFyY2hfY3B1X2lkbGVfZGVhZCgpIG5l
ZWRzDQo+IHRvIGJlIF9fbm9yZXR1cm4uICBCdXQgdGhhdCBzaG91bGQgcHJvYmFibHkgYmUg
YSBzZXBhcmF0ZSBwYXRjaCBhbnl3YXkuDQoNCk9rYXksIEknbGwgc3BsaXQgdGhpcyBvZmYu
DQoNCj4gDQo+PiBUaGUgX19ub3JldHVybiBhbm5vdGF0aW9uIHNlZW1zIHRvIHRyaWdnZXIg
YW4gb2JqdG9vbCB3YXJuaW5nLCB0aG91Z2gsIGluDQo+PiBzcGl0ZSBvZiB0aGUgYWRkZWQg
QlVHKCkgYXQgdGhlIGVuZCBvZiB4ZW5fcHZfcGxheV9kZWFkKCk6DQo+Pg0KPj4gYXJjaC94
ODYveGVuL3NtcF9wdi5vOiB3YXJuaW5nOiBvYmp0b29sOiB4ZW5fcHZfcGxheV9kZWFkKCkg
ZmFsbHMgdGhyb3VnaCB0bw0KPj4gbmV4dCBmdW5jdGlvbiB4ZW5fcHZfY3B1X2RpZSgpDQo+
IA0KPiBZb3UnbGwgbmVlZCB0byB0ZWxsIG9ianRvb2wgdGhhdCB4ZW5fY3B1X2JyaW5ndXBf
YWdhaW4oKSBpcyBub3JldHVybiBieQ0KPiBhZGRpbmcgInhlbl9jcHVfYnJpbmd1cF9hZ2Fp
biIgdG8gZ2xvYmFsX25vcmV0dXJuc1tdIGluDQo+IHRvb2xzL29ianRvb2wvY2hlY2suYy4N
Cg0KQWgsIG9rYXkuIFdpbGwgZG8gdGhhdC4NCg0KPiAoWWVzIGl0J3MgYSBwYWluLCBJJ2xs
IGJlIHdvcmtpbmcgYW4gaW1wcm92ZWQgc29sdXRpb24gdG8gdGhlIG5vcmV0dXJuDQo+IHRo
aW5nLi4uKQ0KDQpTaG91bGQgYmUgZmFpcmx5IGVhc3ksIG5vPw0KDQoiSnVzdCIgZXh0ZW5k
IHRoZSBfX25vcmV0dXJuIG1hY3JvIHRvIHB1dCB0aGUgZnVuY3Rpb24gaW50byBhICIudGV4
dC5ub3JldHVybiINCnNlY3Rpb24sIHdoaWNoIGNhbiBiZSBoYW5kbGVkIGluIGEgc3BlY2lh
bCB3YXkgYnkgb2JqdG9vbC4gVGhpcyB3b3VsZCBuZWVkDQphbiBfX2luaXRfbm9yZXR1cm4g
bWFjcm8sIG9mIGNvdXJzZSwgZm9yIGEgIi5pbml0LnRleHQubm9yZXR1cm4iIHNlY3Rpb24u
DQoNCg0KSnVlcmdlbg0K
--------------sqdMXuE7w70eh96fVGaMpLu3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------sqdMXuE7w70eh96fVGaMpLu3--

--------------sgBAI0d3A9g4VqHeAPIzWML0--

--------------hAyibYhyr4A7ecLZFcdKC0Nj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOAUvsFAwAAAAAACgkQsN6d1ii/Ey99
NQf7BmHH332gwhKhoHMmyH2fJlV2mW4kUysbTkREGK8MH5oXtlQqrDZ2fcUXajJg6v32QZvYPWoY
d07a9Rsng2/dnajCUy7sHzlz25ZDTE4ICoRVlim8wWkp7bB70QOp4+PfZhq44cmzhm4k64QBl2NL
nhRs4aFFLm6OadniJsaLt+Q+TC5yagRW/hVz5q6/vrcusx67jSpgMdHVULZUlXD+nkfynpK/hn1B
PfeMLqsa98kqvCWRq/9MtnEZwznpgnK0nfIRb/JxXGTxlOHs+dmnZVtwnPzzWUJ9m0dr8QgiJxOq
/3iDS2KMouZwD07YYxtCnPEJwhNHpuRTZKjDKLbdpw==
=/tpz
-----END PGP SIGNATURE-----

--------------hAyibYhyr4A7ecLZFcdKC0Nj--
