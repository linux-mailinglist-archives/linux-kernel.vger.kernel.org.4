Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7A70F150
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjEXIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbjEXIot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:44:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8E135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:44:46 -0700 (PDT)
X-UUID: 387406e0fa0f11edb20a276fd37b9834-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=R4LxsoPxauq3iIPc1jGC11LoRDJXn5Om0AS/acI6g6Q=;
        b=LfKSSO6nEbXgHoHRGWWBCCsZt/P3otXnHNpb9553Tb5A1l7uTEPW+A5KTrzk/EH+l4YCGK1hV2tCXsM5KWYCK5g4YtjZ6xBC/JBw/UMkPYPSwIYpy2a1C1DAXg40HwAD946R18NT/z9Oe7GlHWSEcZFVUbGWgDLVYVj+lfk2ewY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b752ceca-a541-4666-b70f-d7e2eba36e4f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:b752ceca-a541-4666-b70f-d7e2eba36e4f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f9ed333c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230523020317SV4SAQJT,BulkQuantity:26,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 387406e0fa0f11edb20a276fd37b9834-20230524
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 262056934; Wed, 24 May 2023 16:44:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 16:44:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 16:44:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFlKYCf1e/t48SYCmSUZK8an9DoF8IZBJo7JlOWdWUCiAwqOMOjz+Cq5Q5PUUIOdCQcTrsIkZLc48oKPuK4eb/tEFUnBl+321CDMEy9XXckS9BrTUaTGJWo0t0FOn5xOpHqLyeVXOnIqKGvQG16tW8BBkA3Qo+RmDolx8sS0WqTcqN48sQ8I3z5uj4xBsTrqxAfMyYnuqfdC0DvJUEUtddof/P9BNuhKiapiKWrG19xApJ6gyA680D3pcY3oBGpOSCmiKij64x6mW9M6DOt1GDBPqOjMICuI/KHBDrjTW3kJ6zyj6cN/Q/BcmDtRjzMB6whFB7REFEhf7I8se4ER3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4LxsoPxauq3iIPc1jGC11LoRDJXn5Om0AS/acI6g6Q=;
 b=YiTnzyyth6VS5XCAaO0G1U6qJM1mUIoaA5hnAuwoa5VJScmOIDN2cl/SPoUFZ1r37Gwchd/e8e4hj4WmxFEjiUGbEAoMs0nvBzWG40dvjO5VmbqwFWzCT3iSfR6Uh2K7J9L9H9j8QjTF8y7LAUjwPVfL7fXVpeWo3IHO2HujYPS6f9AMPorbsqCCpEQZg4Ar9nibhjY0HakTmIBwX+WF1l1ZBbwyEMvQOLT9HceOLIrzhHPmWQHrQQfucwZhAUGXyAUJ2yEcWkrWq1FT6ksT9IwEBdD/fL7LF52grHrEF3s/QQeDc41JXeRX+PB+L2qGca7aGg81ML8bsl+p++UUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4LxsoPxauq3iIPc1jGC11LoRDJXn5Om0AS/acI6g6Q=;
 b=sPlgLWaA7l88Ok4lpCa8K3g8H8NUoJf5x88g/ccrXnTe5ICYfwJsfVIIEX9ZXjn5Dub8Fegw1Kn/N50BNYqt9DQDp+TPyGDtjb/40khTO+qcClThOOQOiWkHJPRDgCWh9S0wqlMFmmRX9gmO6ddwXgrVvspu2FF+qVnK0Ixh4xY=
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com (2603:1096:4:142::9) by
 TYZPR03MB7317.apcprd03.prod.outlook.com (2603:1096:400:41c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:43:31 +0000
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458]) by SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458%6]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 08:43:31 +0000
From:   =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>
To:     "daniel@makrotopia.org" <daniel@makrotopia.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>, "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: mediatek: Raise proc and sram max voltage
 for MT7622/7623
Thread-Topic: [PATCH v2 4/4] cpufreq: mediatek: Raise proc and sram max
 voltage for MT7622/7623
Thread-Index: AQHZXjkW4Q3uqsjo4k+WdVF9MbgoKa9m8tgAgAFeTYCAACz2AIAA6CqAgAAU6gA=
Date:   Wed, 24 May 2023 08:43:31 +0000
Message-ID: <4e5a8202f7446481def19e5926d1bfd6e6568dd7.camel@mediatek.com>
References: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
         <20230324101130.14053-5-jia-wei.chang@mediatek.com>
         <ZGuuVPCqgpUO6p0Q@makrotopia.org>
         <a1793745-eae3-cae5-49fc-2e75fe0847f0@collabora.com>
         <ZGz55oEEAhlWZajK@makrotopia.org>
         <3054e2d9-7f77-a22a-293d-382f19494079@collabora.com>
In-Reply-To: <3054e2d9-7f77-a22a-293d-382f19494079@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5830:EE_|TYZPR03MB7317:EE_
x-ms-office365-filtering-correlation-id: ecf1a903-ba32-4f0b-f6d6-08db5c32f425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zW31PwSPlP7DpB1SJnhziZ3YrF1LCRj75iNNQqZHZb6jlH2WiNETzZt/hZqa6MHepQRKZF6zsTpQfokHicR4zyqH6GgUKDZHL+SWuq4FAt5LHrmS+sr3bCD4tzYLVHmgpnm1U7hB8R0eZQ9+uYR48s61rYyT76WqhJYe11sZPYfyftzEGiFRSSzMGD4ikQQa9By5DXYepD4pBSbt1rVCrvlP8GnJ1Nh16pmI+9nv6arxYQmUM3zZNM53lAKXkuh9jiXA702xnWoHly41YZ3L96qrUSDoMI5DJaLvEahgn1wIkUvG023+tbKRU8fJpE8MSsZe4/N5t8FER6FNS5SyDdrnAJjmYueesisqNPoNeBNeSKUKlM52R/3U2RkP6uSjqiuKqoxkPX2jjuk+92tpWtTFfR7n73RaOYwGcjdpbEm1i9vg/YDbB6kEWjYV7Vyu10ZEc431xgvmN/b7ei1iccJ+OW01NEb1+SF66dduvvWM+WPBgpNEwfuopTVx21jx0Ay4Yu0+nOHkrrqoajus0Hw5sLkqpp9M7G75cdpga940kKjVyrfkaJeC+Wb8PaEU6Qbg5BtyTR5ojiKr51hXYJJ0C/e+4B2s4JxExfeH18U+oEOw/g1jIorK873Sl8BKnMZm+N064IA/VZgCcDO4FWo0BtViw1eB1aMlJPeWNbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5830.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(38100700002)(6486002)(54906003)(41300700001)(478600001)(110136005)(316002)(71200400001)(91956017)(4326008)(76116006)(86362001)(64756008)(66946007)(66556008)(66476007)(66446008)(5660300002)(38070700005)(8936002)(8676002)(2906002)(6506007)(26005)(6512007)(122000001)(186003)(7416002)(83380400001)(2616005)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R05hams2R2ticUdkVnJXTDRPVHdKNzB6Nkh3SmJTTjRtbFUvSE1Nc1RYbjBK?=
 =?utf-8?B?aEhBOUhad1VUQWpEd3NNMi9mdndod2hzb0lHUHZpSFphQ0lJNFB0UHlGeWRD?=
 =?utf-8?B?VUwyajc1bk5NNEJsWkdtczZoYUlReGxkRDVTbUlacVVLWGhZV3h1V3dvQUE5?=
 =?utf-8?B?OWlrTDFqbE1OTW1WK3FVZ082M1pQTlVqa2VTcGhtOGlWM3V6dlRheERQKzdW?=
 =?utf-8?B?aUIzMnZrRmcvazhFT1NLdjhvU1VaQ1pSOGxLTkVkRkprcmcwcDBPQXRiTkR0?=
 =?utf-8?B?SElBaDBkNEZsUklkdVpnVlpxaDd0UWtCcm9lOTYyYktjYUd4Q0FhOG0rbzR0?=
 =?utf-8?B?RnlFbDRNRGZwY09uL1doZmoxcnptUlJjOUhTZE9sNXRYYTFCRDNicHFKWTVt?=
 =?utf-8?B?M3hpaU9OUDB1d2dHYzAxT2EyWUYybHEvdG5GY2FOaUt5YUdMMk9wVU1MRHpn?=
 =?utf-8?B?aUJQRzErMHFzc294di9qSFI0QTdab3hZVGdmWFkrTGh0Ui9ZdjkwcHAyVVk0?=
 =?utf-8?B?Vm9xOUlVV2M2WHJVRmlCUEkzTlhpRXRFUk5wdGtVYTZ2QWsvTVF1V1pQQ1FD?=
 =?utf-8?B?Zm9KTXJuMDE3dnZJMXNvOXhtNEcrN3NUclJYNVR6YUpiQ1UrbmxEeWJOanhK?=
 =?utf-8?B?NW5jak1UNDd0ZVNQM3JQV3VkOGZCOHVKTHJQZFpKWUt6WklUbGhLK0dEK1hp?=
 =?utf-8?B?a05wUmVoQW5rMFBrODdXT1g5VGpxUFlXUk5WSi9pVlJBTGluTWJ2VzUxckEr?=
 =?utf-8?B?STQrT3Q0OFo5bEpka2hIcmNjN0xkQkpEenhqbnhzUER1eEhvV1FnekZ1bmJu?=
 =?utf-8?B?alh2ek9aWGVObUFNWGxzOFZQZTNReE9jb1cweDA3TGp1WVgzajlJVWVaaFJN?=
 =?utf-8?B?SlVJdmk5NHNnL1RWaklaYmxvd205UjFveE1Ndk1BL1p1U25GbHFkdXJUTXFP?=
 =?utf-8?B?Yi9wb2p4bVg2OG1mbXVVa3dLTXRwTWYrc2ZHNkJqb3B1c1A0ZDlHWjBSV1A3?=
 =?utf-8?B?Tmx2YVVrQm16aHA5d1lvTW53QnliZGh6VkxiMEFJZ2h0R3hmL3dsWFUvRU1Q?=
 =?utf-8?B?V0s2MXhrNy9LVXgrS0JpeFZ4eHhJOFMrVXF5Y3ZEeTh6cEpuZWozRzVFS0sv?=
 =?utf-8?B?VGEyeTloMUdUOHhCQis5RTFlVFZLQXNvWUtWRDhqN1Iza2c5bkNJdDBRQjYz?=
 =?utf-8?B?ZDBpT3htYjk0dFl5VFJ3TWJsSW4rVmxoNnVWZVhRbTBZam1kSzNtMVhvaDFU?=
 =?utf-8?B?TGxNRTZxM3Vwc3V5QlB3SXg0a3d3aFVHcnBCdmJEZDBxOVBOVkE5V0xEbmp1?=
 =?utf-8?B?U2N4S0NTVDgxTklPTit5RDFkeURTeWV2TEI0aENrK1ZzNWRwSVBhYWozMmIx?=
 =?utf-8?B?WFFpWnBnK0VSU1Bxdm5YV1RkYzRiWFQ5RjVVSi9rU3FtZHVCZms1WGFibklO?=
 =?utf-8?B?NTlyTm0zQXNwN0ZQTjcvdkRrN1ZrUS8wbHdVN2R6V3Y3a3JxTDRmOGpCUXla?=
 =?utf-8?B?d25QeGxYRU0rYnpObTAwTm9hNVBOdi9Ncm9OdjlpOWNGdURHRFoxc2ZEeEhV?=
 =?utf-8?B?OXVvOVJHWnkwTU5hNnhIUXRxMlZzS056TXBJL2dMdDBPdkhXTTR5Y2JkNGFB?=
 =?utf-8?B?TWR3SGNveU92QTZISGNHbmZXSFZSQisvWDVEUEgwaS9GaTBGUDRsMm16N2VC?=
 =?utf-8?B?cUoxSnBVTmFNc1hyMXBKSHpoZm85SWxyOVdnMFFUamEvSFRucjNrcm5UL2Jz?=
 =?utf-8?B?bmFLYUJsWWRaclA0WTVxck9QeERaT0dEbnJzT0pvNVhHUXMxbHpsS1ZSZFdE?=
 =?utf-8?B?KzFScE16U3RFekpmanByZmFsNmZGblFTZGZHNDVkcTZGa0FMTm51MVYzUHR2?=
 =?utf-8?B?Vm56c00xdzJ1RUthUForbnR1c21OekIzY3o5Q1Q0ZGlabm1jY0MvZ3pEbkww?=
 =?utf-8?B?NlNPTC8xcHJYK1p5YVl4Sm9ReWJmTzRicE1maUQwVWZ5STdacGt6Wm9iTldI?=
 =?utf-8?B?ZWhJVVpLWXpzTi9rV3ZTem1sYkFDZ3BSRmZWa2l0WW0yNHpQTjJUL0l5N2ZT?=
 =?utf-8?B?bjJwdjVwYWpnV1ZzR0QxMGR4TFJCa1NTT1ExdjNYbk9SbTBjWmt5aGZISmUz?=
 =?utf-8?B?UVAzQ3JlR3RvY095RVlsS284NVFva3hZWHpWSnVlRjVUQjJjZmsydSt0TjBB?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FEAB5A798150843896D2450A6D8B9B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf1a903-ba32-4f0b-f6d6-08db5c32f425
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:43:31.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8msPfII7z7x6XeE6b+3NskII56f9NfzrH6CWoAaKH3LL/fuIJzTfhjZX53NRduiE0/mm2f200m0Qee7BN1ULtNf8WoLF7OC0YsD6Zi+A7vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyMy8wNS8yMyAxOTozNywgRGFuaWVsIEdv
bGxlIGhhIHNjcml0dG86DQo+ID4gT24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMDQ6NTY6NDdQTSAr
MDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwNCj4gPiBSZWdubyB3cm90ZToNCj4gPiA+IElsIDIy
LzA1LzIzIDIwOjAzLCBEYW5pZWwgR29sbGUgaGEgc2NyaXR0bzoNCj4gPiA+ID4gSGkgSmlhLVdl
aSwNCj4gPiA+ID4gSGkgQW5nZWxvR2lvYWNjaGlubywNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZy
aSwgTWFyIDI0LCAyMDIzIGF0IDA2OjExOjMwUE0gKzA4MDAsIGppYS13ZWkuY2hhbmcgd3JvdGU6
DQo+ID4gPiA+ID4gRnJvbTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gPiA+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBEdXJpbmcgdGhlIGFkZGl0aW9uIG9mIFNSQU0gdm9sdGFnZSB0cmFja2luZyBmb3Ig
Q0NJIHNjYWxpbmcsDQo+ID4gPiA+ID4gdGhpcw0KPiA+ID4gPiA+IGRyaXZlciBnb3Qgc29tZSB2
b2x0YWdlIGxpbWl0cyBzZXQgZm9yIHRoZSB2dHJhY2sgYWxnb3JpdGhtOg0KPiA+ID4gPiA+IHRo
ZXNlDQo+ID4gPiA+ID4gd2VyZSBtb3ZlZCB0byBwbGF0Zm9ybSBkYXRhIGZpcnN0LCB0aGVuIGVu
Zm9yY2VkIGluIGEgbGF0ZXINCj4gPiA+ID4gPiBjb21taXQNCj4gPiA+ID4gPiA2YTE3YjM4NzZi
YzggKCJjcHVmcmVxOiBtZWRpYXRlazogUmVmaW5lDQo+ID4gPiA+ID4gbXRrX2NwdWZyZXFfdm9s
dGFnZV90cmFja2luZygpIikNCj4gPiA+ID4gPiB1c2luZyB0aGVzZSBhcyBtYXggdmFsdWVzIGZv
ciB0aGUgcmVndWxhdG9yX3NldF92b2x0YWdlKCkNCj4gPiA+ID4gPiBjYWxscy4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBJbiB0aGlzIGNhc2UsIHRoZSB2c3JhbS92cHJvYyBjb25zdHJhaW50cyBm
b3IgTVQ3NjIyIGFuZA0KPiA+ID4gPiA+IE1UNzYyMw0KPiA+ID4gPiA+IHdlcmUgc3VwcG9zZWQg
dG8gYmUgdGhlIHNhbWUgYXMgTVQyNzAxIChhbmQgYSBudW1iZXIgb2Ygb3RoZXINCj4gPiA+ID4g
PiBTb0NzKSwNCj4gPiA+ID4gPiBidXQgdGhhdCB0dXJuZWQgb3V0IHRvIGJlIGEgbWlzdGFrZSBi
ZWNhdXNlIHRoZQ0KPiA+ID4gPiA+IGFmb3JlbWVudGlvbmVkIHR3bw0KPiA+ID4gPiA+IFNvQ3Mn
IG1heGltdW0gdm9sdGFnZSBmb3IgYm90aCBWUFJPQyBhbmQgVlBST0NfU1JBTSBpcyAxLjM2Vi4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGaXggdGhhdCBieSBhZGRpbmcgbmV3IHBsYXRmb3JtIGRh
dGEgZm9yIE1UNzYyMi83NjIzDQo+ID4gPiA+ID4gZGVjbGFyaW5nIHRoZQ0KPiA+ID4gPiA+IHJp
Z2h0IHtwcm9jLHNyYW19X21heF92b2x0IHBhcmFtZXRlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBGaXhlczogZWFkODU4YmQxMjhkICgiY3B1ZnJlcTogbWVkaWF0ZWs6IE1vdmUgdm9sdGFnZSBs
aW1pdHMNCj4gPiA+ID4gPiB0byBwbGF0Zm9ybSBkYXRhIikNCj4gPiA+ID4gPiBGaXhlczogNmEx
N2IzODc2YmM4ICgiY3B1ZnJlcTogbWVkaWF0ZWs6IFJlZmluZQ0KPiA+ID4gPiA+IG10a19jcHVm
cmVxX3ZvbHRhZ2VfdHJhY2tpbmcoKSIpDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaWEtV2VpIENoYW5n
IDxqaWEtd2VpLmNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAg
ICBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jIHwgMTMgKysrKysrKysrKystLQ0K
PiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEv
bWVkaWF0ZWstY3B1ZnJlcS5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWst
Y3B1ZnJlcS5jDQo+ID4gPiA+ID4gaW5kZXggNzY0ZTRmYmRkNTM2Li45YTM5YTdjY2ZhZTkgMTAw
NjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEuYw0K
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMNCj4gPiA+
ID4gPiBAQCAtNjkzLDYgKzY5MywxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0DQo+ID4gPiA+ID4g
bXRrX2NwdWZyZXFfcGxhdGZvcm1fZGF0YSBtdDI3MDFfcGxhdGZvcm1fZGF0YSA9IHsNCj4gPiA+
ID4gPiAgICAgICAgICAgIC5jY2lmcmVxX3N1cHBvcnRlZCA9IGZhbHNlLA0KPiA+ID4gPiA+ICAg
IH07DQo+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2NwdWZyZXFfcGxhdGZvcm1f
ZGF0YQ0KPiA+ID4gPiA+IG10NzYyMl9wbGF0Zm9ybV9kYXRhID0gew0KPiA+ID4gPiA+ICsgIC5t
aW5fdm9sdF9zaGlmdCA9IDEwMDAwMCwNCj4gPiA+ID4gPiArICAubWF4X3ZvbHRfc2hpZnQgPSAy
MDAwMDAsDQo+ID4gPiA+ID4gKyAgLnByb2NfbWF4X3ZvbHQgPSAxMzYwMDAwLA0KPiA+ID4gPiA+
ICsgIC5zcmFtX21pbl92b2x0ID0gMCwNCj4gPiA+ID4gPiArICAuc3JhbV9tYXhfdm9sdCA9IDEz
NjAwMDAsDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGNoYW5nZSBicmVha3MgY3B1ZnJlcSAod2l0
aCBvbmRlbWFuZCBzY2hlZHVsZXIpIG9uIG15IEJQaQ0KPiA+ID4gPiBSNjQNCj4gPiA+ID4gYm9h
cmQgKGhhdmluZyBNVDc2MjJBViBTb0Mgd2l0aCBNVDYzODBOIFBNSUMpLg0KPiA+ID4gPiAuLi4N
Cj4gPiA+ID4gWyAgICAyLjU0MDA5MV0gY3B1ZnJlcTogX190YXJnZXRfaW5kZXg6IEZhaWxlZCB0
byBjaGFuZ2UgY3B1DQo+ID4gPiA+IGZyZXF1ZW5jeTogLTIyDQo+ID4gPiA+IFsgICAgMi41NTY5
ODVdIGNwdSBjcHUwOiBjcHUwOiBmYWlsZWQgdG8gc2NhbGUgdXAgdm9sdGFnZSENCj4gPiA+ID4g
Li4uDQo+ID4gPiA+IChyZXBlYXRpbmcgYSBsb3QsIGV2ZXJ5IHRpbWUgdGhlIGhpZ2hlc3Qgb3Bl
cmF0aW5nIHBvaW50IGlzDQo+ID4gPiA+IHNlbGVjdGVkDQo+ID4gPiA+IGJ5IHRoZSBjcHVmcmVx
IGdvdmVybm9yKQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBNVDYz
ODBOIGRvZXNuJ3Qgc3VwcG9ydCAxMzYwMDAwdVYgb24gdGhlDQo+ID4gPiA+IHN1cHBseQ0KPiA+
ID4gPiBvdXRwdXRzIHVzZWQgZm9yIFNSQU0gYW5kIHByb2Nlc3Nvci4NCj4gPiA+ID4gDQo+ID4g
PiA+IEFzIGZvciBzb21lIHJlYXNvbiBjcHVmcmVxLW1lZGlhdGVrIHRyaWVzIHRvIHJpc2UgdGhl
IFNSQU0NCj4gPiA+ID4gc3VwcGx5DQo+ID4gPiA+IHZvbHRhZ2UgdG8gdGhlIG1heGltdW0gZm9y
IGEgc2hvcnQgbW9tZW50IChwcm9iYWJseSBhIHNpZGUtDQo+ID4gPiA+IGVmZmVjdCBvZg0KPiA+
ID4gPiB0aGUgdm9sdGFnZSB0cmFja2luZyBhbGdvcml0aG0pLCB0aGlzIGZhaWxzIGJlY2F1c2Ug
dGhlIFBNSUMNCj4gPiA+ID4gb25seQ0KPiA+ID4gPiBzdXBwb3J0cyB1cCB0byAxMzUwMDAwdVYu
IEFzIHRoZSBoaWdoZXN0IG9wZXJhdGluZyBwb2ludCBpcw0KPiA+ID4gPiBhbnl3YXkNCj4gPiA+
ID4gdXNpbmcgb25seSAxMzEwMDAwdVYgdGhlIHNpbXBsZSBmaXggaXMgc2V0dGluZyAxMzUwMDAw
dVYgYXMgdGhlDQo+ID4gPiA+IG1heGltdW0NCj4gPiA+ID4gaW5zdGVhZCBmb3IgYm90aCBwcm9j
X21heF92b2x0IGFuZCBzcmFtX21heF92b2x0Lg0KPiA+ID4gPiANCj4gPiA+ID4gQSBzaW1pbGFy
IHNpdHVhdGlvbiBhcHBsaWVzIGFsc28gZm9yIEJQaSBSMiAoTVQ3NjIzTkkgd2l0aA0KPiA+ID4g
PiBNVDYzMjNMDQo+ID4gPiA+IFBNSUMpLCBoZXJlIHRoZSBtYXhpbXVtIHN1cHBvcnRlZCB2b2x0
YWdlIG9mIHRoZSBQTUlDIHdoaWNoDQo+ID4gPiA+IGFsc28gb25seQ0KPiA+ID4gPiBzdXBwb3J0
cyB1cCB0byAxMzUwMDAwdVYsIGFuZCB0aGUgU29DIGhhdmluZyBpdHMgaGlnaGVzdA0KPiA+ID4g
PiBvcGVyYXRpbmcNCj4gPiA+ID4gdm9sdGFnZSBkZWZpbmVkIGF0IDEzMDAwMDB1Vi4NCj4gPiA+
ID4gDQo+ID4gPiA+IElmIGFsbCBhZ3JlZSB3aXRoIHRoZSBzaW1wbGUgZml4IEkgd2lsbCBwb3N0
IGEgcGF0Y2ggZm9yIHRoYXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3dldmVyLCB0byBtZSBpdCBm
ZWVscyBmaXNoeSB0byBiZWdpbiB3aXRoIHRoYXQgdGhlIHRyYWNraW5nDQo+ID4gPiA+IGFsZ29y
aXRobQ0KPiA+ID4gPiB0cmllcyB0byByaXNlIHRoZSB2b2x0YWdlIGFib3ZlIHRoZSBoaWdoZXN0
IG9wZXJhdGluZyBwb2ludA0KPiA+ID4gPiBkZWZpbmVkIGluDQo+ID4gPiA+IGRldmljZSB0cmVl
LCBzZWUgaGVyZToNCj4gPiA+ID4gDQo+ID4gPiA+IDZhMTdiMzg3NmJjODMwIGRyaXZlcnMvY3B1
ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMgKEppYS1XZWkNCj4gPiA+ID4gQ2hhbmcgICAgICAgICAg
ICAgIDIwMjItMDUtMDUgMTk6NTI6MjAgKzA4MDAgMTAwKSAgICBuZXdfdnNyYW0NCj4gPiA+ID4g
PSBjbGFtcChuZXdfdnByb2MgKyBzb2NfZGF0YS0+bWluX3ZvbHRfc2hpZnQsDQo+ID4gPiA+IDZh
MTdiMzg3NmJjODMwIGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMgKEppYS1XZWkN
Cj4gPiA+ID4gQ2hhbmcgICAgICAgICAgICAgIDIwMjItMDUtMDUgMTk6NTI6MjAgKzA4MDANCj4g
PiA+ID4gMTAxKSAgICAgICAgICAgICAgICAgICAgICBzb2NfZGF0YS0+c3JhbV9taW5fdm9sdCwg
c29jX2RhdGEtDQo+ID4gPiA+ID5zcmFtX21heF92b2x0KTsNCj4gPiA+ID4gDQo+ID4gPiA+IEhv
d2V2ZXIsIEkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSBpbiBkZXB0aCB0aGUgcHVycG9zZSBvZiB0aGlz
DQo+ID4gPiA+IGluaXRpYWwgcmlzZSBhbmQgY2FuIGltcG9zc2libHkgdGVzdCBteSBtb2RpZmlj
YXRpb25zIHRvIHRoZQ0KPiA+ID4gPiB0cmFja2luZyBhbGdvcml0aG0gb24gYWxsIHN1cHBvcnRl
ZCBTb0NzLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciBhY3R1YWxseSByZXBv
cnRpbmcgdGhhdCwgSSBkb24ndCB0aGluayB0aGF0IHRoZXJlJ3MNCj4gPiA+IGFueQ0KPiA+ID4g
dmFsaWQgcmVhc29uIHdoeSB0aGUgYWxnb3JpdGhtIHNob3VsZCBzZXQgYSB2b2x0YWdlIGhpZ2hl
ciB0aGFuDQo+ID4gPiB0aGUNCj4gPiA+IG1heGltdW0gdm90YWdlIHNwZWNpZmllZCBpbiB0aGUg
ZmFzdGVzdCBPUFAuDQo+ID4gPiANCj4gPiA+IEFueXdheSAtIHRoZSBsb2dpYyBmb3IgdGhlIHBs
YXRmb3JtIGRhdGEgb2YgdGhpcyBkcml2ZXIgaXMgdG8NCj4gPiA+IGRlY2xhcmUNCj4gPiA+IHRo
ZSBtYXhpbXVtIHZvbHRhZ2UgdGhhdCBTb0MgbW9kZWwgWCBzdXBwb3J0cywgcmVnYXJkbGVzcyBv
ZiB0aGUNCj4gPiA+IGFjdHVhbA0KPiA+ID4gYm9hcmQtc3BlY2lmaWMgT1BQcywgc28gdGhhdCBw
YXJ0IGlzIHJpZ2h0OyB0byBzb2x2ZSB0aGlzIGlzc3VlLA0KPiA+ID4gSSBndWVzcw0KPiA+ID4g
dGhhdCB0aGUgb25seSB3YXkgaXMgZm9yIHRoaXMgZHJpdmVyIHRvIHBhcnNlIHRoZSBPUFBzIGR1
cmluZw0KPiA+ID4gLnByb2JlKCkNCj4gPiA+IGFuZCB0aGVuIGFsd2F5cyB1c2UgaW4gdGhlIGFs
Z29yaXRobQ0KPiA+ID4gDQo+ID4gPiAgICAgIHZwcm9jX21heCA9IG1heChwcm9jX21heF92b2x0
LCBvcHBfdnByb2NfbWF4KTsNCj4gPiA+ICAgICAgdnNyYW1fbWF4ID0gbWF4KHNyYW1fbWF4X3Zv
bHQsIHZzcmFtX3ZyZWdfbWF4KTsNCg0KSGkgRGFuaWVsLCBBbmdlbG8gU2lyLA0KDQpUaGFua3Mg
Zm9yIHRoZSBpc3N1ZSByZXBvcnQgYW5kIHN1Z2dlc3Rpb25zLg0KDQpJcyBpdCBwb3NzaWJsZSB0
byBtb2RpZnkgdGhlIHZhbHVlIG9mIHByb2NfbWF4X3ZvbHQgYW5kIHNyYW1fbWF4X3ZvbHQNCnRv
IDEzMTAwMDAgaW4gbXQ3NjIyX3BsYXRmb3JtX2RhdGEgYXMgdGhlIGhpZ2hlc3Qgdm9sdGFnZSBk
ZWNsYXJlZCBpbg0KbXQ3NjIyLmR0c2kgYW5kIHRoZW4gZ2l2ZSBpdCBhIHRyeT8NCg0KU29ycnks
IEkgbmVlZCBzb21lb25lIGhlbHAgdG8gY2hlY2sgdGhpcyBvbiBtdDc2MjIgc2luY2UgSSBkb24n
dCBoYXZlDQptdDc2MjIgcGxhdGZvcm0uLg0KDQpUaGFua3MuDQoNCj4gPiANCj4gPiBZb3UgcHJv
YmFibHkgbWVhbnQgdG8gd3JpdGUNCj4gPiB2cHJvY19tYXggPSBtaW4ocHJvY19tYXhfdm9sdCwg
b3BwX3Zwcm9jX21heCk7DQo+ID4gdnNyYW1fbWF4ID0gbWluKHNyYW1fbWF4X3ZvbHQsIHZzcmFt
X3ZyZWdfbWF4KTsNCj4gPiANCj4gPiByaWdodD8NCj4gPiANCj4gDQo+IEFwcGFyZW50bHksIHNv
bWUgb2YgbXkgYnJhaW5jZWxscyB3YXMgYXBwYXJlbnRseSB0YWtpbmcgYSBicmVhay4gOi0pDQo+
IA0KPiBZZXMsIEkgd2FzIG1lYW5pbmcgbWluKCksIG5vdCBtYXgoKSA6LSkNCj4gDQo+IENoZWVy
cyENCj4gDQo+ID4gPiANCj4gPiA+IEppYS1XZWksIGNhbiB5b3UgcGxlYXNlIGhhbmRsZSB0aGlz
Pw0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiANCj4gDQo+
IA0K
