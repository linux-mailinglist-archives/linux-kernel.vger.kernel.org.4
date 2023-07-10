Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5898674CE49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGJHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:24:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8F12E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:24:01 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QzwTS5zpczqSNc;
        Mon, 10 Jul 2023 15:23:24 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 15:23:57 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2507.027;
 Mon, 10 Jul 2023 15:23:57 +0800
From:   "yiyang (D)" <yiyang13@huawei.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
Subject: RE: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in
 tty_signal_session_leader()
Thread-Topic: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in
 tty_signal_session_leader()
Thread-Index: AQHZrYT1bMsSMMhC5E+1pp+mQpdZtK+yo7Gg
Date:   Mon, 10 Jul 2023 07:23:57 +0000
Message-ID: <cb540eb6c27f4a71803d094505725ae1@huawei.com>
References: <20230703080323.76548-1-yiyang13@huawei.com>
In-Reply-To: <20230703080323.76548-1-yiyang13@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.164]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZyANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHlpeWFuZyAoRCkgDQpT
ZW50OiAyMDIzxOo31MIzyNUgMTY6MDMNClRvOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
amlyaXNsYWJ5QGtlcm5lbC5vcmcNCkNjOiBqYW5uaEBnb29nbGUuY29tOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBGZW5ndGFvIChmZW5ndGFvLCBFdWxlcikgPGZlbmd0YW80MEBodWF3
ZWkuY29tPjsgR3VvemlodWEgKFNjb3R0KSA8Z3VvemlodWFAaHVhd2VpLmNvbT47IHlpeWFuZyAo
RCkgPHlpeWFuZzEzQGh1YXdlaS5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggUkZDXSB0dHk6IHR0eV9q
b2JjdHJsOiBmaXggcGlkIG1lbWxlYWsgaW4gdHR5X3NpZ25hbF9zZXNzaW9uX2xlYWRlcigpDQoN
ClRoZXJlIGlzIGEgbGVha2VkIHBpZCBpbiB0dHkuDQoNCnVucmVmZXJlbmNlZCBvYmplY3QgMHhm
ZmZmODg5MzYyNjE5NDQwIChzaXplIDExMik6DQogIGNvbW0gInN1ZG8iLCBwaWQgMzYwMzM3Niwg
amlmZmllcyA0NDYyNDE1NjQ5IChhZ2UgNzE2MTQuMTcycykNCiAgaGV4IGR1bXAgKGZpcnN0IDMy
IGJ5dGVzKToNCiAgICAwMSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwZiAwMCA0
MCBkYSAgLi4uLi4uLi4uLi4uLi5ALg0KICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uDQogIGJhY2t0cmFjZToNCiAgICBb
PDAwMDAwMDAwZmQxM2VkMDY+XSBhbGxvY19waWQrMHg4NS8weDZiMA0KICAgIFs8MDAwMDAwMDA3
YzQ0OWNmMD5dIGNvcHlfcHJvY2VzcysweGY2MC8weDI4NDANCiAgICBbPDAwMDAwMDAwOGMzYWUx
NDc+XSBrZXJuZWxfY2xvbmUrMHgxMWEvMHg1MTANCiAgICBbPDAwMDAwMDAwNWQ5YjEyNjU+XSBf
X3NlX3N5c19jbG9uZSsweGNkLzB4MTEwDQogICAgWzwwMDAwMDAwMDlkNGQ2NzJlPl0gZG9fc3lz
Y2FsbF82NCsweDMzLzB4NDANCiAgICBbPDAwMDAwMDAwMmZjMGI4Yjk+XSBlbnRyeV9TWVNDQUxM
XzY0X2FmdGVyX2h3ZnJhbWUrMHg2MS8weGM2DQoNClJhY2UgY29uZGl0aW9uIGJldHdlZW4gZGlz
YXNzb2NpYXRlX2N0dHkoKSBhbmQgdHR5X3NpZ25hbF9zZXNzaW9uX2xlYWRlcigpDQp3YXMgZm91
bmQsIHdoaWNoIHdvdWxkIGNhdXNlIGEgbGVha2FnZSBvZiB0dHlfb2xkX3BncnAuIFRoZSByYWNl
IGNvbmRpdGlvbg0KaXMgZGVzY3JpYmVkIGFzIGZvbGxvd3M6DQoNCkNQVTE6CQkJCUNQVTI6DQpk
aXNhc3NvY2lhdGVfY3R0eSgpDQp7DQogICAuLi4NCiAgIHNwaW5fbG9ja19pcnEoJmN1cnJlbnQt
PnNpZ2hhbmQtPnNpZ2xvY2spOw0KICAgcHV0X3BpZChjdXJyZW50LT5zaWduYWwtPnR0eV9vbGRf
cGdycCk7DQogICBjdXJyZW50LT5zaWduYWwtPnR0eV9vbGRfcGdycCA9IE5VTEw7DQogICB0dHkg
PSB0dHlfa3JlZl9nZXQoY3VycmVudC0+c2lnbmFsLT50dHkpOw0KICAgc3Bpbl91bmxvY2tfaXJx
KCZjdXJyZW50LT5zaWdoYW5kLT5zaWdsb2NrKTsNCg0KCQkJdHR5X3NpZ25hbF9zZXNzaW9uX2xl
YWRlcigpDQoJCQl7DQoJCQkgICBzcGluX2xvY2tfaXJxKCZwLT5zaWdoYW5kLT5zaWdsb2NrKTsN
CgkJCSAgIC4uLg0KCQkJICAgc3Bpbl9sb2NrKCZ0dHktPmN0cmxfbG9jayk7DQoJCQkgICB0dHlf
cGdycCA9IGdldF9waWQodHR5LT5wZ3JwKTsNCgkJCSAgIGlmICh0dHktPnBncnApDQoJQW4gZXh0
cmEgZ2V0Pj4gICAgICAgcC0+c2lnbmFsLT50dHlfb2xkX3BncnAgPSBnZXRfcGlkKHR0eS0+cGdy
cCk7DQoJCQkgICBzcGluX3VubG9jaygmdHR5LT5jdHJsX2xvY2spOw0KCQkJICAgc3Bpbl91bmxv
Y2tfaXJxKCZwLT5zaWdoYW5kLT5zaWdsb2NrKTsNCgkJCX0NCg0KICBpZiAodHR5KSB7DQogICAg
dHR5X2xvY2sodHR5KTsNCiAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdHR5LT5jdHJsX2xvY2ssIGZs
YWdzKTsNCiAgICAuLi4NCiAgICB0dHktPnBncnAgPSBOVUxMOw0KICAgIHNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJnR0eS0+Y3RybF9sb2NrLCBmbGFncyk7DQogICAgdHR5X3VubG9jayh0dHkpOw0K
ICAgIHR0eV9rcmVmX3B1dCh0dHkpOw0KICB9DQp9DQoNClRoZSBpc3N1ZSBpcyBiZWxpZXZlZCB0
byBiZSBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBjOGJjZDljNWJlMjQgKCJ0dHk6DQpGaXggLT5zZXNz
aW9uIGxvY2tpbmciKSB3aG8gbW92ZXMgdGhlIHVubG9jayBvZiBzaWdsb2NrIGluDQpkaXNhc3Nv
Y2lhdGVfY3R0eSgpIGFib3ZlICJpZiAodHR5KSIsIG1ha2luZyBhIHNtYWxsIHdpbmRvdyBhbGxv
d2luZw0KdHR5X3NpZ25hbF9zZXNzaW9uX2xlYWRlcigpdG8ga2ljayBpbi4gSXQgY2FuIGJlIGVh
c2lseSByZXByb2R1Y2VkIGJ5DQphZGRpbmcgYSBkZWxheSBiZWZvcmUgImlmICh0dHkpIi4NCg0K
VG8gZml4IHRoaXMgaXNzdWUsIHdlIGNoZWNrIHdoZXRoZXIgdGhlIHNlc3Npb24gbGVhZGVyIGlz
IGV4aXRpbmcgYmVmb3JlDQphc3NpZ25pbmcgYSBuZXcgdHR5X29sZF9wZ3JwLg0KDQpGaXhlczog
YzhiY2Q5YzViZTI0ICgidHR5OiBGaXggLT5zZXNzaW9uIGxvY2tpbmciKQ0KU2lnbmVkLW9mZi1i
eTogWWkgWWFuZyA8eWl5YW5nMTNAaHVhd2VpLmNvbT4NCkNvLWRldmVsb3BlZC1ieTogR1VPIFpp
aHVhIDxndW96aWh1YUBodWF3ZWkuY29tPg0KU2lnbmVkLW9mZi1ieTogR1VPIFppaHVhIDxndW96
aWh1YUBodWF3ZWkuY29tPg0KLS0tDQogZHJpdmVycy90dHkvdHR5X2pvYmN0cmwuYyB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdHR5L3R0eV9qb2JjdHJsLmMgYi9kcml2ZXJzL3R0eS90dHlfam9iY3Ry
bC5jDQppbmRleCAwZDA0Mjg3ZGEwOTguLmY5YTE0NGFhZWRmYyAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvdHR5L3R0eV9qb2JjdHJsLmMNCisrKyBiL2RyaXZlcnMvdHR5L3R0eV9qb2JjdHJsLmMNCkBA
IC0yMjAsNyArMjIwLDcgQEAgaW50IHR0eV9zaWduYWxfc2Vzc2lvbl9sZWFkZXIoc3RydWN0IHR0
eV9zdHJ1Y3QgKnR0eSwgaW50IGV4aXRfc2Vzc2lvbikNCiAJCQlwdXRfcGlkKHAtPnNpZ25hbC0+
dHR5X29sZF9wZ3JwKTsgIC8qIEEgbm9vcCAqLw0KIAkJCXNwaW5fbG9jaygmdHR5LT5jdHJsLmxv
Y2spOw0KIAkJCXR0eV9wZ3JwID0gZ2V0X3BpZCh0dHktPmN0cmwucGdycCk7DQotCQkJaWYgKHR0
eS0+Y3RybC5wZ3JwKQ0KKwkJCWlmICh0dHktPmN0cmwucGdycCAmJiAhKHAtPmZsYWdzICYgUEZf
RVhJVElORykpDQogCQkJCXAtPnNpZ25hbC0+dHR5X29sZF9wZ3JwID0NCiAJCQkJCWdldF9waWQo
dHR5LT5jdHJsLnBncnApOw0KIAkJCXNwaW5fdW5sb2NrKCZ0dHktPmN0cmwubG9jayk7DQotLSAN
CjIuMTcuMQ0KDQo=
