Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112965BB00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjACG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjACG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:57:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74691272E;
        Mon,  2 Jan 2023 22:57:22 -0800 (PST)
X-UUID: c519c4f9e29f4c7eb4cd223e4e3ab33b-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZmYnDCUAUHPXDRVaowtNGzFRyLwTmO8e/FnkfEePBNo=;
        b=FoBYgfAvMkhRetfKcaC4VVDP/O8GWW0mCTSEdtlQZBS27fc1n/FRpHs6OUsiHDS0C1SNzh1gTsSkMD6m+Q4k/qgXCe4obSkWRRrnJkPjWCIAIJcPRvAmqgLvWq5e7KlCZxDISgIPl4Ocjfd088DwHaX3kjH9aEv5/nSo6iJ5ZIE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:2a5d145a-e05c-4745-b184-cd4ea1a473c6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:e5f4128b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: c519c4f9e29f4c7eb4cd223e4e3ab33b-20230103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2122921351; Tue, 03 Jan 2023 14:57:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 14:57:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 Jan 2023 14:57:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boFf+lwnnJI0aNPWpsdutO1TpqCibLWJTigwvadfd7SmuaJVV4XUR0XsuSFzCOKv1Wi0tqRyp1u3dypkBTp7fAvhUlI7BUmtGVaCv/gQJqDzKNjiVfz0hVgM1KzxcUA2mpas/KEI9b1TLUHysT9LOarlmuVyXflCY2ymP2nSK5IeCR6LYST1aOrKaa67A9Y87sBKpmEFs8wonupOsuI15+kklo6zr678jjYY2oujjyyAeke6JOhhnnomOfYCRv9G3SFMHhxW9sk/PMa8rIzFEkcWsbi6oXb1n54DFiQUOvFMdCrqYEKg6s9Fz7LQ6FRLGef2OELVF2cgp/dTqRxu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmYnDCUAUHPXDRVaowtNGzFRyLwTmO8e/FnkfEePBNo=;
 b=ge1hqRPFs4SchwFHMzCPk03AqFhimdv0Fkm5gBcoRNOlb8utT3n0l7HroBQJ2jna1xkQVT6ZvJGXpGaBl1N+1NC7w6d1YzInvuBFciis9Wet6871ECgv5k9BcNa0Dlfp1pOH5qCpyHgcweVkx+t+O4J3W/AAIr0EjxBezjYAVzQiAa3p7rHj4lTIkqEFzPnrDjYRFBDth7XXhItimi1RJK8buwShDkE+qcqhoSgDRQEIc7w+4lqf3j+nyQBhhz/0sXuB+IX+5bRLnJVq7PSoNXXSv83TmP1EHVfV0yO54FVhGR3zqkGZjBzS+wPnAAZ6MHNDLbp3/PG4LzjSTfNBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmYnDCUAUHPXDRVaowtNGzFRyLwTmO8e/FnkfEePBNo=;
 b=tRS0yZfF1uQoJ9Jaze6RFmjn4bQO/447+duIumi9G/h6HNTdrv4cwQTc77rUnagszxu1DotqDlLAL1Zx9K0e33p3wadg2CuohbQQaKHVaqI/lt72hVE+57wg42PwJ+5ptYy6ETy1I6zwtb/zKFbjlt3iwkcRF1iJD/r+mZJDZbw=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB6791.apcprd03.prod.outlook.com (2603:1096:400:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 06:57:13 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 06:57:13 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 13/13] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH v4 13/13] dt-bindings: mediatek: mt8188: add
 mt8188-mt6359 document
Thread-Index: AQHZHBNTJzci0Zkll0yyf/z7wKpLD66LV20AgADxoQA=
Date:   Tue, 3 Jan 2023 06:57:13 +0000
Message-ID: <a3c4df4278e64d9e7e9a77c44215de281b0d6d75.camel@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
         <20221230055443.16024-14-trevor.wu@mediatek.com>
         <a885bf4b-253d-75fe-0224-02f8dfb44006@linaro.org>
In-Reply-To: <a885bf4b-253d-75fe-0224-02f8dfb44006@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB6791:EE_
x-ms-office365-filtering-correlation-id: e22aba1a-6323-4862-4bc1-08daed57be24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8H4eTugHMw6QPsQfSWKGSOt+zpg3dCouc+za+heIfcHDpo3BZv7AdYd/IIE5PKKXBwRtvFV171+DSwhNSL3obIlC/Kv49CZfqx0c3wOzBPPMOLxAdngs5mBulKxIKTZ9/rSZZM8SgYK3bgYJNe24WXlwA11ORnwymmaJZg9RZ8X918laUWfcWm1p5QS6bBuTjjyyRUbpWFmRWgLFKrb9KCiANGFWTkK18z7dbX0m7x/CDkRHz8WU5IMxwOr+8JalYDVHfkcLJAdxun5sdK6uZicYW++LThCt+dStBJtFN8Zk9bvDgDd9o1UyfW+4Ih+pSykjfMZzclF6oDKUuUHwwkEpif1BIDdIu8O4zxkqWJGM7IWWHyEV00fmUqURrBvA/RZyvZedzHFtlWnaQX18Jq1qEBZSFWKP1Q/4sZRJja1eNP4vqpvs85UIdXCRRwLhIRe6o7erOVwHbewENyyvJSjFE8yevUz6iSZNDUFUerGcAo5LY430SVcu7WTeZnkPnGEVoSBxNuglF3Egr+PCWv8kUvrhXRgADFp7PN0QfFsSWHYstBsG1ZzwDxq9TdFTrrN0vlVGPvWnL22DdBseJqqf7nTH9AaVZh0YhxR3H3O980s2828az4MSA8vA2FXrwCFmNGVT2ZjsqsIClu+YDHXLYV6991q1l9FcO8+Y0VmrBtb/oNvJnSFxfJ4feysmnXuOM4FrcIR4YJV6KXL5knP8hnO68o23/pxogpVAXsAJKbL79SI9PxU0FX8NMWL8734vfy5kdxs0iyNQXeWmmnKrtTkgAXsQ13Ippx8a3evxfse3rmUu9LDzAWx/sZSW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(54906003)(110136005)(26005)(186003)(71200400001)(64756008)(66446008)(2616005)(66556008)(66476007)(6486002)(316002)(66946007)(76116006)(478600001)(966005)(6512007)(4326008)(8936002)(8676002)(7416002)(83380400001)(5660300002)(41300700001)(2906002)(38100700002)(38070700005)(122000001)(86362001)(53546011)(6506007)(36756003)(85182001)(22166006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjIxbDUvOXNIOW9LcWdNQ2hZaWFkcVdHTmI1NTBMdUowRzhRZTJ1Q3JOdGIz?=
 =?utf-8?B?c016d1ZRNE9DcFZZT2hxaTFHVWRaUisra1ZIR1dKVmRmMFJLRWVpOEZXM2xC?=
 =?utf-8?B?OFFMRW5lOGM5Q3JxSmJBZTNGOVp5OVJkdjhQUGZhYWZ1WnYwY1AyRTdDQitV?=
 =?utf-8?B?Y0hHUjF5VnlaQWlOY3NWUU9WYjBKVFVISzZtSUxwQldYRjNJQnFkUWdsRUNB?=
 =?utf-8?B?bFRSTEdZdzZjdUNybjJVR2V2MlNXTHd5NVFQa1BSUys0YTN5UmptZ0hWKy9Z?=
 =?utf-8?B?M0FrTmRFbEY5ZU5kY0VOclRCMlRBcElyZjBKd0FlWklGNWw0K3dSaUdTcHpq?=
 =?utf-8?B?TjFaWXhtb3RPcEthc28zWVZYZURQUWx3QmZQYzR5MlhINllzek5iUEVsWW1S?=
 =?utf-8?B?bmQ4QWp2VDErT1M5YWszUk95OGdCNTNDeEpuTnFIZWt4Zmx1SXI5bHIvNXRF?=
 =?utf-8?B?dEwrcU9BWDUyZktMQUpsSHpqZnpGelRZWlRRbEtac0c5WWNDc3pFZlRBUjdQ?=
 =?utf-8?B?V2F1dHB4bUZ6ZHVFRnFaV2MvZ0VRcnRMTFJzY3hId0xmdlYzTEJpYld2MWVs?=
 =?utf-8?B?ajVqVURlMzd5YUdobzdlb3ZMS3FqWGV4SkpLMGMyOTB6RzA5Z0RyenZQNHcx?=
 =?utf-8?B?UWFuNEhZWm56ak1FbVV4NXMxRTgraVNXNkpUbnhPeHdhaGluT29udE5OMFFU?=
 =?utf-8?B?VXl1eldoRkR0VmIxMVIvNDlkUVQxdlk1R3NVQ3JZUHU5MTVRdk52MkwwTlBJ?=
 =?utf-8?B?K2tUdEVkWkxWTFl5UzZxQUtuVmRrTmhRU0lFdEkyaTM5d1dVR2Y4UDZPbkdQ?=
 =?utf-8?B?NUxiaUprUklic0JENGRQQmNFY3Npckw5Vmh6TTkrcjZVaW9TRWJ0YUNvOHcv?=
 =?utf-8?B?K3YxZjA0L1ptS0pSSlZveWp4QUVDYTRLNEhoWGNjQS9HL3NTdTRJK3JrbUE2?=
 =?utf-8?B?M3E5ODZaSHpUSE1hMkZHWjhtQWJrUGlIa0UvbE9nOHlKSHFhSzdNRnc4aEYw?=
 =?utf-8?B?N2YrdUk4Vm45cjBjZ3ExN0wzOVVicGZ1RXAvMk1LNnZ4RWNFb0tMUXlCMEVs?=
 =?utf-8?B?dmFnRnZZNW41cEkyVmtFMHZ0ZC9PWGJ5Q05hU01MM0pmNFMzN0VRVmdLUFl3?=
 =?utf-8?B?MEozVmdyb28xOVh0aURoUWdEOEZ1cGY0eEUwTVU0R056RGpydXhZb3NmY2c3?=
 =?utf-8?B?bTg1d0ZVQWp5VzA2cU04bkVOU3JtTTI2L3dXVGFnMkY4MmxCMDNFWFFFN0Yx?=
 =?utf-8?B?SEpBcW9OdmN0Y1o2d2Z6eTdyV09MeWQzOVFQb0szdzJXZy9HWGtmdm52YVcx?=
 =?utf-8?B?QjRjRUdjUy9NenNnNXhkdW1BRTZhMUFiaVlVMzR4UUhWQ054Q1YwcmZybUZO?=
 =?utf-8?B?c2tjTTJ2T2xEYi9JUHBkMVROOWw5UEtmRXh3VGF3eDh2bUk5Mzk5WGd3ak9p?=
 =?utf-8?B?VzZoRzdCU3JNYllvOUJFZ29vcUNybUsrWHNHQjFoakUwRUdnTHpIL2h0VUVp?=
 =?utf-8?B?QkNGdGZJbXN5cjBCWkZGODc3Nk1ZK3hwQzhzZ2psYm9MRVpGVGYzbmJLb29o?=
 =?utf-8?B?MDc4MmFDUGYrYzlDbnlNdWxwVHFOOUlZMVRtN1ovN09qTklJckp4amJVcnUw?=
 =?utf-8?B?M1BJMTI5bnlQNHYxNWdZMjBheG9zVWtkOUNyY3lFbHlkdmhpMG1zeFQ2OGJG?=
 =?utf-8?B?UHhYeEo2SzloK1o5bTdVVHM0Q3A0RjNxa3hPbFArdTdnbEVaRHg4N3VQMGZO?=
 =?utf-8?B?dmZSWVRkSXA5UzNpM3NCaVQxL25KVHhtbkZiYTIwY0dYQmVHd1ptVXdpck1h?=
 =?utf-8?B?ODB3SnFoRlVUYnJOZngxMXYzVVltcXI0R04veW55UG1Pa0d3RER3dnZBTU9N?=
 =?utf-8?B?Mml2Nm9vZmtYaDIvcHlBc3hQWkllZi9BUUZ5d3c4VVJZdHYyUHAvRHpFVDls?=
 =?utf-8?B?UGdpQUpzeWc4RzlNS3FjT2c3cHZaek9MenNjNThDQWgvWGlNMVRheFJjQnRZ?=
 =?utf-8?B?b0IxWUJqbm1LSlJjWlRndy9sbXNqTHphSzcxbFhCMFFEb09PdjJjVkRGMktR?=
 =?utf-8?B?eGZYaHR2TW1OMHRuNU40S054RWU4NnUzZ2Fhb2J5cmFVc1poSXUrNHB2R011?=
 =?utf-8?B?NUljSkhXTCs3bEZJY04wZHE3Z2RBL1RUR1NVWlJFUHlwNmtHcmhseUg0d3Bh?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <867DA7B49AFEC8479A864B227DC5A5EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22aba1a-6323-4862-4bc1-08daed57be24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 06:57:13.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9G0rKRMGIQ4WaitTSgeQzuV12wvk+8+6efwWRnH9RTTCwmrE8r0Oy7fmr1nZvbGKu+AjRjuHo6MK08OiDdHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6791
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

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDE3OjMyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAzMC8xMi8yMDIyIDA2OjU0LCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIGRv
Y3VtZW50IGZvciBtdDgxODggYm9hcmQgd2l0aCBtdDYzNTkuDQo+IA0KPiBVc2Ugc3ViamVjdCBw
cmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtICh3aGljaCB5b3UgY2FuIGdldCBmb3INCj4g
ZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24g
dGhlDQo+IGRpcmVjdG9yeQ0KPiB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nKS4NCj4gDQpIaSBLcnp5
c3p0b2YsDQoNCkknbSBzb3JyeSwgYW5kIEknbGwgYWRkICJBU29DIiBwcmVmaXggaW4gdjUuDQoN
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9zb3VuZC9tZWRpYXRlayxtdDgxODgtbXQ2MzU5LnlhbWwg
ICAgICAgICB8IDkzDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgOTMgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTg4LW10NjM1OS55
YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4gPiBtdDYzNTkueWFtbA0KPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0N
Cj4gPiBtdDYzNTkueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAw
MDAwMDAwMDAwLi41NzU0YzFkNDYwZGINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4g
PiBtdDYzNTkueWFtbA0KPiA+IEBAIC0wLDAgKzEsOTMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEu
Mg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbWVkaWF0ZWssbXQ4MTg4LW10NjM1
OS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchblk3dnhldnFvOElMR0hVbjNKZXNzaG1NYkJQ
N1doTU9McHdEcnV2ZF9yX1lJTnU5OUJVWHJhalZaVTl4WTJ6RUdGVVh4dG1yQk9vZmFhYlpxd3Qy
MlA4ek9NWnRrQSTCoA0KPiA+ICANCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1s
Kl9fO0l3ISFDVFJOS0E5d01nMEFSYnchblk3dnhldnFvOElMR0hVbjNKZXNzaG1NYkJQN1doTU9M
cHdEcnV2ZF9yX1lJTnU5OUJVWHJhalZaVTl4WTJ6RUdGVVh4dG1yQk9vZmFhYlpxd3QyMlA5RWhs
d2oydyTCoA0KPiA+ICANCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBNVDgxODggQVNvQyBz
b3VuZCBjYXJkDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFRyZXZvciBXdSA8
dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAg
Y29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODgtbXQ2MzU5LWV2Yg0K
PiA+ICsNCj4gPiArICBtb2RlbDoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3N0cmluZw0KPiA+ICsgICAgZGVzY3JpcHRpb246IFVzZXIgc3BlY2lmaWVk
IGF1ZGlvIHNvdW5kIGNhcmQgbmFtZQ0KPiA+ICsNCj4gPiArICBhdWRpby1yb3V0aW5nOg0KPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvbm9uLXVuaXF1ZS1z
dHJpbmctYXJyYXkNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBBIGxpc3Qgb2Yg
dGhlIGNvbm5lY3Rpb25zIGJldHdlZW4gYXVkaW8gY29tcG9uZW50cy4gRWFjaA0KPiA+IGVudHJ5
IGlzIGENCj4gPiArICAgICAgc2luay9zb3VyY2UgcGFpciBvZiBzdHJpbmdzLiBWYWxpZCBuYW1l
cyBjb3VsZCBiZSB0aGUgaW5wdXQNCj4gPiBvciBvdXRwdXQNCj4gPiArICAgICAgd2lkZ2V0cyBv
ZiBhdWRpbyBjb21wb25lbnRzLCBwb3dlciBzdXBwbGllcywgTWljQmlhcyBvZg0KPiA+IGNvZGVj
IGFuZCB0aGUNCj4gPiArICAgICAgc29mdHdhcmUgc3dpdGNoLg0KPiA+ICsNCj4gPiArICBtZWRp
YXRlayxwbGF0Zm9ybToNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmlu
aXRpb25zL3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgx
ODggQVNvQyBwbGF0Zm9ybS4NCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsg
ICJeZGFpLWxpbmstWzAtOV0rJCI6DQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4gDQo+IE9uIHRo
aXMgbGV2ZWw6DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiANCk9LLiBJJ2xsIGFk
ZCBpdC4NCg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgQ29udGFpbmVyIGZv
ciBkYWktbGluayBsZXZlbCBwcm9wZXJ0aWVzIGFuZCBDT0RFQyBzdWItbm9kZXMuDQo+ID4gKw0K
PiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgZGFpLWxpbmstbmFtZToNCj4gDQo+IElu
c3RlYWQ6DQo+IGxpbmstbmFtZQ0KDQpPSy4gSSdsbCByZXBsYWNlIGl0IGluIHY1Lg0KDQo+ID4g
KyAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgIFRoaXMgcHJvcGVydHkgY29y
cmVzcG9uZHMgdG8gdGhlIG5hbWUgb2YgdGhlIEJFIGRhaS1saW5rIA0KPiA+IHRvIHdoaWNoDQo+
ID4gKyAgICAgICAgICB3ZSBhcmUgZ29pbmcgdG8gdXBkYXRlIHBhcmFtZXRlcnMgaW4gdGhpcyBu
b2RlLg0KPiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgZW51bToNCj4gPiArICAg
ICAgICAgICAgLSBBRERBX0JFDQo+ID4gKyAgICAgICAgICAgIC0gRFBUWF9CRQ0KPiA+ICsgICAg
ICAgICAgICAtIEVURE0xX0lOX0JFDQo+ID4gKyAgICAgICAgICAgIC0gRVRETTJfSU5fQkUNCj4g
PiArICAgICAgICAgICAgLSBFVERNMV9PVVRfQkUNCj4gPiArICAgICAgICAgICAgLSBFVERNMl9P
VVRfQkUNCj4gPiArICAgICAgICAgICAgLSBFVERNM19PVVRfQkUNCj4gPiArICAgICAgICAgICAg
LSBQQ00xX0JFDQo+ID4gKw0KPiA+ICsgICAgICBjb2RlYzoNCj4gPiArICAgICAgICBkZXNjcmlw
dGlvbjogSG9sZHMgc3Vibm9kZSB3aGljaCBpbmRpY2F0ZXMgY29kZWMgZGFpLg0KPiA+ICsgICAg
ICAgIHR5cGU6IG9iamVjdA0KPiA+ICsgICAgICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICBzb3VuZC1kYWk6DQo+
ID4gKyAgICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICAgICAgICAgIG1heEl0ZW1zOiAy
DQo+IA0KPiByZXF1aXJlZCBzb3VuZC1kYWkNCj4gDQpUaGFua3MsIEkgd2lsbCBhZGQgaXQgaW4g
djUuDQoNCg0KPiA+ICsNCj4gPiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAtIGRhaS1saW5r
LW5hbWUNCj4gPiArICAgICAgLSBjb2RlYw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4g
PiArICAtIG1lZGlhdGVrLHBsYXRmb3JtDQo+ID4gKw0KPiANCj4gWW91ciBleGFtcGxlIGxvb2tz
IHByZXR0eSBzdHJhaWdodGZvcndhcmQuIE1heWJlIHlvdSBjYW4gdXNlDQo+IHNpbXBsZS1jYXJk
LnlhbWw/CQ0KPiANCg0KVGhlcmUgaXMgYSBtYWpvciBkaWZmZXJlbmNlIGJldHdlZW4gc2ltcGxl
IGNhcmQgYW5kIE1lZGlhVGVrIHNvdW5kDQpjYXJkLg0KSW4gTWVkaWFUZWsgc291bmQgY2FyZCwg
YWxsIHN1cHBvcnRlZCBkYWktbGlua3MgYXJlIGxpc3RlZCBpbiB0aGUNCm1hY2hpbmUgZHJpdmVy
LCBzbyB0aGUgZGFpLWxpbmsgcHJvcGVydHkgaXMgb25seSB1c2VkIHRvIGludHJvZHVjZSB0aGUN
CmNvbm5lY3RlZCBjb2RlYyBub2Rlcy4gDQpPbiB0aGUgb3RoZXIgaGFuZCwgd2UgaG9wZSB0byBp
bmhlcml0IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBtdDgxOTUgaW4NCndoaWNoIG9uZSBtYWNoaW5l
IGRyaXZlciBzdXBwb3J0cyBib3RoIHNvZiBhbmQgbm9uLXNvZiBjYXJkcywgc28gd2UNCm1ha2Ug
dXNlIG9mICJtZWRpYXRlaywgcGxhdGZvcm0iIGFuZCAibWVkaWF0ZWssYWRzcCIgcHJvcGVydGll
cy4NCklmIEkgZG9uJ3QgbWlzdW5kZXJzdGFuZCB0aGUgaW1wbGVtZW50YXRpb24gb2Ygc2ltcGxl
IGNhcmQsIEkgaGF2ZSB0bw0Kc3BlY2lmeSBldmVyeSBwbGF0Zm9ybSBub2RlIGJ5IGRhaS1saW5r
IGFycmF5IGluIGR0cyBmaWxlIGFuZCBpdCdzIG1vcmUNCmNvbXBsZXggdGhhbiB0aGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbi4NCg0KVGhhbmtzLA0KVHJldm9yDQoNCg==
