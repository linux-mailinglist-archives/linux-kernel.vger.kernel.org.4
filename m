Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23A63A1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiK1Hab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK1Ha1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:30:27 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57BAF1147A;
        Sun, 27 Nov 2022 23:30:24 -0800 (PST)
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 28 Nov 2022 15:30:21
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.0.186]
Date:   Mon, 28 Nov 2022 15:30:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the v4l-dvb-next tree
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221128152645.245141b6@canb.auug.org.au>
References: <20221128152645.245141b6@canb.auug.org.au>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <28948ae.13ac1.184bd24def0.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cS_KCgAnYvyNY4RjJzqbCA--.15708W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQRElNG3I7oMgApsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwKCj4gSGkgYWxsLAo+IAo+IEFmdGVyIG1lcmdpbmcgdGhlIHY0bC1kdmItbmV4
dCB0cmVlLCB0b2RheSdzIGxpbnV4LW5leHQgYnVpbGQgKGh0bWxkb2NzKQo+IHByb2R1Y2VkIHRo
ZXNlIHdhcm5pbmdzOgo+IAo+IGluY2x1ZGUvbWVkaWEvZHZiZGV2Lmg6MTkzOiB3YXJuaW5nOiBG
dW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdyZWYnIG5vdCBkZXNjcmliZWQgaW4gJ2R2Yl9k
ZXZpY2UnCj4gaW5jbHVkZS9tZWRpYS9kdmJkZXYuaDoyMDc6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIGR2Yl9kZXZpY2VfZ2V0KCkuIFByb3RvdHlwZSB3YXMgZm9yIGR2Yl9kZXZp
Y2VfcHV0KCkgaW5zdGVhZAo+IAo+IEludHJvZHVjZWQgYnkgY29tbWl0Cj4gCj4gICAwZmMwNDRi
MmI1ZTIgKCJtZWRpYTogZHZiZGV2OiBhZG9wdHMgcmVmY250IHRvIGF2b2lkIFVBRiIpCj4gCj4g
LS0gCgpPaCBteSBiYWQsIGl0IHNlZW1zIHRoYXQgSSBsZWF2ZSBhIHR5cG8gdGhlcmUgYXMgZm9y
Z2V0dGluZyBhYm91dCB0aGUgZnVuY3Rpb24gbmFtZSBpbiBjb21tZW50LgoKLyoqCiAqIGR2Yl9k
ZXZpY2VfZ2V0IC0gRGVjcmVhc2UgZHZiX2RldmljZSByZWZlcmVuY2UKICoKICogQGR2YmRldjoJ
cG9pbnRlciB0byBzdHJ1Y3QgZHZiX2RldmljZQogKi8Kdm9pZCBkdmJfZGV2aWNlX3B1dChzdHJ1
Y3QgZHZiX2RldmljZSAqZHZiZGV2KTsKCkFsc28gdGhlICdyZWYnIGZpZWxkIGlzIG5vdCBkZXNj
cmliZWQgd2l0aCBjb21tZW50LiBXaWxsIHNlbmQgdGhlIGZpeCB0byB0aGUgdjRsLWR2Yi1uZXh0
IHNvb24uCgpUaGFua3MKTGluCg==
