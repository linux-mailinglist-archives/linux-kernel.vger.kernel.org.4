Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795165FB74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjAFGdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFGdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:33:44 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871F6CFD3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:33:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B4AAA3200A86;
        Fri,  6 Jan 2023 01:33:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 06 Jan 2023 01:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672986819; x=
        1673073219; bh=Hh4ICtBdSV1h558M9rRzWahxiMQq5o2LKrmfpgkGiC4=; b=e
        ZGqaXCocVC5mQJeOuJgEiVbN24bWv1FP2pIu/hg13TFAIH+UzhkheS1lqfLoQuAB
        H/aJb9gb6oAKXw92FS/MlPMX+3nDIvTkUFzAJXbpjFgDvXAt26SxTdGrRQm6/4/s
        x61W8iy9/oJlrmjEHLoFwavmynWLtGR7clgdrzLzYO+mMCGrdeRPMS5tZyzKjGt4
        MO9GIkDNS4uxvyysHNo/ElHD2NPsltDp51KJJyaEdOIx3KnYPe6f0nMIxPfARbBk
        3NoK15qf1hYieuB0j6eWMe1JpqCi+GI0e13XBJ0tt5PD4GMPrtQF8oGq5omzn4gO
        kePAzjfyJVgf+26xmvH8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672986819; x=
        1673073219; bh=Hh4ICtBdSV1h558M9rRzWahxiMQq5o2LKrmfpgkGiC4=; b=h
        DZhPSc0EdjAilUgIHTAg/flZToRBeoh888grZByWpfY3dAApxM0dMk1aChjxCqwX
        s4DI/klPdE09QkLIuxAQt6JqyPwgcWK/GrijQzpMLrJXPwO6Eo9PLAE8CTRLpDRN
        4mEw6d3C2iQO3a9v8qw5AdfNbcmdHpqeiEsZSqQTRGuvYJAO282WJ5SMju7qNi3W
        mjrMcr28aQlkhKbAVxRJEvC4U4cZ89oE/5d5pGR6M8SwKXSSHHHEa11eA8nj4caL
        RR/9LdyNtjYCPOgPpS35IwATlzra075aPGEmNnij9h2Gu3YCUgHZCZ0EsTfYFhYF
        lstXXb+WG9Acg2m98sSYw==
X-ME-Sender: <xms:wsC3Y6T8HKlFVArXKLiLRdpogWIfYbRlw4Uxzo1g-b1KJeK1TY6Gxg>
    <xme:wsC3Y_wFeXO3Lo6FrZMa47Q2YHXe8DXzlaDuH6VJxbOO6vr0Lh6XzeA1zLvYqZ9CP
    ThELi4wsChguL92cw>
X-ME-Received: <xmr:wsC3Y31MmOlU-iIuHrnn9Ot9IyR8gNU6GmL1MTzdxAf3AuEFJ20D_HnLHDgjvjiyg8o1zskofRujP26qwi1OEg6TlFToJTcspfPetkW237-Mmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdduhedmnecujfgurhepkffuhf
    fvveffjghftgfgfgggsehtsgertddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
    rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpe
    ehudeiudehtdeufeeugeffgfduudfgffevkeevgfetteehvdefvdehuefhgfehhfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurh
    esrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:wsC3Y2BLsHiyg5t-VFIzN5SPYnWbp__Yr0_XXBwTCJxbN37c_vD_Nw>
    <xmx:wsC3YzgcjL_vw9omSDZa8w_E_wJekAMD7VMh8oaoAQ5o_yr29r5nRw>
    <xmx:wsC3YyrwiIQKvtmVUsYay1d3AtBIFkmOIacn7neSoNoeD1hRsyBFcw>
    <xmx:w8C3Y-XSEtAJWT6himW5-MFlUSjtD_LS4arVVZZVVeZlJ8BameX0NQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jan 2023 01:33:36 -0500 (EST)
Message-ID: <c6d67f326825548ee5e06d7ebb969d0c99114361.camel@russell.cc>
Subject: Re: [PATCH v2 6/7] powerpc/secvar: Extend sysfs to include config
 vars
From:   Russell Currey <ruscur@russell.cc>
To:     Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com, mpe@ellerman.id.au
Date:   Fri, 06 Jan 2023 17:33:33 +1100
In-Reply-To: <20729da992c608ed40f5f037a7314395075a4254.camel@linux.ibm.com>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-7-ruscur@russell.cc>
         <20729da992c608ed40f5f037a7314395075a4254.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTA1IGF0IDE4OjI4ICsxMTAwLCBBbmRyZXcgRG9ubmVsbGFuIHdyb3Rl
Ogo+IE9uIEZyaSwgMjAyMi0xMi0zMCBhdCAxNToyMCArMTEwMCwgUnVzc2VsbCBDdXJyZXkgd3Jv
dGU6Cj4gPiBUaGUgZm9ydGhjb21pbmcgcHNlcmllcyBjb25zdW1lciBvZiB0aGUgc2VjdmFyIEFQ
SSB3YW50cyB0byBleHBvc2UKPiA+IGEKPiA+IG51bWJlciBvZiBjb25maWcgdmFyaWFibGVzLsKg
IEFsbG93aW5nIHNlY3ZhciBpbXBsZW1lbnRhdGlvbnMgdG8KPiA+IHByb3ZpZGUKPiA+IHRoZWly
IG93biBzeXNmcyBhdHRyaWJ1dGVzIG1ha2VzIGl0IGVhc3kgZm9yIGNvbnN1bWVycyB0byBleHBv
c2UKPiA+IHdoYXQKPiA+IHRoZXkgbmVlZCB0by4KPiA+IAo+ID4gVGhpcyBpcyBub3QgYmVpbmcg
dXNlZCBieSB0aGUgT1BBTCBzZWN2YXIgaW1wbGVtZW50YXRpb24gYXQKPiA+IHByZXNlbnQsCj4g
PiBhbmQKPiA+IHRoZSBjb25maWcgZGlyZWN0b3J5IHdpbGwgbm90IGJlIGNyZWF0ZWQgaWYgbm8g
YXR0cmlidXRlcyBhcmUgc2V0Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxsIEN1cnJl
eSA8cnVzY3VyQHJ1c3NlbGwuY2M+Cj4gCj4gTWlub3IgY29tbWVudHMgYmVsb3csIGJ1dCByZWdh
cmRsZXNzOgo+IAo+IFJldmlld2VkLWJ5OiBBbmRyZXcgRG9ubmVsbGFuIDxhamRAbGludXguaWJt
LmNvbT4KPiAKPiA+IC0tLQo+ID4gSSBwbGF5ZWQgYXJvdW5kIHdpdGggYWRkaW5nIGFuIEFQSSBj
YWxsIHRvIGZhY2lsaXRhdGUgYSBtb3JlCj4gPiBnZW5lcmljCj4gPiBrZXkvdmFsdWUgaW50ZXJm
YWNlIGZvciBjb25maWcgdmFyaWFibGVzIGFuZCBpdCBzZWVtZWQgbGlrZQo+ID4gdW5uZWNlc3Nh
cnkKPiA+IGNvbXBsZXhpdHkuwqAgSSB0aGluayB0aGlzIGlzIGNsZWFuZXIuwqAgSWYgdGhlcmUg
d2FzIGV2ZXIgYSBzZWN2YXIKPiA+IGludGVyZmFjZSBvdGhlciB0aGFuIHN5c2ZzIHdlJ2QgaGF2
ZSB0byByZXdvcmsgaXQsIHRob3VnaC4KPiAKPiBJIGNvbmN1ciwgdGhpcyBjYW4gYmUgZGVhbHQg
d2l0aCBpZi93aGVuIHRoZSBzZWN2YXIgaW50ZXJmYWNlIGlzCj4gZXhwb3NlZCBieSBzb21lIG90
aGVyIG1lYW5zIHRoYW4gc3lzZnMuCj4gCj4gPiAKPiA+IMKgYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3NlY3Zhci5owqAgfMKgIDMgKysrCj4gPiDCoGFyY2gvcG93ZXJwYy9rZXJuZWwvc2VjdmFy
LXN5c2ZzLmMgfCA0MAo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ID4gLS0KPiA+
IMKgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3NlY3Zhci5oCj4gPiBi
L2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9zZWN2YXIuaAo+ID4gaW5kZXggOTJkMmMwNTE5MThi
Li4yNTBlNzA2NmI2ZGEgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
c2VjdmFyLmgKPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9zZWN2YXIuaAo+ID4g
QEAgLTEwLDYgKzEwLDcgQEAKPiA+IMKgCj4gPiDCoCNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgo+
ID4gwqAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvc3lzZnMu
aD4KPiA+IMKgCj4gPiDCoGV4dGVybiBjb25zdCBzdHJ1Y3Qgc2VjdmFyX29wZXJhdGlvbnMgKnNl
Y3Zhcl9vcHM7Cj4gPiDCoAo+ID4gQEAgLTI3LDEwICsyOCwxMiBAQCBzdHJ1Y3Qgc2VjdmFyX29w
ZXJhdGlvbnMgewo+ID4gwqAjaWZkZWYgQ09ORklHX1BQQ19TRUNVUkVfQk9PVAo+ID4gwqAKPiA+
IMKgZXh0ZXJuIHZvaWQgc2V0X3NlY3Zhcl9vcHMoY29uc3Qgc3RydWN0IHNlY3Zhcl9vcGVyYXRp
b25zICpvcHMpOwo+ID4gK2V4dGVybiB2b2lkIHNldF9zZWN2YXJfY29uZmlnX2F0dHJzKGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGUKPiA+ICoqYXR0cnMpOwo+ID4gwqAKPiA+IMKgI2Vsc2UKPiA+IMKg
Cj4gPiDCoHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfc2VjdmFyX29wcyhjb25zdCBzdHJ1Y3Qgc2Vj
dmFyX29wZXJhdGlvbnMKPiA+ICpvcHMpIHsgfQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzZXRf
c2VjdmFyX2NvbmZpZ19hdHRycyhjb25zdCBzdHJ1Y3QgYXR0cmlidXRlCj4gPiAqKmF0dHJzKSB7
IH0KPiA+IMKgCj4gPiDCoCNlbmRpZgo+ID4gwqAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMva2VybmVsL3NlY3Zhci1zeXNmcy5jCj4gPiBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvc2VjdmFy
LXN5c2ZzLmMKPiA+IGluZGV4IGFhMWRhZWM0ODBlMS4uYWQxZTFkNzJkMmFlIDEwMDY0NAo+ID4g
LS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9zZWN2YXItc3lzZnMuYwo+ID4gKysrIGIvYXJjaC9w
b3dlcnBjL2tlcm5lbC9zZWN2YXItc3lzZnMuYwo+ID4gQEAgLTE1LDkgKzE1LDE3IEBACj4gPiDC
oAo+ID4gwqAjZGVmaW5lIE5BTUVfTUFYX1NJWkXCoMKgwqDCoCAxMDI0Cj4gPiDCoAo+ID4gK2Nv
bnN0IHN0cnVjdCBhdHRyaWJ1dGUgKipzZWN2YXJfY29uZmlnX2F0dHJzIF9fcm9fYWZ0ZXJfaW5p
dCA9Cj4gPiBOVUxMOwo+ID4gKwo+ID4gwqBzdGF0aWMgc3RydWN0IGtvYmplY3QgKnNlY3Zhcl9r
b2JqOwo+ID4gwqBzdGF0aWMgc3RydWN0IGtzZXQgKnNlY3Zhcl9rc2V0Owo+ID4gwqAKPiA+ICt2
b2lkIHNldF9zZWN2YXJfY29uZmlnX2F0dHJzKGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGUgKiphdHRy
cykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBXQVJOX09OX09OQ0Uoc2VjdmFyX2NvbmZpZ19h
dHRycyk7Cj4gPiArwqDCoMKgwqDCoMKgwqBzZWN2YXJfY29uZmlnX2F0dHJzID0gYXR0cnM7Cj4g
PiArfQo+ID4gKwo+ID4gwqBzdGF0aWMgc3NpemVfdCBmb3JtYXRfc2hvdyhzdHJ1Y3Qga29iamVj
dCAqa29iaiwgc3RydWN0Cj4gPiBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciAqYnVmKQo+ID4g
wqB7Cj4gPiBAQCAtMTM0LDYgKzE0MiwxNiBAQCBzdGF0aWMgaW50IHVwZGF0ZV9rb2JqX3NpemUo
dm9pZCkKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+IMKgfQo+ID4gwqAKPiA+ICtz
dGF0aWMgaW50IHNlY3Zhcl9zeXNmc19jb25maWcoc3RydWN0IGtvYmplY3QgKmtvYmopCj4gPiAr
ewo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBjb25maWdfZ3JvdXAg
PSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAiY29uZmlnIiwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYXR0cnMgPSAoc3RydWN0IGF0dHJp
YnV0ZSAqKilzZWN2YXJfY29uZmlnX2F0dHJzLAo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiAKPiBJ
IHdhcyBzbGlnaHRseSBjb25jZXJuZWQgdGhhdCB5b3UncmUgcHV0dGluZyB0aGlzIG9uIHRoZSBz
dGFjaywgYnV0Cj4gaXQKPiBkb2Vzbid0IGFwcGVhciB0aGF0IHN5c2ZzX2NyZWF0ZV9ncm91cCgp
IGtlZXBzIGFueSByZWZlcmVuY2VzIHRvIHRoZQo+IGdyb3VwIGFyb3VuZCBhZnRlciBpdCBjcmVh
dGVzIGFsbCB0aGUgZmlsZXMsIHNvIEkgdGhpbmsgdGhpcyBpcyBmaW5lLgo+IAo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91cChrb2JqLCAmY29uZmlnX2dy
b3VwKTsKPiA+ICt9Cj4gPiArCj4gPiDCoHN0YXRpYyBpbnQgc2VjdmFyX3N5c2ZzX2xvYWQodm9p
ZCkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoGNoYXIgKm5hbWU7Cj4gPiBAQCAtMTk2LDI2
ICsyMTQsMzggQEAgc3RhdGljIGludCBzZWN2YXJfc3lzZnNfaW5pdCh2b2lkKQo+ID4gwqAKPiA+
IMKgwqDCoMKgwqDCoMKgwqByYyA9IHN5c2ZzX2NyZWF0ZV9maWxlKHNlY3Zhcl9rb2JqLCAmZm9y
bWF0X2F0dHIuYXR0cik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKSB7Cj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga29iamVjdF9wdXQoc2VjdmFyX2tvYmopOwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2Vycigic2VjdmFyOiBGYWlsZWQgdG8gY3JlYXRlIGZv
cm1hdCBvYmplY3RcbiIpOwo+IAo+IFRoaXMgZmlsZSBkZWZpbmVzIHByX2ZtdCwgc28gdGhlIHNl
Y3ZhcjogcHJlZml4IGhlcmUgY2FuIGdvIGF3YXksCj4gdGhvdWdoIEkgbm90aWNlIHRoYXQgaXMg
dGhlIGNhc2UgZm9yIGFsbCB0aGUgZXhpc3RpbmcgcHJpbnRzIGluIHRoaXMKPiBmdW5jdGlvbiB0
b28uCgpZZWFoIHdlIHNob3VsZCBmaXggdGhhdCBmb3IgYWxsIG9mIHRoZW0sIGdvb2QgY2F0Y2gu
Cgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gLUVOT01FTTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsKPiA+IMKgwqDCoMKgwqDC
oMKgwqB9Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoHNlY3Zhcl9rc2V0ID0ga3NldF9jcmVh
dGVfYW5kX2FkZCgidmFycyIsIE5VTEwsCj4gPiBzZWN2YXJfa29iaik7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFzZWN2YXJfa3NldCkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwcl9lcnIoInNlY3Zhcjogc3lzZnMga29iamVjdCByZWdpc3RyYXRpb24KPiA+IGZhaWxl
ZC5cbiIpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtvYmplY3RfcHV0KHNl
Y3Zhcl9rb2JqKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVO
T01FTTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IC1FTk9NRU07Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgfQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqByYyA9IHVwZGF0ZV9rb2JqX3NpemUo
KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcHJfZXJyKCJDYW5ub3QgcmVhZCB0aGUgc2l6ZSBvZiB0aGUgYXR0cmlidXRl
XG4iKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gPiArwqDCoMKgwqDCoMKg
wqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoc2VjdmFyX2NvbmZpZ19hdHRycykgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gc2VjdmFyX3N5c2ZzX2NvbmZp
ZyhzZWN2YXJfa29iaik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJj
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBy
X2Vycigic2VjdmFyOiBGYWlsZWQgdG8gY3JlYXRlIGNvbmZpZwo+ID4gZGlyZWN0b3J5XG4iKTsK
PiAKPiBTYW1lIGNvbW1lbnQgYXMgYWJvdmUKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgCj4gPiDCoMKgwqDCoMKg
wqDCoMKgc2VjdmFyX3N5c2ZzX2xvYWQoKTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7Cj4gPiArZXJyOgo+ID4gK8KgwqDCoMKgwqDCoMKga29iamVjdF9wdXQoc2VjdmFyX2tv
YmopOwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBs
YXRlX2luaXRjYWxsKHNlY3Zhcl9zeXNmc19pbml0KTsKPiAKCg==

