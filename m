Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0A63196E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiKUFR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKUFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:17:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB49E4B;
        Sun, 20 Nov 2022 21:17:46 -0800 (PST)
X-UUID: 3bca635c8c464411ace4ff68eade38f3-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QGehNapEvphWhlvvBWTLcEK31CT5yYFSkCBHUX4j9AA=;
        b=ArvMoMLE6NrksquwzgKFDN8ziTkS6G9VGkh5J7vfPg2Mw1NRDTqDqUBLrWKuYwqCT1JGOHEk3RVJ2Rpy6AzU247QUEOaknriKEavi8DxR2AeDedi+ZHEsctETzfgWXJ1PmIqtzV03scz9vUQlp5ZcATuZEB0PIr8HY+FDCpVqHQ=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ddd151ab-ba08-4b8d-8480-c37d34292804,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.12,REQID:ddd151ab-ba08-4b8d-8480-c37d34292804,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:62cd327,CLOUDID:e4e4552f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121131728TGT7QSUK,BulkQuantity:2,Recheck:0,SF:38|16|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 3bca635c8c464411ace4ff68eade38f3-20221121
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 558344112; Mon, 21 Nov 2022 13:17:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 13:17:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 21 Nov 2022 13:17:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AelotmnMJUd+3UCs7HB207gNWZ9NNVtljhkZZDtEOUZj1xT6WXYjyiVcfm0G54yzdVuLIL6vUFRhqwNCltRVDG5KOu9/ADPRnyvkKrfWJTgm5ppqIiyL5II2KiqvTJo6Wu/2VOWYffdleUB4XwNsRAPcLqpxlQvnppFDq5tmz7iSyqCB/P74vT1TRrXJEHLRtXyoXOggTHISxT6zbwBEKuKMAAZrl2ptThMaQYBS6Gg3D12/Gqk5+7WraiASBKeJTaCt3Sw6qmMGJj0HiwL+EIqWpmC8o+7JOpIrezjDmO/Wa6b3GFxdVB4+UAC7yhnYYe5P44GUurMdWZVZq1YahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGehNapEvphWhlvvBWTLcEK31CT5yYFSkCBHUX4j9AA=;
 b=UUztWgplGKoFSFNw9uuf4VBf9Vho94jNXbaNy5ag3QTQAOW0Nvygq0OEDtjcKSivD7a/+O9KOL5EH1uUmi3CVICQfDe0TrOUVK7Z/9Nsgfw05Yi1kbjnmgi01Rfh2KbBJ7XTs/1pS16xM8JcFCsnRArBxMS+HktXjOxNrU2mxckfqnCNpNn0J2w2YgvyubKBOX3A2OsR7oZgBtHNXlqjMF9Edxb5Uhjo0GVyM9avk19t+x8/DbgCkt1Dj0FdFOoCIgIZ8nsaJnfNbku3x/hXs82JKu5hboZuManP1Jyqtaz68vyATop8GPENVqlw47HNrHQ6Fu8Kg/2gKXWGPDSdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGehNapEvphWhlvvBWTLcEK31CT5yYFSkCBHUX4j9AA=;
 b=SrZRewTjVTdxwM/vG+mmdRH+gATylhpQ2hLG7g/V7yvd+BZOBdEOtgE5KpbMChFeQcTFbQCtlQN/WNWAs54BTyXMctAMcvzSsg+sU5+1ipr/uBmEEPvCpy2I88zt6v97QeqL26r539dCdzYmmm8ofh2pqc1+JqPZAiomhQqjghE=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB5296.apcprd03.prod.outlook.com (2603:1096:400:3a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 05:17:37 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 05:17:37 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Topic: [PATCH v4 4/4] iommu/mediatek: Add MT8188 IOMMU Support
Thread-Index: AQHY4r0tBcBjsP7VPkOZrVp8uXSJxK5JC6cA
Date:   Mon, 21 Nov 2022 05:17:37 +0000
Message-ID: <5d902abfcac32e1f51f5c6929a03ba08de0db271.camel@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
         <20221018064239.13391-5-chengci.xu@mediatek.com>
In-Reply-To: <20221018064239.13391-5-chengci.xu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB5296:EE_
x-ms-office365-filtering-correlation-id: 014ce17b-9fec-47df-ee17-08dacb7fb460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THVNlDR5oYAeYKd2gujXU9FYx0H2dIzUmQf9MiFfEgYvDkRMhlLPtVexF7VDWtnHFiqh2/H4GoUvcTWlN5buSj5a21DrP8QD80FtevRS9QTZlIa5InURLBP9NwBhubNqjZgbV04juOasGy+QQkVL3jvx2B9bHdJ+XYubWKG9xMJEgV7JMjqIQSYx5LwHKMokUouo6aQWOvG31mF5aMbKijJLrCv8CGZwvYWOzEzvUep0D/d54V+FM/DwZshOZfNRGKFV96B5+t8IV2WwXJitnt4le2f/ps6/98SxH0FCJbcmYvg4RHC4ciYaoe85ggOBBYczN4a7yla4p8+2mcUUeNUtu4W51bBVjUV3/5c0yNddfjMD7HMuYitBFLBmBh0v+BHQMrlLL3qDZT1R8c61UWaBALbqtixuZE6RTGcBZ3MpU2Q8Has1zzaz+5bzJ1HdCwmu1vsUG/2qlBPJlcm1sI05my/AOCL0uv0wwDIL6uG+03sAoIi6xXFhqHEA44nG/hBBCIpzPVJWThKvyLydrwpsUiDL8S9CHy1N/bxOD/JFH7ImuoceTKJjdS6O1jkknjBqHeQm27SmPblpj+2zYHRZhhcZpxtt1xmskSSB/oQ3SXTNAjEmI0mwiVz8+oFqGiyrFTTiPQJBE3WbVuaNcZei3GDmxNEigDe8nAeQfdjMPUmWmDipkS1R33myIP1HQgSjLgPfYsiqLBEMtrgW+4jkXkZyfDDHO/pcTCfO2QE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(85182001)(36756003)(86362001)(122000001)(38070700005)(66476007)(66946007)(76116006)(66556008)(316002)(66446008)(41300700001)(64756008)(8676002)(4326008)(38100700002)(83380400001)(478600001)(71200400001)(54906003)(6486002)(110136005)(5660300002)(8936002)(2906002)(4001150100001)(7416002)(186003)(2616005)(26005)(6506007)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXlGeVBqTDcxN25Cbk5KOWY1bXpyVFpUdDdDTGpJcjJFcjhWMjYzQVNQUENr?=
 =?utf-8?B?NUl5cEJtSUwyZk5CYjVlclNlK0Y2VGlLVzM5RW9rcmJkWmdZL29hVS82Y1Ax?=
 =?utf-8?B?ZHYvd3c3VkFYTy9mbVVLdnRvZFhMTkpuemNKZnRiTUJpV1JGWW1ucmdINHR3?=
 =?utf-8?B?TVMwWnd1SjMxK0haaHUxNjd6d29tMVF4SFM4K3l2UTdBY3dubkdDNjFiU3dQ?=
 =?utf-8?B?UHIydktiQUl1S2FEOS94WkJ3VHdKbTNaVDR2RlhzeU82dXgvMmNuZ3RnUVZG?=
 =?utf-8?B?UzliUEpiK2ZYbXd6UjlGUmZjZTNOdXRFUkU1QXN3eXp1MVJ6LzM5VUpmZGhu?=
 =?utf-8?B?S0p4Z09XZW9iUmJZUTRCdG5aOVlPWG84c1F6STNPN0tDVnJSY3luZTJGOFhB?=
 =?utf-8?B?WWlCaHcrelFGVTN3RzVFZFVnVHRCVmlXdkYwWE5rUklidmQwQStFUldydTNm?=
 =?utf-8?B?SnQ5YXdrNjFZQTI3MDlTenJrZVNtYkNaQWU5d2UvWEZYT29CZ0ZpUjB2cWFS?=
 =?utf-8?B?dEF5RFBDbGc3blk2OXUxUVlMRXAvTzNkNUFlV1NoVzJFOXl4cHVkYlN6VWpE?=
 =?utf-8?B?Z3BkOVZFclJmaC90L3lXWkw2dkQ1TlBlNVJZdFVRaHpMNWlFSHJXazh6WnJU?=
 =?utf-8?B?WE1mMmVPRmpjbTRzc0Znd2tWOXFEcmtkcEVqVnBmeENzSGpOQjRRelBVNjRv?=
 =?utf-8?B?QlJlZy9ERkZsbVZSVmhkd0xCampES3hhQVhNTEZOYy9VSk5maU9heW9BK1Fu?=
 =?utf-8?B?Z042WlJlZElhNi9EcG8vV1RCb1lVVUhKakdUYXR1YXRmbm9lR0ErY25Fb3F6?=
 =?utf-8?B?ajZTZWFuOWdhMndvTGUyeXV2T2NEaUlLZDhURVE1Y1R4VzVTNUd2VUVpQXpJ?=
 =?utf-8?B?Z1Y0cUJRdjVQWVNxOHZzdWlKcnBMTWlCWU9LbWYvbUdwK0h6di9CSHk5QlV6?=
 =?utf-8?B?aWNOdmlvZTdxOWZ0RE1PUUtGZ1M5RlNwZTQ2SlFGMEZwdHovU013NXRlZFhl?=
 =?utf-8?B?Mi9QZWtVNysxekQ0LzBGU0RHK2NpeUluMnIrNkJqQk90ZWFYd3JRU0tCOW9E?=
 =?utf-8?B?My83TTlVckw3WGFIZ1F0S1JkSlpSZnZ4K0l3MGtBSUhFOXdFckpwWjVhSE5T?=
 =?utf-8?B?eTdiZzl3K0VhdHhXM2IxTkpCTStISFFpczgvODErd2c0WDlNQ2NFbDYrTGxw?=
 =?utf-8?B?T3laa1pVTnJTeWFoNVcyUWxZbHpaZXFjT1AxQm9mVnVYa000SEYxZ2JESWxp?=
 =?utf-8?B?KzFLWEZuRUJpT2k2NFFTNmFQT2VRRlFCSkFPS000VjlHQTZQSlhXalJ1TTlX?=
 =?utf-8?B?ZUJQbnBTby9jZHNGT2pXMlRiVTUwNWczMkVFalVlcUFnMXpqT01WWHU2dlZ3?=
 =?utf-8?B?NGI3WU9aR0RDQ0NVVnRWQVFtT2UvSFBkSEErd3phU2htN3BTTEtjRzhYYnZi?=
 =?utf-8?B?ZGFtRHZ5TVFDVEZBeUFKVHhPaW90dTRQYVlZWVJCVWp6QlI0cm41SHFtVG9o?=
 =?utf-8?B?RFJ1bjhwZnZDdnRqZWNoR3A4eVBMTTVhVkU0aGpOT0pWN1BMQnFmZHFYVVVK?=
 =?utf-8?B?c0x4aThubWwvbWNQMnA2OG5qTldkd0dtYmdKelZTVXQyWVM0ajcwR1hBQzdO?=
 =?utf-8?B?akhISHZlSmJoV05EcGNOZk5tTFhQeGFNWlY1bnp2N0NuOXgwNlZwbXNYZkRN?=
 =?utf-8?B?UWl6VndkZjE1QzFSYWZWYllHbGJVYlVGTm1xQW1TQ1I1b1BJRjN6TXNwWFVr?=
 =?utf-8?B?SjF1STZ5dmsrM3EvcEZhS3c2TzJZMjlxem5xcTJFQ2NVRjZFSGJPMGNzWmJh?=
 =?utf-8?B?cFgvVnhwRms2VlFlNSszeDk2VkVTRWNXZnQyWU4zdnNGejlJTkZmd1AxUWJS?=
 =?utf-8?B?TkM3U1JxUldzd0s4MjBqS2pjcjFmb2R5K3hHV3F1anQyZ0wyRjhBWDI3Vkht?=
 =?utf-8?B?aks4eVlCWFVhcEJwaHlsRU1Nbjg4YVlHSXU2MWZ1d0NxWTdSbGxraDhjM1Fp?=
 =?utf-8?B?ZnBBckd2TzQvL01TOFBNOWNsdGdIaitFYzhWMlN1S2xpVXgzN0gxUWpNdVJU?=
 =?utf-8?B?SWV4SnFKVy9jb3BKbFYwQVFWUVdUdE9taURLTmNhMHphQUNtWm9uQ0Y3dm4w?=
 =?utf-8?B?eTM5ZmdlUUc3Vm1wYW52TFJmZXcySjh3Wm8vS29veUNXa2V4aDNPeGRIbUNE?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1680028C54C5A2419731AB5AF2905D82@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014ce17b-9fec-47df-ee17-08dacb7fb460
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 05:17:37.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcK4B/5twbaMO0zMhwOvB/HqYKjjVqJak6JiZbWOw3k/JVsbIuF3x+jBuX+EH9fAeM8NXHtA5lWU5vfi+CnGlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5296
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDE0OjQyICswODAwLCBDaGVuZ2NpLlh1IHdyb3RlOg0KPiBN
VDgxODggaGFzIDMgSU9NTVUsIGNvbnRhaW5pbmcgMiBNTSBJT01NVXMsIG9uZSBpcyBmb3IgdmRv
LCB0aGUgb3RoZXINCj4gaXMgZm9yIHZwcC4gYW5kIDEgSU5GUkEgSU9NTVUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaGVuZ2NpLlh1IDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMgfCA0Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXgg
Y2I2MmNiODlhMmY0Li4zZGU4YmI1ZDg0MDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtMTY2
LDYgKzE2Niw3IEBAIGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiAgCU00VV9NVDgxNzMsDQo+ICAJ
TTRVX01UODE4MywNCj4gIAlNNFVfTVQ4MTg2LA0KPiArCU00VV9NVDgxODgsDQo+ICAJTTRVX01U
ODE5MiwNCj4gIAlNNFVfTVQ4MTk1LA0KPiAgfTsNCj4gQEAgLTE0NzUsNiArMTQ3Niw0OSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGENCj4gbXQ4MTg2X2RhdGFfbW0g
PSB7DQo+ICAJLmlvdmFfcmVnaW9uX25yID0gQVJSQVlfU0laRShtdDgxOTJfbXVsdGlfZG9tKSwN
Cj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBt
dDgxODhfZGF0YV9pbmZyYSA9IHsNCj4gKwkubTR1X3BsYXQJICA9IE00VV9NVDgxODgsDQo+ICsJ
LmZsYWdzICAgICAgICAgICAgPSBXUl9USFJPVF9FTiB8IERDTV9ESVNBQkxFIHwgU1REX0FYSV9N
T0RFIHwNCj4gUE1fQ0xLX0FPIHwNCj4gKwkJCSAgICBNVEtfSU9NTVVfVFlQRV9JTkZSQSB8DQo+
IElGQV9JT01NVV9QQ0lFX1NVUFBPUlQgfA0KPiArCQkJICAgIENGR19JRkFfTUFTVEVSX0lOX0FU
RiwNCj4gKwkuaW52X3NlbF9yZWcgICAgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KPiArCS5i
YW5rc19udW0JICA9IDEsDQo+ICsJLmJhbmtzX2VuYWJsZSAgICAgPSB7dHJ1ZX0sDQo+ICsJLmlv
dmFfcmVnaW9uICAgICAgPSBzaW5nbGVfZG9tYWluLA0KPiArCS5pb3ZhX3JlZ2lvbl9uciAgID0g
QVJSQVlfU0laRShzaW5nbGVfZG9tYWluKSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODhfZGF0YV92ZG8gPSB7DQo+ICsJLm00dV9w
bGF0CT0gTTRVX01UODE4OCwNCj4gKwkuZmxhZ3MgICAgICAgICAgPSBIQVNfQkNMSyB8IEhBU19T
VUJfQ09NTV8zQklUUyB8DQo+IE9VVF9PUkRFUl9XUl9FTiB8DQo+ICsJCQkgIFdSX1RIUk9UX0VO
IHwgSU9WQV8zNF9FTiB8IFNIQVJFX1BHVEFCTEUgfA0KPiBNVEtfSU9NTVVfVFlQRV9NTSwNCj4g
KwkuaHdfbGlzdCAgICAgICAgPSAmbTR1bGlzdCwNCj4gKwkuaW52X3NlbF9yZWcgICAgPSBSRUdf
TU1VX0lOVl9TRUxfR0VOMiwNCj4gKwkuYmFua3NfbnVtICAgICAgPSAxLA0KPiArCS5iYW5rc19l
bmFibGUgICA9IHt0cnVlfSwNCj4gKwkuaW92YV9yZWdpb24JPSBtdDgxOTJfbXVsdGlfZG9tLA0K
PiArCS5pb3ZhX3JlZ2lvbl9ucgk9IEFSUkFZX1NJWkUobXQ4MTkyX211bHRpX2RvbSksDQo+ICsJ
LmxhcmJpZF9yZW1hcCAgID0ge3syfSwgezB9LCB7MjF9LCB7MH0sIHsxOX0sIHs5LCAxMCwNCj4g
KwkJCSAgIDExIC8qIDExYSAqLywgMjUgLyogMTFjICovfSwNCj4gKwkJCSAgIHsxMywgMCwgMjkg
LyogMTZiICovLCAzMCAvKiAxN2IgKi8sIDB9LA0KPiB7NX19LA0KPiArfTsNCj4gKw0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4OF9kYXRhX3ZwcCA9IHsN
Cj4gKwkubTR1X3BsYXQJPSBNNFVfTVQ4MTg4LA0KPiArCS5mbGFncyAgICAgICAgICA9IEhBU19C
Q0xLIHwgSEFTX1NVQl9DT01NXzNCSVRTIHwNCj4gT1VUX09SREVSX1dSX0VOIHwNCj4gKwkJCSAg
V1JfVEhST1RfRU4gfCBJT1ZBXzM0X0VOIHwgU0hBUkVfUEdUQUJMRSB8DQo+IE1US19JT01NVV9U
WVBFX01NLA0KPiArCS5od19saXN0ICAgICAgICA9ICZtNHVsaXN0LA0KPiArCS5pbnZfc2VsX3Jl
ZyAgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KPiArCS5iYW5rc19udW0gICAgICA9IDEsDQo+
ICsJLmJhbmtzX2VuYWJsZSAgID0ge3RydWV9LA0KPiArCS5pb3ZhX3JlZ2lvbgk9IG10ODE5Ml9t
dWx0aV9kb20sDQo+ICsJLmlvdmFfcmVnaW9uX25yCT0gQVJSQVlfU0laRShtdDgxOTJfbXVsdGlf
ZG9tKSwNCj4gKwkubGFyYmlkX3JlbWFwICAgPSB7ezF9LCB7M30sIHsyM30sIHs3fSwge01US19J
TlZBTElEX0xBUkJJRH0sDQo+ICsJCQkgICB7MTIsIDE1LCAyNCAvKiAxMWIgKi99LCB7MTQsDQo+
IE1US19JTlZBTElEX0xBUkJJRCwNCj4gKwkJCSAgIDE2IC8qIDE2YSAqLywgMTcgLyogMTdhICov
LA0KPiBNVEtfSU5WQUxJRF9MQVJCSUQsDQo+ICsJCQkgICAyNywgMjggLyogY2N1MCAqLywgTVRL
X0lOVkFMSURfTEFSQklEfSwgezQsDQo+IDZ9fSwNCj4gK307DQo+ICsNCg0KQWRkIFBHVEFCTEVf
UEFfMzVfRU4gZm9yIHRoZW0uIFRoZW4sDQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCg0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9k
YXRhIG10ODE5Ml9kYXRhID0gew0KPiAgCS5tNHVfcGxhdCAgICAgICA9IE00VV9NVDgxOTIsDQo+
ICAJLmZsYWdzICAgICAgICAgID0gSEFTX0JDTEsgfCBIQVNfU1VCX0NPTU1fMkJJVFMgfA0KPiBP
VVRfT1JERVJfV1JfRU4gfA0KPiBAQCAtMTU0Myw2ICsxNTg3LDkgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQNCj4gbXRrX2lvbW11X29mX2lkc1tdID0gew0KPiAgCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19kYXRhfSwNCj4g
IAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1tNHUiLCAuZGF0YSA9ICZtdDgxODNf
ZGF0YX0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtaW9tbXUtbW0iLCAg
ICAuZGF0YSA9DQo+ICZtdDgxODZfZGF0YV9tbX0sIC8qIG1tOiBtNHUgKi8NCj4gKwl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1pb21tdS1pbmZyYSIsIC5kYXRhID0NCj4gJm10ODE4
OF9kYXRhX2luZnJhfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1pb21t
dS12ZG8iLCAgIC5kYXRhID0NCj4gJm10ODE4OF9kYXRhX3Zkb30sDQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODgtaW9tbXUtdnBwIiwgICAuZGF0YSA9DQo+ICZtdDgxODhfZGF0
YV92cHB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLW00dSIsIC5kYXRh
ID0gJm10ODE5Ml9kYXRhfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1p
b21tdS1pbmZyYSIsIC5kYXRhID0NCj4gJm10ODE5NV9kYXRhX2luZnJhfSwNCj4gIAl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1pb21tdS12ZG8iLCAgIC5kYXRhID0NCj4gJm10ODE5
NV9kYXRhX3Zkb30sDQo=
