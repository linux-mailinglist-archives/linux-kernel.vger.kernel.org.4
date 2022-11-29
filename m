Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4563BE47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiK2KyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiK2KyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:54:11 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1D3EF5F869;
        Tue, 29 Nov 2022 02:54:08 -0800 (PST)
Received: by ajax-webmail-mail-app4 (Coremail) ; Tue, 29 Nov 2022 18:51:58
 +0800 (GMT+08:00)
X-Originating-IP: [106.11.200.105]
Date:   Tue, 29 Nov 2022 18:51:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 2/4] elevator: replace continue with else-if in
 elv_iosched_show
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221129083306.GB24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn>
 <852b18c086ef08baec99d08479a3558a3d5db70f.1669391142.git.nickyc975@zju.edu.cn>
 <20221129083306.GB24762@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b597732.174e6.184c303d3c8.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXXP1O5IVjlsupCA--.15542W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAg0JB1ZdtcovFgAFsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmZWx2X2xpc3QsIGxpc3QpIHsKPiA+IC0JCWlm
IChlID09IGN1cikgewo+ID4gKwkJaWYgKGUgPT0gY3VyKQo+ID4gIAkJCWxlbiArPSBzcHJpbnRm
KG5hbWUrbGVuLCAiWyVzXSAiLCBjdXItPmVsZXZhdG9yX25hbWUpOwo+ID4gLQkJCWNvbnRpbnVl
Owo+ID4gLQkJfQo+ID4gLQkJaWYgKGVsdl9zdXBwb3J0X2ZlYXR1cmVzKHEsIGUpKQo+ID4gKwkJ
ZWxzZSBpZiAoZWx2X3N1cHBvcnRfZmVhdHVyZXMocSwgZSkpCj4gPiAgCQkJbGVuICs9IHNwcmlu
dGYobmFtZStsZW4sICIlcyAiLCBlLT5lbGV2YXRvcl9uYW1lKTsKPiAKPiBMb29rcyBnb29kLiAg
QnV0IHRvIG1ha2UgdGhpcyBldmVuIG1vcmUgb2J2aW91cyBJJ2QgYWxzbyBzd2l0Y2ggdG8KPiBw
aW50aW5nIGUtPmVsZXZhdG9yX25hbWUgZm9yIHRoZSBjdXIgY2FzZSBpbnN0ZWFkIG9mIGN1ci4K
ClRoYXQncyB0cnVlbHkgYmV0dGVyLiBJJ2xsIHNlbmQgYSB2MiBzb29uLgoKVGhhbmtzIQpKaW5s
b25nIENoZW4K
