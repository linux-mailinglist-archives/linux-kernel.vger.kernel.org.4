Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D115F0819
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiI3J7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiI3J7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:59:18 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8217F560
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:59:15 -0700 (PDT)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: PjYGorxjptJIaCMbxNCCHnlxPLTqQ3wpyWKAQU9dUUHK3Y+00HQg2494Ae0BL
        tjcZreCRIkbDv42JtlCnLTu+asAkAZq+F2Te8jIaU23lHIXyW9AnfHEkzrWV0fXdklIeR2S
        Oabcw01Fxd41KD7ISemKjYBgAt8vBUuqX3GyAX4vRn1dEZ4jKIHe79eNzv+aNWnWwCvqJhW
        ApJPQYXpOlQoQBM7mqkYKwQtHXekg1IjxIVrzAVMGsm6hUE515Wyv73/gIovJuD2hUKepNS
        Y0ujGIPGMng91lJTToVW6uM6RyI9ilgcMwy8+teDXYnM+2h10v0HHi68DIO6xJBTqoQHy0k
        imHH9BtUePo+dQbNH4ckwKOid053oe/4BGuA4qT3cUrd99w6uohotr0paekgHlbE1BiPLqg
        /Ub/LVY6B8o=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic637t1664531837t389498
From:   "=?utf-8?B?WmhhbmcgWGluY2hlbmc=?=" <zhangxincheng@uniontech.com>
To:     "=?utf-8?B?bWF6?=" <maz@kernel.org>
Cc:     "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?b2xla3NhbmRy?=" <oleksandr@natalenko.name>,
        "=?utf-8?B?SGFucyBkZSBHb2VkZQ==?=" <hdegoede@redhat.com>,
        "=?utf-8?B?YmlnZWFzeQ==?=" <bigeasy@linutronix.de>,
        "=?utf-8?B?bWFyay5ydXRsYW5k?=" <mark.rutland@arm.com>,
        "=?utf-8?B?bWljaGFlbA==?=" <michael@walle.cc>
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 30 Sep 2022 17:57:17 +0800
X-Priority: 3
Message-ID: <tencent_7C4E401B708789BC3A26F57C@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20220930064042.14564-1-zhangxincheng@uniontech.com>
        <86bkqx6wrd.wl-maz@kernel.org>
In-Reply-To: <86bkqx6wrd.wl-maz@kernel.org>
X-QQ-ReplyHash: 1705522115
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 30 Sep 2022 17:57:19 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJcnJlc3BlY3RpdmUgb2YgdGhlIHBhdGNoIGl0c2VsZiwgSSB3b3VsZCByZWFsbHkgbGlr
ZSB0byB1bmRlcnN0YW5kDQo+IHdoeSB5b3UgY29uc2lkZXIgdGhhdCBpdCBpcyBhIGJldHRl
ciBjb3Vyc2Ugb2YgYWN0aW9uIHRvIGtpbGwgYSBkZXZpY2UNCj4gKGFuZCBwb3RlbnRpYWxs
eSB0aGUgd2hvbGUgbWFjaGluZSkgdGhhbiB0byBsZXQgdGhlIHN0b3JtIGV2ZW50dWFsbHkN
Cj4gY2FsbSBkb3duPyBBIGZyZXF1ZW50IGludGVycnVwdCBpcyBub3QgbmVjZXNzYXJpbHkg
dGhlIHNpZ24gb2YNCj4gc29tZXRoaW5nIGdvaW5nIHdyb25nLiBJdCBpcyB0aGUgc2lnbiBv
ZiBhIGJ1c3kgc3lzdGVtLiBJIHByZWZlciBteQ0KPiBzeXN0ZW1zIGJ1c3kgcmF0aGVyIHRo
YW4gZGVhZC4NCg0KQmVjYXVzZSBJIGZvdW5kIHRoYXQgc29tZSBwZXJpcGhlcmFscyB3aWxs
IHNlbmQgaW50ZXJydXB0cyB0byB0aGUgQ1BVIHZlcnkgZnJlcXVlbnRseSANCmluIHNvbWUg
Y2FzZXMsIGFuZCB0aGUgaW50ZXJydXB0cyB3aWxsIGJlIGhhbmRsZWQgY29ycmVjdGx5LCB3
aGljaCB3aWxsIGNhdXNlIHRoZSBDUFUgDQp0byBkbyBub3RoaW5nIGJ1dCBoYW5kbGUgdGhl
IGludGVycnVwdHMuIEF0IHRoZSBzYW1lIHRpbWUsIHRoZSBSQ1Ugc3lzdGVtIHdpbGwgcmVw
b3J0IA0KdGhlIGZvbGxvd2luZyBsb2dzOg0KDQpbICA4MzguMTMxNjI4XSByY3U6IElORk86
IHJjdV9zY2hlZCBzZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVQ0KWyAgODM4LjEzNzE4OV0g
cmN1OiAgICAgMC0uLi4uOiAoMTk0ODM5IHRpY2tzIHRoaXMgR1ApIGlkbGU9ZjAyLzEvMHg0
MDAwMDAwMDAwMDAwMDA0IHNvZnRpcnE9OTk5My85OTkzIGZxcz05NzQyOCANClsgIDgzOC4x
NDY5MTJdIHJjdTogICAgICAodD0xOTUwMTUgamlmZmllcyBnPTY3NzMgcT0wKQ0KWyAgODM4
LjE1MTUxNl0gVGFzayBkdW1wIGZvciBDUFUgMDoNClsgIDgzOC4xNTQ3MzBdIHN5c3RlbWQt
c2xlZXAgICBSICBydW5uaW5nIHRhc2sgICAgICAgIDAgIDM0NDUgICAgICAxIDB4MDAwMDAw
MGENClsgIDgzOC4xNjE3NjRdIENhbGwgdHJhY2U6DQpbICA4MzguMTY0MTk4XSAgZHVtcF9i
YWNrdHJhY2UrMHgwLzB4MTkwDQpbICA4MzguMTY3ODQ2XSAgc2hvd19zdGFjaysweDE0LzB4
MjANClsgIDgzOC4xNzExNDhdICBzY2hlZF9zaG93X3Rhc2srMHgxMzQvMHgxNjANClsgIDgz
OC4xNzUwNTddICBkdW1wX2NwdV90YXNrKzB4NDAvMHg0Yw0KWyAgODM4LjE3ODYxOF0gIHJj
dV9kdW1wX2NwdV9zdGFja3MrMHhjNC8weDEwOA0KWyAgODM4LjE4Mjc4OF0gIHJjdV9jaGVj
a19jYWxsYmFja3MrMHg2ZTQvMHg4OTgNClsgIDgzOC4xODcwNDRdICB1cGRhdGVfcHJvY2Vz
c190aW1lcysweDJjLzB4ODgNClsgIDgzOC4xOTEyMTRdICB0aWNrX3NjaGVkX2hhbmRsZS5p
c3JhLjUrMHgzYy8weDUwDQpbICA4MzguMTk1NzMwXSAgdGlja19zY2hlZF90aW1lcisweDQ4
LzB4OTgNClsgIDgzOC4xOTk1NTJdICBfX2hydGltZXJfcnVuX3F1ZXVlcysweGVjLzB4MmY4
DQpbICA4MzguMjAzODA4XSAgaHJ0aW1lcl9pbnRlcnJ1cHQrMHgxMGMvMHgyOTgNClsgIDgz
OC4yMDc4OTFdICBhcmNoX3RpbWVyX2hhbmRsZXJfcGh5cysweDJjLzB4MzgNClsgIDgzOC4y
MTIzMjFdICBoYW5kbGVfcGVyY3B1X2RldmlkX2lycSsweDg4LzB4MjI4DQpbICA4MzguMjE2
ODM3XSAgZ2VuZXJpY19oYW5kbGVfaXJxKzB4MmMvMHg0MA0KWyAgODM4LjIyMDgzM10gIF9f
aGFuZGxlX2RvbWFpbl9pcnErMHg2MC8weGI4DQpbICA4MzguMjI0OTE1XSAgZ2ljX2hhbmRs
ZV9pcnErMHg3Yy8weDE3OA0KWyAgODM4LjIyODY1MF0gIGVsMV9pcnErMHhiMC8weDE0MA0K
WyAgODM4LjIzMTc3OF0gIF9fZG9fc29mdGlycSsweDg0LzB4MmU4DQpbICA4MzguMjM1MzQw
XSAgaXJxX2V4aXQrMHg5Yy8weGI4DQpbICA4MzguMjM4NDY4XSAgX19oYW5kbGVfZG9tYWlu
X2lycSsweDY0LzB4YjgNClsgIDgzOC4yNDI1NTBdICBnaWNfaGFuZGxlX2lycSsweDdjLzB4
MTc4DQpbICA4MzguMjQ2Mjg1XSAgZWwxX2lycSsweGIwLzB4MTQwDQpbICA4MzguMjQ5NDEz
XSAgcmVzdW1lX2lycXMrMHhmYy8weDE0OA0KWyAgODM4LjI1Mjg4OF0gIHJlc3VtZV9kZXZp
Y2VfaXJxcysweDEwLzB4MTgNClsgIDgzOC4yNTY4ODNdICBkcG1fcmVzdW1lX25vaXJxKzB4
MTAvMHgyMA0KWyAgODM4LjI2MDcwNl0gIHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIrMHgx
NzAvMHg3ODgNClsgIDgzOC4yNjU0ODNdICBwbV9zdXNwZW5kKzB4NDFjLzB4NGNjDQpbICA4
MzguMjY4OTU4XSAgc3RhdGVfc3RvcmUrMHhiYy8weDE2MA0KWyAgODM4LjI3MjQzM10gIGtv
YmpfYXR0cl9zdG9yZSsweDE0LzB4MjgNClsgIDgzOC4yNzYxNjhdICBzeXNmc19rZl93cml0
ZSsweDQwLzB4NTANClsgIDgzOC4yNzk4MTddICBrZXJuZnNfZm9wX3dyaXRlKzB4Y2MvMHgx
ZTANClsgIDgzOC4yODM3MjZdICBfX3Zmc193cml0ZSsweDE4LzB4MTQwDQpbICA4MzguMjg3
MjAxXSAgdmZzX3dyaXRlKzB4YTQvMHgxYjANClsgIDgzOC4yOTA1MDNdICBrc3lzX3dyaXRl
KzB4NGMvMHhiOA0KWyAgODM4LjI5MzgwNF0gIF9fYXJtNjRfc3lzX3dyaXRlKzB4MTgvMHgy
MA0KWyAgODM4LjI5NzcxM10gIGVsMF9zdmNfY29tbW9uKzB4OTAvMHgxNzgNClsgIDgzOC4z
MDE0NDldICBlbDBfc3ZjX2hhbmRsZXIrMHg5Yy8weGE4DQpbICA4MzguMzA1MTg0XSAgZWww
X3N2YysweDgvMHhjDQoNClRoZSBsb2cgaXMgZnJvbSB0aGUgcHJvY2VzcyBvZiB3YWtpbmcg
dXAgYSBzbGVlcGluZyBtYWNoaW5lLCANCkkgbGVmdCB0aGUgbWFjaGluZSBpbiB0aGlzIHN0
YXRlIGZvciBhIG5pZ2h0IGFuZCBpdCBzdWNjZXNzZnVsbHkgd29rZSB1cCwNCiBhbmQgdGhl
biBJIHNhdyBmcm9tIC9wcm9jL2ludGVycnVwdHMgdGhhdCBhIEdQSU8gaW50ZXJydXB0IHRy
aWdnZXJlZCANCm1vcmUgdGhhbiAxMyBiaWxsaW9uIHRpbWVzLg0KDQoyOTogMTM2ODIwMDAw
MSAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgICAgcGh5dGl1bV9ncGlvNiAgIEVkZ2UgQUNQSTpF
dmVudA0KDQo+IFNvbWV0aGluZyBsaWtlIHRoaXMgc2hvdWxkIGJlIGxpbWl0ZWQgdG8gYSBk
ZWJ1ZyBmZWF0dXJlLiBJdCB3b3VsZA0KPiBhbHNvIGJlIGEgbG90IG1vcmUgdXNlZnVsIGlm
IGl0IHdhcyBidWlsdCBhcyBhbiBpbnRlcnJ1cHQgKmxpbWl0aW5nKg0KPiBmZWF0dXJlLCBy
YXRoZXIgdGhlbiBraWxsaW5nIHRoZSBpbnRlcnJ1cHQgZm9yZXZlciAod2hpY2ggaXMgSU1I
TyBhDQo+IGx1ZGljcm91cyB0aGluZyB0byBkbykuDQoNCkl0J3MgYSBnb29kIGlkZWEgdG8g
aGF2ZSBpdCBhcyBhIGRlYnVnZ2luZyBmZWF0dXJlLg0KDQoNClRoYW5rcywNCg0KICAgICAg
ICAgICAgIFpoYW5nIFhpbmNoZW5n

