Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D08682255
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjAaCoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAaCoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:44:00 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E13526E;
        Mon, 30 Jan 2023 18:43:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 39D065C0538;
        Mon, 30 Jan 2023 21:43:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Jan 2023 21:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1675133035; x=
        1675219435; bh=Lw3BTNjw1z5tIita9M1yTykNXOkxFT8Y+0NmfodF47I=; b=s
        y+l8OzNeqsXTsDaSr4JCPj78O9RuH2YaWRFx3DSr/xs725/onPftkPoW60d4luCS
        3SUfmRO7gDnXDR6EZv2zCP/1T3OvZ/2qE90XCaO2ScWoeyP7F13Qw631/ABpRvRp
        iDjXmwTZxVB63GgEfJvM7MYP9z/PRQyrTMn/oSCrtFKFNRpn+ZrHwtv6q7PjEErq
        ZftMY1Sqx4DeVby7cu9tNsB0CThE8+xt82gZLqSuSfjHN6pwfKh/XzfQZmZuUAXe
        cWa5z4LQxGhJqp1ap7YqQ3wy3aozssfU6vbQkE8qcMq8mEjxiizglc6Y2HeR2xe9
        OWlLPZ294CY2Tm7G34Fqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675133035; x=
        1675219435; bh=Lw3BTNjw1z5tIita9M1yTykNXOkxFT8Y+0NmfodF47I=; b=X
        dTx3I1HNhUBm7zNfZAvPaRhCBqOpmDfeFCJLNUqDiW7noKhMLGDxVuibuKYXyMLo
        H1gWO2XIvlCpO4HFKFnOwuh8dZphQeqoM41HojlRJGr9ZgL2lSPtqCxngu9GSZRy
        dlqh6UT3OWWZ0KjbaoAKizZ3xuHwoObQdC/klPHjIrS1oaGD9vxZUsbQk1h4LGka
        uDukGl5XGg31agjbsbqGfiYhxLl4oHNKGMMTmws/E8GusdpXwSo5OgUOikDdUg+n
        cabHCw8XRgI2HqqEnRALvrB9FzqQzRY/2ukHJqOeXUVP4o12BcahzG6SnGbAaXs7
        UVdHVOd13QMUSbeAxWyQQ==
X-ME-Sender: <xms:aoDYY24wa32cur2nTEMGb2Myda9oedrTXiO4t_jRSXXEpszsxzRZcQ>
    <xme:aoDYY_6OhAWxkdXEr5r42n7eIEmy8Mlh_e11rixCJyZFa9XbH_2anAtea6MhH-ow-
    sDZKJ6D5oK9zrdaNA>
X-ME-Received: <xmr:aoDYY1ducX8lt-YMg6kHG6KWzf19MfUTd14fEyknHyL6dHPvYzBDigwDL3cdeMpLwJgGBNlazkj9BOd8NcKimFqrFoUHg0i4P7cY5MpLBVdAiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeffedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthgsredt
    tderjeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruh
    hsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhepheduieduhedtueefueegfffguddu
    gfffveekvefgteethedvfedvheeuhffghefhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:aoDYYzKRhZvhIrKrMOSz1SxRxmOIqOC9wgKSTDOwHYfRKmCV7oFFzw>
    <xmx:aoDYY6KCraqefrlhsdx5r2i2GdGD48VTzhsolxnVOqL_Lcdi4bRtaQ>
    <xmx:aoDYY0zHfPmYfl56XcAsSZ-oJlH6q2t6Yg6BQFFQOP_YVhDroWNjNQ>
    <xmx:a4DYY8Cxh_cFY9qUkWSc9T5JduFjdxS74BKgU9rXawNmgFcywYLRkA>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 21:43:50 -0500 (EST)
Message-ID: <ae746d6137e5a215c7370d23d367c6dda7a57c90.camel@russell.cc>
Subject: Re: [PATCH v4 21/24] powerpc/pseries: Pass PLPKS password on kexec
From:   Russell Currey <ruscur@russell.cc>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, gcwilson@linux.ibm.com, joel@jms.id.au
Date:   Tue, 31 Jan 2023 13:43:46 +1100
In-Reply-To: <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-22-ajd@linux.ibm.com>
         <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE0OjM2ICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
Cj4gT24gRnJpIEphbiAyMCwgMjAyMyBhdCA1OjQzIFBNIEFFU1QsIEFuZHJldyBEb25uZWxsYW4g
d3JvdGU6Cj4gPiBGcm9tOiBSdXNzZWxsIEN1cnJleSA8cnVzY3VyQHJ1c3NlbGwuY2M+Cj4gPiAK
PiA+IEJlZm9yZSBpbnRlcmFjdGluZyB3aXRoIHRoZSBQTFBLUywgd2UgYXNrIHRoZSBoeXBlcnZp
c29yIHRvCj4gPiBnZW5lcmF0ZSBhCj4gPiBwYXNzd29yZCBmb3IgdGhlIGN1cnJlbnQgYm9vdCwg
d2hpY2ggaXMgdGhlbiByZXF1aXJlZCBmb3IgbW9zdAo+ID4gZnVydGhlcgo+ID4gUExQS1Mgb3Bl
cmF0aW9ucy4KPiA+IAo+ID4gSWYgd2Uga2V4ZWMgaW50byBhIG5ldyBrZXJuZWwsIHRoZSBuZXcg
a2VybmVsIHdpbGwgdHJ5IGFuZCBmYWlsIHRvCj4gPiBnZW5lcmF0ZSBhIG5ldyBwYXNzd29yZCwg
YXMgdGhlIHBhc3N3b3JkIGhhcyBhbHJlYWR5IGJlZW4gc2V0Lgo+ID4gCj4gPiBQYXNzIHRoZSBw
YXNzd29yZCB0aHJvdWdoIHRvIHRoZSBuZXcga2VybmVsIHZpYSB0aGUgZGV2aWNlIHRyZWUsIGlu
Cj4gPiAvY2hvc2VuL3BscGtzLXB3LiBDaGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIHRoaXMgcHJv
cGVydHkgYmVmb3JlCj4gPiB0cnlpbmcKPiAKPiBJbiAvY2hvc2VuL2libSxwbHBrcy1wdwoKR29v
ZCBjYXRjaCwgdGhhbmtzCgo+IAo+ID4gdG8gZ2VuZXJhdGUgYSBuZXcgcGFzc3dvcmQgLSBpZiBp
dCBleGlzdHMsIHVzZSB0aGUgZXhpc3RpbmcKPiA+IHBhc3N3b3JkIGFuZAo+ID4gcmVtb3ZlIGl0
IGZyb20gdGhlIGRldmljZSB0cmVlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxsIEN1
cnJleSA8cnVzY3VyQHJ1c3NlbGwuY2M+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRG9ubmVs
bGFuIDxhamRAbGludXguaWJtLmNvbT4KPiA+IAo+ID4gLS0tCj4gPiAKPiA+IHYzOiBOZXcgcGF0
Y2gKPiA+IAo+ID4gdjQ6IEZpeCBjb21waWxlIHdoZW4gQ09ORklHX1BTRVJJRVNfUExQS1M9biAo
c25vd3BhdGNoKQo+ID4gCj4gPiDCoMKgwqAgRml4IGVycm9yIGhhbmRsaW5nIG9uIGZkdF9wYXRo
X29mZnNldCgpIGNhbGwgKHJ1c2N1cikKPiA+IC0tLQo+ID4gwqBhcmNoL3Bvd2VycGMva2V4ZWMv
ZmlsZV9sb2FkXzY0LmPCoMKgwqDCoMKgIHwgMTggKysrKysrKysrKysrKysrKysrCj4gPiDCoGFy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrcy5jIHwgMTggKysrKysrKysrKysrKysr
KystCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tleGVjL2ZpbGVfbG9hZF82NC5j
Cj4gPiBiL2FyY2gvcG93ZXJwYy9rZXhlYy9maWxlX2xvYWRfNjQuYwo+ID4gaW5kZXggYWY4ODU0
ZjllYWUzLi4wYzkxMzBhZjYwY2MgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMva2V4ZWMv
ZmlsZV9sb2FkXzY0LmMKPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXhlYy9maWxlX2xvYWRfNjQu
Ywo+ID4gQEAgLTI3LDYgKzI3LDcgQEAKPiA+IMKgI2luY2x1ZGUgPGFzbS9rZXhlY19yYW5nZXMu
aD4KPiA+IMKgI2luY2x1ZGUgPGFzbS9jcmFzaGR1bXAtcHBjNjQuaD4KPiA+IMKgI2luY2x1ZGUg
PGFzbS9wcm9tLmg+Cj4gPiArI2luY2x1ZGUgPGFzbS9wbHBrcy5oPgo+ID4gwqAKPiA+IMKgc3Ry
dWN0IHVtZW1faW5mbyB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTY0ICpidWY7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLyogZGF0YSBidWZmZXIgZm9yIHVzYWJsZS1tZW1vcnkKPiA+IHBy
b3BlcnR5ICovCj4gPiBAQCAtMTE1Niw2ICsxMTU3LDkgQEAgaW50IHNldHVwX25ld19mZHRfcHBj
NjQoY29uc3Qgc3RydWN0IGtpbWFnZQo+ID4gKmltYWdlLCB2b2lkICpmZHQsCj4gPiDCoHsKPiA+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3Jhc2hfbWVtICp1bWVtID0gTlVMTCwgKnJtZW0gPSBO
VUxMOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGludCBpLCBucl9yYW5nZXMsIHJldDsKPiA+ICsjaWZk
ZWYgQ09ORklHX1BTRVJJRVNfUExQS1MKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBjaG9zZW5fb2Zm
c2V0Owo+ID4gKyNlbmRpZgo+IAo+IENvdWxkIHB1dCB0aGlzIGluIHBscGtzX2lzX2F2YWlsYWJs
ZSBhbmQgYXZvaWQgYW4gaWZkZWYuCgpZZXAsIG1vdmluZyB0aGlzIG91dCwgdGhvdWdoIG5vdCBp
bnRvIHBscGtzX2lzX2F2YWlsYWJsZSgpLgoKPiAKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKg
LyoKPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiBSZXN0cmljdCBtZW1vcnkgdXNhZ2UgZm9yIGtkdW1w
IGtlcm5lbCBieSBzZXR0aW5nIHVwCj4gPiBAQCAtMTIzMCw2ICsxMjM0LDIwIEBAIGludCBzZXR1
cF9uZXdfZmR0X3BwYzY0KGNvbnN0IHN0cnVjdCBraW1hZ2UKPiA+ICppbWFnZSwgdm9pZCAqZmR0
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgfQo+ID4gwqAKPiA+ICsjaWZkZWYgQ09ORklHX1BTRVJJRVNfUExQS1MKPiA+ICvCoMKgwqDC
oMKgwqDCoC8vIElmIHdlIGhhdmUgUExQS1MgYWN0aXZlLCB3ZSBuZWVkIHRvIHByb3ZpZGUgdGhl
IHBhc3N3b3JkCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocGxwa3NfaXNfYXZhaWxhYmxlKCkpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaG9zZW5fb2Zmc2V0ID0gZmR0X3Bh
dGhfb2Zmc2V0KGZkdCwgIi9jaG9zZW4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoY2hvc2VuX29mZnNldCA8IDApIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKCJDYW4ndCBmaW5kIGNob3NlbiBub2RlOiAl
c1xuIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZkdF9zdHJlcnJvcihjaG9zZW5fb2Zmc2V0KSk7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXQgPSBmZHRfc2V0cHJvcChmZHQsIGNob3Nlbl9vZmZzZXQsICJpYm0scGxwa3MtCj4g
PiBwdyIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwbHBrc19nZXRfcGFzc3dvcmQoKSwKPiA+IHBscGtzX2dldF9w
YXNzd29yZGxlbigpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsjZW5kaWYgLy8gQ09ORklH
X1BTRVJJRVNfUExQS1MKPiAKPiBJIHRoaW5rIGlmIHlvdSBkZWZpbmUgcGxwa3NfZ2V0X3Bhc3N3
b3JkIGFuZCBwbHBrc19nZXRfcGFzc3dvcmRsZW4gYXMKPiBCVUlMRF9CVUdfT04gd2hlbiBQTFBL
UyBpcyBub3QgY29uZmlndXJlZCBhbmQgcGxwa3NfaXNfYXZhaWxhYmxlIGFzCj4gZmFsc2UsIHlv
dSBjb3VsZCByZW1vdmUgdGhlIGlmZGVmIGVudGlyZWx5LgoKSSdtIG1vdmluZyB0aGlzIGludG8g
YSBoZWxwZXIgaW4gcGxwa3MuYyBzaW5jZSBub3cgdGhlcmUncyBGRFQgaGFuZGxpbmcKaW4gZWFy
bHkgYm9vdCBpbiB0aGVyZS4gIFdlIGNhbiBkcm9wIHBscGtzX2dldF9wYXNzd29yZCgpIGVudGly
ZWx5LgoKPiAKPiA+ICsKPiA+IMKgb3V0Ogo+ID4gwqDCoMKgwqDCoMKgwqDCoGtmcmVlKHJtZW0p
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoGtmcmVlKHVtZW0pOwo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrcy5jCj4gPiBiL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9wbHBrcy5jCj4gPiBpbmRleCBiM2M3NDEwYTRmMTMuLjAzNTBmMTBlMTc1
NSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrcy5j
Cj4gPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGxwa3MuYwo+ID4gQEAg
LTE2LDYgKzE2LDcgQEAKPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiA+IMKgI2luY2x1
ZGUgPGxpbnV4L3N0cmluZy5oPgo+ID4gwqAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPiA+ICsj
aW5jbHVkZSA8bGludXgvb2YuaD4KPiA+IMKgI2luY2x1ZGUgPGFzbS9odmNhbGwuaD4KPiA+IMKg
I2luY2x1ZGUgPGFzbS9tYWNoZGVwLmg+Cj4gPiDCoCNpbmNsdWRlIDxhc20vcGxwa3MuaD4KPiA+
IEBAIC0xMjYsNyArMTI3LDIyIEBAIHN0YXRpYyBpbnQgcGxwa3NfZ2VuX3Bhc3N3b3JkKHZvaWQp
Cj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHJldGJ1ZltQTFBBUl9I
Q0FMTF9CVUZTSVpFXSA9IHsgMCB9Owo+ID4gwqDCoMKgwqDCoMKgwqDCoHU4ICpwYXNzd29yZCwg
Y29uc3VtZXIgPSBQTFBLU19PU19PV05FUjsKPiA+IC3CoMKgwqDCoMKgwqDCoGludCByYzsKPiA+
ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsKPiA+ICvCoMKgwqDCoMKgwqDC
oGludCByYywgbGVuOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLy8gQmVmb3JlIHdlIGdlbmVy
YXRlIHRoZSBwYXNzd29yZCwgd2UgbWF5IGhhdmUgYmVlbiBib290ZWQKPiA+IGJ5IGtleGVjIGFu
ZAo+ID4gK8KgwqDCoMKgwqDCoMKgLy8gcHJvdmlkZWQgd2l0aCBhIHByZXZpb3VzIHBhc3N3b3Jk
LsKgIENoZWNrIGZvciB0aGF0Cj4gPiBmaXJzdC4KPiAKPiBTbyBub3QgcmVhbGx5IGdlbmVyYXRp
bmcgdGhlIHBhc3N3b3JkIHRoZW4uIFNob3VsZCBpdCBiZSBpbiBhCj4gZGlmZmVyZW50Cj4gZnVu
Y3Rpb24gdGhlIGNhbGxlciBtYWtlcyBmaXJzdD8KClllcyB0aGlzIHNob3VsZCBoYXZlIGJlZW4g
c2VwYXJhdGUsIGFuZCBub3cgaGFzIHRvIGJlIGFueXdheSBzaW5jZQp3ZSdyZSByZXRyaWV2aW5n
IHRoZSBwYXNzd29yZCBmcm9tIHRoZSBGRFQgaW4gZWFybHkgYm9vdC4KCj4gCj4gPiArwqDCoMKg
wqDCoMKgwqBwcm9wID0gb2ZfZmluZF9wcm9wZXJ0eShvZl9jaG9zZW4sICJpYm0scGxwa3MtcHci
LCAmbGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwcm9wKSB7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgb3NwYXNzd29yZGxlbmd0aCA9ICh1MTYpbGVuOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9zcGFzc3dvcmQgPSBremFsbG9jKG9zcGFzc3dvcmRs
ZW5ndGgsIEdGUF9LRVJORUwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICghb3NwYXNzd29yZCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBvZl9yZW1vdmVfcHJvcGVydHkob2ZfY2hvc2VuLCBwcm9wKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG1lbWNweShvc3Bhc3N3b3JkLCBwcm9wLT52YWx1ZSwgbGVuKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gb2ZfcmVtb3ZlX3Byb3BlcnR5
KG9mX2Nob3NlbiwgcHJvcCk7Cj4gCj4gV2h5IGRvIHlvdSByZW1vdmUgdGhlIHByb3BlcnR5IGFm
dGVyd2FyZD8KCkFzIEFuZHJldyBtZW50aW9uZWQsIHNvIHdlIGRvbid0IGhhdmUgYSBwYXNzd29y
ZCBsaW5nZXJpbmcgaW4gdGhlCmRldmljZSB0cmVlLCB0aG91Z2ggaXQncyBub3QgZXNwZWNpYWxs
eSB1c2VmdWwuICBXZSdyZSBnb2luZyB0byBnZXQgaXQKYW5kIGNsZWFyIGl0IGZyb20gdGhlIEZE
VCBpbiBlYXJseSBib290IGluc3RlYWQuCgo+IAo+IFRoYW5rcywKPiBOaWNrCgo=

