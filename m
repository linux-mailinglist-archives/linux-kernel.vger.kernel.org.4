Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA8617442
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiKCCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKCCdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:33:53 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 19:33:47 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E59D12A98;
        Wed,  2 Nov 2022 19:33:47 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Thu, 3 Nov 2022
 10:27:56 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.109]
Date:   Thu, 3 Nov 2022 10:27:56 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (amc6821) Fix unsigned expression compared with zero
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1872639a.89.1843b5106aa.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+ItJ2NjvEEBAA--.41W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAOB2FEYx0BLQALs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_05,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9od21vbi9hbWM2
ODIxLmM6MjE1OiBXQVJOSU5HOiBVbnNpZ25lZCBleHByZXNzaW9uIGNvbXBhcmVkCndpdGggemVy
bzogcmVnID4gMApkcml2ZXJzL2h3bW9uL2FtYzY4MjEuYzoyMjg6IFdBUk5JTkc6IFVuc2lnbmVk
IGV4cHJlc3Npb24gY29tcGFyZWQKd2l0aCB6ZXJvOiByZWcgPiAwCgpTaWduZWQtb2ZmLWJ5OiBL
YWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9od21vbi9hbWM2
ODIxLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL2FtYzY4MjEuYyBiL2RyaXZlcnMvaHdtb24v
YW1jNjgyMS5jCmluZGV4IDNiZmQxMmZmNGIzYy4uMWY1MzgyZjhkNTJiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2h3bW9uL2FtYzY4MjEuYworKysgYi9kcml2ZXJzL2h3bW9uL2FtYzY4MjEuYwpAQCAt
MTY2LDcgKzE2Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgYW1jNjgyMV9kYXRhICphbWM2ODIxX3VwZGF0
ZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBhbWM2ODIxX2RhdGEgKmRhdGEg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gZGF0
YS0+Y2xpZW50OwogCWludCB0aW1lb3V0ID0gSFo7Ci0JdTggcmVnOworCWludCByZWc7CiAJaW50
IGk7CiAKIAltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Ci0tIAoyLjI1LjEK
