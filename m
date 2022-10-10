Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCF5F96D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJJCa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiJJCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:30:57 -0400
Received: from m1374.mail.163.com (m1374.mail.163.com [220.181.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D02B525EA9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=2YhiT
        nPIQ4MDIZ3nx9WHggkgfBvqFh2UA8aSL+N9Vew=; b=a0jGYpuoyaHCPrGDV1HrX
        XOSK9y1T3ngLCUIhPFNeIDDTuQ1knhg3UgJlX0+KIlSMQiQ0YwJ4tmemlegUj9hh
        S00OPEKOjJ2he2EWu3o/p2sD3ZOlpe8NxuXpGG+jOeSQTbWV4unjc1Q91qkv3luh
        wu68sZ3GQL7GUtWvU6hscg=
Received: from 13667453960$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr74 (Coremail) ; Mon, 10 Oct 2022 10:30:36 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Mon, 10 Oct 2022 10:30:36 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] staging: sm750fb: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y0MRcIyBtLlzjRzi@kroah.com>
References: <20221009094809.3171319-1-13667453960@163.com>
 <Y0MRcIyBtLlzjRzi@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <f427e25.1615.183bfbad6a1.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: SsGowACnLW_Mg0NjhYxMAA--.59363W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivguV+1Zce8Xw2gACsH
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

CkF0IDIwMjItMTAtMTAgMDI6MjI6NDAsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDU6NDg6MDlQTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4KPkFnYWluLCB3aHkgMTYzLmNvbT8KPgoKCgpUaGVyZSBpcyBhIHByb2JsZW0g
d2l0aCB0aGUgY29tcGFueSdzIG1haWxib3gsIGFuZCBzb21ldGltZXMgSSBjYW4ndCByZWNlaXZl
IGVtYWlscy4gU28gSSB0ZW1wb3JhcmlseSB1c2UgbXkgcGVyc29uYWwgZW1haWwgdG8gc2VuZCBw
YXRjaGVzLCBzbyB0aGF0IEkgY2FuIHJlY2VpdmUgZmVlZGJhY2sgZnJvbSB0aGUgY29tbXVuaXR5
IGluIGEgdGltZWx5IG1hbm5lci4KCgp0aGFua3OjrAoKCkppYW5nc2hhbiBZaQ==
