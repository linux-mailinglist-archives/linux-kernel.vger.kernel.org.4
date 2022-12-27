Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4E656AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiL0MZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiL0MZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:25:02 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 04:24:28 PST
Received: from 163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C1F5B7F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=7HHLi88ID4NDreNPJ8UoOkoSTj3PyBOECrINB3nixKQ=; b=j
        YvRJ3HloBHn75eIkD/zkVGmiCWY+H6MsxHfT7ADye7Jbwtp4Q9Dg6tJsykgmM2IR
        bzt9DFhIZUNAk7W6b8h84HaFTRMoRdHFJmpnjOtRbOM8FqICJEwC09tILzCZ1IV9
        tEhwijdxi4FSlEJN8vEY5wROZqGw5mrSJZMKBbwn54=
Received: from 00107082$163.com ( [222.64.110.75] ) by ajax-webmail-wmsvr62
 (Coremail) ; Tue, 27 Dec 2022 20:09:11 +0800 (CST)
X-Originating-IP: [222.64.110.75]
Date:   Tue, 27 Dec 2022 20:09:11 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     linux-kernel@vger.kernel.org
Subject: [/proc/vmstat] nr_kernel_stack is actually meminfo_kernel_stack_kb?
 why...
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
X-NTES-SC: AL_QuycAP2fvUEu5ySYY+kZnEoUjug3W8K5v/kk3Y9VOp80kyr/+zg/VmdtG3bJ4vyhMD6IqACabCl11OJTTIB8XprLd8hDHe2pBkuoy4yn+dfg
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <66e657e6.38d5.185537c93f0.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3a3Vn4KpjC+cBAA--.15917W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTAfkqmI0XGyJSgAAsg
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLCAKCgoKVGhlIG5yX2tlcm5lbF9zdGFjayBpbiAvcHJvYy92bXN0YXQgbm93IGlzIHRoZSBz
YW1lIGFzIEtlcm5lbFN0YWNrIC9wcm9jL21lbWluZm8sIGFuZCBoYXMgYmVlbiB0aGlzIHdheSBz
aW5jZSBhIGNoYW5nZSBtYWRlIHNpeCB5ZWFycyBhZ28gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjQyNzlkNDAwOWM4MjFkZTY0MTA5MDU1NjY1NDI5ZmFkMmE3YmZmNy4xNDY2MDM2NjY4
LmdpdC5sdXRvQGtlcm5lbC5vcmcvKSAKCgoKVGhlIHNpdHVhdGlvbiBub3cgaXMgdmVyeSBjb25m
dXNpbmc6CjEuIHRoZSBuYW1pbmcgc2hvdWxkIGJlIGNoYW5nZWQsIGhvdyBjb3VsZCBvbmUgdGFr
ZSAnbnJfa2VybmVsX3N0YWNrJyBhcyBhIG5hbWluZyBmb3IgbWVtaW5mby1LZXJuZWxTdGFjay1L
Qj8KMi4gRG9zZSBrZXJuZWwudGhyZWFkcy1tYXggbm93IG1lYW5zIGtlcm5lbC50aHJlYWRzLW1h
eC1rQj8KCjMuIEkgcmVhbGx5IHRoaW5rIHRoZSBudW1iZXIgb2YgdGhyZWFkcyBjdXJyZW50bHkg
cnVubmluZyBpbiB0aGUgc3lzdGVtIGlzIGEgdmVyeSB1c2Z1bCBzdGFzdGlzdGljLCBJIHVzZWQg
dG8gY29sbGVjdCBucl9rZXJuZWxfc3RhY2sgaW4gL3Byb2Mvdm1zdGF0IHRvIG1vbml0b3IgdGhy
ZWFkL3Rhc2sgdXNhZ2UgaW4gdGhlIHN5c3RlbSzCoCBhbmQgdHJpZ2dlciBhbGFybSB3aGVuIG5y
X2tlcm5lbF9zdGFjayBpcyBhcHByb2FjaGluZyBzb21ld2hlcmUgbmVhciBrZXJuZWwudGhyZWFk
cy1tYXguwqAgCgoKCkhvcGUgdGhpbmdzIGNhbiBiZSBjaGFuZ2VkLCBhbmQgbnJfa2VybmVsX3N0
YWNrIGNvdWxkIGJlIHJlc3RvcmVkL2ZpeGVkIHRvIGl0cyBvbGQgbWVhbmluZy4KCgoKCkRhdmlk
CgoKCgo=
