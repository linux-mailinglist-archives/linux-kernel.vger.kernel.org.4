Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3865BEE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbjACL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjACL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:00 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CEDFE7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REWzGkejoyY5gQ/86jAStmvLKPbz9cyClgLbLa72erZ68sz2VX8dX0rCGxstjAdqvzR2biBZdTeG3LQ49mdZX5LXiDIXOpfVO3UKuQmHdYl3uFHF9cKprvfu3gs5jRp9rVH4MXrELqT4eOSfQQmDvFH5BuYDIc34ZycXtsnlJ2uUc7QM9CY31Rw4y2VinVR4a0YPdDrMi8hZ3f8odFc7MH0Qkd8CNUpgX74NDNwXKzIxOCevcg110IEUezGzJWaeVjstAtKLlAaqEmcTfnOAHXKWpkUMCOMSCahWhvSzJh48pMcxnnHpeMjPmFYw+NkThr24wBgtTJALNY8RfF4Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+hbJMZgro+yDnnS7dcLQezoUfN2iLWX2xhJgPFJ1+k=;
 b=CmoAumzNg01Q7YzInYaJ5zHn63ks+MdhkwycjbQqSEPV/hAIYd/xqatoHXLQmgTehvWVjG9NwyuCvWc6UcXljtbLCsATfqABoQxoe3izanmevH0R1kT8Dn1ShQY4y3Lhj5+yVgaUKqgvfzyyt8c2bja5SJxBKKkHelko378IiVsSjrcPtjx+LybUjw18H4MUk7m9M/h/FUHWqJ9mZ8rrt3DVZbE4BFW+dUZVJoipyUyeOHXcA5KrMiislx9ufdiaAo/upvC/o9vtua6gsy8tFb4kAeSGOQFuuYu4o9OBToKFIWsgSwehWVfy+JbErEG9ZIW5lvjakFDUFPiqH9a/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 145.14.71.66) smtp.rcpttodomain=kernel.org smtp.mailfrom=zeekrlife.com;
 dmarc=bestguesspass action=none header.from=zeekrlife.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector2-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+hbJMZgro+yDnnS7dcLQezoUfN2iLWX2xhJgPFJ1+k=;
 b=Ej1dMEMZuSIo9MNIZeNdGA7gne3nN6HVrp2BoJHvEbKZUqnPtc6e3a4OIyyJmfvORctEZ0nFKTUZTPKAj7GrSEjDkKXqfs9eyXv4b5dL8kXLkfbh5uxvPufn3f3hsFmd1D0NUrWAReNtTh0ge66dFlVEnNGQ16bkSagVNYWUqJw=
Received: from TY2PR06CA0047.apcprd06.prod.outlook.com (2603:1096:404:2e::35)
 by SEZPR02MB5829.apcprd02.prod.outlook.com (2603:1096:101:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:28:53 +0000
Received: from TYZAPC01FT031.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:2e:cafe::c2) by TY2PR06CA0047.outlook.office365.com
 (2603:1096:404:2e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 11:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 145.14.71.66)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=zeekrlife.com;
Received-SPF: Pass (protection.outlook.com: domain of zeekrlife.com designates
 145.14.71.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=145.14.71.66; helo=CN-BJI-EXP58.Geely.Auto; pr=C
Received: from CN-BJI-EXP58.Geely.Auto (145.14.71.66) by
 TYZAPC01FT031.mail.protection.outlook.com (10.118.152.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 3 Jan 2023 11:28:52 +0000
Received: from CN-BJI-EXP64.Geely.Auto (10.186.65.77) by
 CN-BJI-EXP58.Geely.Auto (10.186.65.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 3 Jan 2023 19:28:36 +0800
Received: from CN-BJI-EXP64.Geely.Auto ([::1]) by CN-BJI-EXP64.Geely.Auto
 ([fe80::98fc:ab7:7b38:dd47%8]) with mapi id 15.01.2176.014; Tue, 3 Jan 2023
 19:28:36 +0800
From:   =?utf-8?B?566h546J5LyfKOerueWumCk=?= <Yuwei.Guan@zeekrlife.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: RE: [PATCH v3] f2fs: deliver the accumulated 'issued' to
 __issue_discard_cmd_orderly() to meet the max_requests limit
Thread-Topic: [PATCH v3] f2fs: deliver the accumulated 'issued' to
 __issue_discard_cmd_orderly() to meet the max_requests limit
Thread-Index: AQHZDtY1kK3k6y3j1EWxvg9ki6uGo65ttckAgB744bA=
Date:   Tue, 3 Jan 2023 11:28:36 +0000
Message-ID: <e377b58f396741fe980556a25326a201@zeekrlife.com>
References: <20221213093419.134-1-Yuwei.Guan@zeekrlife.com>
 <ff5f1e9d-1f44-5a3b-4b76-d3cfa877b18b@kernel.org>
In-Reply-To: <ff5f1e9d-1f44-5a3b-4b76-d3cfa877b18b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.186.26.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT031:EE_|SEZPR02MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: eec62e72-63d5-4868-9eb9-08daed7db175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ph4d8K1CzaMgxzAPT9R9KGtYMvksBfzo/HeLLsnqrZLrh58Xa8xwa4nL90m41P7IUrdKjcT/Nvwfq+/SVAtVjKHog2+Hakcn+oGMulY47actjgu7pEdYHiprNMsiw8lzMfIHUOGoJ+i4+/qfVZGekIMz+LGvvDPV//QmX8DSspPDqqsggN9RrJelhu5he4k210xdaj8p5ZNxBKqauQ/kU6/X+SB3czvt58N4iYcatP0XFjmOX9dmQO02clTJFdJtsbC+ryfus0KyAqe/rIqrSBwwkeQqDdFEgtUgCSulluOBT1uAsZgRffUZG3CmvAR9xLrD/6pY4k1O2y7R/98RiHJuaG5VYgftHeP4sSXqLvlwv/wKKjaTqYQRCmW9ZZIfF5wkbbWcIkSc05W6KuPuDTupYyLCrGlQeVT7C6xJeLgGvDvbBUEhzwScUV+CMa2eabwUKv31/0AUO47eJb0CAO3wPDtDA5Ll8ynOSpOl86X+D7w/QKEhtA+r7zfMR12sVyabnyHszdQY3oUHbVqgTyByOakBIngTnMaQdDNUTsQBi20Z5XKoOm7rriJ7SgObUgxW+t4TSbd54xmdU4KP5yo2pQDP4RK1nv/xfIM9yseVPHwXfQ0niU0YbSe2/3nWa24Ahbg3cnIktlroh2nEVr4vvenfRdZ9/PsUUtlWQC4+gBcyxR2UNd59HV7VHXWdFS8ACCvPx0yiKVGJYFkaVsrq15abRFAmaFDlf8MFvcjUJiFd1a/ZMvoOpFlAQmO5/v8P7Ftw3jHYB5U3FXMYJQ==
X-Forefront-Antispam-Report: CIP:145.14.71.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CN-BJI-EXP58.Geely.Auto;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(2616005)(36860700001)(336012)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(82310400005)(356005)(81166007)(82740400003)(36756003)(85182001)(2906002)(70206006)(54906003)(110136005)(36906005)(41300700001)(70586007)(8676002)(8936002)(316002)(5660300002)(4326008)(108616005)(53546011)(26005)(186003)(24736004)(478600001)(22166006)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:28:52.2505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec62e72-63d5-4868-9eb9-08daed7db175
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[145.14.71.66];Helo=[CN-BJI-EXP58.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT031.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5829
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gDQo+IE9uIDIwMjIvMTIvMTMgMTc6MzQsIFl1d2VpIEd1YW4gd3JvdGU6DQo+ID4gQW55
IG9mIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zIHdpbGwgc2VuZCBtb3JlIHRoYW4gdGhlIG51bWJl
ciBvZg0KPiA+IG1heF9yZXF1ZXN0cyBhdCBhIHRpbWUsIHdoaWNoIHdpbGwgbm90IG1lZXQgdGhl
IGRlc2lnbiBvZiB0aGUNCj4gPiBtYXhfcmVxdWVzdHMgbGltaXQuDQo+ID4NCj4gPiAtIFNldCBt
YXhfb3JkZXJlZF9kaXNjYXJkIGxhcmdlciB0aGFuIGRpc2NhcmRfZ3JhbnVsYXJpdHkgZnJvbSB1
c2Vyc3BhY2UuDQo+ID4gLSBJdCBpcyBhIHNtYWxsIHNpemUgZGV2aWNlLCBkaXNjYXJkX2dyYW51
bGFyaXR5IGNhbiBiZSB0dW5lZCB0byAxIGluDQo+ID4gICAgZjJmc190dW5pbmdfcGFyYW1ldGVy
cygpLg0KPiA+DQo+ID4gV2UgbmVlZCB0byBkZWxpdmVyIHRoZSBhY2N1bXVsYXRlZCBAaXNzdWVk
IHRvDQo+ID4gX19pc3N1ZV9kaXNjYXJkX2NtZF9vcmRlcmx5KCkgdG8gbWVldCB0aGUgbWF4X3Jl
cXVlc3RzIGxpbWl0Lg0KPiA+DQo+ID4gQlRXLCBjb252ZXJ0IHRoZSBwYXJhbWV0ZXIgdHlwZSBv
ZiBAaXNzdWVkIGluIF9fc3VibWl0X2Rpc2NhcmRfY21kKCkuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZdXdlaSBHdWFuIDxZdXdlaS5HdWFuQHplZWtybGlmZS5jb20+DQo+ID4gQ2M6IEJhZ2Fz
IFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPg0KPiANCj4gRm9yIHRoZSBjb2RlIHBhcnQs
IGl0IGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0Br
ZXJuZWwub3JnPg0KPiANCkhpIEplYWdldWssDQoNCkNvdWxkIHlvdSBoZWxwIHRvIHJldmlldyB0
aGlzIGNvbW1pdC4NCg0KVGhhbmtzLg0KPiBUaGFua3MsDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZnMv
ZjJmcy9zZWdtZW50LmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuYyBiL2ZzL2YyZnMvc2VnbWVudC5jIGluZGV4DQo+
ID4gYTkwOTlhNzU0ZGQyLi41MjY4OTM4NDY2ZjUgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvZjJmcy9z
ZWdtZW50LmMNCj4gPiArKysgYi9mcy9mMmZzL3NlZ21lbnQuYw0KPiA+IEBAIC0xMDk3LDggKzEw
OTcsNyBAQCBzdGF0aWMgdm9pZCBfX3VwZGF0ZV9kaXNjYXJkX3RyZWVfcmFuZ2Uoc3RydWN0DQo+
IGYyZnNfc2JfaW5mbyAqc2JpLA0KPiA+ICAgLyogdGhpcyBmdW5jdGlvbiBpcyBjb3BpZWQgZnJv
bSBibGtkZXZfaXNzdWVfZGlzY2FyZCBmcm9tIGJsb2NrL2Jsay1saWIuYw0KPiAqLw0KPiA+ICAg
c3RhdGljIGludCBfX3N1Ym1pdF9kaXNjYXJkX2NtZChzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmks
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkaXNjYXJkX3BvbGljeSAqZHBvbGljeSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRpc2NhcmRfY21kICpkYywNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICppc3N1
ZWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBkaXNjYXJkX2NtZCAqZGMsDQo+ID4gKyBpbnQgKmlzc3VlZCkNCj4gPiAgIHsNCj4gPiAg
ICAgICBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2ID0gZGMtPmJkZXY7DQo+ID4gICAgICAgdW5z
aWduZWQgaW50IG1heF9kaXNjYXJkX2Jsb2NrcyA9IEBAIC0xMzc5LDggKzEzNzgsOCBAQCBzdGF0
aWMNCj4gPiB2b2lkIF9fcXVldWVfZGlzY2FyZF9jbWQoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2Jp
LA0KPiA+ICAgICAgIG11dGV4X3VubG9jaygmU01fSShzYmkpLT5kY2NfaW5mby0+Y21kX2xvY2sp
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgX19pc3N1ZV9kaXNjYXJk
X2NtZF9vcmRlcmx5KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkaXNjYXJkX3BvbGljeSAqZHBvbGljeSkN
Cj4gPiArc3RhdGljIHZvaWQgX19pc3N1ZV9kaXNjYXJkX2NtZF9vcmRlcmx5KHN0cnVjdCBmMmZz
X3NiX2luZm8gKnNiaSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBkaXNjYXJkX3BvbGljeSAqZHBvbGljeSwNCj4gPiAraW50ICppc3N1ZWQpDQo+ID4g
ICB7DQo+ID4gICAgICAgc3RydWN0IGRpc2NhcmRfY21kX2NvbnRyb2wgKmRjYyA9IFNNX0koc2Jp
KS0+ZGNjX2luZm87DQo+ID4gICAgICAgc3RydWN0IGRpc2NhcmRfY21kICpwcmV2X2RjID0gTlVM
TCwgKm5leHRfZGMgPSBOVUxMOyBAQCAtMTM4OCw3DQo+ID4gKzEzODcsNiBAQCBzdGF0aWMgdW5z
aWduZWQgaW50IF9faXNzdWVfZGlzY2FyZF9jbWRfb3JkZXJseShzdHJ1Y3QNCj4gZjJmc19zYl9p
bmZvICpzYmksDQo+ID4gICAgICAgc3RydWN0IGRpc2NhcmRfY21kICpkYzsNCj4gPiAgICAgICBz
dHJ1Y3QgYmxrX3BsdWcgcGx1ZzsNCj4gPiAgICAgICB1bnNpZ25lZCBpbnQgcG9zID0gZGNjLT5u
ZXh0X3BvczsNCj4gPiAtICAgICB1bnNpZ25lZCBpbnQgaXNzdWVkID0gMDsNCj4gPiAgICAgICBi
b29sIGlvX2ludGVycnVwdGVkID0gZmFsc2U7DQo+ID4NCj4gPiAgICAgICBtdXRleF9sb2NrKCZk
Y2MtPmNtZF9sb2NrKTsNCj4gPiBAQCAtMTQxNSw5ICsxNDEzLDkgQEAgc3RhdGljIHVuc2lnbmVk
IGludA0KPiBfX2lzc3VlX2Rpc2NhcmRfY21kX29yZGVybHkoc3RydWN0IGYyZnNfc2JfaW5mbyAq
c2JpLA0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICBkY2MtPm5l
eHRfcG9zID0gZGMtPmxzdGFydCArIGRjLT5sZW47DQo+ID4gLSAgICAgICAgICAgICBlcnIgPSBf
X3N1Ym1pdF9kaXNjYXJkX2NtZChzYmksIGRwb2xpY3ksIGRjLCAmaXNzdWVkKTsNCj4gPiArICAg
ICAgICAgICAgIGVyciA9IF9fc3VibWl0X2Rpc2NhcmRfY21kKHNiaSwgZHBvbGljeSwgZGMsIGlz
c3VlZCk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgIGlmIChpc3N1ZWQgPj0gZHBvbGljeS0+bWF4
X3JlcXVlc3RzKQ0KPiA+ICsgICAgICAgICAgICAgaWYgKCppc3N1ZWQgPj0gZHBvbGljeS0+bWF4
X3JlcXVlc3RzKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgIG5leHQ6
DQo+ID4gICAgICAgICAgICAgICBub2RlID0gcmJfbmV4dCgmZGMtPnJiX25vZGUpOyBAQCAtMTQz
MywxMCArMTQzMSw4IEBADQo+ID4gc3RhdGljIHVuc2lnbmVkIGludCBfX2lzc3VlX2Rpc2NhcmRf
Y21kX29yZGVybHkoc3RydWN0IGYyZnNfc2JfaW5mbw0KPiA+ICpzYmksDQo+ID4NCj4gPiAgICAg
ICBtdXRleF91bmxvY2soJmRjYy0+Y21kX2xvY2spOw0KPiA+DQo+ID4gLSAgICAgaWYgKCFpc3N1
ZWQgJiYgaW9faW50ZXJydXB0ZWQpDQo+ID4gLSAgICAgICAgICAgICBpc3N1ZWQgPSAtMTsNCj4g
PiAtDQo+ID4gLSAgICAgcmV0dXJuIGlzc3VlZDsNCj4gPiArICAgICBpZiAoISgqaXNzdWVkKSAm
JiBpb19pbnRlcnJ1cHRlZCkNCj4gPiArICAgICAgICAgICAgICppc3N1ZWQgPSAtMTsNCj4gPiAg
IH0NCj4gPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgX193YWl0X2FsbF9kaXNjYXJkX2NtZChzdHJ1
Y3QgZjJmc19zYl9pbmZvICpzYmksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZGlzY2FyZF9wb2xpY3kgKmRwb2xpY3kpOw0KPiA+IEBAIC0xNDY0LDgg
KzE0NjAsMTAgQEAgc3RhdGljIGludCBfX2lzc3VlX2Rpc2NhcmRfY21kKHN0cnVjdA0KPiBmMmZz
X3NiX2luZm8gKnNiaSwNCj4gPiAgICAgICAgICAgICAgIGlmIChpICsgMSA8IGRwb2xpY3ktPmdy
YW51bGFyaXR5KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPg0KPiA+IC0g
ICAgICAgICAgICAgaWYgKGkgKyAxIDwgZGNjLT5tYXhfb3JkZXJlZF9kaXNjYXJkICYmIGRwb2xp
Y3ktPm9yZGVyZWQpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiBfX2lzc3VlX2Rp
c2NhcmRfY21kX29yZGVybHkoc2JpLCBkcG9saWN5KTsNCj4gPiArICAgICAgICAgICAgIGlmIChp
ICsgMSA8IGRjYy0+bWF4X29yZGVyZWRfZGlzY2FyZCAmJiBkcG9saWN5LT5vcmRlcmVkKSB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIF9faXNzdWVfZGlzY2FyZF9jbWRfb3JkZXJseShzYmks
IGRwb2xpY3ksICZpc3N1ZWQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaXNz
dWVkOw0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICBwZW5kX2xp
c3QgPSAmZGNjLT5wZW5kX2xpc3RbaV07DQo+ID4NCg==
