Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49C61E893
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKGCWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGCWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:22:07 -0500
Received: from m1311.mail.163.com (m1311.mail.163.com [220.181.13.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C839CBC0A;
        Sun,  6 Nov 2022 18:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ScMxi
        eHTPar3YkNXAD90hEM0gkbOXRibaEF0UYr+a40=; b=jNQS6yQ2krnrEp2+Jnyxg
        orqjhV34FsZ3kiuG/zMsO+7mVxwCmpQJl5RiDlO7Ex1QFgULcUPJbGWA3OK2K+Zn
        z+eYU88kY+yKzo3Er5L38qjx6zOwzNxJ2B7zbX6IYvwAf42reNqRwJ/QzmX5X4/S
        8P6amf3E0XgMRXHvphBUUw=
Received: from slark_xiao$163.com ( [223.104.77.212] ) by
 ajax-webmail-wmsvr11 (Coremail) ; Mon, 7 Nov 2022 10:21:36 +0800 (CST)
X-Originating-IP: [223.104.77.212]
Date:   Mon, 7 Nov 2022 10:21:36 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Manivannan Sadhasivam" <mani@kernel.org>
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] bus: mhi: host: pci_generic: Add macro for some vids
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20221103125009.GH8434@thinkpad>
References: <20221102024437.15248-1-slark_xiao@163.com>
 <20221103125009.GH8434@thinkpad>
X-NTES-SC: AL_QuydBfuTuE4i4CGYZOkWkkcRjuo+UMC0vfgh249fPJs0vinO+wQ5bV9mJX3b/Pi2Oh2BkDioQSlTx+1FY4BWRKKqNzdpQRrMEfI6HYBHuawl
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <cbb018a.ab1.1844fe4a7e8.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: C8GowAAHVZWwa2hjQFdcAA--.10820W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQCyZGBbGFE3vwAAsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTEtMDMgMjA6NTA6MDksICJNYW5pdmFubmFuIFNhZGhh
c2l2YW0iIDxtYW5pQGtlcm5lbC5vcmc+IHdyb3RlOgo+T24gV2VkLCBOb3YgMDIsIDIwMjIgYXQg
MTA6NDQ6MzdBTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gVG8gbWFrZSBjb2RlIG5lYXQg
YW5kIGZvciBjb252ZW5pZW5jZSBwdXJwb3NlLCB1c2luZyBtYWNybyBmb3IKPj4gc29tZSB2aWRz
Lgo+Cj5zL3VzaW5nL3VzZQo+cy92aWRzL1ZJRHMKPgo+PiBSZWZlciB0byBwcmV2aW91cyBwYXRj
aCBpbiBwY2lfaWRzLmggc2lkZSwgdGhleSBhcmUKPj4gbm90IGFsbG93ZWQgdG8gYWRkIG5ldyBl
bnRyaWVzIG9mIHNpbmdsZSBkcml2ZXIgbmVlZGVkLiBTbyB3ZQo+PiBhZGQgaXQgaW4gb3VyIGxv
Y2FsIGZpbGUuCj4+Cj4KPlJlZmVyZW5jZSB0byB0aGUgcHJldmlvdXMgcGF0Y2ggaGFzIG5vIHJl
bGF0aW9uc2hpcCB3aXRoIHRoaXMgY29tbWl0IG9uY2UKPm1lcmdlZC4gSG93IGFib3V0LAo+Cj4i
VGhlc2UgbWFjcm9zIGFyZSBzdXBwb3NlZCB0byBiZSBhZGRlZCB0byBwY2lfaWRzLmguIEJ1dCB1
bnRpbCB0aGUgbWFjcm9zIGFyZQo+dXNlZCBpbiBtdWx0aXBsZSBwbGFjZXMsIGl0IGlzIG5vdCBy
ZWNvbW1lbmRlZC4gU28gYWRkaW5nIGl0IGxvY2FsbHkgZm9yIG5vdy4iCj4gCj4+IFNpZ25lZC1v
ZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJz
L2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIHwgMTggKysrKysrKysrKystLS0tLS0tCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPj4gCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIGIvZHJpdmVycy9i
dXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiBpbmRleCBjNDI1OWNiMmQyODkuLjVhYmM3Nzhh
NTI5MCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+
PiArKysgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+IEBAIC0yNCw2ICsy
NCwxMCBAQAo+PiAgCj4+ICAjZGVmaW5lIEhFQUxUSF9DSEVDS19QRVJJT0QgKEhaICogMikKPj4g
IAo+Cj5BZGQgYSBjb21tZW50LAo+Cj4vKiBQQ0kgVklEIGRlZmluaXRpb25zICovCj4KPj4gKyNk
ZWZpbmUgUENJX1ZFTkRPUl9JRF9USEFMRVMJMHgxMjY5Cj4+ICsKPgo+Tm8gbmVlZCBvZiBuZXds
aW5lCj4KPj4gKyNkZWZpbmUgUENJX1ZFTkRPUl9JRF9RVUVDVEVMCTB4MWVhYwo+PiArCj4KPkp1
c3QgdXNlIGEgc3BhY2UgYWZ0ZXIgUENJX1ZFTkRPUl9JRF9RVUVDVEVMIGxpa2UgYWJvdmUuCj4K
PlRoYW5rcywKPk1hbmkKSGkgTWFuaSwKSSBkaWRuJ3QgZ2V0IHRoZSBwb2ludCBvZiB0aGlzIGZv
cm1hdCBpc3N1ZS4KRG8geW91IG1lYW4gcmVtb3ZlIHRoYXQgbmV3bGluZSBiZXR3ZWVuIHRoZXNl
IDIgZGVmaW5pdGlvbnM/Cj4KPj4gIC8qKgo+PiAgICogc3RydWN0IG1oaV9wY2lfZGV2X2luZm8g
LSBNSEkgUENJIGRldmljZSBzcGVjaWZpYyBpbmZvcm1hdGlvbgo+PiAgICogQGNvbmZpZzogTUhJ
IGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbgo+PiBAQCAtNTU3LDExICs1NjEsMTEgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG1oaV9wY2lfaWRfdGFibGVbXSA9IHsKPj4gIAkJ
LmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3RlbGl0X2ZuOTkwX2luZm8gfSwK
Pj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9RQ09NLCAweDAzMDgpLAo+PiAgCQkuZHJp
dmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcWNvbV9zZHg2NV9pbmZvIH0sCj4+IC0J
eyBQQ0lfREVWSUNFKDB4MWVhYywgMHgxMDAxKSwgLyogRU0xMjBSLUdMIChzZHgyNCkgKi8KPj4g
Kwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9RVUVDVEVMLCAweDEwMDEpLCAvKiBFTTEyMFIt
R0wgKHNkeDI0KSAqLwo+PiAgCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlf
cXVlY3RlbF9lbTF4eF9pbmZvIH0sCj4+IC0JeyBQQ0lfREVWSUNFKDB4MWVhYywgMHgxMDAyKSwg
LyogRU0xNjBSLUdMIChzZHgyNCkgKi8KPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9R
VUVDVEVMLCAweDEwMDIpLCAvKiBFTTE2MFItR0wgKHNkeDI0KSAqLwo+PiAgCQkuZHJpdmVyX2Rh
dGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9pbmZvIH0sCj4+IC0JeyBQ
Q0lfREVWSUNFKDB4MWVhYywgMHgyMDAxKSwgLyogRU0xMjBSLUdMIGZvciBGQ0NMIChzZHgyNCkg
Ki8KPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9RVUVDVEVMLCAweDIwMDEpLCAvKiBF
TTEyMFItR0wgZm9yIEZDQ0wgKHNkeDI0KSAqLwo+PiAgCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVs
X3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9pbmZvIH0sCj4+ICAJLyogVDk5VzE3NSAoc2R4
NTUpLCBCb3RoIGZvciBlU0lNIGFuZCBOb24tZVNJTSAqLwo+PiAgCXsgUENJX0RFVklDRShQQ0lf
VkVORE9SX0lEX0ZPWENPTk4sIDB4ZTBhYiksCj4+IEBAIC01ODUsMTYgKzU4OSwxNiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbWhpX3BjaV9pZF90YWJsZVtdID0gewo+PiAg
CXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0ZPWENPTk4sIDB4ZTBkOSksCj4+ICAJCS5kcml2
ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9mb3hjb25uX3NkeDY1X2luZm8gfSwKPj4g
IAkvKiBNVjMxLVcgKENpbnRlcmlvbikgKi8KPj4gLQl7IFBDSV9ERVZJQ0UoMHgxMjY5LCAweDAw
YjMpLAo+PiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1RIQUxFUywgMHgwMGIzKSwKPj4g
IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX212MzFfaW5mbyB9LAo+PiAg
CS8qIE1WMzEtVyAoQ2ludGVyaW9uKSwgYmFzZWQgb24gbmV3IGJhc2VsaW5lICovCj4+IC0JeyBQ
Q0lfREVWSUNFKDB4MTI2OSwgMHgwMGI0KSwKPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9USEFMRVMsIDB4MDBiNCksCj4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkg
Jm1oaV9tdjMxX2luZm8gfSwKPj4gIAkvKiBNVjMyLVdBIChDaW50ZXJpb24pICovCj4+IC0JeyBQ
Q0lfREVWSUNFKDB4MTI2OSwgMHgwMGJhKSwKPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9USEFMRVMsIDB4MDBiYSksCj4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkg
Jm1oaV9tdjMyX2luZm8gfSwKPj4gIAkvKiBNVjMyLVdCIChDaW50ZXJpb24pICovCj4+IC0JeyBQ
Q0lfREVWSUNFKDB4MTI2OSwgMHgwMGJiKSwKPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9USEFMRVMsIDB4MDBiYiksCj4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkg
Jm1oaV9tdjMyX2luZm8gfSwKPj4gIAl7ICB9Cj4+ICB9Owo+PiAtLSAKPj4gMi4xNy4xCj4+IAo+
Cj4tLSAKPuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7g
r40K
