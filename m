Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5271D731834
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbjFOMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbjFOMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:10:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A2193;
        Thu, 15 Jun 2023 05:10:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so2120310a12.2;
        Thu, 15 Jun 2023 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686831035; x=1689423035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cH7f8dO8LwOHgZYF4+NV54A72XOxsYhU4Qi3RqmzeSk=;
        b=gmhlTz899JCDPr9vM9nGyyH2xJA55W/37lD/M8JdrmhIkThOMi38v5sT7lT2PRme0J
         7fHBSMITz6FUbinDm5VMiDuDelynRQebLt+AbxWc3wbh89aCC3bhyXJbOBxm5FHgOvyT
         RKj7/MjQ5xkCW5atwZ7zTc/uAxvuncU6tCs8v1K2//CHIoSuE/oM/9gncqLM+6X5DBd3
         Qpw9gT1a1hHxitAuEusoHnd//8EEubwCKa8530eUDFjYb7otYL7QWoLk4W4Hvy2RJMTG
         UfhA1hHGq7iVGzDuMfriPMK6yFkCwywNTs186S51mMT4tPDScZLc9qvTZXdsXU1D3aWd
         tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831035; x=1689423035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cH7f8dO8LwOHgZYF4+NV54A72XOxsYhU4Qi3RqmzeSk=;
        b=i7sxh9VcVZSDQJnr8pz9kCQ/gFcI/7GkRT70QD2owsYXXEGVJtkHSjpYLu6ZXjFeno
         CSb9tPvt+zCqIVcZ+c5nQYjpnMm/cf8FPP8hf4+HBfUCy05TnLaHjR/tEw7tyVPdlO5L
         0AZK3PJl6po8c3+4FlIPfFG0eePZ3As+vcp5brKh+FVYjq1Qpm7I0VyA2tStB2REJNKr
         tGj9ErdbSPZ8MSjro7+a5gMDi6grEymzUGc3PzaNmg+nlLFOCfvFOYEVr6nvYO0cm2AE
         NAoO9PrjXMLsYNv5fVd68rtSBgTHq7kBfX1atEg6qWCLai/CL/yrnxhZRl3Ecqxih+Lo
         qkBQ==
X-Gm-Message-State: AC+VfDwsQWR0i/XcyCg1+VvYr57HDmCVtMF3G9Vmbi3E2yg8N69bsFBS
        qieOU6GuLsd51Bmz6MUZy7Y=
X-Google-Smtp-Source: ACHHUZ5wl6u69sjwPLN1wNoNEXiik82pMNrHRD2rkRELKF+UcfozaHZIsflvBXZFm2JaHw3TvUw8sg==
X-Received: by 2002:a05:6402:88e:b0:514:964c:4c42 with SMTP id e14-20020a056402088e00b00514964c4c42mr11810013edy.8.1686831035402;
        Thu, 15 Jun 2023 05:10:35 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b0050d83a39e6fsm8869638edt.4.2023.06.15.05.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:10:35 -0700 (PDT)
Message-ID: <55a46a8cffef60758f0136f389909e307fa1ade4.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Simplify using
 devm_clk_get_optional_enabled()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Date:   Thu, 15 Jun 2023 14:12:57 +0200
In-Reply-To: <7dbe973905f1fdae5d2f5ae5a3b01dd1d6a9925b.1686774340.git.christophe.jaillet@wanadoo.fr>
References: <7dbe973905f1fdae5d2f5ae5a3b01dd1d6a9925b.1686774340.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDIyOjI2ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6Cj4gSWYgc3QtPm1jbGsgaXMgbm90IE5VTEwsIHRoZW4gc3QtPmNsb2NrX3NlbCBpcyBlaXRo
ZXIgQUQ3MTkyX0NMS19FWFRfTUNMSzIKPiBvciBBRDcxOTJfQ0xLX0VYVF9NQ0xLMV8yLgo+IAo+
IFNvIGRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKCkgY2FuIGJlIHVzZWQgaW5zdGVhZCBv
ZiBoYW5kIHdyaXRpbmcgaXQuCj4gVGhpcyBzYXZlcyBzb21lIGxpbmUgb2YgY29kZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5h
ZG9vLmZyPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4K
Cj4gwqBkcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMgfCAxNiArLS0tLS0tLS0tLS0tLS0tCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTky
LmMKPiBpbmRleCA4Njg1ZTBiNThhODMuLjVkY2IyNTdhZDc1NCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2lpby9hZGMvYWQ3MTkyLmMKPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMKPiBA
QCAtOTcyLDExICs5NzIsNiBAQCBzdGF0aWMgdm9pZCBhZDcxOTJfcmVnX2Rpc2FibGUodm9pZCAq
cmVnKQo+IMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3JfZGlzYWJsZShyZWcpOwo+IMKgfQo+IMKg
Cj4gLXN0YXRpYyB2b2lkIGFkNzE5Ml9jbGtfZGlzYWJsZSh2b2lkICpjbGspCj4gLXsKPiAtwqDC
oMKgwqDCoMKgwqBjbGtfZGlzYWJsZV91bnByZXBhcmUoY2xrKTsKPiAtfQo+IC0KPiDCoHN0YXRp
YyBpbnQgYWQ3MTkyX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gwqB7Cj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBhZDcxOTJfc3RhdGUgKnN0Owo+IEBAIC0xMDQ0LDcgKzEwMzksNyBA
QCBzdGF0aWMgaW50IGFkNzE5Ml9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoHN0LT5mY2xrID0gQUQ3MTkyX0lOVF9GUkVRX01IWjsKPiDCoAo+IC3C
oMKgwqDCoMKgwqDCoHN0LT5tY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwg
Im1jbGsiKTsKPiArwqDCoMKgwqDCoMKgwqBzdC0+bWNsayA9IGRldm1fY2xrX2dldF9vcHRpb25h
bF9lbmFibGVkKCZzcGktPmRldiwgIm1jbGsiKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VS
UihzdC0+bWNsaykpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRS
X0VSUihzdC0+bWNsayk7Cj4gwqAKPiBAQCAtMTA1MiwxNSArMTA0Nyw2IEBAIHN0YXRpYyBpbnQg
YWQ3MTkyX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKHN0LT5jbG9ja19zZWwgPT0gQUQ3MTkyX0NMS19FWFRfTUNMSzFfMiB8fAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3QtPmNsb2NrX3NlbCA9PSBBRDcxOTJfQ0xLX0VYVF9NQ0xLMikg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoc3QtPm1jbGspOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwg
MCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biByZXQ7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZtX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoJnNwaS0+ZGV2LCBhZDcxOTJfY2xrX2Rpc2FibGUsCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdC0+bWNsayk7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0LT5mY2xrID0gY2xrX2dldF9yYXRlKHN0LT5tY2xrKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghYWQ3MTkyX3ZhbGlkX2V4dGVybmFsX2ZyZXF1ZW5j
eShzdC0+ZmNsaykpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkZXZfZXJyKCZzcGktPmRldiwKCg==

