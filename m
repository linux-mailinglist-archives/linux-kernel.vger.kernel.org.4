Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3886469040F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBIJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:45:24 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D270547402
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:45:19 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4583FB004A417;
        Thu,  9 Feb 2023 17:45:16 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY01-ACTMBX-02.didichuxing.com (10.79.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 17:45:15 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::9d2c:14fe:d2f1:2a37])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::9d2c:14fe:d2f1:2a37%4]) with mapi
 id 15.01.2375.034; Thu, 9 Feb 2023 17:45:15 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.64.12
From:   =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To:     "pmladek@suse.com" <pmladek@suse.com>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>
CC:     "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>,
        "zwp10758@gmail.com" <zwp10758@gmail.com>,
        "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH v2 2/2] sched: print parent comm in sched_show_task()
Thread-Topic: [PATCH v2 2/2] sched: print parent comm in sched_show_task()
Thread-Index: AQHZNUt+nHl/SPF+iku9su+1GqO3Y67Ga9WA
Date:   Thu, 9 Feb 2023 09:45:15 +0000
Message-ID: <183C235F-2FD9-4BAB-B652-1242BE7F9DF4@didiglobal.com>
In-Reply-To: <20230131080911.GA1601@didi-ThinkCentre-M930t-N000>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <879E760540914349B89A6D4B921D7CBC@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbiBhbmQgc2NoZWQgbWFpbnRhaW5lcnMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3ZWxs
IQ0KUGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgdmVyc2lvbiBhbmQgbGV0IG1lIGtub3cgaWYgdGhl
cmUgYXJlIGFueSBmb2xsb3dpbmcgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcywgIA0KDQrvu7/lnKgg
MjAyMy8xLzMxIOS4i+WNiDQ6MTDvvIzigJzlvKDlhYPngJogVGlvIFpoYW5n4oCdPHRpb3poYW5n
QGRpZGlnbG9iYWwuY29tIDxtYWlsdG86dGlvemhhbmdAZGlkaWdsb2JhbC5jb20+PiDlhpnlhaU6
DQoNCg0KS25vd2luZyB3aG8gdGhlIHBhcmVudCBpcyBtaWdodCBiZSB1c2VmdWwgZm9yIGRlYnVn
Z2luZy4NCkZvciBleGFtcGxlLCB3ZSBjYW4gc29tZXRpbWVzIHJlc29sdmUga2VybmVsIGh1bmcg
dGFza3MgYnkgc3RvcHBpbmcNCnRoZSBwZXJzb24gd2hvIGJlZ2lucyB0aG9zZSBodW5nIHRhc2tz
Lg0KV2l0aCB0aGUgcGFyZW50J3MgbmFtZSBwcmludGVkIGluIHNjaGVkX3Nob3dfdGFzaygpLA0K
aXQgbWlnaHQgYmUgaGVscGZ1bCB0byBsZXQgcGVvcGxlIGtub3cgd2hpY2ggInNlcnZpY2UiIHNo
b3VsZCBiZSBvcGVyYXRlZC4NCkFsc28sIHdlIG1vdmUgdGhlIHBhcmVudCBpbmZvIHRvIGEgZm9s
bG93aW5nIG5ldyBsaW5lLg0KSXQgd291bGQgYmV0dGVyIHNvbHZlIHRoZSBzaXR1YXRpb24gd2hl
biB0aGUgdGFzaw0KaXMgbm90IGFsaXZlIGFuZCB3ZSBjb3VsZCBub3QgZ2V0IGluZm9ybWF0aW9u
IGFib3V0IHRoZSBwYXJlbnQuDQoNCg0KU2lnbmVkLW9mZi1ieTogVGlvIFpoYW5nIDx0aW96aGFu
Z0BkaWRpZ2xvYmFsLmNvbSA8bWFpbHRvOnRpb3poYW5nQGRpZGlnbG9iYWwuY29tPj4NCi0tLQ0K
a2VybmVsL3NjaGVkL2NvcmUuYyB8IDE4ICsrKysrKysrKysrLS0tLS0tLQ0KMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCg0KZGlmZiAtLWdpdCBhL2tl
cm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQppbmRleCBjYjJhYTJiNTRj
N2EuLmQ4ZmQzNTY4NGQ2YyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCisrKyBi
L2tlcm5lbC9zY2hlZC9jb3JlLmMNCkBAIC04ODUzLDcgKzg4NTMsNiBAQCBTWVNDQUxMX0RFRklO
RTIoc2NoZWRfcnJfZ2V0X2ludGVydmFsX3RpbWUzMiwgcGlkX3QsIHBpZCwNCnZvaWQgc2NoZWRf
c2hvd190YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCnsNCnVuc2lnbmVkIGxvbmcgZnJlZSA9
IDA7DQotIGludCBwcGlkOw0KDQoNCmlmICghdHJ5X2dldF90YXNrX3N0YWNrKHApKQ0KcmV0dXJu
Ow0KQEAgLTg4NjUsMTQgKzg4NjQsMTkgQEAgdm9pZCBzY2hlZF9zaG93X3Rhc2soc3RydWN0IHRh
c2tfc3RydWN0ICpwKQ0KI2lmZGVmIENPTkZJR19ERUJVR19TVEFDS19VU0FHRQ0KZnJlZSA9IHN0
YWNrX25vdF91c2VkKHApOw0KI2VuZGlmDQotIHBwaWQgPSAwOw0KKw0KKyBwcl9jb250KCIgc3Rh
Y2s6JS01bHUgcGlkOiUtNWQgZmxhZ3M6MHglMDhseFxuIiwNCisgZnJlZSwgdGFza19waWRfbnIo
cCksIHJlYWRfdGFza190aHJlYWRfZmxhZ3MocCkpOw0KKw0KcmN1X3JlYWRfbG9jaygpOw0KLSBp
ZiAocGlkX2FsaXZlKHApKQ0KLSBwcGlkID0gdGFza19waWRfbnIocmN1X2RlcmVmZXJlbmNlKHAt
PnJlYWxfcGFyZW50KSk7DQorIGlmIChwaWRfYWxpdmUocCkpIHsNCisgc3RydWN0IHRhc2tfc3Ry
dWN0ICpwYXJlbnQgPSByY3VfZGVyZWZlcmVuY2UocC0+cmVhbF9wYXJlbnQpOw0KKw0KKyBwcl9p
bmZvKCJwYXJlbnQ6JS0xNS4xNXMgcHBpZDolLTZkIiwgcGFyZW50LT5jb21tLCB0YXNrX3BpZF9u
cihwYXJlbnQpKTsNCisgfSBlbHNlIHsNCisgcHJfaW5mbygicGFyZW50OnVua25vd24gcHBpZDo8
TlVMTD5cbiIpOw0KKyB9DQpyY3VfcmVhZF91bmxvY2soKTsNCi0gcHJfY29udCgiIHN0YWNrOiUt
NWx1IHBpZDolLTVkIHBwaWQ6JS02ZCBmbGFnczoweCUwOGx4XG4iLA0KLSBmcmVlLCB0YXNrX3Bp
ZF9ucihwKSwgcHBpZCwNCi0gcmVhZF90YXNrX3RocmVhZF9mbGFncyhwKSk7DQoNCg0KcHJpbnRf
d29ya2VyX2luZm8oS0VSTl9JTkZPLCBwKTsNCnByaW50X3N0b3BfaW5mbyhLRVJOX0lORk8sIHAp
Ow0KLS0gDQoyLjE3LjENCg0KDQoNCg0KDQo=
