Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F706C10C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCTLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCTLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:25:43 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18FF41A94F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=JwFBS8AukYvIVWQyHgw3tatudmc/+MbXUT7y0zY9n+U=; b=d
        CmYZYPkbzYgnWwcCkaUF796RIc6KxITFWScSkY/B7QUjRE/Y1R2DK0efc2qRB0IM
        fBoIHhQ5jE5Q7leKxLVCfTLIztj1gjF+cXe1wA/4tygAZAJjoXt1AwHQwGmRLst7
        jpQR302KQRFCzqXici2EwfiXuytPPNhLCGN7h4Jl48=
Received: from 00107082$163.com ( [222.64.154.91] ) by ajax-webmail-wmsvr57
 (Coremail) ; Mon, 20 Mar 2023 19:24:28 +0800 (CST)
X-Originating-IP: [222.64.154.91]
Date:   Mon, 20 Mar 2023 19:24:28 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re:Re: [Debian Package]Regression 6.3-rc3: version is empty  for
 linux-headers installation dir
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZBgl6tbOT0GdIqb4@debian.me>
References: <33233f0e.3970.186fdf28bc7.Coremail.00107082@163.com>
 <ZBgl6tbOT0GdIqb4@debian.me>
X-NTES-SC: AL_QuycC/+avkwt7imQYekXn0oTju85XMCzuv8j3YJeN500uSrR1wEMWlVxN0fx8PqJBA+imjKQWRZI2spje6J/Zr9gMYG89sbub/6Tmk3ilmVA
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <50f29163.57b5.186fec379bc.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDnoIxtQhhk4FgXAA--.20797W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiFgw4ql44XLAjgAACsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24sIEkgd2FzIG1lYW5pbmcgdG8ganVzdCByZXBvcnQg
dGhlIHJlZ3Jlc3Npb24uCkFuZCBJIGp1c3Qgc2VuZCBhIHBhdGNoIHdpdGggdGhlIHNpbXBsZSBm
aXggaW4gYW5vdGhlciBtYWlsLCBob3BlIHRoZSBmb3JtYXQgaXMgb2suCgoKVGhhbmtzCkRhdmlk
CgoKCgoKCgpBdCAyMDIzLTAzLTIwIDE3OjIyOjUwLCAiQmFnYXMgU2FuamF5YSIgPGJhZ2FzZG90
bWVAZ21haWwuY29tPiB3cm90ZToKPk9uIE1vbiwgTWFyIDIwLCAyMDIzIGF0IDAzOjM2OjE2UE0g
KzA4MDAsIERhdmlkIFdhbmcgd3JvdGU6Cj4+IFRoaXMgY291bGQgYmUgZml4ZWQgYnkgYWRkaW5n
IGJhY2sgdGhlIGRlZmluaXRpb24gZm9yIHZlcnNpb24KPj4gCj4+IGRpZmYgLS1naXQgYS9zY3Jp
cHRzL3BhY2thZ2UvYnVpbGRkZWIgYi9zY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKPj4gaW5kZXgg
YzVhZTU3MTY3ZDdjLi4xODcwYjI0ODUyMTcgMTAwNzU1Cj4+IC0tLSBhL3NjcmlwdHMvcGFja2Fn
ZS9idWlsZGRlYgo+PiArKysgYi9zY3JpcHRzL3BhY2thZ2UvYnVpbGRkZWIKPj4gQEAgLTIxNiw2
ICsyMTYsNyBAQCBpbnN0YWxsX2xpYmNfaGVhZGVycyAoKSB7Cj4+ICBybSAtZiBkZWJpYW4vZmls
ZXMKPj4gIAo+PiAgcGFja2FnZXNfZW5hYmxlZD0kKGRoX2xpc3RwYWNrYWdlcykKPj4gK3ZlcnNp
b249JEtFUk5FTFJFTEVBU0UKPj4gIAo+PiAgZm9yIHBhY2thZ2UgaW4gJHtwYWNrYWdlc19lbmFi
bGVkfQo+PiAgZG8KPj4gLS0KPgo+SGksCj4KPkxvb2tzIGxpa2UgeW91ciBmaXh1cCBpcyBjb3Jy
dXB0ZWQgKHRhYnMgY29udmVydGVkIHRvIHNwYWNlcykuIENhbiB5b3UKPnBsZWFzZSBzZW5kIHRo
ZSBwcm9wZXIgcGF0Y2ggKHNlZQo+RG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5yc3QpPwo+Cj5BbHNvLCBzZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2VtYWlsLWNsaWVu
dHMucnN0KSBmb3IgZ3VpZGVzIG9uCj5jb25maWd1cmluZyB5b3VyIGVtYWlsIGNsaWVudCBmb3Ig
a2VybmVsIGRldmVsb3BtZW50Lgo+Cj5UaGFua3MuCj4KPi0tIAo+QW4gb2xkIG1hbiBkb2xsLi4u
IGp1c3Qgd2hhdCBJIGFsd2F5cyB3YW50ZWQhIC0gQ2xhcmEK
