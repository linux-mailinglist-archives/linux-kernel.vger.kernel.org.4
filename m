Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8374F63B0C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiK1SJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiK1SJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:09:03 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA62F3B5;
        Mon, 28 Nov 2022 09:52:53 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C8C1C5FD0A;
        Mon, 28 Nov 2022 20:45:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669657522;
        bh=iy1fZBZWnDEUhSQU2sXf3XtLzGXLg1P+TsmfD374+ZY=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=jVI5Yz7UwsHPvPTPu2t/fv+PrEBn0pT9T1T4q+8HQs6XvVfH8yKpxolX6bYywild7
         bw5oDHrp/6Av2CzTPSwNrL7VSFZGk7qNq2rxw24cuoByEbSAh3TVW54RlsPJG6QvwN
         zVaYrmGUYONZNe0LD9sUr9TrmgbWz5cq7kQ8V69Z6a1AD+elE5nd0z5Oj4t+Ix1Etw
         Ap74kP2tpsZDsYQ5DBY+jXHhl7Sppa5wJfOGyFarwEwJnlIcqkMJrX2YRb9yaSIbPU
         I1eejPncw7rg6Qby/KdgTo44eiXMu5YiWNd78GWDGoYD2R4LtY1ijeDQ2/u1KlrpBm
         fLQbgZuRBhK3A==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 28 Nov 2022 20:45:22 +0300 (MSK)
From:   Martin Kurbanov <MMKurbanov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 2/2] leds: add aw20xx driver
Thread-Topic: [PATCH v1 2/2] leds: add aw20xx driver
Thread-Index: AQHZAEYwOD17Fcl1GkualPBYD4ofhK5PGnoAgAVVCgA=
Date:   Mon, 28 Nov 2022 17:45:22 +0000
Message-ID: <cb9e8610-588e-6e56-ee33-8716008e7905@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
 <ba4918dd-309c-5e6e-dc0a-eb5f1c4b1dfa@linaro.org>
In-Reply-To: <ba4918dd-309c-5e6e-dc0a-eb5f1c4b1dfa@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE73C7A8645F747BE3144545EACD9B1@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/28 12:12:00 #20620243
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTEuMjAyMiAxMToxOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+ICsgICAg
JCBscyAtbCAvc3lzL2J1cy9pMmMvZGV2aWNlcy94eHh4L3BhdHRlcm4wLw0KPj4gKyAgICAtcnct
ci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAgICA0MDk2IEphbiAgMSAwMDowMCBjbGVh
cl9sZWRzDQo+PiArICAgIC1ydy1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQw
OTYgSmFuICAxIDAwOjAwIGZhbGxfdGltZQ0KPj4gKyAgICAtcnctci0tci0tICAgIDEgcm9vdCAg
ICAgcm9vdCAgICAgICAgICA0MDk2IEphbiAgMSAwMDowMCBsb29wX2JlZ2luDQo+PiArICAgIC1y
dy1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQwOTYgSmFuICAxIDAwOjAwIGxv
b3BfZW5kX29uDQo+PiArICAgIC1ydy1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAg
IDQwOTYgSmFuICAxIDAwOjAwIG1heF9icmVhdGhpbmdfbGV2ZWwNCj4+ICsgICAgLXJ3LXItLXIt
LSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgICAgNDA5NiBKYW4gIDEgMDA6MDAgbWluX2JyZWF0
aGluZ19sZXZlbA0KPj4gKyAgICAtcnctci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAg
ICA0MDk2IEphbiAgMSAwMDowMCBtb2RlDQo+PiArICAgIC1ydy1yLS1yLS0gICAgMSByb290ICAg
ICByb290ICAgICAgICAgIDQwOTYgSmFuICAxIDAwOjAwIG9mZl90aW1lDQo+PiArICAgIC1ydy1y
LS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQwOTYgSmFuICAxIDAwOjAwIG9uX3Rp
bWUNCj4+ICsgICAgLXJ3LXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgICAgNDA5NiBK
YW4gIDEgMDA6MDAgcmFtcA0KPj4gKyAgICAtcnctci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAg
ICAgICAgICA0MDk2IEphbiAgMSAwMDowMCByZXBlYXQNCj4+ICsgICAgLXJ3LXItLXItLSAgICAx
IHJvb3QgICAgIHJvb3QgICAgICAgICAgNDA5NiBKYW4gIDEgMDA6MDAgcmlzZV90aW1lDQo+PiAr
ICAgIC1yLS1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQwOTYgSmFuICAxIDAw
OjAwIHJ1bm5pbmcNCj4+ICsgICAgLXJ3LXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAg
ICAgNDA5NiBKYW4gIDEgMDA6MDAgc2VsZWN0X2xlZHMNCj4+ICsgICAgLXJ3LXItLXItLSAgICAx
IHJvb3QgICAgIHJvb3QgICAgICAgICAgNDA5NiBKYW4gIDEgMDA6MDAgc3RhcnQNCj4+ICsgICAg
LXJ3LXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgICAgNDA5NiBKYW4gIDEgMDA6MDAg
dG9nZ2xlDQo+IA0KPiBzeXNmcyBkb2N1bWVudGF0aW9uIGdvZXMgdG8gRG9jdW1lbnRhdGlvbi9B
QkkvDQoNClNob3VsZCBJIGFkZCBpdCB0byBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWNsYXNzLWxlZC1kcml2ZXItYXcyMDB4eD8NCklzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8N
CklzIEtlcm5lbFZlcnNpb24gcGFyYW1ldGVyIHJlcXVpcmVkPw0KDQoNCj4+ICsJY2hpcCA9IGRl
dm1fa3phbGxvYygmY2xpZW50LT5kZXYsDQo+PiArCQkJICAgIHN0cnVjdF9zaXplKGNoaXAsIGxl
ZHMsIGNvdW50KSwNCj4gDQo+IHNpemVvZigqY2hpcCkNCg0KVW5mb3J0dW5hdGVseSwgaXQgd2ls
bCBub3Qgd29yay4gQmVjYXVzZSBJIHdhbnQgdG8gY2FsY3VsYXRlIHRoZSB3aG9sZQ0Kc2l6ZSBv
ZiBjaGlwIHN0cnVjdHVyZSwgaXQgaGFzIGZsZXhpYmxlIGFycmF5IG1lbWJlciBpbnNpZGUuDQoN
Ci0tIA0KQmVzdCBSZWdhcmRzLA0KS3VyYmFub3YgTWFydGluDQoNCg==
