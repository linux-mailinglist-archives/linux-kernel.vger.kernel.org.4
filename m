Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9376F72D943
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjFMFch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbjFMFcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:32:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50457E7A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:30:19 -0700 (PDT)
X-UUID: 5efba02e09ab11ee9cb5633481061a41-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uT6CfhqZ8GmJpLEKWeP4eD3bm9PAYilekRS1fjBZ4og=;
        b=XWHdlREhC8M64iw1EWg+M6KI1E7bofaOLvclEypqrTdpCtKR4+8iTw5pnfEiWGZHRkFzMkTWG3W3aZbSfU46aS3GbG5SGPCdUzIKZWrarfFCO8/jc7xP1f0pOCVFpvk00b1AJi/dHnfMUxkWSRAdu/bThwf5hHrP88kHojiKexg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:758feed8-98c2-4009-9683-be5153cb7e09,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:2,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:cb9a4e1,CLOUDID:6acce36e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5efba02e09ab11ee9cb5633481061a41-20230613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <xiaoming.ding@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1541572634; Tue, 13 Jun 2023 13:30:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 13:30:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 13:30:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGPWjjLNSHWBvMrd7fnq2tJx67wT9Zb4vFdJ2YHsKrBuyy0XwHc+Z7Px2x744kUOd1OZc18IHePP8/QwgJZvKtlBRz+DUmpMKW3MyMRjaM2Txkf0LgBelg/II2u3ebB5U0IonjRofU5rR7RLhsyg50OFkALkC1I1+ylvnwV6t8PpeFQgrbktyxXxYbt1V7Vu7TiSdlYD9x0xjEEpt5cOqp+jeMmpdz5SqCxJSvfvinHyryNTfvU7N/yrrJhadUDPbTiWcBd0zPLfKTomd96SiVX+ZYw9UPHbTlG/UlOF5E63oPsO0fZut2tK2sWZ/Dzjjgyd+IbS3ykAFUibI9n/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT6CfhqZ8GmJpLEKWeP4eD3bm9PAYilekRS1fjBZ4og=;
 b=iPqqs/mF3wxeJO5dye3CWOLDTeTncg+RHYJvKaFgiswqxBRKLY3opKL6GeAdI+fICVesfeRrd0U8sxk97WkFWFpm4XZC05m4DZJd2IfgQExA1TSKir1hIbWKQWtcoGba/1KcqrWJKzaeZzoFq6vWklomowKLRXvboegS/gCkrpZ1MQbkDESeH/fd9ll9RForCXM6MRwrPd54v8ymzAmz2zg48ogLW0LjFIBObZdrRweoWj6NSpfcTsy5KohKvMWv2pxDiVq9+PsHdR0tmzd1AOfDKEpEKrjOpdFk4Z6B4krqV8oyVDkLF25mMkEUsiJKxsuRFfKWsaAsW/Yewkgj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT6CfhqZ8GmJpLEKWeP4eD3bm9PAYilekRS1fjBZ4og=;
 b=Q3AwgS98YwZLedUyDrlI2oWzN/h65F6ybt4aWHBxLL2qMP0XHU/kRHxuOaoGa5RdymOeRTQtg1xAyYl44w6Bj3lMGYnQkM16/KmhWK0LBsG5cuLsHnJoisHUIzgBJWwrTHOYDW7DoBpWQlYHks+2LFkI6z+NYvEOS5Bn1sQWI+I=
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com (2603:1096:4:10a::14)
 by SI2PR03MB6137.apcprd03.prod.outlook.com (2603:1096:4:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 05:30:08 +0000
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::1228:1f7d:ba94:bee8]) by SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::1228:1f7d:ba94:bee8%4]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 05:30:08 +0000
From:   =?utf-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>
To:     "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>
CC:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Thread-Topic: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Thread-Index: AQHZiG5Ti2msX8Qf8EyhdjKxcboKPK9eE0uAgAAFAYCAAARtAIAAFamAgAACxoCAAAv5AIAAh2KAgACm7ICAAB3+AIAAgrWAgAcSBoCAAFx4AIAg4L2A
Date:   Tue, 13 Jun 2023 05:30:07 +0000
Message-ID: <acc5f89dee4426e8c8953eabc65e932f22dde169.camel@mediatek.com>
References: <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
         <ZGSLiiK/JzD5KMd7@infradead.org>
         <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
         <ZGSgCZrg+RjAbGO1@infradead.org>
         <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
         <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
         <ZGWnq/dAYELyKpTy@infradead.org>
         <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
         <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
         <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
         <106e7886-ef02-4979-b96d-66d33cfa119c@lucifer.local>
In-Reply-To: <106e7886-ef02-4979-b96d-66d33cfa119c@lucifer.local>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5369:EE_|SI2PR03MB6137:EE_
x-ms-office365-filtering-correlation-id: 7dfb8814-2451-4a29-98af-08db6bcf4014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AScndfAXMachzIjSmMkes7P00C0rgdjirYTdZEnYCcPqOay8U7WzVFvavgVUrXIGg7lMXLZXSaA5u2KPiIXYlwI1UugBJEd3K4WUi7SCOP0reYzeL2WG7qO1aqzeGgnmOHwUSrko7szRLIjV4OKvF8M9D6DexuoSk55PebA6lRmR9Vy3cFL6o8hNT1VbiziM9icPEMqID6+t5iD5rkTPHwAO3kFXVv8NuUr3XdSpdrKSG34NGS4WmTLE2a4uq80kK55v7LARieZUBIqij+a7XPsbyN5OLFrfo4drk6PhFuackj/8MiH+HhtLI/PfC23IRtySjzHAS9Mv42K9F7IjhsH5dD/i1yMQI700+3V1M1AwayUglRwjiiYfh+D/gzORttFoTQ2XafoGYPjMkXuEc4oUPm1+P0aNQNRNdUIrZkJ3Ljf5hw6pF/WP6+6PmUm3xiPMcspTn72U57LrgBHm2SDlK7Qq2omIWUsqJenUA3zsaGBfF/4XOLxvNmVawvxQ+AYrD5AzXMiXgDGABpPCFSDDG/ssu4CS4GrBrSxeTozm88a5d8wYCPqK8DdEbx1PLXpgbr4J+V115CB6w123F+Ot5uqhQrDuThy3Zzf6tWMsaTV0mVYkHK25Xs5LN5q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5369.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(66946007)(76116006)(4326008)(91956017)(66446008)(66476007)(64756008)(66556008)(36756003)(186003)(54906003)(478600001)(110136005)(2616005)(2906002)(8676002)(316002)(41300700001)(86362001)(6486002)(7416002)(6506007)(53546011)(38070700005)(71200400001)(8936002)(122000001)(5660300002)(83380400001)(26005)(85182001)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWplSExmOTM5UnJzSm83MTk4ajlqOUVYcDJlbE13YURYTlF1ZStxOFJkUVZi?=
 =?utf-8?B?K29DY0JXeHQ2cTJnNW1yOVA2OG01MUszUWQzamNNeHV0cHc5OUJxMWVSdVpJ?=
 =?utf-8?B?TTk5NFZvMzBQZ243dWFMVkQ1bUZtQmc5dTZBV0tuWllWZlV1c1lSYUNYc0pl?=
 =?utf-8?B?UVhBQUNjdGlOTVA1aW9CcURTU2trNmpoSStqQlcvLzZFdDk5N2VRK2FnTm1h?=
 =?utf-8?B?WjE0ODhUbjFuSnRTdDl4YnJWSXdlZnRsbjloRUYvMFRIVG91RVBYWUpnU2dO?=
 =?utf-8?B?a0p1b2tyN3ZvQ0pmR0w2RS9lTHArWEhaWTZDRVJVdnY2S1U5VEdlSXJvcUhx?=
 =?utf-8?B?by9tZXhJRE5rWlF6cElDSUp5U3N1L1JqbFA4LzdFRXhEYytVdWV3Z3BIQWdS?=
 =?utf-8?B?VnlaOXpBVXVhL1FTWXRVeEhDOUpjeExYejArSVlrVklwd2QzbXJGd2J1MGpj?=
 =?utf-8?B?SHEvK1E0ZVRzdWVHMDFuYUVydUJmMmJJcENzTFB4L21DeDlKSlZGYVpRN1Bu?=
 =?utf-8?B?MHBFY0ZpZUxnQ0tjMm53ZTdZSC9Zazk1RHRZU3l1aGxhOFE3Q3d4K3lSbjhF?=
 =?utf-8?B?a2xrblUvTlhnNzNjb3RGdHZFQnVtV2RZVlhkL2Vkak5yYzJ5T0pJNjk5T2xO?=
 =?utf-8?B?OTh2WlZaTWRhTUxZR1hvRHY0dERFVjl2T1ZBb3BvbnJRTjQ5aUlHY2xMNUR5?=
 =?utf-8?B?WHFHdjZKZEcwb3lGWXRILzY3WUpJWkVJRDkxKzdXT0lNRGEya3A5TFNzUGxh?=
 =?utf-8?B?MTJhRFpqQlBCaHV4a3RucFhYSktNZmZZK1dmUFhGVU5mRFFyaUdlTVVzY2Mz?=
 =?utf-8?B?bXR2S3dES09wRmtsTTRUd0pLcHQ2cEkyMEMyRGg4UXEwMTEvanh5N3NSQndj?=
 =?utf-8?B?c3lOZU5GbHFwYk0wY21LQjk3YzdYbTJybVdqS1FQZmdwTEZwdXVJSnIvY2dZ?=
 =?utf-8?B?R05RWWkxZk1vLzA1Vzc0a2hPN2JybFlscTFhRkgwVk1sbGI5bU5MckFYYVNj?=
 =?utf-8?B?aG1YQkc1NDl0blo2TzJvaDRMcUhwZGx6T1N6Z1g0L3ZWeTNBRHR1ZmZEWk0x?=
 =?utf-8?B?bE5SV1hvcjB1Ynh1Nm9TdHFmUWFEaGp6VlRYeHB6RVdEUjNlQi9RM1NWN0Vj?=
 =?utf-8?B?eTdab1ZnaFVPZ2djK0h1T1lhcGsxTklTV0VrenBuWkJsV3lnZEZTNU1mZG9x?=
 =?utf-8?B?WmVtUWd6amd4MnlrOFE1c3FSK1hqZ1NJQWhneksxa0FacEg2OG1KMWF6enhO?=
 =?utf-8?B?Nk0zTU1sa21Ud09LeXZiU0o4eFBjUmM0dFcxcXEzLzl1QTIwZFZILzlzSEJ3?=
 =?utf-8?B?c04wZmNsSHVFYlE0RENWQVYyQjVVYlYvcEJ4VXRIVXpjWkVZMXJYTE1RUHVT?=
 =?utf-8?B?SE4xdzNWdHkxS2ZNOU81OEwrQW5iR0tjT0RrZERiUXh5UFRIZ09CcWMxZFkx?=
 =?utf-8?B?OExXTlpIS0hYaTcwMC92cEswaUFtUzB2WGR2U1F0cnBZTmRYeFVnalVJWGxO?=
 =?utf-8?B?Y0lra1g2NU4zczRRNFRMbGF0cDZ4NWc4UG1yYlVOL0dNVXFVQTFyUi9PNnZm?=
 =?utf-8?B?VDhuNUVrUUtNQWt0d2ppNHF2WmU2WDFWdUNyN2kycnl5RDA5RU5kL0RJQTVO?=
 =?utf-8?B?R0VNMzVCdC8xYzNmQ2EwRk8vR3oxNk1laUdTbktsMFdQSmNOaHRsaXlIUjVU?=
 =?utf-8?B?cFpvWnZuMlhzeUtOV3I1NzFvQytJTWtZQlcreUU3STlVVThKR0FZY1VUZDQx?=
 =?utf-8?B?M2ltSlhmTDd4VHJXVTJoekM3ckJqTGNjL2R2bkl2WExieFlrdlJEWU5XMkRY?=
 =?utf-8?B?MjZ1RmJnSnBOQS9oTnU2NW9zWDBPSWlZbUFqekZZNnpoM3p1UnZFVlhqWlNZ?=
 =?utf-8?B?QjFJd1F5L1EwMTFTVjcvTlRKai85R20zbDMvMmxVTjNCdzFDUGFwdWUrbVp6?=
 =?utf-8?B?TlgyeHRzSFdGZTYrcS82aisxU24xakx4QVltQUdHSHJiamI1ZTdTZmVDSFNy?=
 =?utf-8?B?WFF0ZXBHVHRVWWtMSkxIOUxMWUNVQ3hFbXhzb3BhMEIvUzZSU01heUVPcndn?=
 =?utf-8?B?aWRkRm84TCtPc2h5cExxUUdMYzdQNm10Qkh3REdIWkp5VFN3SWJOTUJGQTZz?=
 =?utf-8?B?TXl0eDJ2dmUxdHVWazdvbk9HRzF0czhJSUczMTJ1T2tqdStMYXgvYWRwaCtC?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <997655933BC9D34A98D7E8F14ACCDB64@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5369.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb8814-2451-4a29-98af-08db6bcf4014
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 05:30:08.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDsVwhhVNyj7/vEl44EDBFeL+wacl2on0db3jrRYgF7C6LP1YVlLpsPjEm0GuI+AnnfR/9cdKcNUymNmuhCnsA9vPp8sy/GApZzfPoGz56s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U28gZG8gd2UgaGF2ZSBhIGNvbmNsdXRpb24gYWJvdXQgdGhpcyBwYXRjaD8gIG9yIG5lZWQgbW9y
ZSB0aW1lIHRvDQpzdHVkeSB0aGUgcG9zc2libGUgcmlza3MNCg0KT24gVHVlLCAyMDIzLTA1LTIz
IGF0IDA4OjI1ICswMTAwLCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWls
IDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+
IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4g
T24gTW9uLCBNYXkgMjIsIDIwMjMgYXQgMDY6NTQ6MjlQTSAtMDcwMCwgSm9obiBIdWJiYXJkIHdy
b3RlOg0KPiA+IE9uIDUvMTgvMjMgMDY6NTYsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiA+
ID4gT24gMTguMDUuMjMgMDg6MDgsIFN1bWl0IEdhcmcgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwg
MTggTWF5IDIwMjMgYXQgMDk6NTEsIENocmlzdG9waCBIZWxsd2lnIDwNCj4gPiA+ID4gaGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDE3
LCAyMDIzIGF0IDA4OjIzOjMzUE0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kDQo+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBJbiBnZW5lcmFsOiBpZiB1c2VyIHNwYWNlIGNvbnRyb2xzIGl0
IC0+IHBvc3NpYmx5IGZvcmV2ZXINCj4gPiA+ID4gPiA+IC0+IGxvbmctdGVybS4gRXZlbg0KPiA+
ID4gPiA+ID4gaWYgaW4gbW9zdCBjYXNlcyBpdCdzIGEgc2hvcnQgZGVsYXk6IHRoZXJlIGlzIG5v
IHRydXN0aW5nDQo+ID4gPiA+ID4gPiBvbiB1c2VyIHNwYWNlLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBGb3IgZXhhbXBsZSwgaW91cmluZyBmaXhlZCBidWZmZXJzIGtlZXAgcGFnZXMgcGlu
bmVkIHVudGlsDQo+ID4gPiA+ID4gPiB1c2VyIHNwYWNlDQo+ID4gPiA+ID4gPiBkZWNpZGVzIHRv
IHVucmVnaXN0ZXJlZCB0aGUgYnVmZmVycyAtPiBsb25nLXRlcm0uDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFNob3J0LXRlcm0gaXMsIGZvciBleGFtcGxlLCBzb21ldGhpbmcgbGlrZSBPX0RJ
UkVDVCB3aGVyZQ0KPiA+ID4gPiA+ID4gd2UgcGluIC0+IERNQSAtPg0KPiA+ID4gPiA+ID4gdW5w
aW4gaW4gZXNzZW50aWFsbHkgb25lIG9wZXJhdGlvbi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBC
dHcsIG9uZSB0aGluZyB0aGF0J3MgYmVlbiBvbiBteSBtaW5kIGlzIHRoYXQgSSB0aGluayB3ZSBn
b3QNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBwb2xhcml0eSBvbiBGT0xMX0xPTkdURVJNIHdy
b25nLiAgSW5zdGVhZCBvZiBvcHRpbmcgaW50byB0aGUNCj4gPiA+ID4gPiBsb25nIHRlcm0NCj4g
PiA+ID4gPiBiZWhhdmlvciBpdCByZWFsbHkgc2hvdWxkIGJlIHRoZSBkZWZhdWx0LCB3aXRoIGEN
Cj4gPiA+ID4gPiBGT0xMX0VQSEVNRVJBTCBmbGFnDQo+ID4gPiA+ID4gdG8gb3B0IG91dCBvZiBp
dC4gIEFuZCBldmVyeSB1c2VycyBvZiB0aGlzIGZsYWcgaXMgcmVxdWlyZWQNCj4gPiA+ID4gPiB0
byBoYXZlDQo+ID4gPiA+ID4gYSBjb21tZW50IGV4cGxhaW5pbmcgdGhlIGxpZmUgdGltZSBydWxl
cyBmb3IgdGhlIHBpbi4uDQo+IA0KPiBJIGNvdWxkbid0IGFncmVlIG1vcmUsIGJhc2VkIG9uIG15
IHJlY2VudCBmb3JheXMgaW50byBHVVAgdGhlDQo+IGludGVyZmFjZQ0KPiBjb250aW51ZXMgdG8g
c3RyaWtlIG1lIGFzIG9kZDotDQo+IA0KPiAtIEZPTExfR0VUIGlzIGEgd2luZyBhbmQgYSBwcmF5
ZXIgdGhhdCBub3RoaW5nIHRoYXQNCj4gICBbZm9saW98cGFnZV1fbWF5YmVfZG1hX3Bpbm5lZCgp
IHByZXZlbnRzIGhhcHBlbnMgaW4gdGhlIGJyaWVmDQo+IHBlcmlvZCB0aGUNCj4gICBwYWdlIGlz
IHBpbm5lZC9tYW5pcHVsYXRlZC4gU28gYWdyZWUgY29tcGxldGVseSB3aXRoIERhdmlkJ3MNCj4g
Y29uY2VwdCBvZg0KPiAgIHVuZXhwb3J0aW5nIHRoYXQgYW5kIHBlcmhhcHMgY2FyZWZ1bGx5IGNv
bnNpZGVyaW5nIG91ciB1c2Ugb2YNCj4gICBpdC4gT2J2aW91c2x5IHRoZSBjb21tZW50cyBhcm91
bmQgZnVuY3Rpb25zIGxpa2UgZ3VwX3JlbW90ZSgpIG1ha2UNCj4gY2xlYXINCj4gICB0aGF0ICd0
aGlzIHBhZ2Ugbm90IGJlIHdoYXQgeW91IHRoaW5rIGl0IGlzJyBidXQgSSB3b25kZXIgd2hldGhl
cg0KPiBtYW55DQo+ICAgY2FsbGVycyBvZiBHVVAgX3RydWx5XyB0YWtlIHRoYXQgb24gYm9hcmQu
DQo+IA0KPiAtIEZPTExfTE9OR1RFUk0gaXMgZW50aXJlbHkgb3B0aW9uYWwgZm9yIFBVUCBhbmQg
eW91IGNhbiBqdXN0IGdvDQo+IGFoZWFkIGFuZA0KPiAgIGZyYWdtZW50IHBhZ2UgYmxvY2tzIHRv
IHlvdXIgaGVhcnQncyBjb250ZW50LiBPZiBjb3Vyc2UgdGhpcyB3b3VsZA0KPiBiZSBhbg0KPiAg
IGFidXNlLCBidXQgYWJ1c2VzIGhhcHBlbi4NCj4gDQo+IC0gV2l0aCB0aGUgcmVjZW50IGNoYW5n
ZSB0byBQVVAvRk9MTF9MT05HVEVSTSBkaXNhbGxvd2luZyBkaXJ0eQ0KPiB0cmFja2VkDQo+ICAg
ZmlsZS1iYWNrZWQgbWFwcGluZ3Mgd2UncmUgbm93IHJlYWxseSByZWx5aW5nIG9uIHRoaXMgZmxh
Zw0KPiBpbmRpY2F0aW5nIGENCj4gICBfbG9uZyB0ZXJtXyBwaW4gc2VtYW50aWNhbGx5LiBCeSBk
ZWZhdWx0aW5nIHRvIHRoaXMgYmVpbmcgc3dpdGNoZWQNCj4gb24sIHdlDQo+ICAgYXZvaWQgY2Fz
ZXMgb2YgY2FsbGVycyB3aG8gbWlnaHQgZW5kIHVwIHRyZWF0aW5nIHRoZSB3b24ndA0KPiAgIHJl
Y2xhaW0vZXRjLiBhc3BlY3Qgb2YgUFVQIGFzIGFsbCB0aGV5IGNhcmUgYWJvdXQgd2hpbGUgaWdu
b3JpbmcNCj4gdGhlDQo+ICAgTUlHUkFURV9NT1ZBQkxFIGFzcGVjdC4NCj4gDQo+ID4gDQo+ID4g
SSBzZWUgbWF5YmUgMTAgb3IgMjAgY2FsbCBzaXRlcyB0b2RheS4gU28gaXQgaXMgZGVmaW5pdGVs
eSBmZWFzaWJsZQ0KPiA+IHRvIGFkZA0KPiA+IGRvY3VtZW50YXRpb24gYXQgZWFjaCwgZXhwbGFp
bmluZyB0aGUgd2h5IGl0IHdhbnRzIGEgbG9uZyB0ZXJtIHBpbi4NCj4gPiANCj4gDQo+IFllYWgs
IG15IGVmZm9ydHMgYXQgZS5nLiBkcm9wcGluZyB2bWFzIGhhcyBiZWVuIGV5ZS1vcGVuaW5nIGlu
DQo+IGFjdHVhbGx5DQo+IHF1aXRlIGhvdyBvZnRlbiBhIHJlZmFjdG9yaW5nIGxpa2UgdGhpcyBv
ZnRlbiBlbmRzIHVwIGJlaW5nIG1vcmUNCj4gc3RyYWlnaHRmb3J3YXJkIHRoYW4geW91IG1pZ2h0
IGltYWdpbmUuDQo+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXQgZG9lcyBsb29rIGxpa2UgYSBiZXR0
ZXIgYXBwcm9hY2ggdG8gbWUgZ2l2ZW4gdGhlIHZlcnkgbmF0dXJlDQo+ID4gPiA+IG9mDQo+ID4g
PiA+IHVzZXIgc3BhY2UgcGFnZXMuDQo+ID4gPiANCj4gPiA+IFllYWgsIHRoZXJlIGlzIGEgbG90
IG9mIGhpc3RvcmljYWwgYmFnZ2FnZS4gRm9yIGV4YW1wbGUsIEZPTExfR0VUDQo+ID4gPiBzaG91
bGQgYmUgaW5hY2Nlc3NpYmxlIHRvIGtlcm5lbCBtb2R1bGVzIGNvbXBsZXRlbHkgYXQgb25lIHBv
aW50LA0KPiA+ID4gdG8gYmUgb25seSB1c2VkIGJ5IHNlbGVjdGVkIGNvcmUtbW0gcGllY2VzLg0K
PiA+IA0KPiA+IFllcy4gV2hlbiBJIGZpcnN0IG1hc3MtY29udmVydGVkIGNhbGwgc2l0ZXMgZnJv
bSBndXAgdG8gcHVwLCBJIGp1c3QNCj4gPiBwcmVzZXJ2ZWQgRk9MTF9HRVQgYmVoYXZpb3IgaW4g
b3JkZXIgdG8ga2VlcCBmcm9tIGNoYW5naW5nIHRvbyBtdWNoDQo+ID4gYXQNCj4gPiBvbmNlLiBC
dXQgSSBhZ3JlZSB0aGF0IHRoYXQgaXQgd291bGQgYmUgbmljZSB0byBtYWtlIEZPTExfR0VUIGFu
DQo+ID4gbW0gaW50ZXJuYWwtb25seSBmbGFnIGxpa2UgRk9MTF9QSU4uDQo+IA0KPiBWZXJ5IGds
YWQgeW91IGRpZCB0aGF0IHdvcmshIEFuZCB0b3RhbGx5IHVuZGVyc3RhbmRhYmxlIGFzIHRvIHlv
dQ0KPiBiZWluZw0KPiBjb25zZXJ2YXRpdmUgd2l0aCB0aGF0LCBidXQgSSB0aGluayB3ZSdyZSBh
dCBhIHBvaW50IHdoZXJlIHRoZXJlJ3MNCj4gbW9yZQ0KPiBhY2NlcHRhbmNlIG9mIGluY3JlbWVu
dGFsIGltcHJvdmVtZW50cyB0byBHVVAgYXMgYSB3aG9sZS4NCj4gDQo+IEkgaGF2ZSBhbm90aGVy
IHBhdGNoIHNlcmllcyBzYXZlZCB1cCBmb3IgX3lldCBtb3JlXyBjaGFuZ2VzIG9uIHRoaXMuDQo+
IEJ1dA0KPiBtaW5kZnVsIG9mIGNodXJuIEkgYW0gdHJ5aW5nIHRvIHNwYWNlIHRoZW0gb3V0Li4u
IHVudGlsIEphc29uIG51ZGdlcw0KPiBtZSBvZg0KPiBjb3Vyc2UgOikNCj4gDQo+ID4gDQo+ID4g
PiANCj4gPiA+IE1heWJlIHdlIHNob3VsZCBldmVuIGRpc2FsbG93IHBhc3NpbmcgaW4gRk9MTF9M
T05HVEVSTSBhcyBhIGZsYWcNCj4gPiA+IGFuZCBvbmx5IHByb3ZpZGUgZnVuY3Rpb25zIGxpa2Ug
cGluX3VzZXJfcGFnZXMoKSB2cy4NCj4gPiA+IHBpbl91c2VyX3BhZ2VzX2xvbmd0ZXJtKCkuIFRo
ZW4sIGRpc2N1c3Npb25zIGFib3V0IGNvbmRpdGlvbmFsDQo+ID4gPiBmbGFnLXNldHRpbmcgYXJl
IG5vIG1vcmUgOikNCj4gPiA+IA0KPiA+ID4gLi4uIG9yIGV2ZW4gdXNlIHBpbl91c2VyX3BhZ2Vz
X3Nob3J0dGVybSgpIHZzLiBwaW5fdXNlcl9wYWdlcygpDQo+ID4gPiAuLi4gdG8gbWFrZSB0aGUg
ZGVmYXVsdCBiZSBsb25ndGVybS4NCj4gPiA+IA0KPiA+IA0KPiA+IFllcywgaXQgaXMgdHJ1ZSB0
aGF0IGhhdmluZyBtb3N0IGd1cCBmbGFncyBiZSBpbnRlcm5hbCB0byBtbSBkb2VzDQo+ID4gdGVu
ZA0KPiA+IHRvIGF2b2lkIHNvbWUgYnVncy4gQnV0IGl0J3MgYWxzbyBhIGxvdCBvZiBjaHVybi4g
SSdtIHN0aWxsIG9uIHRoZQ0KPiA+IGZlbmNlDQo+ID4gYXMgdG8gd2hldGhlciBpdCdzIHJlYWxs
eSBhIGdvb2QgbW92ZSB0byBkbyB0aGlzIGZvciBGT0xMX0xPTkdURVJNDQo+ID4gb3INCj4gPiBu
b3QuIEJ1dCBpdCdzIHJlYWxseSBlYXN5IHRvIHB1c2ggbWUgb2ZmIG9mIGZlbmNlcy4gOikNCj4g
DQo+ICpudWRnZSogOykNCj4gDQo+ID4gDQo+ID4gdGhhbmtzLA0KPiA+IC0tDQo+ID4gSm9obiBI
dWJiYXJkDQo+ID4gTlZJRElBDQo+ID4gDQo+IA0KPiBMb29raW5nIGF0IG5vbi1mYXN0LCBub24t
Rk9MTF9MT05HVEVSTSBQVVAgY2FsbGVycyAoZm9yZ2l2ZSBtZSBpZiBJDQo+IG1pc3NlZCBhbnkp
Oi0NCj4gDQo+IC0gcGluX3VzZXJfcGFnZXNfcmVtb3RlKCkgaW4gcHJvY2Vzc192bV9yd19zaW5n
bGVfdmVjKCkgZm9yIHRoZQ0KPiAgIHByb2Nlc3Nfdm1fYWNjZXNzIGZ1bmN0aW9uYWxpdHkuDQo+
IA0KPiAtIHBpbl91c2VyX3BhZ2VzX3JlbW90ZSgpIGluIHVzZXJfZXZlbnRfZW5hYmxlcl93cml0
ZSgpIGluDQo+ICAga2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50c191c2VyLmMuDQo+IA0KPiAtIHBp
bl91c2VyX3BhZ2VzX3VubG9ja2VkKCkgaW4gaXZ0dl91ZG1hX3NldHVwKCkgaW4NCj4gICBkcml2
ZXJzL21lZGlhL3BjaS9pdnR2L2l2dHYtdWRtYS5jIGFuZCBpdnR2X3l1dl9wcmVwX3VzZXJfZG1h
KCkgaW4NCj4gaXZ0di15dXYuYy4NCj4gDQo+IEFuZCBub25lIHRoYXQgYWN0dWFsbHkgZGlyZWN0
bHkgaW52b2tlIFBVUCB3aXRob3V0IEZPTExfTE9HTlRFUk0uLi4NCj4gVGhhdA0KPiBzdWdnZXN0
cyB0aGF0IHdlIGNvdWxkIHNpbXBseSBkaXNhbGxvdyBub24tRk9MTF9MT05HVEVSTSBub24tZmFz
dCBQVVANCj4gY2FsbHMNCj4gYWx0b2dldGhlciBhbmQgbW92ZSB0byBwaW5fdXNlcl9wYWdlc19s
b25ndGVybSgpIFtJJ20gaGFwcHkgdG8gd3JpdGUNCj4gYQ0KPiBwYXRjaCBzZXJpZXMgZG9pbmcg
dGhpc10uDQo+IA0KPiBUaGUgaXZ0diBjYWxsZXJzIGxvb2sgbGlrZSB0aGV5IHJlYWxseSBhY3R1
YWxseSB3YW50IEZPTExfTE9OR1RFUk0NCj4gdW5sZXNzDQo+IEknbSBtaXNzaW5nIHNvbWV0aGlu
ZyBzbyB3ZSBzaG91bGQgcHJvYmFibHkgY2hhbmdlIHRoYXQgdG9vPw0KPiANCj4gSSBoYXZlbid0
IHN1cnZleWVkIHRoZSBmYXN0IHZlcnNpb25zLCBidXQgSSB0aGluayBkZWZhdWx0aW5nIHRvDQo+
IEZPTExfTE9OR1RFUk0gb24gdGhlbSBhbHNvIG1ha2VzIHNlbnNlLg0KDQo=
