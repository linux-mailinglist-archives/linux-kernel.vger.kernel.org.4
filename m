Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A215FE70C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJNCjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:39:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198C165518;
        Thu, 13 Oct 2022 19:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfDsjnVjDmqg7FCiumG537X8caRBB9QmaQP+98xTtcEf6YbztagDw+Py9YrifCjiOUjVmmmvfRYqEp0NU6bFBfP9uZr/vwMQpm0UXqfikwVkVJsM6lttuvkvh6OawYtRrmfkNvfYcPnaSgrkuxAoXnwF6lFpcNE2d+dtP0i/UO+5qX7mh8mr3ZUqxRqn+ktioRcVAhdWIm+ksqDdfkI5zLAjyoWkYeJQ1W7wJIVVcOjDu4tgHP7QD+RIlImyfV5KDSupxa9WB1xTkKdWrlvxspT1WV1l3GW1s9OR8aLdqcJXgJzm44+1ZVAe5/9JJnZsuobsPRYE9I7uhpWW3peIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOyoWG8vjb3uORtfsmrQSuSXDWbL40ZlhSBDl3yRIZE=;
 b=U2FVR61r8OYa1Vxr3YpIRueAN475uDLQEntSMcynKes6LJ4MjkFMSKZ+mBpeFODbTgZGB5wvKM46a55UJVe17hckHgL4ncj3dectg+Q/C73lFqDCXJudutkIYivdnJS/7/EoCIp3aE4FMKRPXVBmykQdGvKrJkkhg3IC2YOAcNcG321o5PtC96n6OhENPNYP/5V3qtYHrFVFDrkWbEASl8yimr9U6i84sKdYsr9vBwcU4m6jiOxjnshzc5hXlFrU+dnL3gmZbwQJ3m8ipJpstWUJyuTp5ThnDhHKnWRD7fMsH/5GhrFfS/4EZdTuBmzrsFS8QCHPWkfytR7CJR7Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOyoWG8vjb3uORtfsmrQSuSXDWbL40ZlhSBDl3yRIZE=;
 b=uNI0wKqRopck5o1o+UxrlfjWqeQfnPXlRIgpwz9CMy07o6Nqk96BIRondsDmrvew5rH93BKFJeR6evhueOyaGYqq1SuwhHrvhtgVVWcutLskrGHjvByQBd0yTn3JjWFC0Rzt2AwH91cxSq0Mn4z7VFl3z1722ZvVURMgD8+jXQhxentf6kPnju5O3nc/uqSH4aiTShsTMS2ot31i3UpGX0JSaLNmOMvqWPLQUyNKi5MgQi0g68nDRpgTlqarRdjat7/Wn1eSeBdrHAnscFtHfIhcRPXdqT2UKBsU/EL9pe8qe4L9cwkkjGp49nWOHOXsf2bq6oR/ZU7p9/KYoYA/Ww==
Received: from SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27) by
 HKAPR02MB4452.apcprd02.prod.outlook.com (2603:1096:203:df::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.22; Fri, 14 Oct 2022 02:39:02 +0000
Received: from SG2APC01FT0043.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:0:cafe::f2) by SG2PR04CA0165.outlook.office365.com
 (2603:1096:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 14 Oct 2022 02:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 SG2APC01FT0043.mail.protection.outlook.com (10.13.36.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 02:39:02 +0000
Received: from sh-exhtc3.internal.zeku.com (10.123.154.250) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 14 Oct 2022 10:39:02 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc3.internal.zeku.com (10.123.154.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.5;
 Fri, 14 Oct 2022 10:39:02 +0800
Received: from sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c]) by
 sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c%5]) with mapi id
 15.01.2375.012; Fri, 14 Oct 2022 10:39:02 +0800
From:   =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?utf-8?B?546L5aSn5a6HKEpvaG4gV2FuZyk=?= <wangdayu@zeku.com>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        =?utf-8?B?6ams5a6P5LyfKE1hdHRoZXcgTWEp?= <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO
 card
Thread-Topic: [PATCH] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
Thread-Index: Adjd3PNYlSht24hPpUSZ9pMM6h5fsAAArRyAAGWQn2A=
Date:   Fri, 14 Oct 2022 02:39:02 +0000
Message-ID: <4d2f9cf9f9c248a1bb18ce7e86f349d5@zeku.com>
References: <67f722b4bfe84b01bbbf37258a278a68@zeku.com>
 <CAPDyKFpfm2i2u3BKCxFEA=qZ8GiOOryhHYKNt_yyMA51sxSLJw@mail.gmail.com>
In-Reply-To: <CAPDyKFpfm2i2u3BKCxFEA=qZ8GiOOryhHYKNt_yyMA51sxSLJw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.20.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0043:EE_|HKAPR02MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2a64b0-aa72-4843-b351-08daad8d414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xmFnN/CwvmdPEpBvC0t43xs1TpcR6+iEEfBVPl4nwaFO0ObwDldAtC7J4aICaMi3xMYGGjVSM6wEiXEiNUfoqYQhLbBB8iWMIma3lZQq3IcYLkZ9N2zSsCihivLyANifL7qSdIcqBRHc/Wtbv1vsODyLPOuMaLAeHwiusaTXrqLlIbdokER3ep2hMk3UfoZvDZmRwobvUq/frMTGHNfGlCLKuSveATbAuYDLJMbdXx/gMzYr7jY5HjATrUnOyzkCv8BlyetkgOvm82afwMGkEXHnGMitYbwoaWo7+VIZ8LxGSQOs27d2F8a39yNkQA2y8w/uXbEgE4hrcU7/2XG3ORdPNcN6EKitnQkweZHDf1lGk54De75fcZpENv/ngmPhOIZu8WAjiOvqZylhidOLccSQvwEqMV/X6N1LV7vZaVQp+xWBEu229e8CdI+zAX2LmJmvMCZq6RbTVDf8bIavX6JWf4lrEvNP+Cs4sl+sMrd5kjLwLuHwhi3Unzs5JocAuHmbwV04Ow5d//s8cDlyfw45tfqcc4k5E/h2rqzOVQY395mL9HLAXwT0uEkOJCx8MhtC9qRKk44AwezsQsgyGswLkSQlKXt2YBbql+xAY/6AYemgxnQznVsajn0rttfHKBW9Q2YT7inSY/lvqHaAFNoTjkMtDEccVyIR0HnbsfBtFWFK655ihKVkAgZgWBN1vsX5V8GSYtnpiIkuIvRHTf6cXDZJRUbGG4bQFahr2DpIqfYj0jiBRBraUOgdUkIFDnS+nTZWfy5QpTLQJ0m5A==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39850400004)(451199015)(36840700001)(46966006)(6916009)(85182001)(108616005)(5660300002)(8936002)(36860700001)(478600001)(36756003)(36906005)(316002)(4326008)(70206006)(8676002)(70586007)(54906003)(82310400005)(82740400003)(41300700001)(81166007)(356005)(7696005)(47076005)(40480700001)(86362001)(83380400001)(24736004)(26005)(2616005)(336012)(426003)(186003)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 02:39:02.2348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a64b0-aa72-4843-b351-08daad8d414a
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0043.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VkbmVzZGF5LCBPY3RvYmVyIDEyLCAyMDIyIDY6MDkgUE0sIFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPiB3cm90ZToNCj4NCj4gT24gV2VkLCAxMiBPY3QgMjAyMiBhdCAwMzo1
MCwg5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ0KPiA8b3V5YW5nd2Vpemhhb0B6ZWt1LmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiAyMDIy5bm0MTDmnIgxMeaXpSAyMjo0MSwgVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMjcg
U2VwdCAyMDIyIGF0IDA0OjA0LCBXZWl6aGFvIE91eWFuZw0KPiA8b3V5YW5nd2Vpemhhb0B6ZWt1
LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBNYXR0aGV3IE1hIDxt
YWhvbmd3ZWlAemVrdS5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFNESU8gdHVwbGUgaXMgb25seSBh
bGxvY2F0ZWQgZm9yIHN0YW5kYXJkIFNESU8gY2FyZCwgZXNwZWNpYWxseSBpdA0KPiA+ID4gPiBj
YXVzZXMgbWVtb3J5IGNvcnJ1cHRpb24gaXNzdWVzIHdoZW4gdGhlIG5vbi1zdGFuZGFyZCBTRElP
IGNhcmQgaGFzDQo+ID4gPiA+IHJlbW92ZWQgc2luY2UgdGhlIGNhcmQgZGV2aWNlJ3MgcmVmZXJl
bmNlIGNvdW50ZXIgZG9lcyBub3QgaW5jcmVhc2UgZm9yDQo+ID4gPiA+IGl0IGF0IHNkaW9faW5p
dF9mdW5jKCksIGJ1dCBhbGwgU0RJTyBjYXJkIGRldmljZSByZWZlcmVuY2UgY291bnRlciBoYXMN
Cj4gPiA+ID4gZGVjcmVhc2VkIGF0IHNkaW9fcmVsZWFzZV9mdW5jKCkuDQo+ID4gPiA+DQo+ID4g
PiA+IEZpeGVzOiAxYTYzMmY4Y2RjMzMgKCJzZGlvOiBzcGxpdCB1cCBjb21tb24gYW5kIGZ1bmN0
aW9uIENJUyBwYXJzaW5nIikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBNYSA8bWFo
b25nd2VpQHpla3UuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogV2VpemhhbyBPdXlhbmcgPG91
eWFuZ3dlaXpoYW9AemVrdS5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBKb2huIFdhbmcgPHdh
bmdkYXl1QHpla3UuY29tPg0KPiA+ID4NCj4gPiA+IEFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5IQ0K
PiA+ID4NCj4gPiA+IFdvdywgdGhhdCdzIGEgdmVyeSBvbGQgYnVnIHlvdSBmaXhlZCEgSG93ZXZl
ciwgaXQgbG9va3MgbGlrZSB0aGUgZml4ZWQNCj4gPiA+IGNvbW1pdCBzaG91bGQgYmUgY2hhbmdl
ZCB0byA2ZjUxYmUzZDM3ZGYgKCJzZGlvOiBhbGxvdyBub24tc3RhbmRhcmQNCj4gPiA+IFNESU8g
Y2FyZHMiKS4NCj4gPg0KPiA+IFRoYW5rcywgSSBtZXNzZWQgdGhlIHRhZy4NCj4gPg0KPiA+ID4N
Cj4gPiA+IEkgdHJpZWQgdG8gYXBwbHkgdGhlIHBhdGNoLCBidXQgdGhlIHBhdGNoIGZvcm1hdCBz
ZWVtcyB0byBiZSBjb3JydXB0Lg0KPiA+ID4gRGlkIHlvdSB1c2UgZ2l0IGZvcm1hdC1wYXRjaCBh
bmQgZGlkIHJ1biAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCBvbg0KPiA+ID4gaXQ/DQo+ID4gPg0K
PiA+DQo+ID4gWWVhaCBJIHVzZWQgY2hlY2twYXRjaC5wbCB3aXRoIHN0cmljdCBtb2RlIHRvIGNo
ZWNrIHRoaXMgcGF0Y2gsIGFuZCBpdA0KPiA+IGhhcyBubyBvYnZpb3VzIHN0eWxlIHByb2JsZW1z
LiBXaGF0J3MgdGhlIGZvcm1hdCBlcnJvciB5b3UgZ290Pw0KPiANCj4gRVJST1I6IHBhdGNoIHNl
ZW1zIHRvIGJlIGNvcnJ1cHQgKGxpbmUgd3JhcHBlZD8pDQo+ICMxMzA6IEZJTEU6IGRyaXZlcnMv
bW1jL2NvcmUvc2Rpb19idXMuYzoyOTE6DQo+IHN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBkZXZf
dG9fc2Rpb19mdW5jKGRldik7DQo+IA0KPiB0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkg
bGluZXMgY2hlY2tlZA0KPiANCg0KU29ycnkgb3VyIGVtYWlsIGhvc3Rpbmcgc2VydmljZSBtYWRl
IHNvbWUgaXNzdWUgb24gZm9ybWF0dGluZywgSSB3aWxsDQpzZW5kIGFuIHVwZGF0ZWQgcGF0Y2gg
QVNBUC4NCg0KVGhhbmtzLA0KV2Vpemhhbw0KDQo=
