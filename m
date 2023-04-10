Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E526DC6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDJMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDJMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:20:14 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4659C8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681129210;
        bh=LDfsmCHHm9SPOS24B6i9AltvoxInTtvi6NItDUQ4vb4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ffxvJr4w1AWyLxtCYueJU4bjsY9MKonfWa66xxqO6hXQi013eQhLYbqgekXjaNjDp
         2ayP0U3uNwMP5Pzb24EopgZjmW3qlVlC47VbN+Xemjx3X+gKFVMhof5AiCG9Iw9Whm
         S1Xi6/hWHjffIurj/d11vPwoMT4p2T1q2aokJ53c=
Received: from [192.168.124.11] (unknown [113.140.11.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E118A66295;
        Mon, 10 Apr 2023 08:20:08 -0400 (EDT)
Message-ID: <c90c442fe029bfb9c4487284366800b8781954e1.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Improve memory ops
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG rui <wangrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Date:   Mon, 10 Apr 2023 20:20:01 +0800
In-Reply-To: <20230410115734.93365-1-wangrui@loongson.cn>
References: <20230410115734.93365-1-wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTEwIGF0IDE5OjU3ICswODAwLCBXQU5HIHJ1aSB3cm90ZToKPiArwqDC
oMKgwqDCoMKgwqAvKiBhbGlnbiB1cCBhZGRyZXNzICovCj4gK8KgwqDCoMKgwqDCoMKgYW5kacKg
wqDCoMKgdDEsIGEwLCA3Cj4gK8KgwqDCoMKgwqDCoMKgc3ViLmTCoMKgwqBhMCwgYTAsIHQxCgpi
c3RyaW5zLmQgYTAsIHplcm8sIDIsIDAKCkxpa2V3aXNlIGZvciBvdGhlciBhbGlnbmluZyBvcGVy
YXRpb25zIGlmIHRoZSB0ZW1wb3JhcnkgaXMgbm90IHVzZWQuCgo+ICvCoMKgwqDCoMKgwqDCoGFk
ZGkuZMKgwqBhMCwgYTAsIDgKCi0tIApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KU2No
b29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0
eQo=

