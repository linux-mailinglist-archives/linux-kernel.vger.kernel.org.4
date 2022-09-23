Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DBE5E73C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIWGQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIWGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:16:16 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BF1251B4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:16:09 -0700 (PDT)
X-UUID: 2c322588028743f6a294428bfaff513f-20220923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3994f220-7937-4cd3-919b-7a0981c8dcd8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:7ed4f9e3-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2c322588028743f6a294428bfaff513f-20220923
Received: from mail.phison.com [(192.168.1.113)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 100404508; Fri, 23 Sep 2022 14:16:03 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX2.phison.com
 (192.168.1.113) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 23 Sep
 2022 14:16:02 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Fri, 23 Sep 2022 14:16:02 +0800
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
Thread-Index: AQHYzxNtQi5UhZQ6SUWSK6rbmXfzH63siVcw
Date:   Fri, 23 Sep 2022 06:16:01 +0000
Message-ID: <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
 <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
 <20220923061130.GA15835@lst.de>
In-Reply-To: <20220923061130.GA15835@lst.de>
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

RGVhciBDaHJpc3RvcGgsDQoNClRoZSBzaWduZWQgb2ZmIGluZm9ybWF0aW9uIHdhcyBwdXQgaW4g
bGluZSAxMCBpbiBwcmV2aW91cyBwYXRjaC4NCkkgd2FzIG5vdCBhYmxlIHRvIGF0dGFjaCBhbiBp
bWFnZSB0byBpZGVudGlmeSB0aGUgbG9jYXRpb24gdG8geW91Lg0KDQpSaXRhIExpbsHW3b3s0w0K
Kzg4Ni0zNy01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBwaGlzb24uY29tDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9waCBIZWxsd2lnIFttYWlsdG86
aGNoQGxzdC5kZV0NClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIzLCAyMDIyIDI6MTIgUE0NClRv
OiBSaXRhIExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVucyBBeGJv
ZSA8YXhib2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
/FPqyax8IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29u
LmNvbT47IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2Fu
ZywgQXVkcmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRp
c2FibGUgd3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCk9uIEZyaSwgU2VwIDIzLCAyMDIy
IGF0IDAzOjE4OjUyQU0gKzAwMDAsIFJpdGEgTGluIHdyb3RlOg0KPiBEZWFyIENocmlzdG9waCwN
Cj4NCj4gV2UgaGFkIGluY2x1ZGVkIHNpZ25lZCBvZmYgYnkgaW5mb3JtYXRpb24gaW4gdGhlIHBh
dGNoLg0KDQpJJ3ZlIG5vdCBhY3R1YWxseSBmb3VuZCBhIHNpZ25vZmYgaW4gZWl0aGVyIHZlcnNp
b24gb2YgdGhlIHBhdGNoLg0KDQoNClRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGFy
ZSBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEFueSB1bmF1dGhv
cml6ZWQgcmV2aWV3LCB1c2Ugb3IgZGlzdHJpYnV0aW9uIGJ5IGFueW9uZSBvdGhlciB0aGFuIHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUg
c2VuZGVyLCBjb21wbGV0ZWx5IGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRz
LCBhbmQgZGVzdHJveSBhbGwgY29waWVzLiBZb3VyIGNvb3BlcmF0aW9uIHdpbGwgYmUgaGlnaGx5
IGFwcHJlY2lhdGVkLg0K

