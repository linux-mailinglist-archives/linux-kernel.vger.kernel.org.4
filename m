Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB86C0B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCTHge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCTHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:36:31 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A694BB757
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=JPAOou1ZxwqG71rwkeXV6OnEVlQyJNiffXwBInLe4eM=; b=f
        W1GDB94oKSKxgYDnHl1onPJxyQjy54WAAIyODgRJzN3vHtlhdP6yOnCEYzHp4QMk
        9LiUdSFuec7uQdqIP4mOzOAO97ofP6BdjVzTfIc8xAAeuWjjsI0Tt84NoS5Ttm/Q
        Jph+yJTOxLs8GxhiF6fCiliRx/PaETZPMc4dlPkpCk=
Received: from 00107082$163.com ( [222.64.154.91] ) by ajax-webmail-wmsvr88
 (Coremail) ; Mon, 20 Mar 2023 15:36:16 +0800 (CST)
X-Originating-IP: [222.64.154.91]
Date:   Mon, 20 Mar 2023 15:36:16 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: [Debian Package]Regression 6.3-rc3: version is empty  for
 linux-headers installation dir
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuycC/6SuE8s4CWfbOkXn0oTju85XMCzuv8j3YJeN500oyrM/CEAX3B/Nkv0wtq/ERuzvxeyVCdK9M51WY1DUIkeh3LD6ivhaQ7BRoeoZUcr
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <33233f0e.3970.186fdf28bc7.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wA3eaXwDBhkX50UAA--.2313W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTBA4qmI0X6xdZwAAsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBtYWtlIGEgY2xlYW4gYnVpbGQgZm9yIGRlYmlhbiBwYWNrYWdlcywgd2l0aCA2LjMtcmMz
LCB0aGVyZSBpcyBubyB2ZXJzaW9uIGluZm9ybWF0aW9uIGluIHRoZSBuYW1lIG9mIGxpbnV4LWhl
YWRlcnMgZGlyLCB0aGUgbGludXgtaGVhZGVycyBwYWNrYWdlIHdvdWxkIGluc3RhbGwgaW50byAi
L3Vzci9zcmMvbGludXgtaGVhZGVycy0iLgoKVGhpcyBpcyBjYXVzZWQgYnkgMzY4NjJlMTRlMzE2
MTFmOTc4NjYyMmRiMzY2MzI3MjA5YTdhZWRlNyB3aGljaCByZW1vdmUgdGhlIGRlZmluaXRpb24g
Zm9yICJ2ZXJzaW9uIiBpbiBzY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKCmRpZmYgLS1naXQgYS9z
Y3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIgYi9zY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKaW5kZXgg
OTA2ODg5YjMwNGE0Li5jNWFlNTcxNjdkN2MgMTAwNzU1Ci0tLSBhL3NjcmlwdHMvcGFja2FnZS9i
dWlsZGRlYgorKysgYi9zY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKLi4uCiAKLXZlcnNpb249JEtF
Uk5FTFJFTEVBU0UKLS0KCgpCdXQgdGhlIHZhcmlhYmxlIGlzIG5lZWQgZm9yIGJ1aWxkaW5nIGxp
bnV4LWhlYWRlcnM6CnNjcmlwdHMvcGFja2FnZS9idWlsZGRlYgoxODggICAgIGRlc3RkaXI9JHBk
aXIvdXNyL3NyYy9saW51eC1oZWFkZXJzLSR2ZXJzaW9uCjE4OSAgICAgbWtkaXIgLXAgJGRlc3Rk
aXIKCgpUaGlzIGNvdWxkIGJlIGZpeGVkIGJ5IGFkZGluZyBiYWNrIHRoZSBkZWZpbml0aW9uIGZv
ciB2ZXJzaW9uCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9wYWNrYWdlL2J1aWxkZGViIGIvc2NyaXB0
cy9wYWNrYWdlL2J1aWxkZGViCmluZGV4IGM1YWU1NzE2N2Q3Yy4uMTg3MGIyNDg1MjE3IDEwMDc1
NQotLS0gYS9zY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKKysrIGIvc2NyaXB0cy9wYWNrYWdlL2J1
aWxkZGViCkBAIC0yMTYsNiArMjE2LDcgQEAgaW5zdGFsbF9saWJjX2hlYWRlcnMgKCkgewogcm0g
LWYgZGViaWFuL2ZpbGVzCiAKIHBhY2thZ2VzX2VuYWJsZWQ9JChkaF9saXN0cGFja2FnZXMpCit2
ZXJzaW9uPSRLRVJORUxSRUxFQVNFCiAKIGZvciBwYWNrYWdlIGluICR7cGFja2FnZXNfZW5hYmxl
ZH0KIGRvCi0tCgoKCkRhdnVkCg==
