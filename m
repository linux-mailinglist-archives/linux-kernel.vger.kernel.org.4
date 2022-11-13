Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81F626EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:10:56 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92F3D5FD7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 02:10:55 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 18:05:59 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 18:05:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     linux-kernel@vger.kernel.org
Subject:  [PATCH] tools: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4146c8ae.131.1847073f91a.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3jOKHwXBjvx0DAA--.80W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAfs6
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

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6Cgp0b29scy91c2IvZmZzLWFpby1leGFt
cGxlL211bHRpYnVmZi9kZXZpY2VfYXBwL2Fpb19tdWx0aWJ1ZmYuYzoyOTk6MjktMzA6CldBUk5J
Tkc6IFVzZSBBUlJBWV9TSVpFCnRvb2xzL3VzYi9mZnMtYWlvLWV4YW1wbGUvbXVsdGlidWZmL2Rl
dmljZV9hcHAvYWlvX211bHRpYnVmZi5jOjMyNzozMC0zMToKV0FSTklORzogVXNlIEFSUkFZX1NJ
WkUKdG9vbHMvdXNiL2Zmcy1haW8tZXhhbXBsZS9tdWx0aWJ1ZmYvZGV2aWNlX2FwcC9haW9fbXVs
dGlidWZmLmM6MzY3OjM4LTM5OgpXQVJOSU5HOiBVc2UgQVJSQVlfU0laRQp0b29scy91c2IvZmZz
LWFpby1leGFtcGxlL211bHRpYnVmZi9kZXZpY2VfYXBwL2Fpb19tdWx0aWJ1ZmYuYzozNzI6Mjkt
MzA6CldBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcg
PHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogLi4uL2Zmcy1haW8tZXhhbXBsZS9tdWx0aWJ1ZmYv
ZGV2aWNlX2FwcC9haW9fbXVsdGlidWZmLmMgIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90b29scy91c2Iv
ZmZzLWFpby1leGFtcGxlL211bHRpYnVmZi9kZXZpY2VfYXBwL2Fpb19tdWx0aWJ1ZmYuYyBiL3Rv
b2xzL3VzYi9mZnMtYWlvLWV4YW1wbGUvbXVsdGlidWZmL2RldmljZV9hcHAvYWlvX211bHRpYnVm
Zi5jCmluZGV4IGFhY2ExZjQ0ZTc4OC4uYzM0ZGQxMDg2NThmIDEwMDY0NAotLS0gYS90b29scy91
c2IvZmZzLWFpby1leGFtcGxlL211bHRpYnVmZi9kZXZpY2VfYXBwL2Fpb19tdWx0aWJ1ZmYuYwor
KysgYi90b29scy91c2IvZmZzLWFpby1leGFtcGxlL211bHRpYnVmZi9kZXZpY2VfYXBwL2Fpb19t
dWx0aWJ1ZmYuYwpAQCAtMjk2LDcgKzI5Niw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAJCXJldHVybiAxOwogCX0KIAotCWZvciAoaSA9IDA7IGkgPCBzaXplb2YoaW9idWYp
L3NpemVvZigqaW9idWYpOyArK2kpCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoaW9idWYp
OyArK2kpCiAJCWluaXRfYnVmcygmaW9idWZbaV0sIEJVRlNfTUFYLCBCVUZfTEVOKTsKIAogCXdo
aWxlICgxKSB7CkBAIC0zMjQsNyArMzI0LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKIAkJICogd2hlbiB3ZSdyZSBwcmVwYXJpbmcgbmV3IGRhdGEgdG8gc3VibWl0LAogCQkg
KiBzZWNvbmQgYnVmZmVyIGJlaW5nIHRyYW5zbWl0dGVkCiAJCSAqLwotCQlmb3IgKGkgPSAwOyBp
IDwgc2l6ZW9mKGlvYnVmKS9zaXplb2YoKmlvYnVmKTsgKytpKSB7CisJCWZvciAoaSA9IDA7IGkg
PCBBUlJBWV9TSVpFKGlvYnVmKTsgKytpKSB7CiAJCQlpZiAoaW9idWZbaV0ucmVxdWVzdGVkKQog
CQkJCWNvbnRpbnVlOwogCQkJLyogcHJlcGFyZSByZXF1ZXN0cyAqLwpAQCAtMzY0LDEyICszNjQs
MTIgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAogCQkvKiBpZiBhbGwgcmVx
J3MgZnJvbSBpb2NiIGNvbXBsZXRlZCAqLwogCQlpZiAoIWlvYnVmW2FjdHVhbF0ucmVxdWVzdGVk
KQotCQkJYWN0dWFsID0gKGFjdHVhbCArIDEpJShzaXplb2YoaW9idWYpL3NpemVvZigqaW9idWYp
KTsKKwkJCWFjdHVhbCA9IChhY3R1YWwgKyAxKSUoQVJSQVlfU0laRShpb2J1ZikpOwogCX0KIAog
CS8qIGZyZWUgcmVzb3VyY2VzICovCiAKLQlmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGlvYnVmKS9z
aXplb2YoKmlvYnVmKTsgKytpKQorCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGlvYnVmKTsg
KytpKQogCQlkZWxldGVfYnVmcygmaW9idWZbaV0pOwogCWlvX2Rlc3Ryb3koY3R4KTsKIAotLSAK
Mi4yNS4xCg==
