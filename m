Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA715F0675
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiI3Ib1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiI3IbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:31:24 -0400
X-Greylist: delayed 6574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 01:31:22 PDT
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587A3AE7C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:31:20 -0700 (PDT)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: XBN7tc9DADJZtfgXgzM6X3EcWXkpC/cUdMkRjRuxHzKcproOfbYKYVN52FHnu
        0Re+YAbms3WbuWgVh2wa3844BofyiaUX/s4imI5ZUGPsTsfbvuAhRAZDLBw39BIMYJuEB+n
        6RNHMMRtZqhn7tZXapAd8Em00WVE9rX7Q7rcy9ZV/aNrzcSS3qSRdA00nlLiG3uxG/npcgd
        KI6wItpvm14iRE+8UhJ8WxPzJ24B6z88rq1bpxAW3XftGi6aGMTY/M99NHK/vL0LZd6okSk
        vcpzgJxKI7pNKq8Ch8ZV6wHD/DGYWf3dp2D0JzrBPDaskVyPFs/Wp733LcYVw27xdM1GXZw
        zFgeHHo3r2GLGS4mDoRYO2FD9yeCU8EhR0Z2KIcBYbcSrUiSgv5HV/+E4hPjHuT4X/aMzzr
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic637t1664526665t2718694
From:   "=?utf-8?B?5byg6ZGr5Z+O?=" <zhangxincheng@uniontech.com>
To:     "=?utf-8?B?aGRlZ29lZGU=?=" <hdegoede@redhat.com>,
        "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?bWF6?=" <maz@kernel.org>,
        "=?utf-8?B?b2xla3NhbmRy?=" <oleksandr@natalenko.name>,
        "=?utf-8?B?YmlnZWFzeQ==?=" <bigeasy@linutronix.de>,
        "=?utf-8?B?bWFyay5ydXRsYW5k?=" <mark.rutland@arm.com>,
        "=?utf-8?B?bWljaGFlbA==?=" <michael@walle.cc>
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 30 Sep 2022 16:31:05 +0800
X-Priority: 3
Message-ID: <tencent_2F94F13B31CBCD8A6A5942E7@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 30 Sep 2022 16:31:06 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgdmFsdWFibGUgc3VnZ2VzdGlv
bnMsIEkgaGF2ZSBtb2RpZmllZCB0aGUgcGF0Y2ggYXMgZm9sbG93czoNCg0KU3ViamVjdDog
W1BBVENIXSBpbnRlcnJ1cHQ6IGRpc2NvdmVyIGFuZCBkaXNhYmxlIHZlcnkgZnJlcXVlbnQg
aW50ZXJydXB0cw0KDQpJbiBzb21lIGNhc2VzLCBhIHBlcmlwaGVyYWwncyBpbnRlcnJ1cHQg
d2lsbCBiZSB0cmlnZ2VyZWQgZnJlcXVlbnRseSwNCndoaWNoIHdpbGwga2VlcCB0aGUgQ1BV
IHByb2Nlc3NpbmcgdGhlIGludGVycnVwdCBhbmQgZXZlbnR1YWxseSBjYXVzZQ0KdGhlIFJD
VSB0byByZXBvcnQgcmN1X3NjaGVkIHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gdGhlIENQVS4N
Cg0KWyAgODM4LjEzMTYyOF0gcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBz
dGFsbCBvbiBDUFUNClsgIDgzOC4xMzcxODldIHJjdTogICAgIDAtLi4uLjogKDE5NDgzOSB0
aWNrcyB0aGlzIEdQKSBpZGxlPWYwMi8xLzB4NDAwMDAwMDAwMDAwMDAwNA0Kc29mdGlycT05
OTkzLzk5OTMgZnFzPTk3NDI4DQpbICA4MzguMTQ2OTEyXSByY3U6ICAgICAgKHQ9MTk1MDE1
IGppZmZpZXMgZz02NzczIHE9MCkNClsgIDgzOC4xNTE1MTZdIFRhc2sgZHVtcCBmb3IgQ1BV
IDA6DQpbICA4MzguMTU0NzMwXSBzeXN0ZW1kLXNsZWVwICAgUiAgcnVubmluZyB0YXNrICAg
ICAgICAwICAzNDQ1ICAgICAgMSAweDAwMDAwMDBhDQoNClNpZ25lZC1vZmYtYnk6IHpoYW5n
eGluY2hlbmcgPHpoYW5neGluY2hlbmdAdW5pb250ZWNoLmNvbT4NCkNoYW5nZS1JZDogSTlj
OTIxNDZmMjc3MmVhZTM4M2MxNmM4YzEwZGUwMjhiOTFlMDcxNTANCi0tLQ0KIGluY2x1ZGUv
bGludXgvaXJxZGVzYy5oIHwgIDIgKysNCiBrZXJuZWwvaXJxL3NwdXJpb3VzLmMgICB8IDM2
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgMzEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvaXJxZGVzYy5oIGIvaW5jbHVkZS9saW51eC9pcnFkZXNjLmgNCmluZGV4
IDFjZDRlMzY4OTBmYi4uYTNiZDUyMWMzNTU3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51
eC9pcnFkZXNjLmgNCisrKyBiL2luY2x1ZGUvbGludXgvaXJxZGVzYy5oDQpAQCAtMTAyLDYg
KzEwMiw4IEBAIHN0cnVjdCBpcnFfZGVzYyB7DQogCWludAkJCXBhcmVudF9pcnE7DQogCXN0
cnVjdCBtb2R1bGUJCSpvd25lcjsNCiAJY29uc3QgY2hhcgkJKm5hbWU7DQorCXUzMiBnYXBf
Y291bnQ7DQorCXU2NCBnYXBfdGltZTsNCiB9IF9fX19jYWNoZWxpbmVfaW50ZXJub2RlYWxp
Z25lZF9pbl9zbXA7DQogDQogI2lmZGVmIENPTkZJR19TUEFSU0VfSVJRDQpkaWZmIC0tZ2l0
IGEva2VybmVsL2lycS9zcHVyaW91cy5jIGIva2VybmVsL2lycS9zcHVyaW91cy5jDQppbmRl
eCAwMmIyZGFmMDc0NDEuLjc1YmQwMDg4NDQ2YSAxMDA2NDQNCi0tLSBhL2tlcm5lbC9pcnEv
c3B1cmlvdXMuYw0KKysrIGIva2VybmVsL2lycS9zcHVyaW91cy5jDQpAQCAtMTg4LDE5ICsx
ODgsMjEgQEAgc3RhdGljIGlubGluZSBpbnQgYmFkX2FjdGlvbl9yZXQoaXJxcmV0dXJuX3Qg
YWN0aW9uX3JldCkNCiAgKg0KICAqIChUaGUgb3RoZXIgMTAwLW9mLTEwMCwwMDAgaW50ZXJy
dXB0cyBtYXkgaGF2ZSBiZWVuIGEgY29ycmVjdGx5DQogICogIGZ1bmN0aW9uaW5nIGRldmlj
ZSBzaGFyaW5nIGFuIElSUSB3aXRoIHRoZSBmYWlsaW5nIG9uZSkNCisgKg0KKyAqIFNvbWUg
YmFkIGhhcmR3YXJlIHdpbGwgdHJpZ2dlciBpbnRlcnJ1cHRzIHZlcnkgZnJlcXVlbnRseSwg
d2hpY2ggd2lsbA0KKyAqIGNhdXNlIHRoZSBDUFUgdG8gcHJvY2VzcyBoYXJkd2FyZSBpbnRl
cnJ1cHRzIGFsbCB0aGUgdGltZS4gU28gd2hlbg0KKyAqIHdlIGZpbmQgdGhpcyBvdXQsIHRo
ZSBpbnRlcnJ1cHQgc2hvdWxkIGJlIGRpc2FibGVkLg0KICAqLw0KLXN0YXRpYyB2b2lkIF9f
cmVwb3J0X2JhZF9pcnEoc3RydWN0IGlycV9kZXNjICpkZXNjLCBpcnFyZXR1cm5fdCBhY3Rp
b25fcmV0KQ0KK3N0YXRpYyB2b2lkIF9fcmVwb3J0X2JhZF9pcnEoc3RydWN0IGlycV9kZXNj
ICpkZXNjLCBpcnFyZXR1cm5fdCBhY3Rpb25fcmV0LCBjb25zdCBjaGFyICptc2cpDQogew0K
IAl1bnNpZ25lZCBpbnQgaXJxID0gaXJxX2Rlc2NfZ2V0X2lycShkZXNjKTsNCiAJc3RydWN0
IGlycWFjdGlvbiAqYWN0aW9uOw0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KIAlpZiAo
YmFkX2FjdGlvbl9yZXQoYWN0aW9uX3JldCkpIHsNCi0JCXByaW50ayhLRVJOX0VSUiAiaXJx
IGV2ZW50ICVkOiBib2d1cyByZXR1cm4gdmFsdWUgJXhcbiIsDQotCQkJCWlycSwgYWN0aW9u
X3JldCk7DQorCQlwcmludGsobXNnLCBpcnEsIGFjdGlvbl9yZXQpOw0KIAl9IGVsc2Ugew0K
LQkJcHJpbnRrKEtFUk5fRVJSICJpcnEgJWQ6IG5vYm9keSBjYXJlZCAodHJ5IGJvb3Rpbmcg
d2l0aCAiDQotCQkJCSJ0aGUgXCJpcnFwb2xsXCIgb3B0aW9uKVxuIiwgaXJxKTsNCisJCXBy
aW50ayhtc2csIGlycSk7DQogCX0NCiAJZHVtcF9zdGFjaygpOw0KIAlwcmludGsoS0VSTl9F
UlIgImhhbmRsZXJzOlxuIik7DQpAQCAtMjI4LDcgKzIzMCw3IEBAIHN0YXRpYyB2b2lkIHJl
cG9ydF9iYWRfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYywgaXJxcmV0dXJuX3QgYWN0aW9u
X3JldCkNCiANCiAJaWYgKGNvdW50ID4gMCkgew0KIAkJY291bnQtLTsNCi0JCV9fcmVwb3J0
X2JhZF9pcnEoZGVzYywgYWN0aW9uX3JldCk7DQorCQlfX3JlcG9ydF9iYWRfaXJxKGRlc2Ms
IGFjdGlvbl9yZXQsIEtFUk5fRVJSICJpcnEgZXZlbnQgJWQ6IGJvZ3VzIHJldHVybiB2YWx1
ZSAleFxuIik7DQogCX0NCiB9DQogDQpAQCAtMjgyLDYgKzI4NCwyNSBAQCB2b2lkIG5vdGVf
aW50ZXJydXB0KHN0cnVjdCBpcnFfZGVzYyAqZGVzYywgaXJxcmV0dXJuX3QgYWN0aW9uX3Jl
dCkNCiAJCXJldHVybjsNCiAJfQ0KIA0KKwlpZigoZGVzYy0+Z2FwX2NvdW50ICYgMHhmZmZm
MDAwMCkgPT0gMCkNCisJCWRlc2MtPmdhcF90aW1lID0gZ2V0X2ppZmZpZXNfNjQoKTsNCisN
CisJZGVzYy0+Z2FwX2NvdW50ICsrOw0KKw0KKwlpZigoZGVzYy0+Z2FwX2NvdW50ICYgMHgw
MDAwZmZmZikgPj0gMjAwMCkgew0KKwkJaWYoKGdldF9qaWZmaWVzXzY0KCkgLSBkZXNjLT5n
YXBfdGltZSkgPCBIWikgew0KKwkJCWRlc2MtPmdhcF9jb3VudCArPSAweDAwMDEwMDAwOw0K
KwkJCWRlc2MtPmdhcF9jb3VudCAmPSAweGZmZmYwMDAwOw0KKwkJfSBlbHNlIHsNCisJCQlk
ZXNjLT5nYXBfY291bnQgPSAwOw0KKwkJfQ0KKw0KKwkJaWYoKGRlc2MtPmdhcF9jb3VudCA+
PiAxNikgPiAzMCkgew0KKwkJX19yZXBvcnRfYmFkX2lycShkZXNjLCBhY3Rpb25fcmV0LCBL
RVJOX0VSUiAiaXJxICVkOiB0cmlnZ2VyZWQgdG9vIGZyZXF1ZW50bHlcbiIpOw0KKwkJCWly
cV9kaXNhYmxlKGRlc2MpOw0KKwkJfQ0KKwl9DQorDQogCS8qDQogCSAqIFdlIGNhbm5vdCBj
YWxsIG5vdGVfaW50ZXJydXB0IGZyb20gdGhlIHRocmVhZGVkIGhhbmRsZXINCiAJICogYmVj
YXVzZSB3ZSBuZWVkIHRvIGxvb2sgYXQgdGhlIGNvbXBvdW5kIG9mIGFsbCBoYW5kbGVycw0K
QEAgLTQxNiw3ICs0MzcsOCBAQCB2b2lkIG5vdGVfaW50ZXJydXB0KHN0cnVjdCBpcnFfZGVz
YyAqZGVzYywgaXJxcmV0dXJuX3QgYWN0aW9uX3JldCkNCiAJCS8qDQogCQkgKiBUaGUgaW50
ZXJydXB0IGlzIHN0dWNrDQogCQkgKi8NCi0JCV9fcmVwb3J0X2JhZF9pcnEoZGVzYywgYWN0
aW9uX3JldCk7DQorCQlfX3JlcG9ydF9iYWRfaXJxKGRlc2MsIGFjdGlvbl9yZXQsIEtFUk5f
RVJSICJpcnEgJWQ6IG5vYm9keSBjYXJlZCAodHJ5IGJvb3RpbmciDQorCQkJCSJ3aXRoIHRo
ZSBcImlycXBvbGxcIiBvcHRpb24pXG4iKTsNCiAJCS8qDQogCQkgKiBOb3cga2lsbCB0aGUg
SVJRDQogCQkgKi8NCi0tDQoyLjIwLjENCg0KDQpSZWdhcmRzLA0KDQpaaGFuZyBYaW5jaGVu
Zw==

