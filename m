Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAE6E5EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjDRKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDRKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:24:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FC6A52;
        Tue, 18 Apr 2023 03:23:49 -0700 (PDT)
X-UUID: 19011fa8ddd311edb6b9f13eb10bd0fe-20230418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+ci5Q5deqfaJZE3Uz75LmQO4pccpILUJ2whm3Wt314A=;
        b=lQAZ7XtnNbNeE1IE9jaoogD4sjr1nqbWuUTPdJkIWWEiUHp7g5flOOI2R8CDIiba82/CbOvaJJ5VBA8kDRaVKZfj9TMeT5I5QSAnnCvdzEDmdwFYEXvLUUNiNKqkrlMztxBHFFok/Y+Mzc0SDEKZmUbH+2JBPSiVGn07glFNpyo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:69cb2a39-419a-4811-8d11-96a433a54e97,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c11f7584-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 19011fa8ddd311edb6b9f13eb10bd0fe-20230418
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1767390719; Tue, 18 Apr 2023 18:23:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Apr 2023 18:23:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 18 Apr 2023 18:23:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZEcCmMuCcBz9FEjfX9DvrC8+ZhJ0XpADmHMTo9LjNgKgyi6BiEss6tSwGE1jvEan7SqtEmcO/ODO0Ucyx3dY7uhnufzAmAdHuRiVp8zcM2argu4eP2RB/pEwN7jXUB5n76B/HI8Jpvzi8pBxmBpii/p143Zr1zIuPiDSd2+1bSDq8G4rAf1fhd6BWv1sB7drrvuNiP1335vQzgWVjbyKbsKSqqzXF3QptRkKNDdehDXRduAphk7smehCNufhw9vnN925SEQJ4T1b4nx0ONtEI+snTfLKkFITI+7jDmmt8kRBZMu9g1+aJ4l5kTkZrIsDIPmlbxi5KG2ZpYwpQV35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ci5Q5deqfaJZE3Uz75LmQO4pccpILUJ2whm3Wt314A=;
 b=CeTeGfFZeACnnANwl74C1V8PhALyzkwFAxkTmMw3/APpRcNE+deb6YCJlA/dhvG9SoZr7FT3tIOt1qizqFkKUHY9+9TtuuDAaX1jzIrd0xepuT0rG51As2jCYmFZOch6g6fcJ83WFaGRijUn3gyljI8aIuynk0c4mNa0H1R5T2l7ZJUuFlGi+Ryx/XBzeFI3z61H0A9MQVHfFjjFKFgM8TGmtGlhCVyCKeBqM10nc7azsP9ajo20OgO4U45n/H7MS4lM9hFAeI3xXfxRIhyYnxSlFXrwOQXfiqJTZjtLZ08Jk8V/4KaWXTgANkTU/5VVjoWjihGjzzh35Gi4o9yAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ci5Q5deqfaJZE3Uz75LmQO4pccpILUJ2whm3Wt314A=;
 b=c+i/E71LtTusnyiIWPziF1LZ0lbj5+Ba99PJfqna8yp1ZDN4kb+ZCtRUwK8Nt+/z1kN9lFm8Cyi44zgsKmuMBBbGd2ByofcNm+aUszagaa7aq671tuLsCWhUZCQ59QTd9mNij6tn3FGJ+JA1KtJlPg1R04QSfHr6QJbhKNKTSxA=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6802.apcprd03.prod.outlook.com (2603:1096:4:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 10:23:41 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 10:23:41 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
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
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Index: AQHZbfV6H4OsAA5wEEW0uLoJpPACoq8sFaCAgAK7jICAAFbNAIABu8qA
Date:   Tue, 18 Apr 2023 10:23:41 +0000
Message-ID: <3fe703c1279bf4d25a890b63c23a4bc97abd4198.camel@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
         <20230413104713.7174-8-trevor.wu@mediatek.com>
         <310e8979-de96-dda8-6c95-0e6033d8b403@linaro.org>
         <b9daeea6d823b8e84db0ca0df0e04d3716a6b944.camel@mediatek.com>
         <382bc15e-f4e3-3a9f-9dbc-4d46ac1d76d6@collabora.com>
In-Reply-To: <382bc15e-f4e3-3a9f-9dbc-4d46ac1d76d6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6802:EE_
x-ms-office365-filtering-correlation-id: 77aad9bd-8e36-4c90-5ee7-08db3ff6fb38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/Eg9iwVibxbebT1ecC2KIgU881KhxtDXxrnEEZlrDYOXVe+FcBMHwVYoqZKNHZ6/JpZ7irkyNrqKrlgjVvfQZZHf+Fp57FNOMBYmy6faDxLpQJ3FhCOC8zEjwfJ9m5M01hpZaz5FLkr/y96DpQ7Tdz0ws7D69Z1wJ0GofUTm/d3lIUos5xrlPYuV08KZVEnQiw0rmojL0RNP3QEkQIx2tuIvSfMKCM9DP4lRz1TlJLwheYpPjl5+O1TDI2V4935VWvv20H0vpgtrzK+N5mCD1+cHkQi7O/pSUjtx4bDf4d0sh3DYvk9rufGYE14VdQcL4DOp0UBUhTd+rJ5tJUfgNrYRpO7qm2Csz7giGByf/Y8H6WVuRslsgGysD4OAHBs/8OY0jBb4p5dPWGu1WqjJQgq2H7lAsfvYaOTL9pAyFImvSgzHHAjSjlMjJC1gTM/fd6Ov97Cp/EpxCDcNnwiRg+6cRZ4nQjhSO7Oa9f05gngL2F8+yQ/2lzx3dmNjylhC8DHD7uhN/seos05BF4VPOR12Dvbpmapo486Z8uCHimJwLkQMlOvLIE20/xZNUEGpNSV21rHiqwtRHtD++cVi7+2L5YaoxKGqA73o1ya6pxYfY0KYSF0ELviycDfIRj8HoBcgWfwwZJWM3rOrYv7qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(110136005)(54906003)(4326008)(316002)(91956017)(66946007)(66556008)(66476007)(64756008)(76116006)(66446008)(478600001)(6486002)(71200400001)(5660300002)(41300700001)(8676002)(7416002)(2906002)(122000001)(8936002)(86362001)(36756003)(85182001)(38070700005)(186003)(38100700002)(2616005)(26005)(6506007)(53546011)(6512007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck1GdFVWSUV2MjFwbXdtSStpcFNkK2FoVUVXT3pRdDVkZmJvbEU5S2lTekx4?=
 =?utf-8?B?aHFVRnAya3dCak9oOEdlajZiVUhwR1BrcDNSbnRTbWczRkFRU2EvWDVYaHp3?=
 =?utf-8?B?ZVlNcjdmdmhJaHlGWkxMVVduL1NyMFFoVFNrNytVOHBxZDYzRWRFMnVIMmN0?=
 =?utf-8?B?S2VvS2w3NVptUG1ac0gyOWY4Vk4vQld1blJudGVjZ3g5T3o0eXlnS1RnWDNI?=
 =?utf-8?B?b0JwUFNkV01PNXkvRm50d1ZCQ2VOOThRV0RDeHNuUHlJbmpDd0RFeGRCWENh?=
 =?utf-8?B?NktmMjViZ2huSDlTYy8vYXp4WnVGNXNLMno3dVB6K2JtTE0rK0RYbVFJTHcv?=
 =?utf-8?B?aW9XajZMZDZQdy8zelJWT1AvZ0xlSzZlNjBST0pId2xZTnVUdTVGcm95Yk1j?=
 =?utf-8?B?a1JCYjhONnJIQzN1OTNWQ3Z0UThoakdYS2VsUHNKQnhjUjlyaTJGUDhjREN4?=
 =?utf-8?B?VnJNRUpUcThIRTFpUUJMRFpzUHdxUld6RkN0K3FoR3AzQnRRdituZnU4OW9G?=
 =?utf-8?B?V3dXcVUyTFZ3dDZDditHUjZ2MUhma1NxM1BjaEUyWkN0d2FxTFMvSk90eUVI?=
 =?utf-8?B?aW1zWllMaVp3K1lRZCtQMnRVTXpLQmQ3Mk5MRWNrT2N1SGxnOWUyWEM2b2Vv?=
 =?utf-8?B?VEllUi91eC9NWm4ydnV6eUZuKzBvZDBkRHc2OUpwZHduTEp0bUd6TnpaY2lT?=
 =?utf-8?B?Wi9WSlVGM3Y0OGdNOFFWMktvblNSTzdmRGNnNDh0ZVFrcHpUYmt2T29XQlNC?=
 =?utf-8?B?Y0d4ZGJzUStPK2RUTGpsUHpGbUJOVHlHWWhEbUdCQSs3VExPZm1KYmpieWpx?=
 =?utf-8?B?RUJsb21Dc0ZTTnQxOEU2R1NTUzZvMkc1MENNWGNodmV3R3AxU0t0N2RqejB6?=
 =?utf-8?B?VWlLTXk4Q0FJeCsvVkpCVko5ZjNnU1FLazlRdHMzVzl4cndGdWd5emFmT2pQ?=
 =?utf-8?B?c3EyWW5GK1k1bzAxT0FHN0FoR3dqM1VJQTd2TnAvSEM5OXl1QkhqQkpjS1Vm?=
 =?utf-8?B?TjRvdmRFZHF1aUU3WTVNR0trK3BSYjF5RDNXWEpjYVBBYUtuZFBFbEIzd0tR?=
 =?utf-8?B?T3lScSt2VGp4aFZPZ25CbndBVWZMcy9SVCt3L3FENWQ3a2tHcEFSM1BPcmk2?=
 =?utf-8?B?cmxicjRuOFJGZWx4aGxkWVlKb0hWcENIZU53T3FYQjV5R3E3K0VyZkg4MSt0?=
 =?utf-8?B?NURkbFJnLy9rUmZlc01jSGdZZlpQQWtYMDRpNEpLeW1oby9GVThiWnozaFZE?=
 =?utf-8?B?Nnd4Zmw0RENyYlF2elJWdlQzQ0gzR2Y4ZU9YT2p3NW9LVGR4eStRR3o0czl5?=
 =?utf-8?B?T2l2L0ovbEh6TEdFQkw1VVY3RFhrV2c3ZXJqNEFTakJZbEt4d2tuUFhpNWpU?=
 =?utf-8?B?REk1Q3FDZm9kdXVCV3doU0RQRTJ2NVV3TnNXdnFKb3lIQkhwOVlTU1paVVE0?=
 =?utf-8?B?US9PempSNitWd2E0eThLUjM5aFNiSXdibW1YZkJLNnVHZ0tTVVNwSUhhenQx?=
 =?utf-8?B?S1VDSDlpeGV5TTJmMHNROER5Q0V0ZUZIa2lnZDVlWW5KTW16bFZWQm4zWG42?=
 =?utf-8?B?VWd5anU3Vjdob2lKY1VzZ2FEL3V0b212SXF0TWdiSzNHTnd6YXQxdkYveUdV?=
 =?utf-8?B?Qk5pZmNaMXNVRDJlc1RvZ0tGcTE3UDRiU1c5QW84clExeUhTVUU5djdDS3hC?=
 =?utf-8?B?cHViR09qcE04RXpRQ0JZZHpubnhCVXZIMUoxQ1J3cXdnUHpaQmhvOGxseVBS?=
 =?utf-8?B?cmx4cDlPSUY3eno0YkVNYVNCRjh3cU1adjR3ZENJTWNvZytNSzlwN0ZiZkFI?=
 =?utf-8?B?WlFXUzFyNFhsNk9BcGZsWis5U1FoeFJ0RUhnNDI4NDRKalpXc2dFSlV2bmpp?=
 =?utf-8?B?aG01bG9KSm5FdkVuWG5jYzVaQnI3dTVDQy92TUJJeXRlcElKOWczVE5ybEtV?=
 =?utf-8?B?REZOTGIzYnVEbHJ2YlJ0VGYzamJtdEllQ2FRVWF2Um9rYmNsUDJ6aXFpNnZQ?=
 =?utf-8?B?U1lrL0NSOFUzRjRqY2RIWWdlTC83Q2l5aUZLdXFvTjFGZlh6SnVyWHdXSS92?=
 =?utf-8?B?T1poODRYQk4yYUI4ZklQQ0xBeUhCcnNzcmtKTGN0QjN2dEFpUU8vSkJjQ2dj?=
 =?utf-8?B?a2ROSkVpT1dTbkJCR2tSbWVqUzZzSytvdSs4cWpSZGowTjJhc2kveHA3eXNB?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CECAB23D06719E45B8D4E7BD74851829@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aad9bd-8e36-4c90-5ee7-08db3ff6fb38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 10:23:41.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt3PFXXz57HOE4VHg6UiwpZPZkRPGPqkuYVINOtpq7Dae7kRq0IKlTJqkz9g5n5viA3EMxHCYnLFqoHCLHkLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6802
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTE3IGF0IDA5OjU1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTcvMDQvMjMgMDQ6NDQsIFRyZXZvciBXdSAo5ZCz5paH6ImvKSBo
YSBzY3JpdHRvOg0KPiA+IE9uIFNhdCwgMjAyMy0wNC0xNSBhdCAxMTowMCArMDIwMCwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gMTMvMDQvMjAyMyAxMjo0Nywg
VHJldm9yIFd1IHdyb3RlOg0KPiA+ID4gPiBBc3NpZ24gdG9wX2Exc3lzX2hwIGNsb2NrIHRvIDI2
TSwgYW5kIGFkZCBhcGxsMV9kNCB0byBjbG9ja3MNCj4gPiA+ID4gZm9yDQo+ID4gPiA+IHN3aXRj
aGluZw0KPiA+ID4gPiB0aGUgcGFyZW50IG9mIHRvcF9hMXN5c19ocCBkeW5hbWljYWxseQ0KPiA+
ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgIm1lZGlhdGVrLGluZnJhY2ZnIiBpcyBpbmNsdWRlZCBm
b3IgYnVzDQo+ID4gPiA+IHByb3RlY3Rpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgIC4uLi9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtYWZlLnlhbWwgICAgfCAx
OA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgt
DQo+ID4gPiA+IGFmZS55YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4gPiA+ID4gYWZlLnlhbWwNCj4gPiA+ID4g
aW5kZXggODJjY2IzMmYwOGYyLi4wMzMwMWQ1MDgyZjMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtDQo+
ID4gPiA+IGFmZS55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtDQo+ID4gPiA+IGFmZS55YW1sDQo+ID4gPiA+
IEBAIC0yOSw2ICsyOSwxMCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gPiA+ICAgICAgIGRlc2Ny
aXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUgbWVkaWF0ZWsgdG9wY2tnZW4NCj4gPiA+ID4gY29u
dHJvbGxlcg0KPiA+ID4gPiANCj4gPiA+ID4gKyAgbWVkaWF0ZWssaW5mcmFjZmc6DQo+ID4gPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+
ID4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUgbWVkaWF0ZWsgaW5mcmFj
ZmcNCj4gPiA+ID4gY29udHJvbGxlcg0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICBwb3dlci1kb21h
aW5zOg0KPiA+ID4gPiAgICAgICBtYXhJdGVtczogMQ0KPiA+ID4gPiANCj4gPiA+ID4gQEAgLTM3
LDYgKzQxLDcgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gICAgICAgICAtIGRlc2NyaXB0aW9uOiAy
Nk0gY2xvY2sNCj4gPiA+ID4gICAgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBwbGwxIGNsb2Nr
DQo+ID4gPiA+ICAgICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gcGxsMiBjbG9jaw0KPiA+ID4g
PiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gcGxsMSBkaXZpZGUgNA0KPiA+ID4gPiAgICAg
ICAgIC0gZGVzY3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc2kxX21jaw0KPiA+ID4gPiAg
ICAgICAgIC0gZGVzY3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc2kyX21jaw0KPiA+ID4g
PiAgICAgICAgIC0gZGVzY3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc28xX21jaw0KPiA+
ID4gPiBAQCAtNTgsNiArNjMsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICAgICAgIC0gY29u
c3Q6IGNsazI2bQ0KPiA+ID4gPiAgICAgICAgIC0gY29uc3Q6IGFwbGwxDQo+ID4gPiA+ICAgICAg
ICAgLSBjb25zdDogYXBsbDINCj4gPiA+ID4gKyAgICAgIC0gY29uc3Q6IGFwbGwxX2Q0DQo+ID4g
PiANCj4gPiA+IFdoeSBkbyB5b3UgYWRkIGNsb2NrcyBpbiB0aGUgbWlkZGxlPyBUaGUgb3JkZXIg
aXMgc3RyaWN0LCBzbyB5b3UNCj4gPiA+IGp1c3QNCj4gPiA+IGJyb2tlIGFsbCBEVFMuDQo+ID4g
PiANCj4gPiANCj4gPiBJbiBEVFMgZmlsZSwgSSBvbmx5IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQg
dGhlIG9yZGVyIGluIGNsb2Nrcw0KPiA+IHNob3VsZA0KPiA+IGJlIHRoZSBzYW1lIGFzIGNsb2Nr
LW5hbWVzLCBzbyBJIG1pc3VuZGVyc3Rvb2QgdGhhdCBJIGNhbiBhZGQgdGhlDQo+ID4gY2xvY2sN
Cj4gPiBpbiB0aGUgbWlkZGxlIGJhc2VkIG9uIHRoZSBjbG9jayB0eXBlLg0KPiA+IA0KPiA+IFNv
cnJ5LCBJIGRpZG4ndCBrbm93IHRoZSBvcmRlciBpcyBzdHJpY3QuIEkgd2lsbCBtb3ZlIHRoZSBu
ZXcgY2xvY2sNCj4gPiB0bw0KPiA+IHRoZSBsYXN0IG9uZSBpbiB2Mi4NCj4gPiANCj4gDQo+IEFj
dHVhbGx5LCBkb2luZyB0aGF0IGlzIGJvcmRlcmxpbmUtb2suLi4gdGhlcmUncyBubyBkZXZpY2V0
cmVlIGZvcg0KPiBNVDgxODgNCj4gdXBzdHJlYW0sIHNvIHRoYXQncyBub3QgYnJlYWtpbmcgYW55
dGhpbmcgYXQgYWxsLg0KPiBJbiBhbnkgY2FzZSwgSSBhZ3JlZSB0aGF0IHlvdSBzaG91bGQgZ2Vu
ZXJhbGx5IGF2b2lkIGRvaW5nIHRoYXQgYnV0IEkNCj4gdGhpbmsNCj4gdGhhdCBpbiB0aGlzIHNw
ZWNpZmljIGNhc2UgaXQncyBmaW5lOyBJJ20gbm90IGEgZGV2aWNldHJlZSBtYWludGFpbmVyDQo+
IHRob3VnaC4NCj4gDQo+IFAuUy46IFRyZXZvciwgbmV4dCB0aW1lIHBsZWFzZSBtYWtlIHJldmll
d2VycyBhd2FyZSBvZiB0aGUgZmFjdCB0aGF0DQo+IG5vIDgxODgNCj4gICAgICAgIGRldmljZXRy
ZWUgaXMgcHJlc2VudCB1cHN0cmVhbSENCj4gDQpHb3QgaXQuIFRoYW5rcy4NCg0KDQpIaSBrcnp5
c3p0b2YsDQoNCkJlY2F1c2UgdGhlcmUgaXMgbm8gdXBzdHJlYW0gbXQ4MTg4IERUUywgc2hvdWxk
IEkgbW92ZSB0aGUgbmV3IGNsb2NrIHRvDQp0aGUgZW5kIG9mIGNsb2NrIGxpc3Q/DQoNCklmIEkg
bW92ZSAiYXBsbDFfZDQiIHRvIHRoZSBlbmQgb2YgdGhlIGxpc3QgYXQgYmluZGluZyBmaWxlLCB3
aGVuIEkNCnVwc3RyZWFtIHRoZSBkZXZpY2V0cmVlIG5vZGUgZXhpc3RpbmcgY2xvY2tzIGFuZCBj
bG9jay1uYW1lcyBwcm9wZXJ0aWVzDQosIHNob3VsZCBJIGZvbGxvdyB0aGUgc2VxdWVuY2UgZGVm
aW5lZCBpbiBkdC1iaW5kaW5ncyBvciBjYW4gSSBoYXZlIGENCm5ldyBzZXF1ZW5jZSBiYXNlZCBv
biB0aGUgY2xvY2sgdHlwZSBvciBhbHBoYWJldD8NCg0KVGhhbmtzLA0KVHJldm9yDQo=
