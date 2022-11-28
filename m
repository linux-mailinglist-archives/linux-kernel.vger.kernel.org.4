Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02163A642
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiK1Kiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiK1Kit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:38:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C595A5;
        Mon, 28 Nov 2022 02:38:39 -0800 (PST)
X-UUID: ebda6f3f7a6f403fb713ad3a17119e76-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4x5KARFL5Ioic4BvfiKPRtbCJ9A+L8kq4BtIz3ymyC0=;
        b=WPGOJEgyhAGffTkFiauFWPCQvMCN3m47dpk2FswCfSX+ECKfuJ10R9xxSr7wLierKeOoM6dZwd04VFpMC/LXk6PgcQcLygoScCM129a9wyNt+2VlbnbpLej6zWL3hZZaFpeA8Eg2BwV1yGQx0l1oSDRPWS87wLuh4Lqgc8x4n88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fed12a8f-3af7-4c13-87dd-bd3be3850166,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:fed12a8f-3af7-4c13-87dd-bd3be3850166,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:ed496e17-81a9-4b5f-95c6-b6b92590fd73,B
        ulkID:221128183835M01ZMAH2,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ebda6f3f7a6f403fb713ad3a17119e76-20221128
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1797613899; Mon, 28 Nov 2022 18:38:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 28 Nov 2022 18:38:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 28 Nov 2022 18:38:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzUTm6Ctkip+7SPsf/YqAdo2esW1puERWyZtOy8uxA3KsRMlct6Oa6C0Z1Cns91B5zCEiyV5f5XMIpuXm4z7NNyePb+6hPksIy1Ac0XkXqU1n1uvro87fKnABpCU0Z3E0WYKQGB9Fd5H8hwf5RPrFrC+lFJyPbOAvMnN10LoQCfVFGJWGpq/ALvfATIO/e+OLUeudtIfAE4kPe6uzftPDl9fYG//8SUyHZK9RF0DFa9TC9bUiksCnbR2rXnsdF/r/lM/J1iR3H1KaGSaAoqZGwFfu66XVx1xrN11LYf/JfsqghuuP0T7gZRlBlWYiL5pvCEfbOiiQ/782oZTJ6f4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x5KARFL5Ioic4BvfiKPRtbCJ9A+L8kq4BtIz3ymyC0=;
 b=GsBCv2b/2XnBgVQOTwV/ptPnprOktM+u7IJGXx7W3YNUO8LdSJwvrH35wa/ajI1cWwzIl/yTo6gfW4AErNU2afP6bUTVy3ifHRm9BV7v7bYwtWcvSft9tK8r8dXPxx4czReQO1IEQgBsJejLweFdiVkN0la2kkyAWZxuH0IYFeBSnIQNbKaFC3KnrQbGVxERSv8ZeBYShbHCOknduL62t9Et7U0Ui8dJ8LS/lLqU5vvqWzCYl3SbH9Xf+AnOp5es+XuUuRwGULKJuzviF1bsowZs3NviA0iGtf1CsnILlucTdvZe9ojXh03IyeF3wGQ8XACS/PGoMaXnWKTTmQTEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x5KARFL5Ioic4BvfiKPRtbCJ9A+L8kq4BtIz3ymyC0=;
 b=JCGIOO3XgIY1Y2yuTIX2SNtylh8rmgoamXpDvzrVCsAqOwYmk5xtb6u/Osjv3XHgC2Bql7Rlq1YV577hZTWM60q+YCVEnpzPjPw9J4nXsEQvuwq24XJOcZupuJqpLaGK65QHj+w+YsKEmxPGhWLgW6vdpud12zLGnpnGlxgISts=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 10:38:29 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b%5]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 10:38:28 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v28 6/7] drm/mediatek: add drm ovl_adaptor sub driver for
 MT8195
Thread-Topic: [PATCH v28 6/7] drm/mediatek: add drm ovl_adaptor sub driver for
 MT8195
Thread-Index: AQHY8noe0ACpayu3TU2NO8YH/C+9mK5QVEkAgAPx2gA=
Date:   Mon, 28 Nov 2022 10:38:27 +0000
Message-ID: <734e2bfa43db37519c9d90b48150e9696d9987df.camel@mediatek.com>
References: <20221107072413.16178-1-nancy.lin@mediatek.com>
         <20221107072413.16178-7-nancy.lin@mediatek.com>
         <20221125222402.u4qiolkqi2nsv7ae@notapiano>
In-Reply-To: <20221125222402.u4qiolkqi2nsv7ae@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|PSAPR03MB6236:EE_
x-ms-office365-filtering-correlation-id: cac74b43-1f34-4fb7-1951-08dad12caf7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8SKKEg3fSbYi6ByvoTmt667gitI7hZevGd5lhx/8m3VsUPhYGH/tlEflygAe+sLnz1pA2CyCmsXB4iI0fOpNpdcAD99RLK//k4gv2eLlvO6rTEpwoKyXJZN1N1PCMt1tVetPikns1FwwUtMojME6tfFOxv4X/H9Ngd3nB8JF5L1jc29BglUJ/DkzHR36UcnzxaS2yxyhbkP9Tr63hpiL89ZNt62qdNwxV5i3XqtuIt/XXd4trSOV5PzHKMY8ujL7MofyVrropSWz0i6Iv6JF+cIsIMigi+hoZIO/8a+R6wqqy1mrz/Oq0lT/39GstBNVgzicZwL2Z+0R3yZShyKl5E6/8U0pmwfXUOwRBrfUB07D5bvRHSY0NmN2CKAVkgmwZ8FhvLtpvB4q+R49Q+G2GHrLe8I4q3uMoHUeX0ditmJy0cUUmqTsXTIs69Iwte0lrkVRpBYW6RT/h/sAFIDj+3SjPJ+AYOfcT+hn56jSaJnhXnR5DjyjyC1aI9WPPCrA0BUJtCI+GCuvYjSFfkp3NO7dqHfzi4CNKg0LRE74eSJcSozNvFigs6Kk/LCZd4Y+k/7suc+mU7NWcQzBAOthkplqQuSACzAoPp0Wgq545wKryUJEFo2vMveu9tmlyrUtTUnxdhvrkUrC2n4qUIf2xS8xD7LMd5dBdGSTwG2ryKdjuoLRha+IwaQKtFqo8PgPxYTtg+Po/+g+NxzuZHQIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(66574015)(5660300002)(7416002)(54906003)(6916009)(26005)(316002)(6512007)(2616005)(41300700001)(8936002)(186003)(36756003)(8676002)(66946007)(66476007)(66556008)(91956017)(76116006)(66446008)(4326008)(85182001)(64756008)(122000001)(38070700005)(38100700002)(2906002)(4001150100001)(83380400001)(86362001)(6506007)(6486002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHRqT1ptaVo0YWhBMzBtdXdCUFl1WDNtTmtLV3hCOGJ2TUVhbVVraVRnT3Vr?=
 =?utf-8?B?QjN6bkV0TzUwallnbDVBUVFjYXVNVnphNzZTVUdKNEtoV0x3U2d1OU56REhn?=
 =?utf-8?B?bnlMZStHNTI1L1ZkdjUyQ1FLdk91dmNyK3BHdUsvZEJkRWhHTVA0T0dlZ1pC?=
 =?utf-8?B?Z2FwS0R6SEl1Y1lkQTBXQk0rWE1vbk1XMHU3ZHcwdGdWQUcxUm9udFZBUy9X?=
 =?utf-8?B?UHFsa2Q2aHVYZkdtanNWVEVTU05jd2Rrbm52N3pFUjFzclloSUEyZ2QrTXN4?=
 =?utf-8?B?SlZuQW1tWm9EaWFnYi9EclVydndmME50ME1Qem56b2NicjdmaTA0aDM2Tzlu?=
 =?utf-8?B?SVUrT05xdTZnR1RQc3cveElCd1paM3d2K2JJWGVuRld3ZDJRMTJHTjRSZmR4?=
 =?utf-8?B?ZWN5SlMzbFhTZ2VMTDl3dXFnZC9ZTHFlS3d6cTV3SDd4Y01OVGVIenVuOWdF?=
 =?utf-8?B?M2pDZzZ5MUJ5WmkyZFdSTDBqUEs4c24zNDBic2NLWUp2RmNaVHdldUwxeTJk?=
 =?utf-8?B?dzJaVXpTS1RNVXNwOWJmbXd1aVpuTHpwVUNiaW1aNnczekxYMWJEN1Z3RWpY?=
 =?utf-8?B?d1ZKS1dzMXpMRldCcENoa3BuUGY0ZG80ZkRuUDBIMjgyWGRpdW5Pc1FXVE5s?=
 =?utf-8?B?NG9Helh5cEVaaHVDZVhsdy9MWjZodDRaYkFUaGF2MG1udVNCdkpEQUs1N2p6?=
 =?utf-8?B?T0hRSUZQWXJBY3lScC94SFRIVmQreEF6R2dpNmFLYzZTNlE1VVUxRk14Szds?=
 =?utf-8?B?T1RwSHUycHJ4QjZ0d0V6Z2Z1UnlhV05BVUFYQmRzeU0wUVpES1hYZ0pUbWx5?=
 =?utf-8?B?Z0xpUzhVdWY1clFpcFVRN0ZRSVJTeHg3SGpVWFB3ak5UMGRLM3RpbFFFUnNt?=
 =?utf-8?B?NVlyd2wrcXRtTUliaEtnMDhiK0V0ZVdBTmtUcjAzUGZDZ3o0RDlaRlFsZDZF?=
 =?utf-8?B?MmJZTUlvdm9pVzVqa1NFQWJocWpmT2htc2N5R1R0bXdoV3dybnRJekI1QkZw?=
 =?utf-8?B?eUo5OHNJMXQ4VitPN05iRVQ2UGZhQ080ak5LcytKQU9jbXBKaFg3dytMOVpl?=
 =?utf-8?B?WlAvczcxb2xBNEFpSDZRc09KNHVWNytZb1RlTDZqU0ZZYjY1dkU4TWVPN3p2?=
 =?utf-8?B?RG9zYlczcWx0VUpTWWxhcFVRdXJGWEV2VjhSZHVqMlpSZGM0Ym0xMndZc0pT?=
 =?utf-8?B?NTBWYTNtdGNyVzJUMklEMWhPeWMyY2JUYUFWSFEyazN3VU5DckNPSFVka1ZS?=
 =?utf-8?B?U205Tlk1ekQrMXptUXIyQy9aeEFuMERNUUFTZGdRblY3QnNYdjBFMkZKaFFs?=
 =?utf-8?B?aSsrOVhvZHRrZXhVU2wrN0RicHh0RzVybUMzNmJVZEkzSGF5bEE4Y2ZjaEMy?=
 =?utf-8?B?NStZdjJyYzFCcmJnZXlabHRIckdlZ1JXN1FSLzBLMnV2M2RUSzl0QWt3Vmdv?=
 =?utf-8?B?ejNDZkZ5TStvcm5RUGVid3FvU3dZb2VYN0RBMVE2Yi9VNi9mRDM4QndIWk1j?=
 =?utf-8?B?Ni9iVEVCeGtHaWxFZ0ZtaWozNzAyUHZqV3FFSUMzaVphUnliTkpPbjlrZEpK?=
 =?utf-8?B?WEVSSUFaa2pQMXZPdG9scmVNbzBxaEs4dTFPeFVoODZGT1JPVndNb3NIaFFq?=
 =?utf-8?B?cG8yKzAzcXJ5M3lhQVZBc1JhM1N6blJuaTIxZGFNQkpidDJvcGEveFJ3ZGo4?=
 =?utf-8?B?RU9kM0hUQXpodTJZVjhQNE5NMHlTSFdWbHpTYWx1RUp5TnNPQk1tOEJQVXVt?=
 =?utf-8?B?dlhIRXZuaFhjQWRxMWhjZjVlNVV3TUY1R0ZTR0hjN29jRG9aZ0E3a01kV2Nh?=
 =?utf-8?B?WTFSWDdnRzdjc0dvZFNSN2dLbFBRbVFLMWV2ZGFqK3REcDZGaXZSei94Zks2?=
 =?utf-8?B?UkNEU01iQmlOcnNUNGdMd0plN3ZBSjVKY29KQzlqaUpQMml2d1pBby84Yk9O?=
 =?utf-8?B?dXdrNlNPSXd0dWdTTlljYmtxVmozMHBrSHp2WUs3NjY0QXJjVFZXL0t6SmtI?=
 =?utf-8?B?dWxhamdVT2xIdFc2NFd3bFJlS3BKQ3FxcmVZTm9QVHpBRWRFaWJMb1FTWmNQ?=
 =?utf-8?B?cDQ2RUV3cklOMFY1MmM2d1Y0VVVxYXNsV3BvMUpkL3YweldjSCt3RUl2MC82?=
 =?utf-8?B?M2kwT0dkZUg3MGlyRFNvRUQ4VzluZVJuWkFUWGZUNlFRV01xeTRReldCbk9a?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <793753858348EE4AAC74F97EAE0FBC88@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac74b43-1f34-4fb7-1951-08dad12caf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 10:38:27.8699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcAb1ROoIl8t/utTyTJNCpI6D1CVm7+uXkBhWyNhAm6jZe5rCWv8D+K+0tYOZFeJ2XbvU8w7ovk89lCYK0hd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBOaWNvbGFzLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIEZyaSwgMjAyMi0x
MS0yNSBhdCAxNzoyNCAtMDUwMCwgTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+IE9u
IE1vbiwgTm92IDA3LCAyMDIyIGF0IDAzOjI0OjEyUE0gKzA4MDAsIE5hbmN5LkxpbiB3cm90ZToN
Cj4gPiBBZGQgZHJtIG92bF9hZGFwdG9yIHN1YiBkcml2ZXIuIEJyaW5nIHVwIG92bF9hZGFwdG9y
IHN1YiBkcml2ZXIgaWYNCj4gPiB0aGUgY29tcG9uZW50IGV4aXN0cyBpbiB0aGUgcGF0aC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiA+IFRlc3RlZC1ieTogQm8tQ2hlbiBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+
DQo+ID4gVGVzdGVkLWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxh
Ym9yYS5jb20+DQo+ID4gLS0tDQo+IA0KPiBbLi5dDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggMzBkY2I2NWQ4YTVhLi5jZTU2MTdhZDA0
Y2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
IA0KPiBbLi5dDQo+ID4gQEAgLTg5NywyMiArOTA2LDE4IEBAIGludCBtdGtfZHJtX2NydGNfY3Jl
YXRlKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4gKmRybV9kZXYsDQo+ID4gIAkJY3J0Y19pKys7DQo+
ID4gIA0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHBhdGhfbGVuOyBpKyspIHsNCj4gPiAtCQllbnVt
IG10a19kZHBfY29tcF9pZCBjb21wX2lkID0gcGF0aFtpXTsNCj4gPiArCQl1bnNpZ25lZCBpbnQg
Y29tcF9pZCA9IHBhdGhbaV07DQo+ID4gIAkJc3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KPiA+
IC0JCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXA7DQo+ID4gIA0KPiA+ICAJCW5vZGUgPSBwcml2
LT5jb21wX25vZGVbY29tcF9pZF07DQo+ID4gLQkJY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21w
X2lkXTsNCj4gPiAtDQo+ID4gLQkJaWYgKCFub2RlKSB7DQo+ID4gLQkJCWRldl9pbmZvKGRldiwN
Cj4gPiAtCQkJCSAiTm90IGNyZWF0aW5nIGNydGMgJWQgYmVjYXVzZQ0KPiA+IGNvbXBvbmVudCAl
ZCBpcyBkaXNhYmxlZCBvciBtaXNzaW5nXG4iLA0KPiA+IC0JCQkJIGNydGNfaSwgY29tcF9pZCk7
DQo+ID4gLQkJCXJldHVybiAwOw0KPiA+IC0JCX0NCj4gPiAgDQo+ID4gLQkJaWYgKCFjb21wLT5k
ZXYpIHsNCj4gPiAtCQkJZGV2X2VycihkZXYsICJDb21wb25lbnQgJXBPRiBub3QNCj4gPiBpbml0
aWFsaXplZFxuIiwgbm9kZSk7DQo+ID4gKwkJLyogTm90IGFsbCBkcm0gY29tcG9uZW50cyBoYXZl
IGEgRFRTIGRldmljZSBub2RlLCBzdWNoDQo+ID4gYXMgb3ZsX2FkYXB0b3IsDQo+ID4gKwkJICog
d2hpY2ggaXMgdGhlIGRybSBicmluZyB1cCBzdWIgZHJpdmVyDQo+ID4gKwkJICovDQo+ID4gKwkJ
aWYgKCFub2RlICYmIGNvbXBfaWQgIT0gRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IpDQo+
ID4gew0KPiA+ICsJCQlkZXZfZXJyKGRldiwNCj4gPiArCQkJCSJOb3QgY3JlYXRpbmcgY3J0YyAl
ZCBiZWNhdXNlIGNvbXBvbmVudA0KPiA+ICVkIGlzIGRpc2FibGVkLCBtaXNzaW5nIG9yIG5vdCBp
bml0aWFsaXplZFxuIiwNCj4gPiArCQkJCWNydGNfaSwgY29tcF9pZCk7DQo+ID4gIAkJCXJldHVy
biAtRU5PREVWOw0KPiANCj4gV2h5IGRvIHlvdSBjaGFuZ2UgdGhlIGJlaGF2aW9yIGhlcmU/IElm
ICFub2RlLCB0aGUgcmV0dXJuIHNob3VsZCBiZQ0KPiAwLCBiZWNhdXNlDQo+IHRoZXJlIGFyZSB0
d28gc2VwYXJhdGUgZGF0YSBzdHJlYW1zLCBmb3IgaW50ZXJuYWwgYW5kIGV4dGVybmFsDQo+IGRp
c3BsYXksIGFuZCB0aGV5DQo+IGFyZSBvcHRpb25hbC4gSXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRv
IGZvciBleGFtcGxlIGhhdmUgdGhlIG5vZGVzIGZvcg0KPiBleHRlcm5hbA0KPiBkaXNwbGF5IGRp
c2FibGVkIGluIERUIGFuZCBzdGlsbCBoYXZlIHRoZSBkcml2ZXIgcHJvYmUgYW5kIGhhdmUgYQ0K
PiB3b3JraW5nDQo+IGludGVybmFsIGRpc3BsYXkuIEJ1dCB3aXRoIHRoaXMgY2hhbmdlIHlvdSdy
ZSBicmVha2luZyB0aGF0LiBBbHNvLA0KPiB0aGlzIG1lc3NhZ2UNCj4gc2hvdWxkIHN0YXkgYXMg
ZGV2X2luZm8gYW5kIG5vdCBtZW50aW9uICJub3QgaW5pdGlhbGl6ZWQiLCBzbw0KPiBiYXNpY2Fs
bHkgaXQNCj4gc2hvdWxkIHN0YXkgdGhlIHNhbWUgYXMgYmVmb3JlIHRoZSBjaGFuZ2UuDQo+IA0K
PiBUaGFua3MsDQo+IE7DrWNvbGFzDQoNClllcywgWW91IGFyZSByaWdodC4gVGhpcyBpcyBteSBt
aXN0YWtlLiBJIHNob3VsZCBub3QgY2hhbmdlIHRoaXMNCmJlaGF2aW9yLiBJIHdpbGwgZml4IGl0
IGFuZCBtb2RpZnkgYXMgZm9sbG93aW5nIGZvciB0aGUgb3ZsX2FkYXB0b3Igc3ViDQpkcml2ZXIg
Y29tcG9uZW50LCB3aGljaCBkb24ndCBoYXZlIGR0cyBkZXZpY2Ugbm9kZS4NCg0KQEAgLTkwNSw3
ICs5MTQsMTAgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCipk
cm1fZGV2LA0KICAgICAgICAgICAgICAgIG5vZGUgPSBwcml2LT5jb21wX25vZGVbY29tcF9pZF07
DQogICAgICAgICAgICAgICAgY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21wX2lkXTsNCg0KLSAg
ICAgICAgICAgICAgIGlmICghbm9kZSkgew0KKyAgICAgICAgICAgICAgIC8qIE5vdCBhbGwgZHJt
IGNvbXBvbmVudHMgaGF2ZSBhIERUUyBkZXZpY2Ugbm9kZSwgc3VjaA0KYXMgb3ZsX2FkYXB0b3Is
DQorICAgICAgICAgICAgICAgICogd2hpY2ggaXMgdGhlIGRybSBicmluZyB1cCBzdWIgZHJpdmVy
DQorICAgICAgICAgICAgICAgICovDQorICAgICAgICAgICAgICAgaWYgKCFub2RlICYmIGNvbXBf
aWQgIT0gRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IpDQp7DQogICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfaW5mbyhkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
Tm90IGNyZWF0aW5nIGNydGMgJWQgYmVjYXVzZQ0KY29tcG9uZW50ICVkIGlzIGRpc2FibGVkIG9y
IG1pc3NpbmdcbiIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcnRjX2ksIGNv
bXBfaWQpOw0KQEAgLTkzOCw3ICs5NTAsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1
Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCiAgICAgICAgfQ0KDQpSZWdhcmRzLA0KTmFuY3kNCg0K
