Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1380D72DAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbjFMHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjFMHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:20:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A04186
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:20:29 -0700 (PDT)
X-UUID: c314af4209ba11ee9cb5633481061a41-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hznEmKuYLwDV8A/5Vh0TX1Eo2RN3udOfJ7JbEW274f0=;
        b=CsQkIaGgTZBpQX6Zu8I3BM+UL0nS08jXYxWc8LuK7n1vzas2hxsKAEw706ZCYQSnyGPl697lStsVkoZ4U3Z8xLrFaszz5l2amOQyw92Qc1dL0T0D8p7uOxLWnh7qqDgJ/AMHoROpxzlAna4I1JAs1HlCtqmB80QUxcRG9HONWiU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:d4f965eb-4ba7-4bd6-81d5-4a6afed6b868,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:81afe76e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c314af4209ba11ee9cb5633481061a41-20230613
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 56458274; Tue, 13 Jun 2023 15:20:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 15:20:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 15:20:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGId2+WZaZmLjylJ87d93u50vM+3yZMtfbb/0+hCgQ/PXe+Zw+5jywVoKlv7nlZVAohUVlRF2msh1k/E2vPTZVTkNhDraiZiropMK8DB4Ob+3fuJNS9e0IWXeUVrjar4ZGV9o14I2UwfQtssvkecrCN/VHsTnJD+4PHkbNBbxDdmasHkgo1xdLTbdZmlK+lVyahdqNJEfxayIaOY1HgbyY3Y7niBqjWFACOBnTachnWUqr2hJUpTl+sy8BPLzo+EJvXJ3dwRQfn7s60HFugXNLz6YNdiE1B9kGhJAf+Ew2mzNj6XmPFA8w9Br7VBZA0kq/j8CluDvcmsZGwzsVpieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hznEmKuYLwDV8A/5Vh0TX1Eo2RN3udOfJ7JbEW274f0=;
 b=YMc7jrIIUY8tUWxnoxjkXoLV+bPeN8bxLho1gzJn1+M2POqHpaSSnNFWrGPYwYfhbzYQ65v3NvKAqfTM88lYk0Q3irimLOEmLrZkPmop5hGa+qa6vyiHPlTMIh8b+/3vLxQV2vkre5mVwuslfSsTrKVP/TSJH6x1pbKMe8NrFRGF5WzeTNgSMCmFUXaOaUEsi5TpZb8MYlA56ij/TjAPIOjH9C+koPqhu+uCoOLzjfztcaS7b4P3FpVCs0DmkSgDfU49NTw5D++7uhbN1Ex1Kq68R1xonZOJqIsBrXVDgrebjo4eR1NniSpbYRabcGkDVtslRTn7o+nBzIUVCUpQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hznEmKuYLwDV8A/5Vh0TX1Eo2RN3udOfJ7JbEW274f0=;
 b=vsxfmybzATjAZpp3JZyZURPEpIqSVPGTZwJ4lv780H6xaOs01dix34K4ytWJHUs0ozubrP+l62e3KRdyvd0JO64vzUrC0tODP82Q51Oq005P544SMOGlGJQpl8YF7Uk2zuz/L+tcZIlPLBtJ8PGdhvVDjvuShiVffNOBqLGXE1s=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5641.apcprd03.prod.outlook.com (2603:1096:4:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:20:20 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 07:20:19 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 3/5] drm/mediatek: Add initialization for mtk_gem_obj
Thread-Topic: [PATCH 3/5] drm/mediatek: Add initialization for mtk_gem_obj
Thread-Index: AQHZaRzweYxWoYNQokGZSZDt9MHgma+HPSoAgAF/nwA=
Date:   Tue, 13 Jun 2023 07:20:19 +0000
Message-ID: <b5f82bd2f583f072701893b9a70fe099f15428d1.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-4-jason-jh.lin@mediatek.com>
         <f5cb370ffee4fd7f244dcca46f985fdf1367524a.camel@mediatek.com>
In-Reply-To: <f5cb370ffee4fd7f244dcca46f985fdf1367524a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5641:EE_
x-ms-office365-filtering-correlation-id: 0d1cf015-ef36-4c81-ac1b-08db6bdea50b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7qhH+O5ta8+mmaRxvA6B1M0zIkhkfKKkhpzFizAAnI/x6jRW6q59CnErX3hdc2MmCEdo531JzaN/z9gqP+NWBvQnpe8xXPGkB7orfAeEKukM9Xxejp3gUSG9tnaz1PI6+7xKRB+AnXQpk24nL6a6EUADbviwOg2jCohCm6luKmEPX2FiyGqdj0IKLJMW2ZOAaTwlT2sOXZyNyByNuSs3WqmpaZmKZE9e0xMtP52bum8+hWF7Hb6jfjy25d1EEbXHC8yKDK4iGDzOfVtrrIwKl6Ni/UweUo8beTzNPCvkaPdiPWUgAhDXNiN4NS+tHNYvedYrc9lCYfKd0cddITDToXIVwrj41jcr/YkNBNJnm3XX/rvfiEDQfh8eD1DHmoTO8323v7demSTUuHDOD11/hBKBabeFfGuodkjgq49NV2aF/ZSIMiQcttexJuqShYhx71iJ70zxRpr3BNKhRmcH0R5Q7hcjfhwWU334ySX3pKpS3C0rCCxF3lkDfSBgny8Xu9HUxzS/0RgLqY28f3g9RStEfh+aqr/aCc4OvUOSEYu48jId+mMTFDJlEhXxbgKEz5itHhMZQmEeQ4QEtvfATsbNNFjNeZfJpgD6WHS9RE7Zqn+zH55ZsvUuTZXIgzICJX82wnvrdMZq7d8LLAuxr3HQfOFbBP8Qp+sIMLZkbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(66946007)(76116006)(66556008)(64756008)(8936002)(8676002)(5660300002)(85182001)(36756003)(91956017)(71200400001)(478600001)(66476007)(66446008)(4326008)(110136005)(54906003)(316002)(6486002)(41300700001)(38100700002)(122000001)(83380400001)(26005)(186003)(38070700005)(6512007)(107886003)(2616005)(86362001)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3VKQVBDV3NBbkFQR2lNb2hnRW9LWFNkdzFqUVBhUkJoL3dOL091U2NCZ1NE?=
 =?utf-8?B?cXplS1NVSVNLSUNIY3E2Zy96bU9LeXNsYWdhc0RJNUh5dytad3ZXNVcyQnBt?=
 =?utf-8?B?L2ljSFdTN0d6UVJvZ2R5S2ZsbXUzK2o2S3dFKzZEbk9TWjF5ZFBBSHFBYjUz?=
 =?utf-8?B?MUJ2YzNBTGlPcHN2T0dFQjNkTStyRVNZYXBYaWkyZjRzWG5KQWdrR05iTWdx?=
 =?utf-8?B?RGVWSTlIcWgxUDJWK0lXMFZhR1Fvd3YvdnBhY002dTlCUk9ZRGNmVEw5dTE0?=
 =?utf-8?B?dHZyOXl2VFIvUXg1WFhHWitlZGd6VHlPS0dJRmRDYXFoR0RSNkV2djlnWVZ0?=
 =?utf-8?B?K0VudFo2OVVIWGpteGdFNjgyYUtJSDNnUzRtcXR2cEI2OW5JdFlsSURVczRm?=
 =?utf-8?B?NkxXSmNwYU9QVXBsUmt4WThQc3YxV1lMemRUNFVvMzJtazZ1NUdqUXJ3MXBa?=
 =?utf-8?B?RHN2SDlOeDZTSHBsRmEvVUVSNGdyVk84MUNwb3lBQkJXSzZWWEVGSVN4dHh3?=
 =?utf-8?B?d0crSTF5aWZnOXVZOUEyVjI0Q01TQmZRTDNidXVocEFicFpDdS92L0tSMUln?=
 =?utf-8?B?QmNtL3JMSmpuaWI2N1YvZy8wTmV0ZXRiUFQ0djQva3V3OU1CVlBTcmdMTUVM?=
 =?utf-8?B?ZDN5ZG04TUxqNUgxVnlEa0ZrWE1Tem4reEovNTVRRUg5QUcrRG1iKzMwRkFh?=
 =?utf-8?B?YjlTbWNVc1k0T01PK1c1cTIvd0NWR3BaUFNCQ1RycW5tbnR4eDA1clliVUtn?=
 =?utf-8?B?cDJlT013L1pEWHlrUG42ZHpLZ2txUXRZSzJPQ2lENW9ZaDAwZUxaUW5rQSts?=
 =?utf-8?B?eFRRZkg2QmY3eWRGTUsxdlBtTC9VUkhoWENhRmI3cUVvNWpsSkN3Zm4vRVNP?=
 =?utf-8?B?ei96OEJkRTVadGROdE9SRHAzd0F2VUJyL3V2dGJFek9uQVM2bzhPdmJyUjkr?=
 =?utf-8?B?dnk4Zi9WS3ZteWx3T0hpd3hpL0dPY1dJaWtyN3gzYWhNLzU3T2VvTjBROGFj?=
 =?utf-8?B?eHJKdS9UbzlZZkFmNHdyTDJWby9BRjlXN1l4OEZtKy9qdWpwdGk4TnBIZ3I1?=
 =?utf-8?B?cS9tOHNHbEoxOC90d3VGVUxLQno0VURsb3hyaWtVVEFwNjZnNTM5Y3BYeDUy?=
 =?utf-8?B?NU1IOUhVemtaNTBzRzlZcmo0STljZ2ptUnRKdk41c290eXo4dGQxck9za29a?=
 =?utf-8?B?bmNjQWVaMWNKZnpaZWN3Z3R2bmg1bWJkRlB2UlZMb3NUWjQ1SUxPalZ3YWFO?=
 =?utf-8?B?b2RNM3dCU1JUNGFQWW9DS2hIL092dWFLNVBuL204QlpIWXdNcVE1eks2OEpt?=
 =?utf-8?B?aTZxTml6NGlIcU1GeDFpYmkxYkpvWmFXSXdPazZTdUNWM0YzZkpCNm1FVmlq?=
 =?utf-8?B?ei9pRDIxaDdhbXZzeW1vN2paV2ZWOHZZTmZWRHVFYSt0elNnTDZrbkdkcnBE?=
 =?utf-8?B?cnVMT0kwNHQ0R0IwL2FxQzRoek5YS1dLQWY1Vm1GOXJDT09uYnpRNW9FTjlU?=
 =?utf-8?B?bDE5MG1KOHZXSkRDWEEya2ZNVEtRVlJsMEhiSytxS29Wd2hldVdjSUQvRDB3?=
 =?utf-8?B?bGFENlJBUEc0WXlpSTVaZHhTUDlDTEFjbU9qQzdveVdIZEtZUHRIeUNGRzNz?=
 =?utf-8?B?Tm9IbmxLTVpZd2ZJTFdKZU9kOUNVRitzV1dtUWRFV2I4cGQ0aWIyTUNrbkVC?=
 =?utf-8?B?bEpjNi9qdkMvcThVcjErREVKWUcxa3RuQWNtcUhtd2RqR2FaV2hHd2Z1WHV3?=
 =?utf-8?B?ZFdFdFpIT1dXVW1iQVpiQnJrOHZ0NElHZ2pKLzFLT0ZYb1JhSFlBVFFsUUwr?=
 =?utf-8?B?SEk3YXRDUElRQWpoTUNGcWJ4cXo2N0xFQVcrSCtGWXd5UUtZSy95RzlCcUpD?=
 =?utf-8?B?d2VXRVFaR1FIYmpoTFdvTm5EcTRyMko2Nm4xc2hTYjZJY1doTi80K0VhRExO?=
 =?utf-8?B?Zk8wU2RmSUdMaGdVQllxd2dQc21JdC8rU2N6TTRhc3dENEJxamQwTGRRTzZk?=
 =?utf-8?B?UWZHc2RYNCtwQVo0VVF5bS93UTExeTFBdS9rN3lVNkZMdkMrSU1laDdpODhv?=
 =?utf-8?B?NWsxb0JhdzVVdGMyMWc0RldhemtLenRqK0NnNGRNN29idVhzNDhYbU14VUYr?=
 =?utf-8?B?T2RIa3VPclNzL2RWaFlrRldDZGJlUy81aTFNLzZEcXlUS3VRVXRpNmtxTkV4?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <769B5D22827DEB44996E52BF48F97DC7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1cf015-ef36-4c81-ac1b-08db6bdea50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:20:19.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdttfgUzPFXxma/4Pcz9x1KEzgr7nt+7Ba3CQ2E7Jg0VLaDqxHh2Ljm4qMpnS7+hCf1o8aKgycnvpMODjvZkyuMDcLJM6UvM+XdKNwnHNP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBh
dCAwODoyNyArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNC0wNyBhdCAxNDo0NiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IENhbGxpbmcgbXRrX2dlbV9vYmogPSBremFsbG9jKCkgd2hpY2ggcmV0dXJucyB1bmlu
aXRpYWxpemVkIG1lbW9yeSwNCj4gPiBiZWNhdXNlIG10a19nZW1fb2JqIGlzIHVuaW5pdGlhbGl6
ZWQuDQo+ID4gDQo+ID4gSXQgbWF5IGNhdXNlIHVzaW5nIHVuaW5pdGlhbGl6ZWQgdmFsdWUgbXRr
X2dlbV9vYmotPmJhc2UucmVzdg0KPiA+IHdoZW4gY2FsbGluZyBkcm1fZ2VtX29iamVjdF9pbml0
KCkuDQo+ID4gDQo+ID4gU28gYWRkIGluaXRpYWxpemF0aW9uIGZvciBtdGtfZ2VtX29iai4NCj4g
DQo+IFNvIHdlaXJkLCBuYWNrZWQgYnkgbWUuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCkkn
dmUgY2hlY2tlZCB0aGUgY292ZXJpdHkgaXNzdWU6DQoxLiBhbGxvY19mbjogQ2FsbGluZyBremFs
bG9jIHdoaWNoIHJldHVybnMgdW5pbml0aWFsaXplZCBtZW1vcnkuIA0KMi4gYXNzaWduOiBBc3Np
Z25pbmc6IG10a19nZW1fb2JqID0ga3phbGxvYyg0MjRVTCwgMzI2NFUpLCB3aGljaCBwb2ludHMN
CnRvIHVuaW5pdGlhbGl6ZWQgZGF0YS4NCiAgIG10a19nZW1fb2JqID0ga3phbGxvYyhzaXplb2Yo
Km10a19nZW1fb2JqKSwgR0ZQX0tFUk5FTCk7DQoNCi9pbmNsdWRlL2xpbnV4L3NsYWIuaA0KNzMz
OiBzdGF0aWMgaW5saW5lIHZvaWQgKmt6YWxsb2Moc2l6ZV90IHNpemUsIGdmcF90IGZsYWdzKQ0K
NzM0OiB7DQoxLiB1bmluaXRfYnVmZmVyOiBDYWxsIHRvIGttYWxsb2Moc2l6ZSwgZmxhZ3MgfCAw
eDEwMFUpIHJldHVybnMgYW4NCnVuaW5pdGlhbGl6ZWQgYnVmZmVyLiBbTm90ZTogVGhlIHNvdXJj
ZSBjb2RlIGltcGxlbWVudGF0aW9uIG9mIHRoZQ0KZnVuY3Rpb24gaGFzIGJlZW4gb3ZlcnJpZGRl
biBieSBhIGJ1aWx0aW4gbW9kZWwuXQ0KMi4gcmV0dXJuOiBSZXR1cm5pbmcga21hbGxvYyhzaXpl
LCBmbGFncyB8IDB4MTAwVSkuDQoNCg0KSSB0aGluayBpdCBtYXkgYmUgYSBtaXNqdWRnbWVudCB0
byBremFsbG9jIHJldHVybmluZyBhbiB1bmluaXRpYWxpemVkDQptZW1vcnksIHNvIEknbGwgZHJv
cCB0aGlzIHBhdGguDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBG
aXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVk
aWF0ZWsgU29DDQo+ID4gTVQ4MTczLiIpDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2dlbS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2dlbS5jDQo+ID4gaW5kZXggYTI1YjI4ZDNlZTkwLi45YjhmNzJlZDEyZTQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiA+IEBA
IC0zMyw3ICszMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3RfZnVuY3MN
Cj4gPiBtdGtfZHJtX2dlbV9vYmplY3RfZnVuY3MgPSB7DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgbXRr
X2RybV9nZW1fb2JqICptdGtfZHJtX2dlbV9pbml0KHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4gKmRl
diwNCj4gPiAgCQkJCQkJdW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3Qg
bXRrX2RybV9nZW1fb2JqICptdGtfZ2VtX29iajsNCj4gPiArCXN0cnVjdCBtdGtfZHJtX2dlbV9v
YmogKm10a19nZW1fb2JqID0gTlVMTDsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+ICAJc2l6
ZSA9IHJvdW5kX3VwKHNpemUsIFBBR0VfU0laRSk7DQo=
