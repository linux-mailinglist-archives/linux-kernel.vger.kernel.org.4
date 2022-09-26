Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CA5E9CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiIZJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiIZJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:02:38 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B8293ED45;
        Mon, 26 Sep 2022 02:02:30 -0700 (PDT)
Received: from zhuyinbo$loongson.cn ( [10.180.13.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 26 Sep 2022 17:02:24
 +0800 (GMT+08:00)
X-Originating-IP: [10.180.13.64]
Date:   Mon, 26 Sep 2022 17:02:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Yinbo Zhu" <zhuyinbo@loongson.cn>
To:     "Joe Perches" <joe@perches.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>
Subject: Re: Re: [PATCH v2 1/3] MAINTAINERS: add maintainer for thermal
 driver for loongson2 SoCs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <19451295e1563de5e6628e51fa8222b843f55eed.camel@perches.com>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <19451295e1563de5e6628e51fa8222b843f55eed.camel@perches.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: aczo4GZvb3Rlcl90eHQ9MTk1NTo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <58fd6600.c0e4.1837908822e.Coremail.zhuyinbo@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8BxP+CgajFjqSMiAA--.7158W
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/1tbiAQABDGMwRN0PLgAAsn
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

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSm9lIFBlcmNoZXMiIDxq
b2VAcGVyY2hlcy5jb20+Cj4g5Y+R6YCB5pe26Ze0OjIwMjItMDktMjEgMTA6MDY6NTUgKOaYn+ac
n+S4iSkKPiDmlLbku7bkuro6ICJZaW5ibyBaaHUiIDx6aHV5aW5ib0Bsb29uZ3Nvbi5jbj4sICJS
YWZhZWwgSiAuIFd5c29ja2kiIDxyYWZhZWxAa2VybmVsLm9yZz4sICJEYW5pZWwgTGV6Y2FubyIg
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+LCAiQW1pdAo+ICBLdWNoZXJpYSIgPGFtaXRrQGtl
cm5lbC5vcmc+LCAiWmhhbmcgUnVpIiA8cnVpLnpoYW5nQGludGVsLmNvbT4sICJSb2IgSGVycmlu
ZyIgPHJvYmgrZHRAa2VybmVsLm9yZz4sICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnPiwgbGludXgtcG1Admdlci5rZXJuZWwub3JnLCBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IOaK
hOmAgTogemhhbmdob25nY2hlbiA8emhhbmdob25nY2hlbkBsb29uZ3Nvbi5jbj4KPiDkuLvpopg6
IFJlOiBbUEFUQ0ggdjIgMS8zXSBNQUlOVEFJTkVSUzogYWRkIG1haW50YWluZXIgZm9yIHRoZXJt
YWwgZHJpdmVyIGZvciBsb29uZ3NvbjIgU29Dcwo+IAo+IE9uIFdlZCwgMjAyMi0wOS0yMSBhdCAw
OTo1NiArMDgwMCwgWWluYm8gWmh1IHdyb3RlOgo+ID4gQWRkIHpoYW5naG9uZ2NoZW4gYW5kIG15
c2VsZiBhcyBtYWludGFpbmVyIG9mIHRoZSBsb29uZ3NvbjIgU29DCj4gPiBzZXJpZXMgdGhlcm1h
bCBkcml2ZXIuCj4gW10KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
Cj4gW10KPiA+IEBAIC0xMTg5OSw2ICsxMTg5OSwxNCBAQCBGOglkcml2ZXJzLyovKmxvb25nYXJj
aCoKPiA+ICBGOglEb2N1bWVudGF0aW9uL2xvb25nYXJjaC8KPiA+ICBGOglEb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9sb29uZ2FyY2gvCj4gPiAgCj4gPiArTE9PTkdTT04yIFNPQyBT
RVJJRVMgVEhFUk1BTCBEUklWRVIKPiA+ICtNOgl6aGFuZ2hvbmdjaGVuIDx6aGFuZ2hvbmdjaGVu
QGxvb25nc29uLmNuPgo+ID4gK006CVlpbmJvIFpodSA8emh1eWluYm9AbG9vbmdzb24uY24+Cj4g
PiArTDoJbGludXgtcG1Admdlci5rZXJuZWwub3JnCj4gPiArUzoJTWFpbnRhaW5lZAo+ID4gK0Y6
CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL2xvb25nc29uMi10aGVy
bWFsLnlhbWwKPiA+ICtGOglkcml2ZXJzL3RoZXJtYWwvbG9vbmdzb24yX3RoZXJtYWwuYwo+ID4g
Kwo+ID4gIExTSUxPR0lDIE1QVCBGVVNJT04gRFJJVkVSUyAoRkMvU0FTL1NQSSkKPiA+ICBNOglT
YXRoeWEgUHJha2FzaCA8c2F0aHlhLnByYWthc2hAYnJvYWRjb20uY29tPgo+ID4gIE06CVNyZWVr
YW50aCBSZWRkeSA8c3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbT4KPiAKPiBGcm9tIHRoZSBN
QUlOVEFJTkVSUyBoZWFkZXJzOgo+IAo+IAlTOiAqU3RhdHVzKiwgb25lIG9mIHRoZSBmb2xsb3dp
bmc6Cj4gCSAgIFN1cHBvcnRlZDoJU29tZW9uZSBpcyBhY3R1YWxseSBwYWlkIHRvIGxvb2sgYWZ0
ZXIgdGhpcy4KPiAJICAgTWFpbnRhaW5lZDoJU29tZW9uZSBhY3R1YWxseSBsb29rcyBhZnRlciBp
dC4KPiAKPiBJZiB5b3UgYm90aCBhcmUgYmVpbmcgcGFpZCB0byBtYWludGFpbiB0aGlzIGRyaXZl
ciwKPiB0aGlzIFM6IGVudHJ5IHNob3VsZCBiZSBTdXBwb3J0ZWQuClNvcnJ5IGZvciByZXBseWlu
ZyB0byB5b3Ugc28gbGF0ZSwgYmVjYXVzZSB0aGlzIGVtYWlsIGhhcyBlbnRlcmVkIHRoZSBzcGFt
IGxpc3QuCkkgd2l0aCB6aGFuZ2hvbmdjaGVuIHdpbGwgZm9jdXMgb24gdGhlcm1hbCBkcml2ZXIg
YW5kIGxvb2tzIGFmdGVyIGl0IGFjdHVhbGx5LgpzbyBhZGQgemhhbmdob25nY2hlbiB3aXRoIG1l
IGFzIGxvb25nc29uMiB0aGVybWFsIG1haW50YWluZXIuCgpUS3MsCkJScywKWWluYm8gWmh1Lgo+
IAoNCg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv5Lit56eR55qE5ZWG5Lia56eY
5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq
5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So
77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW
5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ
5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq6
5bm25Yig6Zmk5pys6YKu5Lu244CCIA0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNv
bnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24gVGVjaG5vbG9neSAs
IHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFk
ZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3Rh
bCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiBvciBkaXNzZW1pbmF0aW9uKSBi
eSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJp
dGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdC4g
