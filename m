Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199C36E3D51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDQCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDQCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:06:44 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D82132
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:06:41 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7F0792C046D;
        Mon, 17 Apr 2023 14:06:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681697199;
        bh=CTVTacEO1VjVFCXn4U7PXUGyX8f/5RYczQkksR4LeIY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JK1+evqS5d+FjSp5rsJxtOwQzQS3EmOy/4mM+8BYzcQbIFXplt3R3o7l6Khzgq/hK
         wZeTrEKynL7A+QMrX6uaew4ZPv0mjoQ84q6LjFyOHsM7+/mAWeOfUe2ecCzXoAI444
         heht06hWMc87EU/PdDyJaKrWvmJ9jcwiTa3IT++etyoh2a949xjx6ei8Uh3bcKe4In
         g+Dlb0vqNb3o13dF2CfKhW1CCaMkN84WMKbd+S136ffk08jbxaJtGRaDUb8VU5MQaI
         e2L7D8CtgsS7unhi2DPkr2KZ8K8jBIpNRH/WCYnYlvhtW3yUYhhUwhDVmf4FeQeH+a
         5juWktfSYpNqw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643ca9af0001>; Mon, 17 Apr 2023 14:06:39 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Apr 2023 14:06:39 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 17 Apr 2023 14:06:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Lachezar Temelkov <lachezar.temelkov@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SPI Device tree question from blog
Thread-Topic: SPI Device tree question from blog
Thread-Index: AQHZcMTCkCNg4HrSFUao9N/kdqwUSq8t98gA
Date:   Mon, 17 Apr 2023 02:06:39 +0000
Message-ID: <8ad49426-51f0-11db-f44c-aa6cd27a3947@alliedtelesis.co.nz>
References: <CAGdCHaYK09FDu0-TBDv92y8dy+X=7+rsRiMF5PEothi-Zp7uqA@mail.gmail.com>
In-Reply-To: <CAGdCHaYK09FDu0-TBDv92y8dy+X=7+rsRiMF5PEothi-Zp7uqA@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9AA80F28BBE644D800DD834F7D160CC@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=VwQbUJbxAAAA:8 a=D_PGH6MP_eeqzWSGoLUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KGFkZGluZyBsaW51eC1zcGkrbGttbCkNCg0KSGkgTGFjaCwNCg0KT24gMTcvMDQvMjMgMTI6MzYs
IExhY2hlemFyIFRlbWVsa292IHdyb3RlOg0KPiBIaSBDaHJpcywNCj4NCj4gTXkgbmFtZSBpcyBM
YWNoIFRlbWVsa292IGFuZCBJIHNhdyB5b3VyIGRldmljZSB0cmVlIGltcGxlbWVudGF0aW9uIGhl
cmU6DQo+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvc3BpLW11eC55YW1sDQoobm90ZSBjaGFuZ2VkIFVSTCB0byBwb2ludCB0byB0aGUgY2Fu
b25pY2FsIHVwc3RyZWFtLCBjb250ZW50IGlzIHRoZSBzYW1lKQ0KPiBTaW5jZSBteSBaeW56IFo3
MDAwIFNvQyBkb2VzIG5vdCBoYXZlIGVub3VnaCBTUEksIEkgYW0gdXNpbmcgb25lIFNQSSANCj4g
aG9zdCBhbmQgbXVsdGlwbGV4aW5nIHRoZSBzbGF2ZSBzZWxlY3QgcGlucyBhcyB5b3UgZG8gaW4g
dGhlIGxpbmsgYWJvdmUuDQo+DQo+IEhvd2V2ZXIsIGluIG15IGFwcGxpY2F0aW9uLCBvbmUgbWFz
dGVywqAgYm9hcmQgd2l0aCBaeW5xIFo3MDAwIHNlbmRzIA0KPiBzcGlfY2xrLCBzcGlfbW9zaSBh
bmQgc3BpX21pc28gKCBhbG9uZyB3aXRoIHNsYXZlIHNlbGVjdHMpIHRvIDggb3RoZXIgDQo+IElP
IGJvYXJkcywgc28gSSBtdXggdGhlIHNwaV9jbGssIG1vc2kgYW5kIG1pc28gYXMgd2VsbC4NCj4N
Cj4gU28sIG4gdGhlIGVuZCzCoCBJIGhhdmUgMiBtdWx0aXBsZXhlcnMoIHRoYXQgacKgY29udHJv
bMKgZnJvbSBvbmUgOCBiaXQgDQo+IGdwaW8pICwgMSBtdXjCoCBjb250cm9scyB0aGUgc2xhdmUg
c2VsZWN0KCBhcyBpbiB0aGUgdXJsIGFib3ZlKSBhbmQgDQo+IGFub3RoZXIgbXV4IGNvbnRyb2xs
aW5nIHdoaWNoIElPIGJvYXJkIHRoZSBzcGlfY2xrLCBtb3NpIGFuZCBtaXNvIHdpbGwgZ28uDQo+
DQo+IFRoaXMgaXMgZG9uZSBzbyB0aGF0IGFuIEVNSSggZWxlY3Ryb21hZ25ldGljIGludGVyZmVy
ZW5jZSkgYW5kIA0KPiByYWRpYXRpb24gZG9lcyBub3Qgb2NjdXItIGUuZywgaXQgcHJldmVudHMg
dGhlIHNwaSBfY2xvY2sgc2lnbmFscyB0byANCj4gc2ltdWx0YW5lb3VzbHkgZ28gdG8gOCBkaWZm
ZXJlbnQgYm9hcmRzLSAxMiIgYXBwYXJ0LiBBbHNvIGl0wqBoZWxwcyANCj4gd2l0aCBzaWduYWwg
aW50ZWdyaXR5Lg0KPg0KPiBDb3VsZCB5b3UgcGxlYXNlwqAgdGVsbCBtZSAoIGEgZHRzIHNuaXBw
ZXQgbWF5YmUpLCBob3cgdGhlIGRldmljZSB0cmVlIA0KPiB3b3VsZCBsb29rIGxpa2Ugd2l0aCAy
IG11eGVzLiBIb3cgY2FuIGkgY29tYmluZSB0aGVtDQo+DQo+IC0gbXV4IDE6IDQgYml0cyAtIGNo
b29zZXPCoCAxNiBzbGF2ZSBzZWxlY3RzDQo+IC0gbXV4IDIgOjMgYml0cyAtIGNob29zZXMgOCBJ
TyBib2FyZHMNCj4NCj4gSSByZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIGlucHV0LA0KPg0KSSBkZXZl
bG9wZWQgdGhlIHNwaS1tdXggc3VwcG9ydCB3aXRoIGJvYXJkcyB0aGF0IGNvbm5lY3RlZCBqdXN0
IHRoZSBDUyANCnZpYSBhIG11eCwgdGhlIG90aGVyIGxpbmVzIHdlcmUgd2lyZWQgdG9nZXRoZXIu
IFNvIGl0J3Mgbm90IHJlYWxseSANCnNvbWV0aGluZyB0aGF0IEkgY29uc2lkZXJlZC4NCg0KVGhl
IGNvbXBsaWNhdGlvbiBmb3IgeW91IGlzIGluIHRoZSBtdXggaXRzZWxmLiBUaGUgc3BpLW11eCBj
b2RlIHNob3VsZCANCndvcmsgZmluZSBwcm92aWRlZCB0aGVyZSBpcyBhIG11eCBkcml2ZXIgdGhh
dCBkb2VzIHdoYXQgeW91IG5lZWQuIEkgDQpkb24ndCB0aGluayB0aGUgZXhpc3RpbmcgZ3Bpby1t
dXggZHJpdmVyIHdpbGwgaGFuZGxlIGhhdmluZyAxIHN0YXRlIA0KbWFwcGVkIHRvID4xIGdwaW8g
c28geW91J2QgcHJvYmFibHkgbmVlZCB0byBjcmVhdGUgeW91ciBvd24gbXV4IGRyaXZlciANCnRo
YXQgZGVhbHMgd2l0aCB0aGF0LiBZb3UgbWlnaHQgYmUgYWJsZSB0byBkbyBzb21lIGtpbmQgb2Yg
bXVsdGktbGV2ZWwgDQptdXggYnV0IHRoYXQgcHJvYmFibHkgd29uJ3QgcGxheSBuaWNlIHdpdGgg
dGhlIENTIGxpbmVzLg0KDQo=
