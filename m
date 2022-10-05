Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794225F5038
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJEHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJEHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:14:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628961004B;
        Wed,  5 Oct 2022 00:14:52 -0700 (PDT)
X-UUID: dba66f97853843d78c3bc49525498bdf-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K0ZoV39NKPR7i/A9tcYWzKwkCgwXtNIuaC6jYZfrk3Y=;
        b=P0I8zWC97cvJfQVrkAoxQh0WkrpeL3CbGgvzJedSgcHV7RdV00pVN4gDcD/QG9LCbMJVYdkC4wYkUcKNiK2anGQye6P9Hyh495MJDLncbv/utSvqxUCpGyrGQz4rf5mpaA4a9W3ZgesvbmpD7mLAMGy8JQWuHTGSutFyL51wOkk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:35a4692a-a78d-4df0-a898-30300451aaf8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.11,REQID:35a4692a-a78d-4df0-a898-30300451aaf8,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:39a5ff1,CLOUDID:0f19ec69-c578-4abf-baf4-d93ecc5e701f,B
        ulkID:221005151448R3KE781G,BulkQuantity:0,Recheck:0,SF:38|17|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0
X-UUID: dba66f97853843d78c3bc49525498bdf-20221005
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1528838611; Wed, 05 Oct 2022 15:14:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 5 Oct 2022 15:14:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 5 Oct 2022 15:14:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDUbuUlB0ytUQgDVNezhr4B9w4TDCrrlCL1QL0H6Rf6FxErO7lg0H+pIz1SBB1100qKLGI9MpmfbpEUU/tYPgeVLvoV87iy9/qdVlUA/2b85xaVRegtP0bx8UZBO5pxyODpzIIXwN5qANxdA+uEgKjZDeXXg4x3hTfN2GjHq3q6QoxWUSis2iiZL9p2sBsiLPdWOeKj+9ZtFtScSfrb6veAcfVDi/Z2sVzLHnS8i34VRG1bzrYkNZT/w3iVGOEIJCA1yzl4jyV23GzYQkyACul0cNZwPC6iVF+9xhiCC7KMS6niY1wfzdxLA1przLYsUjDJ7YiLUU5OoRB31XmEHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0ZoV39NKPR7i/A9tcYWzKwkCgwXtNIuaC6jYZfrk3Y=;
 b=AtsWc7YZhGfqYTZ13kGDxo8F+Bu/PkCJFw0S+QkiA3QVcdC1DWgQrhQNiR7u3WiVBO53XaywWRjFxMVIChXrSisJW1s6NEs48Ejko3pI3loj1W+L7A86kbM6jeUU87xW6ZqPIxlftXEEiKbrmMWljJT+x6aPXtfZgJ9pnIlsqacLdfH/MQuDeebokLaIO2snyYnmIcrDg5ooQsBpU562He5JPE4MoWiYp6fmXh+ksOc1kO7I793U4IlgzIiPv9macT9ZCYK9pBqYm7vL0c/3RPVutnU99Q6NVvegWL1enblEWOSiY7NHfr3NuzPQjElteyx+4xgWT4myj3zdCo+d+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0ZoV39NKPR7i/A9tcYWzKwkCgwXtNIuaC6jYZfrk3Y=;
 b=bPosK7iintGSwsh7F9YTMyM+U0+rtc1JZ6gZ6fs0d3JgdyS5P0fz+Cv6WUcZJLeboK9tW4JzthoEmN7scKSyQITBzAqDViljJSd8G06BE7LsEvcpjEIecsdgLT/N60gWc6mFxJtCw/xIUbvRzXW/eDq4qAUeXFELAn8uC+vQuBQ=
Received: from SEZPR03MB6690.apcprd03.prod.outlook.com (2603:1096:101:7d::13)
 by KL1PR03MB6198.apcprd03.prod.outlook.com (2603:1096:820:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.9; Wed, 5 Oct
 2022 07:14:42 +0000
Received: from SEZPR03MB6690.apcprd03.prod.outlook.com
 ([fe80::4031:e3cc:328b:693c]) by SEZPR03MB6690.apcprd03.prod.outlook.com
 ([fe80::4031:e3cc:328b:693c%5]) with mapi id 15.20.5709.008; Wed, 5 Oct 2022
 07:14:42 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 04/12] ASoC: mediatek: mt8188: support adda in platform
 driver
Thread-Topic: [PATCH 04/12] ASoC: mediatek: mt8188: support adda in platform
 driver
Thread-Index: AQHY1Nz8FxI+jQSE+0K8lEdfMjloda3+AB4AgAFqbYA=
Date:   Wed, 5 Oct 2022 07:14:42 +0000
Message-ID: <0c9b3c1f64438c17bfe520ae11ff52d71c1df600.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-5-trevor.wu@mediatek.com>
         <0d017f04-cad3-fa76-5d2d-daaa052f2e62@collabora.com>
In-Reply-To: <0d017f04-cad3-fa76-5d2d-daaa052f2e62@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6690:EE_|KL1PR03MB6198:EE_
x-ms-office365-filtering-correlation-id: 321b3f03-cabc-4996-f4d6-08daa6a14639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +UvkwF/MKLqWSYch2WwbyKfFvM78GtWCWhd5+zYockoKQG0Biy8r6dJIEG3x7atgm5J2pSRrOnDR4cJMaZYZ9BsT+HQjxotFjbWjb1XU1pgH7T06WOyUF7aLzqdCis624SqEugpOre2jQBb3S5fRyChMDqfIFLgcRjfVfmUrLxIcljG0Nja52lIAZf2PdtaP5y/qyMoT3y56f4oKcjxH6W7uE16yaDA9uo9EDMZ4VYMyjeCrhzFlht+iJtvjn7C49rLTtBDxhGMXnf6WIcXpvNWnWWWoQ0s7fs5+0fPRpHDCIK/MH64WmVXPIsALQ7XFbSa6eGWwW1qohNyd+gpZPdnfeYHndZKUCmPlYuiqvep6B2IwAwqKq5vi0+jnbuNCFWInbNr4UV+4lgJN+nCLebBV80cZdkJEhy1SdxJpfFF6oSlzxYH1Dl1+9f6hzayUePw2tVQxPqP9KQEtlErVCeJq5b0y7LzBFdRkF9j6yWKLZtqf65aJZMzCtinLOoIa1ewsxQzp6aUjVG2D84C7PENu4xbg1bAnKk2vms884QFAl+W5AMTp7dJVuSU48nVFOWI7zmyobVT6SP776KX9l5hblL/OfM/cG+uL/c3IgTFz/MPPUvLyJ5n/+wKDgDQS9mGKPHivnq9LCPTd/FloaOHpO9yxCK9XKXnYTXHl4vqYLEtjOxJqoRNHPENQtyaEzbHMBtHYvVXWoP43OaFyZCXojRiVsJedL3lnRlBN8ee/GO6GaFGRiQItVIYzy/TZnTMvwapWJL2pvZVoHRA5pBGWnSjEy/VfffWHFFaQ054=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6690.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(36756003)(85182001)(122000001)(38100700002)(86362001)(38070700005)(2616005)(186003)(2906002)(7416002)(5660300002)(6506007)(26005)(6512007)(83380400001)(76116006)(66446008)(66556008)(4326008)(8676002)(316002)(66946007)(66476007)(8936002)(64756008)(41300700001)(110136005)(54906003)(91956017)(6486002)(478600001)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVpIWEZnL1E1YVFQUjFnV24yN045d09heXhHd3VZT0pBOWxHaGlDWDNNQ3lh?=
 =?utf-8?B?eGFhMGMwL2ZSY3ZBZktXZ0gyaDhnZW53cVpKT010M0JMeDNwUHF0eGRqanV0?=
 =?utf-8?B?QnFjc2ttL1pZNEE1a3R4ME4xZStwRHp0dXFYSTM1TEJOZzI1bDZHeHQ3UFBu?=
 =?utf-8?B?ZHl4K3V5RWZMV2xIY2RnemplbENGcC85SFl1WmtUa2NGeTFHUm55SDhVVzVi?=
 =?utf-8?B?Y21pMzVGdmRYbS83MmpPRnhWeE9YWktGcHdMOS85UGhVZmRpOG94aE1NSWUv?=
 =?utf-8?B?a1ZJT2lHbllTZUdiWmkyRHB0Zzk1WDFrZTVaNlBLZUNuR09aVDZHSXhmWEV6?=
 =?utf-8?B?NGxtLzhsaTlJNVExUlhYME8vSW1jc00wWUNhTmpXbExuL29Ydm1yQUxRY0dO?=
 =?utf-8?B?UXVQMmR4aVV2aUcrNGdiMXoycnVza2FrUzd4cTNQSnA4TEZQays4QkQ5N2tS?=
 =?utf-8?B?S2pBd2FOMGY2QlYvVXg4YVlOU0VWcUEvTDlBTEZpRkxveTBaY1hmbkZmV29y?=
 =?utf-8?B?VklSVVczTDVzVDlsdlZYNUZsR0VxZXZwTVk0RENmVnhBOUJna3hQZjRxUGVX?=
 =?utf-8?B?ZUlUU2MwQmVtWCtYVFRVVEQ0VkJyb05wVTMxTkJidFJubFZOL2VCVVh2eVZa?=
 =?utf-8?B?SkxTdkZJUHFQQ1lyOFduRzBvZllEUm1KZVVrLy80ZGplcXZPSEhLSHVmdmRr?=
 =?utf-8?B?blFYMDNNVEVvVlpNV29sZFZsNlp5UDRMbUhIVEpoellmRzEyTC9jM25YZFNO?=
 =?utf-8?B?MEpXOXkxK3JSWUhrVElQYU5RMDlEMlVXR3oveElQMUUvaG10M0RhaG94YS9z?=
 =?utf-8?B?UFRMbkQrRmpaZTdZWlBQbGYxalJ4a25RdGJ0MllheW5zcHZwc2hJQXp6NVF4?=
 =?utf-8?B?NzVzakJSaCthY2cxMkw5NHFyZzBGRUxRNXlCWkw3QmcrVzUvcXN2dVZhb0FZ?=
 =?utf-8?B?blpXa3RhRDB2WkRVVDU5L0lHak1DM3JJT1ExMTRZSi9RdWk2WnVmVEc5Ymdr?=
 =?utf-8?B?c0RtV0tIS3VhRXBOMktIdFA4T0ZJcjloelhBbG9zWXc5OE42d0Z5ck5idmdm?=
 =?utf-8?B?K0VnbXpBYVp1aTVvQ0F5dGNyOWlFNTdLSis4MDR6NDNneFJoNFBONjdWMURN?=
 =?utf-8?B?cXlxdFYxak5EZVhXRmFLb0NGLzZrV3g1RXZkK0lyK2ttYnQxcTFVSFpRc0RF?=
 =?utf-8?B?YzFXMUJ4RWN2VUdTWmZDTnNPQklhWml5bjJvZEU1WWlhNEUwQ3Y5Z1ZLRk5l?=
 =?utf-8?B?UzVQS3ZMSUdiSjQrSDFCdUlRQlJGeGhNRngzL2tYK2JjRlNOOHFmOGtZMGVq?=
 =?utf-8?B?ZG4wSU5YMVNzQkRWeW9sNDRzRXF2OXRyaVJkVnJZViszWDRMVE54NndmZzVu?=
 =?utf-8?B?UXV3QjhiYUxGTzFDc0k2YWF4NWZ1cUlHblRNdi82dHpiUFA4Q3J0cHlwR1ZC?=
 =?utf-8?B?MDREWG1XVVYvZmszQUNOaDBjWTZZWVNzNEN5WlZPQzVMUnVhYlhoeFdMNXkx?=
 =?utf-8?B?RkxQMXhvbDQ1WVpUeWIzTXZFZlJUMzZaZHU5RU9PeDdzWjhyU1JvbmFSazdB?=
 =?utf-8?B?b29zRzJ2a1MvZ205R21oaE9aMjd5ZjdtQXBSQUZEUUN1anlPQlVNQklrUlNr?=
 =?utf-8?B?a0d2TzNYYXVxQzhGcFU2NE8vbytkaFdubHFTV1BiWkZ1TnRQSi8rSndkdTli?=
 =?utf-8?B?T01ZUGQzM2F0bVkyZEJCa2tvL1V0R3h3ZnpUb2swUlVrTFgxenRhMjVMKzlC?=
 =?utf-8?B?VlJhRkxBeWMwdm82U0Z5SWRHS08waTdFVVZsZlNsbFpQbll2TnJtekpNb3Bm?=
 =?utf-8?B?Uy9UOGliMkxGOUlHT2ZpRmUxQUFoaWtiQkVxdVRqcWk1VGZPekUxUTNQd2ZY?=
 =?utf-8?B?bEhKUW02ZUgwUW5aWlB3NTN4RlN6eEVkWkl1QnpocWp1WURCdDdpdzJ3TlZ0?=
 =?utf-8?B?MThhOEtiZGNBMEJNS01hWHN5T2hXMmhYNVBIYWN5SG8xWVpTWjB3bVFWKzFG?=
 =?utf-8?B?TTRZZmJaK0s3Zmx4TitXeTFjdDBFNXlVc3F6NWxkZFpLOWVHRTdjRm9WbWlB?=
 =?utf-8?B?WkJYOHhLdkVaMkFZVjRHMGh0V1RaQSsxNzFzUDVNc3BPKzh3WGtyZmU5NXUy?=
 =?utf-8?B?YnYwbDA3U2Z3T01hREJrcEtyM012TWZoczBvaDJkc09sZ2ZROTJkYzIzNkNi?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C50AF783952E24E96F99B8F6F697619@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6690.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321b3f03-cabc-4996-f4d6-08daa6a14639
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 07:14:42.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvmtduEi9q19lQI3nQ/RGf6CwmPOsUsyqjLX4IpH8et4/PQinqPi81SlEvwj2jwB8SFntE6ACcuFiJSVAddr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6198
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDExOjM3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMzAvMDkvMjIgMTY6NTYsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IA0KLi5zbmlwLi4NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10ODE4OF9hZGRhX210
a2FpZl9pbml0KHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSkNCj4gPiArew0KPiA+ICsJc3RydWN0
IG10ODE4OF9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYgPSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ID4g
KwlzdHJ1Y3QgbXRrYWlmX3BhcmFtICpwYXJhbSA9ICZhZmVfcHJpdi0+bXRrYWlmX3BhcmFtczsN
Cj4gPiArCWludCBkZWxheV9kYXRhOw0KPiA+ICsJaW50IGRlbGF5X2N5Y2xlOw0KPiA+ICsJdW5z
aWduZWQgaW50IG1hc2sgPSAwOw0KPiA+ICsJdW5zaWduZWQgaW50IHZhbCA9IDA7DQo+ID4gKw0K
PiA+ICsJLyogc2V0IHJ4IHByb3RvY29sIDIgJiBtdGthaWZfcnhpZl9jbGtpbnZfYWRjIGludmVy
c2UgKi8NCj4gPiArCW1hc2sgPSAoTVRLQUlGX1JYSUZfQ0xLSU5WX0FEQyB8IE1US0FJRl9SWElG
X1BST1RPQ09MMik7DQo+ID4gKwl2YWwgPSAoTVRLQUlGX1JYSUZfQ0xLSU5WX0FEQyB8IE1US0FJ
Rl9SWElGX1BST1RPQ09MMik7DQo+ID4gKw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGFmZS0+
cmVnbWFwLCBBRkVfQUREQV9NVEtBSUZfQ0ZHMCwgbWFzaywNCj4gPiB2YWwpOw0KPiANCj4gVGhp
cyBzaG91bGQgYmUNCj4gCXJlZ21hcF9zZXRfYml0cyhhZmUtPnJlZ21hcCwgQUZFX0FEREFfTVRL
QUlGX0NGRzAsDQo+IAkJCU1US0FJRl9SWElGX0NMS0lOVl9BREMgfA0KPiBNVEtBSUZfUlhJRl9Q
Uk9UT0NPTDIpOw0KDQpPSy4gSSB3aWxsIHJlcGxhY2UgYWxsIHNpbWlsYXIgdXNhZ2VzIGluIFYy
Lg0KDQo+ID4gKw0KPiA+ICsJbWFzayA9IFJHX1JYX1BST1RPQ09MMjsNCj4gPiArCXZhbCA9IFJH
X1JYX1BST1RPQ09MMjsNCj4gPiArCXJlZ21hcF91cGRhdGVfYml0cyhhZmUtPnJlZ21hcCwgQUZF
X0FVRF9QQURfVE9QLCBtYXNrLCB2YWwpOw0KPiANCj4gcmVnbWFwX3NldF9iaXRzKCkgYWdhaW4N
Cj4gDQoNCj4gPiArDQo+ID4gKwlpZiAoIXBhcmFtLT5tdGthaWZfY2FsaWJyYXRpb25fb2spIHsN
Cj4gPiArCQlkZXZfaW5mbyhhZmUtPmRldiwgIiVzKCksIGNhbGlicmF0aW9uDQo+ID4gZmFpbFxu
IiwgIF9fZnVuY19fKTsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkv
KiBzZXQgZGVsYXkgZm9yIGNoMSwgY2gyICovDQo+ID4gKwlpZiAocGFyYW0tPm10a2FpZl9waGFz
ZV9jeWNsZVtNVDgxODhfTVRLQUlGX01JU09fMF0gPj0NCj4gPiArCSAgICBwYXJhbS0+bXRrYWlm
X3BoYXNlX2N5Y2xlW01UODE4OF9NVEtBSUZfTUlTT18xXSkgew0KPiA+ICsJCWRlbGF5X2RhdGEg
PSBERUxBWV9EQVRBX01JU08xOw0KPiA+ICsJCWRlbGF5X2N5Y2xlID0NCj4gPiArCQkJcGFyYW0t
Pm10a2FpZl9waGFzZV9jeWNsZVtNVDgxODhfTVRLQUlGX01JU09fMF0gDQo+ID4gLQ0KPiA+ICsJ
CQlwYXJhbS0NCj4gPiA+bXRrYWlmX3BoYXNlX2N5Y2xlW01UODE4OF9NVEtBSUZfTUlTT18xXTsN
Cj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZGVsYXlfZGF0YSA9IERFTEFZX0RBVEFfTUlTTzA7DQo+
ID4gKwkJZGVsYXlfY3ljbGUgPQ0KPiA+ICsJCQlwYXJhbS0+bXRrYWlmX3BoYXNlX2N5Y2xlW01U
ODE4OF9NVEtBSUZfTUlTT18xXSANCj4gPiAtDQo+ID4gKwkJCXBhcmFtLQ0KPiA+ID5tdGthaWZf
cGhhc2VfY3ljbGVbTVQ4MTg4X01US0FJRl9NSVNPXzBdOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CXZhbCA9IDA7DQo+ID4gKwltYXNrID0gKE1US0FJRl9SWElGX0RFTEFZX0RBVEEgfCBNVEtBSUZf
UlhJRl9ERUxBWV9DWUNMRV9NQVNLKTsNCj4gPiArCXZhbCB8PSBNVEtBSUZfUlhJRl9ERUxBWV9D
WUNMRShkZWxheV9jeWNsZSkgJg0KPiA+ICsJICAgICAgIE1US0FJRl9SWElGX0RFTEFZX0NZQ0xF
X01BU0s7DQo+IA0KPiAJdmFsID0gRklFTERfUFJFUChNVEtBSUZfUlhJRl9ERUxBWV9DWUNMRV9N
QVNLLCBkZWxheV9jeWNsZSk7DQo+IA0KPiA+ICsJdmFsIHw9IGRlbGF5X2RhdGEgPDwgTVRLQUlG
X1JYSUZfREVMQVlfREFUQV9TSElGVDsNCj4gDQo+IAl2YWwgfD0gRklFTERfUFJFUChNVEtBSUZf
UlhJRl9ERUxBWV9EQVRBLCBkZWxheV9kYXRhKTsNCj4gDQo+IENhbiB5b3UgcGxlYXNlIHVzZSBi
aXRmaWVsZCBhY2Nlc3MgbWFjcm9zIGFjcm9zcyB0aGUgZW50aXJlIGZpbGUgKGFuZA0KPiB0aGUg
b3RoZXJzKT8NCj4gVGhpcyB3aWxsIGJvdGggaW5jcmVhc2UgaHVtYW4gcmVhZGFiaWxpdHkgYW5k
IGFkZCBjb21waWxlLXRpbWUgY2hlY2tzDQo+IG9uIHJlZ2lzdGVyDQo+IGZpZWxkcy4NCj4gDQoN
ClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KY29tcGlsZS10aW1lIGNoZWNrcyBhcmUgaGVs
cGZ1bCB0byBmaW5kIHNvbWUgdW5leHBlY3RlZCBlcnJvcnMuDQpJIHdpbGwgdXBkYXRlIGl0IGlu
IFYyLg0KDQo+ID4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoYWZlLT5yZWdtYXAsIEFGRV9BRERBX01U
S0FJRl9SWF9DRkcyLCBtYXNrLA0KPiA+IHZhbCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2FkZGFfbXRrYWlmX2NmZ19ldmVudChz
dHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldA0KPiA+ICp3LA0KPiA+ICsJCQkJICAgICBzdHJ1Y3Qg
c25kX2tjb250cm9sICprY29udHJvbCwNCj4gPiArCQkJCSAgICAgaW50IGV2ZW50KQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNtcG50ID0gc25kX3NvY19kYXBtX3Rv
X2NvbXBvbmVudCh3LQ0KPiA+ID5kYXBtKTsNCj4gPiArCXN0cnVjdCBtdGtfYmFzZV9hZmUgKmFm
ZSA9DQo+ID4gc25kX3NvY19jb21wb25lbnRfZ2V0X2RydmRhdGEoY21wbnQpOw0KPiA+ICsNCj4g
PiArCWRldl9kYmcoYWZlLT5kZXYsICIlcygpLCBuYW1lICVzLCBldmVudCAweCV4XG4iLA0KPiA+
ICsJCV9fZnVuY19fLCB3LT5uYW1lLCBldmVudCk7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChldmVu
dCkgew0KPiA+ICsJY2FzZSBTTkRfU09DX0RBUE1fUFJFX1BNVToNCj4gPiArCQltdDgxODhfYWRk
YV9tdGthaWZfaW5pdChhZmUpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiAr
CQlicmVhazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBtdGtfYWRkYV9kbF9ldmVudChzdHJ1Y3Qgc25kX3NvY19kYXBtX3dp
ZGdldCAqdywNCj4gPiArCQkJICAgICBzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwNCj4g
PiArCQkJICAgICBpbnQgZXZlbnQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzbmRfc29jX2NvbXBv
bmVudCAqY21wbnQgPSBzbmRfc29jX2RhcG1fdG9fY29tcG9uZW50KHctDQo+ID4gPmRhcG0pOw0K
PiA+ICsJc3RydWN0IG10a19iYXNlX2FmZSAqYWZlID0NCj4gPiBzbmRfc29jX2NvbXBvbmVudF9n
ZXRfZHJ2ZGF0YShjbXBudCk7DQo+ID4gKw0KPiA+ICsJZGV2X2RiZyhhZmUtPmRldiwgIiVzKCks
IG5hbWUgJXMsIGV2ZW50IDB4JXhcbiIsDQo+ID4gKwkJX19mdW5jX18sIHctPm5hbWUsIGV2ZW50
KTsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGV2ZW50KSB7DQo+ID4gKwljYXNlIFNORF9TT0NfREFQ
TV9QT1NUX1BNRDoNCj4gPiArCQkvKiBzaG91bGQgZGVsYXllZCAxL2ZzKHNtYWxsZXN0IGlzIDhr
KSA9IDEyNXVzIGJlZm9yZQ0KPiA+IGFmZSBvZmYgKi8NCj4gPiArCQl1c2xlZXBfcmFuZ2UoMTI1
LCAxMzUpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlicmVhazsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IHZvaWQgbXRrX2FkZGFfdWxfbWljdHlwZShzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUsIGJvb2wN
Cj4gPiBkbWljKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQgcmVnID0gQUZFX0FEREFfVUxf
U1JDX0NPTjA7DQo+ID4gKwl1bnNpZ25lZCBpbnQgdmFsID0gMDsNCj4gPiArCXVuc2lnbmVkIGlu
dCBtYXNrOw0KPiA+ICsNCj4gPiArCW1hc2sgPSAoVUxfU0RNM19MRVZFTF9DVEwgfCBVTF9NT0RF
XzNQMjVNX0NIMV9DVEwgfA0KPiA+ICsJCVVMX01PREVfM1AyNU1fQ0gyX0NUTCk7DQo+IA0KPiAJ
dmFsID0gKFVMX1NETTNfTEVWRUxfQ1RMIHwgVUxfTU9ERV8zUDI1TV9DSDFfQ1RMIHwNCj4gVUxf
TU9ERV8zUDI1TV9DSDJfQ1RMKTsNCj4gDQo+ID4gKw0KPiA+ICsJLyogdHVybiBvbiBkbWljLCBj
aDEsIGNoMiAqLw0KPiA+ICsJaWYgKGRtaWMpDQo+IA0KPiAJCXJlZ21hcF9zZXRfYml0cyhhZmUt
PnJlZ21hcCwgcmVnLCB2YWwpOw0KPiAJZWxzZQ0KPiAJCXJlZ21hcF9jbGVhcl9iaXRzKGFmZS0+
cmVnbWFwLCByZWcsIHZhbCk7DQo+IA0KPiANCk9LLiBJIHdpbGwgdXBkYXRlIHRoaXMgcGFydCBp
biBWMi4NCg0KPiA+ICsJCXZhbCA9IG1hc2s7DQo+ID4gKw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9i
aXRzKGFmZS0+cmVnbWFwLCByZWcsIG1hc2ssIHZhbCk7DQo+ID4gK30NCj4gPiArDQo+IA0KPiAu
LnNuaXAuLg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2FmZV9hZGNfaGlyZXNfY29u
bmVjdChzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldA0KPiA+ICpzb3VyY2UsDQo+ID4gKwkJCQkg
ICAgIHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0ICpzaW5rKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdyA9IHNvdXJjZTsNCj4gPiArCXN0cnVjdCBzbmRfc29j
X2NvbXBvbmVudCAqY21wbnQgPSBzbmRfc29jX2RhcG1fdG9fY29tcG9uZW50KHctDQo+ID4gPmRh
cG0pOw0KPiA+ICsJc3RydWN0IG10a19iYXNlX2FmZSAqYWZlID0NCj4gPiBzbmRfc29jX2NvbXBv
bmVudF9nZXRfZHJ2ZGF0YShjbXBudCk7DQo+ID4gKwlzdHJ1Y3QgbXQ4MTg4X2FmZV9wcml2YXRl
ICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsNCj4gPiArCXN0cnVjdCBtdGtfZGFpX2Fk
ZGFfcHJpdiAqYWRkYV9wcml2Ow0KPiA+ICsNCj4gPiArCWFkZGFfcHJpdiA9IGFmZV9wcml2LT5k
YWlfcHJpdltNVDgxODhfQUZFX0lPX0FEREFdOw0KPiA+ICsNCj4gPiArCWlmICghYWRkYV9wcml2
KSB7DQo+ID4gKwkJZGV2X2VycihhZmUtPmRldiwgIiVzIGFkZGFfcHJpdiA9PSBOVUxMIiwgX19m
dW5jX18pOw0KPiA+ICsJCXJldHVybiAwOw0KPiANCj4gCQlyZXR1cm4gLUVJTlZBTD8NCj4gDQpk
YXBtX3N1cHBseV9jaGVja19wb3dlciBkb2Vzbid0IGhhbmRsZWQgZXJyb3IgcmV0dXJuIHZhbHVl
LCBzbyBpdCBzZWVtcw0KdG8gYmUgYmV0dGVyIHRvIGtlZXAgcmV0dXJuIDAgaGVyZS4NCg0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAoYWRkYV9wcml2LT51bF9yYXRlID4gQUREQV9ISVJF
U19USFJFUykgPyAxIDogMDsNCj4gDQo+IAlyZXR1cm4gISEoYWRkYV9wcml2LT51bF9yYXRlID4g
QUREQV9ISVJFU19USFJFUyk7DQo+IA0KT0suIEkgd2lsbCB1cGRhdGUgaXQgaW4gVjIuDQoNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfYWZlX2RhY19oaXJlc19jb25uZWN0KHN0
cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0DQo+ID4gKnNvdXJjZSwNCj4gPiArCQkJCSAgICAgc3Ry
dWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKnNpbmspDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzbmRf
c29jX2RhcG1fd2lkZ2V0ICp3ID0gc291cmNlOw0KPiA+ICsJc3RydWN0IHNuZF9zb2NfY29tcG9u
ZW50ICpjbXBudCA9IHNuZF9zb2NfZGFwbV90b19jb21wb25lbnQody0NCj4gPiA+ZGFwbSk7DQo+
ID4gKwlzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUgPQ0KPiA+IHNuZF9zb2NfY29tcG9uZW50X2dl
dF9kcnZkYXRhKGNtcG50KTsNCj4gPiArCXN0cnVjdCBtdDgxODhfYWZlX3ByaXZhdGUgKmFmZV9w
cml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiA+ICsJc3RydWN0IG10a19kYWlfYWRkYV9wcml2
ICphZGRhX3ByaXY7DQo+ID4gKw0KPiA+ICsJYWRkYV9wcml2ID0gYWZlX3ByaXYtPmRhaV9wcml2
W01UODE4OF9BRkVfSU9fQUREQV07DQo+ID4gKw0KPiA+ICsJaWYgKCFhZGRhX3ByaXYpIHsNCj4g
PiArCQlkZXZfZXJyKGFmZS0+ZGV2LCAiJXMgYWRkYV9wcml2ID09IE5VTEwiLCBfX2Z1bmNfXyk7
DQo+ID4gKwkJcmV0dXJuIDA7DQo+IA0KPiBzYW1lIGhlcmUNCj4gDQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIChhZGRhX3ByaXYtPmRsX3JhdGUgPiBBRERBX0hJUkVTX1RIUkVTKSA/IDEg
OiAwOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gLi5zbmlwLi4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFu
Z2Vsbw0KPiANCj4gDQo=
