Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDA620F73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiKHLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKHLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:48:54 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A7B55BA;
        Tue,  8 Nov 2022 03:48:53 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Tue, 8 Nov 2022
 19:43:54 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Tue, 8 Nov 2022 19:43:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wentland <harry.wentland@amd.com>, Li <sunpeng.li@amd.com>,
        Siqueira <Rodrigo.Siqueira@amd.com>,
        Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Airlie <airlied@gmail.com>,
        Vetter <daniel@ffwll.ch>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] ACPICA: Fix return
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7ce6bd54.f8.184570dd1b6.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+H6QGpj7csBAA--.64W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfAAAsm
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

cmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCgpT
aWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJp
dmVycy9hY3BpL2FjcGljYS9ldnNjaS5jICAgICAgICAgICAgICAgICAgICAgfCAxMiArKysrKy0t
LS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jIHwg
MTcgKysrKysrKy0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9ldnNjaS5j
IGIvZHJpdmVycy9hY3BpL2FjcGljYS9ldnNjaS5jCmluZGV4IDM5MTVmZjYxNDEyYi4uNjNkZDJh
YTJkMTZhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2V2c2NpLmMKKysrIGIvZHJp
dmVycy9hY3BpL2FjcGljYS9ldnNjaS5jCkBAIC0zOCw5ICszOCw4IEBAIHUzMiBhY3BpX2V2X3Nj
aV9kaXNwYXRjaCh2b2lkKQogCiAJLyogQXJlIHRoZXJlIGFueSBob3N0LWluc3RhbGxlZCBTQ0kg
aGFuZGxlcnM/ICovCiAKLQlpZiAoIWFjcGlfZ2JsX3NjaV9oYW5kbGVyX2xpc3QpIHsKLQkJcmV0
dXJuIChpbnRfc3RhdHVzKTsKLQl9CisJaWYgKCFhY3BpX2dibF9zY2lfaGFuZGxlcl9saXN0KQor
CQlyZXR1cm4gaW50X3N0YXR1czsKIAogCWZsYWdzID0gYWNwaV9vc19hY3F1aXJlX2xvY2soYWNw
aV9nYmxfZ3BlX2xvY2spOwogCkBAIC01Nyw3ICs1Niw3IEBAIHUzMiBhY3BpX2V2X3NjaV9kaXNw
YXRjaCh2b2lkKQogCX0KIAogCWFjcGlfb3NfcmVsZWFzZV9sb2NrKGFjcGlfZ2JsX2dwZV9sb2Nr
LCBmbGFncyk7Ci0JcmV0dXJuIChpbnRfc3RhdHVzKTsKKwlyZXR1cm4gaW50X3N0YXR1czsKIH0K
IAogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKQEAgLTE5Myw5ICsxOTIsOCBAQCBhY3BpX3N0YXR1
cyBhY3BpX2V2X3JlbW92ZV9hbGxfc2NpX2hhbmRsZXJzKHZvaWQpCiAJICAgIGFjcGlfb3NfcmVt
b3ZlX2ludGVycnVwdF9oYW5kbGVyKCh1MzIpIGFjcGlfZ2JsX0ZBRFQuc2NpX2ludGVycnVwdCwK
IAkJCQkJICAgICBhY3BpX2V2X3NjaV94cnVwdF9oYW5kbGVyKTsKIAotCWlmICghYWNwaV9nYmxf
c2NpX2hhbmRsZXJfbGlzdCkgewotCQlyZXR1cm4gKHN0YXR1cyk7Ci0JfQorCWlmICghYWNwaV9n
Ymxfc2NpX2hhbmRsZXJfbGlzdCkKKwkJcmV0dXJuIHN0YXR1czsKIAogCWZsYWdzID0gYWNwaV9v
c19hY3F1aXJlX2xvY2soYWNwaV9nYmxfZ3BlX2xvY2spOwogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jCmluZGV4IDM4ZDcxYjVjMWYyZC4uNjY2
NjFhMjAxMTdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19zdHJlYW0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19zdHJlYW0uYwpAQCAtMjksNyArMjksNiBAQAogI2luY2x1ZGUgImNvcmVfdHlwZXMuaCIKICNp
bmNsdWRlICJyZXNvdXJjZS5oIgogI2luY2x1ZGUgImlwcC5oIgotI2luY2x1ZGUgInRpbWluZ19n
ZW5lcmF0b3IuaCIKICNpbmNsdWRlICJkY19kbXViX3Nydi5oIgogCiAjZGVmaW5lIERDX0xPR0dF
UiBkYy0+Y3R4LT5sb2dnZXIKQEAgLTE1Miw5ICsxNTEsOCBAQCBzdGF0aWMgdm9pZCBkY19zdHJl
YW1fZnJlZShzdHJ1Y3Qga3JlZiAqa3JlZikKIAogdm9pZCBkY19zdHJlYW1fcmVsZWFzZShzdHJ1
Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0pCiB7Ci0JaWYgKHN0cmVhbSAhPSBOVUxMKSB7CisJ
aWYgKHN0cmVhbSAhPSBOVUxMKQogCQlrcmVmX3B1dCgmc3RyZWFtLT5yZWZjb3VudCwgZGNfc3Ry
ZWFtX2ZyZWUpOwotCX0KIH0KIAogc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqZGNfY3JlYXRlX3N0
cmVhbV9mb3Jfc2luaygKQEAgLTMxNiwxMSArMzE0LDExIEBAIGJvb2wgZGNfc3RyZWFtX3NldF9j
dXJzb3JfYXR0cmlidXRlcygKIAlzdHJ1Y3QgZGMgICpkYzsKIAlib29sIHJlc2V0X2lkbGVfb3B0
aW1pemF0aW9ucyA9IGZhbHNlOwogCi0JaWYgKE5VTEwgPT0gc3RyZWFtKSB7CisJaWYgKHN0cmVh
bSA9PSBOVUxMKSB7CiAJCWRtX2Vycm9yKCJEQzogZGNfc3RyZWFtIGlzIE5VTEwhXG4iKTsKIAkJ
cmV0dXJuIGZhbHNlOwogCX0KLQlpZiAoTlVMTCA9PSBhdHRyaWJ1dGVzKSB7CisJaWYgKGF0dHJp
YnV0ZXMgPT0gTlVMTCkgewogCQlkbV9lcnJvcigiREM6IGF0dHJpYnV0ZXMgaXMgTlVMTCFcbiIp
OwogCQlyZXR1cm4gZmFsc2U7CiAJfQpAQCAtMzk5LDEyICszOTcsMTIgQEAgYm9vbCBkY19zdHJl
YW1fc2V0X2N1cnNvcl9wb3NpdGlvbigKIAlzdHJ1Y3QgZGMgICpkYyA9IHN0cmVhbS0+Y3R4LT5k
YzsKIAlib29sIHJlc2V0X2lkbGVfb3B0aW1pemF0aW9ucyA9IGZhbHNlOwogCi0JaWYgKE5VTEwg
PT0gc3RyZWFtKSB7CisJaWYgKHN0cmVhbSA9PSBOVUxMKSB7CiAJCWRtX2Vycm9yKCJEQzogZGNf
c3RyZWFtIGlzIE5VTEwhXG4iKTsKIAkJcmV0dXJuIGZhbHNlOwogCX0KIAotCWlmIChOVUxMID09
IHBvc2l0aW9uKSB7CisJaWYgKHBvc2l0aW9uID09IE5VTEwpIHsKIAkJZG1fZXJyb3IoIkRDOiBj
dXJzb3IgcG9zaXRpb24gaXMgTlVMTCFcbiIpOwogCQlyZXR1cm4gZmFsc2U7CiAJfQpAQCAtNDY4
LDkgKzQ2Niw4IEBAIGJvb2wgZGNfc3RyZWFtX2FkZF93cml0ZWJhY2soc3RydWN0IGRjICpkYywK
IAkJfQogCX0KIAotCWlmICghaXNEcmMpIHsKKwlpZiAoIWlzRHJjKQogCQlzdHJlYW0tPndyaXRl
YmFja19pbmZvW3N0cmVhbS0+bnVtX3diX2luZm8rK10gPSAqd2JfaW5mbzsKLQl9CiAKIAlpZiAo
ZGMtPmh3c3MuZW5hYmxlX3dyaXRlYmFjaykgewogCQlzdHJ1Y3QgZGNfc3RyZWFtX3N0YXR1cyAq
c3RyZWFtX3N0YXR1cyA9IGRjX3N0cmVhbV9nZXRfc3RhdHVzKHN0cmVhbSk7CkBAIC01MjYsNyAr
NTIzLDcgQEAgYm9vbCBkY19zdHJlYW1fcmVtb3ZlX3dyaXRlYmFjayhzdHJ1Y3QgZGMgKmRjLAog
CS8qIHJlbW92ZSB3cml0ZWJhY2sgaW5mbyBmb3IgZGlzYWJsZWQgd3JpdGViYWNrIHBpcGVzIGZy
b20gc3RyZWFtICovCiAJZm9yIChpID0gMCwgaiA9IDA7IGkgPCBzdHJlYW0tPm51bV93Yl9pbmZv
OyBpKyspIHsKIAkJaWYgKHN0cmVhbS0+d3JpdGViYWNrX2luZm9baV0ud2JfZW5hYmxlZCkgewot
CQkJaWYgKGogPCBpKQorCQkJaWYgKGkgIT0gaikKIAkJCQkvKiB0cmltIHRoZSBhcnJheSAqLwog
CQkJCXN0cmVhbS0+d3JpdGViYWNrX2luZm9bal0gPSBzdHJlYW0tPndyaXRlYmFja19pbmZvW2ld
OwogCQkJaisrOwotLSAKMi4zNi4xCg==
