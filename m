Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09F6F7DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjEEHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEEHcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:32:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1524E6A;
        Fri,  5 May 2023 00:31:54 -0700 (PDT)
X-UUID: e61f6508eb1611ed9cb5633481061a41-20230505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SuIdwFlemYbjE+TTunl8m/lg0ZTMMyBBiEKaucgtt4g=;
        b=mdWKZpwcdk0ctzYkHguWFsZuewojxTfAENkZkQ4MiIRj04izghUCfziTNl3HiRS5+bU8bGv3YT70WJLyumR4f+S+a7pbaZu/TIQBeTpv5zYM+eXFKvdOU1woAVgTxQLIEwLHrYt/AAr+yr4XRVEAkOHCpZIg10S3ZR0iWvD7RCs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:9adcb08d-8c12-4adf-ad1a-d17d4e58092f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.23,REQID:9adcb08d-8c12-4adf-ad1a-d17d4e58092f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:697ab71,CLOUDID:3bc6db6a-2f20-4998-991c-3b78627e4938,B
        ulkID:230505153152IDQR3L2F,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e61f6508eb1611ed9cb5633481061a41-20230505
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1345775738; Fri, 05 May 2023 15:31:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 May 2023 15:31:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 May 2023 15:31:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc43pR8beONuouKg0GD+i9Knvq+6I72J1RqWQk7aRu1gBXsiDuDOIvbh8MeRfZ99B/Oxtg/irVmtgsATDHa3DCB+rFTnN3MlWGVM7/wZqwD5VBvFyuWcs6P5iJLnGvQSK+yuOttNfJXqlB+AyV63/WUlJa8jh4jSgZvMCRpYmoJ2ncojULHm+fJ/Szr2ceqIcN+kA+tDjGCgjInyB5L4XTjQOKJv/ByqMb+bO2PDglrFpHsTEkSfOFC9j94l1iN2pZdyzdVQLbjz5GFdEF8XiTY1SQ5FWfzmByhRvAOvrExe1SPevENK35qUG2hy/qQztqCuqgv4KJifj6TXnAk14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuIdwFlemYbjE+TTunl8m/lg0ZTMMyBBiEKaucgtt4g=;
 b=MnKkovTv1V6nC4xZADQYZ1NfiEcLTxzpBKOqZWHIVUA9rCgzd//nmY2gFPeE25tWyCQQvrV0GUuyjZW3tasPnaGgaogGyzUf+Dfo9WDckCw+czvM8rN4pt3QxuYY29D780b7qO5AClC53MgzAkkSxTSXRHlpWK72FfHJRG9adJSoqLQELpeG9uM5HDSr2xtWoJAHV50OdWyVdrqTJbVOsQvzk7E520b4rQwAO+h5otdnGcca4DeMTEOAIc3KKOm6Xdh/rQFa/A0lUDhWg8r2+6fANIMr6BF7o6e1n7xY36PwnYQL2rzVZA8U+W5t26ETA2rvNXE4iT0YUd4uBwY0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuIdwFlemYbjE+TTunl8m/lg0ZTMMyBBiEKaucgtt4g=;
 b=Tno7ktHRiB6TCPYAZhILeZf4ME0Ph1DMZ2jmgVpWa7Hq/eApLnoVkNFgUIUTW0bfsxxW1VTzss2JOjdf/3RwM+h289HFlmRmel2YYTq9u4VoYtn2UjbhcuhP+oReYLkolsJRXd0/uhX9AQZOxqz8JtQw03LSI3gCtIb6kNhf7Xc=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB5498.apcprd03.prod.outlook.com (2603:1096:4:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 07:31:44 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 07:31:44 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Topic: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Index: AQHZeAM4EAl+BAdXWkGhv48UHs3qDa8/PqUAgAwYm4A=
Date:   Fri, 5 May 2023 07:31:44 +0000
Message-ID: <5433e5c1e046c756bd7e423edfad57813e8fdfb9.camel@mediatek.com>
References: <20230426055124.16529-1-trevor.wu@mediatek.com>
         <20230426055124.16529-8-trevor.wu@mediatek.com>
         <20230427144832.GA2992031-robh@kernel.org>
In-Reply-To: <20230427144832.GA2992031-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB5498:EE_
x-ms-office365-filtering-correlation-id: 9830d059-dc77-47ce-18d9-08db4d3ac6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8QXDqifl9RgtDxLNJk9vRcjYajnrLjzE/ej+r0xIyXKkoE2qan9wCd4eKz+UOs5Xc7qYnO+zanpIqBZ5z/66tfAIPYNcIDN266l3Tx7q3agIC+M0nnxF4cJHIgs2kcgEnlU0Pl07TjJQvCjuGPqFWfyKv42YC1pX/x9uABqSWamBsbUK1KCKAQIlCI3zdq3IgrRNzhXStrhhJE2o45+cPI8zaabIvGB5IytLi7KPNCfT1GxNN39TBTsdEuq1q48c4hgkiSm41Xt0o1TwPnLG2SLM2NAYeefMbHI8/jgteEiXgUqs4MGj/umkeSZgyM+miI56DbETAMOpnzJmQW3QSpEkWoZTyLLPkPeH1UmuZRa/6Y9Y2pKLfv1LPf8RC01LAsc8YCQQ4s21aDRjMIU1UaumFxi87JIIyv1tDZtLcT2Xe/+mJ9nRYvTve6iMzyXHjLwLWyPoN6zDbPtLtE6kKHKOtP66oXz+jL/PKxh1HKtFxcxOLs3MWs5fO3IlL5hYN11vrfVWQrMYkf4fyPUGmz3/wBY3HbhRfDd45lQVP+luNl9XXNdYLOt45A9+3XRXVd1xj6DSm1Tpx5eWcEJhUd+8nkqy+ctGuue5fMjpD5sVzKpmnYJFyNKyIvhnkS/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(966005)(76116006)(478600001)(6916009)(4326008)(66946007)(66556008)(66446008)(66476007)(64756008)(71200400001)(6486002)(91956017)(316002)(54906003)(86362001)(36756003)(85182001)(83380400001)(2616005)(6506007)(6512007)(26005)(8936002)(5660300002)(8676002)(41300700001)(7416002)(2906002)(38070700005)(186003)(122000001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBRZG1UdDlOd3Y2TzFEMlR4QjJxdXdOLzRndlpPekhrVTllR2xQZ09qU3Rm?=
 =?utf-8?B?NmxrQXpja1RqUW11VkprUytRUHY1Z0lmYzJIcTdGUnZ2RGxQN2E4VmpjZ0Q4?=
 =?utf-8?B?ajl4dHJZckZXWGhwOTVpSHNGcXNrZ0M3S3paZ2JxK2s2K2JzOWNOS3p6bFlJ?=
 =?utf-8?B?MW1JcGFNTTNyd2Nubjl6SGZRdWxuUGUrRDRsUEUrcFJmdGt0WWhwTEFzVUZo?=
 =?utf-8?B?S3NUWlNrSFI0TUpuL0pGVWNUcTlxOEM1YjludUlUVDdjTEZoTkV2djR4bkdO?=
 =?utf-8?B?WnQyMVowbGZxaUx2MmN5RnNxUkE0VlB0c3BsRkQzVzE4VHAvc1R6aGZyaDZ6?=
 =?utf-8?B?TFp6QTdvcDZNT2k1SnFsYkUvblMra0JsaktCK2NGbnlPdk9kSm5ZUmRJVzdR?=
 =?utf-8?B?aVh3OWF3eWJGTmZXS2FiTkVUckJuUjUrMWRCMGJxMDNxSUREOHk0eEpWYmt5?=
 =?utf-8?B?TjZwMEpuYmtXZk9oRVJESWQranpzclhVYmlvako4a2pwQkp3bjQxQUREU2U2?=
 =?utf-8?B?dC9uRnJtbkxsbmRvb29jVUpnTlVMcitKbXQ4Ri8xSDFLR0d5TkZDNmNYZk5V?=
 =?utf-8?B?M2dnSC9SMkNpZkJhS3dYd3o2WStPcjRpL3NCeFhaaVcrYk9PUCtNdzB0UjMz?=
 =?utf-8?B?T3Z3MlUyakN5MHJVZHZXUHFJRk1oczR6aWdXOXRrank2NVRvdGN5azhRamRi?=
 =?utf-8?B?V0lqcm9PaUFPOVQwS3RLSTYvbU9qZGVkbVFmM0RlaDRYV0FZNWN2dUJOZmZj?=
 =?utf-8?B?Qmp0SUlqQWljSFIrVVVuSVBEeFZ6dzVLSFNYc1psSVZMSmZPS2RyVnFqS1ZI?=
 =?utf-8?B?aFZ5NEE2MHhvMTdvV1VzTW5wWHV2SWZkYkpGTloxZisvcTE4M0llcjVvdlZQ?=
 =?utf-8?B?eUh5T0NUY0lKajBNYWdDTHUyd1hJdzU5b0dPVDJ0azZSU2JNa1MwWnFYdHJk?=
 =?utf-8?B?U3pWbUp2OW1IZjZWQSs3eElxUnRvVXdzYnpScVp0UUs2ZHNrY09iODhFNnB1?=
 =?utf-8?B?ZEFucFFMRFJsSE1pL3hCRXJFeVFFTGh4S0w0SXJvaFN4RitZcGV0UkdOUHZl?=
 =?utf-8?B?T0tHY3I5TUJ6dFR6Q3FPajExRU5LNUlSZkxPcmxNc1pGQUIvUFNETlR4QmRR?=
 =?utf-8?B?dEFQTWxnR3pFeTV5d3U0YmM2QWcwTGJyNEZsaE93aExGNEdPVWVMZHBPUDdw?=
 =?utf-8?B?ZUtsUEMwZkloWEVYSmxOdThMUXF2K2paaXkwSEFadndnUS9Gbi9RKzVXVUh0?=
 =?utf-8?B?cUl4TnltTG1PMHpNN28yUXd0Z2VpZy84MFl5TnNPaVVkN28wT0FXUStUakdI?=
 =?utf-8?B?MzM4dTlBZGoyWnM5eS8zdmZpcHpTdGUrT0ErWENnREZTbURMNnpuK1VBLzZZ?=
 =?utf-8?B?R0RYYmR4RXlHa3Axc0liMjQzOXpUTTRPT1JiY3ZvbjN4SVBsK3RZcmNpODA4?=
 =?utf-8?B?MjJKakc2NzFHNW53UUYxcUV3aFZjOGtsMWJVMDlpVDN1SUFMUElvM3UxeldG?=
 =?utf-8?B?NUtUYzhRbCtiQis5NFpVU0pXbzNqTW4yUUxUV0JaYkZHblEweW5OQ0JmNkNr?=
 =?utf-8?B?ajgyVkNscGF0alltc3JHQUs2emJPMXViZTJwdlBhSHQvdXZ6VlJYcjlaNm0z?=
 =?utf-8?B?Q0ZVdFY5ekd3eEZBKzhaSUd2OGtxZWtxUmVBYTV5eHY5VFYvZjNtcy9Sak0y?=
 =?utf-8?B?aDhLc0F0K2QwSjlTQndSK09xZEhxTENUVS9uRE5ZbUtvUzFYbFJpdFZmRTBm?=
 =?utf-8?B?SkttbDAvNWl5WEpvL1NvbG1UVkdUTVRMR2NHUjJrZmVoWkZxZXZuQ0RQbnZJ?=
 =?utf-8?B?aWNQd1R2anNzNmphQURLTUhUa0hmenNaci83VzBYdkNqNnFJL2xMV3REcUV6?=
 =?utf-8?B?VGF6cW5oN2I5cXlSQ1VZdzc1cUsxa3lGS21ZZDk5K2JmdFlSMmIzY2RtTE94?=
 =?utf-8?B?dTB6bjV2V3dEVWtwZEhuQlBVRHNkMGJINlVibG54b0NFK3Fham9mQkRrQkJQ?=
 =?utf-8?B?My8wQmozZ2hYNTZZcGIvRnVlaXJKMkFDd08wVTNCM0xXZ0hyc0Y1eTdlMnZt?=
 =?utf-8?B?eDlKY2RSWXVGb3ZIaEtnVFNQNmlPR0d1Q1I5VG1OeVhBbWtja2JCNVVSenpN?=
 =?utf-8?B?bnF4SE13RjVCYTRQRDdLSjN5VUxzNzAvR25xaGx4VGJRaUlFSHJlNTVTNWJM?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4CA3DA1C979F8499981ED1B7F014A9C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9830d059-dc77-47ce-18d9-08db4d3ac6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 07:31:44.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PYfXbLi+egkA6oFyz69W3NQ5aE7q7Zog9N+KTSpXhAhPdwPJmxV6Evi48uVVZlDAbGaUGTz7X4uFlNOS/DweA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5498
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTI3IGF0IDA5OjQ4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBXZWQsIEFwciAyNiwgMjAyMyBhdCAwMTo1MToyNFBNICswODAwLCBU
cmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIGFwbGwxX2Q0IHRvIGNsb2NrcyBmb3Igc3dpdGNoaW5n
IHRoZSBwYXJlbnQgb2YgdG9wX2Exc3lzX2hwDQo+ID4gZHluYW1pY2FsbHkuIE9uIHRoZSBvdGhl
ciBoYW5kLCAibWVkaWF0ZWssaW5mcmFjZmciIGlzIGluY2x1ZGVkIGZvcg0KPiA+IGJ1cw0KPiA+
IHByb3RlY3Rpb24uDQo+IA0KPiBCdXMgcHJvdGVjdGlvbj8gTWVhbmluZyBhY2Nlc3MgY29udHJv
bHMgZm9yIHRoZSBkZXZpY2U/IElmIHNvLA0KPiB0aGVyZSdzIGENCj4gcHJvcG9zZWQgYmluZGlu
Z1sxXSBmb3IganVzdCB0aGF0LiBJZiB0aGF0J3Mgc29tZXRoaW5nIE1lZGlhdGVrIG5lZWRzDQo+
IHRvbywgcGxlYXNlIHBhcnRpY2lwYXRlIGluIHRoYXQgZGlzY3Vzc2lvbi4gSXQncyBlYXNpZXIg
dG8gZGVmaW5lIG5ldw0KPiBjb21tb24gYmluZGluZ3MgaWYgdGhlcmUgaXMgbW9yZSB0aGFuIG9u
ZSB1c2VyLg0KPiANCg0KSGkgUm9iLA0KDQpCdXMgcHJvdGVjdGlvbiBpcyBhIGZ1bmN0aW9uIHVz
ZWQgdG8gcHJldmVudCBmcm9tIHRoZSB1bmV4cGVjdGVkIGdsaXRjaA0KZHVyaW5nIHRoZSByZXNl
dC4gVGhlIHN1Z2dlc3RlZCByZXNldCBjb250cm9sIGZsb3cgaXMgbGlzdGVkIGFzIGJlbG93Lg0K
DQpidXMgcHJvdGVjdGlvbiBvbg0KbW9kdWxlIHJlc2V0DQpidXMgcHJvdGVjdGlvbiBvZmYNCg0K
SSB0aGluayBpdCBpcyBub3QgdGhlIHNhbWUgYXMgYWNjZXNzIGNvbnRyb2wgb2YgdGhlIGRldmlj
ZS4gSW4NCmFkZGl0aW9uLCBubyBmcmFtZXdvcmsgb3IgY29udHJvbGxlciB3YXMgaW1wbGVtZW50
ZWQgZm9yIE1USyBidXMNCnByb3RlY3Rpb24uIEhlcmUsIEkganVzdCBtYWtlIHVzZSBvZiB0aGUg
cHJvcGVydHkgdG8gZ2V0IHRoZSBwaGFuZGxlIG9mDQppbmZyYWNmZyB0byBhY2Nlc3MgdGhlIHJl
Z2lzdGVyIGZvciBidXMgcHJvdGVjdGlvbi4NCg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRy
ZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRp
bmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFtbCAgICAgICAgICB8IDEyDQo+ID4gKysr
KysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtYWZlLnlhbWwNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtYWZlLnlh
bWwNCj4gPiBpbmRleCA4MmNjYjMyZjA4ZjIuLmViNThkZThjMGU2OCAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTg4
LQ0KPiA+IGFmZS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4gPiBhZmUueWFtbA0KPiA+IEBAIC0yOSw2ICsy
OSwxMCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICAgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9m
IHRoZSBtZWRpYXRlayB0b3Bja2dlbiBjb250cm9sbGVyDQo+ID4gDQo+ID4gKyAgbWVkaWF0ZWss
aW5mcmFjZmc6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgdGhlIG1lZGlh
dGVrIGluZnJhY2ZnIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gICAgcG93ZXItZG9tYWluczoNCj4g
PiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gDQo+ID4gQEAgLTUyLDYgKzU2LDcgQEAgcHJvcGVydGll
czoNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjogbXV4IGZvciBpMnNpMV9tY2sNCj4gPiAgICAg
ICAgLSBkZXNjcmlwdGlvbjogbXV4IGZvciBpMnNpMl9tY2sNCj4gPiAgICAgICAgLSBkZXNjcmlw
dGlvbjogYXVkaW8gMjZtIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIHBs
bDEgZGl2aWRlIDQNCj4gPiANCj4gPiAgICBjbG9jay1uYW1lczoNCj4gPiAgICAgIGl0ZW1zOg0K
PiA+IEBAIC03Myw2ICs3OCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IGky
c2kxX21fc2VsDQo+ID4gICAgICAgIC0gY29uc3Q6IGkyc2kyX21fc2VsDQo+ID4gICAgICAgIC0g
Y29uc3Q6IGFkc3BfYXVkaW9fMjZtDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFwbGwxX2Q0DQo+IA0K
PiBBIG5ldyByZXF1aXJlZCBlbnRyeSBtYXkgYnJlYWsgdGhlIEFCSS4gSWYgdGhhdCdzIG9rYXks
IGl0IG5lZWRzIHRvDQo+IGJlDQo+IGV4cGxhaW5lZCBpbiB0aGUgY29tbWl0IG1zZy4NCj4gDQoN
Ckl0IHNob3VsZCBiZSBPSywgYmVjYXVzZSB0aGUgcHJvamVjdCBpcyBzdGlsbCBkZXZlbG9waW5n
IGFuZCB0aGVyZSBpcw0Kbm8gZGV2aWNlIHRyZWUgZmlsZSBmb3IgbXQ4MTg4IHVwc3RyZWFtLiBJ
IHdpbGwgYWRkIHRoZSByZWFzb24gdG8gdGhlDQptZXNzYWdlIGluIHY0Lg0KDQpTb3JyeSwgSSBk
aWRuJ3Qgbm90aWNlIHRoYXQgYmVmb3JlLiBJIHdpbGwgcmV2aWV3IG15IGZ1dHVyZSB3b3JrIGFu
ZA0KY2hlY2sgaWYgYW55IHJlcXVpcmVkIHByb3BlcnR5IG9yIGl0ZW0gc2hvdWxkIGJlIGluY2x1
ZGVkIHRvIHRoZQ0KYmluZGluZyBiZWZvcmUgbXQ4MTg4IGF1ZGlvIGRldmljZSB0cmVlIHVwc3Ry
ZWFtLg0KDQpUaGFua3MsDQpUcmV2b3INCg0KPiBSb2INCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNjY4MDcwMjE2LmdpdC5vbGVrc2lpX21vaXNpZWll
dkBlcGFtLmNvbS8NCg==
