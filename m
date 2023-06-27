Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA473F47C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjF0GZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjF0GZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:25:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EE5E52;
        Mon, 26 Jun 2023 23:25:09 -0700 (PDT)
X-UUID: 5ac4829214b311ee9cb5633481061a41-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=5j9ZR4igEwUMsbNGi9xjnHzT5TkQvqVKo2Y0GDnoyyE=;
        b=uYEEtBewzBIBYJYhAT/dsHxC3Tjjl6mP4GgLEIg3PfAXqggKwSTR2ITFa64/9aclIjl7N6tfzhVtzyanLQVIfeH5mIPfpNTgqryWsazkaG3EMc6pcVKUBk9hBhadlG9yynfoRZ9a9k0J2nILL98Iod1ivg3/RjGAZQ5cW+7gkKQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e4630b92-adb0-4439-b7bf-574bf80df0a3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:6aef823c-1de7-4159-8529-a1dab19d9307,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5ac4829214b311ee9cb5633481061a41-20230627
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1372465344; Tue, 27 Jun 2023 14:25:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 14:25:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 14:25:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyY2jgIk55wJYJLqXY7+hH57hvjJBOKiBv7nJZwa35+iwzuEYrvIK7oh95eIdVhpN8Y0KYHKVEwFdFDU50b4PR8inBh6937ZtJeffpqSLM3s9jjBvTvkpeWBTQWY8YHvCxYDzIMSDGTXZk8oSyRLI/WCyZirt6dpolpkY4B2ro+fFFp0JU6zcN9pYlEdgTU4dNUYNNmn3eY34MwQmBQzgcAPzsQFwZlkEdBoXpKdjrt9zeG6pNT1wiLjKZi6xEG0tDGnxbtF6VZKzcOoomH25Zj+27pVH+zwcrGU8ISPuJuIq/y8qY1nUAzRpODMT5xZONtvsjLKaZ4pceVz/NJB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j9ZR4igEwUMsbNGi9xjnHzT5TkQvqVKo2Y0GDnoyyE=;
 b=FekJXkP/5QgD2HCEzdwnGDhINgRIZZbKGtoAuL0OM/nHsQ6Rl21NnoqL5Y3mPNLkEtTcyCuWP6/yWaWgURoUGpLEn4jq347RVrvEvJfbMQYpo2XOoinrfyiQiLFbwWcu9WqkfbjOug+rLX5S3c2S45W9VmAg10mR3whCfqL8FjyYKSFsAlOfGUKEVMJG9pfYm1KJB7jiLRF3JzV8fLn9rje5UQlMkMBkpdeplLX7CCUYTaqEO/0UZDig7pikeSpxAALRELepE5gCVpQ84GWoNQXaaZ/cGfOIqZryF6Ru3Sw4O8NUF34t7UDXN2noTF7FTXYAxQBemD3iJeD5LPxvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j9ZR4igEwUMsbNGi9xjnHzT5TkQvqVKo2Y0GDnoyyE=;
 b=DUkWuxoKh5+1BBxdtoNXciC28rjsbiZqO89GoeuBiw2zsYsJbkzC0BFlEOcSLzyxzdRgWjfRgXN42zzCVmD3wp8eZlIHuZh37HXHIXvJRhrNOK73od3kwhDrtPXVL1ieMp4e+71wnUT+m2DhvepXSn7fTKC45+bDzTn8wMI+fuU=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by KL1PR03MB6228.apcprd03.prod.outlook.com (2603:1096:820:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 06:25:01 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244%6]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 06:25:01 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Topic: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Index: AQHZp9cGuId6UkCLbk+7+3X7D0Dmnq+eFEMAgAAcQgA=
Date:   Tue, 27 Jun 2023 06:25:01 +0000
Message-ID: <eca820ecc0966f884e997bc26fbf3039f7db5b1f.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-5-maso.huang@mediatek.com>
         <fb1aa025-5314-b4c4-25ed-1efbbacbdc3b@microchip.com>
In-Reply-To: <fb1aa025-5314-b4c4-25ed-1efbbacbdc3b@microchip.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|KL1PR03MB6228:EE_
x-ms-office365-filtering-correlation-id: b5c4806a-179e-4972-7381-08db76d73ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wY/MC6RC5i/RTvNqNNf5plpcQzd3bNFzLMhOGlDxfZ0xWsfru7nh4pjVfVSeR1nPgpecIN+oOwpOXXIX5ZLDKOulztyDmvyXOnYwKAUDjM2uLLOMbopDdd4hsDJ5Ob/gnMcmqmiLEIUlkhXlty+Lt1zLkwEp/thz+v0xSyLd7uOBMZivoEI5Lh3Q0oc6J3P+N0VgMghGln3tYLXTHft3PlxXhyrtMKU7fZqxtFHyF78foRZO3TEq++GOJR2v329WGZwur1URDP7KVpkkosGAP8LNIRlL4Mln9fpnEK5jXGQwL+NkWJA7IO555wXziDq0izy2ZOgQC/wcsbgT/ikUxYAAKwpq/y/L9fRGAP8QI4bYAYFidN7UH4scsMpM/qevpjf4fdq7fT4EQUDEAqu4z/iM0Kza8mXnlKX0L5N/bqEIzCyI2Vbb3/EGgqCyPH3+yyqDje3l1b7z8zH/vqgSu+VU5HPgYPfJkMmnJEJPkv/pRCJ/AzEPgk5O4P9R9hljHnp6bFduFrVOkAc/+IvTvQmvAnrWbQEb8IaE9JMtY1UhcyItRT9/55l9VM+2rTwXMGrSpUk4L+1YP9DDDCOcwHkNUuRtsNqFel5Ey1k2UXy/vX9Lu5MJmX3WoWAgZ/JWB7MAlbaDAhMqdONR+hiBETihnmyjs3vnGlLFu83aCkKJp08KRddcy8uEnP91NoQf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(6512007)(2906002)(86362001)(6486002)(921005)(38100700002)(71200400001)(122000001)(2616005)(83380400001)(6506007)(53546011)(38070700005)(41300700001)(186003)(110136005)(478600001)(36756003)(85182001)(91956017)(66556008)(64756008)(66946007)(66476007)(66446008)(316002)(76116006)(26005)(7416002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5BaTM5Vlp3c2VhNmVaNktoelhkTkFLL0FyTXdHdjVRQTF6NlVFWGtpR0I4?=
 =?utf-8?B?aWVuSW9MYTNaYjVrRW5LQWUzaStpdWtyUXNCQ28zNEE5d3FLSFgyakQvbEJM?=
 =?utf-8?B?TjdQUFRMNWpSSHJrQlpHaG5JSk9TQm1odTE0MHh1TDk4YTltZmRmeUx4TEJ6?=
 =?utf-8?B?Vy9wMVp3ZXRuMVg3Y09aclhaMVFYQy9kWFNqRXE4aTcrVjVubjNTOGJFcVZq?=
 =?utf-8?B?dERmYmxYOEZnMHdNblptazNDQVVMeS9ySVpReTFKM0tSRGE1bjRQTHM5OENs?=
 =?utf-8?B?R0k1NXNoWm4vRDNDYnNrVXVTQUptZlA5cHRxOHVCZW9Wek1GdmZ0ME9MTmw1?=
 =?utf-8?B?NStRSGVRSk0zVDB1U0pmU1hZbTM5Y3QrcDlMRitqaE1XMU53bWpYMXNxTEtN?=
 =?utf-8?B?eTlDN3JEc0dXNUsxTnlMaVRvTG5jbmowNmdCcjRoMTJVOENWSGordno5UGlm?=
 =?utf-8?B?bkVTUnFxNm0wNGkwNHdLM1o5dnV0YW1RcjdXVTNnYlhUWlBlaGdIc0R0SUxq?=
 =?utf-8?B?MmFHQ1orWFhsREhCVEZydUZkYkdQZzlDWGV0cVpubm5wMHU2UURsTENKeVJv?=
 =?utf-8?B?WnQwVGpkd1J2dm5XVWNNYXA5OExXeGpZU1MzMm5XVEE4TDdYMG1wUTlSYUxP?=
 =?utf-8?B?aXJaQnBkQUF2amErb1dPakhaU3lMbmVhUHFzUkxHUjVhdkVwU1N3SjRGWllu?=
 =?utf-8?B?NEVEMytKQjYzT0djMG9hbVpQNEphcm0vWVBkSzhqNU1iNjRLM2RqVkRNUFlX?=
 =?utf-8?B?K3JPckNIckFzZ1kyQ1hZcGpaV0dDeUZYN21EekVBQXZsRWI1TEt6VCtXZDdB?=
 =?utf-8?B?NHNSelNJM21mNlh2disvbUhVemJaU0E4U2Z6Mm1aMmU3eTRrZnRteVZwYkcx?=
 =?utf-8?B?Zys5Z1liOGMzb05DZGs0Q2l6dEdCMit6bDhlTDRSNEZrbHJqTFI3alAzdDNM?=
 =?utf-8?B?c1RaQm1JeWxKWndaZDMvd0dBbHJLdUR1N09QTVZTZFlqN1RmdW4wK1FkRm80?=
 =?utf-8?B?ckFYeGNGZXV6REtJMlhLSm8xb0p3cHliVjA4NStaTzdyQ1JvNE5SM2RIdEs1?=
 =?utf-8?B?cXBRU205MGFLVWx4UC9ZOGJqNHhhODBiemVuV2xUci9SamFmNnBCM1E3eDVo?=
 =?utf-8?B?Y0ljQ0JRUVNGbWZvL2c0ZjhEd1Q1TlpyeS9YdXBySnFoUjVSbkxWRnhRZXpC?=
 =?utf-8?B?N1pwSEJNdnlmVXNZbEJITjhtVEVxWEZRaUI4VWdFWjZuTCsyRWtCYU52LzdU?=
 =?utf-8?B?THdTZTlydmtYbjNXbGs5SnA2ZkppM0d0MUlBUVJFN1FlK3RGYkFvV3B3WEtu?=
 =?utf-8?B?REVGaW9BRVJwbDJRdXY0cXZkbmJkYjRyVU5WMW51alg1Q2pXWW5qamZTWS8r?=
 =?utf-8?B?dGdTR0JBSE4wLzVpSk9IVUJ0SDNCYldXRHpFZ0NZUHR6RVFCNVlOeEg4SEJo?=
 =?utf-8?B?RWlkVHo5K25Lc250Mm1DWXlzdEMvcWxnVmNoSHZid2YwdHd3ZVVDc2F3N1lu?=
 =?utf-8?B?eDlYcXZ3S2lWaXJBR2JTeGtoemw3SmNCbmxmdnJVTzF3bDRmSlhac09MdUlQ?=
 =?utf-8?B?enUyMzh3V1ZhcUNjSnJ1dUpmdHNmcEdkQ09BV25VTEdPdTR3d2liQ1RNR2ZJ?=
 =?utf-8?B?SEJGcEc1ditzMXpSVlV1dHorZVlaOTBQZUtZMXVONVVDY2RUdTAweXpKcVls?=
 =?utf-8?B?OTg0SEhFS2hyWUFyK1VzeEI5L1gya2Y5eldQblpWTFltSlJ1ekdESzR1dnlG?=
 =?utf-8?B?RllFQ3JFdkRFWUpzTGpPM2FNQ2dGaDdvRWxPSXVad2NUQkE2d3JVY0dJcElj?=
 =?utf-8?B?MmNOZWVncitBQ0lUVkNGeEpQVVd1T0ZsQVNGeFhRSnRodnFtU0xSRDlqTVhC?=
 =?utf-8?B?SDVMemFVZTdLVzBNTyt3WUZuQkp5dFpxTEZGSG9rVklBNkRISjBnNmRJQ0VP?=
 =?utf-8?B?WkNrOWlGTkZxMXE5Y2llOGpVK1B1VHlaSVpQaWwrR0RTaU1nZ3hCWm9rUFh4?=
 =?utf-8?B?ak1odXNUOElFWlRhcUZ1MWU4ektKbzBjRWVIbzhLa09zS21kbjdTVVNEMG5T?=
 =?utf-8?B?VnRTWGhyUDNDS1BLbEdJbWpBNTRNanlLR0E4VWdCb0N0VlN0TUpkK1pIZFdU?=
 =?utf-8?B?SjJOTDcrWmZIWlc5ZHhZT1IzSGNZRmpnSVZ2NlA0dFdjZDFVdkpBRHJyZTVz?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FFBEE2BB079DA4BB0777C3AA3C78801@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c4806a-179e-4972-7381-08db76d73ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 06:25:01.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HxHyWOz3yDJAUPC0pRgFnnuzLcRemx/cogQobKiBaQ8sW92vk1bCxjAPKk+XL7NAfLBLIJA42tZ9H9kwrjxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTI3IGF0IDA0OjQzICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI2LjA2LjIwMjMgMDU6MzQsIE1hc28g
SHVhbmcgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTg2X2FmZV9wY21fZGV2X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBt
dGtfYmFzZV9hZmUgKmFmZTsNCj4gPiArICAgICAgIHN0cnVjdCBtdDc5ODZfYWZlX3ByaXZhdGUg
KmFmZV9wcml2Ow0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICsgICAgICAg
aW50IGksIGlycV9pZCwgcmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIGFmZSA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKmFmZSksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgaWYg
KCFhZmUpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAg
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgYWZlKTsNCj4gPiArDQo+ID4gKyAgICAgICBhZmUt
PnBsYXRmb3JtX3ByaXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwNCj4gc2l6ZW9mKCphZmVf
cHJpdiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQ
X0tFUk5FTCk7DQo+ID4gKyAgICAgICBpZiAoIWFmZS0+cGxhdGZvcm1fcHJpdikNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsgICAgICAgYWZlX3ByaXYg
PSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ID4gKyAgICAgICBhZmUtPmRldiA9ICZwZGV2LT5kZXY7
DQo+ID4gKyAgICAgICBkZXYgPSBhZmUtPmRldjsNCj4gPiArDQo+ID4gKyAgICAgICBhZmUtPmJh
c2VfYWRkciA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAr
ICAgICAgIGlmIChJU19FUlIoYWZlLT5iYXNlX2FkZHIpKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gUFRSX0VSUihhZmUtPmJhc2VfYWRkcik7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogaW5p
dGlhbCBhdWRpbyByZWxhdGVkIGNsb2NrICovDQo+ID4gKyAgICAgICByZXQgPSBtdDc5ODZfaW5p
dF9jbG9jayhhZmUpOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJDYW5ub3QgaW5pdGlhbGl6ZQ0KPiBjbG9j
a3NcbiIpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGRldm1fcG1fcnVudGltZV9lbmFibGUo
ZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZW5hYmxlIGNsb2NrIGZvciByZWdjYWNoZSBnZXQg
ZGVmYXVsdCB2YWx1ZSBmcm9tIGh3ICovDQo+ID4gKyAgICAgICBhZmVfcHJpdi0+cG1fcnVudGlt
ZV9ieXBhc3NfcmVnX2N0bCA9IHRydWU7DQo+ID4gKyAgICAgICBwbV9ydW50aW1lX2dldF9zeW5j
KCZwZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIGFmZS0+cmVnbWFwID0gZGV2bV9yZWdt
YXBfaW5pdF9tbWlvKCZwZGV2LT5kZXYsIGFmZS0NCj4gPmJhc2VfYWRkciwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgJm10Nzk4Nl9hZmVfcmVnbWFwX2NvbmZpZyk7DQo+ID4gKyAgICAgICBp
ZiAoSVNfRVJSKGFmZS0+cmVnbWFwKSkgew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKGFmZS0+cmVnbWFwKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJs
ZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBwbV9ydW50aW1lX3B1dF9zeW5j
KCZwZGV2LT5kZXYpOw0KPiANCj4gWW91IGFscmVhZHkgZGlkIGhlcmUgYSBwdXQgdGh1cyAoc2Vl
IGJlbG93KQ0KPiANCj4gPiArICAgICAgIGFmZV9wcml2LT5wbV9ydW50aW1lX2J5cGFzc19yZWdf
Y3RsID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogaW5pdCBtZW1pZiAqLw0KPiA+ICsg
ICAgICAgYWZlLT5tZW1pZl9zaXplID0gTVQ3OTg2X01FTUlGX05VTTsNCj4gPiArICAgICAgIGFm
ZS0+bWVtaWYgPSBkZXZtX2tjYWxsb2MoZGV2LCBhZmUtPm1lbWlmX3NpemUsDQo+IHNpemVvZigq
YWZlLT5tZW1pZiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9L
RVJORUwpOw0KPiA+ICsgICAgICAgaWYgKCFhZmUtPm1lbWlmKQ0KPiA+ICsgICAgICAgICAgICAg
ICBnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiA+ICsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkg
PCBhZmUtPm1lbWlmX3NpemU7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICBhZmUtPm1lbWlm
W2ldLmRhdGEgPSAmbWVtaWZfZGF0YVtpXTsNCj4gPiArICAgICAgICAgICAgICAgYWZlLT5tZW1p
ZltpXS5pcnFfdXNhZ2UgPSAtMTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBt
dXRleF9pbml0KCZhZmUtPmlycV9hbGxvY19sb2NrKTsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBp
cnEgaW5pdGlhbGl6ZSAqLw0KPiA+ICsgICAgICAgYWZlLT5pcnFzX3NpemUgPSBNVDc5ODZfSVJR
X05VTTsNCj4gPiArICAgICAgIGFmZS0+aXJxcyA9IGRldm1fa2NhbGxvYyhkZXYsIGFmZS0+aXJx
c19zaXplLCBzaXplb2YoKmFmZS0NCj4gPmlycXMpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgaWYgKCFhZmUtPmlycXMpDQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gKw0KPiA+ICsgICAg
ICAgZm9yIChpID0gMDsgaSA8IGFmZS0+aXJxc19zaXplOyBpKyspDQo+ID4gKyAgICAgICAgICAg
ICAgIGFmZS0+aXJxc1tpXS5pcnFfZGF0YSA9ICZpcnFfZGF0YVtpXTsNCj4gPiArDQo+ID4gKyAg
ICAgICAvKiByZXF1ZXN0IGlycSAqLw0KPiA+ICsgICAgICAgaXJxX2lkID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCAwKTsNCj4gPiArICAgICAgIGlmIChpcnFfaWQgPCAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAiJXBPRm4gbm8gaXJxIGZvdW5kXG4iLCBkZXYtPm9mX25v
ZGUpOw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBpcnFfaWQ7DQo+ID4gKyAgICAgICAgICAg
ICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICByZXQg
PSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxX2lkLCBtdDc5ODZfYWZlX2lycV9oYW5kbGVyLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJUlFGX1RSSUdHRVJfTk9ORSwgImFz
eXMtaXNyIiwgKHZvaWQNCj4gKilhZmUpOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImNvdWxkIG5vdCByZXF1ZXN0X2lycSBmb3IgYXN5
cy0NCj4gaXNyXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsN
Cj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAvKiBpbml0IHN1Yl9kYWlzICovDQo+
ID4gKyAgICAgICBJTklUX0xJU1RfSEVBRCgmYWZlLT5zdWJfZGFpcyk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGFpX3JlZ2lzdGVyX2Nicyk7IGkrKykg
ew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBkYWlfcmVnaXN0ZXJfY2JzW2ldKGFmZSk7DQo+
ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZfZXJyKGFmZS0+ZGV2LCAiZGFpIHJlZ2lzdGVyIGkgJWQgZmFpbCwNCj4gcmV0ICVkXG4i
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGksIHJldCk7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsNCj4gPiArICAgICAgICAg
ICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIC8qIGluaXQgZGFpX2Ry
aXZlciBhbmQgY29tcG9uZW50X2RyaXZlciAqLw0KPiA+ICsgICAgICAgcmV0ID0gbXRrX2FmZV9j
b21iaW5lX3N1Yl9kYWkoYWZlKTsNCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgICAgZGV2X2VycihhZmUtPmRldiwgIm10a19hZmVfY29tYmluZV9zdWJfZGFpIGZhaWws
DQo+IHJldCAlZFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4gPiAr
ICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsNCj4gPiArICAgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgICBhZmUtPm10a19hZmVfaGFyZHdhcmUgPSAmbXQ3OTg2X2FmZV9oYXJkd2Fy
ZTsNCj4gPiArICAgICAgIGFmZS0+bWVtaWZfZnMgPSBtdDc5ODZfbWVtaWZfZnM7DQo+ID4gKyAg
ICAgICBhZmUtPmlycV9mcyA9IG10Nzk4Nl9pcnFfZnM7DQo+ID4gKw0KPiA+ICsgICAgICAgYWZl
LT5ydW50aW1lX3Jlc3VtZSA9IG10Nzk4Nl9hZmVfcnVudGltZV9yZXN1bWU7DQo+ID4gKyAgICAg
ICBhZmUtPnJ1bnRpbWVfc3VzcGVuZCA9IG10Nzk4Nl9hZmVfcnVudGltZV9zdXNwZW5kOw0KPiA+
ICsNCj4gPiArICAgICAgIC8qIHJlZ2lzdGVyIGNvbXBvbmVudCAqLw0KPiA+ICsgICAgICAgcmV0
ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVudCgmcGRldi0+ZGV2LA0KPiA+DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbXQ3OTg2X2FmZV9j
b21wb25lbnQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5VTEwsIDApOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAg
ICBkZXZfd2FybihkZXYsICJlcnJfcGxhdGZvcm1cbiIpOw0KPiA+ICsgICAgICAgICAgICAgICBn
b3RvIGVycl9wbV9kaXNhYmxlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJl
dCA9IGRldm1fc25kX3NvY19yZWdpc3Rlcl9jb21wb25lbnQoYWZlLT5kZXYsDQo+ID4NCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZtdDc5ODZfYWZlX3Bj
bV9kYWlfY29tDQo+IHBvbmVudCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWZlLT5kYWlfZHJpdmVycywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYWZlLQ0KPiA+bnVtX2RhaV9kcml2ZXJzKTsNCj4g
PiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAi
ZXJyX2RhaV9jb21wb25lbnRcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9wbV9k
aXNhYmxlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+
ID4gKw0KPiA+ICtlcnJfcG1fZGlzYWJsZToNCj4gPiArICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5
bmMoJnBkZXYtPmRldik7DQo+IA0KPiB0aGVzZSBzaG91bGQgYmUgbm8gbmVlZCBmb3IgdGhpcyBv
bmUgaGVyZS4NCj4gDQoNCkhpIENsYXVkaXUsDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KVGhp
cyBpcyBmb3IgKElTX0VSUihhZmUtPnJlZ21hcCkpIGVycm9yIGhhbmRsaW5nLg0KTWF5IEkganVz
dCByZW1vdmUgdGhpcyBvbmU/IG9yIGFueSBvdGhlciBzdWdnZXN0aW9uPw0KDQpUaGFua3MsDQpN
YXNvDQoNCj4gPiArICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gDQo+
IFRoaXMgaXMgYWxzbyBjb3ZlcmVkIGJ5IGRldm1fcG1fcnVudGltZV9lbmFibGUoKS4NCj4gDQo+
ID4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiANCg==
