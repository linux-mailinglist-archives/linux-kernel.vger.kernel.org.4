Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C364059A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiLBLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiLBLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:16:43 -0500
X-Greylist: delayed 88443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 03:16:37 PST
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0801D15B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:16:36 -0800 (PST)
X-QQ-SSF: 0040000000B00080
X-QQ-FEAT: dokLFQtf6Hmfz/U1KS/IYmsbTaCViGDnrcjLzsekxkL1oyBqmfyutY5FWoJgd
        f3v3V/oO4dzfSRkTGcYQeSDIQe0SkFnOgc5LR5arohcc18OH095ZWExC644IHRgIOq8fgXp
        /c18flLht6OPknABlfWnx5pVR1c4wdcfUMRPPYi7ZAnDo1Zy9gr/T1MQJKnY5A+/pKYgUv0
        jPMZ72fPW6J5IRqTPdNE0+BvOVAxPvB/+e+ubtSRSzldb1AVTFHhpeCbxsVZpSHU5r3y0JE
        PAyP2MkKfh+PU/YyABMPYfIdrbo1M1V+LyEc6KP/Gd2xR0ngivM6cwNVnmX/WgPdMqXYd/P
        p+sLB/X
X-QQ-BUSINESS-ORIGIN: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.178.174
X-QQ-STYLE: 
X-QQ-mid: qywaplogic4t1669979638t940312
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
Subject: =?gb18030?B?UmWjulJlOiBSZaO6UmU6IFtQQVRDSF0gYXJtNjQv?=
 =?gb18030?B?Ym9vdC9kdHMgYW5kIGFybV9zY3BpOiBhZGQgdG8g?=
 =?gb18030?B?c3VwcG9ydCBQaHl0aXVtIEZUMjAwNCBDUFU=?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Fri, 2 Dec 2022 19:13:58 +0800
X-Priority: 3
Message-ID: <tencent_0D838DEE0F4CB459055E19F5@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 4224319092
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 02 Dec 2022 19:13:59 +0800 (CST)
Feedback-ID: qywaplogic:ucas.com.cn:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8sIEkgZGlkbid0IHJ1biBkdGJzX2NoZWNrLg0KDQpTb3JyeSwNCg0KQmVzdCBSZWdhcmRz
IQ0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBIb25naHVpDQoNCg0KDQoNCg0KDQoN
Cg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0t1K3KvNPKvP4tLS0NCreivP7I
yzoiS3J6eXN6dG9mIEtvemxvd3NraSI8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3Jn
Pg0Kt6LLzcqxvOQ6MjAyMsTqMTLUwjLI1SjQx8bazuUpIM3tyc82OjUwDQrK1bz+yMs6Is31
uum71CI8aG9uZ2h1aS53YW5nQHVjYXMuY29tLmNuPjsiQ2F0YWxpbiBNYXJpbmFzIjxjYXRh
bGluLm1hcmluYXNAYXJtLmNvbT47IldpbGwgRGVhY29uIjx3aWxsQGtlcm5lbC5vcmc+OyJB
cm5kIEJlcmdtYW5uIjxhcm5kQGFybmRiLmRlPjsiT2xvZiBKb2hhbnNzb24iPG9sb2ZAbGl4
b20ubmV0Pjsic29jIjxzb2NAa2VybmVsLm9yZz47IlJvYiBIZXJyaW5nIjxyb2JoK2R0QGtl
cm5lbC5vcmc+OyJLcnp5c3p0b2YgS296bG93c2tpIjxrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc+OyJTdWRlZXAgSG9sbGEiPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsiQ3Jp
c3RpYW4gTWFydXNzaSI8Y3Jpc3RpYW4ubWFydXNzaUBhcm0uY29tPjsibGludXgtYXJtLWtl
cm5lbCI8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsibGludXgta2Vy
bmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsiZGV2aWNldHJlZSI8ZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0K1vfM4jogUmWjulJlOiBbUEFUQ0hdIGFybTY0L2Jv
b3QvZHRzIGFuZCBhcm1fc2NwaTogYWRkIHRvIHN1cHBvcnQgUGh5dGl1bSBGVDIwMDQgQ1BV
DQpPbiAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA==

