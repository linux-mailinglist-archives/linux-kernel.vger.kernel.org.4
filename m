Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242A6629CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiKOOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiKOOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:52:05 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22BF2D1DA;
        Tue, 15 Nov 2022 06:51:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n12so36549105eja.11;
        Tue, 15 Nov 2022 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vln55Gn41j3SY3rRCOnm36b/W/eClfQBXC/fqwicP80=;
        b=FPUflUumk/88cAPAbU6MgYuLOLW48eEAwn4ojoshAY+EMQoNdF7Te0fVCyo76Na9OG
         QYgRbbO2UwUYgdfNRYFAZrv1W0DpDqiMbeZcy1Jo7Aq3nRql37+/6uBTMdjSQVTir4bC
         qfssW8rUuS7redpyXw1zJFtIvauBZgxZROaha7+QpnHu+7J+jgcb/viKdEynkI6zmQ4f
         evddXSSdvc4pCaswtgMvv12Xcf6nKbLytY+qJPUzbRtLza6fVoSy+pvxvkc9Pi9P/iKK
         d3/OpX+lU8mBoBUM/aVqf7/kfo+OSvS56T77jTYgXnSCVJSvLxocrAjhWlAIUTIJq44T
         P55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vln55Gn41j3SY3rRCOnm36b/W/eClfQBXC/fqwicP80=;
        b=VzvRPEsLwUBACASE0UaPkbUXIH+dJS31ohrwQ1dCcYVXqJtJ0+KE4Zll+Y5AuBP5/5
         YecnPL+5+AGjNwKeoi6XqvmWM6tzS31XokZYp7WIsaBXB22Yd/vE5Vijsfm+QcvRb1UP
         NEesfS6C0rhslly7guCavodJzXMFjRGPfryjVeAgHZhai+nK7hoLUcEXyPwlp6QNg4IU
         tTORZ3ThCeHFewhROswkHm5Mu3y7eMTK1uRjXqSsLndA5uCCH0QCWk7jW93+RU8DV7w4
         GZeuPs+niZy+KLzgNjiPWwkj9vUvuL480eTXkkYuBpgoMx6uWZEaqJyNNP6TtHBYvLbz
         RhaQ==
X-Gm-Message-State: ANoB5pkyJ18BDkikR/AQEfKW0yvzy8O94g3XSBAg6rqxgvgY9M88HkJE
        z5E7I2osB1SDfb4fA3K3EOw=
X-Google-Smtp-Source: AA0mqf7IwTT0rkcCgJ7gEmH2GhJyxDfo9BTwtBBog0ttBey4iQRdOWUZfesNzBmwyL1Bs7LnmQlYmQ==
X-Received: by 2002:a17:907:2348:b0:78d:f796:c00d with SMTP id we8-20020a170907234800b0078df796c00dmr13731184ejb.251.1668523896079;
        Tue, 15 Nov 2022 06:51:36 -0800 (PST)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906328300b007aec1b39478sm5513653ejw.188.2022.11.15.06.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:51:35 -0800 (PST)
Message-ID: <27be5a5bf23fbea31d82cf2e7b3f9747d7c610eb.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 15:53:06 +0100
In-Reply-To: <20221111143921.742194-6-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
         <20221111143921.742194-6-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDE1OjM5ICswMTAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Ogo+IFdlIGhhdmUgYSBib2FyZCB3aGVyZSB0aGUgcmVzZXQgcGluIG9mIHRoZSBhZDc0NDEyIGlz
IGNvbm5lY3RlZCB0byBhCj4gZ3BpbywgYnV0IGFsc28gcHVsbGVkIGxvdyBieSBkZWZhdWx0LiBI
ZW5jZSB0byBnZXQgdGhlIGNoaXAgb3V0IG9mCj4gcmVzZXQsIHRoZSBkcml2ZXIgbmVlZHMgdG8g
a25vdyBhYm91dCB0aGF0IGdwaW8gYW5kIHNldCBpdCBoaWdoCj4gYmVmb3JlCj4gYXR0ZW1wdGlu
ZyB0byBjb21tdW5pY2F0ZSB3aXRoIGl0Lgo+IAo+IFdoZW4gYSByZXNldC1ncGlvIGlzIGdpdmVu
IGluIGRldmljZSB0cmVlLCB1c2UgdGhhdCBpbnN0ZWFkIG9mIHRoZQo+IHNvZnR3YXJlIHJlc2V0
LiBBY2NvcmRpbmcgdG8gdGhlIGRhdGEgc2hlZXQsIHRoZSB0d28gbWV0aG9kcyBhcmUKPiBmdW5j
dGlvbmFsbHkgZXF1aXZhbGVudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2Vz
IDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+Cj4gLS0tCj4gwqBkcml2ZXJzL2lpby9hZGRhYy9h
ZDc0NDEzci5jIHwgMTIgKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGRhYy9hZDc0NDEzci5jCj4g
Yi9kcml2ZXJzL2lpby9hZGRhYy9hZDc0NDEzci5jCj4gaW5kZXggOWY3N2QyZjUxNGRlLi5hZjA5
ZDQzZjkyMWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9paW8vYWRkYWMvYWQ3NDQxM3IuYwo+ICsr
KyBiL2RyaXZlcnMvaWlvL2FkZGFjL2FkNzQ0MTNyLmMKPiBAQCAtNzEsNiArNzEsNyBAQCBzdHJ1
Y3QgYWQ3NDQxM3Jfc3RhdGUgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmVnbWFwwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqcmVnbWFwOwo+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgZGV2aWNlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqZGV2
Owo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWlvX3RyaWdnZXLCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKnRyaWc7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGdwaW9fZGVzY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnJlc2V0X2dwaW87Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgc2l6ZV90wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRjX2FjdGl2ZV9j
aGFubmVsczsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNwaV9tZXNzYWdlwqDCoMKgwqDCoMKg
YWRjX3NhbXBsZXNfbXNnOwo+IEBAIC0zOTMsNiArMzk0LDEzIEBAIHN0YXRpYyBpbnQgYWQ3NDQx
M3JfcmVzZXQoc3RydWN0IGFkNzQ0MTNyX3N0YXRlCj4gKnN0KQo+IMKgewo+IMKgwqDCoMKgwqDC
oMKgwqBpbnQgcmV0Owo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHN0LT5yZXNldF9ncGlvKSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW9kX3NldF92YWx1ZV9jYW5zbGVl
cChzdC0+cmVzZXRfZ3BpbywgMSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZz
bGVlcCg1MCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW9kX3NldF92YWx1
ZV9jYW5zbGVlcChzdC0+cmVzZXRfZ3BpbywgMCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKgwqDCoMKgwqDC
oHJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDc0NDEzUl9SRUdfQ01EX0tFWSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFENzQ0
MTNSX0NNRF9LRVlfUkVTRVQxKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiBAQCAtMTMx
Niw2ICsxMzI0LDEwIEBAIHN0YXRpYyBpbnQgYWQ3NDQxM3JfcHJvYmUoc3RydWN0IHNwaV9kZXZp
Y2UKPiAqc3BpKQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHN0LT5yZWdtYXApKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoc3QtPnJlZ21hcCk7
Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBzdC0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29w
dGlvbmFsKHN0LT5kZXYsICJyZXNldCIsCj4gR1BJT0RfT1VUX0xPVyk7Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgKElTX0VSUihzdC0+cmVzZXRfZ3BpbykpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBQVFJfRVJSKHN0LT5yZXNldF9ncGlvKTsKPiArCgpNaW5vciB0aGluZyBi
dXQsCgpJIHdvdWxkIG1vdmUgdGhpcyBpbnRvIGFkNzQ0MTNyX3Jlc2V0KCkgYXMgdGhlcmUncyBu
byByZWFsIG5lZWQgdG8gaGF2ZQp0aGUgZ3Bpb19kZXNjIGluIHN0cnVjdCBhZDc0NDEzcl9zdGF0
ZS4KCi0gTnVubyBTw6EgCg==

