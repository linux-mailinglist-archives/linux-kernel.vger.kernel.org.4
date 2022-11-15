Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6E6291B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiKOGBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKOGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:01:03 -0500
Received: from m1323.mail.163.com (m1323.mail.163.com [220.181.13.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB9112AFF;
        Mon, 14 Nov 2022 22:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=hrk0d
        bbBKzxXX4+Dgcaj55QnrSIJ7qLn9WdJODoPrYk=; b=SIcCZz46ddQl7fblmYx05
        Oi7txIxvms7eaQTRysvNNr4I698alBcz8dIC09p6rbxaEkVgGvU7LAVEnZAJj1ZI
        WQhzwxu6wGpzq7LRM0ByVe/ZmAPXRfr94890nB9TVLeT+LTg4WoSWfjJfGkUCTBK
        fm5J6dQDgnTDHGIfh1hrCw=
Received: from slark_xiao$163.com ( [112.97.55.21] ) by ajax-webmail-wmsvr23
 (Coremail) ; Tue, 15 Nov 2022 14:00:10 +0800 (CST)
X-Originating-IP: [112.97.55.21]
Date:   Tue, 15 Nov 2022 14:00:10 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     mani@kernel.org, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org
Cc:     dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH v3] bus: mhi: host: pci_generic: Add definition for some
 VIDs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20221107112700.773-1-slark_xiao@163.com>
References: <20221107112700.773-1-slark_xiao@163.com>
X-NTES-SC: AL_QuydCviSvUgq5imaZekWkkcRjuo+UMC0vfgh249fPJs0qin81gUHeUVoHmn478SlCyK3iiKRSQFx6eB5cIp8QYC2Tz9ADnGZkVyEGwrYt/iL
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <38bbe02b.1790.18479dfa5ac.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: F8GowACXZmnqKnNjNE1EAA--.17630W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxW5ZFWB2Ued3QACs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpIE1hbmksCkFueSB1cGRhdGUgYWJvdXQgdGhpcyBwYXRjaD8gCkF0IDIwMjItMTEtMDcgMTk6
Mjc6MDAsICJTbGFyayBYaWFvIiA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPlRvIG1ha2Ug
Y29kZSBuZWF0IGFuZCBmb3IgY29udmVuaWVuY2UgcHVycG9zZSwgYWRkIGRlZmluaXRpb24gZm9y
IHNvbWUKPlZJRHMuIEFkZGluZyBpdCBsb2NhbGx5IHVudGlsIHRoZXNlIFZJRHMgYXJlIHVzZWQg
aW4gbXVsdGlwbGUgcGxhY2VzLgo+Cj5TaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194
aWFvQDE2My5jb20+Cj4tLS0KPnYzOiBVcGRhdGUgZGVzY3JpcHRpb24KPnYyOiBVcGRhdGUgZGVz
Y3JpcHRpb24gYW5kIGZpeCBmb3JtYXQgaXNzdWUKPi0tLQo+IGRyaXZlcnMvYnVzL21oaS9ob3N0
L3BjaV9nZW5lcmljLmMgfCAxOCArKysrKysrKysrKy0tLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2Vu
ZXJpYy5jCj5pbmRleCBjNDI1OWNiMmQyODkuLjNhNzg5YmIyZjYzMSAxMDA2NDQKPi0tLSBhL2Ry
aXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMKPisrKyBiL2RyaXZlcnMvYnVzL21oaS9o
b3N0L3BjaV9nZW5lcmljLmMKPkBAIC0yNCw2ICsyNCwxMCBAQAo+IAo+ICNkZWZpbmUgSEVBTFRI
X0NIRUNLX1BFUklPRCAoSFogKiAyKQo+IAo+Ky8qIFBDSSBWSUQgZGVmaW5pdGlvbnMgKi8KPisj
ZGVmaW5lIFBDSV9WRU5ET1JfSURfVEhBTEVTCTB4MTI2OQo+KyNkZWZpbmUgUENJX1ZFTkRPUl9J
RF9RVUVDVEVMCTB4MWVhYwo+Kwo+IC8qKgo+ICAqIHN0cnVjdCBtaGlfcGNpX2Rldl9pbmZvIC0g
TUhJIFBDSSBkZXZpY2Ugc3BlY2lmaWMgaW5mb3JtYXRpb24KPiAgKiBAY29uZmlnOiBNSEkgY29u
dHJvbGxlciBjb25maWd1cmF0aW9uCj5AQCAtNTU3LDExICs1NjEsMTEgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG1oaV9wY2lfaWRfdGFibGVbXSA9IHsKPiAJCS5kcml2ZXJf
ZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV90ZWxpdF9mbjk5MF9pbmZvIH0sCj4gCXsgUENJ
X0RFVklDRShQQ0lfVkVORE9SX0lEX1FDT00sIDB4MDMwOCksCj4gCQkuZHJpdmVyX2RhdGEgPSAo
a2VybmVsX3Vsb25nX3QpICZtaGlfcWNvbV9zZHg2NV9pbmZvIH0sCj4tCXsgUENJX0RFVklDRSgw
eDFlYWMsIDB4MTAwMSksIC8qIEVNMTIwUi1HTCAoc2R4MjQpICovCj4rCXsgUENJX0RFVklDRShQ
Q0lfVkVORE9SX0lEX1FVRUNURUwsIDB4MTAwMSksIC8qIEVNMTIwUi1HTCAoc2R4MjQpICovCj4g
CQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9pbmZv
IH0sCj4tCXsgUENJX0RFVklDRSgweDFlYWMsIDB4MTAwMiksIC8qIEVNMTYwUi1HTCAoc2R4MjQp
ICovCj4rCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1FVRUNURUwsIDB4MTAwMiksIC8qIEVN
MTYwUi1HTCAoc2R4MjQpICovCj4gCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZt
aGlfcXVlY3RlbF9lbTF4eF9pbmZvIH0sCj4tCXsgUENJX0RFVklDRSgweDFlYWMsIDB4MjAwMSks
IC8qIEVNMTIwUi1HTCBmb3IgRkNDTCAoc2R4MjQpICovCj4rCXsgUENJX0RFVklDRShQQ0lfVkVO
RE9SX0lEX1FVRUNURUwsIDB4MjAwMSksIC8qIEVNMTIwUi1HTCBmb3IgRkNDTCAoc2R4MjQpICov
Cj4gCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9p
bmZvIH0sCj4gCS8qIFQ5OVcxNzUgKHNkeDU1KSwgQm90aCBmb3IgZVNJTSBhbmQgTm9uLWVTSU0g
Ki8KPiAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfRk9YQ09OTiwgMHhlMGFiKSwKPkBAIC01
ODUsMTYgKzU4OSwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbWhpX3Bj
aV9pZF90YWJsZVtdID0gewo+IAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9GT1hDT05OLCAw
eGUwZDkpLAo+IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX2ZveGNvbm5f
c2R4NjVfaW5mbyB9LAo+IAkvKiBNVjMxLVcgKENpbnRlcmlvbikgKi8KPi0JeyBQQ0lfREVWSUNF
KDB4MTI2OSwgMHgwMGIzKSwKPisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfVEhBTEVTLCAw
eDAwYjMpLAo+IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX212MzFfaW5m
byB9LAo+IAkvKiBNVjMxLVcgKENpbnRlcmlvbiksIGJhc2VkIG9uIG5ldyBiYXNlbGluZSAqLwo+
LQl7IFBDSV9ERVZJQ0UoMHgxMjY5LCAweDAwYjQpLAo+Kwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRP
Ul9JRF9USEFMRVMsIDB4MDBiNCksCj4gCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3Qp
ICZtaGlfbXYzMV9pbmZvIH0sCj4gCS8qIE1WMzItV0EgKENpbnRlcmlvbikgKi8KPi0JeyBQQ0lf
REVWSUNFKDB4MTI2OSwgMHgwMGJhKSwKPisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfVEhB
TEVTLCAweDAwYmEpLAo+IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX212
MzJfaW5mbyB9LAo+IAkvKiBNVjMyLVdCIChDaW50ZXJpb24pICovCj4tCXsgUENJX0RFVklDRSgw
eDEyNjksIDB4MDBiYiksCj4rCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1RIQUxFUywgMHgw
MGJiKSwKPiAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9tdjMyX2luZm8g
fSwKPiAJeyAgfQo+IH07Cj4tLSAKPjIuMTcuMQo=
