Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081386158F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKBDC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKBDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:02:05 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E33D023171;
        Tue,  1 Nov 2022 20:01:39 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Nov 2022 11:01:33
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Wed, 2 Nov 2022 11:01:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] some random cleanups for blk-mq.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <cover.1667356813.git.nickyc975@zju.edu.cn>
References: <cover.1667356813.git.nickyc975@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3458f1ab.163b5a.184364970c8.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBHC7GN3WFjJvpcBw--.54326W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAAJsw
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

PiBQYXRjaCAxIGltcHJvdmVzIHRoZSBlcnJvciBoYW5kbGluZyBibGtfbXFfYWxsb2NfcnFfbWFw
KCkuIFBhdGNoIDIKPiBpbXByb3ZlcyByZWFkYWJpbGl0eSBvZiBibGtfbXFfYWxsb2NfY2FjaGVk
X3JlcXVlc3QoKS4KPiAKPiBDaGFuZ2VzIGluIHYyOgo+IC0gZHJvcCB3cm9uZyBhbmQgd29ydGhs
ZXNzIHBhdGNoZXMsIHN1Z2dlc3RlZCBieSBDaHJpc3RvcGgsIEplbnMgYW5kCj4gICBDaGFpdGFu
eWEKPiAtIHJlbW92ZSBzaWxseSBnb3RvLXJldHVybi1OVUxMIGluIHBhdGNoIDEgKHBhdGNoIDIg
b3JpZ2luYWxseSksIHN1Z2dlc3RlZAo+ICAgYnkgQ2hyaXN0b3BoIGFuZCBKZW5zCj4gCj4gSmlu
bG9uZyBDaGVuICgyKToKPiAgIGJsay1tcTogaW1wcm92ZSBlcnJvciBoYW5kbGluZyBpbiBibGtf
bXFfYWxsb2NfcnFfbWFwKCkKPiAgIGJsay1tcTogdXNlIGlmLWVsc2UgaW5zdGVhZCBvZiBnb3Rv
IGluIGJsa19tcV9hbGxvY19jYWNoZWRfcmVxdWVzdCgpCj4gCj4gIGJsb2NrL2Jsay1tcS5jIHwg
NDYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgoKT29wcywgSSBm
b3Jnb3QgdGhlIHJldmlld2VkIHRhZyBieSBDaHJpc3RvcGghCgpTb3JyeSEKSmlubG9uZyBDaGVu
Cg==
