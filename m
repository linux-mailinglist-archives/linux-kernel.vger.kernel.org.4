Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207A6378CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKXM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:26:12 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C2D9058
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:26:08 -0800 (PST)
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000B00070
X-QQ-FEAT: wPIjJ9FgeVWsBiS/dltYVBSXJxVV701pwLOnQP3FuLCtVv5RREYOD40wdnqrL
        tBTHpVOhaBlDzyhz9np0hZWZ+zlMn4Xa5Ql9Zn1aV4CEN7oGhI18gkaVFTgSzhNfOlYftr5
        uPUptb73EDY33JGsLD/xZYvT1xjDQV6qZMNC4xIOuJubIg1O17Ye/v5iQ44+1LmBm8QXXVs
        AQTIO93YWsq929L+jnc7+tLzIklAyPaCTf3yyCfUQ9gylueAFecBmPyEIh1zWc+6Gd3W4Mq
        IOXLSNfc9v23jghaQu6WPhlK0O14RpfZHhspRA4x8Pge3Zal0X5H6TryfUC1TMDFa6DgDuy
        qlLfHc8arvXNKxUKAg8pluG04zHZy813TAMG/UF
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.214.84
X-QQ-STYLE: 
X-QQ-mid: logic633t1669292638t6368341
From:   "=?utf-8?B?546L5rSq6L6J?=" <honghui.wang@ucas.com.cn>
To:     "=?utf-8?B?TWFyayBSdXRsYW5k?=" <mark.rutland@arm.com>
Cc:     "=?utf-8?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>,
        "=?utf-8?B?Q3Jpc3RpYW4gTWFydXNz?=" <cristian.marussi@arm.com>,
        "=?utf-8?B?SmFzc2kgQnJhcg==?=" <jassisinghbrar@gmail.com>,
        "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm_scpi: modify to support acpi
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 24 Nov 2022 20:23:58 +0800
X-Priority: 3
Message-ID: <tencent_049E1A8275A0742F2374507E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
        <Y39PetDhm9fpycwo@FVFF77S0Q05N>
In-Reply-To: <Y39PetDhm9fpycwo@FVFF77S0Q05N>
X-QQ-ReplyHash: 504006716
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 24 Nov 2022 20:23:59 +0800 (CST)
Feedback-ID: logic:ucas.com.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmtzIQ0KDQpXaGVuIGJvb3QgZnJvbSB1ZWZpIG9uIHBoeXRpdW0gZnQyMDA0KGFybTY0
KSBwbGF0Zm9ybSwgY2FuJ3Qgc2hvdyB0ZW1wICYgZnJlcSBvZiBjcHUsIGJ1dCB3ZWxsIGlm
IGJvb3QgZnJvbSB1Ym9vdCBmb3Igc2FtZSBrZXJuZWwgYmluYXJ5IGZpbGU7DQpTbyBpIG1v
ZGlmaWVkIGFybV9zY3BpLmMgYW5kIHNjcGktaHdtb24uYyBhcyBwYXRjaCwgYW5kIHRlc3Rl
ZCBvay4NCg0KQmVzdCBSZWdhcmRzIQ0KDQpXYW5nIEhvbmdodWkNCg0KICAtLS0tLS0tLS0t
LS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tRnJvbTogICJNYXJrIFJ1dGxh
bmQiPG1hcmsucnV0bGFuZEBhcm0uY29tPjtEYXRlOiAgVGh1LCBOb3YgMjQsIDIwMjIgMDc6
MDMgUE1UbzogICJXYW5nIEhvbmdodWkiPGhvbmdodWkud2FuZ0B1Y2FzLmNvbS5jbj47IENj
OiAgIlN1ZGVlcCBIb2xsYSI8c3VkZWVwLmhvbGxhQGFybS5jb20+OyAiQ3Jpc3RpYW4gTWFy
dXNzIjxjcmlzdGlhbi5tYXJ1c3NpQGFybS5jb20+OyAiSmFzc2kgQnJhciI8amFzc2lzaW5n
aGJyYXJAZ21haWwuY29tPjsgImxpbnV4LWFybS1rZXJuZWwiPGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZz47ICJsaW51eC1rZXJuZWwiPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBTdWJqZWN0OiAgUmU6IFtQQVRDSCAzLzNdIGFybV9zY3BpOiBtb2Rp
ZnkgdG8gc3VwcG9ydCBhY3BpIE9uIFRodSwgTm92IDI0LCAyMDIyIGF0IDAzOjA5OjMxUE0g
KzA4MDAsIFdhbmcgSG9uZ2h1aSB3cm90ZTo+IGFybV9zY3BpOiBtb2RpZnkgdG8gc3VwcG9y
dCBhY3BpPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgSG9uZ2h1aSA8aG9uZ2h1aS53YW5nQHVj
YXMuY29tLmNuPj4gQEAgLTkzNyw1NSArOTUyLDExNiBAQCBzdGF0aWMgaW50IHNjcGlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik+IGlmIChyZXQpPiAgcmV0dXJuIHJl
dDs+ICA+IC0gZm9yICg7IHNjcGlfZHJ2aW5mby0+bnVtX2NoYW5zIDwgY291bnQ7IHNjcGlf
ZHJ2aW5mby0+bnVtX2NoYW5zKyspIHs+IC1yZXNvdXJjZV9zaXplX3Qgc2l6ZTs+IC1pbnQg
aWR4ID0gc2NwaV9kcnZpbmZvLT5udW1fY2hhbnM7PiAtc3RydWN0IHNjcGlfY2hhbiAqcGNo
YW4gPSBzY3BpX2RydmluZm8tPmNoYW5uZWxzICsgaWR4Oz4gLXN0cnVjdCBtYm94X2NsaWVu
dCAqY2wgPSAmcGNoYW4tPmNsOz4gLXN0cnVjdCBkZXZpY2Vfbm9kZSAqc2htZW0gPSBvZl9w
YXJzZV9waGFuZGxlKG5wLCAic2htZW0iLCBpZHgpOz4gLT4gLWlmICghb2ZfbWF0Y2hfbm9k
ZShzaG1lbV9vZl9tYXRjaCwgc2htZW0pKT4gLSByZXR1cm4gLUVOWElPOz4gKyAvKiBXYW5n
IEhvbmdodWkgbW9kaWZpZWQgdG8gc3VwcG9ydCBhY3BpICovPiArIGlmIChkZXYtPm9mX25v
ZGUpIHtbLi4uXT4gKyB9IGVsc2Ugez4gK2ZvciAoOyBzY3BpX2luZm8tPm51bV9jaGFucyA8
IGNvdW50OyBzY3BpX2luZm8tPm51bV9jaGFucysrKSB7PiArICAgICAgICAgICAgICAgICAg
ICAgICAgdTMyIHNpemU7PiArICAgICAgICAgICAgICAgICAgICAgICAgdTMyIGFkZHI7PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgaW50IGlkeCA9IHNjcGlfaW5mby0+bnVtX2NoYW5z
Oz4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzY3BpX2NoYW4gKnBjaGFuID0g
c2NwaV9pbmZvLT5jaGFubmVscyArIGlkeDs+ICsgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgbWJveF9jbGllbnQgKmNsID0gJnBjaGFuLT5jbDs+ICsgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZm47PiArPiArICAgICAgICAgICAgICAg
ICAgICAgICAgZm4gPSBkZXZfZndub2RlKCYocGRldi0+ZGV2KSk7PiArICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gZndub2RlX3Byb3BlcnR5X3JlYWRfdTMyKGZuLCAic2htZW1f
c3RhcnQiLCAgJmFkZHIpOz4gKyAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPCAw
KSB7PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZh
aWxlZCB0byBnZXQgU0NQSSBwYXlsb2FkIG1lbSByZXNvdXJjZVxuIik7PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Oz4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIH0+ICs+ICsgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBmd25vZGVfcHJv
cGVydHlfcmVhZF91MzIoZm4sICJzaG1lbV9zaXplIiwgICZzaXplKTs+ICsgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgez4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gaW9yZW1hcCBTQ1BJIHBheWxvYWRc
biIpOz4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQUREUk5P
VEFWQUlMOz4gKyAgICAgICAgICAgICAgICAgICAgICAgIH1BQ1BJIGhhcyBuYXRpdmUgbWVj
aGFuaXNtcyB0byBkZXNjcmliZSBJTyByZXNvdXJjZXMsIHNvIHRoaXMgZG9lc24ndCBsb29r
IHJpZ2h0IGF0IGFsbC5Eb2VzIEFSTSBoYXZlIEFDUEkgYmluZGluZ3MgZm9yIFNDUEk/IEkg
ZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGJlIGludmVudGluZ3ZlbmRvci1zcGVjaWZpYyBiaW5k
aW5ncyBmb3IgdGhpcy4uLi4+ICsgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXJldCkg
ez4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNoYW4tPmNoYW4gPSBwaHl0
aXVtX21ib3hfcmVxdWVzdF9jaGFubmVsKGNsKTsuLi4gc28gdGhpcyBsb29rcyB2ZXJ5IHdy
b25nLlRoYW5rcyxNYXJrLg==

