Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591870F78D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjEXNZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjEXNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:25:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8A9B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1FD41F8BF;
        Wed, 24 May 2023 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684934734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ud6MB7nedCZkSb5qPo9d/1Yd567GK4FyPlSF+rxBmoo=;
        b=sjZ7uOhM6BQ/AXe2dfIHc3p4JD/E30fE8XmNSPeiUwRrTVr/oJHH9uLg03XXGffpT1+APg
        NMPKaEgUiDUSoEZHBKULg0Ed0cRwNQ5FKOMmbCX6oeXzUtzPhbJDZwzoYYy/SoWqlyuzIF
        CRv1DXUe7n/XrjtppN6eBXVDaxi1tKE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78EC5133E6;
        Wed, 24 May 2023 13:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Clw3HE4QbmRTBwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 24 May 2023 13:25:34 +0000
Message-ID: <42ca1d5b-f064-9327-90a4-a51a536cca1f@suse.com>
Date:   Wed, 24 May 2023 15:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20230523205703.2116910-1-arnd@kernel.org>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] [v3] x86: xen: add missing prototypes
In-Reply-To: <20230523205703.2116910-1-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EEwKLaWCxiBLY3VNTN9kwMkV"
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
--------------EEwKLaWCxiBLY3VNTN9kwMkV
Content-Type: multipart/mixed; boundary="------------FRGwNkgU1tOwivNx2Vn2eN1p";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <42ca1d5b-f064-9327-90a4-a51a536cca1f@suse.com>
Subject: Re: [PATCH] [v3] x86: xen: add missing prototypes
References: <20230523205703.2116910-1-arnd@kernel.org>
In-Reply-To: <20230523205703.2116910-1-arnd@kernel.org>

--------------FRGwNkgU1tOwivNx2Vn2eN1p
Content-Type: multipart/mixed; boundary="------------vqX0FtuPaXK098mpV9QoM0mE"

--------------vqX0FtuPaXK098mpV9QoM0mE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDUuMjMgMjI6NTYsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBUaGVzZSBmdW5jdGlvbiBhcmUgYWxs
IGNhbGxlZCBmcm9tIGFzc2VtYmxlciBmaWxlcywgb3IgZnJvbSBpbmxpbmUgYXNzZW1ibGVy
LA0KPiBzbyB0aGVyZSBpcyBubyBpbW1lZGlhdGUgbmVlZCBmb3IgYSBwcm90b3R5cGUgaW4g
YSBoZWFkZXIsIGJ1dCBpZiAtV21pc3NpbmctcHJvdG90eXBlcw0KPiBpcyBlbmFibGVkLCB0
aGUgY29tcGlsZXIgd2FybnMgYWJvdXQgdGhlbToNCj4gDQo+IGFyY2gveDg2L3hlbi9lZmku
YzoxMzA6MTM6IGVycm9yOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yICd4ZW5fZWZpX2lu
aXQnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10NCj4gYXJjaC94ODYvcGxhdGZvcm0v
cHZoL2VubGlnaHRlbi5jOjEyMDoxMzogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBm
b3IgJ3hlbl9wcmVwYXJlX3B2aCcgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzXQ0KPiBh
cmNoL3g4Ni94ZW4vbW11X3B2LmM6MzU4OjIwOiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciAneGVuX3B0ZV92YWwnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10NCj4g
YXJjaC94ODYveGVuL21tdV9wdi5jOjM2NjoyMDogZXJyb3I6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3IgJ3hlbl9wZ2RfdmFsJyBbLVdlcnJvcj1taXNzaW5nLXByb3RvdHlwZXNdDQo+
IGFyY2gveDg2L3hlbi9tbXVfcHYuYzozNzI6MTc6IGVycm9yOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yICd4ZW5fbWFrZV9wdGUnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10N
Cj4gYXJjaC94ODYveGVuL21tdV9wdi5jOjM4MDoxNzogZXJyb3I6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3IgJ3hlbl9tYWtlX3BnZCcgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVz
XQ0KPiBhcmNoL3g4Ni94ZW4vbW11X3B2LmM6Mzg3OjIwOiBlcnJvcjogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciAneGVuX3BtZF92YWwnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBl
c10NCj4gYXJjaC94ODYveGVuL21tdV9wdi5jOjQyNToxNzogZXJyb3I6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3IgJ3hlbl9tYWtlX3BtZCcgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5
cGVzXQ0KPiBhcmNoL3g4Ni94ZW4vbW11X3B2LmM6NDMyOjIwOiBlcnJvcjogbm8gcHJldmlv
dXMgcHJvdG90eXBlIGZvciAneGVuX3B1ZF92YWwnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90
eXBlc10NCj4gYXJjaC94ODYveGVuL21tdV9wdi5jOjQzODoxNzogZXJyb3I6IG5vIHByZXZp
b3VzIHByb3RvdHlwZSBmb3IgJ3hlbl9tYWtlX3B1ZCcgWy1XZXJyb3I9bWlzc2luZy1wcm90
b3R5cGVzXQ0KPiBhcmNoL3g4Ni94ZW4vbW11X3B2LmM6NTIyOjIwOiBlcnJvcjogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciAneGVuX3A0ZF92YWwnIFstV2Vycm9yPW1pc3NpbmctcHJv
dG90eXBlc10NCj4gYXJjaC94ODYveGVuL21tdV9wdi5jOjUyODoxNzogZXJyb3I6IG5vIHBy
ZXZpb3VzIHByb3RvdHlwZSBmb3IgJ3hlbl9tYWtlX3A0ZCcgWy1XZXJyb3I9bWlzc2luZy1w
cm90b3R5cGVzXQ0KPiBhcmNoL3g4Ni94ZW4vbW11X3B2LmM6MTQ0MjoxNzogZXJyb3I6IG5v
IHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ3hlbl9tYWtlX3B0ZV9pbml0JyBbLVdlcnJvcj1t
aXNzaW5nLXByb3RvdHlwZXNdDQoNCkknZCBzdWdnZXN0IHRvIGFkZCB0aGUgcHJvdG90eXBl
cyBvZiB0aGUgZnVuY3Rpb25zIGRlZmluZWQgaW4NCmFyY2gveDg2L3hlbi9tbXVfcHYuYyB0
byB0aGUgc2FtZSBzb3VyY2UsIGFzIHRoZXkgYXJlIHJlZmVyZW5jZWQNCm5vd2hlcmUgZWxz
ZS4gVGhpcyBhdm9pZHMgdGhlIG5lZWQgb2YgI2lmZGVmcyBmb3IgdGhvc2UgZnVuY3Rpb25z
Lg0KDQo+IGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYzoxMjMzOjM0OiBlcnJvcjogbm8g
cHJldmlvdXMgcHJvdG90eXBlIGZvciAneGVuX3N0YXJ0X2tlcm5lbCcgWy1XZXJyb3I9bWlz
c2luZy1wcm90b3R5cGVzXQ0KPiBhcmNoL3g4Ni94ZW4vaXJxLmM6MjI6MTQ6IGVycm9yOiBu
byBwcmV2aW91cyBwcm90b3R5cGUgZm9yICd4ZW5fZm9yY2VfZXZ0Y2huX2NhbGxiYWNrJyBb
LVdlcnJvcj1taXNzaW5nLXByb3RvdHlwZXNdDQo+IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5j
OjMwMjoyNDogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ3hlbl9wdl9ldnRj
aG5fZG9fdXBjYWxsJyBbLVdlcnJvcj1taXNzaW5nLXByb3RvdHlwZXNdDQo+IA0KPiBEZWNs
YXJlIGFsbCBvZiB0aGVtIGluIGFuIGFwcHJvcHJpYXRlIGhlYWRlciBmaWxlIHRvIGF2b2lk
IHRoZSB3YXJuaW5ncy4NCj4gRm9yIGNvbnNpc3RlbmN5LCBhbHNvIG1vdmUgdGhlIGFzbV9j
cHVfYnJpbmd1cF9hbmRfaWRsZSgpIGRlY2xhcmF0aW9uIG91dCBvZg0KPiBzbXBfcHYuYy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+
IC0tLQ0KPiB2MzogbW92ZSBkZWNsYXRpb25zIG9mIGNvbmRpdGlvbmFsIGZ1bmN0aW9uIGlu
IGFuICNpZmRlZiB3aXRoIGEgc3R1Yg0KPiB2MjogZml4IHVwIGNoYW5nZWxvZw0KPiAtLS0N
Cj4gICBhcmNoL3g4Ni94ZW4vZWZpLmMgICAgIHwgIDIgKysNCj4gICBhcmNoL3g4Ni94ZW4v
c21wLmggICAgIHwgMTEgKysrKysrKysrKysNCj4gICBhcmNoL3g4Ni94ZW4vc21wX3B2LmMg
IHwgIDEgLQ0KPiAgIGFyY2gveDg2L3hlbi94ZW4tb3BzLmggfCAyNiArKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUveGVuL3hlbi5oICAgICAgfCAgMyArKysNCj4g
ICA1IGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vZWZpLmMgYi9hcmNoL3g4Ni94ZW4vZWZp
LmMNCj4gaW5kZXggN2Q3ZmZiOWM4MjZhLi44NjNkMGQ2YjNlZGMgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gveDg2L3hlbi9lZmkuYw0KPiArKysgYi9hcmNoL3g4Ni94ZW4vZWZpLmMNCj4gQEAg
LTE2LDYgKzE2LDggQEANCj4gICAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQo+ICAgI2luY2x1
ZGUgPGFzbS94ZW4vaHlwZXJjYWxsLmg+DQo+ICAgDQo+ICsjaW5jbHVkZSAieGVuLW9wcy5o
Ig0KPiArDQo+ICAgc3RhdGljIGVmaV9jaGFyMTZfdCB2ZW5kb3JbMTAwXSBfX2luaXRkYXRh
Ow0KPiAgIA0KPiAgIHN0YXRpYyBlZmlfc3lzdGVtX3RhYmxlX3QgZWZpX3N5c3RhYl94ZW4g
X19pbml0ZGF0YSA9IHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9zbXAuaCBiL2Fy
Y2gveDg2L3hlbi9zbXAuaA0KPiBpbmRleCAyMmZiOTgyZmY5NzEuLjkzNjc1MDIyODFkYyAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYveGVuL3NtcC5oDQo+ICsrKyBiL2FyY2gveDg2L3hl
bi9zbXAuaA0KPiBAQCAtMiw2ICsyLDEwIEBADQo+ICAgI2lmbmRlZiBfWEVOX1NNUF9IDQo+
ICAgDQo+ICAgI2lmZGVmIENPTkZJR19TTVANCj4gKw0KPiArdm9pZCBhc21fY3B1X2JyaW5n
dXBfYW5kX2lkbGUodm9pZCk7DQo+ICthc21saW5rYWdlIHZvaWQgY3B1X2JyaW5ndXBfYW5k
X2lkbGUodm9pZCk7DQo+ICsNCj4gICBleHRlcm4gdm9pZCB4ZW5fc2VuZF9JUElfbWFzayhj
b25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaywNCj4gICAJCQkgICAgICBpbnQgdmVjdG9yKTsN
Cj4gICBleHRlcm4gdm9pZCB4ZW5fc2VuZF9JUElfbWFza19hbGxidXRzZWxmKGNvbnN0IHN0
cnVjdCBjcHVtYXNrICptYXNrLA0KPiBAQCAtMjksNiArMzMsMTMgQEAgc3RydWN0IHhlbl9j
b21tb25faXJxIHsNCj4gICB9Ow0KPiAgICNlbHNlIC8qIENPTkZJR19TTVAgKi8NCj4gICAN
Cj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhc21fY3B1X2JyaW5ndXBfYW5kX2lkbGUodm9pZCkN
Cj4gK3sNCj4gK30NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBjcHVfYnJpbmd1cF9hbmRfaWRs
ZSh2b2lkKQ0KPiArew0KPiArfQ0KPiArDQoNCk5vIG5lZWQgZm9yIGFib3ZlIHN0dWJzLCBh
cyB0aGVyZSBpcyBubyB3YXkgdGhleSBjYW4gZ2V0IGNhbGxlZA0Kd2l0aG91dCBDT05GSUdf
U01QLg0KDQo+ICAgc3RhdGljIGlubGluZSBpbnQgeGVuX3NtcF9pbnRyX2luaXQodW5zaWdu
ZWQgaW50IGNwdSkNCj4gICB7DQo+ICAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYveGVuL3NtcF9wdi5jIGIvYXJjaC94ODYveGVuL3NtcF9wdi5jDQo+IGluZGV4IGE5
MmU4MDAyYjVjZi4uZDVhZTVkZTJkYWEyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni94ZW4v
c21wX3B2LmMNCj4gKysrIGIvYXJjaC94ODYveGVuL3NtcF9wdi5jDQo+IEBAIC01NSw3ICs1
NSw2IEBAIHN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3QgeGVuX2NvbW1vbl9pcnEsIHhl
bl9pcnFfd29yaykgPSB7IC5pcnEgPSAtMSB9Ow0KPiAgIHN0YXRpYyBERUZJTkVfUEVSX0NQ
VShzdHJ1Y3QgeGVuX2NvbW1vbl9pcnEsIHhlbl9wbXVfaXJxKSA9IHsgLmlycSA9IC0xIH07
DQo+ICAgDQo+ICAgc3RhdGljIGlycXJldHVybl90IHhlbl9pcnFfd29ya19pbnRlcnJ1cHQo
aW50IGlycSwgdm9pZCAqZGV2X2lkKTsNCj4gLXZvaWQgYXNtX2NwdV9icmluZ3VwX2FuZF9p
ZGxlKHZvaWQpOw0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGNwdV9icmluZ3VwKHZvaWQpDQo+
ICAgew0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL3hlbi1vcHMuaCBiL2FyY2gveDg2
L3hlbi94ZW4tb3BzLmgNCj4gaW5kZXggNmQ3ZjYzMThmYzA3Li5lYjRjYjMwNTcwYzcgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L3hlbi94ZW4tb3BzLmgNCj4gKysrIGIvYXJjaC94ODYv
eGVuL3hlbi1vcHMuaA0KPiBAQCAtMTQ2LDEyICsxNDYsMzggQEAgaW50IHhlbl9jcHVocF9z
ZXR1cChpbnQgKCpjcHVfdXBfcHJlcGFyZV9jYikodW5zaWduZWQgaW50KSwNCj4gICB2b2lk
IHhlbl9waW5fdmNwdShpbnQgY3B1KTsNCj4gICANCj4gICB2b2lkIHhlbl9lbWVyZ2VuY3lf
cmVzdGFydCh2b2lkKTsNCj4gK3ZvaWQgeGVuX2ZvcmNlX2V2dGNobl9jYWxsYmFjayh2b2lk
KTsNCj4gKw0KPiAgICNpZmRlZiBDT05GSUdfWEVOX1BWDQo+ICAgdm9pZCB4ZW5fcHZfcHJl
X3N1c3BlbmQodm9pZCk7DQo+ICAgdm9pZCB4ZW5fcHZfcG9zdF9zdXNwZW5kKGludCBzdXNw
ZW5kX2NhbmNlbGxlZCk7DQo+ICtwdGV2YWxfdCB4ZW5fcHRlX3ZhbChwdGVfdCBwdGUpOw0K
PiArcGdkdmFsX3QgeGVuX3BnZF92YWwocGdkX3QgcGdkKTsNCj4gK3BtZHZhbF90IHhlbl9w
bWRfdmFsKHBtZF90IHBtZCk7DQo+ICtwdWR2YWxfdCB4ZW5fcHVkX3ZhbChwdWRfdCBwdWQp
Ow0KPiArcDRkdmFsX3QgeGVuX3A0ZF92YWwocDRkX3QgcDRkKTsNCj4gK3B0ZV90IHhlbl9t
YWtlX3B0ZShwdGV2YWxfdCBwdGUpOw0KPiArcGdkX3QgeGVuX21ha2VfcGdkKHBnZHZhbF90
IHBnZCk7DQo+ICtwbWRfdCB4ZW5fbWFrZV9wbWQocG1kdmFsX3QgcG1kKTsNCj4gK3B1ZF90
IHhlbl9tYWtlX3B1ZChwdWR2YWxfdCBwdWQpOw0KPiArcDRkX3QgeGVuX21ha2VfcDRkKHA0
ZHZhbF90IHA0ZCk7DQo+ICtwdGVfdCB4ZW5fbWFrZV9wdGVfaW5pdChwdGV2YWxfdCBwdGUp
Ow0KDQpTZWUgYWJvdmUuDQoNCj4gK3ZvaWQgeGVuX3N0YXJ0X2tlcm5lbChzdHJ1Y3Qgc3Rh
cnRfaW5mbyAqc2kpOw0KPiAgICNlbHNlDQo+ICAgc3RhdGljIGlubGluZSB2b2lkIHhlbl9w
dl9wcmVfc3VzcGVuZCh2b2lkKSB7fQ0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fcHZf
cG9zdF9zdXNwZW5kKGludCBzdXNwZW5kX2NhbmNlbGxlZCkge30NCj4gK3N0YXRpYyBpbmxp
bmUgcHRldmFsX3QgeGVuX3B0ZV92YWwocHRlX3QgcHRlKQl7IHJldHVybiBwdGUucHRlOyB9
DQo+ICtzdGF0aWMgaW5saW5lIHBnZHZhbF90IHhlbl9wZ2RfdmFsKHBnZF90IHBnZCkJeyBy
ZXR1cm4gcGdkLnBnZDsgfQ0KPiArc3RhdGljIGlubGluZSBwbWR2YWxfdCB4ZW5fcG1kX3Zh
bChwbWRfdCBwbWQpCXsgcmV0dXJuIHBtZC5wbWQ7IH0NCj4gK3N0YXRpYyBpbmxpbmUgcHVk
dmFsX3QgeGVuX3B1ZF92YWwocHVkX3QgcHVkKQl7IHJldHVybiBwdWQucHVkOyB9DQo+ICtz
dGF0aWMgaW5saW5lIHA0ZHZhbF90IHhlbl9wNGRfdmFsKHA0ZF90IHA0ZCkJeyByZXR1cm4g
cDRkLnA0ZDsgfQ0KPiArc3RhdGljIGlubGluZSBwdGVfdCB4ZW5fbWFrZV9wdGUocHRldmFs
X3QgcHRlKQl7IHJldHVybiAocHRlX3Qpe3B0ZX07IH0NCj4gK3N0YXRpYyBpbmxpbmUgcGdk
X3QgeGVuX21ha2VfcGdkKHBnZHZhbF90IHBnZCkJeyByZXR1cm4gKHBnZF90KXtwZ2R9OyB9
DQo+ICtzdGF0aWMgaW5saW5lIHBtZF90IHhlbl9tYWtlX3BtZChwbWR2YWxfdCBwbWQpCXsg
cmV0dXJuIChwbWRfdCl7cG1kfTsgfQ0KPiArc3RhdGljIGlubGluZSBwdWRfdCB4ZW5fbWFr
ZV9wdWQocHVkdmFsX3QgcHVkKQl7IHJldHVybiAocHVkX3Qpe3B1ZH07IH0NCj4gK3N0YXRp
YyBpbmxpbmUgcDRkX3QgeGVuX21ha2VfcDRkKHA0ZHZhbF90IHA0ZCkJeyByZXR1cm4gKHA0
ZF90KXtwNGR9OyB9DQo+ICtzdGF0aWMgaW5saW5lIHB0ZV90IHhlbl9tYWtlX3B0ZV9pbml0
KHB0ZXZhbF90IHB0ZSkJeyByZXR1cm4gKHB0ZV90KXtwdGV9OyB9DQo+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgeGVuX3N0YXJ0X2tlcm5lbChzdHJ1Y3Qgc3RhcnRfaW5mbyAqc2kpIHt9DQoN
CkRyb3AgdGhvc2Ugc3R1YnMsIHRoZXkgYXJlIG5vdCB1c2VkIHdpdGhvdXQgQ09ORklHX1hF
Tl9QViwgYW5kDQp0aGV5IHNob3VsZG4ndCBiZSB1c2VkIGluIHRoaXMgY2FzZSBhbnl3YXku
DQoNCj4gICAjZW5kaWYNCj4gICANCj4gICAjaWZkZWYgQ09ORklHX1hFTl9QVkhWTQ0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4veGVuLmggYi9pbmNsdWRlL3hlbi94ZW4uaA0KPiBp
bmRleCAwZWZlYjY1MmY5YjguLmY5ODkxNjI5ODNjMyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS94ZW4veGVuLmgNCj4gKysrIGIvaW5jbHVkZS94ZW4veGVuLmgNCj4gQEAgLTMxLDYgKzMx
LDkgQEAgZXh0ZXJuIHVpbnQzMl90IHhlbl9zdGFydF9mbGFnczsNCj4gICANCj4gICAjaW5j
bHVkZSA8eGVuL2ludGVyZmFjZS9odm0vc3RhcnRfaW5mby5oPg0KPiAgIGV4dGVybiBzdHJ1
Y3QgaHZtX3N0YXJ0X2luZm8gcHZoX3N0YXJ0X2luZm87DQo+ICt2b2lkIHhlbl9wcmVwYXJl
X3B2aCh2b2lkKTsNCj4gK3N0cnVjdCBwdF9yZWdzOw0KPiArdm9pZCB4ZW5fcHZfZXZ0Y2hu
X2RvX3VwY2FsbChzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+ICAgDQo+ICAgI2lmZGVmIENP
TkZJR19YRU5fRE9NMA0KPiAgICNpbmNsdWRlIDx4ZW4vaW50ZXJmYWNlL3hlbi5oPg0KDQoN
Ckp1ZXJnZW4NCg==
--------------vqX0FtuPaXK098mpV9QoM0mE
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------vqX0FtuPaXK098mpV9QoM0mE--

--------------FRGwNkgU1tOwivNx2Vn2eN1p--

--------------EEwKLaWCxiBLY3VNTN9kwMkV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRuEE4FAwAAAAAACgkQsN6d1ii/Ey9N
MAf+LtwS2j+za6YUynWwQzUfny4yRglRQMREx7rQBDJU9sUcYHztPmuYE7MPL2RlxhMvudM0o+JU
ChzsnrDR5hDn26iB1kDvBYgUXrrYzUrxEbZpqw4cKtsPeaDc/q+4lUYyAPo1kZXuZ9e87rVx6il5
r0WRSM/dHvMy/qSG53GpEHHAgXBEtZArk0Rrtdw13Zt/uWvVvQPWd6J6wW8ODXC78bz34EkokJeB
xbQNQk3mZSWjVFfi7P/391rBWGksrTrfme7VrNUxvxBJQlnawuzP4TNzwE2Dzk5SAin5aXLjomgg
TTltl4YQWgZugUNiaTKweRZObLhEP57EvY1WKuQLnQ==
=8to8
-----END PGP SIGNATURE-----

--------------EEwKLaWCxiBLY3VNTN9kwMkV--
