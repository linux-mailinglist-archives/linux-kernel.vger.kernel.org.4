Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110096378D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKXM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:27:10 -0500
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29449D92F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:27:08 -0800 (PST)
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000B00070
X-QQ-FEAT: VErM9xwdPg9fXJXFjioDXrs1P5pGz5d8FgCt2Q+/sjAR2I25JyJLX7g504d5r
        dNELfK4ICTcRl1gAAQKBkGaa+CJv9VhwKfm6vxE71DaOL8aufz5af26hz/Ovyf9NuGhFDbL
        WNdrhvyCCXK0MbtfRqNjt8nUgrHylxpqhMQhpHZNGhfJHjDjVEPMVX9oQvqvcSCvizCFozv
        xR6Uvsnan4FIZAIi7URJt0RL60bHCEhYW80qq103npehQNS5Weytl9PdkvpNO2HEeg3chzj
        32fLJUSe7KdGZKtZl73bsjLjPBWNaPANJQi1d79X4D/NN5t9bdC0pkxUViv3+oQVqHP2vQ6
        2YHX0EGMbhGKBYbO1i+clnMYnGLe1VmgFwjQ/7BNiH+vjsy/qI=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.214.84
X-QQ-STYLE: 
X-QQ-mid: logic633t1669292784t41384
From:   "=?utf-8?B?546L5rSq6L6J?=" <honghui.wang@ucas.com.cn>
To:     "=?utf-8?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>
Cc:     "=?utf-8?B?Q3Jpc3RpYW4gTWFydXNz?=" <cristian.marussi@arm.com>,
        "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] arm_scpi: Rev last modify to support acpi
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 24 Nov 2022 20:26:24 +0800
X-Priority: 3
Message-ID: <tencent_52A351CD61E76A06527CACF5@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <566DA2F800E4BACA+Y39Ak8xtNJaBqB90@TP-P15V.lan>
        <20221124111450.mqfpmatba6f7pap6@bogus>
In-Reply-To: <20221124111450.mqfpmatba6f7pap6@bogus>
X-QQ-ReplyHash: 3043500210
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 24 Nov 2022 20:26:25 +0800 (CST)
Feedback-ID: logic:ucas.com.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2shDQoNClRoYW5rcywNCkJlc3QgUmVnYXJkcyENCg0KV2FuZyBIb25naHVpDQoNCiAgLS0t
LS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLUZyb206ICAiU3Vk
ZWVwIEhvbGxhIjxzdWRlZXAuaG9sbGFAYXJtLmNvbT47RGF0ZTogIFRodSwgTm92IDI0LCAy
MDIyIDA3OjE1IFBNVG86ICAiV2FuZyBIb25naHVpIjxob25naHVpLndhbmdAdWNhcy5jb20u
Y24+OyBDYzogICJDcmlzdGlhbiBNYXJ1c3MiPGNyaXN0aWFuLm1hcnVzc2lAYXJtLmNvbT47
ICJsaW51eC1hcm0ta2VybmVsIjxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU3Vi
amVjdDogIFJlOiBbUEFUQ0ggVjIgMy8zXSBhcm1fc2NwaTogUmV2IGxhc3QgbW9kaWZ5IHRv
IHN1cHBvcnQgYWNwaSBPbiBUaHUsIE5vdiAyNCwgMjAyMiBhdCAwNTo1OTo0N1BNICswODAw
LCBXYW5nIEhvbmdodWkgd3JvdGU6PiBSZXYgbGFzdCBtb2RpZnkgdG8gc3VwcG9ydCBhY3Bp
PiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgSG9uZ2h1aSA8aG9uZ2h1aS53YW5nQHVjYXMuY29t
LmNuPj4gLS0tPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jIHwgNCArKysrPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKT4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9m
aXJtd2FyZS9hcm1fc2NwaS5jIGIvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jPiBpbmRl
eCBlMmU5MGRjYzM4YmQuLmFjYTBhOTc4MGMxMiAxMDA2NDQ+IC0tLSBhL2RyaXZlcnMvZmly
bXdhcmUvYXJtX3NjcGkuYz4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jPiBA
QCAtOTA4LDcgKzkwOCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNo
bWVtX29mX21hdGNoW10gX19tYXliZV91bnVzZWQgPSB7PiB7IH0+ICB9Oz4gID4gKyNpZmRl
ZiBDT05GSUdfUEhZVElVTV9NQk9YPiAgZXh0ZXJuIHN0cnVjdCBtYm94X2NoYW4gKnBoeXRp
dW1fbWJveF9yZXF1ZXN0X2NoYW5uZWwoc3RydWN0IG1ib3hfY2xpZW50ICpjbCk7PiArI2Vu
ZGlmSSBoYXZlIGFscmVhZHkgTkFDSyB0aGUgYXBwcm9hY2ggeW91IGhhdmUgdGFrZW4gZm9y
IFNDUEkgKyBBQ1BJLiBKdXN0IGZvcmdvdHRvIG1lbnRpb24gU0NQSSBpcyBvbGQgYW5kIGRl
cHJlY2F0ZWQgcHJvdG9jb2wgYW5kIFNDTUkgcmVwbGFjZWQgaXQuIFlvdW11Y2ggYmUgdXNp
bmcgdGhhdCBpZiBwb3NzaWJsZS5Bbnl3YXlzLCB0aGlzIGtpbmQgb2YgI2lmZGVmZmVyeSBp
cyBub3QgYWxsb3dlZCBpbiBhbnkgZ2VuZXJpYyBjb2RlIGV2ZW4gaWZJIGFncmVlZCB3aXRo
IHRoZSBhcHByb2FjaC4gU28gcGxlYXNlIGRvbid0IGNoYW5nZSB0aGUgY29kZSBpbiBzdWNo
IGEgd2F5Li0tIFJlZ2FyZHMsU3VkZWVw

