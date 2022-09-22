Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D05E5B51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIVGYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIVGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:24:48 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C6754AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:24:42 -0700 (PDT)
X-UUID: 9eae84ef1aad4a7e8a89ff7ef3de3660-20220922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f24c85b6-8246-4179-aaf4-58df58173ddf,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:145da506-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9eae84ef1aad4a7e8a89ff7ef3de3660-20220922
Received: from mail.phison.com [(192.168.1.112)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2106766368; Thu, 22 Sep 2022 14:24:37 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX1.phison.com
 (192.168.1.112) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 22 Sep
 2022 14:24:36 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Thu, 22 Sep 2022 14:24:36 +0800
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
Thread-Index: AQHYzkeLe0OWZE9n0Eyf9CNz48F2CK3q+zuA
Date:   Thu, 22 Sep 2022 06:24:35 +0000
Message-ID: <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
In-Reply-To: <20220922055231.GA27560@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: multipart/mixed;
        boundary="_002_1c9807fea3424be486190a99c923a228ExMBX2phisoncom_"
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_1c9807fea3424be486190a99c923a228ExMBX2phisoncom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBDaHJpc3RvcGgsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBhZHZpY2UuDQpQbGVhc2UgZmlu
ZCB0aGUgdXBkYXRlZCBwYXRjaCBpbiB0aGUgYXR0YWNoZWQgZmlsZS4NCg0KUml0YSBMaW7B1t29
7NMNCis4ODYtMzctNTg2LTg5NiBFeHQuODAwNTENCnJpdGFjaF9saW5AcGhpc29uLmNvbQ0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyBbbWFp
bHRvOmhjaEBsc3QuZGVdDQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIyIDE6NTMg
UE0NClRvOiBSaXRhIExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVu
cyBBeGJvZSA8YXhib2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47
IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsg/FPqyax8IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VA
cGhpc29uLmNvbT47IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29t
PjsgV2FuZywgQXVkcmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1w
Y2k6IGRpc2FibGUgd3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCk9uIFRodSwgU2VwIDIy
LCAyMDIyIGF0IDA1OjUwOjUyQU0gKzAwMDAsIFJpdGEgTGluIHdyb3RlOg0KPiBEZWFyIENocmlz
dG9waCwNCj4NCj4gVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KPiBUaGVzZSBTU0RzIGRvIHN1
cHBvcnQgd3JpdGUgMCBjb21tYW5kIGFuZCB0aGUgZnVuY3Rpb24gd2FzIHRlc3RlZCB3aXRob3V0
IGlzc3VlLg0KPiBCdXQgc2luY2UgdGhlc2UgU1NEcyBhcmUgRFJBTWxlc3MgcHJvZHVjdHMsIHRo
ZSB3cml0ZSAwIGNvbW1hbmQgd2lsbCB0YWtlIGEgbG90IGxvbmdlciB0byBjb21wbGV0ZSB3aGlj
aCBoYWQgaW1wYWN0ZWQgdGhlIHByb2R1Y3QgcGVyZm9ybWFuY2UuDQo+IER1ZSB0byB0aGUgRlcg
aGFkIGJlZW4gZnJvemVuLCB3ZSB3b3VsZCBsaWtlIHRvIGNoZWNrIGlmIHdlIGNvdWxkIGFwcGx5
IENMIGZvciB0aGVzZSAyIHByb2R1Y3RzLg0KDQpwbGVhc2UgYWRkIGEgY29tbWVudCBleHBsYWlu
aW5nIHRoaXMgdG8gdGhlIElEcyBlbnRyeS4NCg0KDQpUaGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVnYWxseSBwcml2aWxlZ2VkLiBB
bnkgdW5hdXRob3JpemVkIHJldmlldywgdXNlIG9yIGRpc3RyaWJ1dGlvbiBieSBhbnlvbmUgb3Ro
ZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBpbW1lZGlhdGVseSBu
b3RpZnkgdGhlIHNlbmRlciwgY29tcGxldGVseSBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFueSBh
dHRhY2htZW50cywgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcy4gWW91ciBjb29wZXJhdGlvbiB3aWxs
IGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCg==

--_002_1c9807fea3424be486190a99c923a228ExMBX2phisoncom_
Content-Type: application/octet-stream;
	name="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"
Content-Description: 0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch
Content-Disposition: attachment;
	filename="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"; size=1354;
	creation-date="Thu, 22 Sep 2022 06:24:09 GMT";
	modification-date="Thu, 22 Sep 2022 06:24:09 GMT"
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
d2UgY291bGQgYXBwbHkgQ0wgZm9yIHRoZXNlIDIgcHJvZHVjdHMuCi0tLQogZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jCmluZGV4IDk4ODY0Yjg1M2VlZi4uNjdkMzMzNWU5Y2M4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9wY2kuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwpAQCAtMzQ3MCw2
ICszNDcwLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3Rh
YmxlW10gPSB7CiAJeyBQQ0lfREVWSUNFKDB4MTk4NywgMHg1MDE2KSwJLyogUGhpc29uIEUxNiAq
LwogCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFOIHwKIAkJCQlO
Vk1FX1FVSVJLX0JPR1VTX05JRCwgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxOTg3LCAweDUwMTkpLCAg
LyogcGhpc29uIEUxOSAqLworCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJ
VEVfWkVST0VTLCB9LAorCXsgUENJX0RFVklDRSgweDE5ODcsIDB4NTAyMSksICAgLyogUGhpc29u
IEUyMSAqLworCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VT
LCB9LAogCXsgUENJX0RFVklDRSgweDFiNGIsIDB4MTA5MiksCS8qIExleGFyIDI1NiBHQiBTU0Qg
Ki8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19OT19OU19ERVNDX0xJU1QgfAogCQkJCU5W
TUVfUVVJUktfSUdOT1JFX0RFVl9TVUJOUU4sIH0sCi0tIAoyLjI1LjEKCg==

--_002_1c9807fea3424be486190a99c923a228ExMBX2phisoncom_--

