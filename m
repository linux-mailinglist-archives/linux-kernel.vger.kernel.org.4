Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA45637B52
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKXOUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiKXOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:19:51 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E0510AD03
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:18:30 -0800 (PST)
X-QQ-SSF: 0040000000B00070
X-QQ-FEAT: ojreUey1GAK4oogU4sE6j+ohEnpOLUPBKejjYhsF620HkKx9h2vg7qw9dRN/a
        kTHt5ahFgDCVsKt8Wc2zKUobZpvIEgyixIcyduPPFghBh3lZsuPOhg89/lw6p3NmMfS9GxM
        B2IE3Tyz8DveddZjXwOxix6Uh4Yw25ffEgEaLkZR9t6qhDDVCi3O5lpqD/P6PDsQkqOj0vL
        /1G9wqw1aKe5gtQ/jFuiKuqcf81evF5Rt8zvCSHrxSFBfF+Qp2oIyLh3i8umyLhXFIdqS79
        vUBYK5G4EsE1GNJVETPkQKfi6/kST/7DiQixsFGVtsbNoMPLCrsojfkZ0Nz0zlJfjV3o0Ss
        XiS4khJ
X-QQ-BUSINESS-ORIGIN: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.214.84
X-QQ-STYLE: 
X-QQ-mid: qywaplogic4t1669299457t466664
From:   "=?gb18030?B?zfW66bvU?=" <honghui.wang@ucas.com.cn>
To:     "=?gb18030?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>
Cc:     "=?gb18030?B?TWFyayBSdXRsYW5k?=" <mark.rutland@arm.com>,
        "=?gb18030?B?Q3Jpc3RpYW4gTWFydXNz?=" <cristian.marussi@arm.com>,
        "=?gb18030?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>,
        "=?gb18030?B?SmFzc2kgQnJhcg==?=" <jassisinghbrar@gmail.com>,
        "=?gb18030?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>,
        "=?gb18030?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: =?gb18030?B?UmWjulJlOiBbUEFUQ0ggMy8zXSBhcm1fc2NwaTog?=
 =?gb18030?B?bW9kaWZ5IHRvIHN1cHBvcnQgYWNwaQ==?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Thu, 24 Nov 2022 22:17:36 +0800
X-Priority: 3
Message-ID: <tencent_3D435BAB4430B7F532CF2ADD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 610654200
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 24 Nov 2022 22:17:38 +0800 (CST)
Feedback-ID: qywaplogic:ucas.com.cn:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIQ0KDQpUaGUgdWVmaSBmaXJtd2FyZSB3YXMgYnVpbHQgaW5jbHVkZSBBQ1BJL0FN
TCwgYnV0IGN1cnJlbnQga2VybmVsIGNvZGUgaXMgbm90IGFibGUgdG8gZXh0cmFjdCB0aGUg
aW5mbywgdGhlIEFDUEkvQU1MIGRyaXZlciBvZiBrZXJuZWwgaXMgbm90IGVub3VnaCBmb3Ig
bWFqb3JpdHkgb2YgIGRldmljZXMgLCBidXQgZmR0IGRyaXZlciBpcy4gSSB0aGluayB0aGVy
ZSdzIGEgbG90IG9mIHdvcmsgdG8gc3VwcG9ydCBtb3JlIGFjcGkgZHJpdmVyLg0KDQpCZXN0
IFJlZ2FyZHMhDQoNCldhbmcgSG9uZ2h1aQ0KDQoNCg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0t1K3KvNPKvP4tLS0NCreivP7IyzoiU3VkZWVwIEhvbGxhIjxzdWRlZXAu
aG9sbGFAYXJtLmNvbT4NCreiy83KsbzkOjIwMjLE6jEx1MIyNMjVKNDHxtrLxCkgze3Jzzk6
NDYNCsrVvP7IyzoizfW66bvUIjxob25naHVpLndhbmdAdWNhcy5jb20uY24+Ow0K1vfM4jog
W1BBVENIIDMvM10gYXJtX3NjcGk6IG1vZGlmeSB0byBzdXBwb3J0IGFjcGkNCk9uIFQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAg

