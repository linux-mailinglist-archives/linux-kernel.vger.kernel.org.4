Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD096C7D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCXMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:01:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C6223C62;
        Fri, 24 Mar 2023 05:01:23 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21BC66603118;
        Fri, 24 Mar 2023 12:01:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679659282;
        bh=dr+N/JcWG1jfg3DjYWBJI/Siew3Yosf/76j1HVDo89c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oPn1UimwgYIPjM/W692u/4rY8Y3Ut3WIyrKeD2NFxPVH1nQa4l6XRl9WjjLuKg4Ax
         IOhbI/lhYi3hBxbnOMFXY64xI8PKpxzeC08Vz9Sw4oqXOGhZKPAg6v25OJKW/OPKT7
         9MTGP/pYR35NzOgfCqNV4lg9RtCDUrPASaInx9GKoYjUTrfo7QcK5+i2bhTEPqImM3
         GfWUsWh+mCp5Mm6EWOMzjIhRkauiSfM26jtwr5QUajkVoxTLnn+gbdNPTJXc+fWoQo
         Tsve3ePvPkVCueUU9zcpaFKVY3zWWXRjyqpXUehpJf0xHPeZ8cWWgKRIozt7hn4m8R
         5vSvSQFJOvQMQ==
Message-ID: <659687a489b4baea1f2cbb879fc59037b39f7ea0.camel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings
 for K3 AM64x SoCs
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>, kernel@collabora.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Mar 2023 12:01:19 +0000
In-Reply-To: <20230308205833.GA1768401@p14s>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
         <20230302171450.1598576-2-martyn.welch@collabora.com>
         <20230308205833.GA1768401@p14s>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDEzOjU4IC0wNzAwLCBNYXRoaWV1IFBvaXJpZXIgd3JvdGU6
Cj4gT24gVGh1LCBNYXIgMDIsIDIwMjMgYXQgMDU6MTQ6NDhQTSArMDAwMCwgTWFydHluIFdlbGNo
IHdyb3RlOgo+IAo+ID4gK2V4YW1wbGVzOgo+ID4gK8KgIC0gfAo+ID4gK8KgwqDCoCByZXNlcnZl
ZC1tZW1vcnkgewo+ID4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDI+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDI+Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgIG1jdV9tNGZzc19kbWFfbWVtb3J5X3JlZ2lvbjogbTRmLWRtYS1tZW1vcnlAOWNiMDAwMDAg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBv
b2wiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MDAgMHg5Y2IwMDAwMCAw
eDAwIDB4MTAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5vLW1hcDsKPiA+ICvC
oMKgwqDCoMKgwqDCoCB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgIG1jdV9tNGZzc19tZW1v
cnlfcmVnaW9uOiBtNGYtbWVtb3J5QDljYzAwMDAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbXBhdGlibGUgPSAic2hhcmVkLWRtYS1wb29sIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlZyA9IDwweDAwIDB4OWNjMDAwMDAgMHgwMCAweGUwMDAwMD47Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBuby1tYXA7Cj4gPiArwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKg
wqAgfTsKPiA+ICsKPiA+ICvCoMKgwqAgc29jIHsKPiA+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVz
cy1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwyPjsKPiA+
ICsKPiA+ICvCoMKgwqDCoMKgwqDCoCBtYWlsYm94MF9jbHVzdGVyMDogbWFpbGJveC0wIHsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNtYm94LWNlbGxzID0gPDE+Owo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWJveF9tNF8wOiBtYm94LW00LTAgewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aSxtYm94LXJ4ID0gPDAgMCAwPjsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGksbWJveC10eCA9IDwxIDAgMD47Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gK8KgwqDCoMKgwqDCoMKgIH07Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqAgYnVzQGYwMDAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBh
dGlibGUgPSAic2ltcGxlLWJ1cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVz
cy1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0g
PDI+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzID0gPDB4MDAgMHgwNDAwMDAw
MCAweDAwIDB4MDQwMDAwMDAgMHgwMAo+ID4gMHgwMWZmMTQwMD47Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBidXNANDAwMDAwMCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDI+Owo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmFuZ2VzID0gPDB4MDAgMHgwNDAwMDAwMCAweDAwIDB4MDQwMDAwMDAg
MHgwMAo+ID4gMHgwMWZmMTQwMD47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1jdV9tNGZzczogbTRmc3NANTAwMDAwMCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSxhbTY0LW00ZnNzIjsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwMCAweDUwMDAw
MDAgMHgwMCAweDMwMDAwPiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA8MHgwMCAweDUwNDAwMDAgMHgwMCAweDEwMDAwPjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWctbmFtZXMgPSAiaXJhbSIsICJk
cmFtIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aSxzY2kg
PSA8JmRtc2M+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRp
LHNjaS1kZXYtaWQgPSA8OT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGksc2NpLXByb2MtaWRzID0gPDB4MTggMHhmZj47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXRzID0gPCZrM19yZXNldCA5IDE+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpcm13YXJlLW5hbWUgPSAiYW02
Mi1tY3UtbTRmMF8wLWZ3IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtYm94ZXMgPSA8Jm1haWxib3gwX2NsdXN0ZXIwICZtYm94X200XzA+Owo+IAo+IFRoaXMg
ZG9lc24ndCBsb29rIHJpZ2h0IHNpbmNlIG1ib3hfbTRfMCBpcyBkZWZpbmVkIHdpdGhpbgo+IG1h
aWxib3gwX2NsdXN0ZXIwLgo+IAoKTG9va2luZyBhdCBvdGhlciB1c2VycyBvZiB0aGUgb21hcCBt
YWlsYm94ZXMgKGFuZCBub3Qgd2FudGluZyB0byBzcGVuZAphZ2VzIHRyYXdsaW5nIGJhY2sgdGhy
b3VnaCB0aGUgbWFpbGluZyBsaXN0IGFyY2hpdmVzIHRvIHRyeSBhbmQgd29yawpvdXQgd2h5IGl0
J3Mgc3BlY2lmaWVkIHRoZSB3YXkgaXQgaXMpIGl0IHNlZW1zIHRoYXQgdGhpcyBpcyB0aGUgd2F5
CnRoYXQgdGhlc2UgbWFpbGJveGVzIGFyZSBzcGVjaWZpZWQuCgpGb3IgaW5zdGFuY2UgaW4gYGFy
Y2gvYXJtL2Jvb3QvZHRzL29tYXA0LWw0LmR0c2lgLCB0aGUgbWFpbGJveCBpcwpkZWZpbmVkOgoK
ICAgICAgICAgICAgICAgIG1haWxib3g6IG1haWxib3hAMCB7CiAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAidGksb21hcDQtbWFpbGJveCI7CiAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDAgMHgyMDA+OwogICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMjYgSVJRX1RZUEVfTEVWRUxfSElHSD47CiAgICAgICAgICAgICAgICAgICAg
ICAgICNtYm94LWNlbGxzID0gPDE+OwogICAgICAgICAgICAgICAgICAgICAgICB0aSxtYm94LW51
bS11c2VycyA9IDwzPjsKICAgICAgICAgICAgICAgICAgICAgICAgdGksbWJveC1udW0tZmlmb3Mg
PSA8OD47CiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hfaXB1OiBtYm94LWlwdSB7CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdGksbWJveC10eCA9IDwwIDAgMD47CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdGksbWJveC1yeCA9IDwxIDAgMD47CiAgICAgICAgICAg
ICAgICAgICAgICAgIH07CiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hfZHNwOiBtYm94LWRz
cCB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGksbWJveC10eCA9IDwzIDAgMD47
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGksbWJveC1yeCA9IDwyIDAgMD47CiAg
ICAgICAgICAgICAgICAgICAgICAgIH07CiAgICAgICAgICAgICAgICB9OwoKSXQncyB1c2VycyBp
biBgYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQuZHRzaWA6CgogICAgICAgICAgICAgICAgZHNwOiBk
c3AgewogICAgICAgICAgICAgICAgICAgICAgICAuLi4KICAgICAgICAgICAgICAgICAgICAgICAg
bWJveGVzID0gPCZtYWlsYm94ICZtYm94X2RzcD47CiAgICAgICAgICAgICAgICAgICAgICAgIC4u
LgogICAgICAgICAgICAgICAgfTsKCiAgICAgICAgICAgICAgICBpcHU6IGlwdUA1NTAyMDAwMCB7
CiAgICAgICAgICAgICAgICAgICAgICAgIC4uLgogICAgICAgICAgICAgICAgICAgICAgICBtYm94
ZXMgPSA8Jm1haWxib3ggJm1ib3hfaXB1PjsKICAgICAgICAgICAgICAgICAgICAgICAgLi4uCiAg
ICAgICAgICAgICAgICB9OwoKCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWVtb3J5LXJlZ2lvbiA9Cj4gPiA8Jm1jdV9tNGZzc19kbWFfbWVtb3J5X3JlZ2lvbj4s
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA8Jm1jdV9tNGZzc19tZW1vcnlfcmVnaW9uPjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH07Cj4gPiArwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKgwqAgfTsKPiA+IC0tIAo+ID4gMi4z
OS4xCj4gPiAKCg==

