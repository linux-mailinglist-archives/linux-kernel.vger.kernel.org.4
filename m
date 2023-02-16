Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7340698BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPF2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBPF2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:28:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B420D2A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:27:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48B322257F;
        Thu, 16 Feb 2023 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676524938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIOZ/N5nOwuhTibyILzjvbJZm8qat8sJfBGAQpCb42M=;
        b=qCzBltD+C0Mvf5Maq7XHbTbWABDrPpy+kBZ2g6udTsLmbIpRyzDjsAz/3aDvkOcm4fBhV+
        KmeHJM62mZBTG0SP6Re57j00IO4xfiQKL0zKXCoFtjPIO0UEABfWSR3MOIq4dGynkQVzT0
        8OtMDOUbZMC92jikJQKTDBpf2XfxDGc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E222713A26;
        Thu, 16 Feb 2023 05:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vNbQNYm97WOESgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Feb 2023 05:22:17 +0000
Message-ID: <174040b7-1a9f-ce7b-e615-c5d1521bcebd@suse.com>
Date:   Thu, 16 Feb 2023 06:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
 <BYAPR21MB1688180BD889936A9B7CCDE3D7A39@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
In-Reply-To: <BYAPR21MB1688180BD889936A9B7CCDE3D7A39@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------thNoPqyxLkNWJPEWXBMIME0s"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------thNoPqyxLkNWJPEWXBMIME0s
Content-Type: multipart/mixed; boundary="------------eB0YCH0xyH5hu8RdsK4weN2A";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <174040b7-1a9f-ce7b-e615-c5d1521bcebd@suse.com>
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
 <BYAPR21MB1688180BD889936A9B7CCDE3D7A39@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688180BD889936A9B7CCDE3D7A39@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------eB0YCH0xyH5hu8RdsK4weN2A
Content-Type: multipart/mixed; boundary="------------6wpUHKpycslDI1AZFWgXjfSr"

--------------6wpUHKpycslDI1AZFWgXjfSr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDIuMjMgMjA6MzgsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSAxNSwgMjAyMyA1OjQwIEFNDQo+Pg0KPj4gT24gMTMuMDIuMjMgMDI6MDgsIE1p
Y2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+Pj4gRnJvbTogSnVlcmdlbiBHcm9zcyA8
amdyb3NzQHN1c2UuY29tPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDgsIDIwMjMgMTE6
MjINCj4+IFBNDQo+Pj4+DQo+Pj4+IFRvZGF5IHB1ZF9zZXRfaHVnZSgpIGFuZCBwbWRfc2V0
X2h1Z2UoKSB0ZXN0IGZvciB0aGUgTVRSUiB0eXBlIHRvIGJlDQo+Pj4+IFdCIG9yIElOVkFM
SUQgYWZ0ZXIgY2FsbGluZyBtdHJyX3R5cGVfbG9va3VwKCkuIFRob3NlIHRlc3RzIGNhbiBi
ZQ0KPj4+PiBkcm9wcGVkLCBhcyB0aGUgb25seSByZWFzb24gdG8gbm90IHVzZSBhIGxhcmdl
IG1hcHBpbmcgd291bGQgYmUNCj4+Pj4gdW5pZm9ybSBiZWluZyAwLiBBbnkgTVRSUiB0eXBl
IGNhbiBiZSBhY2NlcHRlZCBhcyBsb25nIGFzIGl0IGFwcGxpZXMNCj4+Pj4gdG8gdGhlIHdo
b2xlIG1lbW9yeSByYW5nZSBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nLCBhcyB0aGUgYWx0ZXJu
YXRpdmUNCj4+Pj4gd291bGQgb25seSBiZSB0byBtYXAgdGhlIHNhbWUgcmVnaW9uIHdpdGgg
c21hbGxlciBwYWdlcyBpbnN0ZWFkIHVzaW5nDQo+Pj4+IHRoZSBzYW1lIFBBVCB0eXBlIGFz
IGZvciB0aGUgbGFyZ2UgbWFwcGluZy4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICAgIGFyY2gveDg2L21tL3BndGFibGUuYyB8IDYgKystLS0tDQo+Pj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgYi9hcmNoL3g4Ni9tbS9wZ3Rh
YmxlLmMNCj4+Pj4gaW5kZXggZTRmNDk5ZWIwZjI5Li43YjljNTQ0M2QxNzYgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2FyY2gveDg2L21tL3BndGFibGUuYw0KPj4+PiArKysgYi9hcmNoL3g4Ni9t
bS9wZ3RhYmxlLmMNCj4+Pj4gQEAgLTcyMSw4ICs3MjEsNyBAQCBpbnQgcHVkX3NldF9odWdl
KHB1ZF90ICpwdWQsIHBoeXNfYWRkcl90IGFkZHIsIHBncHJvdF90DQo+PiBwcm90KQ0KPj4+
PiAgICAJdTggbXRyciwgdW5pZm9ybTsNCj4+Pj4NCj4+Pj4gICAgCW10cnIgPSBtdHJyX3R5
cGVfbG9va3VwKGFkZHIsIGFkZHIgKyBQVURfU0laRSwgJnVuaWZvcm0pOw0KPj4+PiAtCWlm
ICgobXRyciAhPSBNVFJSX1RZUEVfSU5WQUxJRCkgJiYgKCF1bmlmb3JtKSAmJg0KPj4+PiAt
CSAgICAobXRyciAhPSBNVFJSX1RZUEVfV1JCQUNLKSkNCj4+Pj4gKwlpZiAoIXVuaWZvcm0p
DQo+Pj4+ICAgIAkJcmV0dXJuIDA7DQo+Pj4+DQo+Pj4+ICAgIAkvKiBCYWlsIG91dCBpZiB3
ZSBhcmUgd2Ugb24gYSBwb3B1bGF0ZWQgbm9uLWxlYWYgZW50cnk6ICovDQo+Pj4+IEBAIC03
NDgsOCArNzQ3LDcgQEAgaW50IHBtZF9zZXRfaHVnZShwbWRfdCAqcG1kLCBwaHlzX2FkZHJf
dCBhZGRyLA0KPj4gcGdwcm90X3QgcHJvdCkNCj4+Pj4gICAgCXU4IG10cnIsIHVuaWZvcm07
DQo+Pj4+DQo+Pj4+ICAgIAltdHJyID0gbXRycl90eXBlX2xvb2t1cChhZGRyLCBhZGRyICsg
UE1EX1NJWkUsICZ1bmlmb3JtKTsNCj4+Pj4gLQlpZiAoKG10cnIgIT0gTVRSUl9UWVBFX0lO
VkFMSUQpICYmICghdW5pZm9ybSkgJiYNCj4+Pj4gLQkgICAgKG10cnIgIT0gTVRSUl9UWVBF
X1dSQkFDSykpIHsNCj4+Pj4gKwlpZiAoIXVuaWZvcm0pIHsNCj4+Pj4gICAgCQlwcl93YXJu
X29uY2UoIiVzOiBDYW5ub3Qgc2F0aXNmeSBbbWVtICUjMDEwbGx4LSUjMDEwbGx4XSB3aXRo
IGENCj4+IGh1Z2UtcGFnZSBtYXBwaW5nIGR1ZSB0byBNVFJSIG92ZXJyaWRlLlxuIiwNCj4+
Pj4gICAgCQkJICAgICBfX2Z1bmNfXywgYWRkciwgYWRkciArIFBNRF9TSVpFKTsNCj4+Pg0K
Pj4+IEknbSBzZWVpbmcgdGhpcyB3YXJuaW5nIHRyaWdnZXIgaW4gYSBub3JtYWwgSHlwZXIt
ViBndWVzdCAoaS5lLiwgKm5vdCogYW4NCj4+PiBTRVYtU05QIENvbmZpZGVudGlhbCBWTSku
ICBUaGUgb3JpZ2luYWwgZmlsdGVyaW5nIGhlcmUgYmFzZWQgb24NCj4+PiBNVFJSX1RZUEVf
V1JCQUNLIGFwcGVhcnMgdG8gYmUgaGlkaW5nIGEgYnVnIGluIG10cnJfdHlwZV9sb29rdXBf
dmFyaWFibGUoKQ0KPj4+IHdoZXJlIGl0IGluY29ycmVjdGx5IHRoaW5rcyBhbiBhZGRyZXNz
IHJhbmdlIG1hdGNoZXMgdHdvIGRpZmZlcmVudCB2YXJpYWJsZQ0KPj4+IE1UUlJzLCBhbmQg
aGVuY2UgY2xlYXJzICJ1bmlmb3JtIi4NCj4+Pg0KPj4+IEhlcmUgYXJlIHRoZSB2YXJpYWJs
ZSBNVFJScyBpbiB0aGUgbm9ybWFsIEh5cGVyLVYgZ3Vlc3Qgd2l0aCAzMiBHaUJ5dGVzDQo+
Pj4gb2YgbWVtb3J5Og0KPj4+DQo+Pj4gWyAgICAwLjA0MzU5Ml0gTVRSUiB2YXJpYWJsZSBy
YW5nZXMgZW5hYmxlZDoNCj4+PiBbICAgIDAuMDQ4MzA4XSAgIDAgYmFzZSAwMDAwMDAwMDAw
MDAgbWFzayBGRkZGMDAwMDAwMDAgd3JpdGUtYmFjaw0KPj4+IFsgICAgMC4wNTc0NTBdICAg
MSBiYXNlIDAwMDEwMDAwMDAwMCBtYXNrIEZGRjAwMDAwMDAwMCB3cml0ZS1iYWNrDQo+Pg0K
Pj4gSSd2ZSByZWFkIHRoZSBTRE0gY2hhcHRlciBmb3IgTVRSUnMgYWdhaW4uIERvZXNuJ3Qg
IzEgdmlvbGF0ZSB0aGUgcmVxdWlyZW1lbnRzDQo+PiBmb3IgTVRSUiBzZXR0aW5ncz8gVGhl
IFNETSBzYXlzOg0KPj4NCj4+ICAgICBGb3IgcmFuZ2VzIGdyZWF0ZXIgdGhhbiA0IEtCeXRl
cywgZWFjaCByYW5nZSBtdXN0IGJlIG9mIGxlbmd0aCAyXm4gYW5kIGl0cw0KPj4gICAgIGJh
c2UgYWRkcmVzcyBtdXN0IGJlIGFsaWduZWQgb24gYSAyXm4gYm91bmRhcnksIHdoZXJlIG4g
aXMgYSB2YWx1ZSBlcXVhbCB0bw0KPj4gICAgIG9yIGdyZWF0ZXIgdGhhbiAxMi4gVGhlIGJh
c2UtYWRkcmVzcyBhbGlnbm1lbnQgdmFsdWUgY2Fubm90IGJlIGxlc3MgdGhhbiBpdHMNCj4+
ICAgICBsZW5ndGguIEZvciBleGFtcGxlLCBhbiA4LUtCeXRlIHJhbmdlIGNhbm5vdCBiZSBh
bGlnbmVkIG9uIGEgNC1LQnl0ZSBib3VuZGFyeS4NCj4+ICAgICBJdCBtdXN0IGJlIGFsaWdu
ZWQgb24gYXQgbGVhc3QgYW4gOC1LQnl0ZSBib3VuZGFyeS4NCj4+DQo+PiBUaGlzIG1ha2Vz
IHRoZSByZWFzb25pbmcgYmVsb3cgd3JvbmcuDQo+IA0KPiBBcmdoLiAgSXQgc3VyZSBsb29r
cyBsaWtlIHlvdSBhcmUgcmlnaHQuICBJIGp1c3QgYXNzdW1lZCB0aGUgTVRSUnMgY29taW5n
IGZyb20NCj4gSHlwZXItViB3ZXJlIGdvb2QuICBTaGFtZSBvbiBtZS4gOi0oDQoNCkkgYXNz
dW1lZCB0aGUgc2FtZSwgYXMgSSBkaWRuJ3Qgc2VlIGFueSBmbGF3IGluIHlvdXIgcmVhc29u
aW5nIGJlZm9yZS4gOi0pDQoNCj4gSSd2ZSBwaW5nJ2VkIHRoZSBIeXBlci1WIHRlYW0gdG8g
c2VlIHdoYXQgdGhleSBzYXkuICBCdXQgaXQncyBoYXJkIHRvIHNlZSBob3cNCj4gdGhleSBj
b3VsZCBhcmd1ZSB0aGF0IHRoZXNlIE1UUlJzIGFyZSBjb3JyZWN0bHkgZm9ybWVkLiAgVGhl
IEludGVsIHNwZWMgaXMNCj4gdW5hbWJpZ3VvdXMuDQo+IA0KPiBFdmVuIGlmIEh5cGVyLVYg
YWdyZWVzIHRoYXQgdGhlIE1UUlJzIGFyZSB3cm9uZywgYSBmaXggd2lsbCB0YWtlIHRpbWUg
dG8NCj4gcHJvcGFnYXRlLiAgSW4gdGhlIG1lYW50aW1lLCBpdCBzZWVtcyBsaWtlIHRoZSBM
aW51eCBtaXRpZ2F0aW9ucyBjb3VsZCBiZQ0KPiBhbnkgb2YgdGhlIGZvbGxvd2luZzoNCj4g
DQo+IDEpIEtlZXAgdGhlIHRlc3QgZm9yIFdCIGluIHB1ZF9zZXRfaHVnZSgpIGFuZCBwbWRf
c2V0X2h1Z2UoKQ0KPiANCj4gMikgUmVtb3ZlIHRoZSB0ZXN0LCBidXQgaGF2ZSAidW5pZm9y
bSIgc2V0IHRvIDEgd2hlbiBtdWx0aXBsZSBNVFJScyBhcmUNCj4gICAgICBtYXRjaGVkIGJ1
dCBhbGwgaGF2ZSB0aGUgc2FtZSBjYWNoaW5nIHR5cGUsIHdoaWNoIHlvdSBwcm9wb3NlZCB0
bw0KPiAgICAgIHNvbHZlIFJpY2sgRWRnZWNvbWJlJ3MgcHJvYmxlbS4gIFRoaXMgaXMgbGlr
ZWx5IHRvIHBhcGVyIG92ZXIgdGhlDQo+ICAgICAgcHJvYmxlbSBJIHNhdyB3aXRoIHRoZSBI
eXBlci1WIE1UUlJzIGJlY2F1c2UgdGhlIGluY29ycmVjdGx5IG1hdGNoaW5nDQo+ICAgICAg
TVRSUnMgd291bGQgYWxsIGJlIFdCLg0KPiANCj4gMykgSW4gKmFsbCogSHlwZXItViBWTXMg
KG5vdCBqdXN0IENvbmZpZGVudGlhbCBWTXMpLCBkaXNhYmxlIFg4Nl9GRUFUVVJFX01UUlIN
Cj4gICAgICBhbmQgdXNlIHRoZSBuZXcgb3ZlcnJpZGUgdG8gc2V0IHRoZSBkZWZhdWx0IHR5
cGUgdG8gV0IuICAgSG9wZWZ1bGx5IHdlIGRvbid0DQo+ICAgICAgaGF2ZSB0byBkbyB0aGlz
LCBidXQgSSBjYW4gc3VibWl0IGEgc2VwYXJhdGUgcGF0Y2ggaWYgaXQgYmVjb21lcyBuZWNl
c3NhcnkuDQoNCjQpIFNhbml0aXplIE1UUlJzIGluIG10cnJfY2xlYW51cCgpLCByZXN1bHRp
bmcgaW4gTVRSUiMxIGluIHlvdXIgZXhhbXBsZSB0bw0KICAgIGJlIG1vZGlmaWVkIHRvIHN0
YXJ0IGF0IDAgKHdoaWNoIHdvdWxkIG5vdCByZWFsbHkgaGVscCB0byBzb2x2ZSB0aGUNCiAg
ICBtdWx0aXBsZSBtYXRjaCB5b3UgYXJlIHNlZWluZywgYnV0IEknbSBhYm91dCB0byBzb2x2
ZSB0aGF0IG9uZSwgdG9vLCBhcw0KICAgIHRoZSBtdWx0aXBsZSBNVFJSIG1hdGNoIGlzIGFs
bG93ZWQgaW4gdGhlIHNwZWNzLCBidXQgbm90IHJlYWxseSBoYW5kbGVkDQogICAgY29ycmVj
dGx5IGluIG10cnJfdHlwZV9sb29rdXAoKSkuDQoNCg0KSnVlcmdlbg0K
--------------6wpUHKpycslDI1AZFWgXjfSr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------6wpUHKpycslDI1AZFWgXjfSr--

--------------eB0YCH0xyH5hu8RdsK4weN2A--

--------------thNoPqyxLkNWJPEWXBMIME0s
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPtvYkFAwAAAAAACgkQsN6d1ii/Ey9R
AAf/RT1yUKnteyV1mEieicVoLK/ymZB6TXo2nOjapmSr4cb28jc3P0yvRTqDi34jgiUfSvca4tL6
TMFbVRwKTJ9TUWbhGZoX/FUIuaDAb3C/WRSKqnQ4Y8nlpJNpg/nWx28xWNQz8HXxdb8lQssM/E1I
eSWJ6oh6ZKK2cc+FVe7S6Nj7o0cEbZivK3D8KQXkz9JLRK0fWjmVPcOoG+eV81y5j9ZGDSuhVJsh
PQE3XzBt2g0JDOrN4MS/wNfDSQyXn4yVSnZTDxoK4E8DFHdRCM/v4oTUpKVBCtapgt0JSl6bWwnB
+6BgWCw0I35iG21ihWCnFg+O2lmdnPN9Gs7mEH4c+Q==
=7WIG
-----END PGP SIGNATURE-----

--------------thNoPqyxLkNWJPEWXBMIME0s--
