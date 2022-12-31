Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB565A310
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 08:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLaHS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 02:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:18:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B617640;
        Fri, 30 Dec 2022 23:18:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id co23so21882128wrb.4;
        Fri, 30 Dec 2022 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zP8aN8F1TFjp+QyRXOKBu1FOqjclgtUNuKrVJaJr4Rw=;
        b=dm4su3njwGwZGWwqjbznPCls0FteayWvKX5jqOMfvGKvh7tDtrn0UXmiSDjtClC5te
         5zUPByBodYNbFzVGzYV2CRMtub9BIBJ0kLYfNk5o3hhmA/fJjrKz5CdBM+hH+RHUyY3r
         UYPWFhLXdDKeqzmrs2ROclpml8xTUiT1mMG5BA3OKHI4Z3PRuN3wOfh3kWVFv8co/i+Z
         iqsj9EPNIXKl4xua9MXGjOuseWQmF95SPxo4wfrFWSZNfwk0k+ZPzdwnGFuxnuYlTpFr
         DqxWFFKKckE6ieIjl04LVxAXngnHfsQzGygctv6h96xfTVJNPWHmvtvG7Rdf1dadC4Eq
         kdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP8aN8F1TFjp+QyRXOKBu1FOqjclgtUNuKrVJaJr4Rw=;
        b=noFYAdSTei1Jy0lo0j+90cgM5eXBh981um3Jgk1At7cfzLtrwGvvnpOXtCsu4AmKEZ
         sdyrMazKFurG+6vG0c2wfKSKynUPN9lsuB5d9E537y06agqa7F6TDV2U6HSKwkOjJeqM
         1Qd575teNdJtKHF2CXFxC/zStJGPam74Ro99LXhjKy9HPgNKWFNjld/jjGljiKLWJc+C
         TiRwMDJFAikupMTcMddVktGOVSuoGa/DJ5VPFme6y0+n6xwSUGfmW9ueo7Lp2TwUP11B
         JwrlGnYg8NvpUIwxVKD7tmhSHhoWCQnGgZSA1iYQW4hwQdREWISxmhxVfVb8COULHYYG
         YrQg==
X-Gm-Message-State: AFqh2kotMwwEk71kQYUjJlPPNh9M/nzIOZCId4Ei5gOf0Ffg+6dLzi2e
        cbo7fBzpSkjw6Zr2B9G6PWs=
X-Google-Smtp-Source: AMrXdXuCCt0wQVgUtfQuQ9SZ7/ciRJpO65NWMFaoA3CHYaZppGjTvJUmcfvIslP74yfUBnoXfpLXhg==
X-Received: by 2002:a05:6000:501:b0:26b:8177:a5e6 with SMTP id a1-20020a056000050100b0026b8177a5e6mr20053277wrf.51.1672471100771;
        Fri, 30 Dec 2022 23:18:20 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:70ad:9f34:9d41:ef2c? ([2a02:168:6806:0:70ad:9f34:9d41:ef2c])
        by smtp.gmail.com with ESMTPSA id s13-20020adfdb0d000000b002420dba6447sm22928907wri.59.2022.12.30.23.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:18:20 -0800 (PST)
Message-ID: <46438c4880373193ba7e11cbdf0fa4e1be12ab31.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 31 Dec 2022 08:18:19 +0100
In-Reply-To: <87wn7g7xku.fsf@BL-laptop>
References: <20220714115515.5748-1-pali@kernel.org>
         <20220714183328.4137-1-pali@kernel.org>
         <20220714183328.4137-3-pali@kernel.org> <87wn7g7xku.fsf@BL-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2-1 
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

T24gTW9uLCAyMDIyLTExLTI4IGF0IDAxOjA1ICswMTAwLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6
Cj4gUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz4gd3JpdGVzOgo+IAo+ID4gQXJtYWRhIDM4
eCBzdXBwb3J0cyBwZXIgQ1BVIGludGVycnVwdHMgZm9yIGdwaW9zLCBsaWtlIEFybWFkYSBYUC4g
UHJlLVhQCj4gPiB2YXJpYW50cyBsaWtlIEFybWFkYSAzNzAgZG8gbm90IHN1cHBvcnQgcGVyIENQ
VSBpbnRlcnJ1cHRzIGZvciBncGlvcy4KPiA+IAo+ID4gU28gY2hhbmdlIGNvbXBhdGlibGUgc3Ry
aW5nIGZvciBBcm1hZGEgMzh4IGZyb20gIm1hcnZlbGwsYXJtYWRhLTM3MC1ncGlvIgo+ID4gd2hp
Y2ggaW5kaWNhdGVzIHByZS1YUCB2YXJpYW50IHRvICJtYXJ2ZWxsLGFybWFkYXhwLWdwaW8iIHdo
aWNoIGluZGljYXRlcwo+ID4gWFAgdmFyaWFudCBvciBuZXcuCj4gPiAKPiA+IERyaXZlciBncGlv
LW12ZWJ1LmMgd2hpY2ggaGFuZGxlcyBib3RoIHByZS1YUCBhbmQgWFAgdmFyaWFudHMgYWxyZWFk
eQo+ID4gcHJvdmlkZXMgc3VwcG9ydCBmb3IgcGVyIENQVSBpbnRlcnJ1cHRzIG9uIFhQIGFuZCBu
ZXdlciB2YXJpYW50cy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogUGFsaSBSb2jDoXIgPHBhbGlA
a2VybmVsLm9yZz4KPiA+IEZpeGVzOiA3Y2IyYWNiM2ZiYWUgKCJBUk06IGR0czogbXZlYnU6IEFk
ZCBQV00gcHJvcGVydGllcyBmb3IgYXJtYWRhLTM4eCIpCj4gCj4gQXBwbGllZCBvbiBtdmVidS9k
dAo+IAo+IFRoYW5rcywKPiAKPiBHcmVnb3J5CgpUaGlzIHBhdGNoIG1hZGUgaXQgaW50byBtYWlu
bGluZSwgYnV0IHVuZm9ydHVuYXRlbHkgYnJva2UgZ3BpbyBpbnRlcnJ1cHRzIG9uClR1cnJpcyBP
bW5pYSAoQXJtYWRhIDM4NSksIHdpdGggcmF0aGVyIGJhZCBjb25zZXF1ZW5jZXMuIEkgaGF2ZSBz
dWJtaXR0ZWQgYQpyZWdyZXNzaW9uIHJlcG9ydC4KCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvZjI0NDc0ZTcwYzFhNGU5NjkyYmQ1OTZlZjZkOTdjZWRhOTUxMTI0NS5jYW1lbEBnbWFp
bC5jb20vCgpJIGFtIGhhcHB5IHRvIHRlc3QgcG90ZW50aWFsIGZpeGVzLiBUaGUgdHJpdmlhbCBv
bmUgKGdldHRpbmcgdGhlICJyZWciCnByb3BlcnRpZXMgcmlnaHQsIGFzIHN0YXRlZCBieSBDaHJp
cyBQYWNraGFtKSBkb2Vzbid0IHdvcmssIGVpdGhlci4KCkEgcmV2ZXJ0IHdvdWxkIHNvbHZlIHRo
ZSBwcm9ibGVtIG9uIHRoZSBPbW5pYSwgZm9yIHRoZSB0aW1lIGJlaW5nLgoKUmVnYXJkcywgS2xh
dXMKCj4gPiAtLS0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpIHwgNCAr
Ky0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kg
Yi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kKPiA+IGluZGV4IGRmM2M4ZDFkOGY2
NC4uOTM0M2RlNjk0N2IzIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRh
LTM4eC5kdHNpCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kKPiA+
IEBAIC0yOTIsNyArMjkyLDcgQEAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH07Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3BpbzA6IGdwaW9AMTgxMDAgewo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zNzAtZ3BpbyIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0g
Im1hcnZlbGwsYXJtYWRheHAtZ3BpbyIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICJtYXJ2ZWxsLG9yaW9uLWdwaW8iOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDE4MTAwIDB4NDA+
LCA8MHgxODFjMCAweDA4PjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWctbmFtZXMgPSAiZ3BpbyIsICJwd20iOwo+
ID4gQEAgLTMxMCw3ICszMTAsNyBAQAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvMTogZ3Bpb0AxODE0MCB7Cj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MC1ncGlvIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUg
PSAibWFydmVsbCxhcm1hZGF4cC1ncGlvIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIm1hcnZlbGwsb3Jpb24tZ3BpbyI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4MTgxNDAgMHg0
MD4sIDwweDE4MWM4IDB4MDg+Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZy1uYW1lcyA9ICJncGlvIiwgInB3bSI7
Cj4gPiAtLSAKPiA+IDIuMjAuMQo+ID4gCj4gCgo=

