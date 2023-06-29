Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799774232C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF2JYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjF2JYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:24:33 -0400
Received: from m159.mail.126.com (m159.mail.126.com [220.181.15.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CF12681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=rNwVlDC2J/hCm1dmyP4xlqe4cz4USW6cQHGWH2SpQ24=; b=A
        6A6X3t4Gy7Wx7iKbC4Wdm1Akm7gHzfg4RY1ZjQSA29eMNJnFVBI6Gb2X/sFtnNk5
        hcuVOl2DC5GSxhY7KYHBX+CHfevrQI+GSOZ2wQNWZ1V9mXt+JCYhyogeVdM5axf/
        pPNKo4C0K/LOF1XieDkXAcAT+cJRjnkTeWwtfMLf3k=
Received: from liujf628995$126.com ( [124.126.99.218] ) by
 ajax-webmail-wmsvr9 (Coremail) ; Thu, 29 Jun 2023 17:23:07 +0800 (CST)
X-Originating-IP: [124.126.99.218]
Date:   Thu, 29 Jun 2023 17:23:07 +0800 (CST)
From:   liujf628995 <liujf628995@126.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, security@kernel.org,
        secalert@redhat.com
Subject: =?utf-8?Q?Re:Re:_use-after-free_in_kmemleak=5Fscan=EF=BC=9F?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <2023062958-twistable-rut-e684@gregkh>
References: <59a9e693.270f.1890529db99.Coremail.liujf628995@126.com>
 <2023062958-twistable-rut-e684@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Message-ID: <37563212.63b4.1890676ab47.Coremail.liujf628995@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcqowABnf7d7TZ1kG14xAA--.37735W
X-CM-SenderInfo: holxywywsymmav6rjloofrz/1tbiqAWdTVpEA60RTQABsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b2ssSSB3aWxsIHNlbmQgdGhlIG1haWwgYnkgcGxhaW4vdGV4dCBhZ2FpbiBieSBhbm90aGVyIGVt
YWlsIGFkZHJlc3MsdGhpcyBjcmFzaCBvY2N1cmVkIG1hbnkgdGltZXMgaW4gbXkgZnV6emluZyxi
dXQgSSdtIHNvcnJ5IHRoYXQgSSBoYXZlIG5vdCBhIHJlcHJvZHVjZXIgb3IgYSBwYXRjaC4KQXQg
MjAyMy0wNi0yOSAxMzo1Njo1NywgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gd3JvdGU6Cj5PbiBUaHUsIEp1biAyOSwgMjAyMyBhdCAxMToxOTozNkFNICswODAwLCBsaXVq
ZjYyODk5NSB3cm90ZToNCj4+IGhlbGxvLGhlcmUgaXMgYSBjcmFzaCBmcm9tIHN5emthbGxlcixp
dCBsb29rcyBsaWtlIGhhcHBlbmVkIGluIGttZW1sZWFrIHNjYW4uSXQgY291bGQgbm90IGJlIHJl
cHJvZHVjZWQgYnkgc3l6a2FsbGVyIGJlY2F1c2UgdGhpcyBzaG91bGQgbm90IGhhdmUgYmVlbiBj
YXVzZWQgYnkgc3lzY2FsbCBmdXp6LkkgZG9uJ3Qga25vdyB3aGF0IHJoZSByZWFzb24gZm9yIHRo
aXPvvIxwbGVhc2UgY2hlY2sgaXQuTXkgZnV6emVkIGxpbnV4IGtlcm5lbCBpcyBsaW51eC02LjLv
vIhjb21taXQvYzljMzM5NWQ1ZTNkY2M2ZGFlZTY2YzY5MDgzNTRkNDdiZjk4Y2IwY++8iQ0KPg0K
PklmIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBvciBhIHBhdGNoLCB3ZSB3aWxsIGJlIGdsYWQgdG8g
cmV2aWV3IGl0LA0KPm90aGVyd2lzZSBqdXN0IHNlbmRpbmcgc3l6Ym90IHJlcG9ydHMgbGlrZSB0
aGlzIChlc3BlY2lhbGx5IGluIGh0bWwNCj5mb3JtYXQgd2hpY2ggaXMgcmVqZWN0ZWQgYnkgdGhl
IG1haWxpbmcgbGlzdHMpLCB3aWxsIG5vdCBnbyB2ZXJ5IGZhciBhcw0KPndlIGhhdmUgbG9hZHMg
b2YgdGhlbSBhbHJlYWR5Lg0KPg0KPnRoYW5rcywNCj4NCj5ncmVnIGstaA0K
