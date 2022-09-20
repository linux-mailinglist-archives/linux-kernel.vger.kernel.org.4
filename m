Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17325BD8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiITAV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITAVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:21:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13225018F;
        Mon, 19 Sep 2022 17:21:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D5225C01E2;
        Mon, 19 Sep 2022 20:21:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Sep 2022 20:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663633280; x=
        1663719680; bh=VbAejdjD9UaMfsDs74NDsg2d+mKxJjZQy4FL4UKO4Oc=; b=h
        0m6f0gYrz52lqRrvTgAlh5LKIGa2/5zTZ/JuIlC0CXTGBos9+lxi8YGMjXb+nndy
        gT9F+Z/GC2NBIW223WocZD2641UvmG9nvhIHXelKbkPFvu4raK+ewbhlGLxQb/Bq
        WyMh2vUea84IZo4U0Q5saPdwpHPMVYhlVKV9MVQc2qHnRZoYJ13JffQrY5mO2Xf4
        Y0HYkWy2mm8uREIkH8xF1hxLgHy560gvwK1fS3O1eR1LjsSeQtWVVZvfSdTaiOEI
        3m3mS2ZHtqfY5YLAhiseqqaj8ISv6aF+fRdllZ5ZwKioHO2SXdvMRJyamLva1kVV
        qMjN3inQ7JgveHxoIihBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663633280; x=
        1663719680; bh=VbAejdjD9UaMfsDs74NDsg2d+mKxJjZQy4FL4UKO4Oc=; b=Y
        2VfrQQ01yFCBmjAeBsMvHXCq9JrHu8ge+niZPUXXAoraaGgvFkf4rBgAlTwaCR6S
        9wWEhu55+kMSjedNj2CuuGdMWgO5rIUOXTqTBxHfIOUrKClLge8uLgU5L+l/GF2v
        Dnc9YBMnjbhIarO8zUVCMYAOUAl96rKII03lnNn856pifKddOLHzxts4diujdvmv
        Kio0Gy3PswLNsmUYmDqv8XCX48sCcYNqSU/iVy0kBXOHJx5e21EYebHPUaBZKN7H
        KTHYQLsuAeFv31W1GaDz8oioPRtf+paU36iFO1km2HdcEF4iBCTx9L/vtnh9eNSu
        7sfK5O3Yt5HFe0NkCIqoQ==
X-ME-Sender: <xms:gAcpY8ENRw_5mVGv8BDtlnjNWmow-cdNx7uG8nCWBU5OqeRt6Lsmqg>
    <xme:gAcpY1VdfqtAochlVc9G-6jGAwIZgKCEBtHuneK9QcJop6fhx9jHJ8BasTW8GAQfz
    Key0c3vpFNmXvdCq74>
X-ME-Received: <xmr:gAcpY2JzZEQVipx5NZwZ8P5YmkEvti13oXopAdxcNHhisdRZoc5Eop9t1D4GiAgHwhzUHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtsgertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeevjeelledugfehtedtleevtdegjeeiteeiffeihfduiefffffffedtteffkedvleen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:gAcpY-GYqv0BukNKba-S50Nqhq1bROArnP0hho5EGKHBRLiiTJ9e0g>
    <xmx:gAcpYyUCrZBMDhFkIZw2WOe1XTLY0Mziqo2F_QauNG97ed6tqb-hNQ>
    <xmx:gAcpYxPEmZqjAG6oBKmeVsXMKV4oWx-9-aXvyiN4ic7ylq_ZkdJJdw>
    <xmx:gAcpY0JlB7ZXgtFKzPEblyCGeM3sXWX7TbgXBBDwzRE7Kh_ztjhY8Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 20:21:16 -0400 (EDT)
Message-ID: <d6a2c31de1cb7e10730926ff0c3630c8c40a0e19.camel@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Expand support of GPU fan to read RPM and
 label
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, corentin.chary@gmail.com, linux@roeck-us.net,
        jdelvare@suse.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Date:   Tue, 20 Sep 2022 12:21:07 +1200
In-Reply-To: <4d55be61-e797-9eec-bf7e-ed675947b04d@redhat.com>
References: <20220916004623.10992-1-luke@ljones.dev>
         <4d55be61-e797-9eec-bf7e-ed675947b04d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTE5IGF0IDEzOjE4ICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+
IEhpIEx1a2UsCj4gCj4gT24gOS8xNi8yMiAwMTo0NiwgTHVrZSBELiBKb25lcyB3cm90ZToKPiA+
IFRoZSBwcmV2aW91c2x5IGFkZGVkIHBhdGNoIHRvIGFkZCBzdXBwb3J0IGZvciBwd20gY2hhbmdl
IGZvciBUVUYKPiA+IGxhcHRvcHMKPiA+IGFsc28gaXMgdXN1YWJsZSBmb3IgbW9yZSB0aGFuIFRV
Ri4gVGhlIHNhbWUgbWV0aG9kIGAweDAwMTEwMDE0YCBpcwo+ID4gdXNlZCB0byByZWFkIHRoZSBm
YW4gUlBNLgo+ID4gCj4gPiBBZGQgdHdvIGV4dHJhIGF0dHJpYnV0ZXMgZm9yIHJlYWRpbmcgZmFu
MiBwbHVzIGZhbjIgbGFiZWwuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgRC4gSm9uZXMg
PGx1a2VAbGpvbmVzLmRldj4KPiA+IC0tLQo+ID4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3Vz
LXdtaS5jIHwgMzYKPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ID4gwqAx
IGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMKPiA+IGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYwo+ID4gaW5kZXggYWU0NmFmNzMxZGU5Li43ZmU2Y2Uy
NWRhMGEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCj4g
PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCj4gPiBAQCAtNzIsNiArNzIs
NyBAQCBtb2R1bGVfcGFyYW0oZm5sb2NrX2RlZmF1bHQsIGJvb2wsIDA0NDQpOwo+ID4gwqAKPiA+
IMKgI2RlZmluZSBBU1VTX1dNSV9GTkxPQ0tfQklPU19ESVNBQkxFRMKgwqBCSVQoMCkKPiA+IMKg
Cj4gPiArI2RlZmluZSBBU1VTX0dQVV9GQU5fREVTQ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAiZ3B1X2ZhbiIKPiA+IMKgI2RlZmluZSBBU1VTX0ZBTl9ERVNDwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgImNwdV9mYW4iCj4gPiDCoCNkZWZpbmUgQVNVU19GQU5fTUZVTsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MTMKPiA+IMKgI2RlZmluZSBBU1VT
X0ZBTl9TRlVOX1JFQUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MDYKPiA+IEBAIC0yMDc4
LDYgKzIwNzksMzAgQEAgc3RhdGljIHNzaXplX3QgYXN1c19od21vbl90ZW1wMShzdHJ1Y3QKPiA+
IGRldmljZSAqZGV2LAo+ID4gwqB9Cj4gPiDCoAo+ID4gwqAvKiBHUFUgZmFuIG9uIG1vZGVybiBS
T0cgbGFwdG9wcyAqLwo+ID4gK3N0YXRpYyBzc2l6ZV90IGZhbjJfaW5wdXRfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUKPiA+ICphdHRyLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYXIgKmJ1ZikKPiA+
ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYXN1c193bWkgKmFzdXMgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCB2YWx1ZTsKPiA+ICvCoMKgwqDCoMKg
wqDCoGludCByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhc3VzX3dtaV9nZXRf
ZGV2c3RhdGUoYXN1cywKPiA+IEFTVVNfV01JX0RFVklEX0dQVV9GQU5fQ1RSTCwgJnZhbHVlKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB2YWx1ZSAmPSAw
eGZmZmY7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIl
ZFxuIiwgdmFsdWUgPCAwID8gLTEgOiB2YWx1ZSAqCj4gPiAxMDApOwo+IAo+IEFzIGFscmVhZHkg
bWVudGlvbmVkIHNpbmNlIHlvdSAmIHdpdGggMHhmZmZmIGFib3ZlIHRoZSBzaWduIGJpdCBjYW4K
PiBuZXZlciBiZQo+IHNldCwgc28gdGhlIHZhbHVlIGlzIG5ldmVyIGxlc3MgdGhlbiA8IDAsIHNv
IEkgaGF2ZSBzaW1wbGlmaWVkIHRoaXMKPiB0bzoKPiAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIHZhbHVlICogMTAwKTsKPiAKPiB3aGlsZSBtZXJnaW5n
LgoKVGhhbmtzIEhhbnMgcmVhbGx5IGFwcHJlY2lhdGUgaXQsIHNvcnJ5IGkgbWlzc2VkIHRoYXQu
IE15IHdvcmtsb2FkIGlzIGEKYml0IHRvbyBsYXJnZSBhdCB0aGUgbW9tZW50IDopCgpDaGVlcnMs
Ckx1a2UuCgo+IAo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3NpemVfdCBmYW4yX2xhYmVsX3No
b3coc3RydWN0IGRldmljZSAqZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlCj4gPiAqYXR0ciwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjaGFyICpidWYpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHNwcmludGYoYnVm
LCAiJXNcbiIsIEFTVVNfR1BVX0ZBTl9ERVNDKTsKPiA+ICt9Cj4gCj4gQW5kIGhlcmUgSSBoYXZl
IGRvbmUgcy9zcHJpbnRmL3N5c2ZzX2VtaXQvIHdpdGggdGhvc2UgY2hhbmdlcwo+IEkndmUgYXBw
bGllZCB0aGlzIHBhdGNoIHRvIG15IHJldmlldy1oYW5zIGJyYW5jaDoKPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZHg4Ni9wbGF0Zm9ybS1kcml2ZXJz
LXg4Ni5naXQvbG9nLz9oPXJldmlldy1oYW5zCj4gCj4gTm90ZSBpdCB3aWxsIHNob3cgdXAgaW4g
bXkgcmV2aWV3LWhhbnMgYnJhbmNoIG9uY2UgSSd2ZSBwdXNoZWQgbXkKPiBsb2NhbCBicmFuY2gg
dGhlcmUsIHdoaWNoIG1pZ2h0IHRha2UgYSB3aGlsZS4KPiAKPiBPbmNlIEkndmUgcnVuIHNvbWUg
dGVzdHMgb24gdGhpcyBicmFuY2ggdGhlIHBhdGNoZXMgdGhlcmUgd2lsbCBiZQo+IGFkZGVkIHRv
IHRoZSBwbGF0Zm9ybS1kcml2ZXJzLXg4Ni9mb3ItbmV4dCBicmFuY2ggYW5kIGV2ZW50dWFsbHkK
PiB3aWxsIGJlIGluY2x1ZGVkIGluIHRoZSBwZHg4NiBwdWxsLXJlcXVlc3QgdG8gTGludXMgZm9y
IHRoZSBuZXh0Cj4gbWVyZ2Utd2luZG93Lgo+IAo+IFJlZ2FyZHMsCj4gCj4gSGFucwo+IAo+IAo+
IAo+ID4gKwo+ID4gwqBzdGF0aWMgc3NpemVfdCBwd20yX2VuYWJsZV9zaG93KHN0cnVjdCBkZXZp
Y2UgKmRldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjaGFyICpidWYpCj4gPiBAQCAtMjEyNyw5ICsyMTUyLDEyIEBAIHN0YXRpYyBzc2l6ZV90
IHB3bTJfZW5hYmxlX3N0b3JlKHN0cnVjdAo+ID4gZGV2aWNlICpkZXYsCj4gPiDCoC8qIEZhbjEg
Ki8KPiA+IMKgc3RhdGljIERFVklDRV9BVFRSX1JXKHB3bTEpOwo+ID4gwqBzdGF0aWMgREVWSUNF
X0FUVFJfUlcocHdtMV9lbmFibGUpOwo+ID4gLXN0YXRpYyBERVZJQ0VfQVRUUl9SVyhwd20yX2Vu
YWJsZSk7Cj4gPiDCoHN0YXRpYyBERVZJQ0VfQVRUUl9STyhmYW4xX2lucHV0KTsKPiA+IMKgc3Rh
dGljIERFVklDRV9BVFRSX1JPKGZhbjFfbGFiZWwpOwo+ID4gKy8qIEZhbjIgLSBHUFUgZmFuICov
Cj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JXKHB3bTJfZW5hYmxlKTsKPiA+ICtzdGF0aWMgREVW
SUNFX0FUVFJfUk8oZmFuMl9pbnB1dCk7Cj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JPKGZhbjJf
bGFiZWwpOwo+ID4gwqAKPiA+IMKgLyogVGVtcGVyYXR1cmUgKi8KPiA+IMKgc3RhdGljIERFVklD
RV9BVFRSKHRlbXAxX2lucHV0LCBTX0lSVUdPLCBhc3VzX2h3bW9uX3RlbXAxLCBOVUxMKTsKPiA+
IEBAIC0yMTQwLDYgKzIxNjgsOCBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqaHdtb25fYXR0
cmlidXRlc1tdID0KPiA+IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfcHdtMl9lbmFi
bGUuYXR0ciwKPiA+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfZmFuMV9pbnB1dC5hdHRyLAo+
ID4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl9mYW4xX2xhYmVsLmF0dHIsCj4gPiArwqDCoMKg
wqDCoMKgwqAmZGV2X2F0dHJfZmFuMl9pbnB1dC5hdHRyLAo+ID4gK8KgwqDCoMKgwqDCoMKgJmRl
dl9hdHRyX2ZhbjJfbGFiZWwuYXR0ciwKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgJmRldl9h
dHRyX3RlbXAxX2lucHV0LmF0dHIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgTlVMTAo+ID4gQEAgLTIx
NjAsNyArMjE5MCw5IEBAIHN0YXRpYyB1bW9kZV90Cj4gPiBhc3VzX2h3bW9uX3N5c2ZzX2lzX3Zp
c2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHx8
IGF0dHIgPT0gJmRldl9hdHRyX3B3bTFfZW5hYmxlLmF0dHIpIHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGFzdXMtPmZhbl90eXBlID09IEZBTl9UWVBFX05PTkUpCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
MDsKPiA+IC3CoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoYXR0ciA9PSAmZGV2X2F0dHJfcHdtMl9l
bmFibGUuYXR0cikgewo+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIGlmIChhdHRyID09ICZkZXZf
YXR0cl9mYW4yX2lucHV0LmF0dHIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB8fCBhdHRyID09
ICZkZXZfYXR0cl9mYW4yX2xhYmVsLmF0dHIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB8fCBh
dHRyID09ICZkZXZfYXR0cl9wd20yX2VuYWJsZS5hdHRyKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChhc3VzLT5ncHVfZmFuX3R5cGUgPT0gRkFOX1RZUEVfTk9ORSkK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoYXR0ciA9PSAmZGV2X2F0dHJfdGVt
cDFfaW5wdXQuYXR0cikgewo+IAoK

