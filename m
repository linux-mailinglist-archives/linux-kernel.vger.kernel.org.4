Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43CF6E075B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDMHIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:08:54 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E404C3C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:08:52 -0700 (PDT)
Received: from ziqin_l$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app2
 (Coremail) ; Thu, 13 Apr 2023 15:08:34 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Thu, 13 Apr 2023 15:08:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY57Sr55C0?= <ziqin_l@hust.edu.cn>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Dongliang Mu" <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] soc: mediatek: mtk-svs: change the function
 IS_ERR_OR_NULL() to IS_ERR()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230406024200.3126080-1-ziqin_l@hust.edu.cn>
References: <20230406024200.3126080-1-ziqin_l@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1b48b0ec.3b004.1877971d059.Coremail.ziqin_l@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GQEQrABnSU5yqjdk_XmWAg--.41327W
X-CM-SenderInfo: bgsqjjiyqwkmo6kx23oohg3hdfq/1tbiAQoAEl7Em5AGOAAAs2
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

cGluZz8KCiJaaXFpbiBMaXUiIDx6aXFpbl9sQGh1c3QuZWR1LmNuPuWGmemBk++8mgo+IG52bWVt
X2NlbGxfZ2V0KCkgd2lsbCByZXR1cm4gYW4gRVJSX1BUUigpIG9uIGVycm9yIG9yIGEgdmFsaWQg
cG9pbnRlciB0byBhDQo+IHN0cnVjdCBudm1lbV9jZWxsIGJ1dCB3b24ndCByZXR1cm4gTlVMTCwg
dGhlIGNoZWNrIGZ1bmN0aW9uIHNob3VsZCBiZQ0KPiBJU19FUlIoKSBpbnN0ZWFkIG9mIElTX0VS
Ul9PUl9OVUxMKCkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFppcWluIExpdSA8emlxaW5fbEBodXN0
LmVkdS5jbj4NCj4gUmV2aWV3ZWQtYnk6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUuY24+
DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLXN2cy5jDQo+IGluZGV4IGE3ZWIwMTliNTE1Ny4uODEyN2ZiNmQ1ODdiIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmMNCj4gKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+IEBAIC0xNzI2LDcgKzE3MjYsNyBAQCBzdGF0aWMgaW50
IHN2c19nZXRfZWZ1c2VfZGF0YShzdHJ1Y3Qgc3ZzX3BsYXRmb3JtICpzdnNwLA0KPiAgCXN0cnVj
dCBudm1lbV9jZWxsICpjZWxsOw0KPiAgDQo+ICAJY2VsbCA9IG52bWVtX2NlbGxfZ2V0KHN2c3At
PmRldiwgbnZtZW1fY2VsbF9uYW1lKTsNCj4gLQlpZiAoSVNfRVJSX09SX05VTEwoY2VsbCkpIHsN
Cj4gKwlpZiAoSVNfRVJSKGNlbGwpKSB7DQo+ICAJCWRldl9lcnIoc3ZzcC0+ZGV2LCAibm8gXCIl
c1wiPyAlbGRcbiIsDQo+ICAJCQludm1lbV9jZWxsX25hbWUsIFBUUl9FUlIoY2VsbCkpOw0KPiAg
CQlyZXR1cm4gUFRSX0VSUihjZWxsKTsNCj4gLS0gDQo+IDIuMjUuMQ0K
