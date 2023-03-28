Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD06CB4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1DZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1DZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:25:03 -0400
Received: from t03.bc.larksuite.com (t03.bc.larksuite.com [209.127.231.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601E10CF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1679973888;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=0ZsZ4rpcQtccHo+nCntHpjTAj1f20IXn/GZUCcCVFoM=;
 b=TTkZvRp7zBVCMhSTUavv+lCD181DhpEH1q7y8ik13lFeG3okfVpplmUfw/CBIKUYxE3BYG
 MSHW0o94LkwWExmbKGDo2XZVnFZEUPlOqyzPejZQa7S3/NhuX4f2ITtp5fbmFR5+kJmjQw
 /A9PFR2uu7CzK2ytNo++XjkIVRHc/cq6CDXoAvpFdmYD0uuxK9ejhGSgj5b2M/EFh4FOtN
 da2HrvOvBeqHMwCv1SfIWIxyMgLqpYlueHXHlZPtlgptVPbyiGyzYBnWCMSJ6jr4Nn0MZe
 ENRorH3fmfxtToMmm7OIc3pqmCZxGM6u3f78rpWY9Eh5OVa+IJzaHuFqf5WAkg==
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Lms-Return-Path: <lba+264225dff+0cf98b+vger.kernel.org+zangchunxin@lixiang.com>
To:     "Namhyung Kim" <namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <C84E377A-CBC1-49A7-A8EC-09F2503433D2@lixiang.com>
References: <20230317063246.1128219-1-zangchunxin@lixiang.com> <CAM9d7chc+eJvPMm3ZhcxcbYUjNzVvBG7N0DvVwMzmOOb+-xiMQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf sched: Fix sched latency analysis incorrect
Date:   Tue, 28 Mar 2023 11:24:48 +0800
In-Reply-To: <CAM9d7chc+eJvPMm3ZhcxcbYUjNzVvBG7N0DvVwMzmOOb+-xiMQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary=649a99a623d56ad6933784b4a889eceaa58638550dcfe8361313871d3bcf
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerry Zhou" <zhouchunhua@lixiang.com>
From:   "Chunxin Zang" <zangchunxin@lixiang.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--649a99a623d56ad6933784b4a889eceaa58638550dcfe8361313871d3bcf
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8

PiBPbiBNYXIgMjgsIDIwMjMsIGF0IDAzOjAwLCBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMTE6MzPigK9QTSBD
aHVueGluIFphbmcgPHphbmdjaHVueGluQGxpeGlhbmcuY29tPiB3cm90ZToNCj4+IA0KPj4gJ3Bl
cmYgc2NoZWQgbGF0ZW5jeScgaXMgaW5jb3JyZWN0IHRvIGdldCBwcm9jZXNzIHNjaGVkdWxlIGxh
dGVuY3kNCj4+IHdoZW4gaXQgdXNlZCAnc2NoZWQ6c2NoZWRfd2FrZXVwJyB0byBhbmFseXNpcyBw
ZXJmLmRhdGEuDQo+PiANCj4+IEJlY2F1c2UgJ3BlcmYgcmVjb3JkJyBwcmVmZXIgdXNlICdzY2hl
ZDpzY2hlZF93YWtpbmcnIHRvDQo+PiAnc2NoZWQ6c2NoZWRfd2FrZXVwJyBzaW5jZSBjb21taXQg
ZDU2NmE5YzJkNDgyICgicGVyZiBzY2hlZDogUHJlZmVyDQo+PiBzY2hlZF93YWtpbmcgZXZlbnQg
d2hlbiBpdCBleGlzdHMiKS4gSXQncyB2ZXJ5IHJlYXNvbmFibGUgdG8NCj4+IGV2YWx1YXRlIHBy
b2Nlc3Mgc2NoZWR1bGUgbGF0ZW5jeS4NCj4+IA0KPj4gU2ltaWxhcmx5LCB1cGRhdGUgc2NoZWQg
bGF0ZW5jeS9tYXAvcmVwbGF5IHRvIHVzZSBzY2hlZF93YWtpbmcgZXZlbnRzLg0KPiANCj4gSGF2
ZSB5b3UgY2hlY2tlZCBwZXJmIHNjaGVkIHJlcGxheSAoYWRkX3NjaGVkX2V2ZW50X3dha2V1cCk/
ICBJIHRoaW5rDQo+IGl0J2QgbWFrZSB1bm5lY2Vzc2FyeSBzY2hlZCBhdG9tcyBmb3Igc2NoZWRf
d2FrZXVwLg0KPiANCj4gQ2FuIHdlIGNoZWNrIHRoZSB3YWtldXAgYW5kIHdha2luZyBldmVudHMg
YW5kIGRpc2FibGUgdGhlIHdha2V1cA0KPiBpZiB0aGUgd2FraW5nIGlzIGZvdW5kIGxpa2UgaW4g
cGVyZl9zY2hlZF9fdGltZWhpc3Q/DQoNClRoYXQncyBhIGdvb2QgaWRlYSwgSSB3aWxsIGRvIHRo
YXQgaW4gdjQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzDQpDaHVueGluDQoNCj4gDQo+IFRoYW5r
cywNCj4gTmFtaHl1bmcNCj4gDQo+IA0KPj4gDQo+PiBJIHVzZWQgJ3BlcmYgcmVjb3JkIC1lICJz
Y2hlZDoqICInIHRvIHJlY29yZCBib3RoIHdha2V1cCBhbmQgd2FraW5nIGV2ZW50cywNCj4+IGFu
ZCB1c2UgZml4ZWQgcGVyZiB2ZXJzaW9uIHRvIGFuYWx5c2lzIHRoZW0sIHRoZSByZXN1bHQgaXMg
Y29ycmVjdC4NCj4+IEJlY2F1c2UgdGhlIGZ1bmN0aW9uICJsYXRlbmN5X3dha2V1cF9ldmVudCIg
d2lsbCBjaGFuZ2UgYXRvbS0+c3RhdGUgdG8NCj4+IFRIUkVBRF9XQUlUX0NQVSBhdCB3YWtpbmcg
ZXZlbnQsIGFuZCBqdWRnZSB0aGUgJ2F0b20tPnN0YXRlICE9DQo+PiBUSFJFQURfU0xFRVBJTkcn
IGlzIGZhbHNlIHRoZW4gcmV0dXJuZWQgYXQgd2FrZXVwIGV2ZW50Lg0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBDaHVueGluIFphbmcgPHphbmdjaHVueGluQGxpeGlhbmcuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogSmVycnkgWmhvdSA8emhvdWNodW5odWFAbGl4aWFuZy5jb20+DQo+PiAtLS0NCj4+
IA0KPj4gICAgICAgIGNoYW5nZWxvZ3MgaW4gdjM6DQo+PiAgICAgICAgMSkgZml4IG5vbi1BU0NJ
SSBjaGFyYWN0ZXJzIGluIGNvbW1pdCBsb2cuDQo+PiANCj4+ICAgICAgICBjaGFuZ2Vsb2dzIGlu
IHYyOg0KPj4gICAgICAgIDEpIGZpeCBlbWFpbCBhZGRyZXNzIGRpc2FwcGVhcmluZyBpbiAnc2ln
bmVkIG9mZiBieScNCj4+IA0KPj4gdG9vbHMvcGVyZi9idWlsdGluLXNjaGVkLmMgfCAxICsNCj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvdG9v
bHMvcGVyZi9idWlsdGluLXNjaGVkLmMgYi90b29scy9wZXJmL2J1aWx0aW4tc2NoZWQuYw0KPj4g
aW5kZXggODZlMTg1NzVjOWJlLi4xYWY0ZWMxYWM4MjQgMTAwNjQ0DQo+PiAtLS0gYS90b29scy9w
ZXJmL2J1aWx0aW4tc2NoZWQuYw0KPj4gKysrIGIvdG9vbHMvcGVyZi9idWlsdGluLXNjaGVkLmMN
Cj4+IEBAIC0xODE5LDYgKzE4MTksNyBAQCBzdGF0aWMgaW50IHBlcmZfc2NoZWRfX3JlYWRfZXZl
bnRzKHN0cnVjdCBwZXJmX3NjaGVkICpzY2hlZCkNCj4+ICAgICAgICBjb25zdCBzdHJ1Y3QgZXZz
ZWxfc3RyX2hhbmRsZXIgaGFuZGxlcnNbXSA9IHsNCj4+ICAgICAgICAgICAgICAgIHsgInNjaGVk
OnNjaGVkX3N3aXRjaCIsICAgICAgIHByb2Nlc3Nfc2NoZWRfc3dpdGNoX2V2ZW50LCB9LA0KPj4g
ICAgICAgICAgICAgICAgeyAic2NoZWQ6c2NoZWRfc3RhdF9ydW50aW1lIiwgcHJvY2Vzc19zY2hl
ZF9ydW50aW1lX2V2ZW50LCB9LA0KPj4gKyAgICAgICAgICAgICAgIHsgInNjaGVkOnNjaGVkX3dh
a2luZyIsICAgICAgIHByb2Nlc3Nfc2NoZWRfd2FrZXVwX2V2ZW50LCB9LA0KPj4gICAgICAgICAg
ICAgICAgeyAic2NoZWQ6c2NoZWRfd2FrZXVwIiwgICAgICAgcHJvY2Vzc19zY2hlZF93YWtldXBf
ZXZlbnQsIH0sDQo+PiAgICAgICAgICAgICAgICB7ICJzY2hlZDpzY2hlZF93YWtldXBfbmV3Iiwg
ICBwcm9jZXNzX3NjaGVkX3dha2V1cF9ldmVudCwgfSwNCj4+ICAgICAgICAgICAgICAgIHsgInNj
aGVkOnNjaGVkX21pZ3JhdGVfdGFzayIsIHByb2Nlc3Nfc2NoZWRfbWlncmF0ZV90YXNrX2V2ZW50
LCB9LA0KPj4gLS0NCj4+IDIuMjUuMQ0KPj4gDQo+PiDlo7DmmI7vvJrov5nlsIHpgq7ku7blj6rl
hYHorrjmlofku7bmjqXmlLbogIXpmIXor7vvvIzmnInlvojpq5jnmoTmnLrlr4bmgKfopoHmsYLj
gILnpoHmraLlhbbku5bkurrkvb/nlKjjgIHmiZPlvIDjgIHlpI3liLbmiJbovazlj5Hph4zpnaLn
moTku7vkvZXlhoXlrrnjgILlpoLmnpzmnKzpgq7ku7bplJnor6/lnLDlj5Hnu5nkuobkvaDvvIzo
r7fogZTns7vpgq7ku7blj5Hlh7rogIXlubbliKDpmaTov5nkuKrmlofku7bjgILmnLrlr4blj4rm
s5XlvovnmoTnibnmnYPlubbkuI3lm6DkuLror6/lj5Hpgq7ku7bogIzmlL7lvIPmiJbkuKflpLHj
gILku7vkvZXmj5Dlh7rnmoTop4LngrnmiJbmhI/op4Hlj6rlsZ7kuo7kvZzogIXnmoTkuKrkurro
p4Hop6PvvIzlubbkuI3kuIDlrprku6PooajmnKzlhazlj7jjgIINCgrlo7DmmI7vvJrov5nlsIHp
gq7ku7blj6rlhYHorrjmlofku7bmjqXmlLbogIXpmIXor7vvvIzmnInlvojpq5jnmoTmnLrlr4bm
gKfopoHmsYLjgILnpoHmraLlhbbku5bkurrkvb/nlKjjgIHmiZPlvIDjgIHlpI3liLbmiJbovazl
j5Hph4zpnaLnmoTku7vkvZXlhoXlrrnjgILlpoLmnpzmnKzpgq7ku7bplJnor6/lnLDlj5Hnu5nk
uobkvaDvvIzor7fogZTns7vpgq7ku7blj5Hlh7rogIXlubbliKDpmaTov5nkuKrmlofku7bjgILm
nLrlr4blj4rms5XlvovnmoTnibnmnYPlubbkuI3lm6DkuLror6/lj5Hpgq7ku7bogIzmlL7lvIPm
iJbkuKflpLHjgILku7vkvZXmj5Dlh7rnmoTop4LngrnmiJbmhI/op4Hlj6rlsZ7kuo7kvZzogIXn
moTkuKrkurrop4Hop6PvvIzlubbkuI3kuIDlrprku6PooajmnKzlhazlj7jjgII=

--649a99a623d56ad6933784b4a889eceaa58638550dcfe8361313871d3bcf--
