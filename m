Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C103A6CD494
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjC2I3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjC2I3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:29:21 -0400
X-Greylist: delayed 1081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 01:29:19 PDT
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02CAE170F;
        Wed, 29 Mar 2023 01:29:18 -0700 (PDT)
Received: from sunying$nj.iscas.ac.cn ( [204.44.112.13] ) by
 ajax-webmail-APP-13 (Coremail) ; Wed, 29 Mar 2023 15:52:30 +0800
 (GMT+08:00)
X-Originating-IP: [204.44.112.13]
Date:   Wed, 29 Mar 2023 15:52:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5a2Z5rui?= <sunying@nj.iscas.ac.cn>
To:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Multiple undefined configuration options are dependent in Kconfig
 under the v6.3-rc4 drivers directory
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20221213(4b1d97a5)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowACXn18_7iNkH9QOAA--.38250W
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/1tbiCQQFAWQj49YqzwAAse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXQgaGFzIGJlZW4gZGlzY292ZXJlZCB0aGF0IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbiBv
cHRpb25zIGFyZSB1bmRlZmluZWQgaW4gdGhlIGN1cnJlbnQgbGF0ZXN0IHZlcnNpb24sIHY2LjMt
cmM0LCB5ZXQgdGhleSBhcmUgYmVpbmcgcmVsaWVkIHVwb24gYnkgb3RoZXIgY29uZmlndXJhdGlv
biBvcHRpb25zIGluIG11bHRpcGxlIEtjb25maWcgZmlsZXM6CgpNSVBTX0JBSUtBTF9UMSBpcyB1
bmRlZmluZWQsIHVzZWQgYXMgYSAnZGVwZW5kcyBvbicgY29uZGl0aW9uIGluIG11bHRpcGxlIGZp
bGVzIHN1Y2ggYXMgZHJpdmVycy9hdGEvS2NvbmZpZywgZHJpdmVycy9od21vbi9LY29uZmlnLCBk
cml2ZXJzL2J1cy9LY29uZmlnLCBhbmQgZHJpdmVycy9tZW1vcnkvS2NvbmZpZy4KTUZEX01BWDU5
N1ggaXMgdW5kZWZpbmVkLCB1c2VkIGFzIGEgJ2RlcGVuZHMgb24nIGNvbmRpdGlvbiBpbiBLY29u
ZmlnIGZpbGUgZHJpdmVycy9yZWd1bGF0b3IvS2NvbmZpZy4KTUZEX1NNNTcwMyBpcyB1bmRlZmlu
ZWQsIHVzZWQgYXMgYSAnZGVwZW5kcyBvbicgY29uZGl0aW9uIGluIEtjb25maWcgZmlsZSBkcml2
ZXJzL3JlZ3VsYXRvci9LY29uZmlnLgpBUkNIX1RIVU5ERVJCQVkgaXMgdW5kZWZpbmVkLCB1c2Vk
IGFzIGEgJ2RlcGVuZHMgb24nIGNvbmRpdGlvbiBpbiBLY29uZmlnIGZpbGVzIGRyaXZlcnMvcGlu
Y3RybC9LY29uZmlnIGFuZCBkcml2ZXJzL3BoeS9pbnRlbC9LY29uZmlnLgpBUkNIX0JDTTQ5MDgg
aXMgdW5kZWZpbmVkLCB1c2VkIGFzIGEgJ2RlcGVuZHMgb24nIGNvbmRpdGlvbiBpbiBLY29uZmln
IGZpbGUgZHJpdmVycy9sZWRzL2JsaW5rL0tjb25maWcuCk1GRF9UTjQ4TV9DUExEIGlzIHVuZGVm
aW5lZCwgdXNlZCBhcyBhICdkZXBlbmRzIG9uJyBjb25kaXRpb24gaW4gS2NvbmZpZyBmaWxlcyBk
cml2ZXJzL2dwaW8vS2NvbmZpZyBhbmQgZHJpdmVycy9yZXNldC9LY29uZmlnLiAKVVNCX0hTSUNf
VVNCMzYxMyBpcyB1bmRlZmluZWQsIHVzZWQgYXMgYSAnZGVwZW5kcyBvbicgY29uZGl0aW9uIGlu
IGRyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL0tjb25maWcgYW5kIGRyaXZlcnMvc3RhZ2luZy9ncmV5
YnVzL2FyY2hlLXBsYXRmb3JtLmMuCgpJZiB0aGVzZSA3IGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBh
cmUgZGVwcmVjYXRlZCwgaXQgaXMgcmVjb21tZW5kZWQgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmNp
ZXMgb24gdGhlbSBpbiB0aGUgS2NvbmZpZyBmaWxlcy4gCklmIHRoZXkgYXJlIHN0aWxsIHVzZWZ1
bCwgaXQgaXMgcmVjb21tZW5kZWQgdG8gZGVmaW5lIHRoZW0uCgoKQmVzdCByZWdhcmRzLApZaW5n
IFN1bgpQZW5ncGVuZyBIb3UKWWFuamllIFJlbg==
