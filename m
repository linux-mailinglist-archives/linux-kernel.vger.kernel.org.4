Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC662B310
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKPGEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPGEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:04:46 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2107.outbound.protection.outlook.com [40.107.96.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B725C1;
        Tue, 15 Nov 2022 22:04:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1H8l/JkcPHBOw3KUOCYrtAcZIMiqTA5d1ptANpVuS98oe2xjIH6a5uRQeaRaNCJL2T1DkvyeRhY2E2DE2ygTXKBJzFzqb0SXla0LoTO1WWYWCpN79EHWR+lscCAfx5zoBczbDioaPUlQIu1+bcEg+SkA9/MXWrm7AkHRG5DLFxserCQMC1pwI/Gj3z4Ikmyi+bgMIWzjK7nvQ8QCWtycW94AKaeE+AfEceJXPbqHynqFkcw9QX0yiv8r9pYdZ6j0/xHA5191djxAz5rtJTYoZz/rsq35xQIovwvsfvrFS+NrOUJlCMRG76OZ+V4DofF9VRbQGxESIue1vFDriBwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZAYRLHoTKj58/8yM/vqLFsRdbEUUyAbT7+cuTrqgBw=;
 b=NqA2ZsL5aFhzEJl91KOncZek93K8gomnumkdk4VB9fkqqTkNqfaKiUfa7eBBPpOACX2cdTl82ZT9Tg9iTg7+ILSE7D48EDGQ7cS6oAFEyy0Rse8M2mN/RAN8ohqFvrlbc45lxq0E58TLqORcmlMkwwIXV0PiBoaL/ZpProbUkyEDQp4LYJu78xPtEtxbQ0JRf4HQjipEgSBIBS7Ojk2FdZJiRrlQld3+yqL/GycHVZxz5u2gfhXygjWkamKO4u7U9RyAozd+HcPOE70Arfik+Ljuk9qrVBcyZy0IaWJU5jLztHMCSOqyAuvjkCy+uT1tqZ3IXHdfLEvdBO1WXGxWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZAYRLHoTKj58/8yM/vqLFsRdbEUUyAbT7+cuTrqgBw=;
 b=JQQHVoQR+uW6CXUL+BeZ591iOIdPEoZJwe9l2MFwQclcB0QdaP63A1lIpU0OXfYdHWf4ySCVUyJtn41ZLZdsUTWLO1FinRRsbJZaKHt63j202EuF6XDZyxKZ/OM4xb/DwOnMKffphavYH44FL3LKFH3BBKboRIrFjDzRN04T7AE=
Received: from SN1PR16MB2255.namprd16.prod.outlook.com (2603:10b6:802:32::31)
 by SA2PR16MB4060.namprd16.prod.outlook.com (2603:10b6:806:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 16 Nov
 2022 06:04:43 +0000
Received: from SN1PR16MB2255.namprd16.prod.outlook.com
 ([fe80::3d5a:4fd5:f5:8e27]) by SN1PR16MB2255.namprd16.prod.outlook.com
 ([fe80::3d5a:4fd5:f5:8e27%4]) with mapi id 15.20.5813.012; Wed, 16 Nov 2022
 06:04:43 +0000
From:   "Louis Lu(TP)" <louis.lu@bayhubtech.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Subject: RE: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail issue
 caused by CD# debounce timeout
Thread-Topic: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail
 issue caused by CD# debounce timeout
Thread-Index: AQHY8uV3VxrtojCCxkmtWvVSDxr8w65BG/BA
Date:   Wed, 16 Nov 2022 06:04:43 +0000
Message-ID: <SN1PR16MB22551227277A186B79ECA225F1079@SN1PR16MB2255.namprd16.prod.outlook.com>
References: <20221104095512.4068-1-chevron.li@bayhubtech.com>
 <CAPDyKFqaQyQ0rViHUZoN8NzcPu51utu4KhC2KsY4p2s_sua=kQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqaQyQ0rViHUZoN8NzcPu51utu4KhC2KsY4p2s_sua=kQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR16MB2255:EE_|SA2PR16MB4060:EE_
x-ms-office365-filtering-correlation-id: 5df665f3-b434-4bb8-776e-08dac79874ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: el381alwwbMttZLeK27t5SjVSLleq3yMYn5bMO8pkZeKKOvIREtkN/0tXfjVHXjWqwsFL+XqiWHln7z4drvbeUQ3Y23HZFNmHCQlT12/BgIsm7FUoHsESAsf+HfEgK2yWWhh7h3cRfZJ1ia8OoIVxiWffMhMJBrNRtbrlA8DC39DlVLF1MrlA9XYMch3BG5S10UHtOB3h4UwBbUXFcpj8dYKuqOVOsz/RC7Y5s8Sq3XDBiurXF3L8iqp1O0RfF6q3Ttvu8WGx16ATAAAcOsQxNnbW8ZOmjf++33knNqxwTrl9JMFYnyYZiTB8YivLN7aKnKEshJcV68s+VUg9zm4JCHG56pSa7sJhAUsXmqDd08o8I8KEGRSgU9Vl9p88vulPnBXYrPD5sUUoRdr5lwakiIaL934gwBso7O4NTbeE3Vszw/PiTgyE5JB+sfnm6Xe8vH9l9IDdYBY4sGDXLk/Hbya05j3ywLMAmMwc2AUJnRyZI5/2XKL6y/0d5u+akxCJ/rFkNem5XPt9rAzsy1GwQCU5q0itcQcyoj7/AeieeMW7AMx430oYdAic625XyvYaXHWzQ2MoIoUAPzkOk1Iiyko9felSym06zj8UbGfPvwfDxWIz5iT7e1KAIoeuEz9qVArr/1nOJyWyVDxZ9nlosXncGFjQrwbrgRWpmiKjrx5H7zuchWnsxEL4zBs7u0ANF3qOCC+q4YhdbMpR14Vde+5Jd/rJD7YqiVdx77ZH5sm5rB072cJfnLMC4tYdmFxNKNm/Jlpl3YeY3RpAEhJYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR16MB2255.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39830400003)(451199015)(5660300002)(6636002)(66556008)(316002)(55016003)(66476007)(66446008)(76116006)(186003)(2906002)(64756008)(122000001)(4326008)(8676002)(66946007)(38100700002)(41300700001)(52536014)(8936002)(9686003)(86362001)(53546011)(478600001)(33656002)(107886003)(38070700005)(7696005)(6506007)(83380400001)(110136005)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3V1d3ZIMnpzZEdTME9zSzZUQlVPT0JkZTVoVmY4RkVwRzNmc0FnZW02U0Mz?=
 =?utf-8?B?Mkd3ajlVeGEzaXloQWdUekNWbHN4dkVEVi9FNDlRL3l6UGo5REZZTlZxdGlp?=
 =?utf-8?B?TGdBT2hQSm5NSWVMM0laajh2OERXVHJ1UGxRUThJOE4vRDY1MHY2ZFREMkVU?=
 =?utf-8?B?YTBmQjM0c0h0eU42ZDZBcTdLTFVjK0JXRnBBak9UNkQrOXlwak1UazFEU3FI?=
 =?utf-8?B?K3BQY2NyWlBFZi9RWS9aUGlUdG5kYisxMm9BcFRZd0pKYXl1WFJSV2MyYXVa?=
 =?utf-8?B?QTRIdU4rT1IxaXZoOGNLMXJ2S1pGM1VEcE4rRnRvQXltSUpoM3J3R3Q0WC9r?=
 =?utf-8?B?OEI1NjJ0cEFuRUZ4UXZ4TE9jdjJPRlhkMVpoelBMZVprbnV0cS9JeWUrSUxy?=
 =?utf-8?B?UHBuQlZkN29TVVg5RTlDWEJHRmlJMzRGVWRrQXJaZXJTQ1ZWZjdTODlKZnp1?=
 =?utf-8?B?SU1reHFVRld2azUxREgvVTRkY2p2TDkxMWZkU1VzcVh0anFnbE8xQzNva2JB?=
 =?utf-8?B?M0hvbDIxRjEzUnY0elBKek4wdENmOTFOS1kyM2xRend6MkVCTjJXUWJnRDV5?=
 =?utf-8?B?bFg5dnZJRmRmWkNCRk5QK0NXaDFTejFsMU14aEdseWcyVzRkTFVsRXpZQjY3?=
 =?utf-8?B?S1BWQ00ybzlxYyt2MVdmK0dPQ0R1OCtiQlBBU1NJQ2gvRE9jYjBsMm5WcEZx?=
 =?utf-8?B?N0hpRElOWCtyZzJ3NmtuSlVURVo5blY4U24rRFBKUW5nZEZQWWtOK2tVRXox?=
 =?utf-8?B?RVNMalJ3N0xvem40Sm9lM2Y2YzJlbTJkanpwWFp5M0tIVTY4YzlzbUdtbEp4?=
 =?utf-8?B?OTg5UHZoUjBRVmZ5YlVRVUpmakpqa20xM0sydGhWdEVQRXB2aEg0cUVSL09N?=
 =?utf-8?B?K0tDMTY0S25RckN4N00waTYxQlBvR2Qxd3BEdlBTanBCVmY1NjVUNUVUUGpl?=
 =?utf-8?B?Rm85YmhlM0g3dnZTVGpQRFdXcGkzZ05RMVR0NXp4R1hPUXFIWFlCbFpjUVNV?=
 =?utf-8?B?OWJVa3pia21LY0lMbWpoR1QrTFVNL3lDT3Y4bUFmY0tzYU5sN0gxVzVVN3F4?=
 =?utf-8?B?OVpRcjJ6WFVXWndOdzRuRjY0eFRSY3N6NnV2MzVlNWlWMHhpU29zY2xnemVZ?=
 =?utf-8?B?N0h6QjI1SXNyT09lV3c1cFVrOVFmWjZHVDhjc0xIK3hYeUN4K2p0dXErOWQ1?=
 =?utf-8?B?Ykx0WUoxQW1OclRJbUlrcU8rWi94MVhKcy9UZUFWdyttVWxUQUFCV2NaSEY4?=
 =?utf-8?B?ckZCWEVRRng1dkI0Rzg5NzlLOGZ5ZjNTN0lSK2NWWmdpVjlmbXI1d2ZSTmRp?=
 =?utf-8?B?Rzl3bXhGTFlLa0prNVozc2U3akNrWG1rckpEK2VNNTJRaTVPdGFCcFBmU2Nu?=
 =?utf-8?B?V3hRYW50ckplTnlsTjJqZDdzdTI1WkRqSEhQQ2hBZlR6U0hpNzZIb0RmNmo3?=
 =?utf-8?B?c2swSU5UamkyNWFtYlNjeDlLVWhWNExWMFZ2VUZJZ2lrbkZxSG1tT1dkVHcr?=
 =?utf-8?B?ZVdhT3oya1hYRHdXb0d4M0MxSElMbWZhZW05VGlCVlFYcmRtMVUxVDVsNmFr?=
 =?utf-8?B?S2tFVlBaRCs2UnFrRXlpLzRlWlc1N0tMVGtBMjJmSWlBZzF3L1BMdXloZG9Q?=
 =?utf-8?B?SHBMMUZoa2V5VU9RaFM4OU5rRGlNZjZFaDd4Z3phcHdWbmtobW5kTndRU0pP?=
 =?utf-8?B?cHBlQ1BnQ0JoYkIxSVJpNTZQUDFjL2ljUjF3SU0reEFSYlB6dkRWemRaSTZu?=
 =?utf-8?B?czNTOUxFM25FdTUyNEM2MlkwRmsxcmYrTTI2Q1Joa2UzWS9zT3d1VktOYndW?=
 =?utf-8?B?d0lrNHhNLzZxVGRPdDhhd3NqZkgrU0JIelNYeHpUQkJlZ2F5bkV4bkIzTXRx?=
 =?utf-8?B?bERhZjJZRmlJczF5N1JEWUxRNTd4Q01IMzBlS0lhK2JkSXJXTUhjN0dQWGRW?=
 =?utf-8?B?RFZIZUVSa2NxVWV5aEVPemNJOXhTZ1M4aVIrWkpzY3MzRGpFVnB5VFNkeGU0?=
 =?utf-8?B?MCtaTVp0OWNOckM1Q2diSEllOThaU25qcitLTXlnenpEY1gvelljMDIyRUNM?=
 =?utf-8?B?Y0wreTVBWU1jOUtId0hvRDh3bFJmK3hFR2hhQTl1RUpJbm5xOFYxYUZWSmNI?=
 =?utf-8?B?YUFkVW84TTUrMlNnSkxlUk9oOGRuMFpaZzFaR3NFMTB0dmcyQkUwL3psSHp6?=
 =?utf-8?Q?42KtON9IcGh8BlJP0SHxELleW2QEZ6xInB9lTB+sCOlN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR16MB2255.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df665f3-b434-4bb8-776e-08dac79874ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 06:04:43.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdS6gdRxXvTJfV94iRz9x07/6LSpqHwuIGF1mbccQ7h/Jqi1Hmni/vD4Gfy+jOJfXHhCb9SHs7X+4QV8jfk9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4060
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KTWF5IHdlIGNoZWNrIHdoZW4gdGhpcyB1cGRhdGUgcGF0Y2hlZCB3aWxsIGJl
IHBoYXNlZCBpbj8NCg0KVGhhbmtzLA0KQmVzdCBSZWdhcmRzLA0KTG91aXMgTHUNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnPiANClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDgsIDIwMjIgNDoxMyBBTQ0KVG86IENo
ZXZyb24gTGkgKFdIKSA8Y2hldnJvbi5saUBiYXlodWJ0ZWNoLmNvbT4NCkNjOiBhZHJpYW4uaHVu
dGVyQGludGVsLmNvbTsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgU2hhcGVyIExpdSAoV0gpIDxzaGFwZXIubGl1QGJheWh1YnRlY2guY29t
PjsgWGlhb0d1YW5nIFl1IChXSCkgPHhpYW9ndWFuZy55dUBiYXlodWJ0ZWNoLmNvbT47IFNoaXJs
ZXkgSGVyKFNDKSA8c2hpcmxleS5oZXJAYmF5aHVidGVjaC5jb20+OyBMb3VpcyBMdShUUCkgPGxv
dWlzLmx1QGJheWh1YnRlY2guY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBWMSAxLzFdIG1tYzog
c2RoY2ktcGNpLW8ybWljcm86IGZpeCBjYXJkIGRldGVjdCBmYWlsIGlzc3VlIGNhdXNlZCBieSBD
RCMgZGVib3VuY2UgdGltZW91dA0KDQpPbiBGcmksIDQgTm92IDIwMjIgYXQgMTA6NTUsIENoZXZy
b24gTGkgPGNoZXZyb24ubGlAYmF5aHVidGVjaC5jb20+IHdyb3RlOg0KPg0KPiBUaGUgU0QgY2Fy
ZCBpcyByZWNvZ25pemVkIGZhaWxlZCBzb21ldGltZXMgd2hlbiByZXN1bWUgZnJvbSBzdXNwZW5k
Lg0KPiBCZWNhdXNlIENEIyBkZWJvdW5jZSB0aW1lIHRvbyBsb25nIHRoZW4gY2FyZCBwcmVzZW50
IHJlcG9ydCB3cm9uZy4NCj4gRmluYWxseSwgY2FyZCBpcyByZWNvZ25pemVkIGZhaWxlZC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogQ2hldnJvbiBMaSA8Y2hldnJvbi5saUBiYXlodWJ0ZWNoLmNvbT4N
Cg0KQXBwbGllZCBmb3IgbmV4dCwgdGhhbmtzIQ0KDQpLaW5kIHJlZ2FyZHMNClVmZmUNCg0KDQo+
IC0tLQ0KPiBDaGFuZ2UgaW4gVjE6DQo+IEFkanVzdCBiYXlodWIgY2hpcCBzZXR0aW5nIGZvciBD
RCMgZGVib3VuY2UgdGltZSB0byBtaW5pbXVtIHZhbHVlDQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXBjaS1vMm1pY3JvLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCj4g
aW5kZXggYWQ0NTdjZDljYmFhLi5iY2ExZDA5NWI3NTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLXBjaS1vMm1pY3JvLmMNCj4gQEAgLTMyLDYgKzMyLDcgQEANCj4gICNkZWZpbmUgTzJfU0Rf
Q0FQUyAgICAgICAgICAgICAweEUwDQo+ICAjZGVmaW5lIE8yX1NEX0FETUExICAgICAgICAgICAg
MHhFMg0KPiAgI2RlZmluZSBPMl9TRF9BRE1BMiAgICAgICAgICAgIDB4RTcNCj4gKyNkZWZpbmUg
TzJfU0RfTUlTQ19DVFJMMiAgICAgICAweEYwDQo+ICAjZGVmaW5lIE8yX1NEX0lORl9NT0QgICAg
ICAgICAgMHhGMQ0KPiAgI2RlZmluZSBPMl9TRF9NSVNDX0NUUkw0ICAgICAgIDB4RkMNCj4gICNk
ZWZpbmUgTzJfU0RfTUlTQ19DVFJMICAgICAgICAgICAgICAgIDB4MUMwDQo+IEBAIC04NzcsNiAr
ODc4LDEyIEBAIHN0YXRpYyBpbnQgc2RoY2lfcGNpX28yX3Byb2JlKHN0cnVjdCBzZGhjaV9wY2lf
Y2hpcCAqY2hpcCkNCj4gICAgICAgICAgICAgICAgIC8qIFNldCBUdW5pbmcgV2luZG93cyB0byA1
ICovDQo+ICAgICAgICAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9TRF9UVU5JTkdfQ1RSTCwgMHg1
NSk7DQo+ICsgICAgICAgICAgICAgICAvL0FkanVzdCAxc3QgYW5kIDJuZCBDRCBkZWJvdW5jZSB0
aW1lDQo+ICsgICAgICAgICAgICAgICBwY2lfcmVhZF9jb25maWdfZHdvcmQoY2hpcC0+cGRldiwg
TzJfU0RfTUlTQ19DVFJMMiwgJnNjcmF0Y2hfMzIpOw0KPiArICAgICAgICAgICAgICAgc2NyYXRj
aF8zMiAmPSAweEZGRTdGRkZGOw0KPiArICAgICAgICAgICAgICAgc2NyYXRjaF8zMiB8PSAweDAw
MTgwMDAwOw0KPiArICAgICAgICAgICAgICAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5w
ZGV2LCBPMl9TRF9NSVNDX0NUUkwyLCBzY3JhdGNoXzMyKTsNCj4gKyAgICAgICAgICAgICAgIHBj
aV93cml0ZV9jb25maWdfZHdvcmQoY2hpcC0+cGRldiwgTzJfU0RfREVURUNUX1NFVFRJTkcsIDEp
Ow0KPiAgICAgICAgICAgICAgICAgLyogTG9jayBXUCAqLw0KPiAgICAgICAgICAgICAgICAgcmV0
ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE8yX1NEX0xPQ0tfV1AsICZzY3JhdGNoKTsNCj4NCj4g
YmFzZS1jb21taXQ6IGVlNjA1MGM4YWY5NmJiYTJmODFlOGIwNzkzYTFmYzJmOTk4ZmNkMjANCj4g
LS0NCj4gMi4yNS4xDQo+DQo=
