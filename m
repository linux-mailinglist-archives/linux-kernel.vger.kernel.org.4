Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEEA7298CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbjFIL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjFIL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:56:11 -0400
Received: from mail.inventec.com (mail.inventec.com [61.220.76.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA995358B;
        Fri,  9 Jun 2023 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=sEx04; d=inventec.com;
    h=from:to:cc:subject:date:message-id:in-reply-to:content-type:
      mime-version;
    bh=EEbqQOffsxMaPWtW7UGxs6N/o1lBOZW5XM+gHa3cw9k=;
    b=HV2w3Rba7JA1eR1IwRlZkvNJqC8XgJGOJWG+jbZ7EBlvEb4FUBas8yC8ssuU3M
      0srULzYZecrVeKFKzCyVoSNu21ISNBCVK+vSPDwjQpX0ua4WL8O+6Z/laE7dFT
      rZqmJhNg281fgB5UtYeUIC4EFI/bSXAhrBKTGKTNz1XyWvY=
Received: from IEC1-EX2016-03.iec.inventec (10.15.2.59) by
 IEC1-EX2016-04.iec.inventec (10.1.254.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:52:34 +0800
Received: from IEC1-MSE-FE2.inventec.com (10.1.254.204) by
 IEC1-EX2016-03.iec.inventec (10.15.2.59) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:52:34 +0800
Received: from IEC1-EX2016-02.iec.inventec (IEC1-EX2016-02.iec.inventec [10.1.254.221])
        by IEC1-MSE-FE2.inventec.com with ESMTP id 359BqS66062581;
        Fri, 9 Jun 2023 19:52:28 +0800 (GMT-8)
        (envelope-from Chen.PJ@inventec.com)
Received: from IEC1-EX2016-01.iec.inventec (10.15.2.58) by
 IEC1-EX2016-02.iec.inventec (10.1.254.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:52:28 +0800
Received: from IEC1-EX2016-01.iec.inventec ([fe80::3cbc:265e:12a1:d39b]) by
 IEC1-EX2016-01.iec.inventec ([fe80::3cbc:265e:12a1:d39b%7]) with mapi id
 15.01.2507.023; Fri, 9 Jun 2023 19:52:28 +0800
From:   =?big5?B?Q2hlbi5QSiCzr6xmpfQgVEFP?= <Chen.PJ@inventec.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     =?big5?B?WWUuVmljILitpnSyTSBUQU8=?= <ye.vic@inventec.com>,
        =?big5?B?SHVhbmcuQWxhbmcgtsCtXq2mIFRBTw==?= 
        <Huang.Alang@inventec.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec starscream-bmc
Thread-Topic: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec
 starscream-bmc
Thread-Index: AQHZmsjdyWzKt8FWXUGyE1efizUsDQ==
Date:   Fri, 9 Jun 2023 11:52:28 +0000
Message-ID: <c5f1fbb0e6754394af41eb5083f64d89@inventec.com>
References: <b039b1b2673644af84db8f803bc7d156@inventec.com>
In-Reply-To: <b039b1b2673644af84db8f803bc7d156@inventec.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IEC1-EX2016-01.iec.inventec (15.01.2507.023)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.6.245.192]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: IEC1-MSE-FE2.inventec.com 359BqS66062581
X-TM-SNTS-SMTP: 8FC9931BA941FCBC45B2527A75CA23D9CCB5FC066D5F223A6C00B5FF3DDBF2052000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
