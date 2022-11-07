Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717F061EDE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKGI41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiKGI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:56:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC85165AC;
        Mon,  7 Nov 2022 00:56:08 -0800 (PST)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5Q7N5kXkzRp6C;
        Mon,  7 Nov 2022 16:56:00 +0800 (CST)
Received: from kwepemi500002.china.huawei.com (7.221.188.171) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:56:06 +0800
Received: from kwepemi500002.china.huawei.com ([7.221.188.171]) by
 kwepemi500002.china.huawei.com ([7.221.188.171]) with mapi id 15.01.2375.031;
 Mon, 7 Nov 2022 16:56:06 +0800
From:   Jiantao Zhang <water.zhangjiantao@huawei.com>
To:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jakobkoschel@gmail.com" <jakobkoschel@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Subject: [PATCH] USB: gadget: Fix CFI failure during usb config switch.
Thread-Topic: [PATCH] USB: gadget: Fix CFI failure during usb config switch.
Thread-Index: AdjyhqKcM1K7gDGYQF24dNHpxaSVqg==
Date:   Mon, 7 Nov 2022 08:56:06 +0000
Message-ID: <b4d5fcb42622441189ad0e6ca5b170c0@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.108.160]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCAwYTU1MTg3YTFlYzhjDQoNCkluIHRoZSBwcm9jZXNzIG9mIHN3
aXRjaGluZyBVU0IgY29uZmlnIGZyb20gcm5kaXMgdG8gb3RoZXIgY29uZmlnLCBpZiBmdW5jdGlv
biBnYWRnZXQtPm9wcy0+cHVsbHVwKCkgcmV0dXJuIGFuIGVycm9yLGl0IHdpbGwgaW5ldml0YWJs
eSBjYXVzZSBhIENGSSBmYWlsdXJlKExpbnV4IHZlcnNpb24gNS4xMC40MykuDQoNCmFuYWx5c2lz
IGFzIGZvbGxvd3M6DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCigxKSB3cml0ZSAvY29uZmlnL3VzYl9nYWRnZXQvZzEvVURDICJub25lIiAg
IChpbml0LnVzYi5jb25maWdmcy5yYzoyKQ0KDQpnZXRoZXJfZGlzY29ubmVjdCsweDJjLzB4MWY4
ICAgICAoZGV2LT5wb3J0X3VzYiA9IE5VTEwpDQpybmRpc19kaXNhYmxlKzB4NGMvMHg3NA0KY29t
cG9zaXRlX2Rpc2Nvbm5lY3QrMHg3NC8weGIwDQpjb25maWdmc19jb21wb3NpdGVfZGlzY29ubmVj
dCsweDYwLzB4N2MNCnVzYl9nYWRnZXRfZGlzY29ubmVjdCsweDcwLzB4MTI0DQp1c2JfZ2FkZ2V0
X3VucmVnaXN0ZXJfZHJpdmVyKzB4YzgvMHgxZDgNCmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUr
MHhlYy8weDFlNA0KDQppbiBmdW5jdGlvbiB1c2JfZ2FkZ2V0X2Rpc2Nvbm5lY3QoKSxnYWRnZXQt
PnVkYy0+ZHJpdmVyLT5kaXNjb25uZWN0KCkNCndpbGwgbm90IGJlIGNhbGxlZCB3aGVuIGdhZGdl
dC0+b3BzLT5wdWxsdXAoKSByZXR1cm4gYW4gZXJyb3IsIHRoZXJlZm9yZSwgcG9pbnRlciBkZXYt
PnBvcnQgd2lsbCBub3QgYmUgc2V0IHRvIE5VTEwuDQoNCigyKSBybSAvY29uZmlnL3VzYl9nYWRn
ZXQvZzEvY29uZmlncy9iLjEvZjEgICAgKGluaXQudXNiLmNvbmZpZ2ZzLnJjOjgpDQogICAgKGYx
IC0+IC4uLy4uLy4uLy4uL3VzYl9nYWRnZXQvZzEvZnVuY3Rpb25zL3JuZGlzLmdzNCkNCg0Kcm5k
aXNfZGVyZWdpc3RlcisweDI4LzB4NTQNCnJuZGlzX2ZyZWUrMHg0NC8weDdjDQp1c2JfcHV0X2Z1
bmN0aW9uKzB4MTQvMHgxYw0KY29uZmlnX3VzYl9jZmdfdW5saW5rKzB4YzQvMHhlMA0KY29uZmln
ZnNfdW5saW5rKzB4MTI0LzB4MWM4DQp2ZnNfdW5saW5rKzB4MTE0LzB4MWRjDQoNCigzKSBybWRp
ciAvY29uZmlnL3VzYl9nYWRnZXQvZzEvZnVuY3Rpb25zL3JuZGlzLmdzNA0KICAgIChpbml0LnVz
Yi5jb25maWdmcy5yYzoxMSkNCg0KQ0ZJIGZhaWx1cmUgKHRhcmdldDogWzxmZmZmZmY4MTRiYzIw
YzAwPl0gMDAwMDAwMDA2OGY1MDA3OCk6DQpDUFU6IDIgUElEOiAxIENvbW06IGluaXQgVklQOiAw
MCBUYWludGVkOiBHICAgVyAgTyAgIDUuMTAuNDMgIzENCkNhbGwgdHJhY2U6DQogX19jZmlfc2xv
d3BhdGgrMHgzMDAvMHgzYmMNCiBybmRpc19zaWduYWxfZGlzY29ubmVjdCsweDFlMC8weDIwNA0K
IHJuZGlzX2Nsb3NlKzB4MjQvMHgyYw0KIGV0aF9zdG9wKzB4ZDAvMHgyMzQgICAgICAgICAgIChp
ZiBkZXYtPnBvcnRfdXNiICE9IE5VTEwsIGNhbGwgcm5kaXNfY2xvc2UpDQogX19kZXZfY2xvc2Vf
bWFueSsweDIwNC8weDJkNA0KIGRldl9jbG9zZV9tYW55KzB4NDgvMHgyYzgNCiByb2xsYmFja19y
ZWdpc3RlcmVkX21hbnkrMHgxODQvMHhkYWMNCiB1bnJlZ2lzdGVyX25ldGRldmljZV9xdWV1ZSsw
eGY4LzB4MjRjDQogcm5kaXNfZnJlZV9pbnN0KzB4NzgvMHhjOA0KIHJuZGlzX2F0dHJfcmVsZWFz
ZSsweDNjLzB4ODQNCiBjb25maWdfaXRlbV9yZWxlYXNlKzB4NmMvMHgxODANCiBjb25maWdmc19y
bWRpcisweDdlMC8weGNhMA0KDQpTaW5jZSB0aGUgcm5kaXMgbWVtb3J5IGhhcyBiZWVuIGZyZWVk
IGluIHN0ZXAyLCBmdW5jdGlvbiBybmRpc19jbG9zZSBjYW5ub3QgYmUgY2FsbGVkIGhlcmUuIElu
IGZ1bmN0aW9uIGV0aF9zdG9wKCksIGlmIHBvaW50ZXIgZGV2LT5wb3J0X3VzYiBpcyBOVUxMLCBm
dW5jdGlvbiBybmRpc19jbG9zZSgpIHdpbGwgbm90IGJlIGNhbGxlZC4gU28sIGlmDQpnYWRnZXQt
Pm9wcy0+cHVsbHVwKCkgcmV0dXJuIGFuIGVycm9yIGluIHN0ZXAxLCBhIENGSSBmYWlsdXJlIHdp
bGwgYmUNCmNhdXNlZCBoZXJlLg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpUaHJvdWdoIGFib3ZlIGFuYWx5c2lzLCBpIHRoaW5rIGdhZGdl
dC0+dWRjLT5kcml2ZXItPmRpc2Nvbm5lY3QoKSBuZWVkIHRvIGJlIGNhbGxlZCBldmVuIGlmIGdh
ZGdldC0+dWRjLT5kcml2ZXItPmRpc2Nvbm5lY3QoKSByZXR1cm4gYW4gZXJyb3IuDQoNClNpZ25l
ZC1vZmYtYnk6IEppYW50YW8gWmhhbmcgPHdhdGVyLnpoYW5namlhbnRhb0BodWF3ZWkuY29tPg0K
U2lnbmVkLW9mZi1ieTogVGFvWHVlIDx4dWV0YW8wOUBodWF3ZWkuY29tPg0KLS0tDQogZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2NvcmUuYyBpbmRleCBjNjNjMGMyY2Y2NDkuLmI1MDJiMmFjNDgyNCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2NvcmUuYw0KQEAgLTcwNyw5ICs3MDcsNiBAQCBFWFBPUlRfU1lNQk9MX0dQTCh1c2JfZ2FkZ2V0
X2Nvbm5lY3QpOw0KICAqIGFzIGEgZGlzY29ubmVjdCAod2hlbiBhIFZCVVMgc2Vzc2lvbiBpcyBh
Y3RpdmUpLiAgTm90IGFsbCBzeXN0ZW1zDQogICogc3VwcG9ydCBzb2Z0d2FyZSBwdWxsdXAgY29u
dHJvbHMuDQogICoNCi0gKiBGb2xsb3dpbmcgYSBzdWNjZXNzZnVsIGRpc2Nvbm5lY3QsIGludm9r
ZSB0aGUgLT5kaXNjb25uZWN0KCkgY2FsbGJhY2sNCi0gKiBmb3IgdGhlIGN1cnJlbnQgZ2FkZ2V0
IGRyaXZlciBzbyB0aGF0IFVEQyBkcml2ZXJzIGRvbid0IG5lZWQgdG8uDQotICoNCiAgKiBSZXR1
cm5zIHplcm8gb24gc3VjY2VzcywgZWxzZSBuZWdhdGl2ZSBlcnJuby4NCiAgKi8NCiBpbnQgdXNi
X2dhZGdldF9kaXNjb25uZWN0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpIEBAIC03MzQsMTMg
KzczMSw4IEBAIGludCB1c2JfZ2FkZ2V0X2Rpc2Nvbm5lY3Qoc3RydWN0IHVzYl9nYWRnZXQgKmdh
ZGdldCkNCiAJfQ0KIA0KIAlyZXQgPSBnYWRnZXQtPm9wcy0+cHVsbHVwKGdhZGdldCwgMCk7DQot
CWlmICghcmV0KSB7DQorCWlmICghcmV0KQ0KIAkJZ2FkZ2V0LT5jb25uZWN0ZWQgPSAwOw0KLQkJ
bXV0ZXhfbG9jaygmdWRjX2xvY2spOw0KLQkJaWYgKGdhZGdldC0+dWRjLT5kcml2ZXIpDQotCQkJ
Z2FkZ2V0LT51ZGMtPmRyaXZlci0+ZGlzY29ubmVjdChnYWRnZXQpOw0KLQkJbXV0ZXhfdW5sb2Nr
KCZ1ZGNfbG9jayk7DQotCX0NCiANCiBvdXQ6DQogCXRyYWNlX3VzYl9nYWRnZXRfZGlzY29ubmVj
dChnYWRnZXQsIHJldCk7IEBAIC0xNTMyLDYgKzE1MjQsMTEgQEAgc3RhdGljIHZvaWQgZ2FkZ2V0
X3VuYmluZF9kcml2ZXIoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlrb2JqZWN0X3VldmVudCgmdWRj
LT5kZXYua29iaiwgS09CSl9DSEFOR0UpOw0KIA0KIAl1c2JfZ2FkZ2V0X2Rpc2Nvbm5lY3QoZ2Fk
Z2V0KTsNCisNCisJbXV0ZXhfbG9jaygmdWRjX2xvY2spOw0KKwl1ZGMtPmRyaXZlci0+ZGlzY29u
bmVjdCh1ZGMtPmdhZGdldCk7DQorCW11dGV4X3VubG9jaygmdWRjX2xvY2spOw0KKw0KIAl1c2Jf
Z2FkZ2V0X2Rpc2FibGVfYXN5bmNfY2FsbGJhY2tzKHVkYyk7DQogCWlmIChnYWRnZXQtPmlycSkN
CiAJCXN5bmNocm9uaXplX2lycShnYWRnZXQtPmlycSk7DQpAQCAtMTYyNiw2ICsxNjIzLDExIEBA
IHN0YXRpYyBzc2l6ZV90IHNvZnRfY29ubmVjdF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQog
CQl1c2JfZ2FkZ2V0X2Nvbm5lY3QodWRjLT5nYWRnZXQpOw0KIAl9IGVsc2UgaWYgKHN5c2ZzX3N0
cmVxKGJ1ZiwgImRpc2Nvbm5lY3QiKSkgew0KIAkJdXNiX2dhZGdldF9kaXNjb25uZWN0KHVkYy0+
Z2FkZ2V0KTsNCisNCisJCW11dGV4X2xvY2soJnVkY19sb2NrKTsNCisJCXVkYy0+ZHJpdmVyLT5k
aXNjb25uZWN0KHVkYy0+Z2FkZ2V0KTsNCisJCW11dGV4X3VubG9jaygmdWRjX2xvY2spOw0KKw0K
IAkJdXNiX2dhZGdldF91ZGNfc3RvcCh1ZGMpOw0KIAl9IGVsc2Ugew0KIAkJZGV2X2VycihkZXYs
ICJ1bnN1cHBvcnRlZCBjb21tYW5kICclcydcbiIsIGJ1Zik7DQotLQ0KMi4xNy4xDQoNCg==
