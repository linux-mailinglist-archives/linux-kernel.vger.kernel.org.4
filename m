Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244F693037
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBKLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKLMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:12:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F233251D;
        Sat, 11 Feb 2023 03:12:28 -0800 (PST)
X-UUID: f2a9196ea9fc11ed945fc101203acc17-20230211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7scvT5CVXfI5y/XA6fjN0NECPLsF068tYM7WSf/RBPc=;
        b=OiIsUcf2oYtwifJmu2bMOF6t8Q5zdaUDF6v7uFMXT7hXCLPV10Do+6wYCiLpWKTtR5BPfF3Iv8M/9JIdlGh+wy3P0XNG1VvSWWwdJQighg12pPRhNOZT6uRs7xzmzBE6N1jD4nKGSMJqp5a8Ji+k6I2K+3jHWZU2r0gdB49Y/2Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:23957105-07b8-47d9-b984-aa81ba856a10,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:0797938e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: f2a9196ea9fc11ed945fc101203acc17-20230211
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 773081072; Sat, 11 Feb 2023 19:12:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 11 Feb 2023 19:12:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 11 Feb 2023 19:12:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHffNupfeQaUBHKJO29MqRdkMtUfDSEqOYfarPchMBRhvy4oVDDSbnl89GII99vBx0c4nNZ867ykNuBOsuM77dJgt67dG3xAPLrQdeDf/RtXS6CNlgR/8K3SjzT2zkGDWyIgrSvSk8Wb4qYxuju5l1iUyzkyBh5Uk45mfytY7appN9oClX0ewDE91prcMatKLpnbeKUDPplMBqlPOxfZDfgVQYEX5v/H/7dSNd3wfgqZ3RRWPstf98vAGcccuwoT0GqvTDNSMzmF57kmMP2q06NxPZWKOPZY6OtsnDfzgilugXAQiSLggh16vVVAbaWhw8Ely47Jz0WL7JFHDkoySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7scvT5CVXfI5y/XA6fjN0NECPLsF068tYM7WSf/RBPc=;
 b=kS4gG8vXVxY8Lm9PJ6HS8bE/qr+i7pCYYwTWArLFi0vzKbwMH0eLpXjVncYQjbqcng3kkkJmQzbkao9fMJnimd25x+7FWiplm/kWe7ayHIDrpoWQtDhCtvG1BxHq+1CuFv3Xg+xPRRnE09URQ5VXIpgOarEOrXXhSa9j4IkMDxiUulXY/wfsmJlowI4+bIBY8PH5fPrzZF1AJvCobNQhf6MVyaBpcCzwW61vT76RFcNuA5/x6oraHrUzcb3mB8v8C/N14NQoNZ//uiFioFkHkTV/xFWEmDbQhmlO/hdKZ5NhowzCRH/3OkFlANa9N7nA7frN0MCiSdp8AtTsRF3gvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7scvT5CVXfI5y/XA6fjN0NECPLsF068tYM7WSf/RBPc=;
 b=nGw33Cso5/JWn/7xa0pbtNyKUBbjhGTPHwWjkJgk/E7sN0C4bt5gWS5DcNkfGHqvrWCPWLNHjAb4lkch6P3vquoaxolyngfdIUDfQPsbB+DSpwF7NLvj7Qm4i706iQpzeKozI6ll+Uf1ZgZKTXS0nzXaKVIiGZ0R/pzC+Myylb0=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 KL1PR03MB6238.apcprd03.prod.outlook.com (2603:1096:820:a1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22; Sat, 11 Feb 2023 11:12:14 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591%7]) with mapi id 15.20.6086.018; Sat, 11 Feb 2023
 11:12:14 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v5 3/3] soc: mediatek: mtk-svs: add thermal voltage
 compensation if needed
Thread-Topic: [PATCH v5 3/3] soc: mediatek: mtk-svs: add thermal voltage
 compensation if needed
Thread-Index: AQHZNwOxJXP6ilqufEyaZi9viBrOO667njAAgA4HKIA=
Date:   Sat, 11 Feb 2023 11:12:13 +0000
Message-ID: <fd62705e1abf8124706da6520fde5b77846bfd2c.camel@mediatek.com>
References: <20230202124104.16504-1-roger.lu@mediatek.com>
         <20230202124104.16504-4-roger.lu@mediatek.com>
         <26837308-4837-f252-d162-f8af4859b63e@gmail.com>
In-Reply-To: <26837308-4837-f252-d162-f8af4859b63e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|KL1PR03MB6238:EE_
x-ms-office365-filtering-correlation-id: 372f75bc-57de-4c62-446c-08db0c20d3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ws9OlDXnNgl3VHXEfw0lGx7toIdmTONsMgNblY6sXbL8Y+5WqAtX2nyGF/1zx9RaGlrOsUdcZixSPSHoP6ktzMu72QCh9zgQNGdcrTqwlIT2FPLPFFs9/lib/SmdWYCWWUGKmcHH2MmxebWcKPqvy2zH1puh1RR4dfk66MZ+fmWpqaKDQGVJhL/88YZaDctno+uleM8kC+O9yzCD5a8/En7Xq2Cg1/8RiEtAf8heiDPx4vqCbxfVDEF4AsDapGQfa3L7MtZMMxKFzCk704bUdHyEUYO6eV0E7Y3fsrx8x8+GetF8wQZJjGRMC838e6ocLmiwg0gaRLhhfU0YNIwu7+HWrv5NoEzDRMioZ9Ut4EGY3TH9YRZP4xbGmbr/5OzbzyrPp+WQEO6ZM4C+cbWug39swgkVu0XX8P1SqnVbwc8Jf8HEDMrN8pvHJfD9e5udCBqL35K7xRmeYHl6av4Jv9BhCBAPtaR0nPVmGTdLl5ydNv5zecI2G3bWRUdb88h4rCm9pxr/DVokZ+jC63Igpl7Q1KjYctsUID9UzpmvDo1E1IaHAYyq+aob7vuyhe9NdZH8MqYA1+SnCtmRawLi1ZSz3vtm6mr49cQniUWxCsm39qM7vM5RXXCVpDbv7hDK9IDu0z9jDWp/MgIEnXhxHsvx5oOv2ax5Q6B5D6/tQTPiiwBqJ9xihAos4bNCoVpN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(2616005)(107886003)(122000001)(6486002)(478600001)(110136005)(6512007)(6506007)(186003)(26005)(83380400001)(71200400001)(38100700002)(86362001)(38070700005)(36756003)(2906002)(64756008)(85182001)(66556008)(66476007)(8676002)(66446008)(316002)(4326008)(66946007)(76116006)(91956017)(8936002)(54906003)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWptelBKVStTTWlmNkEvbGsrVWwxNG5rZDNZMkJFWlh2RFY1aHV1VDFqWlpo?=
 =?utf-8?B?UkZFaEdFNkQ5eWVJbXVwYTN1TXZaaUJZWnc1ajNXOVdTN3o2WTBicWJyV1k2?=
 =?utf-8?B?VFZFMlJIcmp5cXpVRUJIYzV2OHExRUM3WTZxWHlNSzRab0tReE9sdVBtZFpV?=
 =?utf-8?B?b0wzVHRvK3IycTRlbHNrd0NPVmtuaVM3N0ZnQ1ZrRHh5QXVKRWhGdEQ1SEhV?=
 =?utf-8?B?RzFqUmlMNHE3QVRlZFM3WkF4SUZYZ0RGYko5NzZDVFJ0WUpYaDNxYStrYnlM?=
 =?utf-8?B?NjczUXArbkNQSkdkRmx1NGhybjlBU1IrNVFvMzdOVVN4eXVHSjhyMkt5bE9x?=
 =?utf-8?B?NWI4WFg4WHY3R3VmdlYzOEJRZ1FKR2NRVjhsYmdiVmdBY1Nta1I3UFVVUE1K?=
 =?utf-8?B?Q2FCYjNsamdtWGxrK1cvSjlvM0k2WkV2UjliTEY1RFJmWlluMzRQZ2VJdXRq?=
 =?utf-8?B?L1dXTDVjZTRVQjFIT2VpQXRmWWZSeDdhVnBQN2plOElhOFBaL1A1WS85dU1j?=
 =?utf-8?B?eEpjbWsrTWVVY2toZ1h4VHBPS1pEZERYZVVFenpnY1B2RUZkUE1xaEo2cGZB?=
 =?utf-8?B?L1orSE8va01ySWdqYzNGaDVLcU1uYmkwS1hBOEIvcVdiUnRiVGdsNllmUnJx?=
 =?utf-8?B?Z09OR0dJNkMyRkRpTExsdGpWQ2lJTlhDLzVQS3dER2F2KzRCckNvZTZ3RVNo?=
 =?utf-8?B?enplRWo2Ri9keElEZ3BMZFpFZVBGN1ZEYTRSa3BPck53ZnlYckZ5M0JYaUcx?=
 =?utf-8?B?SDM2ZEFMaWtsdnM1QXcyc2RkeERrRC85d1ptL2VJNmJRY0hyUUM5YW1lSit1?=
 =?utf-8?B?Q3RVOTFIT2o4MmRrVFBFUWQzOWRGRUhBUzBkSlZLbmVOalpSSzk1cXA4ZG9a?=
 =?utf-8?B?K3A4cUN1dWwrWjlrY2N0WmNPUnJZRWwzODRkTjBrbFZ6anpvNzAzZnorUzhr?=
 =?utf-8?B?WjhZblVsMi9GdVRqcjZ0YWEwZU55NHdoR0RJN2JTMVQzRDh3TmEwTUZ0QUg0?=
 =?utf-8?B?MkRqUFZDTDMyN0VTTFAwVTM2QWFXbkdvbk9mUGdsTDJRbEFrL0xmcER0T2dD?=
 =?utf-8?B?REx4aW8yUWpJOXY3OUo1ZGE4b2JmRytwN3NKWWNXUXBaTXZ5Q05HY2dNc0VV?=
 =?utf-8?B?b3RIS2N2Y2F5ODFBNlhDSTM1M2t0ZWdIWjFQZXFKTWFUWksrRncwbUtJNW5p?=
 =?utf-8?B?MHBwOWhQRngvaGE0YmtHRGxaamxpSTB1YjBaMzJPRTFBMUx5NmFZL1hCM1E1?=
 =?utf-8?B?THVUeGxiRG0wUkdSOXBjekhsT3lJSnhTU1NFbXYvYk9wTWYzR25veVRhb0dO?=
 =?utf-8?B?TWhLWGJseW0ybUxHSWw1c04wZWlwb3Vsb1pTWDlIQ1JkSHV5ZDRpMEp1Y0dV?=
 =?utf-8?B?TnV4NEhYcUdPc2JodGhKVDJIaVpkOGVqMjRkWEQ4enhsaWFROHBuRVVpbm5H?=
 =?utf-8?B?VzlJOGt4ZS9tQTJ6ZEJMUWwxamw4L1YveUpPeUFNZEVCdEtyUFRxL1VYTEl0?=
 =?utf-8?B?eHN2cm8rVC9CVU51MEU5STVzdERLQTJWVk9GZ285ckl1ekRLemQzSU54ajlm?=
 =?utf-8?B?MVRzTWVmNkVoRGxiY0ZjRFRYUk9DT09pbjJrTkZZQ1gyVGw3MHJML3ZxRnI4?=
 =?utf-8?B?L0dRZFpBbGcvanJuN3o4Wk9GMi9STy9RVWdlT01sbVhRbm1hekpLcmNFMnpY?=
 =?utf-8?B?dWt0aUVDZ3c4UERBQWF4Z21mMC82MmtMVGtqRWp1T3c0M2ZHNmZkdkVsYUEx?=
 =?utf-8?B?R1p5b29oMDk3bis5cmN6MWJtV1pCdzAxZWdiYSsreUFORzdLdGpLL00wUzZu?=
 =?utf-8?B?L1V1eFlBWHQ2VWFjTVdqc2lyNGNZZjJDeVdsR1ZZY1lpU3J3TzRMZ1pMZG9S?=
 =?utf-8?B?aVRyZHV3RXh3eDk4bFFTNU9aWmlXL09lTTZVa0w0OHo2T1dXOFJpZ2tNL1dY?=
 =?utf-8?B?eXZzaWxGTDVEZDEyQlpIRnE1clM1b0wrNDNIaDNxRmt4emdra0RNNU15TXBF?=
 =?utf-8?B?Uld6S29hUUlxLy9sMS81RGZTVWlOaXA0Tjh0bEdSOWZTMlFWNS9DaGN4b1FK?=
 =?utf-8?B?M0s5aGt2djFSQlM4K0crbUtWY2toK1FaM2JrVnJmajdKa0hiRVVPek4yNmEw?=
 =?utf-8?B?V3M3SzdEemxIQVJrUlpXMDBCUjNrK2JMOUcreWc3SEI4YXhNWFk3VnY2UmlZ?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2A6047BBAEDA4CBAFC536F21BD67BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372f75bc-57de-4c62-446c-08db0c20d3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 11:12:13.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGEQShN3/5JiiexiZnIxju1OFrlues1qZYNUsCC4mMt2xT0VSLBBpR4w9c+V56ncZIDxei5mDtKkjKlt+iJh9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6238
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQoNCi4uLiBbc25p
cF0gLi4uDQoNCj4gPiBAQCAtMjEyNyw2ICsyMTIzLDcgQEAgc3RhdGljIHN0cnVjdCBzdnNfYmFu
ayBzdnNfbXQ4MTkyX2JhbmtzW10gPSB7DQo+ID4gICAJCS50eXBlCQkJPSBTVlNCX0xPVywNCj4g
PiAgIAkJLnNldF9mcmVxX3BjdAkJPSBzdnNfc2V0X2JhbmtfZnJlcV9wY3RfdjMsDQo+ID4gICAJ
CS5nZXRfdm9sdHMJCT0gc3ZzX2dldF9iYW5rX3ZvbHRzX3YzLA0KPiA+ICsJCS50em9uZV9uYW1l
CQk9ICJncHUxIiwNCj4gPiAgIAkJLnZvbHRfZmxhZ3MJCT0gU1ZTQl9SRU1PVkVfRFZURklYRURf
Vk9MVCwNCj4gPiAgIAkJLm1vZGVfc3VwcG9ydAkJPSBTVlNCX01PREVfSU5JVDAyLA0KPiA+ICAg
CQkub3BwX2NvdW50CQk9IE1BWF9PUFBfRU5UUklFUywNCj4gPiBAQCAtMjE0NCw2ICsyMTQxLDEw
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3ZzX2Jhbmsgc3ZzX210ODE5Ml9iYW5rc1tdID0gew0KPiA+ICAg
CQkuY29yZV9zZWwJCT0gMHgwZmZmMDEwMCwNCj4gPiAgIAkJLmludF9zdAkJCT0gQklUKDApLA0K
PiA+ICAgCQkuY3RsMAkJCT0gMHgwMDU0MDAwMywNCj4gPiArCQkudHpvbmVfaHRlbXAJCT0gODUw
MDAsDQo+ID4gKwkJLnR6b25lX2h0ZW1wX3ZvZmZzZXQJPSAwLA0KPiA+ICsJCS50em9uZV9sdGVt
cAkJPSAyNTAwMCwNCj4gPiArCQkudHpvbmVfbHRlbXBfdm9mZnNldAk9IDcsDQo+IA0KPiBXaGlj
aCBpcyB0aGUgZXhhY3Qgc2FtZSB0em9uZSB0aGVuIGluIHRoZSBvdGhlciBiYW5rLiBXaGljaCBi
cmluZ3MgbWUgdG8gYQ0KPiBnb29kIA0KPiBwb2ludDoNCj4gSXMgdGhlIHR6b25lIGJhbmsgc3Bl
Y2lmaWMgb3IgdGhlIHNhbWUgZm9yIGFsbCBiYW5rcz8NCg0KVGhlcm1hbCB6b25lICh0em9uZSkg
aXNuJ3QgZm9yIGFsbCBTVlMgYmFua3MuIEluIG90aGVyIHdvcmRzLCB0em9uZSBpcyBzcGVjaWZp
Yw0KZm9yIGNvcnJlc3BvbmRpbmcgRFZGUyBkb21haW4gbGlrZSBTVlMgR1BVIHR6b25lIGlzIGZv
ciBHUFUgRFZGUyBkb21haW4uIExldCdzDQp0YWtlIE1UODE4MyBTVlMgYW5kIE1UODE5MiBTVlMg
YXMgZXhhbXBsZXMuDQoNCk1UODE5MiBTVlMgYXBwbGllcyAyLWxpbmUgSFcgZGVzaWduIChIaWdo
L2xvdyAyIGJhbmtzIG9wdGltaXplIHRoZSBzYW1lIERWRlMNCmRvbWFpbikuIFNvLCBTVlMgR1BV
IEhpZ2gvbG93IGJhbmsgdXNlcyB0aGUgc2FtZSBHUFUgdHpvbmUuDQoNCk1UODE4MyBTVlMgYXBw
bGllcyAxLWxpbmUgSFcgZGVzaWduICgxIGJhbmsgb3B0aW1pemVzIDEgRFZGUyBkb21haW4pDQpU
aGVyZWZvcmUsIFNWUyBDUFUvR1BVL0NDSSBiYW5rIHVzZSBkaWZmZXJlbnQgdHpvbmUgYmVjYXVz
ZSB0aGV5IGFyZSBkaWZmZXJlbnQNCkRWRlMgZG9tYWluLg0KDQo+IEF0IGxlYXN0IGZvciBtdDgx
OTIgdGhleSBhcmUgbm90LiBJIHN1cHBvc2Ugd2l0aCB0aGlzIGNoYW5nZSB0byB0aGUgY29kZQ0K
PiBtdDgxODMgDQo+IGNvdWxkIHRha2UgYWR2YW50YWdlIG9mIHRoaXMgb24gYWxsIGl0J3MgYmFu
a3MgYXMgd2VsbC4NCj4gSW4gdGhhdCBjYXNlLCBjYW4gd2UgDQo+IHN0YXJ0IHRvIHJlc3RydWN0
dXJlIHRoZSBzdHJ1Y3Qgc3ZzX2JhbmsgdG8gb25seSBoYXZlIHRoZSB0em9uZSB2YWx1ZXMNCj4g
ZGVjbGFyZWQgDQo+IG9uY2U/DQoNClNpbmNlIHR6b25lIGlzbid0IGZvciBhbGwgYmFua3MsIHdl
IGNhbm5vdCBkZWNsYXJlIGl0IG9uY2UgZm9yIGFsbCBJQyBzdXBwb3J0cw0KZnJvbSB0aGlzIHBv
aW50IG9mIHZpZXcuIA0KDQo+IA0KPiBCYWNrZ3JvdW5kIGlzIHRoYXQgSSdtIHZlcnkgdW5oYXBw
eSB3aXRoIHRoZSBzdnNfYmFuayBkYXRhIHN0cnVjdXRyZS4gSXQNCj4gc2VlbXMgDQo+IGxpa2Ug
YSAidGhyb3cgaXQgYWxsIGluIGhlcmUiLiBJdCBzaG91bGQgYmUgc3RydWN0dXJlZCBmb3IgZnVu
Y3Rpb25hbCBwYXJ0cw0KPiBvZiANCj4gdGhlIGJhbmtzLiBNYXliZSB1c2luZyBzdHJ1Y3RzLCBt
YXliZSB1bmlvbnMgd2hlcmUgcG9zc2libGUuIEluIGFueSBjYXNlDQo+IGhhdmluZyANCj4gYSBm
bGF0IHN0cnVjdCBvZiBvdmVyIDUwIG1lbWJlcnMgaXNuJ3QgcmVhbGx5IHdoYXQgd2Ugd2FudC4N
Cg0KTXkgYXBvbG9neS4gV2UnbGwgc3RydWN0dXJlIHN2c19iYW5rIGZvciBmdW5jdGlvbmFsIHBh
cnRzIG9mIHRoZW0uDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo=
