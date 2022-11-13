Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D0626EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiKMJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiKMJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:18:47 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E7D312A8B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 01:18:37 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:13:04 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:13:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Julia.Lawall@inria.fr, joel@jms.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xmon: Fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6432107b.12b.1847043884e.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+EhtXBjzBkDAA--.79W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwALsu
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKYXJjaC9wb3dlcnBjL3htb24v
cHBjLW9wYy5jOjk1Nzo2Ny02ODogV0FSTklORzogVXNlIEFSUkFZX1NJWkUKYXJjaC9wb3dlcnBj
L3htb24vcHBjLW9wYy5jOjcyODA6MjQtMjU6IFdBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCmFyY2gv
cG93ZXJwYy94bW9uL3BwYy1vcGMuYzo2OTcyOjI1LTI2OiBXQVJOSU5HOiBVc2UgQVJSQVlfU0la
RQphcmNoL3Bvd2VycGMveG1vbi9wcGMtb3BjLmM6NzIxMToyMS0yMjogV0FSTklORzogVXNlIEFS
UkFZX1NJWkUKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5j
bj4KLS0tCiBhcmNoL3Bvd2VycGMveG1vbi9wcGMtb3BjLmMgfCAxMyArKysrLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvcG93ZXJwYy94bW9uL3BwYy1vcGMuYyBiL2FyY2gvcG93ZXJwYy94bW9uL3BwYy1v
cGMuYwppbmRleCAwNzc0ZDcxMTQ1M2UuLmFkNjRjMjcwOTc1NyAxMDA2NDQKLS0tIGEvYXJjaC9w
b3dlcnBjL3htb24vcHBjLW9wYy5jCisrKyBiL2FyY2gvcG93ZXJwYy94bW9uL3BwYy1vcGMuYwpA
QCAtOTU0LDkgKzk1NCw3IEBAIGNvbnN0IHN0cnVjdCBwb3dlcnBjX29wZXJhbmQgcG93ZXJwY19v
cGVyYW5kc1tdID0KICAgeyAweGZmLCAxMSwgTlVMTCwgTlVMTCwgUFBDX09QRVJBTkRfU0lHTk9Q
VCB9LAogfTsKIAotY29uc3QgdW5zaWduZWQgaW50IG51bV9wb3dlcnBjX29wZXJhbmRzID0gKHNp
emVvZiAocG93ZXJwY19vcGVyYW5kcykKLQkJCQkJICAgLyBzaXplb2YgKHBvd2VycGNfb3BlcmFu
ZHNbMF0pKTsKLQorY29uc3QgdW5zaWduZWQgaW50IG51bV9wb3dlcnBjX29wZXJhbmRzID0gQVJS
QVlfU0laRShwb3dlcnBjX29wZXJhbmRzKTsKIC8qIFRoZSBmdW5jdGlvbnMgdXNlZCB0byBpbnNl
cnQgYW5kIGV4dHJhY3QgY29tcGxpY2F0ZWQgb3BlcmFuZHMuICAqLwogCiAvKiBUaGUgQVJYLCBB
UlksIFJYIGFuZCBSWSBvcGVyYW5kcyBhcmUgYWx0ZXJuYXRlIGVuY29kaW5ncyBvZiBHUFJzLiAg
Ki8KQEAgLTY5NjgsOCArNjk2Niw3IEBAIGNvbnN0IHN0cnVjdCBwb3dlcnBjX29wY29kZSBwb3dl
cnBjX29wY29kZXNbXSA9IHsKIHsiZmNmaWR1LiIsCVhSQyg2Myw5NzQsMSksCVhSQV9NQVNLLCBQ
T1dFUjd8UFBDQTIsCVBQQ1ZMRSwJCXtGUlQsIEZSQn19LAogfTsKIAotY29uc3QgaW50IHBvd2Vy
cGNfbnVtX29wY29kZXMgPQotICBzaXplb2YgKHBvd2VycGNfb3Bjb2RlcykgLyBzaXplb2YgKHBv
d2VycGNfb3Bjb2Rlc1swXSk7Citjb25zdCBpbnQgcG93ZXJwY19udW1fb3Bjb2RlcyA9IEFSUkFZ
X1NJWkUocG93ZXJwY19vcGNvZGVzKTsKIAwKIC8qIFRoZSBWTEUgb3Bjb2RlIHRhYmxlLgogCkBA
IC03MjA3LDggKzcyMDQsNyBAQCBjb25zdCBzdHJ1Y3QgcG93ZXJwY19vcGNvZGUgdmxlX29wY29k
ZXNbXSA9IHsKIHsic2VfYmwiLAlCRDgoNTgsMCwxKSwJQkQ4X01BU0ssCVBQQ1ZMRSwJMCwJCXtC
OH19LAogfTsKIAotY29uc3QgaW50IHZsZV9udW1fb3Bjb2RlcyA9Ci0gIHNpemVvZiAodmxlX29w
Y29kZXMpIC8gc2l6ZW9mICh2bGVfb3Bjb2Rlc1swXSk7Citjb25zdCBpbnQgdmxlX251bV9vcGNv
ZGVzID0gQVJSQVlfU0laRSh2bGVfb3Bjb2Rlcyk7CiAMCiAvKiBUaGUgbWFjcm8gdGFibGUuICBU
aGlzIGlzIG9ubHkgdXNlZCBieSB0aGUgYXNzZW1ibGVyLiAgKi8KIApAQCAtNzI3Niw1ICs3Mjcy
LDQgQEAgY29uc3Qgc3RydWN0IHBvd2VycGNfbWFjcm8gcG93ZXJwY19tYWNyb3NbXSA9IHsKIHsi
ZV9jbHJsc2x3aSIsNCwgUFBDVkxFLCAiZV9ybHdpbm0gJTAsJTEsJTMsKCUyKS0oJTMpLDMxLSgl
MykifSwKIH07CiAKLWNvbnN0IGludCBwb3dlcnBjX251bV9tYWNyb3MgPQotICBzaXplb2YgKHBv
d2VycGNfbWFjcm9zKSAvIHNpemVvZiAocG93ZXJwY19tYWNyb3NbMF0pOworY29uc3QgaW50IHBv
d2VycGNfbnVtX21hY3JvcyA9IEFSUkFZX1NJWkUocG93ZXJwY19tYWNyb3MpOwotLSAKMi4yNS4x
Cg==
