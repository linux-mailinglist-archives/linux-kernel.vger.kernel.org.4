Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1216C3587
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCUPWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCUPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:22:05 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F7B81D936
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=LzMtmN8pLBEwPXlMa/QVxc9cYzqkW8riSwKqtl7QGno=; b=T
        R5TIUF1P2uOFHhEjK8Q/Iwvc+mSi67PIQfzgZ1yioVGsO4r29pIF3b+QeU2CQKkq
        LKY2JyxA2HMOtOmavvh2sM2NFPLNVf6aolwIcPx4bt0ak2xShP/mTIbsY1AxBAaW
        0Q1/+uZo9vC/TDx6Woyjhd/vKavF008yeGi1u5Z/sI=
Received: from 00107082$163.com ( [222.64.154.91] ) by ajax-webmail-wmsvr134
 (Coremail) ; Tue, 21 Mar 2023 23:20:41 +0800 (CST)
X-Originating-IP: [222.64.154.91]
Date:   Tue, 21 Mar 2023 23:20:41 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re:Re: [PATCH] scripts/package: add back 'version' for builddeb
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
References: <20230320110819.23668-1-00107082@163.com>
 <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
X-NTES-SC: AL_QuycC/iavUgv5yCRYukXn0oTju85XMCzuv8j3YJeN500iivk3DsDWG1aAXjr0tu+NRKoogqJVgdNxdxfRZNWX6SilaKKBV0fEd67BXZ9WYG0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3ee67285.5853.18704c2158c.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wAXpDhJyxlkO8gAAA--.2788W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwM5qlXmEKuFjQACsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4KPkFnYWluLCB5b3VyIHBhdGNoIGxvb2tzIGxpa2UgY29ycnVwdGVkICh0YWJzIGNvbnZlcnRl
ZCB0byBzcGFjZXMpLgo+UGxlYXNlIHJlc3VibWl0OyB0aGlzIHRpbWU7IGdlbmVyYXRlIHRoZSBw
YXRjaCB2aWEgZ2l0LWZvcm1hdC1wYXRjaCgxKQo+YW5kIHRoZW4gc2VuZCB0aGUgcmVzdWx0aW5n
IHBhdGNoIHdpdGggZ2l0LXNlbmQtZW1haWwoMSkuCj4KPlRoYW5rcy4KPgpJIGRpZCB1c2UgYGdp
dCBmb3JtYXQtcGF0Y2hgIGFuZCBgZ2l0IHNlbmQtZW1haWxgLCBidXQgSSBkaWQgbm90IHJ1biBz
Y3JpcHRzL2NoZWNrcGF0Y2gucGwuCk5vdyB3aGVuIEkgcnVuIHNjcmlwdHMvY2hlY2twYXRjaC5w
bCBhZ2FpbnN0IHRoZSBmaWxlIGdlbmVyYXRlZCBieSBgZ2l0IGZvcm1hdC1wYXRjaGAsIGl0IHNo
b3dzIGEgd2FybmluZyBhYm91dCAiRml4ZXM6IiB0YWcsIGFuZApJIGhhdmUgcmVzZW5kIGEgcGF0
Y2ggd2hpY2ggcGFzcyB0aGUgY2hlY2tzIG9mIHNjcmlwdHMvY2hlY2twYXRjaC5wbCwgaG9wZSB0
aGlzIHRpbWUgaXQgY291bGQgYmUgb2suCgpgYGAKJCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgMDAw
MS1zY3JpcHRzLXBhY2thZ2UtYWRkLWJhY2stdmVyc2lvbi1mb3ItYnVpbGRkZWIucGF0Y2gKdG90
YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCA3IGxpbmVzIGNoZWNrZWQKCjAwMDEtc2NyaXB0cy1w
YWNrYWdlLWFkZC1iYWNrLXZlcnNpb24tZm9yLWJ1aWxkZGViLnBhdGNoIGhhcyBubyBvYnZpb3Vz
IHN0eWxlIHByb2JsZW1zIGFuZCBpcyByZWFkeSBmb3Igc3VibWlzc2lvbi4KYGBgCgoKRGF2aWQ=

