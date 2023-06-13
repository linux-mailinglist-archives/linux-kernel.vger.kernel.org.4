Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73E72DC34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjFMITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFMITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:19:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015EEA;
        Tue, 13 Jun 2023 01:19:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso6444193e87.1;
        Tue, 13 Jun 2023 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686644379; x=1689236379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lMAW5Ou7KIhsW2jfrLpswrS3QB3OUx2Kdr76igm5lO8=;
        b=LRjXwL9hOWHS985h6F1wdXt3wymMPxI8YOwOcOx1HA7TCcK+a/7uwUfkobmJoEYCp5
         O6twhQS7jzBniSS0CuMwX0FCeuzEUpesUIg4Xg9L//w//aihtv0mTrsFvWvkfZDt7CdL
         m6O8ZeqIMtNTHIblQ0RVfr4pbuHcF193Vt9diXAVYtfJdUJVECLh3ylNkZB6micMUKX2
         U0ud9TT1UBhXPj0hRrZTCmDFGkdQZBHNx4R6Fq2vO4zftpumtqiUQi+jTkojFP8Yg1Ok
         oxBfiRSU094XbHPWCKbmieBFdlC1Y/28ECkah6k7uarghWlEIHW1AcC5Kg9lbE6hfC7A
         MSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644379; x=1689236379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMAW5Ou7KIhsW2jfrLpswrS3QB3OUx2Kdr76igm5lO8=;
        b=jTRaMy85RoQIzjEZYcwsyzVyymT6BuQlzD/KxaHevTfsH09wt6nqZxZprP2bNbnwDc
         oBYfZ3EZxNjNcE//ngVbDg5lSnbXQ6pPO/we6tHAgXTy7oedDXPr+I3oQrVjb7uZ16sL
         +gG24KDDX/tUOcshD8ImH0P8YDcVga5XTPELoeslsjZuutVdqnWUbx9F3IxSQWITBvzz
         q3nzx/FgpaQIpiUDWKE+ESonRmrci06HmfvGFdZ8axD0AizFFWR+sqywWiIJf1S9W1zw
         6HgIcdh0U1UH5hcO5v/v6Ctu/kNdRt7N1Txv+DtKkHcM1W49zEUkPrFD+2o8L75RRdmV
         E6ig==
X-Gm-Message-State: AC+VfDwmmTZnJi90t18Nf01I/4kZZ9JJIbvYqNf4ACHc4135cNS8qADf
        +16fpRFGOEfZi+rugB7qipc=
X-Google-Smtp-Source: ACHHUZ4EhS5HDW4G+tOLLnU7Xghluj5zQNpSC7DsYgl2jfPWEnoryOW83iiI1up6bOjO8Yw4td5lCg==
X-Received: by 2002:a19:e345:0:b0:4f4:c973:c97d with SMTP id c5-20020a19e345000000b004f4c973c97dmr4881664lfk.25.1686644379178;
        Tue, 13 Jun 2023 01:19:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003f801c12c58sm13537829wmd.43.2023.06.13.01.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:19:38 -0700 (PDT)
Message-ID: <b38cb68185b078fe346727b6dceb17967a56c18a.camel@gmail.com>
Subject: Re: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date:   Tue, 13 Jun 2023 10:19:38 +0200
In-Reply-To: <20230613054250.472897-1-markus.burri@mt.com>
References: <20230613054250.472897-1-markus.burri@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
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

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDA3OjQyICswMjAwLCBNYXJrdXMgQnVycmkgd3JvdGU6Cj4g
UHJpbnQgcmVhZCBhbmQgZXhwZWN0ZWQgZGV2aWNlIElEIGFzIGRlYnVnIHdhcm5pbmcuCj4gQWRk
IGVycm9yIGNoZWNrIGZvciBhZF9zZF9pbml0KCkgcmVzdWx0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6
IE1hcmt1cyBCdXJyaSA8bWFya3VzLmJ1cnJpQG10LmNvbT4KPiAtLS0KCllvdSBoYXZlIHVucmVs
YXRlZCBjaGFuZ2VzIGJ1dCB0aGV5IGFyZSBlYXN5IGVub3VnaCB0byBnbyBpbiBzYW1lIHBhdGNo
CihhdCBsZWFzdCBmb3IgbWUpLiBIZW5jZToKClJldmlld2VkLWJ5OiBOdW5vIFNhIDxudW5vLnNh
QGFuYWxvZy5jb20+Cgo+IMKgZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jIHwgOCArKysrKy0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jIGIvZHJpdmVycy9paW8vYWRjL2Fk
NzE5Mi5jCj4gaW5kZXggZDcxOTc3Yi4uMjIwYzNiNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMvYWQ3MTkyLmMKPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMKPiBAQCAtNDAz
LDggKzQwMyw4IEBAIHN0YXRpYyBpbnQgYWQ3MTkyX3NldHVwKHN0cnVjdCBhZDcxOTJfc3RhdGUg
KnN0LCBzdHJ1Y3QKPiBkZXZpY2Vfbm9kZSAqbnApCj4gwqDCoMKgwqDCoMKgwqDCoGlkICY9IEFE
NzE5Ml9JRF9NQVNLOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChpZCAhPSBzdC0+Y2hpcF9p
bmZvLT5jaGlwX2lkKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2Fybigm
c3QtPnNkLnNwaS0+ZGV2LCAiZGV2aWNlIElEIHF1ZXJ5IGZhaWxlZCAoMHglWClcbiIsCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWQpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2Fybigmc3QtPnNkLnNwaS0+ZGV2LCAiZGV2
aWNlIElEIHF1ZXJ5IGZhaWxlZCAoMHglWCAhPQo+IDB4JVgpXG4iLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlkLCBzdC0+Y2hpcF9pbmZvLT5jaGlw
X2lkKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBzdC0+bW9kZSA9IEFENzE5Ml9NT0RFX1NFTChB
RDcxOTJfTU9ERV9JRExFKSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBRDcx
OTJfTU9ERV9DTEtTUkMoc3QtPmNsb2NrX3NlbCkgfAo+IEBAIC0xMDQ5LDcgKzEwNDksOSBAQCBz
dGF0aWMgaW50IGFkNzE5Ml9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+IMKgwqDCoMKg
wqDCoMKgwqBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbmRpb19kZXYt
PmluZm8gPSAmYWQ3MTkyX2luZm87Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBhZF9zZF9pbml0KCZz
dC0+c2QsIGluZGlvX2Rldiwgc3BpLCAmYWQ3MTkyX3NpZ21hX2RlbHRhX2luZm8pOwo+ICvCoMKg
wqDCoMKgwqDCoHJldCA9IGFkX3NkX2luaXQoJnN0LT5zZCwgaW5kaW9fZGV2LCBzcGksICZhZDcx
OTJfc2lnbWFfZGVsdGFfaW5mbyk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqByZXQgPSBkZXZtX2FkX3NkX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcigmc3BpLT5kZXYsIGlu
ZGlvX2Rldik7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCgo=

