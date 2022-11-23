Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD946356A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiKWJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiKWJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:31:15 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D2303CB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:30:12 -0800 (PST)
X-QQ-SSF: 0040000000B00050
X-QQ-FEAT: Js1xXDonPB71POLU1khepmEQeZKe3MlZu5dwceIYnExrvtsfAenUvoEGzZKhi
        XtiCfwyjamkPU7bNFJtLb5Z5MeoB1mVAp9ysWdmcaYHgY9wq08v5yxrK2AnXOmJ9HQIrxoD
        pCYD+5jlgKfIS8yjtoBf8jjcQqHfgV88+UQVV361FPHwOYTi256CWkERd1Wfp6a0hO1LqOj
        6TpN9ULuTqaiAqYvzZEtJtCEP5HrVaXsdNVUxqvn/h2r3aZOnP5F+3eNwrk1AyQHsIzSRTo
        S6jVAbouR4HRiOBn7znZx+HvJBgiW81aptdKf+U+y4VJPJsmknQBb+BdrBjfVL6CDrcu/NZ
        AjuIMUq
X-QQ-BUSINESS-ORIGIN: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.214.84
X-QQ-STYLE: 
X-QQ-mid: qywaplogic4t1669195803t823248
From:   "=?gb18030?B?zfW66bvU?=" <honghui.wang@ucas.com.cn>
To:     "=?gb18030?B?UGV0ciBNbGFkZWs=?=" <pmladek@suse.com>
Cc:     "=?gb18030?B?U2VyZ2V5IFNlbm96aGF0c2t5?=" <senozhatsky@chromium.org>,
        "=?gb18030?B?U3RldmVuIFJvc3RlZHQ=?=" <rostedt@goodmis.org>,
        "=?gb18030?B?Sm9obiBPZ25lc3M=?=" <john.ogness@linutronix.de>,
        "=?gb18030?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: =?gb18030?B?UmWjulJlOiBbUEFUQ0ggVjJdIHByaW50azogZml4?=
 =?gb18030?B?IGEgdHlwbyBvZiBjb21tZW50?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Wed, 23 Nov 2022 17:30:02 +0800
X-Priority: 3
Message-ID: <tencent_3D70D8C80B9474E67AF618B6@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 312409942
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 23 Nov 2022 17:30:04 +0800 (CST)
Feedback-ID: qywaplogic:ucas.com.cn:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmtzLA0KQmVzdCBSZWdhcmRzIQ0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBI
b25naHVpDQoNCg0KDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLdStyrzT
yrz+LS0tDQq3orz+yMs6IlBldHIgTWxhZGVrIjxwbWxhZGVrQHN1c2UuY29tPg0Kt6LLzcqx
vOQ6MjAyMsTqMTHUwjIyyNUo0MfG2rb+KSDN7cnPNzoxNg0KytW8/sjLOiJXYW5nIEhvbmdo
dWkiPGhvbmdodWkud2FuZ0B1Y2FzLmNvbS5jbj47DQrW98ziOiBbUEFUQ0ggVjJdIHByaW50
azogZml4IGEgdHlwbyBvZiBjb21tZW50DQpPbiBUICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA==

