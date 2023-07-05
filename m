Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678D747EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjGEH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGEH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:59:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCAC10DD;
        Wed,  5 Jul 2023 00:58:58 -0700 (PDT)
X-UUID: c8128b3a1b0911eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=UEPrgIcBO/pI44YrUNc/Ckr+LftVJXYU3eI3gXu1/WY=;
        b=nZaYIbqygMVpekcFZ3Bb4h1PvTx6D9olz5KFpoenElOsx/uHGR1LdAo1058NrtFrlOKZs7ur8bD/33ThFpphWiuV1K/w3lKTf6djWicebnUmNGKmUSAodHJpkMb/tNS8HNIgyfs2kiZD7NTS0sf1w41hcmDmPCfCH6QKvyKQKak=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:a9a541ba-b48c-478e-a53e-c1c43fb53c2f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:a9a541ba-b48c-478e-a53e-c1c43fb53c2f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:46f6950d-26a8-467f-b838-f99719a9c083,B
        ulkID:230705155853FWIV8PP0,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c8128b3a1b0911eeb20a276fd37b9834-20230705
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1954947163; Wed, 05 Jul 2023 15:58:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 15:58:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 15:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du9fLb26DFrUD3euLXb5SmB17YyFWSkoGuWRm+Q7nl38PCEe49HAgWXv9pUI75m2URO3xtjQq2hSJkmbbSa0OIajrbPWoOJbO9Gakvq7vvgQZiQfea61I/VrQ39BECxTU8oyTBRlBAuHUHw6IDoTtRSDSU6emQxxNjBc777Nnn2t3mAxCDdpst2nxDxURGw8BYM4K55syKO7jLNAEvn0t690ssgdh1xG3SDw4HcgtN0QqTICxJAG2Sln1Myc4pBdVFxz7rmoXdvdlVEmWivRwAwYYOMLDa7+SK8aJVxFUXEi48d+EZkD2i2NXuYqmRiaMKyVkwnWHLRIQd83Lo+G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEPrgIcBO/pI44YrUNc/Ckr+LftVJXYU3eI3gXu1/WY=;
 b=TVwW5UjXeRUhTSICjnBMpANVG4/KZtIdHLL2xvL1OyMPCctHeV7yDZX5NpLfZ5+agIJ+bxy+rLNH2ItRQOEgBgWY9O/ybYT7o/PE+uDJGmud8WPedx47ewAD4xlUa1gOCoZwJ2SwHQNPQlM5SzEXSEHuzMDlMMfZ+XeMHPwPvyfM3Lvx+epcJhn70jwGxB0Wv6vQqrtDcCtO4TrFatnqO0ArEs3rygpJAHvh4Olq8YPtgG9eISVSQekuyh3V9hlivqHtBxNAT+1iJcvCmdrvmsjIL33UIfrECMYmr9uZTS4xqSey8gXmBStcuIZ/qpwRAD2FIUg7fEfX720ANWKoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEPrgIcBO/pI44YrUNc/Ckr+LftVJXYU3eI3gXu1/WY=;
 b=Ad3R8kg49mg8/bN34xlUg01LnMwjp7r/A9iHvtAeY3HaH9/kmM39SfmjrDvj1BEhyvhOU7lXOS6QN1nIGokUUzXzPZYRqi2V47S5GTeZNAVdzs3Mrfa+NJoUIISpV/Dt8MdjwMwzBi0OKc+OlC6enQ/rM8itEfLvxDGXN9GHy94=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SI2PR03MB5754.apcprd03.prod.outlook.com (2603:1096:4:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:58:48 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:58:48 +0000
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
Subject: Re: [PATCH v2 1/7] ASoC: mediatek: mt7986: add common header
Thread-Topic: [PATCH v2 1/7] ASoC: mediatek: mt7986: add common header
Thread-Index: AQHZp9beDI9HtDsyeESc3V6YM24Oya+pXHeAgAGA6IA=
Date:   Wed, 5 Jul 2023 07:58:48 +0000
Message-ID: <2c1f1a22247ba54600950e4a4b089ec8dacb401c.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-2-maso.huang@mediatek.com>
         <bb13702f-801d-57f4-64d1-077dd977d43b@collabora.com>
In-Reply-To: <bb13702f-801d-57f4-64d1-077dd977d43b@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SI2PR03MB5754:EE_
x-ms-office365-filtering-correlation-id: ccac185d-de00-4a32-bac4-08db7d2daa50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SsC+momHRZNMn0QU85CoNo+d6m4Sykc7Nm8KvKnofAiAWrFU9SvFvXvd7loDssitINXTfeWbC5QAx/WIXDtJdyTExMNrE2qxImo+JftsHe/plg/AjncE9zeOC0xHs6ex2DikqS35c1TEmiK1NKZfZH4revkkSEI9RTMVbjZw36inGiVs0CLqjlkFsgtO3fEpU9cu70IUOI2DlepqLSiUxEp/1fQrHzbQiy0koaZAAb5srfxKVoNSHs3K95j+Mz9nOkY2Em/S50tbFDcuasN8NYTrn/1kYomUccu8te7DbKQdCqvqLaPSHndbLIhsc9u7EQGxu0w/gwBKhZGQQ2RkD8r8Z+lZpsws2QEgnwuId/oOcUXZEgB/2FKOqicZ1OWNLoRB1CRRQcADSOXcHNZEloCxMRtsYmjn3lhuEPE2oDijsyMAiofyLBQnLpMx7DHGGNi3dKxe5iodBEYuZwkuEVHUMoMkk1BK/v2QrJaIHX863LJP70YEpbEyOHcSH6a7LoSaRObzkVKCbw4TdXuFpiXta8x5BZjKYKRCnDjj7BRKfooFNyv7qEGNyBaKPKsji6+c4TYsbo0LXYAKrfODGE70Krwqe3NzobQon8X/9x5usCoVTk0kgG5aYd2XvJpLZniuzdcD66FQQfjk7+bwvVmgKW3Sm0VZ1Et1sob0gfQMwZ/E2Y3MvZh68DApOues
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(478600001)(6486002)(71200400001)(91956017)(110136005)(76116006)(186003)(6506007)(26005)(6512007)(2906002)(66946007)(316002)(41300700001)(66476007)(66556008)(7416002)(8676002)(8936002)(5660300002)(122000001)(921005)(38100700002)(66446008)(64756008)(38070700005)(86362001)(2616005)(83380400001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXZrYnZvbnlFOHE5N3JEckZZZG1EVkRmcFlxa25yVi9nNjdIcTJ4VUZuc3ZX?=
 =?utf-8?B?TzFSQTN1SEdRcmxoMS9lK1V2VDNFTE92UWdkbElNMkl2SjlUYm85NGdDKy9L?=
 =?utf-8?B?RU9YMXdwV1ZaKzJMbTI4U2FnTjBqTFF5YzgzakdnM01sMmxzTFlQUDZuK2ps?=
 =?utf-8?B?ZVA5a3EwKzBUN1p6ZzhuNEZ1QzZCeThPS0c2ZEM1OFBFUCtzMitHYkp5d3NO?=
 =?utf-8?B?b095S1g2NXQrbm9QNkVPTWc5WVFaZUhhUjRUWlUyVFE0K0R6MUFmc0RoUHlB?=
 =?utf-8?B?c0NsSWF3bHhTNEVQWFZ1YmMxemVrMDBQRVhKRU5rTjN1clNHM0xwMVc3VUo2?=
 =?utf-8?B?KzFvRTBqcjQraDhXTHc5TWllVHYyOUQ4YnV3L1hob2QyU1BJMTFpVnVnVjYz?=
 =?utf-8?B?K2VLSjlORERGdGlxdEMvVVpaeU5YVnFGU1d5ZlhxVEwwVitlR1VzckhnRDhX?=
 =?utf-8?B?WEFwR2hmZDdqWlRwdW1FUGNuWUhmNzZJc2hsZjBHRFIrWkFqdHdGWEJlZ0R6?=
 =?utf-8?B?MzdLSjF3QmpjcnRWWmJiT0JBYWpReG10OEZTbXdXTFJsNzFRWjhjMTVWemdx?=
 =?utf-8?B?UWZpUTVMMFNiRlFaT3J4UVNTQy9CNGpxUmtrKzllclVrTENxdU1QcWJ6eGVB?=
 =?utf-8?B?dVM1UStpcXpvbHBxWFQ4RmhJR3hjQThoREFHckFZL1g2Q0NqSC9wUmtNRzh3?=
 =?utf-8?B?WGRmaTRiWG5VWHBQcG1tUnBQQkFST2xqVHhHUjJPN0pYL3hnLzFqQkJFQzdV?=
 =?utf-8?B?eDVKNklNU01EcmphMXlmQjA1cUpzU3Zicjl1NDUya0ZUUHUzaStRd1RMcldr?=
 =?utf-8?B?Nnh5dWVLN1JEMGt0Y3BBNVVZZm9MOGdIbk1wdTVldURjdGd0QkgyVE5La0Uy?=
 =?utf-8?B?ckFPQUl4MkIyRExXdzI5cnorVjFwOHlHTmMxY1B6RzhPbHd6M09tMUk3Z3Rk?=
 =?utf-8?B?bVpUb2hRT0pBSURIcXYvUDBGRmV3TkN4aHRpRnNJYU4wRGNJOEdGWjZvNzNI?=
 =?utf-8?B?SWVrY2ZPZFgwTVd6MUhNcUdOZHF5NjJhMmpyZUZZZlJhbnlPemhRdXhpTFR0?=
 =?utf-8?B?eDAwdld0UllEYmFwMVYxRnJTY0pFNzdlNlVmV1RQS2txUGMxY3VJR0FqaFRq?=
 =?utf-8?B?TjMyR2pnRG5lalpEMEVqT2ZlMVp1RnBlUTBaL1JUSHYwelkwMDhIS0cyTHBY?=
 =?utf-8?B?Y1dWQkdOQmpoemFRMy9CdVQrOHN4aGRJdUZPUUE2VjdNaVM0VDAwRlhha05Z?=
 =?utf-8?B?aXJoYWNvUVJlV1NWVFhTUFhTVkdybk1XRWZwQ2pHQTBHWVFrZGRrNUhMSkpv?=
 =?utf-8?B?TVRrMmlwdTdreXdQU2dsQm9DOWJmVzRZZ3E0VjM0MEtlMW1USk9RbEVEK0w4?=
 =?utf-8?B?TTVreStTQzRQSE9qKzNsQmtsMjJKUzBJV1J4NEpHczZDdGVsWWU1cEloTzhQ?=
 =?utf-8?B?UW1Lc3d1eHRMNEZoQVNOSWVidGhyYW03UmcvRE90clJnYjVUa2owdWJTUTEy?=
 =?utf-8?B?QU5MNkVuYWM0eUl0VEVIUzhwOUZranAvR04xd3N3VG1qcDVVSmhVR3BWQTZJ?=
 =?utf-8?B?UGlJMlRYRENNdkdVMStHdVpNQVE2OWFyQWFtYjdrejlveTJZR3dNSGd0VzFs?=
 =?utf-8?B?MnBSSjBxdlB6S1NNZ0RUM1dGVE85T0hpZEJoUjVRL3RIQjlVWnplMFNNdXFP?=
 =?utf-8?B?M0RBZXdscnYyN1R4SkxCaHZrTERMZmVHVnJ3cEoxMm5vWlNjZTNUMTcwZWxy?=
 =?utf-8?B?RGJEQkhnbmUzR0lHZXg1L09HcDdQQ20xREpQWHZNQVhYT2FRdGFTM0llcnFs?=
 =?utf-8?B?TUxtc1N4dFJ2YWRrVE9laEF0MWNpNTBQTHg5NDdjcVJuckFDUHVjdEZVMHE4?=
 =?utf-8?B?ZGdYOFlQOTVIWGZxcFRmbnhualhJTFcxUno3ek5teENYdnBYYlI3N2Z1WFo5?=
 =?utf-8?B?NmFZVlRZd2VJWnFaK0U4RUZnRGZEZm5xeTFHTlJwdC96YUFWN2U0Wm8zaUlH?=
 =?utf-8?B?Q2FnVG8vRmtKYVdYS1JxREJCdnRQN214K0ZrOUlwekZ5ZjJ6SWQwYUgxUUpm?=
 =?utf-8?B?cm9HeEZJaVBlbUw1QzFOWHZocDZzL1Q1VlBMYW5CV0VQeVB0Rzh0UDJ5V0xy?=
 =?utf-8?B?SVRMZkozaG14a01VRGdHbDFwTmJpZ2dqT2VFZGxEcWJhR1lHbGF0NVo3WEFw?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43AB029ED4174F4E9086BF32D3877B84@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac185d-de00-4a32-bac4-08db7d2daa50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 07:58:48.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoB0hISRv9XJUSE9zYPn9Y+phuDE3MBD8FETktF+eyAsg6hqN5evU/1W85xZdIO4RA2cl0uyGEeijJ/rnW4X5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDExOjAxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAyNi8wNi8yMyAwNDozNCwgTWFzbyBIdWFu
ZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCBoZWFkZXIgZmlsZXMgZm9yIHJlZ2lzdGVyIGRlZmluaXRp
b24gYW5kIHN0cnVjdHVyZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxt
YXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRl
ay9tdDc5ODYvbXQ3OTg2LWFmZS1jb21tb24uaCB8ICA1MSArKysrKw0KPiA+ICAgc291bmQvc29j
L21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtcmVnLmggICAgICAgIHwgMjA2DQo+ICsrKysrKysrKysr
KysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNTcgaW5zZXJ0aW9ucygrKQ0KPiA+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWFmZS1j
b21tb24uaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5
ODYvbXQ3OTg2LXJlZy5oDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRl
ay9tdDc5ODYvbXQ3OTg2LWFmZS1jb21tb24uaA0KPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5
ODYvbXQ3OTg2LWFmZS1jb21tb24uaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi42NDZlMWJlNGZkY2UNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNvbW1vbi5oDQo+ID4gQEAg
LTAsMCArMSw1MSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAq
Lw0KPiA+ICsvKg0KPiA+ICsgKiBtdDc5ODYtYWZlLWNvbW1vbi5oICAtLSAgTWVkaWFUZWsgNzk4
NiBhdWRpbyBkcml2ZXIgZGVmaW5pdGlvbnMNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChj
KSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gPiArICogQXV0aG9yOiBWaWMgV3UgPHZpYy53dUBtZWRp
YXRlay5jb20+DQo+ID4gKyAqICAgICAgICAgTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBfTVRfNzk4Nl9BRkVfQ09NTU9O
X0hfDQo+ID4gKyNkZWZpbmUgX01UXzc5ODZfQUZFX0NPTU1PTl9IXw0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgPHNvdW5kL3NvYy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4g
PiArI2luY2x1ZGUgIi4uL2NvbW1vbi9tdGstYmFzZS1hZmUuaCINCj4gPiArDQo+ID4gK2VudW0g
ew0KPiA+ICtNVDc5ODZfTUVNSUZfREwxLA0KPiA+ICtNVDc5ODZfTUVNSUZfVlVMMTIsDQo+ID4g
K01UNzk4Nl9NRU1JRl9OVU0sDQo+ID4gK01UNzk4Nl9EQUlfRVRETSA9IE1UNzk4Nl9NRU1JRl9O
VU0sDQo+ID4gK01UNzk4Nl9EQUlfTlVNLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArZW51bSB7DQo+
ID4gK01UNzk4Nl9JUlFfMCwNCj4gPiArTVQ3OTg2X0lSUV8xLA0KPiA+ICtNVDc5ODZfSVJRXzIs
DQo+ID4gK01UNzk4Nl9JUlFfTlVNLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGNsazsN
Cj4gPiArDQo+ID4gK3N0cnVjdCBtdDc5ODZfYWZlX3ByaXZhdGUgew0KPiA+ICtzdHJ1Y3QgY2xr
X2J1bGtfZGF0YSAqY2xrczsNCj4gPiAraW50IG51bV9jbGtzOw0KPiA+ICsNCj4gPiAraW50IHBt
X3J1bnRpbWVfYnlwYXNzX3JlZ19jdGw7DQo+ID4gKw0KPiA+ICsvKiBkYWkgKi8NCj4gPiArdm9p
ZCAqZGFpX3ByaXZbTVQ3OTg2X0RBSV9OVU1dOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArdW5zaWdu
ZWQgaW50IG10Nzk4Nl9hZmVfcmF0ZV90cmFuc2Zvcm0oc3RydWN0IGRldmljZSAqZGV2LA0KPiA+
ICsgICAgICAgdW5zaWduZWQgaW50IHJhdGUpOw0KPiA+ICsNCj4gPiArLyogZGFpIHJlZ2lzdGVy
ICovDQo+ID4gK2ludCBtdDc5ODZfZGFpX2V0ZG1fcmVnaXN0ZXIoc3RydWN0IG10a19iYXNlX2Fm
ZSAqYWZlKTsNCj4gPiArI2VuZGlmDQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRl
ay9tdDc5ODYvbXQ3OTg2LXJlZy5oDQo+IGIvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5
ODYtcmVnLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uNjQzM2NkZjNkYTkyDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3NvdW5kL3NvYy9t
ZWRpYXRlay9tdDc5ODYvbXQ3OTg2LXJlZy5oDQo+ID4gQEAgLTAsMCArMSwyMDYgQEANCj4gPiAr
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICog
bXQ3OTg2LXJlZy5oICAtLSAgTWVkaWFUZWsgNzk4NiBhdWRpbyBkcml2ZXIgcmVnIGRlZmluaXRp
b24NCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIxIE1lZGlhVGVrIEluYy4NCj4g
PiArICogQXV0aG9yOiBWaWMgV3UgPHZpYy53dUBtZWRpYXRlay5jb20+DQo+ID4gKyAqICAgICAg
ICAgTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gKyAqLw0KPiA+ICsN
Cj4gPiArI2lmbmRlZiBfTVQ3OTg2X1JFR19IXw0KPiA+ICsjZGVmaW5lIF9NVDc5ODZfUkVHX0hf
DQo+IA0KPiAuLnNuaXAuLg0KPiANCj4gPiArLyogRVRETV9PVVQ1X0NPTjQgKi8NCj4gPiArI2Rl
ZmluZSBPVVRfUkVMQVRDSCh4KSAgICAgICAgICAgICAgICAgICgoeCkgPDwgMjQpDQo+ID4gKyNk
ZWZpbmUgT1VUX1JFTEFUQ0hfU0ZUICAgICAgICAgICAgICAgICAyNA0KPiA+ICsjZGVmaW5lIE9V
VF9SRUxBVENIX01BU0sgICAgICAgICAgICAgICAgR0VOTUFTSygyOCwgMjQpDQo+ID4gKyNkZWZp
bmUgT1VUX0NMS19TUkMoeCkgICAgICAgICAgICAgICAgICAoKHgpIDw8IDYpDQo+ID4gKyNkZWZp
bmUgT1VUX0NMS19TUkNfU0ZUICAgICAgICAgICAgICAgICA2DQo+ID4gKyNkZWZpbmUgT1VUX0NM
S19TUkNfTUFTSyAgICAgICAgICAgICAgICBHRU5NQVNLKDgsIDYpDQo+ID4gKyNkZWZpbmUgT1VU
X1NFTF9GUyh4KSAgICAgICAgICAgICAgICAgICAoKHgpIDw8IDApDQo+IA0KPiBBIG51bWJlciBz
aGlmdGVkIGJ5IHplcm8gYml0cyBpcyBlcXVhbCB0byBpdHNlbGYsIHNvLCB0aGlzIHN0YXRlbWVu
dA0KPiBkb2Vzbid0DQo+IG1ha2Ugc2Vuc2UuIEkgdW5kZXJzdGFuZCB3aHkgeW91IHdhbnQgYSBP
VVRfU0VMX0ZTKHgpIGRlZmluaXRpb24NCj4gdGhvdWdoLCBzbw0KPiB5b3UgY291bGQgZG8gaXQg
bGlrZToNCj4gDQo+ICNkZWZpbmUgT1VUX1NFTF9GUyh4KSh4KQ0KPiANCj4gQWZ0ZXIgd2hpY2gs
DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vs
bw0KDQpIaSBBbmdlbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpJJ2xsIGZpeCB0aGlz
IGluIHYzIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQoNCg==
