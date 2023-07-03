Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE8745588
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGCGis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:38:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8954CC;
        Sun,  2 Jul 2023 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688366325; x=1719902325;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=XY0H3vpbe1CY3a8pLjAJo9l/2ZEaI81wluzp+nLFyyA=;
  b=Nm8cC+UcdK+MtJbLCv+oMI+hYS4ae0SdCNuXDtbYW6q3JiRTSZBG8R3E
   mkoR1YT2cnPj/JAmzfQjYm2C4D7y9T4NukGqwGDQpUtHrzEbxyOoVo4di
   /dOfueqk7llbRvCq9SWLGcf4CtGCoLuCwCdRhE7ms3ctlCGC/x7cyUW3A
   TAuEktgxx1zLy0zTmAdE9mZfxnRKR4Al+bYo4pYXIMBoR2tHrnWHt/8zd
   m4I2vhDXucrmhE1zkgrGBE6UXl5udo7ZUKlwEyMr9TSXxRSTdCjht1+cY
   O8de/AkpMDCjnrOvc897ILZygwuSR4Wk6nieKHmgQuRwRRodbr5B50Ru0
   w==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="221002744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2023 23:38:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Jul 2023 23:38:44 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 2 Jul 2023 23:38:42 -0700
Message-ID: <590ccbc8e32e7c85392ba331a83d00ad81eae0c8.camel@microchip.com>
Subject: Re: [PATCH 1/2] arm64: dts: microchip: minor whitespace cleanup
 around '='
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 3 Jul 2023 08:38:41 +0200
In-Reply-To: <20230702185108.43959-1-krzysztof.kozlowski@linaro.org>
References: <20230702185108.43959-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTAyIGF0IDIwOjUxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlCj4gY29udGVudCBpcyBzYWZlCj4gCj4gVGhlIERUUyBj
b2RlIGNvZGluZyBzdHlsZSBleHBlY3RzIGV4YWN0bHkgb25lIHNwYWNlIGJlZm9yZSBhbmQgYWZ0
ZXIgJz0nCj4gc2lnbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+Cj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9zcGFyeDUuZHRzaSB8IDEyICsrKysrKy0tLS0tLQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1LmR0c2kKPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NS5kdHNpCj4gaW5kZXggNDk5NjQ5OWNjNzM4Li4yNDA3
NWNkOTE0MjAgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bh
cng1LmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFyeDUuZHRz
aQo+IEBAIC00NjksMTQgKzQ2OSwxNCBAQCBzZXJkZXM6IHNlcmRlc0AxMDgwODAwMCB7Cj4gCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaDogc3dpdGNoQDYwMDAwMDAwMCB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzcGFyeDUtc3dpdGNoIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID3CoMKgIDwweDYgMCAweDQwMTAwMD4sCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA8MHg2IDB4MTAwMDQwMDAgMHg3ZmMwMDA+LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDB4NiAweDExMDEwMDAwIDB4YWYw
MDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVn
ID0gPDB4NiAwIDB4NDAxMDAwPiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDB4NiAweDEwMDA0MDAwIDB4N2ZjMDAwPiwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDB4
NiAweDExMDEwMDAwIDB4YWYwMDAwPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJlZy1uYW1lcyA9ICJjcHUiLCAiZGV2IiwgImdjYiI7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQtbmFtZXMg
PSAieHRyIiwgImZkbWEiLCAicHRwIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9wqDCoMKgIDxHSUNfU1BJIDMwIElSUV9UWVBFX0xF
VkVMX0hJR0g+LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxHSUNfU1BJIDI1IElSUV9UWVBFX0xF
VkVMX0hJR0g+LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxHSUNfU1BJIDI3IElSUV9UWVBFX0xF
VkVMX0hJR0g+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzAgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgPEdJQ19TUEkgMjUgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgPEdJQ19TUEkgMjcgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNldHMgPSA8JnJlc2V0IDA+Owo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXQtbmFtZXMgPSAi
c3dpdGNoIjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiAtLQo+IDIuMzQu
MQo+IApSZXZpZXdlZC1ieTogU3RlZW4gSGVnZWx1bmQgPFN0ZWVuLkhlZ2VsdW5kQG1pY3JvY2hp
cC5jb20+CgpCUgpTdGVlbgo=

