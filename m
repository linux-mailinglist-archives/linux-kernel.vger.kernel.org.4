Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D92F74FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGLGFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGLGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:05:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17A12A;
        Tue, 11 Jul 2023 23:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/269sJNbsx/3rvCe7/rkIM5iDKMhQ/s1f+n2p9ge/Q4fyr83azWoqlK3JTx3VHsviRLlOB5mFpKxhv0SMFaFagQjepWzrb/xG+lJ546q5eijqn2w74R27HAln79TFGF4O2NC0TqyzT/+YUWEh4Hs58A1IvVp7m46yNTtgAkFOPLxxqHVViIRgW8BFB9cxpgFb2XmvJl3CwzzfFGNtDcWHrNqoZzNg7w7vpPbMgkwBVX9G5jjA5/kKSwDnl3wlAI3VNACPNSfApjH2VEVLC+L3SJxWdEH5x5BqjooDi2vrel+ePAYD+E0uRx0E3Sl1GV3Wqp8ddO722rMaEn6jdiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yURTJApGbpf93P8j9+4hy8CP/Z4gwhAqowxHzSFydY=;
 b=oVhUS+3cFIfUBqoPA+EH0DMzinlhDip9sUKzgstqL2eNFOSzo5KNYXlUfHWFBoRWSM3KqZLslXsBm3Tr904XbsHEnsCFqQLEGrKiwCCFITSH292GvuhYopV0FlbS19Bw7gvpAFL2+XRxvXh/R8+4zCjcWCLb9haya32o6LDRnYO31rBVPVmnw1WUpmKhrAA53R6I8rnE3Qp8nyjyh6+ymMqxu8UF9CKn7Z95Pq+jMkO4ZeNH0x9nBhpwAvXT9wLrRyvuNaY9Don0YVlgsKXCbJbcnL7EIA2rSRVThCkAM6vsku1pmWv/TKWpjSWSiznFPZ/emIXhQ//1qYbJVJccGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yURTJApGbpf93P8j9+4hy8CP/Z4gwhAqowxHzSFydY=;
 b=BiGifSeBWMvhTpidqxA2EMnUhBZSg9+PehDYp8h1e8ryG2nK/yU/HsiospnbUwOJE5HXja5SnRIMf0supNLxZvN+91V6BffTjPZA1MsNHMfFxyHBZwONMaVlNUoSvb6ZGKSbC/LtinW7t9m41iax4firuPBrfSEB96OzpIzEPMLOtTKrSllb+Np1x6Z8O2RScR6I54igdZyPD5+72UvHXb64iBjQSXl9gTKiNofL6W3f5EvhW4DnlyhkHAvlCOzXs08dmXY+PkKDYBvz69K2Jz1oK/Bxx+3A87ExADVi9e4D//KMXQ74q5HDJMaodyVCjuZKH5Z7FjPk1BvfW/Ydlg==
Received: from OS6P279CA0104.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3d::10)
 by AM0PR10MB3731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:05:39 +0000
Received: from HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3d:cafe::2) by OS6P279CA0104.outlook.office365.com
 (2603:10a6:e10:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 06:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT102.mail.protection.outlook.com (10.152.1.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 06:05:38 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 08:05:37 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 14:05:35 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 14:05:35 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Thread-Topic: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Thread-Index: AQHZs9iTW+HS9TjwuU6ojS6PQTnTFq+05GKAgAAZfwCAABAoAIAAEeIA
Date:   Wed, 12 Jul 2023 06:05:35 +0000
Message-ID: <42d578c52a590f50f90e2378ef3e2a1522038fc2.camel@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
         <20230711091713.1113010-4-huaqian.li@siemens.com>
         <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
         <0d1b15b1016d451862b895f851c6c6c81472755f.camel@siemens.com>
         <ec89d59b-bb8d-ae7e-2284-1fd6bca22366@roeck-us.net>
In-Reply-To: <ec89d59b-bb8d-ae7e-2284-1fd6bca22366@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.129.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCDFD9BA9796CC4FBFF85AB731F5AF2C@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT102:EE_|AM0PR10MB3731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f94ed9e-70e3-438b-677a-08db829e043e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPKdKP0kb8OWoeEK7u6I54QNt1DXL79tY5f7r/oERnre2z7RmXvnacleZfHwfJ2VkiQRwzQbYO+UtKzN2+N6I8c2rSuJYluJPs+Xbm+ewsBpyNp8Zk+m1vY7msMyoGglhNvvUr+ikIOdN9kjj+h9Vf7mmGuQI0Mqs9HzkuTTR+swuOZiirWiQFtAnL4gX/XdEgn//chXdSnuBR3BxUKu0lPxmn5miMcgxnXOzFkAqiNBis+n3j8A9Vl8RSx+d42uJr8lrP+/EN3xUGyxkp7o8COft/vWaWBToNKx/oIR+qRi0vdFl2erRdf6qSJJPiS1mumE1GE5p7R4YS3Tdg3yIa2kwXbIfAR/hjlVvAZyx8cgoWszAUGQhQozekdtUq2Q/9/yeTf+e4pNYfPi18Hs1iu3F72xFN0c2m+hsPoEWTznpExo4Wqb3o7qI/dnM6dcZ2O61498RQgyHgUH5LVxNfXEkmhcZG+PuAi2dTn47aQzQYozdtb+NJQMrXdzzDrg1hliyGLTgaf28mxyXV74GdBx7RfvxDWGAbP5oXj/RKOt0GMnlX3AtO90FacOuLSIY+I6P6ABOL21nbBGZLmGGF67dv9MyKsM3olPlRa6jdV2IFmQO914OgNwD9lB3xHGxlKibkKq794xjCNZJcSUxO6HgSnK/tCttjKFwtUiOob4XJv7Ft8u0pisQY8yWQDEFcK5PeSHMcQ6WXKSSI1t1MUUxP0+k/cHxxTmahXTU848GNJ7hbB8HRwQVjLRsSIguIiWL1vZB6TVsBaH+OpdPcz5QUA2DK/2p2hGXpSK130bfTVykol1rw7/YD4qq1Av
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(81166007)(356005)(40480700001)(36860700001)(36756003)(53546011)(47076005)(956004)(2616005)(83380400001)(7416002)(8936002)(8676002)(5660300002)(110136005)(478600001)(54906003)(4326008)(316002)(70206006)(70586007)(41300700001)(26005)(186003)(336012)(2906002)(82310400005)(82960400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:05:38.9761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f94ed9e-70e3-438b-677a-08db829e043e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3731
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTExIGF0IDIyOjAxIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
IE9uIDcvMTEvMjMgMjE6MDMsIExpLCBIdWEgUWlhbiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyMy0w
Ny0xMSBhdCAxOTozMiAtMDcwMCwgR3VlbnRlciBSb2VjayB3cm90ZToKPiA+ID4gT24gNy8xMS8y
MyAwMjoxNywgaHVhcWlhbi5saUBzaWVtZW5zLmNvbcKgd3JvdGU6Cj4gPiA+ID4gRnJvbTogTGkg
SHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+Cj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBXRElPRl9DQVJEUkVTRVQgc3VwcG9ydCBmb3IgdGhlIHBsYXRmb3JtCj4g
PiA+ID4gd2F0Y2hkb2cKPiA+ID4gPiB3aG9zZSBoYXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0IHRo
aXMgZmVhdHVyZSwgdG8ga25vdyBpZiB0aGUKPiA+ID4gPiBib2FyZAo+ID4gPiA+IHJlYm9vdCBp
cyBkdWUgdG8gYSB3YXRjaGRvZyByZXNldC4KPiA+ID4gPiAKPiA+ID4gPiBUaGlzIGlzIGRvbmUg
dmlhIHJlc2VydmVkIG1lbW9yeShSQU0pLCB3aGljaCBpbmRpY2F0ZXMgaWYKPiA+ID4gPiBzcGVj
aWZpYwo+ID4gPiA+IGluZm8gc2F2ZWQsIHRyaWdnZXJpbmcgdGhlIHdhdGNoZG9nIHJlc2V0IGlu
IGxhc3QgYm9vdC4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBIdWEgUWlhbiA8
aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiDCoMKgIGRyaXZlcnMv
d2F0Y2hkb2cvcnRpX3dkdC5jIHwgNDgKPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+ID4gPiA+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMo
KykKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0
LmMKPiA+ID4gPiBiL2RyaXZlcnMvd2F0Y2hkb2cvcnRpX3dkdC5jCj4gPiA+ID4gaW5kZXggY2U4
ZjE4ZTkzYWE5Li43N2ZkNmI1NDEzN2MgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy93YXRj
aGRvZy9ydGlfd2R0LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J0aV93ZHQuYwo+
ID4gPiA+IEBAIC0xOCw2ICsxOCw3IEBACj4gPiA+ID4gwqDCoCAjaW5jbHVkZSA8bGludXgvcG1f
cnVudGltZS5oPgo+ID4gPiA+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+Cj4gPiA+ID4g
wqDCoCAjaW5jbHVkZSA8bGludXgvd2F0Y2hkb2cuaD4KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L29mLmg+Cj4gPiA+ID4gwqDCoCAKPiA+ID4gPiDCoMKgICNkZWZpbmUgREVGQVVMVF9IRUFSVEJF
QVQgNjAKPiA+ID4gPiDCoMKgIAo+ID4gPiA+IEBAIC01Miw2ICs1MywxMSBAQAo+ID4gPiA+IMKg
wqAgCj4gPiA+ID4gwqDCoCAjZGVmaW5lIERXRFNUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoEJJVCgxKQo+ID4gPiA+IMKgwqAgCj4gPiA+ID4gKyNkZWZpbmUgUE9OX1JFQVNPTl9T
T0ZfTlVNwqDCoMKgwqDCoDB4QkJCQkNDQ0MKPiA+ID4gPiArI2RlZmluZSBQT05fUkVBU09OX01B
R0lDX05VTcKgwqDCoDB4REREREREREQKPiA+ID4gPiArI2RlZmluZSBQT05fUkVBU09OX0VPRl9O
VU3CoMKgwqDCoMKgMHhDQ0NDQkJCQgo+ID4gPiA+ICsjZGVmaW5lIFBPTl9SRUFTT05fSVRFTV9C
SVRTwqDCoMKgMHhGRkZGRkZGRgo+ID4gPiA+ICsKPiA+ID4gPiDCoMKgIHN0YXRpYyBpbnQgaGVh
cnRiZWF0ID0gREVGQVVMVF9IRUFSVEJFQVQ7Cj4gPiA+ID4gwqDCoCAKPiA+ID4gPiDCoMKgIC8q
Cj4gPiA+ID4gQEAgLTE5OCw2ICsyMDQsMTEgQEAgc3RhdGljIGludCBydGlfd2R0X3Byb2JlKHN0
cnVjdAo+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgcnRpX3dkdF9kZXZpY2UgKndkdDsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgY2xrICpjbGs7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgdTMyIGxhc3RfcGlu
ZyA9IDA7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIHJlc2VydmVkX21lbV9zaXplOwo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgKnZhZGRyOwo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoHVuc2lnbmVkIGxvbmcgcGFkZHI7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIGRh
dGFbM107Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIHJlZ1s4XTsKPiA+ID4gPiDCoMKgIAo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHdkdCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigq
d2R0KSwgR0ZQX0tFUk5FTCk7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCF3ZHQpCj4g
PiA+ID4gQEAgLTI4NCw2ICsyOTUsNDMgQEAgc3RhdGljIGludCBydGlfd2R0X3Byb2JlKHN0cnVj
dAo+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiDC
oMKgIAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdmFyaWFi
bGVfdTMyX2FycmF5KHBkZXYtCj4gPiA+ID4gPiBkZXYub2Zfbm9kZSwgInJlZyIsIHJlZywKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIEFSUkFZX1NJWkUocmVnKSk7Cj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJjYW5ub3QgcmVhZCB0aGUgcmVnIGluZm8uXG4iKTsK
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnJfaW9tYXA7Cj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gPiAKPiA+ID4gVGhpcyBhYm9ydHMgaWYgdGhlIHBy
b3BlcnR5IGRvZXMgbm90IGV4aXN0LCB3aGljaCBpcwo+ID4gPiB1bmFjY2VwdGFibGUuCj4gPiA+
IEFueSBzdWNoIGFkZGl0aW9uIG11c3QgYmUgb3B0aW9uYWwuCj4gPiBBZ3JlZSwgcmVmYWN0b3Ig
aXQuCj4gPiA+IAo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoCAqIElmIHJlc2VydmVkIG1lbW9yeSBpcyBkZWZpbmVkIGZvciB3YXRjaGRv
ZyByZXNldAo+ID4gPiA+IGNhdXNlLgo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFJlYWRvdXQg
dGhlIFBvd2VyLW9uKFBPTikgcmVhc29uIGFuZCBwYXNzIHRvCj4gPiA+ID4gYm9vdHN0YXR1cy4K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0
ID09IDgpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFkZHIgPSBy
ZWdbNV07Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc2VydmVkX21l
bV9zaXplID0gcmVnWzddOwo+ID4gPiAKPiA+ID4gSXQgc2VlbXMgb2RkIHRoYXQgcmVzZXJ2ZWRf
bWVtX3NpemUgaXMgbm90IGNoZWNrZWQsCj4gPiBBQ0sKPiA+ID4gYW5kIHRoYXQgaXQgaXMgZXZl
biBwcm92aWRlZAo+ID4gPiBnaXZlbiB0aGF0IGl0IG5lZWRzIHRvIGJlIChhdCBsZWFzdCkgMjQg
Ynl0ZXMsIGFuZCBhbnkgb3RoZXIKPiA+ID4gdmFsdWUKPiA+ID4gZG9lcyBub3QgcmVhbGx5Cj4g
PiA+IG1ha2Ugc2Vuc2UuCj4gPiA+IAo+ID4gSSB3YXMgdGhpbmtnIHRvIGFkZCB0aGUgcmVsaWFi
aWxpdHksIGJ1dCBpdCBzZWVtcyB0byBiZSB1bm5lY2Vzc2FyeQo+ID4gYW5kCj4gPiBwb2ludGxl
c3MuIFdlcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCA4IGJ5dGVzIGFyZSBlbm91Z2g/Cj4gPiAKPiAK
PiBOby4KSSBndWVzcyBJIG1pc3VuZGVyc3Rvb2QgeW91LiBIZXJlIHlvdSB3YXMgc3VnZ2VzdGlu
ZyB0aGF0CnJlc2VydmVkX21lbV9zaXplIHNob3VsZCBiZSBjaGVja2VkIGFuZCBtYWtlIHN1cmUg
dGhlIHZhbHVlIHRvIGJlIGF0CmxlYXN0IDI0IGJ5dGVzLiBBbSBJIHVuZGVyc3RhbmRpbmcgeW91
IGNvcnJlY3RseT8KPiA+ID4gPiBNRU1SRU1BUF9XQik7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICh2YWRkciA9PSBOVUxMKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byBtYXAgbWVtb3J5LQo+ID4gPiA+IHJlZ2lvbi5cbiIpOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnJfaW9tYXA7Cj4gPiA+IAo+
ID4gPiBUaGlzIHJldHVybnMgOCwgd2hpY2ggd291bGQgYmUgYW4gb2RkIGVycm9yIHJldHVybi4K
PiA+ID4gCj4gPiBBQ0sscmVmYWN0b3IgaXQuCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRhdGFbMF0gPSAqdmFkZHIgJiBQT05fUkVBU09OX0lURU1fQklUUzsKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF0YVsxXSA9ICoodmFkZHIgKyAxKSAmIFBPTl9S
RUFTT05fSVRFTV9CSVRTOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
YXRhWzJdID0gKih2YWRkciArIDIpICYgUE9OX1JFQVNPTl9JVEVNX0JJVFM7Cj4gPiA+ID4gKwo+
ID4gPiAKPiA+ID4gVGhlICYgc2VlbXMgcG9pbnRsZXNzIC8gd2FzdGVmdWwuIFdoeSBpZ25vcmUg
dGhlIHVwcGVyIDMyIGJpdHMgb2YKPiA+ID4gZWFjaCBsb2NhdGlvbiA/Cj4gPiA+IEVpdGhlciBt
YWtlIGl0IHUzMiBvciBtYWtlIGl0IHU2NCBhbmQgdXNlIHRoZSBlbnRpcmUgNjQgYml0Lgo+ID4g
PiBCZXNpZGVzLAo+ID4gPiB2YWRkclswLi4yXSB3b3VsZCBtYWtlIHRoZSBjb2RlIG11Y2ggZWFz
aWVyIHRvIHJlYWQuCj4gPiA+IAo+ID4gQUNLLCByZWZhY3RvciBpdC4KPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsICJXYXRjaGRvZzogc29mID0gJWxY
LCBkYXRhID0gJWxYLAo+ID4gPiA+IGVvZgo+ID4gPiA+ID0gJWxYXG4iLAo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF0YVswXSwgZGF0YVsx
XSwgZGF0YVsyXSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoKGRhdGFbMF0gPT0gUE9OX1JFQVNPTl9TT0ZfTlVNKQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJiYgKGRhdGFbMV0gPT0gUE9OX1JFQVNPTl9N
QUdJQ19OVU0pCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
JiAoZGF0YVsxXSA9PSBQT05fUkVBU09OX01BR0lDX05VTSkpIHsKPiA+ID4gCj4gPiA+IFVubmVj
ZXNzYXJ5IGlubmVyICgpLCBhbmQgSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIGNoZWNraW5nCj4g
PiA+IGRhdGFbMV0KPiA+ID4gdHdpY2UuCj4gPiBZZWFoLCBhIHR5cG8gaGFwcGVuZWQuCj4gPiA+
IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGV2X2luZm8oZGV2LCAiV2F0Y2hkb2cgcmVzZXQgY2F1c2UKPiA+ID4gPiBkZXRlY3RlZC5cbiIp
Owo+ID4gPiAKPiA+ID4gVW5uZWNlc3Nhcnkgbm9pc2UuCj4gPiBBQ0sscmVuYW1lIGRldl9pbmZv
IHRvIGRldl9kYmcuCj4gPiA+IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgd2RkLT5ib290c3RhdHVzIHw9IFdESU9GX0NBUkRSRVNFVDsKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQodmFkZHIsIDAsIHJlc2VydmVkX21lbV9zaXplKTsK
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtdW5tYXAodmFkZHIpOwo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ID4gCj4gPiA+IEFuZCBzb21lIHJhbmRvbSBkYXRh
IGluIHRoZSBwcm9wZXJ0eSBpcyBhY2NlcHRhYmxlID8gVGhhdCBpcyBvZGQsCj4gPiA+IGVzcGVj
aWFsbHkKPiA+ID4gYWZ0ZXIgbWFuZGF0aW5nIHRoZSBwcm9wZXJ0eSBpdHNlbGYuCj4gPiA+IAo+
ID4gWWVhaCwgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGFib3V0IGhvdyB0byBzdG9yZSB0
aGUgd2F0Y2hkb2cKPiA+IHJlc2V0IGNhdXNlPwo+ID4gCj4gCj4gTm8sIGFuZCB0aGF0IGlzIG5v
dCB0aGUgcG9pbnQgSSB3YXMgdHJ5aW5nIHRvIG1ha2UuIFlvdXIgY29kZQo+IGFjdGl2ZWx5Cj4g
YWJvcnRzIHByb2JlIGlmIHRoZSAicmVnIiBwcm9wZXJ0eSBkb2VzIG5vdCBleGlzdCBhdCBhbGws
IGJ1dCB0aGVuIGl0Cj4gc2lsZW50bHkgaWdub3JlcyBpZiBpdCBjb250YWlucyBhIHJhbmRvbSBu
dW1iZXIgb2YgZWxlbWVudHMgKG90aGVyCj4gdGhhbiA4KS4gRm9yIGV4YW1wbGUsIHNvbWV0aGlu
ZyBsaWtlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MHgxMjM0IDB4
NTY3OD4KPiBpcyBzaWxlbnRseSBpZ25vcmVkLiBJZiBhbnl0aGluZywgX3RoYXRfIHNob3VsZCBy
ZXR1cm4gLUVJTlZBTAo+IGJlY2F1c2UgaXQgaXMgb2J2aW91c2x5IHdyb25nLgpOb3cgSSBnZXQg
aXQsIG1hbnkgdGhhbmtzIGZvciBwb2ludGluZyBvdXQuCj4gCj4gT24gYSBoaWdoZXIgbGV2ZWws
IHRoZSBlbnRpcmUgY29kZSBwdXp6bGVzIG1lLiBPYnZpb3VzbHkgdGhlcmUKPiBtdXN0IGJlIGEg
bWVhbnMgZm9yIHRoZSBCSU9TIG9yIFJPTU1PTiB0byB3cml0ZSBQT05fUkVBU09OX1NPRl9OVU0K
PiBpbnRvIHNvbWUgbWVtb3J5IGFyZWEuIFRoYXQgbWVhbnMgdGhlIEJJT1MvUk9NTU9OIG11c3Qg
YmUgYWJsZQo+IHRvIGRldGVjdCB0aGF0IHNpdHVhdGlvbi4gV2h5IG5vdCB1c2UgdGhlIHNhbWUg
Y29kZSB0byBkZXRlY3QgdGhpcwo+IGluIHRoZSBkcml2ZXIgd2l0aG91dCB0aGUgY29tcGxleGl0
eSBvZiBwYXNzaW5nIGl0IGZyb20gQklPUy9ST01NT04KPiB0byBkcml2ZXIgaW4gc29tZSByYW5k
b20gbWVtb3J5IGFyZWEgPwo+IApJbiBUSSBBTTY1eCBjYXNlcywgdGhlIGhhcmR3YXJlIGlzIG5v
dCBjYXBhYmxlIG9mIGlzc3VpbmcgYSByZXNldCBvbgppdHMgb3duLCBhbmQgaXMgbm90IHBvc3Np
YmxlIHRvIHJlY29yZCBvciBkZXRlY3QgdGhlIHdhdGNoZG9nIHJlc2V0CnNpdHVhdGlvbi4gU28g
YGszLXJpdC13ZHRgIGZpcm13YXJlIHdoaWNoIHJ1bnMgaW4gYSBtY3UgY29yZSB3YXMgdXNlZAp0
byBkZXRlY3QgdGhlIHdhdGNoZG9nIGludGVycnVwdCBhbmQgcmVzZXQgdGhlIFNvYy4gSGVyZSBJ
IGFtIHRyeWluZyB0bwp3cml0ZSB0aGUgcmVhc29uIGluIHRoaXMgZmlybXdhcmUgd2hlbiB3YXRj
aGRvZyBpbnRlcnJ1cHQgaGFwcGVucywgYW5kCnJlYWQgaXQgb3V0IGluIGtlcm5lbC4KCj4gPiBC
ZXN0IHJlZ2FyZHMsCj4gPiBMaSBIdWEgUWlhbgo+ID4gPiA+ICsKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqB3YXRjaGRvZ19pbml0X3RpbWVvdXQod2RkLCBoZWFydGJlYXQsIGRldik7Cj4gPiA+
ID4gwqDCoCAKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSB3YXRjaGRvZ19yZWdpc3Rl
cl9kZXZpY2Uod2RkKTsKPiA+ID4gCj4gPiAKPiAKCg==
