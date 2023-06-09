Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0F729B46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjFINP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbjFINP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:15:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276130F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:15:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7A91FDF3;
        Fri,  9 Jun 2023 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686316548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo4cl1WAqmybln6WLAf5iaMaSZ3/6pIFafYp/P84fXQ=;
        b=NjHXkgiI4CQeWO5uSSZ6zaXykMG+1bBCBHV0fT42czfctMKbc0y4NEV4vOWk5oeQOSzwhI
        mX0SGL2nrveba4HuIkpl9KLsNzZX8SvQ32DQlZgX5eO8nZK81xeFs6mwcix1jwtsGAeZmo
        ME2NiytyyZr5fEyvDKgt6t9zDNa4VY4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 372E013A47;
        Fri,  9 Jun 2023 13:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u1z+CwQmg2QkUgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 13:15:48 +0000
Message-ID: <4f9b820e-4f6b-0547-6422-16a863435604@suse.com>
Date:   Fri, 9 Jun 2023 15:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] x86/mm: Fix PAT bit missing from page protection
 modify mask
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20230609130140.182781-2-janusz.krzysztofik@linux.intel.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230609130140.182781-2-janusz.krzysztofik@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f0Jyu9YOJsOJQgEzdLNf0MFE"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f0Jyu9YOJsOJQgEzdLNf0MFE
Content-Type: multipart/mixed; boundary="------------y20Gc09UE3OiN5pMc4DCC0Bv";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <4f9b820e-4f6b-0547-6422-16a863435604@suse.com>
Subject: Re: [PATCH v3] x86/mm: Fix PAT bit missing from page protection
 modify mask
References: <20230609130140.182781-2-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230609130140.182781-2-janusz.krzysztofik@linux.intel.com>

--------------y20Gc09UE3OiN5pMc4DCC0Bv
Content-Type: multipart/mixed; boundary="------------1DoquptYreU3XTkw7uD0Ps6l"

--------------1DoquptYreU3XTkw7uD0Ps6l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDYuMjMgMTU6MDEsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90ZToNCj4gVmlzaWJs
ZSBnbGl0Y2hlcyBoYXZlIGJlZW4gb2JzZXJ2ZWQgd2hlbiBydW5uaW5nIGdyYXBoaWNzIGFw
cGxpY2F0aW9ucyBvbg0KPiBMaW51eCB1bmRlciBYZW4gaHlwZXJ2aXNvci4gIFRob3NlIG9i
c2VydmF0aW9ucyBoYXZlIGJlZW4gY29uZmlybWVkIHdpdGgNCj4gZmFpbHVyZXMgZnJvbSBr
bXNfcHdyaXRlX2NyYyBJbnRlbCBHUFUgdGVzdCB0aGF0IHZlcmlmaWVzIGRhdGEgY29oZXJl
bmN5DQo+IG9mIERSTSBmcmFtZSBidWZmZXIgb2JqZWN0cyB1c2luZyBoYXJkd2FyZSBDUkMg
Y2hlY2tzdW1zIGNhbGN1bGF0ZWQgYnkNCj4gZGlzcGxheSBjb250cm9sbGVycywgZXhwb3Nl
ZCB0byB1c2Vyc3BhY2UgdmlhIGRlYnVnZnMuICBBZmZlY3RlZA0KPiBwcm9jZXNzaW5nIHBh
dGhzIGhhdmUgdGhlbiBiZWVuIGlkZW50aWZpZWQgd2l0aCBuZXcgSUdUIHRlc3QgdmFyaWFu
dHMgdGhhdA0KPiBtbWFwIHRoZSBvYmplY3RzIHVzaW5nIGRpZmZlcmVudCBtZXRob2RzIGFu
ZCBjYWNoaW5nIG1vZGVzIFsxXS4NCj4gDQo+IFdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBn
dWVzdCwgTGludXggdXNlcyBYZW4gcHJvdmlkZWQgUEFUIGNvbmZpZ3VyYXRpb24NCj4gd2hp
Y2ggaXMgZGlmZmVyZW50IGZyb20gaXRzIG5hdGl2ZSBvbmUuICBJbiBwYXJ0aWN1bGFyLCBY
ZW4gc3BlY2lmaWMgUFRFDQo+IGVuY29kaW5nIG9mIHdyaXRlLWNvbWJpbmluZyBjYWNoaW5n
LCBsaWtlbHkgdXNlZCBieSBncmFwaGljcyBhcHBsaWNhdGlvbnMsDQo+IGRpZmZlcnMgZnJv
bSB0aGUgTGludXggZGVmYXVsdCBvbmUgZm91bmQgYW1vbmcgc3RhdGljYWxseSBkZWZpbmVk
IG1pbmltYWwNCj4gc2V0IG9mIHN1cHBvcnRlZCBtb2Rlcy4gIFNpbmNlIFhlbiBkZWZpbmVz
IFBURSBlbmNvZGluZyBvZiB0aGUgV0MgbW9kZSBhcw0KPiBfUEFHRV9QQVQsIGl0IG5vIGxv
bmdlciBiZWxvbmdzIHRvIHRoZSBtaW5pbWFsIHNldCwgZGVwZW5kcyBvbiBjb3JyZWN0DQo+
IGhhbmRsaW5nIG9mIF9QQUdFX1BBVCBiaXQsIGFuZCBjYW4gYmUgbWlzbWF0Y2hlZCB3aXRo
IHdyaXRlLWJhY2sgY2FjaGluZy4NCj4gDQo+IFdoZW4gYSB1c2VyIGNhbGxzIG1tYXAoKSBm
b3IgYSBEUk0gYnVmZmVyIG9iamVjdCwgRFJNIGRldmljZSBzcGVjaWZpYw0KPiAubW1hcCBm
aWxlIG9wZXJhdGlvbiwgY2FsbGVkIGZyb20gbW1hcF9yZWdpb24oKSwgdGFrZXMgY2FyZSBv
ZiBzZXR0aW5nIFBURQ0KPiBlbmNvZGluZyBiaXRzIGluIGEgdm1fcGFnZV9wcm90IGZpZWxk
IG9mIGFuIGFzc29jaWF0ZWQgdmlydHVhbCBtZW1vcnkgYXJlYQ0KPiBzdHJ1Y3R1cmUuICBV
bmZvcnR1bmF0ZWx5LCBfUEFHRV9QQVQgYml0IGlzIG5vdCBwcmVzZXJ2ZWQgd2hlbiB0aGUg
dm1hJ3MNCj4gLnZtX2ZsYWdzIGFyZSB0aGVuIGFwcGxpZWQgdG8gLnZtX3BhZ2VfcHJvdCB2
aWEgdm1fc2V0X3BhZ2VfcHJvdCgpLiAgQml0cw0KPiB0byBiZSBwcmVzZXJ2ZWQgYXJlIGRl
dGVybWluZWQgd2l0aCBfUEFHRV9DSEdfTUFTSyBzeW1ib2wgdGhhdCBkb2Vzbid0DQo+IGNv
dmVyIF9QQUdFX1BBVC4gIEFzIGEgY29uc2VxdWVuY2UsIFdCIGNhY2hpbmcgaXMgcmVxdWVz
dGVkIGluc3RlYWQgb2YgV0MNCj4gd2hlbiBydW5uaW5nIHVuZGVyIFhlbiAoYWxzbywgV1Ag
aXMgc2lsZW50bHkgY2hhbmdlZCB0byBXVCwgYW5kIFVDDQo+IGRvd25ncmFkZWQgdG8gVUNf
TUlOVVMpLiAgV2hlbiBydW5uaW5nIG9uIGJhcmUgbWV0YWwsIFdDIGlzIG5vdCBhZmZlY3Rl
ZCwNCj4gYnV0IFdQIGFuZCBXVCBleHRyYSBtb2RlcyBhcmUgdW5pbnRlbnRpb25hbGx5IHJl
cGxhY2VkIHdpdGggV0MgYW5kIFVDLA0KPiByZXNwZWN0aXZlbHkuDQo+IA0KPiBXUCBhbmQg
V1QgbW9kZXMsIGVuY29kZWQgd2l0aCBfUEFHRV9QQVQgYml0IHNldCwgd2VyZSBpbnRyb2R1
Y2VkIGJ5IGNvbW1pdA0KPiAyODFkNDA3OGJlYzMgKCJ4ODY6IE1ha2UgcGFnZSBjYWNoZSBt
b2RlIGEgcmVhbCB0eXBlIikuICBDYXJlIHdhcyB0YWtlbg0KPiB0byBleHRlbmQgX1BBR0Vf
Q0FDSEVfTUFTSyBzeW1ib2wgd2l0aCB0aGF0IGFkZGl0aW9uYWwgYml0LCBidXQgdGhhdA0K
PiBzeW1ib2wgaGFzIG5ldmVyIGJlZW4gdXNlZCBmb3IgaWRlbnRpZmljYXRpb24gb2YgYml0
cyBwcmVzZXJ2ZWQgd2hlbg0KPiBhcHBseWluZyBwYWdlIHByb3RlY3Rpb24gZmxhZ3MuICBT
dXBwb3J0IGZvciBhbGwgY2FjaGUgbW9kZXMgdW5kZXIgWGVuLA0KPiBpbmNsdWRpbmcgdGhl
IHByb2JsZW1hdGljIFdDIG1vZGUsIHdhcyB0aGVuIGludHJvZHVjZWQgYnkgY29tbWl0DQo+
IDQ3NTkxZGY1MDUxMiAoInhlbjogU3VwcG9ydCBYZW4gcHYtZG9tYWlucyB1c2luZyBQQVQi
KS4NCj4gDQo+IFRoZSBpc3N1ZSBuZWVkcyB0byBiZSBmaXhlZCBieSBpbmNsdWRpbmcgX1BB
R0VfUEFUIGJpdCBpbnRvIGEgYml0bWFzayB1c2VkDQo+IGJ5IHBncHJvdF9tb2RpZnkoKSBm
b3Igc2VsZWN0aW5nIGJpdHMgdG8gYmUgcHJlc2VydmVkLiAgV2UgY2FuIGRvIHRoYXQNCj4g
ZWl0aGVyIGludGVybmFsbHkgdG8gcGdwcm90X21vZGlmeSgpIChhcyBpbml0aWFsbHkgcHJv
cG9zZWQpLCBvciBieSBtYWtpbmcNCj4gX1BBR0VfUEFUIGEgcGFydCBvZiBfUEFHRV9DSEdf
TUFTSy4gIElmIHdlIGdvIGZvciB0aGUgbGF0dGVyIHRoZW4sIHNpbmNlDQo+IF9QQUdFX1BB
VCBpcyB0aGUgc2FtZSBhcyBfUEFHRV9QU0UsIHdlIG5lZWQgdG8gbm90ZSB0aGF0IF9IUEFH
RV9DSEdfTUFTSw0KPiAtLSBhIGh1Z2UgcG1kcycgY291bnRlcnBhcnQgb2YgX1BBR0VfQ0hH
X01BU0ssIGludHJvZHVjZWQgYnkgY29tbWl0DQo+IGM0ODlmMTI1N2I4YyAoInRocDogYWRk
IHBtZF9tb2RpZnkiKSwgZGVmaW5lZCBhcyAoX1BBR0VfQ0hHX01BU0sgfA0KPiBfUEFHRV9Q
U0UpIC0tIHdpbGwgbm8gbG9uZ2VyIGRpZmZlciBmcm9tIF9QQUdFX0NIR19NQVNLLiAgSWYg
c3VjaA0KPiBtb2RpZmljYXRpb24gb2YgX1BBR0VfQ0hHX01BU0sgd2FzIGlycmVsZXZhbnQg
dG8gaXRzIHVzZXJzIHRoZW4gb25lIG1pZ2h0DQo+IHdvbmRlciB3aHkgdGhhdCBuZXcgX0hQ
QUdFX0NIR19NQVNLIHN5bWJvbCB3YXMgaW50cm9kdWNlZCBpbnN0ZWFkIG9mDQo+IHJldXNp
bmcgdGhlIGV4aXN0aW5nIG9uZSB3aXRoIHRoYXQgb3RoZXJ3aXNlIGlycmVsZXZhbnQgYml0
IChfUEFHRV9QU0UgaW4NCj4gdGhhdCBjYXNlKSBhZGRlZC4NCj4gDQo+IEFzc3VtZSB0aGF0
IGFkZGluZyBfUEFHRV9QQVQgdG8gX1BBR0VfQ0hHX01BU0sgZG9lc24ndCBicmVhayBwdGVf
bW9kaWZ5KCkNCj4gYW5kIGl0cyB1c2VycywgYW5kIGdvIGZvciBpdC4gIEFsc28sIGFkZCBf
UEFHRV9QQVRfTEFSR0UgdG8NCj4gX0hQQUdFX0NIR19NQVNLIGZvciBzeW1tZXRyeS4gIEZv
ciBiZXR0ZXIgY2xhcml0eSwgc3BsaXQgb3V0IGNvbW1vbiBiaXRzDQo+IGZyb20gYm90aCBz
eW1ib2xzIHRvIGFub3RoZXIgb25lIGFuZCB1c2UgaXQgdG9nZXRoZXIgd2l0aCBzcGVjaWZp
YyBiaXRzDQo+IHdoZW4gZGVmaW5pbmcgdGhlIG1hc2tzLg0KPiANCj4gdjM6IFNlcGFyYXRl
IG91dCBjb21tb24gYml0cyBvZiBfUEFHRV9DSEdfTUFTSyBhbmQgX0hQQUdFX0NIR19NQVNL
IGludG8NCj4gICAgICBfQ09NTU9OX1BBR0VfQ0hHX01BU0sgKFJpY2spLA0KPiAgICAtIGZp
eCBoYXJkIHRvIHBhcnNlIHdvcmRpbmcgb2YgJ3doYXQnIHBhcnQgb2YgY29tbWl0IGRlc2Ny
aXB0aW9uIChvbg0KPiAgICAgIERhdmUncyByZXF1ZXN0KS4NCj4gdjI6IEtlZXAgcGdwcm90
X21vZGlmeSgpIHVudG91Y2hlZCwgbWFrZSBfUEFHRV9QQVQgcGFydCBvZiBfUEFHRV9DSEdf
TUFTSw0KPiAgICAgIGluc3RlYWQgKEJvcmlzbGF2KSwNCj4gICAgLSBhbHNvIGFkZCBfUEFH
RV9QQVRfTEFSR0UgdG8gX0hQQUdFX0NIR19NQVNLIChKdWVyZ2VuKS4NCj4gDQo+IFsxXSBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2lndC1ncHUtdG9vbHMvLS9jb21t
aXQvMGYwNzU0NDEzZjE0DQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy9kcm0vaW50ZWwvLS9pc3N1ZXMvNzY0OA0KPiBGaXhlczogMjgxZDQwNzhiZWMz
ICgieDg2OiBNYWtlIHBhZ2UgY2FjaGUgbW9kZSBhIHJlYWwgdHlwZSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IEphbnVzeiBLcnp5c3p0b2ZpayA8amFudXN6LmtyenlzenRvZmlrQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gVGVzdGVkLWJ5OiBNYXJlayBNYXJjenlrb3dza2ktR8OzcmVja2kgPG1h
cm1hcmVrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmRpIFNo
eXRpIDxhbmRpLnNoeXRpQGxpbnV4LmludGVsLmNvbT4NCj4gQWNrZWQtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gIyB2MQ0KPiBDYzogQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+DQo+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29t
Pg0KPiBDYzogIkVkZ2Vjb21iZSwgUmljayBQIiA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjMuMTkrDQoNClJldmlld2Vk
LWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0KDQo=

--------------1DoquptYreU3XTkw7uD0Ps6l
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1DoquptYreU3XTkw7uD0Ps6l--

--------------y20Gc09UE3OiN5pMc4DCC0Bv--

--------------f0Jyu9YOJsOJQgEzdLNf0MFE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSDJgMFAwAAAAAACgkQsN6d1ii/Ey8l
cggAgiU5NRc9SSU8E4eys2nUYYyaDRXpsyUVMLUF9nn8VGXYQaoDto563gf0rLj4Wrh59Dsz5BpH
WEtGAMJJkMGN5eX7ED52ryg73g5M3sJsBx4eumJfU6x3OWOJctSvlGf7S/K2BJ5nHvHdcpngYetR
SFAqmzXJfC1LZKLpBINK4wreJX3g3S50+i3UOX0eKcGWpYarBs/w31cqvaFDeP9UXuMJ/GJHdsE6
wBHXPP3qSzR7lxaR+v8BaUHkEHLJF8BqumyoICkocmuBAtWjlZ3Z01z8DzRpDrPwaz84LKToWAGk
ChdD/2/igaRAY3v0b8MFA/dugly3klNQnNdeUnZCsw==
=3+6Q
-----END PGP SIGNATURE-----

--------------f0Jyu9YOJsOJQgEzdLNf0MFE--
