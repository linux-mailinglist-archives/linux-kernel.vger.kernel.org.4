Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BD5E5B00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIVFvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVFvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:51:05 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE57B4401
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:51:03 -0700 (PDT)
X-UUID: 3e1dab82188e4df9af119a6914f3938e-20220922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3095cd38-1ed9-4aa8-a4f5-1e8ec9751c34,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:8f1aa406-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3e1dab82188e4df9af119a6914f3938e-20220922
Received: from mail.phison.com [(192.168.1.112)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 236721958; Thu, 22 Sep 2022 13:50:54 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX1.phison.com
 (192.168.1.112) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 22 Sep
 2022 13:50:53 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Thu, 22 Sep 2022 13:50:53 +0800
From:   Rita Lin <ritach_lin@phison.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?/FPqyax8?= <redd_huang@phison.com>,
        Tina Hsu <tina_hsu@phison.com>,
        =?gb2312?B?Vml0YSBIc3VlaCAo0abSwdm7KQ==?= <Vita.Hsueh@quantatw.com>,
        "Wang, Audrey" <audrey.wang@hp.com>
Subject: RE: nvme-pci: disable write zeros support on SSDs
Thread-Topic: nvme-pci: disable write zeros support on SSDs
Thread-Index: AQHYzkSfe7UtL+HLHkWMegZBEIt1C63q8FPQ
Date:   Thu, 22 Sep 2022 05:50:52 +0000
Message-ID: <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
In-Reply-To: <20220922053137.GA27191@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBDaHJpc3RvcGgsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NClRoZXNlIFNTRHMg
ZG8gc3VwcG9ydCB3cml0ZSAwIGNvbW1hbmQgYW5kIHRoZSBmdW5jdGlvbiB3YXMgdGVzdGVkIHdp
dGhvdXQgaXNzdWUuDQpCdXQgc2luY2UgdGhlc2UgU1NEcyBhcmUgRFJBTWxlc3MgcHJvZHVjdHMs
IHRoZSB3cml0ZSAwIGNvbW1hbmQgd2lsbCB0YWtlIGEgbG90IGxvbmdlciB0byBjb21wbGV0ZSB3
aGljaCBoYWQgaW1wYWN0ZWQgdGhlIHByb2R1Y3QgcGVyZm9ybWFuY2UuDQpEdWUgdG8gdGhlIEZX
IGhhZCBiZWVuIGZyb3plbiwgd2Ugd291bGQgbGlrZSB0byBjaGVjayBpZiB3ZSBjb3VsZCBhcHBs
eSBDTCBmb3IgdGhlc2UgMiBwcm9kdWN0cy4NCg0KUml0YSBMaW7B1t297NMNCis4ODYtMzctNTg2
LTg5NiBFeHQuODAwNTENCnJpdGFjaF9saW5AcGhpc29uLmNvbQ0KDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyBbbWFpbHRvOmhjaEBsc3QuZGVd
DQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIyIDE6MzIgUE0NClRvOiBSaXRhIExp
biA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVs
Lm9yZz47IEplbnMgQXhib2UgPGF4Ym9lQGZiLmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg/FPqyax8IDxy
ZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvbT47IFZp
dGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2FuZywgQXVkcmV5
IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRpc2FibGUgd3Jp
dGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCk9uIFRodSwgU2VwIDIyLCAyMDIyIGF0IDAyOjAz
OjAxQU0gKzAwMDAsIFJpdGEgTGluIHdyb3RlOg0KPiBEZWFyIHJlY2VpdmVycywNCj4NCj4gV2Ug
d291bGQgbGlrZSB0byBhcHBseSB0byBkaXNhYmxlIHdyaXRlIHplcm9zIHN1cHBvcnQgb24gUGhp
c29uIFNTRHMuDQoNCkNhbiB5b3UgZXhwbGFpbiB3aHkgdGhlc2UgU1NEcyBkbyBjbGFpbSB3cml0
ZSBaZXJvZXMgYnV0IGl0IGRvZXNuJ3QgYWN0dWFsbHkgd29yaywgYW5kIHdoeSB0aGlzIGlzIG5v
dCBmaXhhYmxlIGluIGEgZmlybXdhcmUgdXBkYXRlPw0KDQoNClRoaXMgbWVzc2FnZSBhbmQgYW55
IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVn
ZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2Ugb3IgZGlzdHJpYnV0aW9uIGJ5IGFueW9u
ZSBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgc3RyaWN0bHkgcHJvaGliaXRl
ZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGltbWVkaWF0
ZWx5IG5vdGlmeSB0aGUgc2VuZGVyLCBjb21wbGV0ZWx5IGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQg
YW55IGF0dGFjaG1lbnRzLCBhbmQgZGVzdHJveSBhbGwgY29waWVzLiBZb3VyIGNvb3BlcmF0aW9u
IHdpbGwgYmUgaGlnaGx5IGFwcHJlY2lhdGVkLg0K

