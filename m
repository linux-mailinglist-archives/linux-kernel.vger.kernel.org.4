Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444E747EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGEIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjGEIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:04:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB765E5;
        Wed,  5 Jul 2023 01:04:18 -0700 (PDT)
X-UUID: 874c3d521b0a11eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=MSNKZn8xid8c3XlKjL/MZgjqGE+Hye16d5B4lukoRMk=;
        b=XYJg9GBGI31KyEJQ8EF8JROPqR//RUqactq8mqIqVngMCsqnEyKYHxFHf6dnRvK+mGxeKxeOwGshFSnbL57yLKRjhfy74FL9MCUy8wkNrfP0k9HdxP8W00m9EZleAaEZf5f8mtgbwIpVCZdqlgpf/aIDRzgNNGFCm6Nm3A2MO+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:500da1e7-168c-4993-902e-58a911cf1bc1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:500da1e7-168c-4993-902e-58a911cf1bc1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:8079b882-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:230705160414QKSJSPDD,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 874c3d521b0a11eeb20a276fd37b9834-20230705
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 277383742; Wed, 05 Jul 2023 16:04:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 16:04:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 16:04:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K99RUn5Efz1lVqMqcJ8CMEOHIo0lo7rbnW8UsdH96amf27cM5F4DwSFhqhc/zZ/keogBjQd+w40rnYqA5lzjaLzuoxLKonvoXJw0Dq3OsoJ8BXp/dm0xxiIHgp8U2BQXDA9poK7kMxan/ztZQHqNlTXO6QHhqdavdRUy3Omiaeo2ba3vp1EmSB4pgUf4DfseUjlj9YHQwQjWZBOmEI2sSnBGH7IX7kP4z1I6PQQ2l4UavyM7y783ycOfvSw1SczQ4+Uh8VyhAPCU4ACBmx8xSCxMo8uXnU9u0+oMN45MVIJQWpWskShBuvwLUFCnS7s7ufwFBejnAc2oJTyipCAw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSNKZn8xid8c3XlKjL/MZgjqGE+Hye16d5B4lukoRMk=;
 b=F2xDspf3JXbYZj2eGVF3uce2ytrcXpvbVmAmFXvDTOi5anDMi4hVB1uo3gPESZZmf9tkYSOX1ZxANvkQyx//9Q4MQX2KUt2eQvM03Gxp0ImzOFQrxmKDvhbI7p1Buwa2Iv6ps5nsUlxA6gkEFL0ZXYwk5QPbyYyFBeoU8rlRK/hy7VVweMyBuc0TTwREew+7BHxkGD+N47GouCTSLT2s+suGVE/ZPBf1rrecBBxj5w16/ByblDcP2fwvUllSNLm91RsmfEvHKixVq+uX0IAaEdlCe9ED5BwV+1EJczkV5pAABmOlR+xx2AVLt02CXyXxxtaoERPJHefIo7jJPmdlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSNKZn8xid8c3XlKjL/MZgjqGE+Hye16d5B4lukoRMk=;
 b=ZYdCnDArW58me/ZS716fGaWANH2anQyY0dKU7cy2DGGZmkaZGy5YIC1Iaz3OA+aTiv9QOGPGJInqKMsagWUmvSOBLwUz/uyrpk3S5d2VZ/09GhT6aZWMwHE3549MlaRglNml4zuwTyQc1OtyzzSLbdPQJSSSnM9PUd+dRG2c47Y=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SEZPR03MB7487.apcprd03.prod.outlook.com (2603:1096:101:12b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:03:03 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:03:02 +0000
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
Subject: Re: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Topic: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Index: AQHZp9cGuId6UkCLbk+7+3X7D0Dmnq+pX94AgAF+rwA=
Date:   Wed, 5 Jul 2023 08:03:02 +0000
Message-ID: <50d34157f4556abcd7db221566f7bb8873ab99c8.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-5-maso.huang@mediatek.com>
         <d5c0ea7a-e38b-b078-4664-dd451d4e3396@collabora.com>
In-Reply-To: <d5c0ea7a-e38b-b078-4664-dd451d4e3396@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SEZPR03MB7487:EE_
x-ms-office365-filtering-correlation-id: 7f0fb608-a20e-494a-8cb3-08db7d2e417a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCsxZYslMZ8HlOL8GMjfnVqpp9y5w/zIaoyQaP7bHKRWt6+Lu1QtCYIPCdH0XYsQf7vYWs9tnQqDFfPXXPJmhirilMzI07knmIsuXOg1Vb/M61iAiA9G74V0Q7czcL5BBJzRWj/AiaZKKSvOx/Nr1Ou6ZCtId2Sl2N/qUumAmOFRjr2pdgYRkvfsvgH3CCnCaxSwwONoWeCGpxZUz4bcE0uXru66zejELeraHURAIyT1LMe8L9wVJCHLSaTJ9BolSehdhEbr1AsldTsAw2bEYgyfD5DHehPaYn3Jm5qYBMAIDLBuKv612CJMRMZ2WOQFAjSx4kzV6zQhj6SdnBXn3NX2njRJiwb712heb2F3Z7aHRUHp9suKas+a9HCUQ9B7p1HXCjH6Uvfc8yVjkdFuI4WuwrCoxrhfhAL6v5sRobcidXEgup8z4oLnTcu5UuU9I2syVFcpP4c/qEV4yCMTJup4S+DwNDddWzbZJK+uPHihb1kTIcBL+y4QzYusBlzbqbrCsEJYb87dA+OlA/5I45AP1PlQr8dNZ9glK8FnNweQ7Lq5+tgHVVskjd/4ulJWeRIwmdT3W6Ubo0BjEBB+EaPCv10GHdd1jKwedqEVjcDaOlGiQNetEcBaWjKukyweIlR41L6ouFvTuq6DxbvcEYWt0bfWGT3HE/0ktr7dgY0LkXrJbRZNJZD36P9FeTBP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(5660300002)(7416002)(6486002)(2616005)(2906002)(26005)(186003)(921005)(6512007)(38100700002)(122000001)(6506007)(38070700005)(83380400001)(316002)(71200400001)(36756003)(86362001)(66476007)(66556008)(66446008)(91956017)(66946007)(76116006)(64756008)(85182001)(478600001)(110136005)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzFpbzhFNzltOHZNb3FXWGxDeVdSdmgybVh1c1JXSVJCRUF4OTR4SnA3ZmpZ?=
 =?utf-8?B?OWtKMHY3S2N5cmNMV25LWDhPUHFpaVAyby9sSlVzdHUxMlFwdldFZTZTSFBm?=
 =?utf-8?B?MithVlVXMVJ1NHJUVEVPZFNSdDc3N29XWC9uRExyRWthdXlLV3JmUWdCVXdz?=
 =?utf-8?B?c2pKbUFjZy9LSVBDNjk0czcyR2svdVNKOVlzYk1wa2dUd1R2ZWxtQk9xY1pQ?=
 =?utf-8?B?R3pJaElTRUlrQlovU24xQURobXRsbTl3dTA1em10UXB4WlpvNVpFUnYxU09S?=
 =?utf-8?B?ZGE1OGVjaHdVblNCRzZLSFpwSEtZbVVtRjBQcU9CYUdVTXVNdS8raHNvVVVy?=
 =?utf-8?B?cExMWXBjdnU0VGh6T1VDNkZaZEkvY3pBUVJON3NndjE5Z0VZVG8vY1hFeDlk?=
 =?utf-8?B?SnI5R3hXcEI5aDJsVXhWYTZ6eWQwVFpzQ2puRHBES2I5YUw2clJCQWhiQnk1?=
 =?utf-8?B?VVFEU1lpdlpmVlVscEpsaFRGTXVaNlFhWWcwWUM5Y1JaZmgvT1BQeHBOT0Vu?=
 =?utf-8?B?dXpzYUJMQitjdVdIVUNOVS8zZUFxbGpwdmxFQXkvTnAxK2JSK2V3Q3NTb04v?=
 =?utf-8?B?YW96dk1mTnQ3cWRVT2lMbm5ZTFlCeENpbldxaldnN09XTDcrb3hHOEhDdlJT?=
 =?utf-8?B?TnAvQkliUUVaQU85ZkxZWXVwQi95eDlhc1laQWhXbVZFRU1CaElMalFQaTlC?=
 =?utf-8?B?N2VEYW1WVW01Z0hJMXc2SW1OZVp2YjVQbmhSM3lmZGVMbTA0YjhOR0pFOWVo?=
 =?utf-8?B?SjZnenBCc21TVHZCUlpQT2RudmRwbkd6MU9pY2hZOU9ZRmU3Z0xSNWd2eXN6?=
 =?utf-8?B?SnQwSnVhREF2TWN1NXltM25iK0VVUTQ2MWZLYzZlU2oyWURzU21iYWx3SmtJ?=
 =?utf-8?B?NWZ2bm41VGV5cGp4eTdTY1ErZVJ0NE84K2sxeWZLeW5MOWovdC80NkVOYXZy?=
 =?utf-8?B?OGc5YWRqZzh0dktpWW5RRUMrMlRWQVJLcE9iTFA2YjhIWEVDS0tuME5UYXdO?=
 =?utf-8?B?YlUxMTNkaUgwdG9pWkpaUEVVT1I4aXA4K256SnFjL0FaS28ybFk3SnZLbllQ?=
 =?utf-8?B?UlMwRjdUNmNYMHNRT055QzFyeXNDOExmZ0pUZHA1cEtCZ2doSm53SWFnK2U3?=
 =?utf-8?B?QXp1dFZzK2hwZFdqV2xmSlhESW9vZ1gvQ3hWYm0zaVl0OTZiK0d6YXczNW1R?=
 =?utf-8?B?dlUwczA5SVNJRjYwNk9nbFd2Z3FiSDdPWW9jQzhlV1NxSUxmT2VnVy8zakFx?=
 =?utf-8?B?bWpNSXFaWURUdnJFQ3hnTE9vK2dHRjkyK1dWd1ZVZXBEN1Y4bVpoanhZYlVC?=
 =?utf-8?B?ZTVzV2VYS09iaTZHK3NCVitTSlJYRkxubmRVQnFPaWpwdTNZc2o2ZDJFV0s0?=
 =?utf-8?B?RjR3MFFZUkpnbTB1ak9jNlpPZDM5TXBOa2djaFNkR2c3OUkzTzdORkFpVUE0?=
 =?utf-8?B?YS9DZGx4aHlTTnQya3FRSVdSMVRzVzR3bTFVc2k3NHRVMUFaOHBtZUFZSUdz?=
 =?utf-8?B?d0MwdWF4bVJoVmlEb1F2UFM5Z2NZOU5OYUxHaU9mR0J5UVdVTlYwK1lVNUQ1?=
 =?utf-8?B?dmwxNEFZbkg1U3BlWFFXa2tlUkFXajRmZGtmYmJWSW1xY1JsSGdEaXlleFdw?=
 =?utf-8?B?SWZIMTlHdlArVHI3eXFFa3E4L1lSeDFjYk1ESUNoVnRCUWRFMzhaaU9nZ0pY?=
 =?utf-8?B?U2FVWXJmakV0MFA5NGtGbjlGOCt4OWR6YWVrRzZmcUZYRFBLZHRSWkF0VzNX?=
 =?utf-8?B?RlMxVUQ2c0tPWnpiK2lQUjQ2REZGQzk2dVpTMklZSHJTWGhLV0t5a01xcE5J?=
 =?utf-8?B?VTdTUTNPemg0TVgzSHZSc3J6eTVPNGwzNzJsVzh4SDJkTW1xZXRkK3h1MmpW?=
 =?utf-8?B?VC9YSkRqN28zZCtsWHgybVlKMC90QnExMjF6bDBTV0ZhcnNWTzhNT0kvQkt2?=
 =?utf-8?B?QWpSMCsvazZQZG9oV1BJSWhMTnMreXJLcE0wK1FqSHZSS0tiZFY1Nm4yLzdn?=
 =?utf-8?B?a1VtM2w4b21ORzFuSkZINWpTM0hDNmZienJmM2RseW85K1BkOUxCSVJJZlMw?=
 =?utf-8?B?Zk9mVkZUZWJmelhvZkpjNXBVMExSUHVSVWJJUjVwS2p6NEU2NU03UUFaWmk1?=
 =?utf-8?B?YkFyQS9zYlkzRVZndUZMZ1lISTFQdFZ0bkVqaExMditCL0FHaG14VVo2bk95?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78ED544A9E1B4A488C253368B4ED7FF8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0fb608-a20e-494a-8cb3-08db7d2e417a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:03:02.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjNjQqgyQOEU6H3YEQElgom6t3C5BH4FMWxhMIWXUq3TBx8CMj6kNXomDv85PSt0WrWZ7zAt6dsX1FbICOhPjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDExOjEzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAyNi8wNi8yMyAwNDozNCwgTWFzbyBIdWFu
ZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCBtdDc5ODYgcGxhdGZvcm0gZHJpdmVyLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgc291bmQvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgIHwg
IDEwICsNCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L01ha2VmaWxlICAgICAgICAg
fCAgIDkgKw0KPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLXBjbS5j
IHwgNTk4DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2
MTggaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRp
YXRlay9tdDc5ODYvTWFrZWZpbGUNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtcGNtLmMNCj4gPiANCj4gDQo+IC4uc25pcC4uDQo+
IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUt
cGNtLmMNCj4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtcGNtLmMNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWVlZjIxNzYy
ZTkzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5
ODYvbXQ3OTg2LWFmZS1wY20uYw0KPiA+IEBAIC0wLDAgKzEsNTk4IEBADQo+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIE1lZGlhVGVrIEFM
U0EgU29DIEFGRSBwbGF0Zm9ybSBkcml2ZXIgZm9yIE1UNzk4Ng0KPiA+ICsgKg0KPiA+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMjEgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKiBBdXRob3I6IFZpYyBXdSA8
dmljLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiArICogICAgICAgICBNYXNvIEh1YW5nIDxtYXNvLmh1
YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJtdDc5ODYt
YWZlLWNvbW1vbi5oIg0KPiA+ICsjaW5jbHVkZSAibXQ3OTg2LWFmZS1jbGsuaCINCj4gPiArI2lu
Y2x1ZGUgIm10Nzk4Ni1yZWcuaCINCj4gPiArI2luY2x1ZGUgIi4uL2NvbW1vbi9tdGstYWZlLXBs
YXRmb3JtLWRyaXZlci5oIg0KPiA+ICsjaW5jbHVkZSAiLi4vY29tbW9uL210ay1hZmUtZmUtZGFp
LmgiDQo+ID4gKw0KPiA+ICtlbnVtIHsNCj4gPiArTVRLX0FGRV9SQVRFXzhLID0gMCwNCj4gPiAr
TVRLX0FGRV9SQVRFXzExSyA9IDEsDQo+ID4gK01US19BRkVfUkFURV8xMksgPSAyLA0KPiA+ICtN
VEtfQUZFX1JBVEVfMTZLID0gNCwNCj4gPiArTVRLX0FGRV9SQVRFXzIySyA9IDUsDQo+ID4gK01U
S19BRkVfUkFURV8yNEsgPSA2LA0KPiA+ICtNVEtfQUZFX1JBVEVfMzJLID0gOCwNCj4gPiArTVRL
X0FGRV9SQVRFXzQ0SyA9IDksDQo+ID4gK01US19BRkVfUkFURV80OEsgPSAxMCwNCj4gPiArTVRL
X0FGRV9SQVRFXzg4SyA9IDEzLA0KPiA+ICtNVEtfQUZFX1JBVEVfOTZLID0gMTQsDQo+ID4gK01U
S19BRkVfUkFURV8xNzZLID0gMTcsDQo+ID4gK01US19BRkVfUkFURV8xOTJLID0gMTgsDQo+ID4g
K307DQo+ID4gKw0KPiA+ICt1bnNpZ25lZCBpbnQgbXQ3OTg2X2FmZV9yYXRlX3RyYW5zZm9ybShz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgcmF0ZSkNCj4gDQo+
IEZpdHMgaW4gb25lIGxpbmUuDQo+IA0KDQpPSy4NCg0KPiA+ICt7DQo+ID4gK3N3aXRjaCAocmF0
ZSkgew0KPiA+ICtjYXNlIDgwMDA6DQo+ID4gK3JldHVybiBNVEtfQUZFX1JBVEVfOEs7DQo+ID4g
K2Nhc2UgMTEwMjU6DQo+ID4gK3JldHVybiBNVEtfQUZFX1JBVEVfMTFLOw0KPiA+ICtjYXNlIDEy
MDAwOg0KPiA+ICtyZXR1cm4gTVRLX0FGRV9SQVRFXzEySzsNCj4gPiArY2FzZSAxNjAwMDoNCj4g
PiArcmV0dXJuIE1US19BRkVfUkFURV8xNks7DQo+ID4gK2Nhc2UgMjIwNTA6DQo+ID4gK3JldHVy
biBNVEtfQUZFX1JBVEVfMjJLOw0KPiA+ICtjYXNlIDI0MDAwOg0KPiA+ICtyZXR1cm4gTVRLX0FG
RV9SQVRFXzI0SzsNCj4gPiArY2FzZSAzMjAwMDoNCj4gPiArcmV0dXJuIE1US19BRkVfUkFURV8z
Mks7DQo+ID4gK2Nhc2UgNDQxMDA6DQo+ID4gK3JldHVybiBNVEtfQUZFX1JBVEVfNDRLOw0KPiA+
ICtjYXNlIDQ4MDAwOg0KPiA+ICtyZXR1cm4gTVRLX0FGRV9SQVRFXzQ4SzsNCj4gPiArY2FzZSA4
ODIwMDoNCj4gPiArcmV0dXJuIE1US19BRkVfUkFURV84OEs7DQo+ID4gK2Nhc2UgOTYwMDA6DQo+
ID4gK3JldHVybiBNVEtfQUZFX1JBVEVfOTZLOw0KPiA+ICtjYXNlIDE3NjQwMDoNCj4gPiArcmV0
dXJuIE1US19BRkVfUkFURV8xNzZLOw0KPiA+ICtjYXNlIDE5MjAwMDoNCj4gPiArcmV0dXJuIE1U
S19BRkVfUkFURV8xOTJLOw0KPiA+ICtkZWZhdWx0Og0KPiA+ICtkZXZfd2FybihkZXYsICIlcygp
LCByYXRlICV1IGludmFsaWQsIHVzZSAlZCEhIVxuIiwNCj4gDQo+IHMvdXNlL3VzaW5nL2cNCj4g
DQoNCk9LLg0KDQo+ID4gKyBfX2Z1bmNfXywgcmF0ZSwgTVRLX0FGRV9SQVRFXzQ4Syk7DQo+ID4g
K3JldHVybiBNVEtfQUZFX1JBVEVfNDhLOw0KPiA+ICt9DQo+ID4gK30NCj4gPiArDQo+IA0KPiAu
LnNuaXAuLg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBib29sIG10Nzk4Nl9pc192b2xhdGlsZV9y
ZWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZA0KPiBpbnQgcmVnKQ0KPiA+ICt7DQo+ID4g
Ky8qIHRoZXNlIGF1dG8tZ2VuIHJlZyBoYXMgcmVhZC1vbmx5IGJpdCwgc28gcHV0IGl0IGFzIHZv
bGF0aWxlICovDQo+ID4gKy8qIHZvbGF0aWxlIHJlZyBjYW5ub3QgYmUgY2FjaGVkLCBzbyBjYW5u
b3QgYmUgc2V0IHdoZW4gcG93ZXIgb2ZmDQo+ICovDQo+IA0KPiBGaXggdGhlIGNvbW1lbnQgZm9y
bWF0IHBsZWFzZTsgZm9yIG11bHRpLWxpbmUgY29tbWVudHMsIHlvdSB3YW50Og0KPiANCj4gLyoN
Cj4gICogVGhvc2UgYXV0by1nZW4gcmVncyBhcmUgcmVhZC1vbmx5LCBzbyBwdXQgaXQgYSB2b2xh
dGlsZSBiZWNhdXNlDQo+ICAqIHZvbGF0aWxlIHJlZ2lzdGVycyBjYW5ub3QgYmUgY2FjaGVkLCB3
aGljaCBtZWFucyB0aGF0IHRoZXkgY2Fubm90DQo+ICAqIGJlIHNldCB3aGVuIHBvd2VyIGlzIG9m
Zg0KPiAgKi8NCj4gDQoNCk9LLg0KDQo+IA0KPiA+ICtzd2l0Y2ggKHJlZykgew0KPiA+ICtjYXNl
IEFGRV9ETDBfQ1VSX01TQjoNCj4gPiArY2FzZSBBRkVfREwwX0NVUjoNCj4gPiArY2FzZSBBRkVf
REwwX1JDSF9NT046DQo+ID4gK2Nhc2UgQUZFX0RMMF9MQ0hfTU9OOg0KPiA+ICtjYXNlIEFGRV9W
VUwwX0NVUl9NU0I6DQo+ID4gK2Nhc2UgQUZFX1ZVTDBfQ1VSOg0KPiA+ICtjYXNlIEFGRV9JUlFf
TUNVX1NUQVRVUzoNCj4gPiArY2FzZSBBRkVfTUVNSUZfUkRfTU9OOg0KPiA+ICtjYXNlIEFGRV9N
RU1JRl9XUl9NT046DQo+ID4gK3JldHVybiB0cnVlOw0KPiA+ICtkZWZhdWx0Og0KPiA+ICtyZXR1
cm4gZmFsc2U7DQo+ID4gK307DQo+ID4gK30NCj4gPiArDQo+IA0KPiAuLnNuaXAuLg0KPiANCj4g
PiArDQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTg2X2FmZV9wY21fZGV2X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArc3RydWN0IG10a19iYXNlX2FmZSAqYWZl
Ow0KPiA+ICtzdHJ1Y3QgbXQ3OTg2X2FmZV9wcml2YXRlICphZmVfcHJpdjsNCj4gPiArc3RydWN0
IGRldmljZSAqZGV2Ow0KPiA+ICtpbnQgaSwgaXJxX2lkLCByZXQ7DQo+ID4gKw0KPiA+ICthZmUg
PSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCphZmUpLCBHRlBfS0VSTkVMKTsNCj4g
PiAraWYgKCFhZmUpDQo+ID4gK3JldHVybiAtRU5PTUVNOw0KPiA+ICtwbGF0Zm9ybV9zZXRfZHJ2
ZGF0YShwZGV2LCBhZmUpOw0KPiA+ICsNCj4gPiArYWZlLT5wbGF0Zm9ybV9wcml2ID0gZGV2bV9r
emFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqYWZlX3ByaXYpLA0KPiA+ICsgIEdGUF9LRVJORUwp
Ow0KPiA+ICtpZiAoIWFmZS0+cGxhdGZvcm1fcHJpdikNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICthZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsNCj4gPiArYWZlLT5kZXYg
PSAmcGRldi0+ZGV2Ow0KPiA+ICtkZXYgPSBhZmUtPmRldjsNCj4gPiArDQo+ID4gK2FmZS0+YmFz
ZV9hZGRyID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ICtp
ZiAoSVNfRVJSKGFmZS0+YmFzZV9hZGRyKSkNCj4gPiArcmV0dXJuIFBUUl9FUlIoYWZlLT5iYXNl
X2FkZHIpOw0KPiA+ICsNCj4gPiArLyogaW5pdGlhbCBhdWRpbyByZWxhdGVkIGNsb2NrICovDQo+
ID4gK3JldCA9IG10Nzk4Nl9pbml0X2Nsb2NrKGFmZSk7DQo+IA0KPiBBcyBzYWlkIGluIHRoZSBy
ZXZpZXcgZm9yIHBhdGNoIFsyLzddLCBmdW5jdGlvbiBtdDc5ODZfaW5pdF9jbG9jaygpDQo+IG11
c3QgYmUgbW92ZWQNCj4gaW4gdGhpcyBmaWxlIGluc3RlYWQuDQo+IA0KDQpPSy4NCg0KPiA+ICtp
ZiAocmV0KQ0KPiA+ICtyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkNhbm5vdCBpbml0
aWFsaXplIGNsb2Nrc1xuIik7DQo+ID4gKw0KPiA+ICtyZXQgPSBkZXZtX3BtX3J1bnRpbWVfZW5h
YmxlKGRldik7DQo+ID4gK2lmIChyZXQpDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsv
KiBlbmFibGUgY2xvY2sgZm9yIHJlZ2NhY2hlIGdldCBkZWZhdWx0IHZhbHVlIGZyb20gaHcgKi8N
Cj4gPiArYWZlX3ByaXYtPnBtX3J1bnRpbWVfYnlwYXNzX3JlZ19jdGwgPSB0cnVlOw0KPiA+ICtw
bV9ydW50aW1lX2dldF9zeW5jKCZwZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiArYWZlLT5yZWdtYXAg
PSBkZXZtX3JlZ21hcF9pbml0X21taW8oJnBkZXYtPmRldiwgYWZlLT5iYXNlX2FkZHIsDQo+ID4g
KyAgICAgICZtdDc5ODZfYWZlX3JlZ21hcF9jb25maWcpOw0KPiANCj4gcG1fcnVudGltZV9wdXRf
c3luYygmcGRldi0+ZGV2KTsNCj4gaWYgKElTX0VSUihhZmUtPnJlZ21hcCkpDQo+IHJldHVybiBQ
VFJfRVJSKGFmZS0+cmVnbWFwKTsNCj4gDQo+IGFmZV9wcm92LT5wbV9ydW50aW1lX2J5cGFzc19y
ZWdfY3RsID0gZmFsc2U7DQo+IA0KPiB0aGF0J3MgYmV0dGVyIDotKQ0KPiANCg0KT0suDQoNCj4g
PiAraWYgKElTX0VSUihhZmUtPnJlZ21hcCkpIHsNCj4gPiArcmV0ID0gUFRSX0VSUihhZmUtPnJl
Z21hcCk7DQo+ID4gK2dvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3Bt
X3J1bnRpbWVfcHV0X3N5bmMoJnBkZXYtPmRldik7DQo+ID4gK2FmZV9wcml2LT5wbV9ydW50aW1l
X2J5cGFzc19yZWdfY3RsID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsvKiBpbml0IG1lbWlmICovDQo+
ID4gK2FmZS0+bWVtaWZfc2l6ZSA9IE1UNzk4Nl9NRU1JRl9OVU07DQo+ID4gK2FmZS0+bWVtaWYg
PSBkZXZtX2tjYWxsb2MoZGV2LCBhZmUtPm1lbWlmX3NpemUsIHNpemVvZigqYWZlLQ0KPiA+bWVt
aWYpLA0KPiA+ICsgIEdGUF9LRVJORUwpOw0KPiA+ICtpZiAoIWFmZS0+bWVtaWYpDQo+ID4gK2dv
dG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gKw0KPiA+ICtmb3IgKGkgPSAwOyBpIDwgYWZlLT5tZW1p
Zl9zaXplOyBpKyspIHsNCj4gPiArYWZlLT5tZW1pZltpXS5kYXRhID0gJm1lbWlmX2RhdGFbaV07
DQo+ID4gK2FmZS0+bWVtaWZbaV0uaXJxX3VzYWdlID0gLTE7DQo+ID4gK30NCj4gPiArDQo+ID4g
K211dGV4X2luaXQoJmFmZS0+aXJxX2FsbG9jX2xvY2spOw0KPiA+ICsNCj4gPiArLyogaXJxIGlu
aXRpYWxpemUgKi8NCj4gPiArYWZlLT5pcnFzX3NpemUgPSBNVDc5ODZfSVJRX05VTTsNCj4gPiAr
YWZlLT5pcnFzID0gZGV2bV9rY2FsbG9jKGRldiwgYWZlLT5pcnFzX3NpemUsIHNpemVvZigqYWZl
LT5pcnFzKSwNCj4gPiArIEdGUF9LRVJORUwpOw0KPiA+ICtpZiAoIWFmZS0+aXJxcykNCj4gPiAr
Z290byBlcnJfcG1fZGlzYWJsZTsNCj4gPiArDQo+ID4gK2ZvciAoaSA9IDA7IGkgPCBhZmUtPmly
cXNfc2l6ZTsgaSsrKQ0KPiA+ICthZmUtPmlycXNbaV0uaXJxX2RhdGEgPSAmaXJxX2RhdGFbaV07
DQo+ID4gKw0KPiA+ICsvKiByZXF1ZXN0IGlycSAqLw0KPiA+ICtpcnFfaWQgPSBwbGF0Zm9ybV9n
ZXRfaXJxKHBkZXYsIDApOw0KPiA+ICtpZiAoaXJxX2lkIDwgMCkgew0KPiA+ICtkZXZfZXJyKGRl
diwgIiVwT0ZuIG5vIGlycSBmb3VuZFxuIiwgZGV2LT5vZl9ub2RlKTsNCj4gPiArcmV0ID0gaXJx
X2lkOw0KPiA+ICtnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiANCj4gWW91IGNhbiBqdXN0IHJldHVy
bi4uLiBhbmQgcGxlYXNlIHVzZSBkZXZfZXJyX3Byb2JlKCkuDQo+IA0KDQpPSy4NCg0KPiA+ICt9
DQo+ID4gK3JldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnFfaWQsIG10Nzk4Nl9hZmVfaXJx
X2hhbmRsZXIsDQo+ID4gKyAgICAgICBJUlFGX1RSSUdHRVJfTk9ORSwgImFzeXMtaXNyIiwgKHZv
aWQgKilhZmUpOw0KPiA+ICtpZiAocmV0KSB7DQo+ID4gK2Rldl9lcnIoZGV2LCAiY291bGQgbm90
IHJlcXVlc3RfaXJxIGZvciBhc3lzLWlzclxuIik7DQo+ID4gK2dvdG8gZXJyX3BtX2Rpc2FibGU7
DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qIGluaXQgc3ViX2RhaXMgKi8NCj4gPiArSU5JVF9MSVNU
X0hFQUQoJmFmZS0+c3ViX2RhaXMpOw0KPiA+ICsNCj4gPiArZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoZGFpX3JlZ2lzdGVyX2Nicyk7IGkrKykgew0KPiA+ICtyZXQgPSBkYWlfcmVnaXN0ZXJf
Y2JzW2ldKGFmZSk7DQo+ID4gK2lmIChyZXQpIHsNCj4gPiArZGV2X2VycihhZmUtPmRldiwgImRh
aSByZWdpc3RlciBpICVkIGZhaWwsIHJldCAlZFxuIiwNCj4gPiArIGksIHJldCk7DQo+ID4gK2dv
dG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gK30NCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogaW5pdCBk
YWlfZHJpdmVyIGFuZCBjb21wb25lbnRfZHJpdmVyICovDQo+ID4gK3JldCA9IG10a19hZmVfY29t
YmluZV9zdWJfZGFpKGFmZSk7DQo+ID4gK2lmIChyZXQpIHsNCj4gPiArZGV2X2VycihhZmUtPmRl
diwgIm10a19hZmVfY29tYmluZV9zdWJfZGFpIGZhaWwsIHJldCAlZFxuIiwNCj4gPiArIHJldCk7
DQo+ID4gK2dvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ID4gK30NCj4gPiArDQo+ID4gK2FmZS0+bXRr
X2FmZV9oYXJkd2FyZSA9ICZtdDc5ODZfYWZlX2hhcmR3YXJlOw0KPiA+ICthZmUtPm1lbWlmX2Zz
ID0gbXQ3OTg2X21lbWlmX2ZzOw0KPiA+ICthZmUtPmlycV9mcyA9IG10Nzk4Nl9pcnFfZnM7DQo+
ID4gKw0KPiA+ICthZmUtPnJ1bnRpbWVfcmVzdW1lID0gbXQ3OTg2X2FmZV9ydW50aW1lX3Jlc3Vt
ZTsNCj4gPiArYWZlLT5ydW50aW1lX3N1c3BlbmQgPSBtdDc5ODZfYWZlX3J1bnRpbWVfc3VzcGVu
ZDsNCj4gPiArDQo+ID4gKy8qIHJlZ2lzdGVyIGNvbXBvbmVudCAqLw0KPiA+ICtyZXQgPSBkZXZt
X3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCZwZGV2LT5kZXYsDQo+ID4gKyAgICAgICZtdDc5
ODZfYWZlX2NvbXBvbmVudCwNCj4gPiArICAgICAgTlVMTCwgMCk7DQo+ID4gK2lmIChyZXQpIHsN
Cj4gPiArZGV2X3dhcm4oZGV2LCAiZXJyX3BsYXRmb3JtXG4iKTsNCj4gDQo+IFRoYXQgc2hhbGwg
bm90IGJlIGEgZGV2X3dhcm4sIGJ1dCBhIGRldl9lcnIoKSBpbnN0ZWFkLCBidXQgdGhlbiwNCj4g
YmVpbmcgdGhpcw0KPiBhIHByb2JlIGZ1bmN0aW9uIGFuZCBub3QgbmVlZGluZyB0aGF0IGp1bXAs
IGl0J3MgZGV2X2Vycl9wcm9iZSgpLg0KPiANCg0KT0suDQoNCj4gPiArZ290byBlcnJfcG1fZGlz
YWJsZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2Nv
bXBvbmVudChhZmUtPmRldiwNCj4gPiArICAgICAgJm10Nzk4Nl9hZmVfcGNtX2RhaV9jb21wb25l
bnQsDQo+ID4gKyAgICAgIGFmZS0+ZGFpX2RyaXZlcnMsDQo+ID4gKyAgICAgIGFmZS0+bnVtX2Rh
aV9kcml2ZXJzKTsNCj4gPiAraWYgKHJldCkgew0KPiA+ICtkZXZfd2FybihkZXYsICJlcnJfZGFp
X2NvbXBvbmVudFxuIik7DQo+IA0KPiBTYW1lIGhlcmUuDQo+IA0KDQpPSy4NCg0KPiA+ICtnb3Rv
IGVycl9wbV9kaXNhYmxlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArZXJyX3BtX2Rpc2FibGU6DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0aGlzIGxhYmVsIGJl
Y2F1c2UgeW91J3JlIG5vdyB1c2luZw0KPiBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCkgYW5kLA0K
PiBmb2xsb3dpbmcgbXkgYWR2aWNlIGZyb20gc29tZSBsaW5lcyB1cCwgcG1fcnVudGltZV9wdXRf
c3luYygpIGlzDQo+IGNhbGxlZCBhdCB0aGUNCj4gcmlnaHQgdGltZSBhbHJlYWR5Lg0KPiANCj4g
VGhpcyBtZWFucyB0aGF0IHlvdSBjYW4gc2ltcGxpZnkgdGhpcyBmdW5jdGlvbiBhIGxvdCB3aXRo
IGRpcmVjdGx5DQo+IHJldHVybmluZyB0aGUNCj4gZXJyb3IgaW4gZXJyb3IgcGF0aHMgKGluY2x1
ZGluZyBpbnN0YW5jZXMgb2YgZGV2X2Vycl9wcm9iZSgpICkuDQo+IA0KDQpPSy4NCg0KPiA+ICtw
bV9ydW50aW1lX3B1dF9zeW5jKCZwZGV2LT5kZXYpOw0KPiA+ICtwbV9ydW50aW1lX2Rpc2FibGUo
JnBkZXYtPmRldik7DQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyB2b2lkIG10Nzk4Nl9hZmVfcGNtX2Rldl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gPiArew0KPiA+ICtwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+
ID4gK2lmICghcG1fcnVudGltZV9zdGF0dXNfc3VzcGVuZGVkKCZwZGV2LT5kZXYpKQ0KPiA+ICtt
dDc5ODZfYWZlX3J1bnRpbWVfc3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXQ3OTg2X2FmZV9wY21fZHRfbWF0
Y2hbXSA9IHsNCj4gPiAreyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc5ODYtYWZlIiwgfSwN
Cj4gDQo+IFlvdSBkb24ndCBuZWVkIHRoZSBjb21tYSBoZXJlICAgICAgICAgICAgICAgXl4NCj4g
c28gdGhpcyBpcyBqdXN0DQo+IA0KPiB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Nzk4Ni1h
ZmUiIH0sDQo+IA0KDQpPSy4NCg0KPiBFdmVyeXRoaW5nIGVsc2UgbG9va3MgZmluZS4NCj4gDQo+
IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KDQpIaSBBbmdlbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXZp
ZXcuDQpJJ2xsIHJlZmluZSBhbGwgb2YgdGhlbSBpbiB2MyBwYXRjaC4NCg0KQmVzdCByZWdhcmRz
LA0KTWFzbw0KDQo=
