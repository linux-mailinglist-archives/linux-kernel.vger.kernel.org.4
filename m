Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836ED5F96D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJJCfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJJCfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:35:13 -0400
Received: from m1374.mail.163.com (m1374.mail.163.com [220.181.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E00E838684
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 19:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=fqc7P
        OfcW+wefL87nJX++WuyipQJOgC3GBIb6bkLx0U=; b=R63w0yfmyEWgbFGAVFNB1
        aRuI+WhhMRv06EVBqwmilbBz724b8i2vB8P8/rZTCaHElRHYi/N2IC6ozBzH8UEW
        DHo3j8ta1N26pfShiHis2X61eyvLFhTMHFSa54cPXdlXfu0KeWZctnhVOLv7x/7n
        2VaOWbFK3dI+BDceGZXRaM=
Received: from 13667453960$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr74 (Coremail) ; Mon, 10 Oct 2022 10:35:01 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Mon, 10 Oct 2022 10:35:01 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] staging: rtl8192u: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y0MRTlpjuG3rJX9o@kroah.com>
References: <20221009085746.3149599-1-13667453960@163.com>
 <Y0MRTlpjuG3rJX9o@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <36da6995.16ee.183bfbee245.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: SsGowAC3QmzVhENj5Y1MAA--.52454W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivhaW+1Zce8k6SQABsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMTAtMTAgMDI6MjI6MDYsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDQ6NTc6NDZQTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4KPkFnYWluLCB3aHkgYSAxNjMuY29tIGFkZHJlc3M/Cj4KClRoZXJlIGlzIGEg
cHJvYmxlbSB3aXRoIHRoZSBjb21wYW55J3MgbWFpbGJveCwgYW5kIHNvbWV0aW1lcyBJIGNhbid0
IHJlY2VpdmUgZW1haWxzLiBTbyBJIHRlbXBvcmFyaWx5IHVzZSBteSBwZXJzb25hbCBtYWlsYm94
IHRvIHNlbmQgcGF0Y2hlcywgc28gdGhhdCBJIGNhbiByZWNlaXZlIGZlZWRiYWNrIGZyb20gdGhl
IGNvbW11bml0eSBpbiBhIHRpbWVseSBtYW5uZXIuCgp0aGFua3OjrAoKSmlhbmdzaGFuIFlp
