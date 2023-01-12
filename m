Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B318666EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjALJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjALJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:48:08 -0500
X-Greylist: delayed 1815 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 01:44:22 PST
Received: from m13101.mail.163.com (m13101.mail.163.com [220.181.13.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1661D50F69
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=DTlVCsACkosA40+UL2Cx6wAyr3jb/5hrs9h8dtBq4zQ=; b=S
        eXzUe0/A272UqsCwHkxmAGfkGhuURi66SR5bhMhoraqFf+pc9Mq6lMLxxdxme2G4
        Z+HV082yF6nIv5o/vZUJMcWgbWA4cEoCfdUGXYo5xZ5lc2ix+Yv319P/teE75Txl
        lu6/V83hjd0wpEVpshgqnz7z1XtKwy1IRcrPixp7oc=
Received: from slark_xiao$163.com ( [43.134.191.38] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Thu, 12 Jan 2023 16:58:37 +0800 (CST)
X-Originating-IP: [43.134.191.38]
Date:   Thu, 12 Jan 2023 16:58:37 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     mani@kernel.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] bus: mhi: host: Update mhi driver description
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20221229011358.15874-1-slark_xiao@163.com>
References: <20221229011358.15874-1-slark_xiao@163.com>
X-NTES-SC: AL_QuycAfmavEEq4SKQYOkXmE8bgOg9UcK3vPgv3YdfP5k0vSv29zIZTEB9A0rSzcOrGRi0jye0SRZV6MV5fbJoWaOU2vUm+PEhCtG1pmq9EN9V
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b95162c.5aa8.185a533db68.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowAAXMQG9y79jBN0AAA--.4330W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiNRXzZGI0bAGcOgACso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFuaSwKTm8gcmVzcG9uc2Ugb2Ygc2VuZGluZyBlbWFpbCB0byBtYW5pQGtlcm5lbC5vcmcu
IFRoaXMgZW1haWwgYWRkcmVzcwp3YXMgZ2VuZXJhdGVkIGJ5IHNjcmlwdHMvZ2V0X21haW50YWlu
ZXIucGwuCgpBdCAyMDIyLTEyLTI5IDA5OjEzOjU4LCAiU2xhcmsgWGlhbyIgPHNsYXJrX3hpYW9A
MTYzLmNvbT4gd3JvdGU6Cj5UaGlzIHNob3VsZCBiZSBhIG1pc3Rha2UuIE1ISSBjb250YWlucyAi
SG9zdCBJbnRlcmZhY2UiCj5hbHJlYWR5LiBTbyB3ZSBzaGFsbCB1cGRhdGUgIk1ISSIgdG8gIk1v
ZGVtIiBhbmQgdGhlIGZ1bGwKPm5hbWUgc2hhbGwgYmUgIk1vZGVtIEhvc3QgSW50ZXJmYWNlIi4K
Pgo+U2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+LS0tCj4g
ZHJpdmVycy9idXMvbWhpL2hvc3QvaW5pdC5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvbWhp
L2hvc3QvaW5pdC5jIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvaW5pdC5jCj5pbmRleCBiZjY3MmRl
MzUxMzEuLjczMDczMzVjNGZkMSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L2lu
aXQuYwo+KysrIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvaW5pdC5jCj5AQCAtMTQ0OSw0ICsxNDQ5
LDQgQEAgcG9zdGNvcmVfaW5pdGNhbGwobWhpX2luaXQpOwo+IG1vZHVsZV9leGl0KG1oaV9leGl0
KTsKPiAKPiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Cj4tTU9EVUxFX0RFU0NSSVBUSU9OKCJN
SEkgSG9zdCBJbnRlcmZhY2UiKTsKPitNT0RVTEVfREVTQ1JJUFRJT04oIk1vZGVtIEhvc3QgSW50
ZXJmYWNlIik7Cj4tLSAKPjIuMTcuMQo=
