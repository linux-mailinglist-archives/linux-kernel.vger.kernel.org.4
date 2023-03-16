Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8E6BC60C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCPGTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:19:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D2211167;
        Wed, 15 Mar 2023 23:19:23 -0700 (PDT)
X-UUID: 7d15b84ec3c211ed91027fb02e0f1d65-20230316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LXS9e0JQ08DSTJIOGCsZYj55CpDVowa30+10lg1reIE=;
        b=XKElfdPSgHM04PiGgJ2tC1bqIFpwXYAmVTv5sEDmniG5seyPCuwsoKiae98+SXuAOMMwT7sH81go/dYpqzRpNU4oMwf+/SF6ZUsDPpZu0ha6PcU5dt3lg1BjrM3MnyLZKMN+Rlm/9n/JOgpemLfG/z7dNzNumauoPv/XfNQg+f4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:8aa4aff8-3707-4f34-b170-318172e9aca3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:f6a98a28-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 7d15b84ec3c211ed91027fb02e0f1d65-20230316
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 953079201; Thu, 16 Mar 2023 14:19:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 16 Mar 2023 14:19:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 16 Mar 2023 14:19:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1rfqlovsF3B2WVGP4HNX99zN1JtTr8X+owVXFhNlx/W7aPphAAgg3LH9af54et+cradsYVK68wkdIy6xWV749eD6d/517hPbx+lGnyYnAhnFaANO9LDjfVslmE4qHCXV2+lTMC8Rw68eYRoq1YnNO1gAsUkWTOi59mGkoJztvtaqL77brMTHE+949sDHFdv1p0h46g0g7ubewirvyBHxJpuj7F7LiVkog+tqzgQi+by1slmqqaM6KyFGtsAHH7y85z3M7IW+dAAntKjEqMBwZVIPoA+JELaClPsqCUI+Ye3RxETMyPbvYnzRHrMKBUgkIi/ThmNaiLGjd0i+LZqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXS9e0JQ08DSTJIOGCsZYj55CpDVowa30+10lg1reIE=;
 b=SoBQpZAn1/n6H9dal3slJ1Dsy21AuQWLgDxMDxjcYxm5mEz5D7rxMSdxn5xUU60Pr0zTaVoEZM6CUx8by2jdSjpZ69yTmsoNqGjGeZk2tlm4Fpzl7PavV7D8gVdzueJDqL3LH9igvIXSnOtzUiI+U9BV13raTJ/9VT4Tz//xVWIuIpgO0TJhpLKiHAUBLtNXkCeJ8jdIoy1Sbdf/E+5QzFOD21b8MKiMKa0J8u9K035csT/HpMi8aVt/pj/GeUhhNj9scebn4Pir65tE6awiudUdcGqApj0l0X82Es2+faslWVQ0Bt6kyjmiSwmc7a48RTcEP/cf+F5/DTo06a4gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXS9e0JQ08DSTJIOGCsZYj55CpDVowa30+10lg1reIE=;
 b=mP05UjI/wwMHCYVy16DlbIutnMU+Iw+M9v+pW6ybBdvEtA/FLZBGbW3ofFLxhmSoaE5+r1Au0TaG3OeolPgwq6EEQnzhDgK6QuO3979eLI7u0I5BWlv0NjaTFftI0dC/HhTmTplaKifj0dFzIrOCtqxA5v7laIvbXUCDJfkqqMg=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 06:19:17 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65%4]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 06:19:16 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Topic: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Index: AQHZGcrXQb/1V2Icz0ST2hH4Pb2de677rZiAgAA66wCAAYJcAA==
Date:   Thu, 16 Mar 2023 06:19:15 +0000
Message-ID: <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
References: <20221227081011.6426-1-nancy.lin@mediatek.com>
         <20221227081011.6426-2-nancy.lin@mediatek.com>
         <4aff6a7a3b606f26ec793192d9c75774276935e0.camel@mediatek.com>
         <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
In-Reply-To: <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|TYZPR03MB5566:EE_
x-ms-office365-filtering-correlation-id: ec3c1c21-6084-4cb5-b0ca-08db25e65e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kH6xdwiGc55gwjFyetwUM4wHvnrCZ4JWFyDqxZsaN8iaee5HMMr5BtU8a+tYWyvIKYRmmqa9ZLIznKEgOj5ISwtgRhIYQg3Z1eWM0svXdhlIJMqjRPKki2mS9cD5k0GUH6lp3Kvcn9mCW5oGrr0Zm50qJSdLXuodvJL2jB1tWWojvxrP09dgKI0pFxt6NprZe/f+LrR2Wr5/haHPraPYkfg3SnliiTlPMxWIKi55sBhFIdkOK6VZbxIuIOqwVbF2QyFZJmvWOvsX1dkYNfiEaziKLtJ4scqUn4ncqNT8mmF+PhGc5YPBV3lglhuC8PBMNQOu/p2sM0V4r4tZTv02P8zvPtPiDqjaHRovxUKumXhuNhX0QeC61Gw3lSlsGto8sM/EKL9UaTmoRtkYV+9qXulUbyQqQE+PVsrOZvrr+njpRVOfnpc3W6Pl1C8YhcHj+wUZonBxODLzlEQqVouxu6mn/UWdGpSYd0spm+VKiAKZ2hvUq0TeRVxm0rQsgn2hKb5Rp1oFdReqAYx0jxlWZZ94P0YJGNDqjXwbMJHNSos6FCHz8bSCdOAjeM2mqx85arjhUdXHCfnFldPmtvmuPlI9fZc7iv4/KuRKgF2KQGpuRXm7XE+tpJtGV15EQ6NsCl0VigK/g0dyi8OMID6J5FzrY7nXYJYW/eMxTIRSM42RaHlqGxGLOoAYsy0ylNuGpn7BwPlq9z+TpUjc9pmB4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(38070700005)(86362001)(85182001)(36756003)(38100700002)(122000001)(2906002)(7416002)(5660300002)(41300700001)(8936002)(4326008)(2616005)(26005)(6506007)(186003)(53546011)(6512007)(83380400001)(316002)(54906003)(110136005)(8676002)(66946007)(66446008)(66476007)(64756008)(66556008)(91956017)(76116006)(6486002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnhxM1BCdzdSTlFoNlVvNXNBVTdJaVdSUmpXdzBRRDh3OVhYZFluaEZ4R051?=
 =?utf-8?B?RVZUVHRQQjhvOG1MS2hnZ1M4VWFqUGVoQXoyMmhIZk5xVFJFcEY0Q2ROeUtv?=
 =?utf-8?B?VUFBRmFMSzErZjlTVTJiUVJaald4RzJKNlVxOTRLeFVHNDRUSWljNTlTOGxw?=
 =?utf-8?B?aWZPdkYxVWNBdjAvRWF5cTBtT0ZKLzRUYzlnMXg3YkFOVWVEdForYlVya0JJ?=
 =?utf-8?B?ckYyRFoxL28rMm4vUE1wSkcxdnorM20xMTlLVitIOU9hZVZFWThKVE01Yzho?=
 =?utf-8?B?bEVkdmF3d01yeHVZUStLR0VsL3U0empScEsyTm5qc1U3ck9lS0NCaU9Lek1s?=
 =?utf-8?B?dmNXWUV5SzRickZndUE2SlZjdjd4eFZFTXFrMUl2Q3NBS01adEwrWHowcUxK?=
 =?utf-8?B?b29MV0cxbkt5ZC9OODl5UHB6bWQxWWFwaXVaa2htcHVzS21XWHFkL3JoQXNR?=
 =?utf-8?B?dkJIUVFlZWJpYWhNNmpyNmxDMEFuRG9iZnZoMUFXNUdaRG1reS9uVjJoenZN?=
 =?utf-8?B?TFcyc0VCcmtFNG85L1ZwdWlRMmFQSHYzZm5OZXN4cUhxQjkwUk9kTW5DVFd6?=
 =?utf-8?B?bVZjMThMbGxYS3ZmbFVWTDhjN2I1Z0Q3Rzg1SzRkNVVqRU00TE5NZWFPcTlH?=
 =?utf-8?B?RVBLNmp4QXppbHJuOTNHMXlqVFNQdk93b2ZuUTYyb3lacitWVmt5RE9GWk5U?=
 =?utf-8?B?WmJ0UlZaQ3BPUnlmSmNjaDRXREhXbDJLNmFzNHNTdHZhQk5QMnpjUDJQTTlU?=
 =?utf-8?B?KzhOaG1VcitmcU9nRUZra05rVnd1WTdoaU92ejJyZmFJYXBtWUtrYmV1UG5B?=
 =?utf-8?B?N2pGWGN5cTJEQWpMV0MreG1QUUk2ZkJIYTNiK1BGaHhGZVBVZ0pvdFZndE56?=
 =?utf-8?B?aHF6cFh1U25CdVg3ejU2WnR5cC81TTNaSnNteU1mTG1HY1ZsQm84U294R1N4?=
 =?utf-8?B?L2lBRWpGdWd6VmxxMklHc3hUMmZQVDVZakZBanFFeHlpeHpIYXFPVXRsUGtY?=
 =?utf-8?B?eVNGWWtTaC9CNlVrTGZ3YnF0R2lpb3pRMkNkekRZWm5nM09TUHl2QU5wT1Nq?=
 =?utf-8?B?NXRaMzJKMVZGNlM0bXJBVm5mOFc1UisrOVBwSkNBT3JnRUZreEhYS096bnM3?=
 =?utf-8?B?aTB5OVM5TE14MkdCdHZXa3N1a0lVUkNZc2xJUHpSQ2xmS3R4dHpnLzg5aDN2?=
 =?utf-8?B?RTJtN2h3MEwrTGJLYkwxMGh2Tk1HNWQvUGFPcEdGbGQ2MWtxNEFVR1FUdUhV?=
 =?utf-8?B?Z2dMc0krWVV6bWFyNjFRUlhoUnpEY3N4NkRGM0ZhYmhqZkJSVVVEUlhMOUpG?=
 =?utf-8?B?WFduYlFxRUxTYjdXUmFlMHY3YnVnVEgwbVpCN1lDQldWb3Y0RWNHb0RZNk5o?=
 =?utf-8?B?MGJ3djdXUjI5TWxUaUYrZklSdGpNOUl5Z1dmK2dLVGJMUUpsMjdGSzFxWkIy?=
 =?utf-8?B?bjBuS0xrMk93R1ZWb2JUMGlyNTdlaGE3Y09QNkNoK2YxYWIwelRYSGVIMzhP?=
 =?utf-8?B?aTYzbDlGeEx3N2JiQ1I5SFVNd0p6T004Mm5WMzVCakkyemNCZjN2b2ZyZy8r?=
 =?utf-8?B?VGk1V2swUGR0djJGdy9CTjFmckExT25icEpoU1VzYWR5bm1ZVlZzRWRMWWtz?=
 =?utf-8?B?QUFvNG9oZjQ0UjhJd0NFYkZDRFdxaFJQZWpzUEQ0SXJsUi9nV0NuNmIxd0JG?=
 =?utf-8?B?Q0FaM1IxeFFoejF1WDc1ajZIang1Zzh0SllMTGZSYnVNTFVOREhKbW9zaVRN?=
 =?utf-8?B?eG5aRlJzYWNRZFQ1WDMxMXBvZVdPZDlJN2VLLzBQcEVvRFZIVWc0aUN2TFVD?=
 =?utf-8?B?cTNtOGk2bVNnaVFsQTNJWi9BRXFscHZLaHdvWHByOW44cDdhMDY0RGwyejFu?=
 =?utf-8?B?a2FDcUsvaXIzVG1leTFCSVBIRWpROG05dmkyRE1YcURFa2VMdEtUaXFvN1ho?=
 =?utf-8?B?ZFc5U01NWmVSMkFMSVc5eVBkQ0NqQkdoa1ZZZmZLOUpaYVdjdTRsUHBUMVZn?=
 =?utf-8?B?dVhxemVPT09JdGZJM1FEbkZ5RElOVDlrb1VwanZBSFo5cjZVcmRtYWNOaWJS?=
 =?utf-8?B?S2xkWWhObmpqVStYS3laaFl0MDBlMERvbXh3VVpTa29qV2JMeXhmMVpzenJK?=
 =?utf-8?B?THJoSkhKbEphaEJEOTdMNHRSWFJaTURKZVc5Sy90UGdSOUtOOTkxcGJTOU40?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A0969E01705314991BAA273848ED353@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3c1c21-6084-4cb5-b0ca-08db25e65e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 06:19:15.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1zsFrXj1YIF5XS0RtDPJg8o5hORGycwcBoxkT7TbHd6EpD7Gk6slZ6FHNWwxUf9/0PgvatBAQWPaxsSqGjJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTE1IGF0IDA4OjE2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNS8wMy8yMDIzIDA0OjQ1LCBOYW5jeSBMaW4gKOael+aso+ieoikgd3JvdGU6
DQo+IA0KPiBUcmltIHRoZSByZXBsaWVzIGFuZCByZW1vdmUgdW5uZWVkZWQgY29udGV4dC4gWW91
IHdhbnQgdG8gZ2V0IHRoZQ0KPiBhdHRlbnRpb24gb2Ygb3RoZXIgcGVvcGxlLCBub3QgZm9yY2Ug
dGhlbSB0byByZWFkIGVudGlyZSBlbWFpbC4NCj4gDQo+ID4gPiArICBtZWRpYXRlayxnY2UtY2xp
ZW50LXJlZzo+PiArICAgICRyZWY6DQo+ID4gPiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9waGFuZGxlLWFycmF5DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcmVnaXN0ZXIg
b2YgZGlzcGxheSBmdW5jdGlvbiBibG9jayB0byBiZQ0KPiA+ID4gc2V0IGJ5DQo+ID4gPiBnY2Uu
DQo+ID4gPiArICAgICAgVGhlcmUgYXJlIDQgYXJndW1lbnRzIGluIHRoaXMgcHJvcGVydHksIGdj
ZSBub2RlLCBzdWJzeXMNCj4gPiA+IGlkLA0KPiA+ID4gb2Zmc2V0IGFuZA0KPiA+ID4gKyAgICAg
IHJlZ2lzdGVyIHNpemUuIFRoZSBzdWJzeXMgaWQgaXMgZGVmaW5lZCBpbiB0aGUgZ2NlIGhlYWRl
cg0KPiA+ID4gb2YNCj4gPiA+IGVhY2ggY2hpcHMNCj4gPiA+ICsgICAgICBpbmNsdWRlL2R0LWJp
bmRpbmdzL2djZS88Y2hpcD4tZ2NlLmgsIG1hcHBpbmcgdG8gdGhlDQo+ID4gPiByZWdpc3Rlcg0K
PiA+ID4gb2YgZGlzcGxheQ0KPiA+ID4gKyAgICAgIGZ1bmN0aW9uIGJsb2NrLg0KPiA+ID4gKyAg
ICBpdGVtczoNCj4gPiA+ICsgICAgICBpdGVtczoNCj4gPiA+ICsgICAgICAgIC0gZGVzY3JpcHRp
b246IHBoYW5kbGUgb2YgR0NFDQo+ID4gPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBHQ0Ugc3Vi
c3lzIGlkDQo+ID4gPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiByZWdpc3RlciBvZmZzZXQNCj4g
PiA+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVyIHNpemUNCj4gPiA+ICsgICAgbWlu
SXRlbXM6IDcNCj4gPiA+ICsgICAgbWF4SXRlbXM6IDcNCj4gPiA+ICsNCj4gPiANCj4gPiBIaSBS
b2IgYW5kIGtyenlzenRvZiwNCj4gPiANCj4gPiBJIGdvdCB0aGUgdHdvIG1lc3NhZ2VzIHdoZW4g
cnVubmluZyBkdF9iaW5kaW5nX2NoZWNrIFsxXS4gVGhpcw0KPiA+IGJpbmRpbmcNCj4gPiBwYXRj
aCB3YXMgc2VudCBwcmV2aW91c2x5IGluIFsyXS4gDQo+ID4gDQo+ID4gSWYgSSByZW1vdmUgdGhl
IGZvbGxvd2luZyBpdGVtcy9taW5JdGVtcy9tYXhJdGVtcyBpbiB0aGUNCj4gPiBtZWRpYXRlayxn
Y2UtDQo+ID4gY2xpZW50IHByb3BlcnR5LCB0aGUgdHdvIG1lc3NhZ2UgZGlzYXBwZWFyLiBJIGRv
bid0IGtub3cgd2hhdCdzDQo+ID4gd3JvbmcNCj4gPiB3aXRoIHRoZSBvcmlnaW5hbCBzeW50YXgu
IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBmb3IgdGhpcz8NCj4gPiANCj4gPiAtICAgIGl0
ZW1zOg0KPiA+IC0gICAgICBpdGVtczoNCj4gPiAtICAgICAgICAtIGRlc2NyaXB0aW9uOiBwaGFu
ZGxlIG9mIEdDRQ0KPiA+IC0gICAgICAgIC0gZGVzY3JpcHRpb246IEdDRSBzdWJzeXMgaWQNCj4g
PiAtICAgICAgICAtIGRlc2NyaXB0aW9uOiByZWdpc3RlciBvZmZzZXQNCj4gPiAtICAgICAgICAt
IGRlc2NyaXB0aW9uOiByZWdpc3RlciBzaXplDQo+ID4gLSAgICBtaW5JdGVtczogNw0KPiA+IC0g
ICAgbWF4SXRlbXM6IDcNCj4gPiANCj4gPiANCj4gPiBbMV0uDQo+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZXRoZHIuZQ0KPiA+
IHhhbXANCj4gPiBsZS5kdGINCj4gPiAvcHJvai9tdGsxOTM0Ny9jcm9zL3NyYy90aGlyZF9wYXJ0
eS9rZXJuZWwvdjUuMTAvRG9jdW1lbnRhdGlvbi9kZXZpDQo+ID4gY2V0cg0KPiA+IGVlL2JpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZXRoZHIuZXhhbXBsZS5kdGI6IA0KPiA+IGhk
ci1lbmdpbmVAMWMxMTQwMDA6IG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnOjA6IFs0Mjk0OTY3Mjk1
LCA3LA0KPiA+IDE2Mzg0LA0KPiA+IDQwOTYsIDQyOTQ5NjcyOTUsIDcsIDIwNDgwLCA0MDk2LCA0
Mjk0OTY3Mjk1LCA3LCAyODY3MiwgNDA5NiwNCj4gPiA0Mjk0OTY3Mjk1LCA3LCAzNjg2NCwgNDA5
NiwgNDI5NDk2NzI5NSwgNywgNDA5NjAsIDQwOTYsIDQyOTQ5NjcyOTUsDQo+ID4gNywNCj4gPiA0
NTA1NiwgNDA5NiwgNDI5NDk2NzI5NSwgNywgNDkxNTIsIDQwOTZdIGlzIHRvbyBsb25nDQo+ID4g
ICAgICAgICBGcm9tIHNjaGVtYToNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBrbm93biBpc3N1ZSB3
aXRoIHBoYW5kbGVzIHdpdGggdmFyaWFibGUgbnVtYmVyIG9mDQo+IGFyZ3VtZW50cy4gRWl0aGVy
IHdlIGFkZCBpdCB0byB0aGUgZXhjZXB0aW9ucyBvciBqdXN0IGRlZmluZSBpdCBpbg0KPiByZWR1
Y2VkIHdheSBsaWtlIGluIG90aGVyIGNhc2VzIC0gb25seSBtYXhJdGVtczogMSB3aXRob3V0IGRl
c2NyaWJpbmcNCj4gaXRlbXMuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0KDQpIaSBLcnp5c3p0b2YsDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQoNCkJ1dCBJIGhh
dmUgc2V2ZXJhbCBpdGVtcyBmb3IgdGhpcyB2ZW5kb3IgcHJvcGVydHkgaW4gdGhlIGJpbmRpbmcN
CmV4YW1wbGUuDQpDYW4gSSByZW1vdmUgbWF4SXRlbXM/IENoYW5nZSB0aGUgbWVkaWF0ZWssZ2Nl
LWNsaWVudC1yZWcgYXMgWzFdLg0KDQpbMV0NCiAgbWVkaWF0ZWssZ2NlLWNsaWVudC1yZWc6DQog
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0K
ICAgIGRlc2NyaXB0aW9uOiBUaGUgcmVnaXN0ZXIgb2YgZGlzcGxheSBmdW5jdGlvbiBibG9jayB0
byBiZSBzZXQgYnkNCmdjZS4NCiAgICAgIFRoZXJlIGFyZSA0IGFyZ3VtZW50cyBpbiB0aGlzIHBy
b3BlcnR5LCBnY2Ugbm9kZSwgc3Vic3lzIGlkLA0Kb2Zmc2V0IGFuZA0KICAgICAgcmVnaXN0ZXIg
c2l6ZS4gVGhlIHN1YnN5cyBpZCBpcyBkZWZpbmVkIGluIHRoZSBnY2UgaGVhZGVyIG9mIGVhY2gN
CmNoaXBzDQogICAgICBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS88Y2hpcD4tZ2NlLmgsIG1hcHBp
bmcgdG8gdGhlIHJlZ2lzdGVyIG9mDQpkaXNwbGF5DQogICAgICBmdW5jdGlvbiBibG9jay4NCg0K
UmVnYXJkcywNCk5hbmN5DQoNCj4gDQo=
