Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11E626ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiKMJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:55:40 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7B23E009;
        Sun, 13 Nov 2022 01:55:39 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:50:30 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:50:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject:  [PATCH] ACPICA: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3701ca18.12f.1847065cd7e.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+LmvXBj4BsDAA--.83W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAZs8
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

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6Cgpkcml2ZXJzL2FjcGkvYWNwaWNhL3Ri
ZmFkdC5jOjEwNzoyNy0yODogV0FSTklORzogVXNlIEFSUkFZX1NJWkUKZHJpdmVycy9hY3BpL2Fj
cGljYS90YmZhZHQuYzoxMzc6MzAtMzE6IFdBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCgpTaWduZWQt
b2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9h
Y3BpL2FjcGljYS90YmZhZHQuYyB8IDggKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlj
YS90YmZhZHQuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0LmMKaW5kZXggMzFkN2VhODRh
MzYwLi42MzdmY2Q3NGYzMGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0
LmMKKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS90YmZhZHQuYwpAQCAtMTAzLDkgKzEwMyw3IEBA
IHN0YXRpYyBzdHJ1Y3QgYWNwaV9mYWR0X2luZm8gZmFkdF9pbmZvX3RhYmxlW10gPSB7CiAJIEFD
UElfRkFEVF9TRVBBUkFURV9MRU5HVEggfCBBQ1BJX0ZBRFRfR1BFX1JFR0lTVEVSfQogfTsKIAot
I2RlZmluZSBBQ1BJX0ZBRFRfSU5GT19FTlRSSUVTIFwKLQkJCShzaXplb2YgKGZhZHRfaW5mb190
YWJsZSkgLyBzaXplb2YgKHN0cnVjdCBhY3BpX2ZhZHRfaW5mbykpCi0KKyNkZWZpbmUgQUNQSV9G
QURUX0lORk9fRU5UUklFUyAoQVJSQVlfU0laRShmYWR0X2luZm9fdGFibGUpKQogLyogVGFibGUg
dXNlZCB0byBzcGxpdCBFdmVudCBCbG9ja3MgaW50byBzZXBhcmF0ZSBzdGF0dXMvZW5hYmxlIHJl
Z2lzdGVycyAqLwogCiB0eXBlZGVmIHN0cnVjdCBhY3BpX2ZhZHRfcG1faW5mbyB7CkBAIC0xMzMs
OSArMTMxLDcgQEAgc3RhdGljIHN0cnVjdCBhY3BpX2ZhZHRfcG1faW5mbyBmYWR0X3BtX2luZm9f
dGFibGVbXSA9IHsKIAkgMX0KIH07CiAKLSNkZWZpbmUgQUNQSV9GQURUX1BNX0lORk9fRU5UUklF
UyBcCi0JCQkoc2l6ZW9mIChmYWR0X3BtX2luZm9fdGFibGUpIC8gc2l6ZW9mIChzdHJ1Y3QgYWNw
aV9mYWR0X3BtX2luZm8pKQotCisjZGVmaW5lIEFDUElfRkFEVF9QTV9JTkZPX0VOVFJJRVMgKEFS
UkFZX1NJWkUoZmFkdF9wbV9pbmZvX3RhYmxlKSkKIC8qKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAg
KgogICogRlVOQ1RJT046ICAgIGFjcGlfdGJfaW5pdF9nZW5lcmljX2FkZHJlc3MKLS0gCjIuMjUu
MQo=
