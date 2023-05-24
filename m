Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF970F7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjEXNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjEXNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:46:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4959C;
        Wed, 24 May 2023 06:46:06 -0700 (PDT)
X-UUID: 526416a6fa3911ed9cb5633481061a41-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r4z+nDeO8aXFqZpDVSnjAARVwdQSbq8Iw3Uun8Ezp0E=;
        b=n6YXtuJK+XsqQlXhbmr+8BTi7j/dLxoRNZi9G19EXogjRbuKqvnESQOcXj+EhKN940GE+MyHJzwXpXeB407HKPlB74VkrKEXIj1NA8xvoiMS3wepTyUpX8jNLcdIygk4+WHHHmUE/Kjxh4lLuptpoH5OsJZP1XAmDEgjeC9AXJE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:dc18e24e-ad05-407a-bf37-c2401fecfa0b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:dc18e24e-ad05-407a-bf37-c2401fecfa0b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:90e7df6c-2f20-4998-991c-3b78627e4938,B
        ulkID:2305240026178M5ZVZQD,BulkQuantity:31,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 526416a6fa3911ed9cb5633481061a41-20230524
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 344432271; Wed, 24 May 2023 21:46:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 21:46:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 21:46:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZhmRgp4OdEKFSvZjQ3YkuR6/rr4uUnmVn7SFoK7ssCXPMaBzV//nNlisIuXQ9GxbrBoRQHisXBfLDCcWoqyTg+dxqc5GerIzEsTMTwIgy3pyhS5j69HSQIgL2W4zfZzPFsYu5ERffUaWkk6km7DIQSrOgexsNY0N8Nj9NQJ06FXyqUfDxxa/clH2Eori59br6sVggOZS+E6etwGD6pFkWmvAyq7TClParopZwdamg/tGkyvsxJtMqKRJFZaXj9GaIAFt7A/PAmHjfHNVkIUxAFJF4xKyYkx22JD66EaTXeIRCcLB/AHcZS90xERO+kri+CN/saZDHMx8WWrm5ojwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4z+nDeO8aXFqZpDVSnjAARVwdQSbq8Iw3Uun8Ezp0E=;
 b=T/150rQE/IZeRyd0kXYFqWJ00u7htacVP3rlQ0f5xC/x/Ti6CbyjFA8woiupBVetHRZ8Qn8119xVq2rkE1S4VaPUWHTkeoDzeFGP3TqM11+KKz+VPwtwGVKmlywgYsFyYr6vez7DyrPjGhjyOSbvjoV3FlurvWykmbu0Rrkb5MGkBUA0Y9WTWt1pmu8VbW84isNFV9ZpgHlwaFgXnEttAfciyJPF7lQ7dyW9b6OEqGtK5saP7lwzYfp7mZtCgd55CK3YYmWuP80rbrn8fs59u6crGllRbKEzqYlJKALnMvBYZ1TuwiP+R2e7kDf3ci4X3gbYomMfvBeAwKvddZWigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4z+nDeO8aXFqZpDVSnjAARVwdQSbq8Iw3Uun8Ezp0E=;
 b=pEFwzUWftGsRwxYtrByd2/3qzyUPWZQA5tFY14nV9oti6bYj7Po9Wdv0Pz7/iQN4pz/5YjdHY3VPJHeAm+dw8Yztpvd6f8gOsHcPdJzPv2om+VJ9F2fWU0zYou2MpDHjrO+3RUHVAj0e8/QHJIlYldoFGnOzmU1EwoXizYOqAmc=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB7722.apcprd03.prod.outlook.com (2603:1096:400:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 13:45:58 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 13:45:58 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Topic: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Index: AQHZjR0FfmF6vQnyyUC64/q6ES0fra9oDFOAgACnk4CAALkrAIAABNeA
Date:   Wed, 24 May 2023 13:45:58 +0000
Message-ID: <e0fb6da4974407726cdf668577fe0d40e6e6e9e2.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-3-trevor.wu@mediatek.com>
         <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
         <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
         <56b892cd-977e-5b24-55f0-df25e187308b@baylibre.com>
In-Reply-To: <56b892cd-977e-5b24-55f0-df25e187308b@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB7722:EE_
x-ms-office365-filtering-correlation-id: 5d398666-ea59-4c69-5ff2-08db5c5d3463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZS5uVKHwJeDTbREhh6BX5YZvuF8GeUedDM2eDvE0HPMA6ZIZ2faZZ1SIwjqCu/U1+3oS7O4pc+jth+j4JkwL8im0CkrAXdVviun9FK1roKU5WoFA4VM3T61rjS+y/mG739IZ6NosWlwK6gq6AaJNynwV5bxxew0W1CZbO5lihaMp37wP9oYyFWV8+3wtsJx+H/AXE+oyoRJE2nxH7IBmvaX2TEP8eA+ZIr+fdIKpPbToh7DSUX9TLlckZy9i5f8QQ66+Y5DLk2LmQIY/p0BZnGlBjfxUvjcCj2XyWzwxJbjpvw6DHIN7qsaEfk21NYH0hOzvILw9PEc6GUwspg61DZzoUV0nPOvyvlYBgCs9jJCGHeLoQPTMN9oYbD8zPkv3ksyOOz8N/QNaIbXX9MTssxTFSlAdWjHaUC9xx8oVUGa3DiS+DuAmK+tAjUGccU4BGvH46X595gYuOQ0kzxFjA2egkvzcoqZEdm+79mUgDozctGPS4So4C7RFbeaik4rOnL4FKSYcaVXJCWeci7JuvQaWnzJrjXRH7bx21kge3VYcJnUum7H23n+cc6jEP05fj+NG7KhgownEKIdYUeXmHsQxYtqY97MQ2Hvvyhf3o4rakD3ckWJO1csvTKhIM2XlojLZA7s+ZtwnAI5IOguy3TNUW1mmtPTFBzlxJFF46m8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(6486002)(41300700001)(71200400001)(316002)(26005)(6506007)(53546011)(6512007)(122000001)(921005)(8936002)(8676002)(5660300002)(7416002)(85182001)(36756003)(38100700002)(478600001)(86362001)(2616005)(4326008)(83380400001)(110136005)(54906003)(38070700005)(2906002)(66556008)(186003)(76116006)(66946007)(64756008)(66476007)(66446008)(91956017)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzFhV3JoWEpiRWJ3RFJsenNYYlBQNnFFdjdJOWVSMUd0L1NvSi9LU1JCMG82?=
 =?utf-8?B?c3pUSVF0SzV6VEJuMEpWMWpGcHV0eEhJTUl0NTlxUXBaM1hIT3lnKzh3QndM?=
 =?utf-8?B?M3V5dndES3J6bXdabzRLVWpORklqa3k0bWt5eTA0Uk9oWm9GM2FPcHFIaFZs?=
 =?utf-8?B?dXRvMDZxa2JmQzh3TmlhZElrNVY0MDRXV01PR3BvdUdoL05TakQrYXpENzZn?=
 =?utf-8?B?TjBpKy9SbEtEMkdhU0cyT0pzeXJtaVplVXV5a0hucm9CQXZsSFFBcFJGTkpM?=
 =?utf-8?B?SEFmYlFvQXBWWGZlR2FGRGJBSDJuNm9iU3lGRWxaVU1QQitjV1RndlV3TjRR?=
 =?utf-8?B?NVUrZmNFUVI1TUlUMTJqc2VZdXVMR1lZVWxxd3JwakN4Q1poRWxscE52NEdO?=
 =?utf-8?B?SG8rKzhaaElsVHJZZnJVYTBIcVAxdzlQRTdtZkFPQlJod1BGYjFFT0s5M1kr?=
 =?utf-8?B?MUUwVTFrZk1wbnJWTEtlaUZCRTR1UDlERDVFdXJ2dE43MUIvWUNKNXJEUkNh?=
 =?utf-8?B?Q0YzMlRuT3k5Y2xhSHZqdFNBWEZmZDFCOCtmelJxOEpnbENhQlhnaGhyTjlR?=
 =?utf-8?B?YVF4Qmk5bTY0d0dHTEhPKzhtM21HbFB4S1VadU83VE1OQ3lSa0o1MFJRSTdP?=
 =?utf-8?B?SGM2U1BOTkczRnhMVVltbXZvcUhyZitMcHprdHMyTU4vU1o1YXJoSHRzMHpn?=
 =?utf-8?B?VURVVHJvRTl6V3E2S2prajBWRkRJT25wUWpEWlVhNDNOVVBTdTM0WGJ1WExn?=
 =?utf-8?B?SWhhWUkvYTdoaEF2SThjWUFNQkg1RTMvNEFMZVhnVjhBQUx5Ymxwb21Vb1pV?=
 =?utf-8?B?WXdteENzVlZsSmJKVkp1czBQV2lGdEZBR3NRMmpjY2xpN0pnUzhKRW1UVlVq?=
 =?utf-8?B?QUxCLzVDdld0UmZVajhXckZXTlc1SXJBN21oZm81K3JnU1BQcHRscHhlTysy?=
 =?utf-8?B?OTFYZnJWYTJOMFZUUUJ0K3VuOWZaQ2lKTlM1N1dFMWFQcFFKTnI1Nkt0d0dM?=
 =?utf-8?B?RmZWZm9jVlY5Q3ZVSWp6SnVmcUZ2MStBZk54a2kxVWFiQkNUclNTMFNRK3Rl?=
 =?utf-8?B?eUlpTXAvUHhYeFl6a0Y4RjRBVkpoanhFRCttTkJaaWxpYUZDL3NHckNpZG5r?=
 =?utf-8?B?M1pOc0FlN3lWdTFLeFNQMG5xc2pvUXNMd0NvSHo4YjVGbk11VS9TYWFiRG9C?=
 =?utf-8?B?Vjg4a2ZpRUhWNTRSdHkya3hXRFhSSWVBakpFN3JXM3R3R3NsZmJ4Z3Qxc1VL?=
 =?utf-8?B?MnFraFplakhtR2ttbDdIWkw5eXdWTUpzV0hVTTRQK29QVjZ5OGRsSWVHTTBY?=
 =?utf-8?B?eCtvVEI3QU53aWpqUnlybEgvcGNWSlFadEM3TnJNREozMjJDL1M4aGRjeWM5?=
 =?utf-8?B?VGNXVUNMOERKc1VKV04zaldtd1oxWTN2b1B5Q1U2Y2xVQ0s0OEk3T21vMHgw?=
 =?utf-8?B?bUk4M2tWbFpDZzBsVWpycjUrUGU3UGtzaC9tWGY5MHNwd1M2VW40VmE1SENX?=
 =?utf-8?B?cmhTaDhaek83Z3kvNVhaV3BudkNnVWNBVjgxb2FkWUpKcy9UeFZwcTl3Ykdo?=
 =?utf-8?B?RHg3ZEwwVnVyNlpEYVNlWFFuTWFMWGszVXY0UXVRWFFSUTFiVS9kSEFXUldt?=
 =?utf-8?B?NmxjenhPbjZWK3JxRVhyV1pPNmpadU1LNnZZRUdSR0xjNXVycU9tK09aU04v?=
 =?utf-8?B?QjA3dnp6Y2pYRGhYQXRLTEJuekQxdkd1aVlWaXB4S3NxTGdVTjVjUFhuelRL?=
 =?utf-8?B?VGR5OURjZ3pRbG5OMm0rSmNHU0JwbTd3QldvZWFncWdiUTRBRGdKN1NPTWF2?=
 =?utf-8?B?eWJMWVd0aFl0WWtUVktPL0ZoMHZIYzJqYzVuM0hHL253V05YZkpsSDNtUHRi?=
 =?utf-8?B?K1VFOHZQUXloTWZHUVRWVXBMOTBDMFB6UE51WkJFQ1c3L05oenVkMGlMMWIy?=
 =?utf-8?B?K1EzaE1lbEs3U2p1OEhWVkNVaXJKVnFVL3FVR21oeGdUQ0VUbi9RVzFPckh3?=
 =?utf-8?B?amlJOStTQUNCRFFmMUVrUkkzb3NuZEdVdzRxdG9zT1BoUUtqWCtHTkU0RHR4?=
 =?utf-8?B?OCtWaTR3MWxuZXU3SGlpVUtENWlmdkhsZFJPeWthZ0kvQjBjMytTenZFdGVi?=
 =?utf-8?B?U2lGUkRsU1licFZwNVBUd2Zwa28wdjdQVTQvMzNwVHV0VG9wRDNVRm90U293?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6AD57E45206214E988EC4A49738173E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d398666-ea59-4c69-5ff2-08db5c5d3463
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 13:45:58.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRr1CKfhUlSYaectyV0Ed8QnpYpy4znrI5EYbFpBFzU6Qml/Rg5m+2qY9Ne8VvOFS/a6lLAtJ1R7G0wWzJ0ChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7722
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE1OjI4ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAyNC8wNS8yMDIzIDA0OjI1LCBUcmV2b3IgV3UgKOWQs+aW
h+iJrykgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIzLTA1LTIzIGF0IDE4OjI2ICswMjAwLCBBbGV4
YW5kcmUgTWVyZ25hdCB3cm90ZToNCj4gPiA+IE9uIDIzLzA1LzIwMjMgMDQ6MTksIFRyZXZvciBX
dSB3cm90ZToNCj4gPiA+ID4gQUREQV9CRSBpcyB1c2VkIHRvIGNvbm5lY3QgdG8gbXQ2MzU5LiBG
b3IgbWFjaGluZSBtdDgxODgtDQo+ID4gPiA+IG10NjM1OSwNCj4gPiA+ID4gY29kZWMNCj4gPiA+
ID4gZm9yIEFEREFfQkUgbXVzdCBiZSBtdDYzNTkgd2hpY2ggYXJlIGNvbmZpZ3VyZWQgb24gdGhl
IG1hY2hpbmUNCj4gPiA+ID4gZHJpdmVyLg0KPiA+ID4gPiBCZXNpZGVzLCBBRERBX0JFIGlzIGRp
dmlkZWQgaW50byB0d28gZGFpcywgVUxfU1JDX0JFIGFuZA0KPiA+ID4gPiBETF9TUkNfQkUuDQo+
ID4gPiA+IEFzIGEgcmVzdWx0LCByZW1vdmUgQUREQV9CRSBmcm9tIGl0ZW1zIG9mIGxpbmstbmFt
ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdTx0cmV2b3Iud3VA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgaG93ICJETF9T
UkNfQkUiIGFuZCAiVUxfU1JDX0JFIiBsaW5rcyBhcmUNCj4gPiA+IGRvbmUuDQo+ID4gPiBXaHkg
dGhlc2UgZGFpcyBkb24ndCByZXBsYWNlICJBRERBX0JFIiBpbiB0aGlzIGJpbmRpbmcgPw0KPiA+
ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQWxleGFuZHJlDQo+ID4gPiANCj4gPiANCj4gPiBI
aSBBbGV4YW5kcmUsDQo+ID4gDQo+ID4gQmVjYXVzZSB0aGUgc291bmQgY2FyZCBpcyBtdDgxODgt
bXQ2MzU5LCB0aGUgY29kZWMgZm9yIHRoZXNlIHR3bw0KPiA+IGxpbmtzDQo+ID4gbXVzdCBiZSBt
dDYzNTkuIFRodXMsIEkgc3BlY2lmaXkgdGhlIGNvZGVjIGluIG1hY2hpbmUgZHJpdmVyDQo+ID4g
ZGlyZWN0bHkuDQo+ID4gSWYgdGhlIGNvZGVjIGlzIGNoYW5nZWQsIHRoZXJlIHdpbGwgYmUgYSBu
ZXcgc291bmQgY2FyZCBhbmQgYmluZGluZw0KPiA+IGZpbGUuIEluIGNvbmNsdXNpb24sIHRoZSBj
b2RlYyB3b24ndCBiZSB1cGRhdGVkIHZpYSBkdHMsIGFuZCB0aGF0J3MNCj4gPiB3aHkNCj4gPiBJ
IGRvbid0IGp1c3QgcmVwbGFjZSBBRERBX0JFIGluIHRoaXMgYmluZGluZy4NCj4gPiANCj4gPiBE
byB5b3Ugc3VnZ2VzdCBtZSBhZGQgc29tZSBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2U/DQo+IA0KPiBObyBpdCdzIGZpbmUsIEknbSBqdXN0IHRyeWluZyB0byB1bmRlcnN0YW5kLg0K
PiANCj4gV2hlbiB5b3Ugc2F5ICJJIHNwZWNpZml5IHRoZSBjb2RlYyBpbiBtYWNoaW5lIGRyaXZl
ciBkaXJlY3RseSIsIHlvdQ0KPiBhcmUgdGFsa2luZyBhYm91dCB0aGlzIGNoYW5nZSA/DQo+IA0K
PiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChzdHJjbXAoZGFpX2xpbmstPm5hbWUsICJETF9T
UkNfQkUiKSA9PSAwDQo+IHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmNtcChk
YWlfbGluay0+bmFtZSwgIlVMX1NSQ19CRSIpID09IDApDQo+IHsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFpbml0X210NjM1OSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRhaV9saW5rLT5pbml0ID0gbXQ4MTg4X210NjM1OV9pbml0Ow0KPiANCj4gSSdtIGFz
a2luZyBiZWNhdXNlIHRoZSBlcXVpdmFsZW50IHdhcyBkb25lIGhlcmU6DQo+IA0KPiAtICAgICAg
IFtEQUlfTElOS19BRERBX0JFXSA9IHsNCj4gLSAgICAgICAgICAgICAgIC5uYW1lID0gIkFEREFf
QkUiLA0KPiArICAgICAgIFtEQUlfTElOS19ETF9TUkNfQkVdID0gew0KPiArICAgICAgICAgICAg
ICAgLm5hbWUgPSAiRExfU1JDX0JFIiwNCj4gICAgICAgICAgICAgICAgIC5ub19wY20gPSAxLA0K
PiAgICAgICAgICAgICAgICAgLmRwY21fcGxheWJhY2sgPSAxLA0KPiAtICAgICAgICAgICAgICAg
LmRwY21fY2FwdHVyZSA9IDEsDQo+IC0gICAgICAgICAgICAgICAuaW5pdCA9IG10ODE4OF9tdDYz
NTlfaW5pdCwNCj4gLSAgICAgICAgICAgICAgIFNORF9TT0NfREFJTElOS19SRUcoYWRkYSksDQo+
ICsgICAgICAgICAgICAgICBTTkRfU09DX0RBSUxJTktfUkVHKGRsX3NyYyksDQo+IA0KPiBTbyBJ
J20gd29uZGVyaW5nIHdoeSAiQUREQV9CRSIgJiAiRFBUWF9CRSIgJiAiRVRETTNfT1VUX0JFIiBh
cmUgaW4NCj4gdGhlDQo+IGVudW0gbGlzdCBvZiB0aGUgYmluZGluZyBzaW5jZSB0aGUgY29kZWMg
aXMgYWxyZWFkeSBzcGVjaWZpZWQgaW4NCj4gbWFjaGluZSBkcml2ZXIgdG9vLiBJIHByb2JhYmx5
IG1pc3Mgc29tZXRoaW5nIGJ1dCBJIGRvbid0IGtub3cgd2hhdC4NCj4gDQo+IA0KDQoNClRoZSBm
b2xsb3dpbmcgY29kZSBzbmlwcGV0IGlzIGN1dCBmcm9tIFtQQVRDSCB2MiAxLzddLg0KDQogLyog
QkUgKi8NCi1TTkRfU09DX0RBSUxJTktfREVGUyhhZGRhLA0KLSAgICAgICAgICAgICAgICAgICAg
REFJTElOS19DT01QX0FSUkFZKENPTVBfQ1BVKCJBRERBIikpLA0KK1NORF9TT0NfREFJTElOS19E
RUZTKGRsX3NyYywNCisgICAgICAgICAgICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01Q
X0NQVSgiRExfU1JDIikpLA0KICAgICAgICAgICAgICAgICAgICAgREFJTElOS19DT01QX0FSUkFZ
KENPTVBfQ09ERUMoIm10NjM1OS1zb3VuZCIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAibXQ2MzU5LXNuZC1jb2RlYy0NCmFpZjEiKSksDQogICAg
ICAgICAgICAgICAgICAgICBEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9FTVBUWSgpKSk7DQpAQCAt
MTQwLDYgKzE0MCwxMiBAQCBTTkRfU09DX0RBSUxJTktfREVGUyhwY20xLA0KICAgICAgICAgICAg
ICAgICAgICAgREFJTElOS19DT01QX0FSUkFZKENPTVBfRFVNTVkoKSksDQogICAgICAgICAgICAg
ICAgICAgICBEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9FTVBUWSgpKSk7DQogDQorU05EX1NPQ19E
QUlMSU5LX0RFRlModWxfc3JjLA0KKyAgICAgICAgICAgICAgICAgICAgREFJTElOS19DT01QX0FS
UkFZKENPTVBfQ1BVKCJVTF9TUkMiKSksDQorICAgICAgICAgICAgICAgICAgICBEQUlMSU5LX0NP
TVBfQVJSQVkoQ09NUF9DT0RFQygibXQ2MzU5LXNvdW5kIiwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJtdDYzNTktc25kLWNvZGVjLQ0KYWlmMSIp
KSwNCisgICAgICAgICAgICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01QX0VNUFRZKCkp
KTsNCg0KDQpUaGlzIGlzIHdoeSBJIHRhbGsgYWJvdXQgc3BlY2lmeWluZyB0aGUgY29kZWMgaXQg
Y29ubmVjdHMgaW4gdGhlDQptYWNoaW5lIGRyaXZlci4NCklmIHlvdSBjaGVjayBvdGhlciBkYWkt
bGlua3MsIHlvdSB3b3VsZCBzZWUgQ09NUF9EVU1NWSgpIGluIHRoZQ0KQ09NUF9DT0RFQygpIGZp
ZWxkLg0KDQpUaGFua3MsDQpUcmV2b3INCj4gDQo=
