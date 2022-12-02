Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD364033D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiLBJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiLBJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:24:49 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C211E3;
        Fri,  2 Dec 2022 01:24:14 -0800 (PST)
X-QQ-SSF: 0040000000B00080
X-QQ-FEAT: C46Rb8GPIEeJThy4ybpU5KHg+3YJ4oOCdEdnlYvxq/hvyYyTy5yQxd9V406Mw
        31Zb8AGLr72mqVVD3cmthQqWCDAu6kZIbp3PCcwH7WQQCjUK0vJGDwY7T9W0eMQ1/+Vp+i7
        IZudxB73QwdZYVaIfi3WfF0tKtJHyA9I58fw+PvjMHkvvonF8Zuy7jyVryGIHDLQBXlNrSS
        +60de1m/4zHXEpKmPR7VJ3y63r+LUDmKa1/R329Hqr4XxI8KUr0/cypgDNcJlF5TJszSFdB
        xcSnMRBPxhUiFx8Gbizggc+lqFE2O7rXc9ckc4Zgg/oEX8gAwE6quIHVa/suA/Nid9rfFwD
        thNxdn4
X-QQ-BUSINESS-ORIGIN: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.136.163.169
X-QQ-STYLE: 
X-QQ-mid: qywaplogic4t1669973020t984265
From:   "=?gb18030?B?zfW66bvU?=" <honghui.wang@ucas.com.cn>
To:     "=?gb18030?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" 
        <krzysztof.kozlowski@linaro.org>,
        "=?gb18030?B?Q2F0YWxpbiBNYXJpbmFz?=" <catalin.marinas@arm.com>,
        "=?gb18030?B?V2lsbCBEZWFjb24=?=" <will@kernel.org>,
        "=?gb18030?B?QXJuZCBCZXJnbWFubg==?=" <arnd@arndb.de>,
        "=?gb18030?B?T2xvZiBKb2hhbnNzb24=?=" <olof@lixom.net>,
        "=?gb18030?B?c29j?=" <soc@kernel.org>,
        "=?gb18030?B?Um9iIEhlcnJpbmc=?=" <robh+dt@kernel.org>,
        "=?gb18030?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "=?gb18030?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>,
        "=?gb18030?B?Q3Jpc3RpYW4gTWFydXNzaQ==?=" <cristian.marussi@arm.com>,
        "=?gb18030?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>,
        "=?gb18030?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?gb18030?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>
Subject: =?gb18030?B?UmWjulJlOiBbUEFUQ0hdIGFybTY0L2Jvb3QvZHRz?=
 =?gb18030?B?IGFuZCBhcm1fc2NwaTogYWRkIHRvIHN1cHBvcnQg?=
 =?gb18030?B?UGh5dGl1bSBGVDIwMDQgQ1BV?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Fri, 2 Dec 2022 17:23:40 +0800
X-Priority: 3
Message-ID: <tencent_12CFBB7717187D6F2B9A3246@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 1410768324
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 02 Dec 2022 17:23:41 +0800 (CST)
Feedback-ID: qywaplogic:ucas.com.cn:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGFwcHJvYWNoIGlzIHBhc3NlZCB0aGUgdGVzdCBhbmQgdmVyaWZpY2F0aW9uIG9uIEZU
MjAwNCBERVYgYm9hcmQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBkZXRhaWxlZCBhbmFseXNp
cy4NCg0KSSdsbCB0cnkgYWdhaW4uDQoNCkJlc3QgUmVnYXJkcyENCg0KLS0tLS0tLS0tLS0t
LS0tLS0tDQpXYW5nIEhvbmdodWkNCg0KDQoNCg0KDQoNCg0KDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLS3Urcq808q8/i0tLQ0Kt6K8/sjLOiJLcnp5c3p0b2YgS296bG93
c2tpIjxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQq3osvNyrG85DoyMDIyxOox
MtTCMsjVKNDHxtrO5Skgz8LO5zQ6NTANCsrVvP7IyzoiV2FuZyBIb25naHVpIjxob25naHVp
LndhbmdAdWNhcy5jb20uY24+OyJDYXRhbGluIE1hcmluYXMiPGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tPjsiV2lsbCBEZWFjb24iPHdpbGxAa2VybmVsLm9yZz47IkFybmQgQmVyZ21hbm4i
PGFybmRAYXJuZGIuZGU+OyJPbG9mIEpvaGFuc3NvbiI8b2xvZkBsaXhvbS5uZXQ+OyJzb2Mi
PHNvY0BrZXJuZWwub3JnPjsiUm9iIEhlcnJpbmciPHJvYmgrZHRAa2VybmVsLm9yZz47Ikty
enlzenRvZiBLb3psb3dza2kiPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47
IlN1ZGVlcCBIb2xsYSI8c3VkZWVwLmhvbGxhQGFybS5jb20+OyJDcmlzdGlhbiBNYXJ1c3Np
IjxjcmlzdGlhbi5tYXJ1c3NpQGFybS5jb20+OyJsaW51eC1hcm0ta2VybmVsIjxsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyJsaW51eC1rZXJuZWwiPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyJkZXZpY2V0cmVlIjxkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZz47DQrW98ziOiBbUEFUQ0hdIGFybTY0L2Jvb3QvZHRzIGFuZCBhcm1fc2NwaTog
YWRkIHRvIHN1cHBvcnQgUGh5dGl1bSBGVDIwMDQgQ1BVDQpPbiAwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA==

