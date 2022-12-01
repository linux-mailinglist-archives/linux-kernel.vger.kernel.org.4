Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55363EE4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiLAKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLAKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:43:42 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067A391CE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:43:37 -0800 (PST)
X-QQ-SSF: 0040000000B00080
X-QQ-FEAT: swyrzWPvyR1hxYimos3aa4wAQ6Y6GGBIn+Gvpq5o5E62QtXsPCOLct3sjSq2K
        WuLwx080D4oXtx08dhJftDMCOuYwT7kjfXGyYAgvrH74ddb4L08RLCp5HWxN9IgH1yjFTi+
        Q9kxUXHislUZQ0r/F7om3NTB+J+6RGs3YSM2lDvQwPCaE0TP4daYwokCvQL9xceI3yTB+mh
        F6szpD8jUt/JtpRIVQPfGnIoHATJUSjBnRsQGTX54sq3nBTeMdjsz7PqKI8o4IWA8eBbwHF
        9f3UjAYRIADwSOdpH24l+9KMcf3eOadY3GD2OBY3pIU+9n/qqhq3nY9azsy55jN8Q4CjFSp
        AI1WI67
X-QQ-BUSINESS-ORIGIN: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.178.174
X-QQ-STYLE: 
X-QQ-mid: qywaplogic4t1669891306t403568
From:   "=?gb18030?B?zfW66bvU?=" <honghui.wang@ucas.com.cn>
To:     "=?gb18030?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>
Cc:     "=?gb18030?B?Q3Jpc3RpYW4gTWFydXNzaQ==?=" <cristian.marussi@arm.com>,
        "=?gb18030?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>,
        "=?gb18030?B?SmFzc2kgQnJhcg==?=" <jassisinghbrar@gmail.com>,
        "=?gb18030?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?gb18030?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>
Subject: =?gb18030?B?UmWjulJlOiBbUEFUQ0hdbWFpbGJveC9hcm1fc2Nw?=
 =?gb18030?B?aTogQWRkIHRvIHN1cHBvcnQgUGh5dGl1bSBGVDIw?=
 =?gb18030?B?MDAvNCBDUFVzLCBzaG93IHRlbXBlcmF0dXJlIG9m?=
 =?gb18030?B?IGNwdS4=?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Thu, 1 Dec 2022 18:41:46 +0800
X-Priority: 3
Message-ID: <tencent_2F6BF4F403D4DD764FD3D0BF@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 842504449
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 01 Dec 2022 18:41:47 +0800 (CST)
Feedback-ID: qywaplogic:ucas.com.cn:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gRFRTIG9mIEZUMjAwMC80IHBhc3NlZCBmcm9tIHVib290LiBBZGQgdGhlIERUUyBmaWxl
IHRvIGtlcm5lbD8NCg0KT2YgY291cnNlLCBpdCdzIGFsc28gYSBnb29kIHdheSB0byBtb2Rp
ZnkgRFRTIGZpbGUgYnVpbHQgaW4gdWJvb3QuDQoNClRoYW5rcywNCg0KQmVzdCBSZWdhcmRz
IQ0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBIb25naHVpDQoNCg0KDQoNCg0KDQoN
Cg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0t1K3KvNPKvP4tLS0NCreivP7I
yzoiU3VkZWVwIEhvbGxhIjxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCreiy83KsbzkOjIwMjLE
6jEy1MIxyNUo0MfG2svEKSDN7cnPNjoyNQ0KytW8/sjLOiJXYW5nIEhvbmdodWkiPGhvbmdo
dWkud2FuZ0B1Y2FzLmNvbS5jbj47DQrW98ziOiBbUEFUQ0hdbWFpbGJveC9hcm1fc2NwaTog
QWRkIHRvIHN1cHBvcnQgUGh5dGl1bSBGVDIwMDAvNCBDUFVzLCBzaG93IHRlbXBlcmF0dXJl
IG9mIGNwdS4NCk9uIFQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg

