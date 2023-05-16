Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8887049A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjEPJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:46:33 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 02:46:30 PDT
Received: from mail.inventec.com (mail.inventec.com [218.32.67.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C570F2;
        Tue, 16 May 2023 02:46:30 -0700 (PDT)
Received: from IEC1-EX2016-03.iec.inventec (10.15.2.59) by
 IEC1-EX2016-03.iec.inventec (10.15.2.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 17:15:47 +0800
Received: from IEC1-MSE-FE2.inventec.com (10.1.254.204) by
 IEC1-EX2016-03.iec.inventec (10.15.2.59) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 16 May 2023 17:15:47 +0800
Received: from IEC1-EX2016-02.iec.inventec (IEC1-EX2016-02.iec.inventec [10.1.254.221])
        by IEC1-MSE-FE2.inventec.com with ESMTP id 34G9FhJO052455;
        Tue, 16 May 2023 17:15:43 +0800 (GMT-8)
        (envelope-from Chen.PJ@inventec.com)
Received: from IEC1-EX2016-01.iec.inventec (10.15.2.58) by
 IEC1-EX2016-02.iec.inventec (10.1.254.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 17:15:43 +0800
Received: from IEC1-EX2016-01.iec.inventec ([fe80::ad9c:c1af:d29:f80d]) by
 IEC1-EX2016-01.iec.inventec ([fe80::ad9c:c1af:d29:f80d%7]) with mapi id
 15.01.2507.021; Tue, 16 May 2023 17:15:43 +0800
From:   =?big5?B?Q2hlbi5QSiCzr6xmpfQgVEFP?= <Chen.PJ@inventec.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?big5?B?WWUuVmljILitpnSyTSBUQU8=?= <ye.vic@inventec.com>,
        =?big5?B?SHVhbmcuQWxhbmcgtsCtXq2mIFRBTw==?= 
        <Huang.Alang@inventec.com>
Subject: [PATCH] dt-bindings: arm: aspeed: add Inventec starscream-bmc
Thread-Topic: [PATCH] dt-bindings: arm: aspeed: add Inventec starscream-bmc
Thread-Index: AQHZh9b9H4korMyllESFK0bWK7oT/Q==
Date:   Tue, 16 May 2023 09:15:43 +0000
Message-ID: <c5dd9b64b4754da8b11efefd97527a4f@inventec.com>
References: <28f0ce0a82464083ae24f9ef2f598425@inventec.com>
In-Reply-To: <28f0ce0a82464083ae24f9ef2f598425@inventec.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IEC1-EX2016-01.iec.inventec (15.01.2507.021)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.6.245.192]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: IEC1-MSE-FE2.inventec.com 34G9FhJO052455
X-TM-SNTS-SMTP: 3DB4FA82B12A3F874D9AD0E6CE5DB7C7CED8E01020EE1E34F6EC7C0C85E61F382000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9jdW1lbnQgdGhlIG5ldyBjb21wYXRpYmxlcyB1c2VkIG9uIEludmVudGVjIHN0YXJzY3JlYW0t
Ym1jDQoNClNpZ25lZC1vZmYtYnk6IENoZW4gUEogPENoZW4ucGpAaW52ZW50ZWMuY29tPg0KLS0t
DQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hc3BlZWQvYXNwZWVkLnlh
bWwgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hc3BlZWQvYXNwZWVkLnlh
bWwNCmluZGV4IDFiNTg1ZTU1NDc5MS4uZmI0Y2U1ZGYyZmEwIDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hc3BlZWQvYXNwZWVkLnlhbWwNCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1s
DQpAQCAtODIsNiArODIsNyBAQCBwcm9wZXJ0aWVzOg0KICAgICAgICAgICAgICAgLSBpYm0sZXZl
cmVzdC1ibWMNCiAgICAgICAgICAgICAgIC0gaWJtLHJhaW5pZXItYm1jDQogICAgICAgICAgICAg
ICAtIGlibSx0YWNvbWEtYm1jDQorICAgICAgICAgICAgICAtIGludmVudGVjLHN0YXJzY3JlYW0t
Ym1jDQogICAgICAgICAgICAgICAtIGludmVudGVjLHRyYW5zZm9ybWVyLWJtYw0KICAgICAgICAg
ICAgICAgLSBqYWJpbCxyYnAtYm1jDQogICAgICAgICAgICAgICAtIG51dmlhLGRjLXNjbS1ibWMN
Ci0tIA0KMi4yNS4xDQoNCg==
