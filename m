Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D95E725D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiIWDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIWDTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:19:03 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C944115A6F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:19:00 -0700 (PDT)
X-UUID: df5d27741db544aca526f1b9a8177122-20220923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e28a0c00-9859-410f-91b3-6104cc68d46c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:c91fc006-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: df5d27741db544aca526f1b9a8177122-20220923
Received: from mail.phison.com [(192.168.1.112)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2047599724; Fri, 23 Sep 2022 11:18:54 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX1.phison.com
 (192.168.1.112) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 23 Sep
 2022 11:18:52 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Fri, 23 Sep 2022 11:18:52 +0800
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
Thread-Index: AQHYzo9mLRoycnw5e06F0MlERwYXUq3sWP0A
Date:   Fri, 23 Sep 2022 03:18:52 +0000
Message-ID: <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
In-Reply-To: <20220922142626.GB28397@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: multipart/mixed;
        boundary="_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_"
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBDaHJpc3RvcGgsDQoNCldlIGhhZCBpbmNsdWRlZCBzaWduZWQgb2ZmIGJ5IGluZm9ybWF0
aW9uIGluIHRoZSBwYXRjaC4NCldlIHdpbGwgdXNlIHBoaXNvbi5jb3JwLXBhcnRuZXIuZ29vZ2xl
LmNvbSBmb3IgdGhpcyBjYXNlLg0KVGhhbmsgeW91Lg0KDQpSaXRhIExpbsHW3b3s0w0KKzg4Ni0z
Ny01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBwaGlzb24uY29tDQoNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9waCBIZWxsd2lnIFttYWlsdG86aGNoQGxz
dC5kZV0NClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjIgMTA6MjYgUE0NClRvOiBS
aXRhIExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVucyBBeGJvZSA8
YXhib2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg/FPq
yax8IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNv
bT47IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2FuZywg
QXVkcmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRpc2Fi
bGUgd3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCkNhbiB5b3UgZ2l2ZSBtZSBhIFNpZ25l
ZC1vZmYtYnk6IGZvciB0aGlzIHBhdGNoIGFzIHdlbGw/DQoNCkFsc28gc2hvdWxkIHRoaXMgcmVh
bGx5IHVzZSB0aGUgcGhpc29uLmNvcnAtcGFydG5lci5nb29nbGUuY29tIG9yIHBoaXNvbi5jb20g
Zm9yIHRoZSBBdXRob3IgaWRlbnRpZmljYXRpb24/ICAoU2FtZSBmb3IgdGhlIHNpZ25vZmYpLg0K
DQoNCg0KVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBh
bmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVz
ZSBvciBkaXN0cmlidXRpb24gYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIsIGNvbXBsZXRl
bHkgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMsIGFuZCBkZXN0cm95IGFs
bCBjb3BpZXMuIFlvdXIgY29vcGVyYXRpb24gd2lsbCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuDQo=

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_
Content-Type: application/octet-stream;
	name="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"
Content-Description: 0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch
Content-Disposition: attachment;
	filename="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"; size=1421;
	creation-date="Fri, 23 Sep 2022 03:18:49 GMT";
	modification-date="Fri, 23 Sep 2022 03:18:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNWEzMmE4NWZmYTI2Y2JiZjA2NDlkMmI1NDU3ZjZlMTNlYzg1OTAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvcnAtcGFydG5l
ci5nb29nbGUuY29tPgpEYXRlOiBUaHUsIDIyIFNlcCAyMDIyIDE0OjE2OjMwICswODAwClN1Ympl
Y3Q6IFtQQVRDSF0gW1BBVENIXSBBZGQgUGhpc29uIEUzQy9FNEMgRGlzYWJsZSBXcml0ZSBaZXJv
CgpFM0MvRTRDIFNTRHMgZG8gc3VwcG9ydCB3cml0ZSAwIGNvbW1hbmQgYW5kIHRoZSBmdW5jdGlv
biB3YXMgdGVzdGVkIHdpdGhvdXQgaXNzdWUuCkJ1dCBzaW5jZSB0aGVzZSBTU0RzIGFyZSBEUkFN
bGVzcyBwcm9kdWN0cywgdGhlIHdyaXRlIDAgY29tbWFuZCB3aWxsIHRha2UgYSBsb3QgbG9uZ2Vy
IHRvIGNvbXBsZXRlIHdoaWNoIGhhZCBpbXBhY3RlZCB0aGUgcHJvZHVjdCBwZXJmb3JtYW5jZS4K
RHVlIHRvIHRoZSBGVyBoYWQgYmVlbiBmcm96ZW4sIHdlIHdvdWxkIGxpa2UgdG8gY2hlY2sgaWYg
d2UgY291bGQgYXBwbHkgQ0wgZm9yIHRoZXNlIDIgcHJvZHVjdHMuCgpzaWduZWQtb2ZmLWJ5OiBU
aW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvcnAtcGFydG5lci5nb29nbGUuY29tPgotLS0KIGRy
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYwppbmRleCA5ODg2NGI4NTNlZWYuLjY3ZDMzMzVlOWNjOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMK
QEAgLTM0NzAsNiArMzQ3MCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQg
bnZtZV9pZF90YWJsZVtdID0gewogCXsgUENJX0RFVklDRSgweDE5ODcsIDB4NTAxNiksCS8qIFBo
aXNvbiBFMTYgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5R
TiB8CiAJCQkJTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNFKDB4MTk4Nywg
MHg1MDE5KSwgIC8qIHBoaXNvbiBFMTkgKi8KKwkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19E
SVNBQkxFX1dSSVRFX1pFUk9FUywgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxOTg3LCAweDUwMjEpLCAg
IC8qIFBoaXNvbiBFMjEgKi8KKwkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dS
SVRFX1pFUk9FUywgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxYjRiLCAweDEwOTIpLAkvKiBMZXhhciAy
NTYgR0IgU1NEICovCiAJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfTk9fTlNfREVTQ19MSVNU
IHwKIAkJCQlOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFOLCB9LAotLSAKMi4yNS4xCgo=

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_--

