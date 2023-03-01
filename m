Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149626A6BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCAL34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCAL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:29:52 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6919A1EBDC;
        Wed,  1 Mar 2023 03:29:49 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Wed, 1 Mar 2023 19:29:42
 +0800 (GMT+08:00)
X-Originating-IP: [106.117.98.179]
Date:   Wed, 1 Mar 2023 19:29:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     syzbot <syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com>
Cc:     hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] WARNING in smsusb_term_device
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2023 www.mailtech.cn zju.edu.cn
In-Reply-To: <00000000000063a01505f5a4f0a6@google.com>
References: <00000000000063a01505f5a4f0a6@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56c765d1.725f4.1869cef6f08.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDX3QwmN_9j_XCdDQ--.22734W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4BAVZdtd2LwAAAsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBTdW4sIDI2IEZlYiAyMDIzIDE4OjA3OjIwIC0wODAwIHN5emJvdCB3cm90ZToK
Cj4gc3l6Ym90IGhhcyBiaXNlY3RlZCB0aGlzIGlzc3VlIHRvOgo+IAo+IGNvbW1pdCBlYmFkOGU3
MzFjMWMwNmFkZjA0NjIxZDZmZDMyN2I4NjBjMDg2MWI1Cj4gQXV0aG9yOiBEdW9taW5nIFpob3Ug
PGR1b21pbmdAemp1LmVkdS5jbj4KPiBEYXRlOiAgIE1vbiBKYW4gMjMgMDI6MDQ6MzggMjAyMyAr
MDAwMAo+IAo+ICAgICBtZWRpYTogdXNiOiBzaWFubzogRml4IHVzZSBhZnRlciBmcmVlIGJ1Z3Mg
Y2F1c2VkIGJ5IGRvX3N1Ym1pdF91cmIKPiAKPiBiaXNlY3Rpb24gbG9nOiAgaHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20veC9iaXNlY3QudHh0P3g9MTY4N2FmMWNjODAwMDAKPiBzdGFydCBj
b21taXQ6ICAgODIzMjUzOWY4NjRjIEFkZCBsaW51eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAy
MDIzMDIyNQo+IGdpdCB0cmVlOiAgICAgICBsaW51eC1uZXh0Cj4gZmluYWwgb29wczogICAgIGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwb3J0LnR4dD94PTE1ODdhZjFjYzgwMDAw
Cj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4
dD94PTExODdhZjFjYzgwMDAwCj4ga2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFw
cHNwb3QuY29tL3gvLmNvbmZpZz94PTRmZTY4NzM1NDAxYTYxMTEKPiBkYXNoYm9hcmQgbGluazog
aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTQwYWM2ZTczMzI2ZTc5ZWU4
ZWNiCj4gc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVw
cm8uc3l6P3g9MTNiYTdjYjBjODAwMDAKPiBDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20veC9yZXByby5jP3g9MTY3MzQ5NjRjODAwMDAKPiAKPiBSZXBvcnRlZC1i
eTogc3l6Ym90KzQwYWM2ZTczMzI2ZTc5ZWU4ZWNiQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20K
PiBGaXhlczogZWJhZDhlNzMxYzFjICgibWVkaWE6IHVzYjogc2lhbm86IEZpeCB1c2UgYWZ0ZXIg
ZnJlZSBidWdzIGNhdXNlZCBieSBkb19zdWJtaXRfdXJiIikKClRoYW5rcyBmb3IgcmVwb3J0aW5n
IHRoaXMgaXNzdWUhIEkgaGF2ZSBzZW50IGEgcGF0Y2ggdG8gZml4IGl0LiBUaGUgbGluayBpcyBi
ZWxvdzoKCmh0dHBzOi8vcGF0Y2h3b3JrLmxpbnV4dHYub3JnL3Byb2plY3QvbGludXgtbWVkaWEv
cGF0Y2gvMjAyMzAzMDEwOTE4MTMuODI1NDMtMS1kdW9taW5nQHpqdS5lZHUuY24vCgpCZXN0IHJl
Z2FyZHMsCkR1b21pbmcgWmhvdQo=
