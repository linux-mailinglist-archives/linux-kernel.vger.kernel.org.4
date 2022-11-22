Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA802633C35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiKVMOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiKVMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:14:37 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3218E303C2;
        Tue, 22 Nov 2022 04:14:34 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 22 Nov 2022 20:14:30
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Tue, 22 Nov 2022 20:14:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] elevator: restore old io scheduler on failure
 in elevator_switch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221121071305.GB23882@lst.de>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
 <20221121071305.GB23882@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6d74b4a9.5489.1849f42de2d.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgA3jw4mvXxjDPhdCQ--.64658W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgICB1ZdtcinewAAsv
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

PiBPbiBGcmksIE5vdiAxOCwgMjAyMiBhdCAwODowOTo1MlBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBlbGV2YXRvcl9zd2l0Y2ggY29udGFpbnMgdGhlIGZhbGxiYWNrIGxvZ2ljIGlu
IHNxIGVyYSwgYnV0IGl0IHdhcyByZW1vdmVkCj4gPiB3aGVuIG1vdmluZyB0byBtcSAoY29tbWl0
OiBhMWNlMzVmYTQ5ODUyZGI2MGZjNmUyNjgwMzg1MzBiZTUzM2M1YjE1KSwKPiA+IGxlYXZpbmcg
dGhlIGRvY3VtZW50IG1pc21hdGNoZWQgd2l0aCB0aGUgYmVoYXZpb3IuIEFzIGZhciBhcyBJIGNh
biBzZWUsCj4gPiByZXN0b3JpbmcgdGhlIG9sZCBpbyBzY2hlZHVsZXIgaXMgbW9yZSByZWFzb25h
YmxlIHRoYW4ganVzdCBsZWF2aW5nIHRoZQo+ID4gc2NoZWR1bGVyIG5vbmUsIGhlbmNlIHRoZXJl
IGlzIHRoZSBzZXJpZXMuCj4gCj4gV2hhdCBmYWlsdXJlIHNjZW5hcmlvdSBjYW4geW91IHRoaW5r
IG9mZiB3aGVyZSBzd2l0Y2hpbmcgdG8gdGhlIGludGVuZGVkCj4gc2NoZWR1bGUgZmFpbHMsIGJ1
dCBzd2l0Y2hpbmcgYmFjayB0byB0aGUgcHJldmlvdXMgb25lIHdpbGwgc3VjY2VlZD8KCk1vc3Rs
eSBmYWlsdXJlcyBzcGVjaWZpYyB0byB0aGUgaW50ZW5kZWQgaW8gc2NoZWR1bGVyLCBsaWtlIGNv
bnN1bWluZyBtb3JlCnJlc291cmNlcyB0aGFuIHRoZSBvbGQgb25lIHRoYXQgdGhlIHN5c3RlbSBj
YW4gbm90IGFmZm9yZC4gQnV0IHN1cmUgaXQncwpyYXJlLCBzbyBkbyB5b3UgdGhpbmsgSSBzaG91
bGQganVzdCBjb3JyZWN0IHRoZSBvdXRkYXRlZCBkb2N1bWVudD8KClRoYW5rcyEKSmlubG9uZyBD
aGVuCgo=
