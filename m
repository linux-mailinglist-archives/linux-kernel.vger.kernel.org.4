Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E9626EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiKMJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:34:54 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8BFD49;
        Sun, 13 Nov 2022 01:34:53 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:29:50 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:29:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4d274d11.12d.1847052e009.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3jOIOuXBjwBoDAA--.79W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwATs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6CgpzY3JpcHRzL21vZC9zdW12ZXJzaW9u
LmM6MjE5OjQ4LTQ5OiBXQVJOSU5HOiBVc2UgQVJSQVlfU0laRQpzY3JpcHRzL21vZC9zdW12ZXJz
aW9uLmM6MTU2OjQ4LTQ5OiBXQVJOSU5HOiBVc2UgQVJSQVlfU0laRQoKU2lnbmVkLW9mZi1ieTog
S2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIHNjcmlwdHMvbW9kL3N1bXZl
cnNpb24uYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zY3JpcHRzL21vZC9zdW12ZXJzaW9uLmMgYi9zY3JpcHRz
L21vZC9zdW12ZXJzaW9uLmMKaW5kZXggNmJmOWNhY2EwOTY4Li4zMTA2NmJmZGJhMDQgMTAwNjQ0
Ci0tLSBhL3NjcmlwdHMvbW9kL3N1bXZlcnNpb24uYworKysgYi9zY3JpcHRzL21vZC9zdW12ZXJz
aW9uLmMKQEAgLTE1Myw3ICsxNTMsNyBAQCBzdGF0aWMgdm9pZCBtZDRfdHJhbnNmb3JtKHVpbnQz
Ml90ICpoYXNoLCB1aW50MzJfdCBjb25zdCAqaW4pCiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBtZDRf
dHJhbnNmb3JtX2hlbHBlcihzdHJ1Y3QgbWQ0X2N0eCAqY3R4KQogewotCWxlMzJfdG9fY3B1X2Fy
cmF5KGN0eC0+YmxvY2ssIHNpemVvZihjdHgtPmJsb2NrKSAvIHNpemVvZih1aW50MzJfdCkpOwor
CWxlMzJfdG9fY3B1X2FycmF5KGN0eC0+YmxvY2ssIEFSUkFZX1NJWkUoY3R4LT5ibG9jaykpOwog
CW1kNF90cmFuc2Zvcm0oY3R4LT5oYXNoLCBjdHgtPmJsb2NrKTsKIH0KIApAQCAtMjE2LDcgKzIx
Niw3IEBAIHN0YXRpYyB2b2lkIG1kNF9maW5hbF9hc2NpaShzdHJ1Y3QgbWQ0X2N0eCAqbWN0eCwg
Y2hhciAqb3V0LCB1bnNpZ25lZCBpbnQgbGVuKQogCWxlMzJfdG9fY3B1X2FycmF5KG1jdHgtPmJs
b2NrLCAoc2l6ZW9mKG1jdHgtPmJsb2NrKSAtCiAJCQkgIHNpemVvZih1aW50NjRfdCkpIC8gc2l6
ZW9mKHVpbnQzMl90KSk7CiAJbWQ0X3RyYW5zZm9ybShtY3R4LT5oYXNoLCBtY3R4LT5ibG9jayk7
Ci0JY3B1X3RvX2xlMzJfYXJyYXkobWN0eC0+aGFzaCwgc2l6ZW9mKG1jdHgtPmhhc2gpIC8gc2l6
ZW9mKHVpbnQzMl90KSk7CisJY3B1X3RvX2xlMzJfYXJyYXkobWN0eC0+aGFzaCwgQVJSQVlfU0la
RShtY3R4LT5oYXNoKSk7CiAKIAlzbnByaW50ZihvdXQsIGxlbiwgIiUwOFglMDhYJTA4WCUwOFgi
LAogCQkgbWN0eC0+aGFzaFswXSwgbWN0eC0+aGFzaFsxXSwgbWN0eC0+aGFzaFsyXSwgbWN0eC0+
aGFzaFszXSk7Ci0tIAoyLjI1LjEK
