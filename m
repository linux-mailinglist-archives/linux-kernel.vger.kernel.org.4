Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743A6D55A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjDDAt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDDAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:49:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6485510CB;
        Mon,  3 Apr 2023 17:49:17 -0700 (PDT)
X-UUID: 83b14faad28211eda9a90f0bb45854f4-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2qaN32FyA1TlsZN3xZyHo3vvBf0nvtPUo7qWegP9XLM=;
        b=J2aikQd/nmsm80I/CYVJ2jUxbsLfrpR8l41+KnMqoe6vuvC//SfB5Oq11zqQBJQtNoWmjQHtxJ2IbG7lpchNC0km9cCOWWfoFopehjsqlba7Ko8iyk1WG6GAJ3hpxO5R4tQa0fGKMFtwGgJ/H6R8ULD1SuHsBJsfDMCUnHPghnY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:3ea96c06-772b-4199-bf8a-a741defa2cb6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:98d64d2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 83b14faad28211eda9a90f0bb45854f4-20230404
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1655155048; Tue, 04 Apr 2023 08:49:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 08:49:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 08:49:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3hozp6m+Nt1SsE0sEhuckY0LAZwnor7IyACTkU/2KWk9prsjKswTKBsknUOGpK8/lD5NVpg62F7bj0qsegkAcWxto7yOO4ug/uJqJfeD3W3sa2Kpo1aqI9NqeOcWuqxJDlwyrS4NGFwxHj1G/iIui1/ctOQ5Kn0cSqRhl+MpsCjk3Zz97Ghm9Y0LibYmCCaHFbFtR+OREGZcvxX98LWIg9wz+lB483ww/XstWySe/nH4h0iOVJecpwoLI3KTb/Q+JrSQn14kzh8HcdQkV7CftCp5+cy58Fa7qr/k7uhtdIKqo28dpTT3b0cRybQQJhb5fXRsrn/S0lMeEqrTGb+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qaN32FyA1TlsZN3xZyHo3vvBf0nvtPUo7qWegP9XLM=;
 b=i8xq9GM618lpdDzNOEEK1O3h7Xb4QjajsTwT9bkecLM33hNFTvrcKaxIl8N65XyBnsycX7tHUSCSCHXyAuAe2uLwfWM1qoR+/Gg1Q9u1hEod+ydRpWs2etZVIcE9XS3TGIMf7GZ+Mf/mgPGxexzL5eU9pRNpPkJoBEK0cgw3BpRiXAWkx1MwEPBWcBhNjwmw6rVvgjgND8z81SEC+Baqlf8ajIi4C8BuohiEPtrOP7LtpxDYsvBB7eHEJ5etJvUabWBAQWaZ/A0knnb1KlFLcu/vi7wE0N+BTat5Zg9blO59THb3YuLkNRUBFwWeoK96ElHMJsFztz0tOR+BSlMhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qaN32FyA1TlsZN3xZyHo3vvBf0nvtPUo7qWegP9XLM=;
 b=dllFxJF+7DPX7thUPRPzqpixyehgjIve0QvTf6JDY7eOBO3Fg+uCMXNZA4g9IY89j66RPKfoUYSB2iTfw6nekThB+3djCunZXlZJ3f3z7PAKw2U9hHIEk/JxccvugtStvc8EDKWVOzwizkYPdUZw5l7hQegE3mxMBvsL39S3X+k=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6670.apcprd03.prod.outlook.com (2603:1096:400:1f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Tue, 4 Apr
 2023 00:49:08 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%4]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 00:49:07 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 01/14] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Topic: [PATCH v6 01/14] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Thread-Index: AQHZZgzEbtEcb50lHEmTPo6MYnjG068ZnJuAgAC1zwA=
Date:   Tue, 4 Apr 2023 00:49:07 +0000
Message-ID: <262958994466c2f602193b5f25b5d33d7ebda0a2.camel@mediatek.com>
References: <20230403091337.26745-1-yong.wu@mediatek.com>
         <20230403091337.26745-2-yong.wu@mediatek.com>
         <3a73c940-d97b-4d5c-a546-b5ee257a12f9@notapiano>
In-Reply-To: <3a73c940-d97b-4d5c-a546-b5ee257a12f9@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6670:EE_
x-ms-office365-filtering-correlation-id: 931d3d53-4cc4-4cf6-49b7-08db34a6656e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYjWT3fsIhXafostZVvfvaucSjM49ZUhFtO9Yk/X8+sh8oNmx/JbKYh5NI6uj0B90EnKgSeZPz9bHiyaKp8md6QuxHiW1qybVUDLg2mDHumhvsQlbeeDQTSye1m5Co/mNMffK4/k5tsmpgWGHt9wT9xLsPrYSl1P+40JbXStgQhaP6qNTbm9PExyBSQcE0eIHBVKRZRT8E7B7x6oUrIhGcY3Fe0TjFojYwCTnBzRXY1kHiHLVAxAeVsgpgb9QB/1jpRSiKJ4Box++9T0Z+S7j0IKXCynlQycc37gmXrFxJpZUmUhtcYURJKRDVb70FaEzt4kj+6L83fs2y6gYy/+d8N3VK0TufyD5KTEfagrIz+kjXXjmAmicR0a2maCpUqurV0u/rIzIQFfToNckWpWPlEsz2LZTEtIyl9aROlHX6y8sE1NxEc6IYe4saDvC29vQgdb0ZKgTIIL2KQoXNn1tX9yLa/HW35607LFU+izDetXVsmjlg42jZ3Bpu4sRfy3Wk9zQYMTJYj95wtxEqpzTs77CL3SCNXqF7O1YYq+6qdEUApfY+01PY2HO2SKthfrrMLDWgCzBb3WDjBZ8n6tJ3hn7uXEHFDkbHTFLRHgJYUoNbsIQ/4cjNudGwSDJVkRGrJqMWzFpqCk9Rdhp5G/8LLFE1jR+AlHBMEGBhAXuL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(38100700002)(64756008)(41300700001)(71200400001)(38070700005)(66556008)(66946007)(6916009)(4326008)(8676002)(66446008)(66476007)(5660300002)(6486002)(54906003)(316002)(86362001)(478600001)(91956017)(186003)(83380400001)(6506007)(2616005)(85182001)(76116006)(7416002)(122000001)(966005)(36756003)(66574015)(26005)(6512007)(2906002)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clRLN1cwYU1nd3ZiNGF4R2k3Q2g3K0FpempDWkFEYkFJM3JkZU12RFZJcllw?=
 =?utf-8?B?Y0tCM0Z1Z2VHb0w4Y0t6ZTc2bUl1SHZuT2Zkb2pKV01XTXp4UDRNTDl5S1g4?=
 =?utf-8?B?YkxXa1hKV1lMcm5tRTgxVW5yQlVmOStILzlwZWk5MXNKRHBQbjNFR3lBdE9O?=
 =?utf-8?B?d3l5cllUNm5hMDNRM25jbjhqYXBtK1pjK1BCVmFxSzY0T0dhK3VCeXoreVBW?=
 =?utf-8?B?MlQ1VytVZWMzOHlaMkpJd0lTVERtQmdNM2F1SWFOT1QrMUhIRXJMakxUc1Q1?=
 =?utf-8?B?bEh3VlhZaXFYSmIwTDlYeTVKd2tZV1lnSDRFZlN4ZDJrZ2U1VVQzRDNJM3BY?=
 =?utf-8?B?ZUV2SGcxQ2tuUk4zTFBoYTZlUUZTS3E1Z0FBb0laM3hXampCMzllejZ1VFdr?=
 =?utf-8?B?T0JpcEh0RG1mejVJdmE0cm9wRWF1cVdsZHB3SXJYQklzbWxwWEdjUmNYZ1o5?=
 =?utf-8?B?cVdZVDlMNTNSTGlETGxORERoYkdWcWxQN0lYd1Nqa09HNFJaMTE2TWtXeElk?=
 =?utf-8?B?VjNDVkVPUWVseEZ4QUFFRVA3Mm5kbEtXTkFTeWNqRmpRQkNIS3pkdXErc2dj?=
 =?utf-8?B?TnB5R2dTdzloeTRrS0RwZHJXczZvUnE3aWlrd3l6MkV1aVNhQWNzYjAwNThx?=
 =?utf-8?B?NmpZemdqd3VySGRkUVpWMVpMODFEc2hJUXFNeUtXcDhxblkzTjRUYit5V1hS?=
 =?utf-8?B?NjdXU3IrN1FFSDczb3Y4b2tHOTcrcGxEeDBMaHpTYkxQaE5FWVRiamZoVk43?=
 =?utf-8?B?NXlaWENScE5SUEI2WGw3ZTYxZERCM04yUFlpN0piTG1iRVBhRVFxbHloTkJY?=
 =?utf-8?B?L0JpMTlFc3krd2h4OHVJZUMxS2pzK29JL0QwVWI1VnJpc3pBS1dKSndDYVNM?=
 =?utf-8?B?ZGNmaDdZTHl1UHdYNjlhRGx0cEYxUGM3MGVqSnRIZXRTVE15Tld6dnl1R3BR?=
 =?utf-8?B?SUl5K3RPVW1yRGFNK3lGZ2ZuakU0U0Vsc1ZhQ2t4QmU0SFp1cXFPV3dpcHJY?=
 =?utf-8?B?R0UzcDgvZGpGbTA2K0U0UURLQnZMOTVwNm0yRFczMGlPclhoY0V0by93Ritx?=
 =?utf-8?B?Vy9OUG9yMWU4Z3V1YXRIYkNWMm1Mbnd3cnM1YjBTVkFBQjRJRGhFdmRpU3du?=
 =?utf-8?B?Tnl4dmhGMHRrTGlpTm1KSFdXVHNZUmRUQXlWR2lnQWRmWmZDSzdZSUZzaHYz?=
 =?utf-8?B?alVybG1YRDJIa1J0b3ZtNTRHdXlhMHp2MGNwNjZOTHZhY1RPR20yTHVId3d0?=
 =?utf-8?B?Qm5aTEYxM0h2TUlKNENHaUhBaE1sZFFBODFnRGJxN2lHTm15VHAxQ3J2VE1r?=
 =?utf-8?B?c0NrQkt0Ukpyd2oxTUI4clNBWHFIdHAzVmdQNkI2ZnFNNzBSTkJoSENWc1k1?=
 =?utf-8?B?ZnFiR2MzM0k1anVlbUp1VU9hVjBtRmRYRmxpdU93ZWpiUHNod3RVellEeUkz?=
 =?utf-8?B?WUwxZU02Q0E0cFZOR1lGRzlaQXlDRGtVcVZkNFErcVRyZnIrbTlwR3dwRUN3?=
 =?utf-8?B?VGd6Sm9wSm5pUUd2SnRWSFY2cko1azlOdnNxN0pVM1d1RGN3NGkvRmVHcWpE?=
 =?utf-8?B?ZkE0d3VQMnQ5U0FEWjdOc2Q2S0hoYWlFT3Q4bDk3MHovWlRjUDR6MHg2Rkdt?=
 =?utf-8?B?SUhweHR4RmxYU292N3NNNk54YmpSaS9sQTE3RWxyTTJOVFlSYnZXRnZENWYr?=
 =?utf-8?B?UFRRVEJaZ0ZKYWJ4TmVmQmpEUmJLcWhTSnQ1RDhFTFRkWm1ENnBEN1dwWUdl?=
 =?utf-8?B?dmhuT1lSWUUwckFkazFHWlAyMjV3T0tPMnE3eWthREFnSXQzYjE4ZEcwM1h0?=
 =?utf-8?B?bUVEMVJ2ejlpcTA0UW8reWg2REhoT3VzQnh5c2EzeERyL2RsRUdMYTh0dVVM?=
 =?utf-8?B?eVlVVWlXUGpQcXdPMURSNDBacGJPbFdWUlRpUFBOdXFPNHR2aHZyTmgxRXdp?=
 =?utf-8?B?MGZtdmp4dHFjR3hIK2hXTzBMVHVrT01SalFEcjRwMnQwd2kyOWVVd2Z4QTgz?=
 =?utf-8?B?MFQ1QThoVkd6WEZpbXZiSjdrZHJnL3hkZTZzeEN6eFI1V2twU0pqL2dEVzBX?=
 =?utf-8?B?MEtiSFdaUzN5TGtMWE5wRlFRZm1PbkNua1dTcitzdHE5blRoTzRjTDBJakt0?=
 =?utf-8?B?bDNBc1JMdi90T3E2V2VqWWJhU0lUYWg4THdCTkpXOFllbk5aaWlnQk56VnF6?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44953DB545C1324E8AA0C889A7501A7E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931d3d53-4cc4-4cf6-49b7-08db34a6656e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 00:49:07.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzMNsBIfyzO3tcke2OTc3+jgCkNERD89A92oMoMdaWlbv5N20L8XqZ6pWL/9/HXqAYdYYIb1W16CUxomYwScSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6670
X-MTK:  N
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDA5OjU4IC0wNDAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBNb24sIEFwciAwMywgMjAyMyBhdCAwNToxMzoy
NFBNICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBbLi5dDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiBzdWJkZXYt
ZGVjb2Rlci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiBzdWJkZXYtZGVjb2Rlci55YW1sDQo+ID4gQEAg
LTc2LDExICs3Niw2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIFRoZSBub2RlIG9mIHN5c3Rl
bSBjb250cm9sIHByb2Nlc3NvciAoU0NQKSwgdXNpbmcNCj4gPiAgICAgICAgdGhlIHJlbW90ZXBy
b2MgJiBycG1zZyBmcmFtZXdvcmsuDQo+ID4gDQo+ID4gLSAgZG1hLXJhbmdlczoNCj4gPiAtICAg
IG1heEl0ZW1zOiAxDQo+ID4gLSAgICBkZXNjcmlwdGlvbjogfA0KPiA+IC0gICAgICBEZXNjcmli
ZXMgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2Ugb2YgSU9NTVUgbWFwcyB0bw0KPiA+IG1lbW9y
eS4NCj4gPiAtDQo+ID4gICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiAgICAgIGNvbnN0OiAyDQo+
ID4gDQo+ID4gQEAgLTIwMyw3ICsxOTgsNiBAQCByZXF1aXJlZDoNCj4gPiAgICAtIHJlZw0KPiA+
ICAgIC0gaW9tbXVzDQo+ID4gICAgLSBtZWRpYXRlayxzY3ANCj4gPiAtICAtIGRtYS1yYW5nZXMN
Cj4gPiAgICAtIHJhbmdlcw0KPiA+IA0KPiA+ICBpZjoNCj4gPiBAQCAtMjM2LDcgKzIzMCw2IEBA
IGV4YW1wbGVzOg0KPiA+ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
Mi12Y29kZWMtZGVjIjsNCj4gPiAgICAgICAgICAgICAgbWVkaWF0ZWssc2NwID0gPCZzY3A+Ow0K
PiA+ICAgICAgICAgICAgICBpb21tdXMgPSA8JmlvbW11MCBNNFVfUE9SVF9MNF9WREVDX01DX0VY
VD47DQo+ID4gLSAgICAgICAgICAgIGRtYS1yYW5nZXMgPSA8MHgxIDB4MCAweDAgMHg0MDAwMDAw
MCAweDAgMHhmZmYwMDAwMD47DQo+ID4gICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+
Ow0KPiA+ICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAgICAgICAgICAgICAg
cmFuZ2VzID0gPDAgMCAwIDB4MTYwMDAwMDAgMCAweDQwMDAwPjsNCj4gDQo+IEhpLA0KPiANCj4g
dGhpcyBjaGFuZ2Ugd2FzIGFsc28gZG9uZSBpbiBhbm90aGVyIHBhdGNoIFsxXSwgYW5kIGl0IGlz
IGFscmVhZHkNCj4gcXVldWVkIGZvciB0aGUNCj4gbWVkaWEgdHJlZSBbMl0sIHNvIHlvdSdsbCBu
ZWVkIHRvIHJlbW92ZSB0aGlzIHBhcnQgb2YgeW91ciBwYXRjaCBpbg0KPiBvcmRlciB0bw0KPiBh
dm9pZCBjb25mbGljdHMuDQoNCkhpIE7DrWNvbGFzLA0KDQpUaGFua3MgYSBsb3QgZm9yIHRoaXMg
aW5mb3JtYXRpb24uIEkgd2lsbCByZW1vdmUgdGhlIGNoYW5nZSBpbiB0aGlzDQpmaWxlLg0KDQo+
IA0KPiBbMV0gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDMwMzAxMzg0Mi4y
MzI1OS0zLWFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbS8NCj4gWzJdIA0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvOThjNDg2OTAtNjMxZC0xMDg2LTliN2MtMDA0YzYxY2M4ZGJiQHhz
NGFsbC5ubC8jdA0KPiANCj4gVGhhbmtzLA0KPiBOw61jb2xhcw0K
