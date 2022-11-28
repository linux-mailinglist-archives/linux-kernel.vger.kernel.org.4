Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1863A56E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiK1JxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiK1JxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:53:15 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78488BAB;
        Mon, 28 Nov 2022 01:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669629178; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TkDhaTaha1YZwnDpZvKRDpSR4of7zurqL6+DIukCVgEplG/pEoprJKr8lvnxIOCsBp5ILrMbymqTSrm40SgUqaqm3s0c4ydSwiFOGwW55CsoiLaDs8TlI7Nk0NIlln4A8SccnUZXaKhwESvOvTgaJwUSrRkZLA4u6FYs4VnYaDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669629178; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=RQxtNK72FsBLfreseFcEcIn2qrRvqhfKN7hWEpKOpOI=; 
        b=mJaFO6WquKGfm8d7FkhvAZjjt3hV/HohZBe3MXWxzbgHk5sNk28+5iUQoeITcEMem9iA2nRcE3XE0CTcQ5f1S9TL8F9j/QmaP9PWFaxDZ5wRB7enY09O0VofK2wiRRLiORX2OKRacBQyiAYEeqFlG6Y7e36+jqDrBoJX3KmZzvg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669629178;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=RQxtNK72FsBLfreseFcEcIn2qrRvqhfKN7hWEpKOpOI=;
        b=Q9zo4BOrqdTTcr+6bPVKXuq+Uo+Wv2jBccz2t0utu5ELYv5zXPk4g1pBueD9ckzj
        L21fTMw/y2Z5xFm19wcNI7rbSu0CLv168ZbPfshqjQ0+oM/6EUd4LBLoEphW/Gud9SW
        WTS6XTZz3l9+IrJ3NhlD73b6eqN0XgiDUhNqhiLk=
Received: from [192.168.1.191] (120.85.97.163 [120.85.97.163]) by mx.zohomail.com
        with SMTPS id 1669629176940825.6418046564406; Mon, 28 Nov 2022 01:52:56 -0800 (PST)
Message-ID: <3ad94a3fc3558da2da80d238d26f29e2c42db5c1.camel@icenowy.me>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Mon, 28 Nov 2022 17:52:51 +0800
In-Reply-To: <Y4OcngDlw/4Szt7g@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
         <20221127132448.4034-7-jszhang@kernel.org> <Y4OcngDlw/4Szt7g@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTEtMjfmmJ/mnJ/ml6XnmoQgMTc6MjEgKzAwMDDvvIxDb25vciBEb29sZXnlhpnp
gZPvvJoKPiArQ0MgSWNlbm93eQo+IAo+IE9uIFN1biwgTm92IDI3LCAyMDIyIGF0IDA5OjI0OjQ1
UE0gKzA4MDAsIEppc2hlbmcgWmhhbmcgd3JvdGU6Cj4gPiBBZGQgYSBiYWlzYyBkdHNpIGZvciB0
aGUgYm91ZmZhbG9sYWIgYmw4MDggU29DLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXNoZW5n
IFpoYW5nIDxqc3poYW5nQGtlcm5lbC5vcmc+Cj4gPiAtLS0KPiA+IMKgYXJjaC9yaXNjdi9ib290
L2R0cy9ib3VmZmFsb2xhYi9ibDgwOC5kdHNpIHwgNzQKPiA+ICsrKysrKysrKysrKysrKysrKysr
KysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykKPiA+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYm91ZmZhbG9sYWIvYmw4MDguZHRzaQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9ib3VmZmFsb2xhYi9ibDgwOC5k
dHNpCj4gPiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvYm91ZmZhbG9sYWIvYmw4MDguZHRzaQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjRiMTcwY2NjMzJl
Cj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2JvdWZmYWxv
bGFiL2JsODA4LmR0c2kKPiA+IEBAIC0wLDAgKzEsNzQgQEAKPiA+ICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjArIG9yIE1JVCkKPiA+ICsvKgo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAyMiBKaXNoZW5nIFpoYW5nIDxqc3poYW5nQGtlcm5lbC5vcmc+Cj4gPiArICovCj4gPiAr
Cj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPgo+
ID4gKwo+ID4gKy8gewo+ID4gK8KgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJib3VmZmFsb2xh
YixibDgwOCI7Cj4gPiArwqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICvC
oMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDE+Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
Y3B1cyB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGltZWJhc2UtZnJlcXVl
bmN5ID0gPDEwMDAwMDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRy
ZXNzLWNlbGxzID0gPDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXpl
LWNlbGxzID0gPDA+Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNw
dTA6IGNwdUAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29tcGF0aWJsZSA9ICJ0aGVhZCxjOTA2IiwgInJpc2N2IjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX3R5cGUgPSAiY3B1IjsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0g
PDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
LWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkLWNhY2hlLXNldHMgPSA8MjU2PjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZC1jYWNoZS1zaXplID0gPDMyNzY4
PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaS1j
YWNoZS1ibG9jay1zaXplID0gPDY0PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaS1jYWNoZS1zZXRzID0gPDEyOD47Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtc2l6ZSA9IDwzMjc2OD47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1tdS10
eXBlID0gInJpc2N2LHN2MzkiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByaXNjdixpc2EgPSAicnY2NGltYWZkYyI7Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNwdTBfaW50YzogaW50ZXJy
dXB0LWNvbnRyb2xsZXIgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpbnRlcnJ1cHQtY29udHJvbGxlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxz
ID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgI2ludGVycnVwdC1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoHh0YWw6IHh0YWwtY2xrIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAjY2xvY2stY2VsbHMgPSA8MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyogVGhpcyB2YWx1ZSBtdXN0IGJlIG92ZXJyaWRkZW4gYnkgdGhlIGJvYXJkICov
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2stZnJlcXVlbmN5ID0gPDA+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHNvYyB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVz
IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYW5nZXM7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZG1hLW5vbmNvaGVyZW50Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDE+Owo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVhcnQwOiBzZXJpYWxAMzAwMDIwMDAgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxl
ID0gImJvdWZmYWxvbGFiLGJsODA4LXVhcnQiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MHgzMDAwMjAwMCAweDEwMDA+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0g
PDIwIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8Jnh0YWw+Owo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGxpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZTAwMDAwMDAgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRp
YmxlID0gInRoZWFkLGM5MDAtcGxpYyI7Cj4gCj4gSG1tLCBASWNlbm93eSAtIHNob3VsZCB0aGlz
IHVzZSB5b3VyIG5ldyBvcGVuLWM5MDYtcGxpYyBjb21wYXRpYmxlCj4gZnJvbQo+IDIwMjIxMTIx
MDQxNzU3LjQxODY0NS00LXV3dUBpY2Vub3d5Lm1lwqA/CgpJIGFtIGFnYWluc3QgdXNpbmcgb3Bl
bmM5MDYtcGxpYy4KCk1heWJlIEkgd2lsbCBhZGQgInRoZWFkLGM5MDYtcGxpYyIsICJ0aGVhZCxj
OTAwLXBsaWMiIGFzIGFuIHZhbGlkCmNvbXBhdGlibGUsIGFzIHRoZXJlIHNlZW1zIHRvIGJlIGZl
dyBvcHRpb25zIHJlbGF0ZWQgdG8gUExJQy9DTElOVCBmb3IKQzkwNi9DOTEwIChhdCBsZWFzdCBh
cyB0aGUgb3BlbiBkb2N1bWVudCBvZiB0aGVtIHNheSkuCgo+IAo+IEFzIGlzLCBkdGJzX2NoZWNr
IGdpdmVzIGE6Cj4gYmw4MDgtc2lwZWVkLW0xcy1kb2NrLmR0YjogaW50ZXJydXB0LWNvbnRyb2xs
ZXJAZTAwMDAwMDA6IGNvbXBhdGlibGU6Cj4gJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9u
ZSBtdXN0IGJlIGZpeGVkOgo+IMKgwqDCoMKgwqDCoMKgIFsndGhlYWQsYzkwMC1wbGljJ10gaXMg
dG9vIHNob3J0Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlZyA9IDwweGUwMDAwMDAwIDB4NDAwMDAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmNw
dTBfaW50Ywo+ID4gMHhmZmZmZmZmZj4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA8JmNwdTBfaW50YyA5PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDA+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjaW50ZXJydXB0
LWNlbGxzID0gPDI+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByaXNjdixuZGV2ID0gPDY0PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Owo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiA+ICt9Owo+ID4gLS0gCj4gPiAyLjM4LjEK
PiA+IAo+ID4gCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0Cj4gPiBsaW51eC1yaXNjdkBsaXN0cy5p
bmZyYWRlYWQub3JnCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXJpc2N2Cgo=

