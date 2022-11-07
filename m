Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF061F09A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKGK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKGK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:27:31 -0500
Received: from m13110.mail.163.com (m13110.mail.163.com [220.181.13.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28939167CE;
        Mon,  7 Nov 2022 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Iezgj
        ihe3dMNgACGfpPanM3zvh99fKU3TJbsD0OFZa4=; b=UewkY+SWzGeiHNOG7iz7h
        qGT+4oOPSaUAXU++sKP8JJvTCY8whaSIGCg2yTXZRCIz6988+SFjCm2v5Nf3zdTJ
        fZGRpYoaBxtD4LdS/88ySdEMis8dA0I/7JHIPlkztRyddcnXO9yveLRlnJKbwo0k
        l+2eVlYYI5uEB9Y9nvNh88=
Received: from slark_xiao$163.com ( [112.97.52.114] ) by
 ajax-webmail-wmsvr110 (Coremail) ; Mon, 7 Nov 2022 18:26:16 +0800 (CST)
X-Originating-IP: [112.97.52.114]
Date:   Mon, 7 Nov 2022 18:26:16 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     mani@kernel.org, loic.poulain@linaro.org, dnlplm@gmail.com,
        yonglin.tan@outlook.com, fabio.porcedda@gmail.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH v2] bus: mhi: host: pci_generic: Add macro for
 some VIDs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y2jVtWPdTybNCYqX@kroah.com>
References: <20221107084826.8888-1-slark_xiao@163.com>
 <Y2jJpT5//xBUOQMq@kroah.com>
 <28f1e702.28d7.184516dbbbb.Coremail.slark_xiao@163.com>
 <Y2jVtWPdTybNCYqX@kroah.com>
X-NTES-SC: AL_QuydBfSauU8s4CCRYekWkkcRjuo+UMC0vfgh249fPJs0pCvtxAMnWFBjJnDK+smkJQyVnzeNTiZyythzUqdYWY0xnU/Bg6eXjfRlTVHEt+Hq
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b96b2e2.3a97.18451a061a3.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bsGowADnUwdI3Whj5KBFAA--.2306W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwmyZFWB2NyaHgAAs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTEtMDcgMTc6NTM6NTcsICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMDU6
MzA6NTZQTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gCj4+IAo+PiAKPj4gCj4+IAo+PiAK
Pj4gCj4+IAo+PiAKPj4gCj4+IAo+PiAKPj4gCj4+IAo+PiAKPj4gCj4+IEF0IDIwMjItMTEtMDcg
MTc6MDI6MjksICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+
PiA+T24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMDQ6NDg6MjZQTSArMDgwMCwgU2xhcmsgWGlhbyB3
cm90ZToKPj4gPj4gVG8gbWFrZSBjb2RlIG5lYXQgYW5kIGZvciBjb252ZW5pZW5jZSBwdXJwb3Nl
LCB1c2UgbWFjcm8gZm9yCj4+ID4+IHNvbWUgVklEcy4gVGhlc2UgbWFjcm9zIGFyZSBzdXBwb3Nl
ZCB0byBiZSBhZGRlZCB0byBwY2lfaWRzLmguCj4+ID4KPj4gPk5vLCB0aGV5IGFyZSBub3Qgc3Vw
cG9zZWQgdG8gYmUgYWRkZWQgdGhlcmUgYXQgYWxsLgo+PiA+Cj4+ID5BbmQgdGhleSBhcmUgbm90
IGEgIm1hY3JvIiwgaXQgaXMgYSAiI2RlZmluZSIuCj4+ID4KPj4gPj4gQnV0IHVudGlsIHRoZSBt
YWNyb3MgYXJlIHVzZWQgaW4gbXVsdGlwbGUgcGxhY2VzLCBpdCBpcyBub3QKPj4gPj4gcmVjb21t
ZW5kZWQuIFNvIGFkZGluZyBpdCBsb2NhbGx5IGZvciBub3cuCj4+ID4KPj4gPkFnYWluLCB0aGVz
ZSBhcmUgbm90IG1hY3Jvcwo+PiA+Cj4+ID50aGFua3MsCj4+ID4KPj4gPmdyZWcgay1oCj4+IAo+
PiBIaSBHcmVnLAo+PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudC4KPj4gSW4gbXkgb3Bpbmlvbiwg
TUFDUk8gYWxtb3N0IHNhbWUgYXMgYSAnI2RlZmluZScuICBNYXkgSSBrbm93IGhvdyBkbyAKPj4g
eW91IGNhbGwgc3VjaCBkZWZpbml0aW9uPwo+Cj5BcyBJIHNhaWQsIHRoaXMgaXMganVzdCBhIGRl
ZmluZSwgbm90IGEgbWFjcm8gYXQgYWxsLgo+Cj4+IEFuZCBjb3VsZCB5b3UgZ2l2ZSB5b3VyIGNv
bW1lbnRzIGluIHByZXZpb3VzIHBhdGNoLCBub3QgdGhlICdmaW5hbCcgb25lPwo+Cj5JIGRvIG5v
dCB1bmRlcnN0YW5kLCB3aGF0IHByZXZpb3VzIHBhdHJjaD8gIFdoYXQgImZpbmFsIiBvbmU/ICBX
aGF0IGlzCj50aGUgImxhdGVzdCIgcGF0Y2g/CnByZXZpb3VzIHBhdGNoOgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjIxMDI3MTE1MTIzLjUzMjYtMS1zbGFya194aWFvQDE2My5jb20v
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjEwMjgwMjM3MTEuNDE5Ni0xLXNsYXJr
X3hpYW9AMTYzLmNvbS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTEwMjAyNDQz
Ny4xNTI0OC0xLXNsYXJrX3hpYW9AMTYzLmNvbS8KCidmaW5hbCcgcGF0Y2g6Cmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMDcwODQ4MjYuODg4OC0xLXNsYXJrX3hpYW9AMTYzLmNv
bS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTEwMTAxNTg1OC42Nzc3LTEtc2xh
cmtfeGlhb0AxNjMuY29tLwoKVGhlICdmaW5hbCcgcGF0Y2ggd2FzIGNvbW1pdHRlZCBhY2NvcmRp
bmcgdG8gdGhlIGFkdmljZSBvZiB0aGUgZmVhdHVyZQptYWludGFpbmVyLiAKPgo+PiBJbiBhbm90
aGVyIHBjaV9pZHMgcGF0Y2gsIHlvdSBicmVhayBpdCBpbiB2MyBhbmQgYnJlYWsgaXQgaGVyZSBh
Z2FpbiBpbiB2Mi4KPgo+SSBicm9rZSB3aGF0PwpZb3UgY291bGQgaGF2ZSAgdm9pY2VkIG91dCBz
dWNoIGNvbW1lbnQgaW4gVjEsIFYyIGJlZm9yZSB0aGUgJ2ZpbmFsJy4gCj4KPj4gSG9uZXN0bHks
ICBpdCdzIHBvc2l0aXZlIGZvciB3aG9sZSBwcm9qZWN0LiBCdXQgaXQncyBuZWdhdGl2ZSAgZm9y
IGNvbnRyaWJ1dG9yIAo+PiBhbmQgbWFpbnRhaW5lci4gCj4KPkkgYW0gdG90YWxseSBjb25mdXNl
ZCBoZXJlIGFuZCBkbyBub3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgcmVmZXJyaW5nCj50bywg
c29ycnkuCj4KPmdyZWcgay1oCg==
