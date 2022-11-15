Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4251D6298F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKOMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKOMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:34:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EED639F;
        Tue, 15 Nov 2022 04:34:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d7so6942788qkk.3;
        Tue, 15 Nov 2022 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NMKzybMgnpU4TUhL0A5Twqvf3zje33/2luEIlnv0GQ=;
        b=WLxqYB36WUsha4pjzeNfh1yZJsNXUQWlai7vklI/hEhzFTBPAFPUcaOv1RmZcVi5tB
         yTX/v3128BuY3oOlXpfdWPSTdfOMQ9LGRV0mOAXzNGLD/jiCsy1RkExHjbzRzCctmApR
         vdaitWpycBAzd9hEyjahvTCChXjyinrCLM08sJpxdFdDN5BPdNgUmtQK38AK+0Y0Ot3+
         vgbP5jxDUM3YwSWVB40Mq2wqyvv8NCz3zHHhSPxPusQrzBbhC4XxRTVEdbreocQUmJP5
         r1kjybVuKiA+T9JE+G6LtWDH2QgMdGOG+qa5e+xwgRx3uH/fz+LHPNDtmDfZ2R4kzCIS
         wpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NMKzybMgnpU4TUhL0A5Twqvf3zje33/2luEIlnv0GQ=;
        b=LIziIt4rgzvJZuEKeAzMF7EN+UxjjyzN4rf+jg0JHUA+OX4uXssn4PlMYBqSYxZ1A2
         cUhpabRLja9g4vYPoJg5jEc6XGJOasyVGaG87i2LFGoxG6q1bmGkl3vZ7+bxo1tvHB2i
         kjVVZ5+ekGfcRaoGAyLTAeI0CFJCEcINLO5Epksto+qrKeDbhGa3ounICtA1BysP+sLT
         oY3ZPGgvJh1IPX6wvvLe51M4eYACtP7ypfLK/EcVhFVovsafEbxsv26nItn6SMQsTbOo
         KJnK+xuzKCAZ+B+DRTwXSJ/0ZJ5d8TissQLZ8XHMesUE7lUK3/MihTxrIs7D5+cM1UxX
         5qog==
X-Gm-Message-State: ANoB5pnnrNhRasfbULaP9lErFLry9FDNmHK+LLwZYhoR0GgFfVexxr2b
        ZhtsurAOB49aH2o7+lBOtyk=
X-Google-Smtp-Source: AA0mqf5GJ15iHgzZlGUop1p5rJSvKvHb0butMyYksjt1xuobC+xWtg3OhbQrWMcfGh8qGfnPAYGhsA==
X-Received: by 2002:a37:be81:0:b0:6fa:ece6:7c5e with SMTP id o123-20020a37be81000000b006faece67c5emr15003173qkf.466.1668515686181;
        Tue, 15 Nov 2022 04:34:46 -0800 (PST)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006fb7c42e73asm3613148qkp.21.2022.11.15.04.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:34:45 -0800 (PST)
Message-ID: <2a6c721b8c27b4631f424e7c68e11a2409005261.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: frequency: adf4377: add support for ADF4377
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 13:36:14 +0100
In-Reply-To: <20221106175139.093edcd9@jic23-huawei>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
         <20221104092802.90725-3-antoniu.miclaus@analog.com>
         <3417a0fd87e6f13207690e49b797f2d2689f802a.camel@gmail.com>
         <20221106175139.093edcd9@jic23-huawei>
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

T24gU3VuLCAyMDIyLTExLTA2IGF0IDE3OjUxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIEZyaSwgMDQgTm92IDIwMjIgMTI6Mzg6MDcgKzAxMDAKPiBOdW5vIFPDoSA8bm9uYW1l
Lm51bm9AZ21haWwuY29tPiB3cm90ZToKPiAKPiA+IE9uIEZyaSwgMjAyMi0xMS0wNCBhdCAxMToy
OCArMDIwMCwgQW50b25pdSBNaWNsYXVzIHdyb3RlOgo+ID4gPiBUaGUgQURGNDM3NyBpcyBhIGhp
Z2ggcGVyZm9ybWFuY2UsIHVsdHJhbG93IGppdHRlciwgZHVhbCBvdXRwdXQKPiA+ID4gaW50ZWdl
ci1OCj4gPiA+IHBoYXNlZCBsb2NrZWQgbG9vcCAoUExMKSB3aXRoIGludGVncmF0ZWQgdm9sdGFn
ZSBjb250cm9sbGVkCj4gPiA+IG9zY2lsbGF0b3IKPiA+ID4gKFZDTykgaWRlYWxseSBzdWl0ZWQg
Zm9yIGRhdGEgY29udmVydGVyIGFuZCBtaXhlZCBzaWduYWwgZnJvbnQKPiA+ID4gZW5kCj4gPiA+
IChNeEZFKQo+ID4gPiBjbG9jayBhcHBsaWNhdGlvbnMuCj4gPiA+IAo+ID4gPiBEYXRhc2hlZXQ6
Cj4gPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50
YXRpb24vZGF0YS1zaGVldHMvYWRmNDM3Ny5wZGYKPiA+ID4gU2lnbmVkLW9mZi1ieTogQW50b25p
dSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4KPiAKPiBOdW5vLCBwbGVhc2Ug
Y3JvcCB0byB0aGUgYml0IHlvdSBjb21tZW50IG9uLsKgIERvb20gc2Nyb2xsaW5nIGlzbid0Cj4g
ZnVuIDspCj4gCgpSaWdodCwgc29ycnkgYWJvdXQgdGhhdCA6KQoKPiBBIGZldyBmb2xsb3cgdXAg
Y29tbWVudHMgaW5saW5lLgo+IAo+IEpvbmF0aGFuCj4gCj4gPiA+IC0tLQo+ID4gPiDCoGRyaXZl
cnMvaWlvL2ZyZXF1ZW5jeS9LY29uZmlnwqDCoCB8wqDCoCAxMCArCj4gPiA+IMKgZHJpdmVycy9p
aW8vZnJlcXVlbmN5L01ha2VmaWxlwqAgfMKgwqDCoCAxICsKPiA+ID4gwqBkcml2ZXJzL2lpby9m
cmVxdWVuY3kvYWRmNDM3Ny5jIHwgMTE1NAo+IAo+IC4uLgo+ID4gPiArc3RhdGljIHNzaXplX3Qg
YWRmNDM3N19yZWFkKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHVpbnRwdHJfdAo+ID4gPiBw
cml2YXRlLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbiwKPiA+ID4gY2hhcgo+
ID4gPiAqYnVmKQo+ID4gPiArewo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWRmNDM3N19z
dGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB1NjQg
dmFsID0gMDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJldDsKPiA+ID4gKwo+ID4gPiArwqDC
oMKgwqDCoMKgwqBzd2l0Y2ggKCh1MzIpcHJpdmF0ZSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqBj
YXNlIEFERjQzNzdfRlJFUToKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dCA9IGFkZjQzNzdfZ2V0X2ZyZXEoc3QsICZ2YWwpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtRUlOVkFMOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmFsID0gMDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICsKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldCA/OiBzeXNmc19lbWl0KGJ1ZiwgIiVsbHVcbiIsIHZh
bCk7wqAgCj4gPiAKPiA+IEkgd291bGQgYWxzbyByZXR1cm4gaW4gcGxhY2UuIEkndmUgY29tZSB0
byBwcmVmZXIgaXQgYnV0IHRoYXQncyBtZQo+ID4gOikKPiAKPiBEZWZpbml0ZWx5IGlmIGFsdGVy
bmF0aXZlIGlzIGEgdGVybmFyeSEKPiAKPiAKPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJl
dCA/IDogRklFTERfR0VUKEFERjQzNzdfTVVYT1VUX01TSywgbW9kZSk7Cj4gPiA+ICt9Cj4gPiA+
ICsKPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2VudW0gYWRmNDM3N19tdXhvdXRfZW51
bSA9IHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLml0ZW1zID0gYWRmNDM3N19tdXhvdXRfbW9kZXMs
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoC5udW1faXRlbXMgPSBBUlJBWV9TSVpFKGFkZjQzNzdfbXV4
b3V0X21vZGVzKSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLmdldCA9IGFkZjQzNzdfZ2V0X211eG91
dF9tb2RlLAo+ID4gPiArwqDCoMKgwqDCoMKgwqAuc2V0ID0gYWRmNDM3N19zZXRfbXV4b3V0X21v
ZGUsCj4gPiA+ICt9Owo+ID4gPiArCj4gPiA+ICsjZGVmaW5lIF9BREY0Mzc3X0VYVF9JTkZPKF9u
YW1lLCBfc2hhcmVkLCBfaWRlbnQpIHsgXAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLm5hbWUgPSBfbmFtZSwgXAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLnJlYWQgPSBhZGY0Mzc3X3JlYWQsIFwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC53cml0ZSA9IGFkZjQzNzdfd3JpdGUsIFwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5wcml2YXRlID0gX2lkZW50LCBcCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAuc2hhcmVkID0gX3NoYXJlZCwgXAo+ID4gPiArwqDCoMKgwqDCoMKgwqB9
Cj4gPiA+ICsKPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlY19leHRfaW5m
byBhZGY0Mzc3X2V4dF9pbmZvW10gPQo+ID4gPiB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoCAqIFVzdWFsbHkgd2UgdXNlIElJT19DSEFOX0lORk9fRlJFUVVF
TkNZLCBidXQgdGhlcmUgYXJlCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHZhbHVlcyA+IDJeMzIg
aW4gb3JkZXIgdG8gc3VwcG9ydCB0aGUgZW50aXJlIGZyZXF1ZW5jeQo+ID4gPiByYW5nZQo+ID4g
PiArwqDCoMKgwqDCoMKgwqAgKiBpbiBIei4KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoF9BREY0Mzc3X0VYVF9JTkZPKCJmcmVxdWVuY3kiLCBJSU9fU0hBUkVE
X0JZX0FMTCwKPiA+ID4gQURGNDM3N19GUkVRKSzCoCAKPiA+IAo+ID4gQ2FuJ3Qgd2UgaGF2ZSB1
NjQgYWxyZWFkeSBpbiBJSU9fQ0hBTl9JTkZPX0ZSRVFVRU5DWT8gSSBrbm93IHRoZQo+ID4gd3Jp
dGUKPiA+IHNpZGUgaXMgYSBiaXQgYXdrd2FyZCBidXQgSSB0aGluayB3ZSBjYW4gbWFrZSBpdCBi
ZXR0ZXIuCj4gCj4gaG1tLiBJIHRoaW5rIHdlIG9ubHkgaGF2ZSBzNjQuIElmIDYzIGJpdHMgaXMg
ZW5vdWdoIHRoZW4gd2UgYXJlIGdvb2QKPiB0byBnbyA6KQo+IAo+IChpbiB0aGUgYW5uYWxzIG9m
IGJhZCBkZXNpZ24gZGVjaXNpb25zLCB0aGlua2luZyB5ZWFycyBhZ28gdGhhdCBubwo+IG9uZSB3
b3VsZAo+IMKgZ28gYmV5b25kIDMyIGJpdHMuLi4gb29wcykuCj4gCj4gPiDCoAo+ID4gPiArwqDC
oMKgwqDCoMKgwqBJSU9fRU5VTSgibXV4b3V0X3NlbGVjdCIsIElJT19TSEFSRURfQllfQUxMLAo+
ID4gPiAmYWRmNDM3N19tdXhvdXRfZW51bSksCj4gPiA+ICvCoMKgwqDCoMKgwqDCoElJT19FTlVN
X0FWQUlMQUJMRSgibXV4b3V0X3NlbGVjdCIsIElJT19TSEFSRURfQllfQUxMLAo+ID4gPiAmYWRm
NDM3N19tdXhvdXRfZW51bSksCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHsgfSwKPiA+ID4gK307Cj4g
PiA+ICsKPiAKPiAuLi4KPiAKPiA+ID4gKwo+ID4gPiArc3RhdGljIGludCBhZGY0Mzc3X3Byb2Jl
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gPiA+ICt7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCByZWdt
YXAgKnJlZ21hcDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFkZjQzNzdfc3RhdGUgKnN0
Owo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoGluZGlvX2RldiA9IGRldm1faWlvX2RldmljZV9hbGxvYygmc3BpLT5kZXYsCj4gPiA+IHNp
emVvZigqc3QpKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFpbmRpb19kZXYpCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiA+ID4gKwo+ID4g
PiArwqDCoMKgwqDCoMKgwqByZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X3NwaShzcGksCj4gPiA+
ICZhZGY0Mzc3X3JlZ21hcF9jb25maWcpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJS
KHJlZ21hcCkpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRS
X0VSUihyZWdtYXApOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0ID0gaWlvX3ByaXYo
aW5kaW9fZGV2KTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbmRpb19kZXYtPmluZm8g
PSAmYWRmNDM3N19pbmZvOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbmRpb19kZXYtPm5hbWUgPSAi
YWRmNDM3NyI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+Y2hhbm5lbHMgPSBhZGY0
Mzc3X2NoYW5uZWxzOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbmRpb19kZXYtPm51bV9jaGFubmVs
cyA9IEFSUkFZX1NJWkUoYWRmNDM3N19jaGFubmVscyk7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKg
wqDCoMKgc3QtPnJlZ21hcCA9IHJlZ21hcDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3QtPnNwaSA9
IHNwaTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3QtPnR5cGUgPSBzcGlfZ2V0X2RldmljZV9pZChz
cGkpLT5kcml2ZXJfZGF0YTvCoCAKPiA+IAo+ID4gSG1tIHRoaXMgaXMgc29tZXRoaW5nIHRoYXQg
Y2FtZSB1cCBpbnRlcm5hbGx5IHRoZSBvdGhlciBkYXkuIEFyZSB3ZQo+ID4gZ3VhcmFudGVlZCB0
aGF0IHRoaXMgd2lsbCBhbHdheXMgd29yaz8gRm9yIE9GIEkgdGhpbmsgaXQgaXMgYnV0IEknbQo+
ID4gbm90Cj4gPiBzdXJlIGFib3V0IEFDUEk/IEF0IGZpcnN0IGdsYW5jZSwgaXQgc2VlbXMgdGhh
dCBpdCBtaWdodCBiZSBvayBidXQKPiA+IEkKPiA+IGRpZCBub3Qgd2VudCB0b28gZGVlcCBpbiB0
aGUgQUNQSSBjb2RlLgo+IAo+IEJldHRlciBpbmRlZWQgdG8gbm90IGFzc3VtZSBpdCBhbmQgaW5k
ZWVkIEFDUEkgY2FuJ3QgZG8gdGhpcyBtYWdpYywKPiBiZWNhdXNlCj4gdGhlcmUgaXNuJ3QgYSBt
YXRjaCBiZXR3ZWVuIHRoZSBhY3R1YWwgQUNQSSBJRCBhbmQgdGhlCj4gc3BpX2RldmljZV9pZHMu
Cj4gTm90IHN1cmUgd2hhdCBpdCBkb2VzIHdpdGggUFJQMDAwMSBjYXNlICh3aGVyZSBpdCB1c2Vz
IHRoZQo+IG9mX2RldmljZV9pZCB0YWJsZSkuCgpTb21lIGNvbW1lbnRzL3F1ZXN0aW9ucyBvbiB0
aGUgcGF0dGVybjoKCj4gCj4gCj4gwqDCoMKgwqDCoMKgwqDCoHN0LT50eXBlID0gZGV2aWNlX2dl
dF9tYXRjaF9pZCgpLT5kcml2ZXJfZGF0YTsKCkFyZSB3ZSBzdXJlIHRoYXQgZGV2aWNlX2dldF9t
YXRjaF9pZCgpIChJIGd1ZXNzIHlvdSBtZWFudApkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSkgY2Fu
bm90IHJldHVybiBOVUxMPyBJJ20gYWx3YXlzIGEgYml0IG9uIHRoZQpjYXJlZnVsIHNpZGUgd2l0
aCB0aGVzZSBkZXJlZmVyZW5jZXMuLi4KCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghc3QtPnR5cGUp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBzcGlfZGV2
aWNlX2lkICppZCA9Cj4gc3BpX2dldF9kZXZpY2VfaWQoc3BpKTsKPiAKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzdC0+dHlwZSA9IHNwaV9nZXRfZGV2aWNlX2lkKHNwaSktPmRyaXZl
cl9kYXRhOwoKaWQtPmRyaXZlcl9kYXRhIDopCgo+IMKgwqDCoMKgwqDCoMKgwqB9CgotIE51bm8g
U8OhCgoKCgpkZXZpY2VfZ2V0X21hdGNoX2lkKCktPmRyaXZlcl9kYXRhOwoKCg==

