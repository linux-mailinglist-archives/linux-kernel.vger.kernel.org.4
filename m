Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61D6F6576
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDHHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:07:44 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60912B9;
        Thu,  4 May 2023 00:07:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef3ce7085bso133141cf.2;
        Thu, 04 May 2023 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683184062; x=1685776062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXE74rzjxVxEcoYP+0S/dS1+eDZ23kkhga/gmUUJ1Yg=;
        b=XADF7hNgC5t2qcHkc4Pgpn61ox4cvY148szCFQTLHUbk2hNl0BY2qD5rqXxSFU7pUK
         GBPaIL9wu5ZvPewjR7KnqTTJVDPZYKN/jX1pAW0yyXOw+seWbTdlteolb8GmUDju/QLp
         otFEB4Kp02gS5ityle9ILIyuz/EqAy/2vKkn3EKcBwKP4qBLqXn0cWL3sWvL3EpxXdnB
         qi6KoR/WwcHksIA29k/t2k5vNVW0KIZYI1iyFyqz/soed2PlLt6NK82AEn1DG8VnnXtc
         uvAksn/f3IwSYxFWwDI9yb0ruo1P0NMaF0UG9ex+lzp9+d6l21Cayoash2XplB/jLxJI
         KImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683184062; x=1685776062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXE74rzjxVxEcoYP+0S/dS1+eDZ23kkhga/gmUUJ1Yg=;
        b=j+rFym6jlMoXMCXPpHSJuH6wBAOPTV3pql0ZgI+nzYhBUcw4n9v/96N34TWUpkN3cU
         dBapIfPYcjY1L6w/M3nCbgEHyP9b3Uri0IsR65G/qDcqgCdMBEoM/jFdsMGBtja5enbW
         992OVrgS++yN4sRfX3vVnSMWo6n1vpMkV/AyqE0Ps63K+zYmTPzBo1gpC6Os4ACo8q9O
         XYoXXvgFaByJXlQ0V3nglWfTmgttO3KY4J0FXUJ/dgQ/jG0gLPZBAVoD36QhiVKtbfyU
         822XJNfBf55xaVT3vMUVUYSvxmgiQbt8bImLID6Nn3EOnHrbHi98/lWVVlpkD+I8S9ON
         D8oA==
X-Gm-Message-State: AC+VfDwPXC9NyppUvp5dNvPQrJNiJMFDGoaISlUE+6zCWe0MGG5xK3mM
        w3z+ZPKj9l7wU67TT+x8bfY=
X-Google-Smtp-Source: ACHHUZ644Rxcv8R007XxswLWqdd1oyZZAXrEwV5MtXqXdJvMsTeEOeUMTkwzjuV9AiWmTm+pmPyRdA==
X-Received: by 2002:ac8:4e43:0:b0:3c0:3b08:2d80 with SMTP id e3-20020ac84e43000000b003c03b082d80mr4178346qtw.63.1683184062487;
        Thu, 04 May 2023 00:07:42 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:c599:e44a:8287:c91c? (p200300f6ef058700c599e44a8287c91c.dip0.t-ipconnect.de. [2003:f6:ef05:8700:c599:e44a:8287:c91c])
        by smtp.gmail.com with ESMTPSA id pr1-20020a05620a86c100b0074ced3e0004sm11320432qkn.63.2023.05.04.00.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:07:41 -0700 (PDT)
Message-ID: <50a65435aedd208e4980938ed191c2a281c5015e.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74413: fix resistance input processing
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 May 2023 09:09:52 +0200
In-Reply-To: <20230503095817.452551-1-linux@rasmusvillemoes.dk>
References: <20230503095817.452551-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
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

T24gV2VkLCAyMDIzLTA1LTAzIGF0IDExOjU4ICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Ogo+IE9uIHN1Y2Nlc3MsIGFkNzQ0MTNyX2dldF9zaW5nbGVfYWRjX3Jlc3VsdCgpIHJldHVybnMg
SUlPX1ZBTF9JTlQgYWthCj4gMS4gU28gY3VycmVudGx5LCB0aGUgSUlPX0NIQU5fSU5GT19QUk9D
RVNTRUQgY2FzZSBpcyBlZmZlY3RpdmVseQo+IGVxdWl2YWxlbnQgdG8gdGhlIElJT19DSEFOX0lO
Rk9fUkFXIGNhc2UsIGFuZCB3ZSBuZXZlciBjYWxsCj4gYWQ3NDQxM3JfYWRjX3RvX3Jlc2lzdGFu
Y2VfcmVzdWx0KCkgdG8gY29udmVydCB0aGUgYWRjIG1lYXN1cmVtZW50IHRvCj4gb2htcy4KPiAK
PiBDaGVjayByZXQgZm9yIGJlaW5nIG5lZ2F0aXZlIHJhdGhlciB0aGFuIG5vbi16ZXJvLgo+IAo+
IEZpeGVzOiBmZWEyNTFiNmE1ZGJkIChpaW86IGFkZGFjOiBhZGQgQUQ3NDQxM1IgZHJpdmVyKQo+
IFNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5k
az4KPiAtLS0KClJldmlld2VkLWJ5OiBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+Cgo+IMKg
ZHJpdmVycy9paW8vYWRkYWMvYWQ3NDQxM3IuYyB8IDIgKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9hZGRhYy9hZDc0NDEzci5jIGIvZHJpdmVycy9paW8vYWRkYWMvYWQ3NDQxM3IuYwo+IGluZGV4
IDA3ZTlmNmFlMTZhOC4uZTMzNjZjZjVlYjMxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2Fk
ZGFjL2FkNzQ0MTNyLmMKPiArKysgYi9kcml2ZXJzL2lpby9hZGRhYy9hZDc0NDEzci5jCj4gQEAg
LTEwMDcsNyArMTAwNyw3IEBAIHN0YXRpYyBpbnQgYWQ3NDQxM3JfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0ID0gYWQ3NDQxM3JfZ2V0X3NpbmdsZV9hZGNfcmVzdWx0KGluZGlvX2RldiwgY2hhbi0+Y2hh
bm5lbCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2
YWwpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZDc0NDEzcl9hZGNfdG9fcmVzaXN0YW5jZV9yZXN1bHQo
KnZhbCwgdmFsKTsKCg==

