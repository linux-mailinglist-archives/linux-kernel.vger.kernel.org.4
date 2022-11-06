Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8593C61E291
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKFOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKFOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:30:10 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B42ACE26
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 06:30:09 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 22:25:24 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 22:25:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: platform-mhu: Remove unnecessary print function
 dev_err()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6745733c.be.1844d54f4b9.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCHj+DUw2djcYsBAA--.37W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CyAACsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RWxpbWluYXRlIHRoZSBmb2xsb3cgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9kcml2ZXJzL21haWxi
b3gvcGxhdGZvcm1fbWh1LmM6MTM5OjMtMTA6IGxpbmUgMTM5IGlzIHJlZHVuZGFudCBiZWNhdXNl
CnBsYXRmb3JtX2dldF9pcnEoKSBhbHJlYWR5IHByaW50cyBhbiBlcnJvcgoKU2lnbmVkLW9mZi1i
eTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvbWFpbGJv
eC9wbGF0Zm9ybV9taHUuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvcGxhdGZvcm1fbWh1LmMgYi9kcml2ZXJzL21haWxi
b3gvcGxhdGZvcm1fbWh1LmMKaW5kZXggYTU5MjJhYzBiMGJmLi4wOGUwZWVkZWE4NjAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbWFpbGJveC9wbGF0Zm9ybV9taHUuYworKysgYi9kcml2ZXJzL21haWxi
b3gvcGxhdGZvcm1fbWh1LmMKQEAgLTEzNiw3ICsxMzYsNiBAQCBzdGF0aWMgaW50IHBsYXRmb3Jt
X21odV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQltaHUtPmNoYW5baV0u
Y29uX3ByaXYgPSAmbWh1LT5tbGlua1tpXTsKIAkJbWh1LT5tbGlua1tpXS5pcnEgPSBwbGF0Zm9y
bV9nZXRfaXJxKHBkZXYsIGkpOwogCQlpZiAobWh1LT5tbGlua1tpXS5pcnEgPCAwKSB7Ci0JCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgaXJxJWRcbiIsIGkpOwogCQkJcmV0dXJuIG1odS0+
bWxpbmtbaV0uaXJxOwogCQl9CiAJCW1odS0+bWxpbmtbaV0ucnhfcmVnID0gbWh1LT5iYXNlICsg
cGxhdGZvcm1fbWh1X3JlZ1tpXTsKLS0gCjIuMjUuMQoK
