Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB76C41D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCVFMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVFMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:12:35 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A094615A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=qwHo6v/UQaYyK2BR5D/QGwEr9RnX4ZDOl82OMBwaxZk=; b=V
        SkaI6P5bYZkP/j2bPsa7s2F/MjoCHIQlNQFXjJVbmvM0uADr/umt0Yq64fcRzK2C
        /Q4tUS8zLFA3/hQfZX89HMbaAKB+REvqmlbUoPagg6V1k7FIRZJo6fSKU3ZJbHYs
        VZSHYDWz25eGnD+qqxQS8PLNSuXAau0X1SE+kPL9Q4=
Received: from 00107082$163.com ( [222.64.154.91] ) by ajax-webmail-wmsvr80
 (Coremail) ; Wed, 22 Mar 2023 13:12:07 +0800 (CST)
X-Originating-IP: [222.64.154.91]
Date:   Wed, 22 Mar 2023 13:12:07 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re:Re: [PATCH] scripts/package: add back 'version' for builddeb
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2f199872-87c8-c7e9-8d9c-b4e51bbc207b@gmail.com>
References: <20230320110819.23668-1-00107082@163.com>
 <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
 <3ee67285.5853.18704c2158c.Coremail.00107082@163.com>
 <1a2278c5-5398-2e7a-344d-fd5dd9703b10@gmail.com>
 <2f199872-87c8-c7e9-8d9c-b4e51bbc207b@gmail.com>
X-NTES-SC: AL_QuycC/idvkEp4SOQY+kXn0oTju85XMCzuv8j3YJeN500hyr29SsrVF9vAnDqysOgKAaykDiYfwp34f97c5NFdazsJwDvnPmbRZFL/bV/ew3V
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <406f0b68.252f.18707bb49de.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDHzwcnjhpkkFIEAA--.148W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTBc6qmI0X8BcygABsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMy0wMy0yMiAxMTozNzo0NSwgIkJhZ2FzIFNhbmpheWEiIDxiYWdhc2RvdG1lQGdt
YWlsLmNvbT4gd3JvdGU6Cj5PbiAzLzIyLzIzIDEwOjM1LCBCYWdhcyBTYW5qYXlhIHdyb3RlOgo+
PiBPSywgYnV0IHRoZXJlIGlzIGFscmVhZHkgdGhlIHNpbWlsYXIgZml4IHN1Ym1pdHRlZCBhdCBb
MV0uIFBsZWFzZSB0ZXN0IGl0Lgo+PiAKPj4gVGhhbmtzIGFueXdheS4KPj4gCj4+IFsxXTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgta2J1aWxkLzMzNTFmOTA3Y2ZkMGI1ZDgzNzJlODU4
YThlYzkwNjVjYzJiZDkxZGYuMTY3OTQzNDcxOC5naXQua2V2aW5Aa2V2aW5sb2NrZS5uYW1lLwo+
PiAKPgo+T29wcywgdGhlIGZpeCBpcyBhbHJlYWR5IGFwcGxpZWQgYXQgWzFdLgo+Cj5bMV06IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21hc2FoaXJveS9s
aW51eC1rYnVpbGQuZ2l0L2NvbW1pdC8/aD1maXhlcyZpZD0zY2VkNzFkMjczZjhlZGYwN2JmMDFh
ODMxYTQ5Y2E2Yjk4OGUwNmIzCj4KPi0tIAo+QW4gb2xkIG1hbiBkb2xsLi4uIGp1c3Qgd2hhdCBJ
IGFsd2F5cyB3YW50ZWQhIC0gQ2xhcmEKCgpJdCdzIE9LLCBnbGFkIHRvIGtub3cgaXQgd2lsbCBi
ZSBmaXhlZCBpbiB0aGUgbmV4dCByYy4KCkRhdmlk
