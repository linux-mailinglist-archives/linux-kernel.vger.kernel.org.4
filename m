Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D56FD9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjEJIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjEJIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:49:28 -0400
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65F5C1BEA;
        Wed, 10 May 2023 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=laBzUBuY99rTCcA9sQMQ+5Qw29Kos5L9LHYh4Tc7P+c=; b=E
        ieJRNE46xy03YCPlYyzc/vDmCWR+vQMfxLqtUM/9f93Or9gup74tDKDg+xwCg7Si
        KEXVEvkH0J3+2DpfHIz3t3bqNar3jiyHrMuhW2WZxAcSPngQQqnrTGb+kZ4Op4rg
        wXBQI0k9dX47xEJWMeQjxTvz+D7dsVhkdzVEOhcR5s=
Received: from wangyouwan$126.com ( [103.163.180.46] ) by
 ajax-webmail-wmsvr64 (Coremail) ; Wed, 10 May 2023 16:48:07 +0800 (CST)
X-Originating-IP: [103.163.180.46]
Date:   Wed, 10 May 2023 16:48:07 +0800 (CST)
From:   wangyouwan <wangyouwan@126.com>
To:     "Dhruva Gole" <d-gole@ti.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] cpufreq: create cooling device based on ACPI
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <aa8386f8-6dce-0caf-a09f-a14347abf391@ti.com>
References: <20230428070314.225560-1-wangyouwan@126.com>
 <aa8386f8-6dce-0caf-a09f-a14347abf391@ti.com>
X-NTES-SC: AL_QuyTAfubt0wj4SeeYulS/T1E/LZbI7jC0pRmlcYUXM0QuiLqxwcORnBBJmb84PsR+KGO3r7iyuDGfPK4wq0j
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3cf25b19.65d3.18804d8a859.Coremail.wangyouwan@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAAn50RHWltkoCMaAA--.49155W
X-CM-SenderInfo: 5zdqw5prxzt0a6rslhhfrp/1tbiHgJrFWIxqYnqAwACs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpJJ20gc29ycnksIGJ1dCBJJ20gdXNpbmcgdGhlIDUuNCBrZXJuZWwsIGFuZCB0aGUgInNjcGkt
Y3B1ZnJlcSIgZnVuY3Rpb24gaXMgdXNlZCBpbiB0aGUgc2NwaV9jbG9ja3NfcHJvYmVfYWNwaSBm
dW5jdGlvbi4KCgoKQXQgMjAyMy0wNC0yOCAxNzo1NjowNywgIkRocnV2YSBHb2xlIiA8ZC1nb2xl
QHRpLmNvbT4gd3JvdGU6Cj5IaSwKPgo+T24gMjgvMDQvMjMgMTI6MzMsIHdhbmd5b3V3YW5AMTI2
LmNvbSB3cm90ZToKPj4gRnJvbTogeW91d2FuIFdhbmcgPHdhbmd5b3V3YW5AMTI2LmNvbT4KPj4g
Cj4+IFdoZW4gdXNpbmcgdGhlICJzY3BpX2NwdWZyZXEiIGRyaXZlciwgYW4gZXJyb3IKPgo+UGFy
ZG9uLCBkbyB5b3UgbWVhbiBkcml2ZXJzL2NwdWZyZXEvYWNwaS1jcHVmcmVxLmMgPwo+Cj4+IG9j
Y3VyczpjcHVmcmVxX2Nvb2xpbmc6IE9GIG5vZGUgbm90IGF2YWlsYWJsZSBmb3IgY3B1Ki4KPgo+
Cj5JZiB0aGlzIGlzIGZpeGluZyBzb21lIGVycm9ycy8gYnVncywgbWF5YmUgYWRkIGFuIGFwcHJv
cHJpYXRlIGZpeGVzCj50YWc/Cj4KPj4gVGhlIGN1cnJlbnQgY29tcHV0ZXIgbW90aGVyYm9hcmQg
aXMgdXNpbmcgQUNQSSBmaXJtd2FyZS4KPj4gR28gdG8gc2VlIHRoYXQgdGhlIGVycm9yIGlzIGNh
dXNlZCBieSBjYWxsaW5nIHRoZQo+PiAib2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyIiBpbnRl
cmZhY2UuCj4+IGNvbW1lbnQ6Y3JlYXRlIGNwdWZyZXEgY29vbGluZyBkZXZpY2UgYmFzZWQgb24g
RFQuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiB5b3V3YW4gV2FuZyA8d2FuZ3lvdXdhbkAxMjYuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIHwgNyArKysrKystCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Wy4uLl0KPj4g
ICAKPgo+LS0gCj5UaGFua3MgYW5kIFJlZ2FyZHMsCj5EaHJ1dmEgR29sZQo=
