Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152E861E2E3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKFPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:16:02 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A4DBF5A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:16:01 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 23:11:12 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 23:11:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     linux-kernel@vger.kernel.org
Subject:  [PATCH] recordmcount: Fix warning comparing pointer to 0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <10ee62bd.c2.1844d7ee28a.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+GQzmdj9IsBAA--.50W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CzgADsQ
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKc2NyaXB0cy9yZWNvcmRtY291
bnQuYzoxNDI6MTMtMTQ6IFdBUk5JTkcgY29tcGFyaW5nIHBvaW50ZXIgdG8gMC4KClNpZ25lZC1v
ZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBzY3JpcHRzL3Jl
Y29yZG1jb3VudC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9yZWNvcmRtY291bnQuYyBiL3NjcmlwdHMv
cmVjb3JkbWNvdW50LmMKaW5kZXggY2NlMTJlMTk3MWQ4Li43NTBmNTE5NjYwOGMgMTAwNjQ0Ci0t
LSBhL3NjcmlwdHMvcmVjb3JkbWNvdW50LmMKKysrIGIvc2NyaXB0cy9yZWNvcmRtY291bnQuYwpA
QCAtMTM5LDcgKzEzOSw3IEBAIHN0YXRpYyBzc2l6ZV90IHV3cml0ZSh2b2lkIGNvbnN0ICpjb25z
dCBidWYsIHNpemVfdCBjb25zdCBjb3VudCkKIHN0YXRpYyB2b2lkICogdW1hbGxvYyhzaXplX3Qg
c2l6ZSkKIHsKIAl2b2lkICpjb25zdCBhZGRyID0gbWFsbG9jKHNpemUpOwotCWlmIChhZGRyID09
IDApIHsKKwlpZiAoYWRkcikgewogCQlmcHJpbnRmKHN0ZGVyciwgIm1hbGxvYyBmYWlsZWQ6ICV6
dSBieXRlc1xuIiwgc2l6ZSk7CiAJCWZpbGVfYXBwZW5kX2NsZWFudXAoKTsKIAkJbW1hcF9jbGVh
bnVwKCk7Ci0tIAoyLjI1LjEK
