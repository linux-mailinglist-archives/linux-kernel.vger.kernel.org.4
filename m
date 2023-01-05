Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2C65EEAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjAEOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjAEOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:25:06 -0500
Received: from 163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2665F559C3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=3GW9Z5cfgz8pMeZ04XtLdblMO6HBSQ4K2QmhpdPFwtI=; b=i
        JDbvGMtGWRwMnS4DfkqFXRRnTNRQSv5Bs7neods8M3lbHIf2rrGdlaKKWh6e68w0
        ofNeh3J9acWZ540IuKOqXJvHLj7k7w4CVs6iGvXy9NT2xQJLokwEtVUF1v6Rf924
        VfVGQWza33XgLDRL+qKZuuBq2lhf17dahL9oaeVfNg=
Received: from 00107082$163.com ( [222.64.110.75] ) by ajax-webmail-wmsvr57
 (Coremail) ; Thu, 5 Jan 2023 22:24:55 +0800 (CST)
X-Originating-IP: [222.64.110.75]
Date:   Thu, 5 Jan 2023 22:24:55 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     linux-kernel@vger.kernel.org
Subject: [proc/vmstat]set nr_kernel_stack in vmstat to nr_threads
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuycAPWZt04i4ymZZekZnEoUjug3W8K5v/kk3Y9VOp80uSrB3DkQRmFEH2bS4cijKz+2rga6dTpM48dRVJlcTa41Z5AdEw8Ny3ZhjGVrE2Ww
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <41beab3a.4f68.1858252166b.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wBnasq43bZjeo4CAA--.15258W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbivBftqmASalA6wwAAsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bnJfa2VybmVsX3N0YWNrIGluIC9wcm9jL3Ztc3RhdCBpcyB2ZXJ5IGNvbmZ1c2luZywgaXRzIHZh
bHVlIGlzIG5vdyB0aGUgc2FtZSBhcyBLZXJuZWxTdGFjayBpbiAvcHJvYy9tZW1pbmZvLAppbmRp
Y2F0aW5nIGtlcm5lbCBzdGFjayBtZW1vcnkgdXNhZ2UgaW4gS0IuICBJdCB3b3VsZCBiZSBoZWxw
ZnVsIHRvIGV4cG9zZSBhIHN0YXQgYWJvdXQgdGhlIG51bWJlciBvZiBrZXJuZWwgdGhyZWFkLAoo
dGhlIHN5c2luZm8gc3lzY2FsbCByZXR1cm4gYSBwcm9jIG51bWJlciB3aXRoIHR5cGUgVTE2LCBv
dmVyZmxvdyB3b3VsZCBoYXBwZW4pLiBUaGlzIHBhdGNoIHNldCBucl9rZXJuZWxfc3RhY2sgaW4g
L3Byb2Mvdm1zdGF0CnRvIGEgdmFsdWUgZGVmaW5lZCBieSBhIGdsb2JhbCB2YXJpYWJsZSBucl90
aHJlYWRzLgoKLS0KZGlmZiAtLWdpdCBhL21tL3Ztc3RhdC5jIGIvbW0vdm1zdGF0LmMKaW5kZXgg
MWVhNmE1Y2UxYzQxLi4wMDQwYmVhYTFiMjQgMTAwNjQ0Ci0tLSBhL21tL3Ztc3RhdC5jCisrKyBi
L21tL3Ztc3RhdC5jCkBAIC0yOCw2ICsyOCw3IEBACiAjaW5jbHVkZSA8bGludXgvbW1faW5saW5l
Lmg+CiAjaW5jbHVkZSA8bGludXgvcGFnZV9leHQuaD4KICNpbmNsdWRlIDxsaW51eC9wYWdlX293
bmVyLmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQvc3RhdC5oPgogCiAjaW5jbHVkZSAiaW50ZXJu
YWwuaCIKIApAQCAtMTgzMSw5ICsxODMyLDIwIEBAIHN0YXRpYyBpbnQgdm1zdGF0X3Nob3coc3Ry
dWN0IHNlcV9maWxlICptLCB2b2lkICphcmcpCiB7CiAgICAgICAgdW5zaWduZWQgbG9uZyAqbCA9
IGFyZzsKICAgICAgICB1bnNpZ25lZCBsb25nIG9mZiA9IGwgLSAodW5zaWduZWQgbG9uZyAqKW0t
PnByaXZhdGU7Ci0KKyAgICBzdGF0aWMgbG9uZyBua3NfaSA9IC0xOyAvLyBpbmRleCBmb3IgbnJf
a2VybmVsX3N0YWNrCisgICAgaWYgKG5rc19pIDwgMCAmJiBua3NfaSA+IC0xMjgpIHsKKyAgICAg
ICAgaWYgKHN0cmNtcCgibnJfa2VybmVsX3N0YWNrIiwgdm1zdGF0X3RleHRbb2ZmXSkgPT0gMCkg
eworICAgICAgICAgICAgbmtzX2kgPSBvZmY7CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAg
ICBua3NfaS0tOworICAgICAgICB9CisgICAgfQogICAgICAgIHNlcV9wdXRzKG0sIHZtc3RhdF90
ZXh0W29mZl0pOwotICAgICAgIHNlcV9wdXRfZGVjaW1hbF91bGwobSwgIiAiLCAqbCk7CisgICAg
aWYgKG5rc19pID09IG9mZikgeworICAgICAgICBzZXFfcHV0X2RlY2ltYWxfdWxsKG0sICIgIiwg
bnJfdGhyZWFkcyk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgc2VxX3B1dF9kZWNpbWFsX3VsbCht
LCAiICIsICpsKTsKKyAgICB9CiAgICAgICAgc2VxX3B1dGMobSwgJ1xuJyk7CiAKICAgICAgICBp
ZiAob2ZmID09IE5SX1ZNU1RBVF9JVEVNUyAtIDEpIHsKCi0tCgoKRGF2aWQKCg==
