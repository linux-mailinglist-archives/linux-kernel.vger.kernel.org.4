Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1961E28D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKFOVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:21:00 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E63FAE60;
        Sun,  6 Nov 2022 06:20:59 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 22:16:08 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 22:16:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     deller@gmx.de, arnd@arndb.de, b.zolnierkie@samsung.com,
        robert.jarzmik@free.fr, ulf.hansson@linaro.org, wangqing@vivo.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: pxafb: Remove unnecessary print function
 dev_err()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <278d64e0.bd.1844d4c7a95.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+KowWdjLosBAA--.51W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CxgAEsf
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

RWxpbWluYXRlIHRoZSBmb2xsb3cgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9kcml2ZXJzL3ZpZGVv
L2ZiZGV2L3B4YWZiLmM6MjMzMDoyLTk6IGxpbmUgMjMzMCBpcyByZWR1bmRhbnQgYmVjYXVzZQpw
bGF0Zm9ybV9nZXRfaXJxKCkgYWxyZWFkeSBwcmludHMgYW4gZXJyb3IKClNpZ25lZC1vZmYtYnk6
IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3ZpZGVvL2Zi
ZGV2L3B4YWZiLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9weGFmYi5jIGIvZHJpdmVycy92aWRlby9mYmRldi9w
eGFmYi5jCmluZGV4IDY5NmFjNTQzMTE4MC4uYzQ2ZWQ3ODI5OGFlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L3B4YWZiLmMKKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9weGFmYi5j
CkBAIC0yMzI3LDcgKzIzMjcsNiBAQCBzdGF0aWMgaW50IHB4YWZiX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKmRldikKIAogCWlycSA9IHBsYXRmb3JtX2dldF9pcnEoZGV2LCAwKTsKIAlp
ZiAoaXJxIDwgMCkgewotCQlkZXZfZXJyKCZkZXYtPmRldiwgIm5vIElSUSBkZWZpbmVkXG4iKTsK
IAkJcmV0ID0gLUVOT0RFVjsKIAkJZ290byBmYWlsZWRfZnJlZV9tZW07CiAJfQotLSAKMi4yNS4x
Cg==
