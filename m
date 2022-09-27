Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC15EBB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiI0HOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI0HO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:14:28 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95019294
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:14:25 -0700 (PDT)
X-UUID: fe7cb102af554dc6a2f78404c7e13c1d-20220927
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2226a127-c713-4c85-a74d-0bfbbca74abf,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:cab35ae4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fe7cb102af554dc6a2f78404c7e13c1d-20220927
Received: from mail.phison.com [(192.168.1.112)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 418285534; Tue, 27 Sep 2022 15:14:18 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX1.phison.com
 (192.168.1.112) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 27 Sep
 2022 15:14:17 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Tue, 27 Sep 2022 15:14:17 +0800
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
Thread-Index: AQHY0j/4wQsO+hvIkEO1rJFSkOxQRa3y3Hug
Date:   Tue, 27 Sep 2022 07:14:16 +0000
Message-ID: <3aeb692e9037462b9f9a23a60277b80c@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
 <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
 <20220923061130.GA15835@lst.de>
 <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
 <20220927070822.GA15262@lst.de>
In-Reply-To: <20220927070822.GA15262@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: multipart/mixed;
        boundary="_002_3aeb692e9037462b9f9a23a60277b80cExMBX2phisoncom_"
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_3aeb692e9037462b9f9a23a60277b80cExMBX2phisoncom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBDaHJpc3RvcGgsDQoNClBsZWFzZSBmaW5kIHRoZSBzaW5nZWQtb2ZmLWJ5IGxpbmUgYmVs
b3cuDQoNCi8vc2lnbmVkLW9mZi1ieTogVGluYSBIc3UgPHRpbmFfaHN1QHBoaXNvbi5jb3JwLXBh
cnRuZXIuZ29vZ2xlLmNvbT4vLw0KDQpSZWF0dGFjaCB0aGUgcGF0Y2ggYWdhaW4NClRoYW5rcw0K
DQpSaXRhIExpbsHW3b3s0w0KKzg4Ni0zNy01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBw
aGlzb24uY29tDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9w
aCBIZWxsd2lnIFttYWlsdG86aGNoQGxzdC5kZV0NClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAy
NywgMjAyMiAzOjA4IFBNDQpUbzogUml0YSBMaW4gPHJpdGFjaF9saW5AcGhpc29uLmNvbT4NCkNj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz47IEplbnMgQXhib2UgPGF4Ym9lQGZiLmNvbT47IFNhZ2kgR3JpbWJlcmcgPHNhZ2lA
Z3JpbWJlcmcubWU+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IPxT6smsfCA8cmVkZF9odWFuZ0BwaGlzb24uY29tPjsgVGluYSBI
c3UgPHRpbmFfaHN1QHBoaXNvbi5jb20+OyBWaXRhIEhzdWVoICjRptLB2bspIDxWaXRhLkhzdWVo
QHF1YW50YXR3LmNvbT47IFdhbmcsIEF1ZHJleSA8YXVkcmV5LndhbmdAaHAuY29tPg0KU3ViamVj
dDogUmU6IG52bWUtcGNpOiBkaXNhYmxlIHdyaXRlIHplcm9zIHN1cHBvcnQgb24gU1NEcw0KDQpP
biBGcmksIFNlcCAyMywgMjAyMiBhdCAwNjoxNjowMUFNICswMDAwLCBSaXRhIExpbiB3cm90ZToN
Cj4gRGVhciBDaHJpc3RvcGgsDQo+DQo+IFRoZSBzaWduZWQgb2ZmIGluZm9ybWF0aW9uIHdhcyBw
dXQgaW4gbGluZSAxMCBpbiBwcmV2aW91cyBwYXRjaC4NCj4gSSB3YXMgbm90IGFibGUgdG8gYXR0
YWNoIGFuIGltYWdlIHRvIGlkZW50aWZ5IHRoZSBsb2NhdGlvbiB0byB5b3UuDQoNCkkgaGF2ZSBu
b3QgYmVlbiBhYmxlIHRvIGZpbmQgYSBTaWduZWQtb2ZmLWJ5OiBsaW5lLiAgUGxlYXNlIHByb3Zp
ZGUgb25lIGluIHJlcGx5IHRvIHRoaXMgbWFpbC4NCg0KDQpUaGlzIG1lc3NhZ2UgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVnYWxseSBwcml2aWxlZ2Vk
LiBBbnkgdW5hdXRob3JpemVkIHJldmlldywgdXNlIG9yIGRpc3RyaWJ1dGlvbiBieSBhbnlvbmUg
b3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHN0cmljdGx5IHByb2hpYml0ZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBpbW1lZGlhdGVs
eSBub3RpZnkgdGhlIHNlbmRlciwgY29tcGxldGVseSBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFu
eSBhdHRhY2htZW50cywgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcy4gWW91ciBjb29wZXJhdGlvbiB3
aWxsIGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCg==

--_002_3aeb692e9037462b9f9a23a60277b80cExMBX2phisoncom_
Content-Type: application/octet-stream;
	name="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"
Content-Description: 0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch
Content-Disposition: attachment;
	filename="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"; size=1421;
	creation-date="Tue, 27 Sep 2022 07:13:25 GMT";
	modification-date="Tue, 27 Sep 2022 07:13:25 GMT"
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

--_002_3aeb692e9037462b9f9a23a60277b80cExMBX2phisoncom_--

