Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E295704465
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjEPEq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEPEq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:46:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C176AC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 21:46:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F0EE2C03F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:46:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684212399;
        bh=x1xSqqcIQxo4yHnGi/aeTOVQvkwH8+dImv0jo+KukAs=;
        h=From:To:CC:Subject:Date:From;
        b=KDqrgq9avkC0r2u2Gc2EzTLJ2Daq9hQsE6aKszFQGoqbMginDxK5b2/zspwixSMvH
         zGpm769zCzmrKg/BLnQYz1h7/HGvZKL2WS9b/FcEqBOhsPNxLQRsEGAl+/TFFjFCOD
         2XMdqy+mSHht0DeQW/yJ+aWLYwoXmbR1S8Alut2uQRrTDC4VioMXsGjBrHzqYhDXGI
         atyvUDJeYKPrnVava8pr9+gvgqUxQLYfuS8iMhmnf/ZV44g15m6GqKK1UWY4z4Ozdy
         8VgFGG/1fPcYE3ha5+WpyTfaJUPflx53AAMlYUhur6k9seGkcwgAYsfiBkLAadIp/Y
         BwqHXfXz0qfUg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64630aaf0000>; Tue, 16 May 2023 16:46:39 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Tue, 16 May 2023 16:46:38 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Tue, 16 May 2023 16:46:38 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Tue, 16 May 2023 16:46:38 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Marvell NFC timings on CN9130
Thread-Topic: Marvell NFC timings on CN9130
Thread-Index: AQHZh7FmJPDyhVgaf0OyIHAzbKJ+ow==
Date:   Tue, 16 May 2023 04:46:38 +0000
Message-ID: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <786D3EEAC51A214A804B27DB0F8E80E8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=V49VWFFmnWFogDPQAP4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLCBUaG9tYXMsDQoNCkEgaGFyZHdhcmUgY29sbGVhZ3VlIHJlcG9ydGVkIGEgY29u
Y2VybiB0byBtZSBhYm91dCBhIG5ldyBkZXNpZ24gd2UgaGF2ZSANCnVzaW5nIHRoZSBNYXJ2ZWxs
IENOOTEzMCBTb0MgKHdoaWNoIEkgdGhpbmsgd2FzIGNhbGxlZCBBcm1hZGEtOEsgYmVmb3JlIA0K
dGhleSByZWJyYW5kZWQpLg0KDQpCYXNpY2FsbHkgdGhlaXIgY29uY2VybiBpcyB0aGF0IHRoZSB0
V0MgdGltaW5nIHRoZXkgb2JzZXJ2ZSBpcyBmYXN0ZXIgDQoofjE4bnMpIHRoYW4gdGhlIGRvY3Vt
ZW50ZWQgbWluaW11bSBpbiB0aGUgaGFyZHdhcmUgZGF0YXNoZWV0IGZvciB0aGUgDQpDTjkxMzAg
KDI1bnMpLiBBc2lkZSBmcm9tIG5vdCBtZWV0aW5nIHRoZSBkYXRhc2hlZXQgc3BlYyB3ZSd2ZSBu
b3QgDQpvYnNlcnZlZCBhbnkgb3RoZXIgaXNzdWUgKHlldCkuDQoNCkkgbm90aWNlIGluIHRoZSBt
YXJ2ZWxsX25hbmQuYyBkcml2ZXIgdGhhdCBtYXJ2ZWxsX25mY19pbml0KCkgc2V0cyB0aGUgDQpO
QU5EIENsb2NrIEZyZXF1ZW5jeSBTZWxlY3QgYml0ICgweEYyNDQwNzAwOjApIHRvIDEgd2hpY2gg
cnVucyBhY2NvcmRpbmcgDQp0byB0aGUgZGF0YXNoZWV0IHRoZSBOQU5EIGZsYXNoIGF0IDQwME1I
eiAuIEJ1dCB0aGUgY2FsY3VsYXRpb25zIGluIA0KbWFydmVsbF9uZmNfc2V0dXBfaW50ZXJmYWNl
KCkgdXNlIHRoZSB2YWx1ZSBmcm9tIA0KY2xrX2dldF9yYXRlKG5mYy0+Y29yZV9jbGspIHdoaWNo
IGlzIHN0aWxsIDI1ME1IeiBzbyBJJ20gd29uZGVyaW5nIGlmIA0KbWF5YmUgdGhlIGZhY3QgdGhh
dCB0aGUgTkFORCBmbGFzaCBpcyBiZWluZyBydW4gZmFzdGVyIGlzIGhhdmluZyBhbiANCmltcGFj
dCBvbiB0aW1pbmdzIHRoYXQgYXJlIGNhbGN1bGF0ZWQgYXJvdW5kIHRoZSBjb3JlX2NsayBmcmVx
dWVuY3kuDQoNCkRvIHlvdSB0aGluayB0aGF0IHRoZSB0aW1pbmdzIGNhbGN1bGF0aW9ucyBzaG91
bGQgdGFrZSB0aGUgTkFORCBDbG9jayANCkZyZXF1ZW5jeSBTZWxlY3Qgc2V0dGluZyBpbnRvIGFj
Y291bnQ/DQoNClRoYW5rcywNCkNocmlzDQo=
