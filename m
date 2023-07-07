Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97A74AD98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGGJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:08:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F52128;
        Fri,  7 Jul 2023 02:08:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992f15c36fcso211994866b.3;
        Fri, 07 Jul 2023 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688720894; x=1691312894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vsrs8dvay+QVCYq9yDGzqiagqt9CW0MwYSzjX7CK3hk=;
        b=eqaZJQGm6UVsQAzQ/NNZc1TUl03Tt9IFILF+7jP87a4rM6t9usMyOQ740kQNdkt51k
         kEl8ycNa1bKnNnjx52JaCeDRfjp65G8mBSFjwd5C2J/3x28eTn1ElZVnZp8SRvILqo/4
         r4FkNPcn4vB2igJZfaIPcxIu03M8NDH8SjEZKnmnCY5sRqMMr6oVjg3/HCH1BEqw3vXT
         X/fy8At0BoTrFgP/apqPm06OjHqDtq61dTNTHEx63U/lt4M2438mI4ZCq+pE0iibYIYV
         CyC7qhJxQ+T317zQmwn6pUZ3cl8AVriCqMM71+930kilvbP3gLcBThr52Obw3IUAahhV
         jOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688720894; x=1691312894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsrs8dvay+QVCYq9yDGzqiagqt9CW0MwYSzjX7CK3hk=;
        b=Wxkf+4W41Qj+4COZwxQlzPs5mmQZeBTqLYpwf2dOg/+q9aytG6cNN2oocevAZFvXrt
         D6165PqKZ6zdpd/0qqHGS5Tpu4hwoURrw7szqSNz/WJEsxXkHwNjkx3IczXjQpQJYI8P
         jATBEvT+9Xs810/jnFp0y0C/wRn14SXZZ2X+awvzwCalknedGdUL91Fe6Uu4jXEchZUA
         IgAeDofIqCkJkQLdGJv6UHTqSX8zomfjw8Ey9GBq9O+7skxCkvQKp+fO37MRoxo8NZoe
         7X5imjUYOnJ+STm2rKk7d4eY7H+J899f11d514bWbsuVOk+UPb7NLO38Ll1tYoqQatLI
         bAYw==
X-Gm-Message-State: ABy/qLYXhQyh1t23QWkLnl0Q8ceJnxM9rO5s9BqhS+/Y/43gO9urpeD8
        Hs92U5aGWMZqBF7QDMyqA54=
X-Google-Smtp-Source: APBJJlFlbZSnMEyTfLlhLqTa6EIcMDtI63qo+y2OTRroaisrWEFEmyaXIvBDD5pGVq5NmDBO77e87g==
X-Received: by 2002:a17:906:f15:b0:98e:973:d39f with SMTP id z21-20020a1709060f1500b0098e0973d39fmr2866197eji.33.1688720893484;
        Fri, 07 Jul 2023 02:08:13 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id m4-20020a170906258400b00992025654c4sm1902828ejb.182.2023.07.07.02.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 02:08:13 -0700 (PDT)
Message-ID: <a8b3ea873be180e62aca60564430a29b3b88e6e2.camel@gmail.com>
Subject: Re: [PATCH v4] iio: adc: add buffering support to the TI LMP92064
 ADC driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 11:10:41 +0200
In-Reply-To: <20230707063635.1496437-1-l.goehrs@pengutronix.de>
References: <20230707063635.1496437-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
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

T24gRnJpLCAyMDIzLTA3LTA3IGF0IDA4OjM2ICswMjAwLCBMZW9uYXJkIEfDtmhycyB3cm90ZToK
PiBFbmFibGUgYnVmZmVyZWQgcmVhZGluZyBvZiBzYW1wbGVzIGZyb20gdGhlIExNUDkyMDY0IEFE
Qy4KPiBUaGUgbWFpbiBiZW5lZml0IG9mIHRoaXMgY2hhbmdlIGlzIGJlaW5nIGFibGUgdG8gcmVh
ZCBvdXQgY3VycmVudCBhbmQKPiB2b2x0YWdlIG1lYXN1cmVtZW50cyBpbiBhIHNpbmdsZSB0cmFu
c2ZlciwgYWxsb3dpbmcgaW5zdGFudGFuZW91cyBwb3dlcgo+IG1lYXN1cmVtZW50cy4KPiAKPiBS
ZWFkcyBpbnRvIHRoZSBidWZmZXIgY2FuIGJlIHRyaWdnZXJlZCBieSBhbnkgc29mdHdhcmUgdHJp
Z2dlcnMsIGUuZy4KPiB0aGUgaWlvLXRyaWctaHJ0aW1lcjoKPiAKPiDCoMKgwqAgJCBta2RpciAv
c3lzL2tlcm5lbC9jb25maWcvaWlvL3RyaWdnZXJzL2hydGltZXIvbXktdHJpZ2dlcgo+IMKgwqDC
oCAkIGNhdCAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW9cOmRldmljZTMvbmFtZQo+IMKgwqDCoCBs
bXA5MjA2NAo+IMKgwqDCoCAkIGlpb19yZWFkZGV2IC10IG15LXRyaWdnZXIgLWIgMTYgaWlvOmRl
dmljZTMgfCBoZXhkdW1wCj4gwqDCoMKgIFdBUk5JTkc6IEhpZ2gtc3BlZWQgbW9kZSBub3QgZW5h
YmxlZAo+IMKgwqDCoCAwMDAwMDAwIDAwMDAgMDE3NiAwMTAxIDAwMDEgNTUwNyBhYmQ1IDc2NDUg
MTc2OAo+IMKgwqDCoCAwMDAwMDEwIDAwMDAgMDE2ZCAwMTAxIDAwMDEgZWUxZSBhYzZiIDc2NDUg
MTc2OAo+IMKgwqDCoCAuLi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIEfDtmhycyA8bC5n
b2VocnNAcGVuZ3V0cm9uaXguZGU+Cj4gLS0tCgpSZXZpZXdlZC1ieTogTnVubyBTYSA8bnVuby5z
YUBhbmFsb2cuY29tPgoKPiBDaGFuZ2VzIHYxLT52MjoKPiAKPiDCoCAtIFJlbW92ZSBzdXBlcmZs
dW91cyAuc2hpZnQgPSAwIGluaXRpYWxpemF0aW9uIGluIHNjYW5fdHlwZS4KPiDCoCAtIFJlcGxh
Y2Uga21hbGxvYyBidWZmZXIgYWxsb2NhdGlvbiBmb3IgZXZlcnkgcmVhZCB3aXRoIGEgc3RhY2sK
PiDCoMKgwqAgYWxsb2NhdGVkIHN0cnVjdHVyZS4KPiDCoMKgwqAgQSBzdHJ1Y3QgaXMgdXNlZCB0
byBlbnN1cmUgY29ycmVjdCBhbGlnbm1lbnQgb2YgdGhlIHRpbWVzdGFtcCBmaWVsZC4KPiDCoMKg
wqAgU2VlIGUuZy4gYWRjL3JvY2tjaGlwX3NhcmFkYy5jIGZvciBvdGhlciB1c2VycyBvZiB0aGUg
c2FtZSBwYXR0ZXJuLgo+IMKgIC0gVXNlIGF2YWlsYWJsZV9zY2FuX21hc2tzIGFuZCBhbHdheXMg
cHVzaCBib3RoIHZvbHRhZ2UgYW5kIGN1cnJlbnQKPiDCoMKgwqAgbWVhc3VyZW1lbnRzIHRvIHRo
ZSBidWZmZXIuCj4gCj4gQ2hhbmdlcyB2Mi0+djM6Cj4gCj4gwqAgLSBIYW5kbGUgZXJyb3JzIHJl
dHVybmVkIGJ5IGxtcDkyMDY0X3JlYWRfbWVhcygpIG91dC1vZi1saW5lIHZpYQo+IMKgwqDCoCBh
IGdvdG8gZXJyOwo+IAo+IENoYW5nZXMgdjMtPnY0Ogo+IAo+IMKgIC0gOC1CeXRlIGFsaWduIHRo
ZSA2NCBiaXQgdGltZXN0YW1wIGluIHRoZSBidWZmZXIgc3RydWN0dXJlCj4gwqDCoMKgIGFuZCBt
ZW1zZXQoKSB0aGUgc3RhY2stYWxsb2NhdGVkIGJ1ZmZlciB0byBwcmV2ZW50IGxlYWtpbmcKPiDC
oMKgwqAga2VybmVsIG1lbW9yeSB0byB1c2Vyc3BhY2UuIChUaGFua3MgdG8gTnVubyBTw6EpCj4g
LS0tCj4gwqBkcml2ZXJzL2lpby9hZGMvdGktbG1wOTIwNjQuYyB8IDUzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygr
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvdGktbG1wOTIwNjQuYyBiL2RyaXZl
cnMvaWlvL2FkYy90aS1sbXA5MjA2NC5jCj4gaW5kZXggYzMwZWQ4MjQ5MjRmMy4uODRiYTVjNGEw
ZWVhNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvdGktbG1wOTIwNjQuYwo+ICsrKyBi
L2RyaXZlcnMvaWlvL2FkYy90aS1sbXA5MjA2NC5jCj4gQEAgLTE2LDcgKzE2LDEwIEBACj4gwqAj
aW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPgo+IMKgCj4gwqAjaW5jbHVkZSA8bGludXgvaWlvL2lp
by5oPgo+ICsjaW5jbHVkZSA8bGludXgvaWlvL2J1ZmZlci5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4
L2lpby9kcml2ZXIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2lpby90cmlnZ2VyZWRfYnVmZmVyLmg+
Cj4gKyNpbmNsdWRlIDxsaW51eC9paW8vdHJpZ2dlcl9jb25zdW1lci5oPgo+IMKgCj4gwqAjZGVm
aW5lIFRJX0xNUDkyMDY0X1JFR19DT05GSUdfQSAweDAwMDAKPiDCoCNkZWZpbmUgVElfTE1QOTIw
NjRfUkVHX0NPTkZJR19CIDB4MDAwMQo+IEBAIC05MSw2ICs5NCwxMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGlpb19jaGFuX3NwZWMgbG1wOTIwNjRfYWRjX2NoYW5uZWxzW10gPQo+IHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hZGRyZXNzID0gVElfTE1QOTIwNjRfQ0hBTl9J
TkMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW5mb19tYXNrX3NlcGFyYXRl
ID0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBCSVQo
SUlPX0NIQU5fSU5GT19SQVcpIHwgQklUKElJT19DSEFOX0lORk9fU0NBTEUpLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2Nhbl9pbmRleCA9IFRJX0xNUDkyMDY0X0NIQU5fSU5D
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2Nhbl90eXBlID0gewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNpZ24gPSAndScsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucmVhbGJpdHMg
PSAxMiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5z
dG9yYWdlYml0cyA9IDE2LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9LAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRhdGFzaGVldF9uYW1lID0gIklOQyIsCj4g
wqDCoMKgwqDCoMKgwqDCoH0sCj4gwqDCoMKgwqDCoMKgwqDCoHsKPiBAQCAtOTgsOCArMTA3LDIw
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBsbXA5MjA2NF9hZGNfY2hhbm5l
bHNbXQo+ID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFkZHJlc3MgPSBU
SV9MTVA5MjA2NF9DSEFOX0lOViwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5p
bmZvX21hc2tfc2VwYXJhdGUgPQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgfCBCSVQoSUlPX0NIQU5fSU5GT19T
Q0FMRSksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zY2FuX2luZGV4ID0gVElf
TE1QOTIwNjRfQ0hBTl9JTlYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zY2Fu
X3R5cGUgPSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuc2lnbiA9ICd1JywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5yZWFsYml0cyA9IDEyLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLnN0b3JhZ2ViaXRzID0gMTYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGF0YXNoZWV0
X25hbWUgPSAiSU5WIiwKPiDCoMKgwqDCoMKgwqDCoMKgfSwKPiArwqDCoMKgwqDCoMKgwqBJSU9f
Q0hBTl9TT0ZUX1RJTUVTVEFNUCgyKSwKPiArfTsKPiArCj4gK3N0YXRpYyBjb25zdCB1bnNpZ25l
ZCBsb25nIGxtcDkyMDY0X3NjYW5fbWFza3NbXSA9IHsKPiArwqDCoMKgwqDCoMKgwqBCSVQoVElf
TE1QOTIwNjRfQ0hBTl9JTkMpIHwgQklUKFRJX0xNUDkyMDY0X0NIQU5fSU5WKSwKPiArwqDCoMKg
wqDCoMKgwqAwCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgaW50IGxtcDkyMDY0X3JlYWRfbWVhcyhz
dHJ1Y3QgbG1wOTIwNjRfYWRjX3ByaXYgKnByaXYsIHUxNiAqcmVzKQo+IEBAIC0xNzEsNiArMTky
LDMyIEBAIHN0YXRpYyBpbnQgbG1wOTIwNjRfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldiwKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgfQo+IMKgCj4gK3N0YXRpYyBpcnFyZXR1cm5f
dCBsbXA5MjA2NF90cmlnZ2VyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcCkKPiArewo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBpaW9fcG9sbF9mdW5jICpwZiA9IHA7Cj4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBmLT5pbmRpb19kZXY7Cj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IGxtcDkyMDY0X2FkY19wcml2ICpwcml2ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsK
PiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB1MTYgdmFsdWVzWzJdOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQ2NF90
IHRpbWVzdGFtcCBfX2FsaWduZWQoOCk7Cj4gK8KgwqDCoMKgwqDCoMKgfSBkYXRhOwo+ICvCoMKg
wqDCoMKgwqDCoGludCByZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG1lbXNldCgmZGF0YSwgMCwg
c2l6ZW9mKGRhdGEpKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gbG1wOTIwNjRfcmVhZF9t
ZWFzKHByaXYsIGRhdGEudmFsdWVzKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
aWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3RpbWVzdGFtcChpbmRpb19kZXYsICZkYXRhLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlpb19nZXRfdGltZV9ucyhpbmRpb19kZXYpKTsKPiAr
Cj4gK2VycjoKPiArwqDCoMKgwqDCoMKgwqBpaW9fdHJpZ2dlcl9ub3RpZnlfZG9uZShpbmRpb19k
ZXYtPnRyaWcpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gSVJRX0hBTkRMRUQ7Cj4gK30K
PiArCj4gwqBzdGF0aWMgaW50IGxtcDkyMDY0X3Jlc2V0KHN0cnVjdCBsbXA5MjA2NF9hZGNfcHJp
diAqcHJpdiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvX3Jlc2V0KQo+IMKgewo+IEBAIC0zMDEsNiArMzQ4
LDEyIEBAIHN0YXRpYyBpbnQgbG1wOTIwNjRfYWRjX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpCj4gwqDCoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+Y2hhbm5lbHMgPSBsbXA5MjA2NF9hZGNf
Y2hhbm5lbHM7Cj4gwqDCoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gQVJS
QVlfU0laRShsbXA5MjA2NF9hZGNfY2hhbm5lbHMpOwo+IMKgwqDCoMKgwqDCoMKgwqBpbmRpb19k
ZXYtPmluZm8gPSAmbG1wOTIwNjRfYWRjX2luZm87Cj4gK8KgwqDCoMKgwqDCoMKgaW5kaW9fZGV2
LT5hdmFpbGFibGVfc2Nhbl9tYXNrcyA9IGxtcDkyMDY0X3NjYW5fbWFza3M7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoHJldCA9IGRldm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoZGV2LCBpbmRp
b19kZXYsIE5VTEwsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG1wOTIwNjRf
dHJpZ2dlcl9oYW5kbGVyLCBOVUxMKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
IkZhaWxlZCB0byBzZXR1cCBidWZmZXJlZAo+IHJlYWRcbiIpOwo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoZGV2LCBpbmRpb19kZXYpOwo+IMKg
fQo+IAo+IGJhc2UtY29tbWl0OiA2OTk1ZTJkZTY4OTFjNzI0YmZlYjJkYjMzZDdiODc3NzVmOTEz
YWQxCgo=

