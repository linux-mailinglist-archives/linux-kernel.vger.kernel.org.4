Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F862F942
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbiKRP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiKRP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:28:34 -0500
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 07:28:31 PST
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C327176
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:28:28 -0800 (PST)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A6A61348D6E;
        Fri, 18 Nov 2022 16:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1668784780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uDpepbDz6oAsPmKRPLYkr5Mx+SABgVzOUZM4/B3U8Q=;
        b=tWKaide1exK5/CcC1vSdRgb2ES/r1jatqYzrzVo5hm+hvY2Rbap3L0lRxZ58+gbxPQg5du
        /1Po1XrDzGv/93WQdFwuiSkqAfStM2dB50QnpNwn9DDVs6/hCsUR3YR329ot+1GI4eUW2u
        wkHjgltOhAlt1VZj6KGy01q2rah0taUqalfP8N87XzLjmzrN2lLiQpxxlTHHkf3mBKy4Tc
        dqXuLawWIuXCbzl2/cdRHzcuL5qpogatjRxerI8wxyEu4WzYriTtPo3lkw/dLZ978wQ04a
        amPLfGBKD4NBxMTnV1qVAcKMRhHhDDwTG/5A8Y4Vqnq64bI2ywM1Mw2oIoT13w==
Message-ID: <79ba65cc117db8102bd8f7e30d6d44fdbd0542f1.camel@svanheule.net>
Subject: Re: [PATCH v3] dt-bindings: pinctrl: convert semtech,sx150xq
 bindings to dt-schema
From:   Sander Vanheule <sander@svanheule.net>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org
Date:   Fri, 18 Nov 2022 16:19:39 +0100
In-Reply-To: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
References: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgpPbiBUdWUsIDIwMjItMTEtMTUgYXQgMTE6MDYgKzAxMDAsIE5laWwgQXJtc3Ryb25nIHdy
b3RlOgo+IFRoaXMgY29udmVydHMgdGhlIFNlbXRlY2ggU1gxNTBYcSBiaW5kaW5ncyB0byBkdC1z
Y2hlbWFzLCBhZGQgbmVjZXNzYXJ5Cj4gYmluZGluZ3MgZG9jdW1lbnRhdGlvbiB0byBjb3ZlciBh
bGwgZGlmZmVyZW5jZXMgYmV0d2VlbiBIVyB2YXJpYW50cwo+IGFuZCBjdXJyZW50IGJpbmRpbmdz
IHVzYWdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9u
Z0BsaW5hcm8ub3JnPgo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pgo+IC0tLQo+IFRvOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4g
VG86IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Cj4gVG86IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4KPiBDYzogbGludXgtZ3Bp
b0B2Z2VyLmtlcm5lbC5vcmcKPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+IENoYW5nZXMgaW4gdjM6Cj4gLSBS
ZXNlbnQgd2l0aCBtaXNzaW5nIFRvOiBMaW51cyBXYWxsZWlqCj4gLSBMaW5rIHRvIHYyOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIxMDA1LW1kbTk2MTUtc3gxNTA5cS15YW1sLXYyLTAt
YTRhNWI4ZWVjYzdiQGxpbmFyby5vcmcKPiAKPiBDaGFuZ2VzIGluIHYyOgo+IC0gZml4ZWQgcm9i
IGNvbW1lbnRzCj4gLSBhZGRlZCByb2IncyBSZXZpZXdlZC1ieQo+IC0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMTAwNS1tZG05NjE1LXN4MTUwOXEteWFtbC12MS0w
LTBjMjY2NDliNjM3Y0BsaW5hcm8ub3JnCj4gLS0tCgpbc25pcF0KCj4gK8KgIC0gaWY6Cj4gK8Kg
wqDCoMKgwqAgcHJvcGVydGllczoKPiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZToKPiArwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnRhaW5zOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW06
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gc2VtdGVjaCxzeDE1MDNxCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gc2VtdGVjaCxzeDE1MDZxCj4gK8KgwqDCoCB0aGVuOgo+
ICvCoMKgwqDCoMKgIHBhdHRlcm5Qcm9wZXJ0aWVzOgo+ICvCoMKgwqDCoMKgwqDCoCAnLWNmZyQn
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllczoKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwaW5zOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtczoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdHRlcm46ICdeZ3Bpb1swLTE1XSQnCgpbc25pcF0K
Cj4gK8KgIC0gaWY6Cj4gK8KgwqDCoMKgwqAgcHJvcGVydGllczoKPiArwqDCoMKgwqDCoMKgwqAg
Y29tcGF0aWJsZToKPiArwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRhaW5zOgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnN0OiBzZW10ZWNoLHN4MTUwOXEKPiArwqDCoMKgIHRoZW46Cj4gK8Kg
wqDCoMKgwqAgcGF0dGVyblByb3BlcnRpZXM6Cj4gK8KgwqDCoMKgwqDCoMKgICctY2ZnJCc6Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBpbnM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGl0ZW1zOgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGF0dGVybjogJ14ob3NjaW98Z3Bpb1swLTE1XSkkJwoKU29y
cnkgdG8gYmUgc28gbGF0ZSB0byByZXBseSwgYnV0IGRvbid0IHRoZXNlIHBhdHRlcm5zIG9ubHkg
bWF0Y2ggImdwaW8wIiwgImdwaW8xIiwgYW5kICJncGlvNSI/CgpBIHF1aWNrIHNlYXJjaCBmb3Ig
c29tZSBkYXRhc2hlZXRzIHR1cm5lZCB1cCB0aGUgU1gxNTAzIGFuZCBTWDE1MDlRIHdpdGggMTYg
R1BJT3MsIHNvIEkgYXNzdW1lIHRoZQppbnRlbnRpb24gd2FzIHRvIG1hdGNoICJncGlvMCIgdG8g
ImdwaW8xNSIuIEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgIl4oZ3Bpb1swLTldfGdwaW8xWzAtNV0p
JCIgKG9yCnNvbWV0aGluZyBlcXVpdmFsZW50KS4KCkJlc3QsClNhbmRlcgo=

