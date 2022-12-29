Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56CC658C94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiL2MLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2MLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:11:41 -0500
X-Greylist: delayed 942 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 04:11:40 PST
Received: from m13122.mail.163.com (m13122.mail.163.com [220.181.13.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ADE765AE;
        Thu, 29 Dec 2022 04:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=dVm2duRCYQpcLBg/h6h7ZaAY5XzexeXnERJ1uibrhjI=; b=f
        XHvF1ImNoQ1/Tff3vBhJXjopdx2O2Pp84u3qUo6LNhtbwogjLUaa41+R8WmDKcak
        7HaAyWNJgNlezFgo2j+sLnQPqRKER5MaMQQL0IOtHyNFOn8MTAI5EkEoG5CW7ZsS
        vH0QgPBlVfulDIajUOOJYhsAGp3nyp30xN0Hfm1qNw=
Received: from andyshrk$163.com ( [58.22.7.114] ) by ajax-webmail-wmsvr122
 (Coremail) ; Thu, 29 Dec 2022 19:55:32 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date:   Thu, 29 Dec 2022 19:55:32 +0800 (CST)
From:   "Andy Yan" <andyshrk@163.com>
To:     "Heiko Stuebner" <heiko@sntech.de>
Cc:     krzysztof.kozlowski+dt@linaro.org, piotr.oniszczuk@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re:Re: [PATCH 2/2] arm64: dts: rockchip: Enable wifi module AP6398s
 for rk3566 box demo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <17226287.uLZWGnKmhe@phil>
References: <20221225114915.3518502-1-andyshrk@163.com>
 <20221225114953.3518595-1-andyshrk@163.com> <17226287.uLZWGnKmhe@phil>
X-NTES-SC: AL_QuycAP+au0Eo5CSeZOkZnEobh+Y5UcK2s/ki2YFXN5k0nSvC4DkcY3FzN2PEyuieIQq0vha7cgNw1N95QLZJcKXVjFLqKLEiWdP6kzd/LRYB
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <98e7c6a.2e9c.1855dbcccf1.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: esGowACnSCw0gK1jVYppAA--.8778W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbivBnmXmASagkiyQABsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKSGkgSGVpa286CgoKCgoKCgoKCgoKQXQgMjAyMi0xMi0yOSAwMzoyMTozMiwgIkhlaWtvIFN0
dWVibmVyIiA8aGVpa29Ac250ZWNoLmRlPiB3cm90ZToKPkhpIEFuZHksCj4KPkFtIFNvbm50YWcs
IDI1LiBEZXplbWJlciAyMDIyLCAxMjo0OTo1MyBDRVQgc2NocmllYiBBbmR5IFlhbjoKPj4gVGhl
cmUgaXMgYSBBUDYzOThzIHdpZmkvYnQgbW9kdWxlIG9uIHRoaXMgYm9hcmQuCj4+IEZpeCB0aGUg
c2RtbWMxIGR0IG5vZGUgdG8gbWFrZSB3aWZpIHdvcmsuCj4+IAo+PiBGaXhlczogMmUwNTM3YjE2
YjI1ICgiYXJtNjQ6IGR0czogcm9ja2NoaXA6IEFkZCBkdHMgZm9yIHJvY2tjaGlwIHJrMzU2NiBi
b3ggZGVtbyBib2FyZCIpCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFlhbiA8YW5keXNocmtA
MTYzLmNvbT4KPj4gLS0tCj4+IAo+PiAgLi4uL2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU2Ni1ib3gt
ZGVtby5kdHMgICAgIHwgMjYgKysrKysrKysrKysrKysrKy0tLQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1NjYtYm94LWRlbW8uZHRzIGIvYXJjaC9hcm02
NC9ib290L2R0cy9yb2NrY2hpcC9yazM1NjYtYm94LWRlbW8uZHRzCj4+IGluZGV4IGQ5NTY0OTZk
NTIyMS4uNmMwYzI0MjI2YjUyIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Jv
Y2tjaGlwL3JrMzU2Ni1ib3gtZGVtby5kdHMKPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9y
b2NrY2hpcC9yazM1NjYtYm94LWRlbW8uZHRzCj4+IEBAIC0zMjQsOCArMzI0LDEyIEBAIHdpZmlf
ZW5hYmxlX2g6IHdpZmktZW5hYmxlLWggewo+PiAgCQkJcm9ja2NoaXAscGlucyA9IDwyIFJLX1BC
MSBSS19GVU5DX0dQSU8gJnBjZmdfcHVsbF9ub25lPjsKPj4gIAkJfTsKPj4gIAo+PiArCQl3aWZp
X2hvc3Rfd2FrZV9oOiB3aWZpLWhvc3Qtd2FrZS1sIHsKPj4gKwkJCXJvY2tjaGlwLHBpbnMgPSA8
MiBSS19QQjIgUktfRlVOQ19HUElPICZwY2ZnX3B1bGxfbm9uZT47Cj4+ICsJCX07Cj4+ICsKPj4g
IAkJd2lmaV8zMms6IHdpZmktMzJrIHsKPj4gLQkJCXJvY2tjaGlwLHBpbnMgPSA8MCBSS19QQjAg
MiAmcGNmZ19wdWxsX25vbmU+Owo+PiArCQkJcm9ja2NoaXAscGlucyA9IDwyIFJLX1BDNiAxICZw
Y2ZnX3B1bGxfbm9uZT47Cj4+ICAJCX07Cj4+ICAJfTsKPj4gIAo+PiBAQCAtMzkxLDE2ICszOTUs
MzAgQEAgJnNkbW1jMCB7Cj4+ICB9Owo+PiAgCj4+ICAmc2RtbWMxIHsKPj4gKwkvKiBXaUZpICYg
QlQgY29tYm8gbW9kdWxlIEFNUEFLIEFQNjM5OFMgKi8KPj4gKwkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKPj4gKwkjc2l6ZS1jZWxscyA9IDwwPjsKPj4gIAlidXMtd2lkdGggPSA8ND47Cj4+ICsJY2xv
Y2stZnJlcXVlbmN5ID0gPDE1MDAwMDAwMD47Cj4+ICsJY2FwLXNkaW8taXJxOwo+PiAgCWNhcC1z
ZC1oaWdoc3BlZWQ7Cj4+IC0JZGlzYWJsZS13cDsKPj4gKwlzZC11aHMtc2RyMTA0Owo+PiArCWtl
ZXAtcG93ZXItaW4tc3VzcGVuZDsKPj4gIAltbWMtcHdyc2VxID0gPCZzZGlvX3B3cnNlcT47Cj4+
ICAJbm9uLXJlbW92YWJsZTsKPj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+PiAgCXBp
bmN0cmwtMCA9IDwmc2RtbWMxX2J1czQgJnNkbW1jMV9jbWQgJnNkbW1jMV9jbGs+Owo+PiAtCXZt
bWMtc3VwcGx5ID0gPCZ2Y2NfM3YzPjsKPj4gLQl2cW1tYy1zdXBwbHkgPSA8JnZjY2FfMXY4PjsK
Pgo+d2h5IGFyZSB5b3UgcmVtb3ZpbmcgdGhlIG1tYy1zdXBwbGllcyBoZXJlPwo+VGhlIHN1cHBs
aWVzIG5lZWRlZCBmb3IgbW1jIHRvIHdvcmsgc2hvdWxkIHZlcnkgbXVjaCBiZSBwcmVzZW50Cj5J
IHRoaW5rLCBlc3BlY2lhbGx5IHRvIGFsc28gbWFrZSBzdXJlIHNvbWV0aGluZyBlbHNlIGRvZXNu
J3QKPnR1cm4gdGhlbSBvZmYuCgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMsIEkgd2lsbCBmaXgg
aXQgaW4gVjIuCgo+Cj5IZWlrbwo+Cj4+ICAJc3RhdHVzID0gIm9rYXkiOwo+PiArCj4+ICsJYnJj
bWY6IHdpZmlAMSB7Cj4+ICsJCWNvbXBhdGlibGUgPSAiYnJjbSxiY200MzI5LWZtYWMiOwo+PiAr
CQlyZWcgPSA8MT47Cj4+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8yPjsKPj4gKwkJaW50
ZXJydXB0cyA9IDxSS19QQjIgR1BJT19BQ1RJVkVfSElHSD47Cj4+ICsJCWludGVycnVwdC1uYW1l
cyA9ICJob3N0LXdha2UiOwo+PiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+PiArCQlw
aW5jdHJsLTAgPSA8JndpZmlfaG9zdF93YWtlX2g+Owo+PiArCX07Cj4+ICB9Owo+PiAgCj4+ICAm
c3BkaWYgewo+PiAKPgo+Cj4K
