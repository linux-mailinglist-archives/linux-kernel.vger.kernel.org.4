Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A165DB51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjADRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjADRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:35:35 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF21AA05;
        Wed,  4 Jan 2023 09:35:33 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1739420032;
        Thu,  5 Jan 2023 01:35:27 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1672853728;
        bh=/N0R+ySjnTMdM2rsZ7vk1QeAJ/dma8FcYdzFNNeDzG4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CB8m11jXSPWlNaT0kTy91CILph1AGDbbBSOO/HrKs4uexZ6c7E6y766M8z0N621sk
         nDw/SX9ZECUmpo6vbbYZeCcGT/+xMax81sdStb9VmHXf/4FkiVXZmYEzR6QFw8elNU
         Cd5bG3x10eQUusor9ih4RIIwtNOQ7mPTf20je3RFAtTaWVmJqh9Ys3yaN7k4VsEzNb
         xmKfH2jD1KXbVfXJbt4YPBySMMyfi3H0UVQiq077697PxYKLYvS18F7ykt+Ai92Q1E
         w2fNWiVMJc/60K+lskjfWtKyUHEjcq3FXc9pPKp0HoeK9Y0gvKHkHshkLkf/gOEUY6
         gD/TofMqXIwcQ==
Message-ID: <33f6f9e66c8143515d36d17bf33d95362830f83f.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH v3 2/2] mfd: syscon: allow reset control for syscon
 devices
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Lee Jones <lee@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 05 Jan 2023 01:35:26 +0800
In-Reply-To: <Y7WvXTPxyIGw5y9R@google.com>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
         <20221211025700.1180843-3-jk@codeconstruct.com.au>
         <Y7WvXTPxyIGw5y9R@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLAoKPiA+IEBAIC0xMjQsNyArMTI3LDE3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY29uICpv
Zl9zeXNjb25fcmVnaXN0ZXIoc3RydWN0IGRldmljZV9ub2RlICpucCwgYm9vbCBjaGVja19jbGsp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSByZWdtYXBfbW1p
b19hdHRhY2hfY2xrKHJlZ21hcCwgY2xrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9hdHRhY2g7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIGVycl9hdHRhY2hfY2xrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXNl
dCA9IG9mX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShucCwgTlVMTCk7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihyZXNldCkpIHsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gUFRS
X0VSUihyZXNldCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGdvdG8gZXJyX2F0dGFjaF9jbGs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfSBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChyZXNldCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBnb3RvIGVycl9yZXNldDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+
IAo+IFRoZSBlbHNlIGlzIHN1cGVyZmx1b3VzLCByaWdodD8KClllcCwgd2UgY291bGQgbW92ZSB0
aGF0IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoKSBvdXQgb2YgdGhlIGVsc2UgYmxvY2suCklmIHRo
ZXJlIGFyZSBubyBvdGhlciBjaGFuZ2VzLCBJJ2xsIHNlbmQgYSB2NCB3aXRoIHRoYXQuCgpDaGVl
cnMsCgoKSmVyZW15Cg==

