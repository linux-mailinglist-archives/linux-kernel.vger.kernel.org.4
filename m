Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AE462412C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKJLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKJLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:15:02 -0500
Received: from m13114.mail.163.com (m13114.mail.163.com [220.181.13.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4DB02870A;
        Thu, 10 Nov 2022 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TZJpb
        OcFFeyqiQRDIdE1+HY4QipIZ+rgMxxRMwDZS/g=; b=ppEhLeQgq44r2pTSflDs2
        YN7Orx3I4HDxgRiIN2OoR0QNcya/fWqJQAiFT/3NphvGJijSaYaEB7gquelOPS6D
        arRitsxR1d2CqROgoT5Lr2AayL5/RHF0r/pdqpvHypp20Lt6jqC4ieRhRUVth4lD
        nq9x1a8YBGOUUrAhtQPa6s=
Received: from slark_xiao$163.com ( [223.104.68.226] ) by
 ajax-webmail-wmsvr114 (Coremail) ; Thu, 10 Nov 2022 19:14:28 +0800 (CST)
X-Originating-IP: [223.104.68.226]
Date:   Thu, 10 Nov 2022 19:14:28 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     mani@kernel.org, loic.poulain@linaro.org, dnlplm@gmail.com,
        yonglin.tan@outlook.com, fabio.porcedda@gmail.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: Re: [PATCH v2] bus: mhi: host: pci_generic: Add macro
 for some VIDs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y2j1GBLQB2N8+lUM@kroah.com>
References: <20221107084826.8888-1-slark_xiao@163.com>
 <Y2jJpT5//xBUOQMq@kroah.com>
 <28f1e702.28d7.184516dbbbb.Coremail.slark_xiao@163.com>
 <Y2jVtWPdTybNCYqX@kroah.com>
 <5b96b2e2.3a97.18451a061a3.Coremail.slark_xiao@163.com>
 <Y2j1GBLQB2N8+lUM@kroah.com>
X-NTES-SC: AL_QuydCvyct0At7iibYekWkkcRjuo+UMC0vfgh249fPJs0qCvE/wwrQFR+F1rx/e+lFTy9mzO1UCBpx+NEeYJhR695DCdo2uH20/GJ89V8YS59
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <28434d76.39c6.184613f9965.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowABXiNMU3WxjBoJYAA--.62578W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRS1ZFyPfTbhcgAAsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMTEtMDcgMjA6MDc6NTIsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMDY6MjY6MTZQTSArMDgwMCwg
U2xhcmsgWGlhbyB3cm90ZToKPldoeSBhbGwgdGhlIGJsYW5rIGxpbmVzPwoKMTYzIG1haWwgYXV0
b21hdGljYWxseSBhZGQgaXQgLCBhbmQgSSBmb3JnZXQgcmVtb3ZlIGl0LgoKPgo+PiBBdCAyMDIy
LTExLTA3IDE3OjUzOjU3LCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3
cm90ZToKPj4gPk9uIE1vbiwgTm92IDA3LCAyMDIyIGF0IDA1OjMwOjU2UE0gKzA4MDAsIFNsYXJr
IFhpYW8gd3JvdGU6Cj4+ID5BcyBJIHNhaWQsIHRoaXMgaXMganVzdCBhIGRlZmluZSwgbm90IGEg
bWFjcm8gYXQgYWxsLgo+PiA+Cj4+ID4+IEFuZCBjb3VsZCB5b3UgZ2l2ZSB5b3VyIGNvbW1lbnRz
IGluIHByZXZpb3VzIHBhdGNoLCBub3QgdGhlICdmaW5hbCcgb25lPwo+PiA+Cj4+ID5JIGRvIG5v
dCB1bmRlcnN0YW5kLCB3aGF0IHByZXZpb3VzIHBhdHJjaD8gIFdoYXQgImZpbmFsIiBvbmU/ICBX
aGF0IGlzCj4+ID50aGUgImxhdGVzdCIgcGF0Y2g/Cj4+IHByZXZpb3VzIHBhdGNoOgo+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIxMDI3MTE1MTIzLjUzMjYtMS1zbGFya194aWFv
QDE2My5jb20vCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjEwMjgwMjM3MTEu
NDE5Ni0xLXNsYXJrX3hpYW9AMTYzLmNvbS8KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIyMTEwMjAyNDQzNy4xNTI0OC0xLXNsYXJrX3hpYW9AMTYzLmNvbS8KPj4gCj4+ICdmaW5h
bCcgcGF0Y2g6Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMDcwODQ4MjYu
ODg4OC0xLXNsYXJrX3hpYW9AMTYzLmNvbS8KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIyMTEwMTAxNTg1OC42Nzc3LTEtc2xhcmtfeGlhb0AxNjMuY29tLwo+Cj5UaGF0J3MgMiBk
aWZmZXJlbnQgdmVyc2lvbnMsIHdpdGggYSB0b3RhbCBvZiAzLgo+Cj4+IAo+PiBUaGUgJ2ZpbmFs
JyBwYXRjaCB3YXMgY29tbWl0dGVkIGFjY29yZGluZyB0byB0aGUgYWR2aWNlIG9mIHRoZSBmZWF0
dXJlCj4+IG1haW50YWluZXIuIAo+PiA+Cj4+ID4+IEluIGFub3RoZXIgcGNpX2lkcyBwYXRjaCwg
eW91IGJyZWFrIGl0IGluIHYzIGFuZCBicmVhayBpdCBoZXJlIGFnYWluIGluIHYyLgo+PiA+Cj4+
ID5JIGJyb2tlIHdoYXQ/Cj4+IFlvdSBjb3VsZCBoYXZlICB2b2ljZWQgb3V0IHN1Y2ggY29tbWVu
dCBpbiBWMSwgVjIgYmVmb3JlIHRoZSAnZmluYWwnLiAKPgo+V2UgYWxsIHJldmlldyBwYXRjaGVz
IHdoZW4gd2UgY2FuLiAgVGhlcmUgaXMgbm8gcnVsZSB0aGF0IHBlb3BsZSBjYW4gbm90Cj5jb21t
ZW50IG9uIG5ld2VyIHBhdGNoZXMsIG9yIG9sZGVyIG9uZXMuCj4KPkluIGZhY3QsIGl0IHdvdWxk
IGJlIHdvbmRlcmZ1bCBpZiB5b3UgY291bGQgdGFrZSBzb21lIHRpbWUgYW5kIHJldmlldwo+cGF0
Y2hlcyBmcm9tIG90aGVycy4gIEl0IHdvdWxkIGhlbHAgeW91ciB1bmRlcnN0YW5kaW5nIG9mIHRo
ZSBjb2RlIGFuZAo+aG93IHRoZSBrZXJuZWwgZGV2ZWxvcG1lbnQgcHJvY2VzcyB3b3Jrcy4KPgo+
dGhhbmtzLAo+Cj5ncmVnIGstaApBZ3JlZSB3aXRoIHRoaXMuICBCdXQgeW91IGtub3csIDUgYXR0
ZW1wdCAgIGp1c3QgZm9yIGEgbGl0dGxlIHVwZGF0ZSAgd2VyZSByZWplY3RlZApJdCdzIHNvIGZy
dXN0cmF0aW5nLiBBbnl3YXksIEkgcmUtc3VibWl0IGFub3RoZXIgdjMgcGF0Y2ggZm9yIHRoaXMg
Y2hhbmdlLgpQbGVhc2UgZ2l2ZSB5b3VyIGNvbW1lbnQgaWYgeW91IGFyZSBmcmVlLgoKVGhhbmtz
Cg==
