Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9476C5B81BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiINHAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiINHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:00:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0C491FC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:00:04 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSB1w5hJnzlVkl;
        Wed, 14 Sep 2022 14:56:04 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (7.221.188.139) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 14:59:55 +0800
Received: from kwepemi500008.china.huawei.com ([7.221.188.139]) by
 kwepemi500008.china.huawei.com ([7.221.188.139]) with mapi id 15.01.2375.024;
 Wed, 14 Sep 2022 14:59:55 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     "lkundrak@v3.sk" <lkundrak@v3.sk>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     ruanjinjie <ruanjinjie@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBBUk06IG1tcDogTWFrZSBtbXAyX3Jlc291?=
 =?gb2312?Q?rce=5Fgpio_static?=
Thread-Topic: [PATCH -next] ARM: mmp: Make mmp2_resource_gpio static
Thread-Index: AQHYvZygDMXA9V5jW0GdHnKMJzF6Na3ek86g
Date:   Wed, 14 Sep 2022 06:59:55 +0000
Message-ID: <aaf1d593d6874c22a2ae56643756e6a6@huawei.com>
References: <20220901004524.81383-1-ruanjinjie@huawei.com>
In-Reply-To: <20220901004524.81383-1-ruanjinjie@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.109.254]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IHJ1YW5qaW5qaWUgPHJ1YW5qaW5q
aWVAaHVhd2VpLmNvbT4gDQq3osvNyrG85DogMjAyMsTqOdTCMcjVIDg6NDUNCsrVvP7IyzogbGt1
bmRyYWtAdjMuc2s7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQqzrcvNOiBydWFu
amluamllIDxydWFuamluamllQGh1YXdlaS5jb20+DQrW98ziOiBbUEFUQ0ggLW5leHRdIEFSTTog
bW1wOiBNYWtlIG1tcDJfcmVzb3VyY2VfZ3BpbyBzdGF0aWMNCg0KVGhlIHN5bWJvbCBpcyBub3Qg
dXNlZCBvdXRzaWRlIG9mIHRoZSBmaWxlLCBzbyBtYXJrIGl0IHN0YXRpYy4NCg0KRml4ZXMgdGhl
IGZvbGxvd2luZyB3YXJuaW5nOg0KDQouL2FyY2gvYXJtL21hY2gtbW1wL21tcDIuYzoxNTc6MTc6
IHdhcm5pbmc6IHN5bWJvbCAnbW1wMl9yZXNvdXJjZV9ncGlvJyB3YXMgbm90IGRlY2xhcmVkLiBT
aG91bGQgaXQgYmUgc3RhdGljPw0KDQpTaWduZWQtb2ZmLWJ5OiBydWFuamluamllIDxydWFuamlu
amllQGh1YXdlaS5jb20+DQotLS0NCiBhcmNoL2FybS9tYWNoLW1tcC9tbXAyLmMgfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW1tcC9tbXAyLmMgYi9hcmNoL2FybS9tYWNoLW1tcC9tbXAyLmMg
aW5kZXggYmJjNGMyMjc0ZGUzLi42OTZiYzE4NTZlNmQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9t
YWNoLW1tcC9tbXAyLmMNCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL21tcDIuYw0KQEAgLTE1NCw3
ICsxNTQsNyBAQCBNTVAyX0RFVklDRShhc3JhbSwgImFzcmFtIiwgLTEsIE5PTkUsIDB4ZTAwMDAw
MDAsIDB4NDAwMCk7DQogLyogMHhkMTAwMDAwMCB+IDB4ZDEwMWZmZmYgaXMgcmVzZXJ2ZWQgZm9y
IHNlY3VyZSBwcm9jZXNzb3IgKi8gIE1NUDJfREVWSUNFKGlzcmFtLCAiaXNyYW0iLCAtMSwgTk9O
RSwgMHhkMTAyMDAwMCwgMHgxODAwMCk7DQogDQotc3RydWN0IHJlc291cmNlIG1tcDJfcmVzb3Vy
Y2VfZ3Bpb1tdID0gew0KK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgbW1wMl9yZXNvdXJjZV9ncGlv
W10gPSB7DQogCXsNCiAJCS5zdGFydAk9IDB4ZDQwMTkwMDAsDQogCQkuZW5kCT0gMHhkNDAxOWZm
ZiwNCi0tDQoyLjI1LjENCg0K
