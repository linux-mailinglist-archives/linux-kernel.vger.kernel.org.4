Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954E5FBEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJLBuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLBuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:50:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB62CDFB;
        Tue, 11 Oct 2022 18:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkatOZ+6LrMZ598lBTv1KwQcfBF8IwEJFSrhJzUNWCqa+Gjkc+yH1YlMPgVybB6DPP7X89k5o1IL0bvHU6O2kqDG72KbA/2sDFVKjOKbdsj3vFbXXot1c8m9tKS/axnFGR+Au26OQqCaf24BGw0uO4MF9PairLud2f7aLYf1g1P0gVjzerqV0AYn5cJ72Iz4HkWPrtIFEt9LQ/RT7pUqi/yNEii4qNxurKIl8Z/pCLIxFHWYFw/SHYjVDUIMgIQ0P1GwNK0R4sUmy/7aCu9eGe+bFkVVa4FOvaw9np/GqFs9DfdfyYDdvaRu0+GwY0LDs5FwUdOK+KNVSUO7dM90Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfreOwLLWry7JZQwrE6LhpwvFEnCNQVHrBilYhpU5q0=;
 b=T3SiIw5/SOTo3J9uY1V43eCzKdpc3cXu1Xqoe4n6MqRZ1uw8tisjvsfxlJ4DGtGkfu/ZeHcYF54M0tnDA6myAwyIKCoYHz75ziRN+NFnhmMsRqwCJFgdX5vUU7qdKs1zHFaYIH3HCQdf0KKsZumtiAPW1kKjW6kIP6sX4SMo/+HN05AwOWy06ZxYIiYJ9CzoqKZ+3lPLivu7kzByt2JrBwt8OQnYCa+0bn1XiLD34Ic3afDeq4G032bZlDqeHwiMRI9DLCdj/4llwynlG4CpN0724FCsxCMStrZwwq2glmwpr6xnRM2qFKOSjXXRsMR5vziLsrNGsBC91ZcAbAeTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfreOwLLWry7JZQwrE6LhpwvFEnCNQVHrBilYhpU5q0=;
 b=gH3HAvUv2t12QojM+WNZ9UjZkQ7wLE6lN9r8z6LKwP189GPY4Zl05VCwMGOOGjQo3z6gTsSOtwOc3bNA3B0H17lmmf9iEsNXVRGnoStqt5zo91gLeh3YTYWNTinpwNzl/NYwvSvxW6rFW78mDAVgEGHqq2ajbiyc+gnSHm4O9HWJkFdcYdRMWVh6rYCJZy7tn/YpjBSkSa+lbo8ZzugxUW/M4IK2sQaEbb/QdfHHpnO2g7Rt6QWbTdlX7BrprIHbRxxliSBPni+hrKpsFn3Om9VCP6l1eGftHoRvR8IPwRZt6E2Vy7hY5OFJx129pBpdZNTlHxb7ZaPa6rEuUHRKMw==
Received: from PS2PR03CA0004.apcprd03.prod.outlook.com (2603:1096:300:5b::16)
 by SEZPR02MB5494.apcprd02.prod.outlook.com (2603:1096:101:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 01:50:08 +0000
Received: from PSAAPC01FT007.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5b:cafe::11) by PS2PR03CA0004.outlook.office365.com
 (2603:1096:300:5b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20 via Frontend
 Transport; Wed, 12 Oct 2022 01:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 PSAAPC01FT007.mail.protection.outlook.com (10.13.38.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 01:50:07 +0000
Received: from sh-exhtc5.internal.zeku.com (10.123.154.252) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Wed, 12 Oct 2022 09:50:06 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc5.internal.zeku.com (10.123.154.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.5;
 Wed, 12 Oct 2022 09:50:06 +0800
Received: from sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c]) by
 sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c%5]) with mapi id
 15.01.2375.012; Wed, 12 Oct 2022 09:50:06 +0800
From:   =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?utf-8?B?546L5aSn5a6HKEpvaG4gV2FuZyk=?= <wangdayu@zeku.com>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        =?utf-8?B?6ams5a6P5LyfKE1hdHRoZXcgTWEp?= <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO
 card
Thread-Topic: [PATCH] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
Thread-Index: Adjd3PNYlSht24hPpUSZ9pMM6h5fsA==
Date:   Wed, 12 Oct 2022 01:50:06 +0000
Message-ID: <67f722b4bfe84b01bbbf37258a278a68@zeku.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.42.162]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT007:EE_|SEZPR02MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f3ddbd-0385-485d-18c3-08daabf4176b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/YBpx83PLG3pkhFszHsasi63QcgT7ZnMsgiznnVVYqJ6Jccv7ojOkYmMFuga2kzx8WCESa6UuhdqRuYcHqdUCVpL+lmKCO5Ax62PNl+Is+wO1VZ2ML+6CZAwXePnBkIAD71ZOXujl03XSdkpkeFrQxTZecv1Ddk5PmYVSzvuCS0Tim2Lx0zYBMuNc7CyPlx3XijaealMTMoL46n6f4pSbBbV9Kx+tivTcwF8+hf4Oe6vE9oAfXBzzQRWv1YWWFEvPgZsje9sWXIQ+8kEyPWFziRwLYcw4glHEnq95XJoWhoFK89+DnvwkA+Tz2it0ia82nKiioYPUxafuqiNi/7+vVUTMBfvelzgBU7vWJ/0f/69VAYhA3JNRiYRBJzoxRX1n+HfI6rWIW6RePoHtf8ZuvC/JFo7RxwB+Hi+SCdHS10Wx8zKFyHcvk7Uh5RZvUUZx29zPGmDqgDp7IeNEkDC3aIBu3F4YJfbvDBmohjzKQ3tnL1+biJ5EXZF7sZPiyEwriIvX/Ho0VHBlks1rbU/3S+qiqZ9ox8goxMAITP6ATu/a3dyPzLYg4Vyuuw0cHYm2rEkNn8RuFY9NyGs5PBDd72iDDd0edIZEO98ed1JxfrPRyL0e0TMWIYH2g5TDNUEdf5XwRoEBn+P5sgtfrhfgz0U4u6UJbRZsBUSQENk7uk+8BcI95JE1ZO7NGV7eamsstkLyVvahcwf0fCPnpZc+z67/f6VNrm+Bf5u5c9TpAjRkE3UhD5gXHHb1VlOR8S2y8cjbcXAikJ3UJ3Wptw2w==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39850400004)(451199015)(36840700001)(46966006)(8936002)(2906002)(41300700001)(5660300002)(4326008)(8676002)(70586007)(70206006)(82740400003)(86362001)(36756003)(85182001)(356005)(81166007)(426003)(336012)(478600001)(108616005)(316002)(24736004)(7696005)(2616005)(26005)(40480700001)(6916009)(36906005)(54906003)(186003)(47076005)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 01:50:07.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f3ddbd-0385-485d-18c3-08daabf4176b
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT007.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MjAyMuW5tDEw5pyIMTHml6UgMjI6NDEsIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjcgU2VwdCAyMDIyIGF0IDA0OjA0LCBXZWl6aGFv
IE91eWFuZyA8b3V5YW5nd2Vpemhhb0B6ZWt1LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBNYXR0aGV3IE1hIDxtYWhvbmd3ZWlAemVrdS5jb20+DQo+ID4NCj4gPiBTRElPIHR1cGxlIGlz
IG9ubHkgYWxsb2NhdGVkIGZvciBzdGFuZGFyZCBTRElPIGNhcmQsIGVzcGVjaWFsbHkgaXQNCj4g
PiBjYXVzZXMgbWVtb3J5IGNvcnJ1cHRpb24gaXNzdWVzIHdoZW4gdGhlIG5vbi1zdGFuZGFyZCBT
RElPIGNhcmQgaGFzDQo+ID4gcmVtb3ZlZCBzaW5jZSB0aGUgY2FyZCBkZXZpY2UncyByZWZlcmVu
Y2UgY291bnRlciBkb2VzIG5vdCBpbmNyZWFzZSBmb3INCj4gPiBpdCBhdCBzZGlvX2luaXRfZnVu
YygpLCBidXQgYWxsIFNESU8gY2FyZCBkZXZpY2UgcmVmZXJlbmNlIGNvdW50ZXIgaGFzDQo+ID4g
ZGVjcmVhc2VkIGF0IHNkaW9fcmVsZWFzZV9mdW5jKCkuDQo+ID4NCj4gPiBGaXhlczogMWE2MzJm
OGNkYzMzICgic2Rpbzogc3BsaXQgdXAgY29tbW9uIGFuZCBmdW5jdGlvbiBDSVMgcGFyc2luZyIp
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBNYSA8bWFob25nd2VpQHpla3UuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBXZWl6aGFvIE91eWFuZyA8b3V5YW5nd2Vpemhhb0B6ZWt1LmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogSm9obiBXYW5nIDx3YW5nZGF5dUB6ZWt1LmNvbT4NCj4gDQo+IEFwb2xv
Z2l6ZSBmb3IgdGhlIGRlbGF5IQ0KPiANCj4gV293LCB0aGF0J3MgYSB2ZXJ5IG9sZCBidWcgeW91
IGZpeGVkISBIb3dldmVyLCBpdCBsb29rcyBsaWtlIHRoZSBmaXhlZA0KPiBjb21taXQgc2hvdWxk
IGJlIGNoYW5nZWQgdG8gNmY1MWJlM2QzN2RmICgic2RpbzogYWxsb3cgbm9uLXN0YW5kYXJkDQo+
IFNESU8gY2FyZHMiKS4NCg0KVGhhbmtzLCBJIG1lc3NlZCB0aGUgdGFnLg0KDQo+IA0KPiBJIHRy
aWVkIHRvIGFwcGx5IHRoZSBwYXRjaCwgYnV0IHRoZSBwYXRjaCBmb3JtYXQgc2VlbXMgdG8gYmUg
Y29ycnVwdC4NCj4gRGlkIHlvdSB1c2UgZ2l0IGZvcm1hdC1wYXRjaCBhbmQgZGlkIHJ1biAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCBvbg0KPiBpdD8NCj4gDQoNClllYWggSSB1c2VkIGNoZWNrcGF0
Y2gucGwgd2l0aCBzdHJpY3QgbW9kZSB0byBjaGVjayB0aGlzIHBhdGNoLCBhbmQgaXQNCmhhcyBu
byBvYnZpb3VzIHN0eWxlIHByb2JsZW1zLiBXaGF0J3MgdGhlIGZvcm1hdCBlcnJvciB5b3UgZ290
Pw0KDQpUaGFua3MsDQpXZWl6aGFvDQoNCg==
