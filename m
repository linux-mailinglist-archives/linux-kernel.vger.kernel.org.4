Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC561571E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKBBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBBof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:44:35 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A37B5DED7;
        Tue,  1 Nov 2022 18:44:33 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Nov 2022 09:44:30
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Wed, 2 Nov 2022 09:44:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/4] blk-mq: update comment for
 blk_mq_quiesce_queue_nowait()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221101172720.GA20526@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <489a9322eed1f95f8770752cc715084f1fa961d3.1667314759.git.nickyc975@zju.edu.cn>
 <20221101172720.GA20526@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f33a768.1635a2.1843602e799.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAXz1p+y2FjIKdcBw--.53643W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwATsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIE5vdiAwMSwgMjAyMiBhdCAxMToxMTozNFBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBibGtfbXFfcXVpZXNjZV9xdWV1ZV9ub3dhaXQoKSBpcyBub3cgcmVhc29uYWJs
eSB1c2VkIGJ5IHNjc2lfaG9zdF9ibG9jaygpCj4gPiB0byBhdm9pZCBjYWxsaW5nIHN5bmNocm9u
aXplX3JjdSgpIGZvciBlYWNoIExVTi4gV2Ugc2hvdWxkIG5vdCBjb25zaWRlciB0bwo+ID4gcmVt
b3ZlIGl0Lgo+IAo+IEkgc3Ryb25nbHkgZGlzYWdyZWUgYWJvdXQgdGhpcyBiZWluZyBhIHJlYXNv
bmFibGUgdXNlLiAgV2hhdCBTQ1NJIGRpZAo+IHRoZXJlIGlzIGEgaG9ycmlibGUgaGFjayB0aGF0
IHNob3VsZCBoYXZlIG5ldmVyIGJlZW4gbWVyZ2VkLiAgVGhlCj4gcmlnaHQgdGhpbmcgdG8gZG8g
aXMgdGhlIHBlci10YWdfc2V0IHF1aWVzY2UgdGhhdCB3ZSd2ZSBiZWVuIHdvcmtpbmcKPiBvbi4K
Ck9rLCBJIGd1ZXNzIEkgbmVlZCB0byByZWFkIHRoZSBwZXItdGFnX3NldCBxdWllc2NlIHBhdGNo
IHNlcmllcy4KClRoYW5rcyEKSmlubG9uZyBDaGVuCg==
