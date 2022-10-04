Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66F95F423C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJDLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJDLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:47:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85EA4A81F;
        Tue,  4 Oct 2022 04:47:05 -0700 (PDT)
X-UUID: b364bf984d65481e9cf5a45b66b868d6-20221004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SsAp3B5I5v7DSYFJohU8qpgIbXrEjzCJZlRAa+W6EK0=;
        b=hUMt06e8B4rCnu2dtpURI/D9FBTGZlZKebJ3/Yi8i2z8YPNTidU0CTHKG9cmoSroW2jrrgPkCuUfqiFwDdwFEd2jXisE52NspbdLv+OlOXVrDK82ZoMiKq3u/kxQBD38M6djxGgKV86hsMvmucWhm/YsHmFg+ecn29a98sq1nDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:824987e8-527b-427c-b738-5a54f3ee1390,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:4a03d569-c578-4abf-baf4-d93ecc5e701f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b364bf984d65481e9cf5a45b66b868d6-20221004
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 375633200; Tue, 04 Oct 2022 19:46:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 4 Oct 2022 19:46:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 4 Oct 2022 19:46:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwGuIPkEEL34t0hc4+P3JQvpms/iFFeteBxIw81Qg7UrOr0h716/1+Da2UuXEeifq8YE5EttpPqNGhzZJgg4MN/qR7K6t9R+mi3sOsw+r9K4Bk/2Oy6Qj/WTaDzRgolciqitXQT5e/0lnCqG+NWNICBrJUxuTrrTy617NBDx4Byu0kavzDF4JIkgFffBZvY1VQQkYibarRbdIpI75XAMgCPBNz+jlXToaQXCFNy2dHXvjY6lBfHBjkzlsjVl+tYoFj5lOPZ2EWz/X/P8j0OpySg6L7q495sDwKKr7LfRMvZ++oR9hj7/GmGOOy7DBkvfwVdBg1ZkPvQMFQMbh2svUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsAp3B5I5v7DSYFJohU8qpgIbXrEjzCJZlRAa+W6EK0=;
 b=VrwAZlrWn6Rpe3gxx9vdz79RGddUb4qq1U2vk/EugbHWD0lvIHBPggz6XPW0va5OC12ZMJQ2ct1bcNM+lmaB74cwxbsydvmwxUow/igXI0I0lBrk+P9YhHsnWs2Tlq6f2LTMgVZWgtdmLkNYp6nDDCO1qUiOgzMoPJsZmeFiUT8TWF33MOqEtDRys2G5N60jV9ASVZXfSvAUtjVVWgfBckCyLxwFKlN8l2nNLo0VDLnTyqFLCatmsEJ2SbE46C1J8G3TUP8Xn5+IOIq4Xx8labghDoes3mIkhJdQlAHrF+RPlwsE3WkWqxNFVF0BYBuC4qxb5UQxSKtU2tnjHRBWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsAp3B5I5v7DSYFJohU8qpgIbXrEjzCJZlRAa+W6EK0=;
 b=Q5KubMUcdQlwAHCYi587i3ZUpBl6yTvexda9Gq2GNrOX4Ql4nrqIQG3pxyWLt/DI2NV73ZVxtaLhUZK2DR6OxsV38wiBdxErx5LYdbEKyTFXTTL0gBenFyVc6N0nZtXPMxKfnfF/pUP6RnEh6+1Ny+S29UZ/n1beZ/adADmzEM0=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEYPR03MB6878.apcprd03.prod.outlook.com (2603:1096:101:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.7; Tue, 4 Oct
 2022 11:46:53 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Tue, 4 Oct 2022
 11:46:53 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Um95LUNXIFllaCAo6JGJ5Lit55GLKQ==?= 
        <Roy-CW.Yeh@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 2/6] dts: arm64: mt8195: add MMSYS and MUTEX
 configuration for VPPSYS
Thread-Topic: [PATCH v1 2/6] dts: arm64: mt8195: add MMSYS and MUTEX
 configuration for VPPSYS
Thread-Index: AQHY19SvPeka3yCnvE6Ks+f6jVJ+RK3+HlMA
Date:   Tue, 4 Oct 2022 11:46:53 +0000
Message-ID: <c80af435ec4fec9419c47a73c0bda112ef62c76d.camel@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
         <20221004093319.5069-3-moudy.ho@mediatek.com>
In-Reply-To: <20221004093319.5069-3-moudy.ho@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEYPR03MB6878:EE_
x-ms-office365-filtering-correlation-id: b2bea769-bea4-40ca-98cf-08daa5fe219e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZGIeemkisieFuISz02O+EBrt5qgLNhaWppfPwPQfe5MHkgBLXQcO1JSjTjhk9UoEr2sQRStpk6D+C/mrFcvS02sZ0rL3d3LNoXt4BP7+DfjjVi5O8iLggfjKKuuaf7bmQHqb7a8gwtYlRsmavkWhPT+gUxLVmiPTUX9i/Ok4XfxvKIKxu8/KTFZYRq43IhjYB/jEim6bqe+HYYjS/LaNWcbEiF/aF1YYEzZdEBTBo9sMv/y6X+EWnzR4UXcyowGPAh77hfpYfSbAucTtJu+avFPlkYGVZELF/1n5uokrpUXDCDw2cZw9r+zI5dopWDDTUZW4BwoxnhBrqMH4JHPaGSfPKO6886WIbqcqYusTnv/LqQ0eS0oyT6WFQx70TU2u6eQxrenbbWH+q5EsuzFFliYsrA/AbaQWK5PYFrUWSb5gi47h0/Yf5wf02rNyWYavmN5uOBnlnY5lUYMzsXZ39+n+H6l6gXsmKvDiAhjV1y5dOJhKswNmlmFetCpmvR2+dV+s4k0uSx18VQVjPifpSa6PXFXMnNzyPry3n+rGfBxRsnKL2MpyiGJJrZy702zU9bfF505+1hgnlDvoYnhKPw60bHejZMhLZgcjxzn5BOHdi3N9t69x2T4Tk6a3aUpQ9FOqF5iryMnrzJ0eQ4v4Tfoq9ZLxYb3R2G1tWxuYpdQxcYGtVi6Pl3OGUp1kFPr0D9BGsXq+RmbJ6OAlIFReZD8+BDAhCwypveb4K9d194EDvM0noNghGKf4L40Ky2uqEQ6pa80DOWOPBE5L+Bg1unBsOKlrJo+tGbOUWLJuOLxnCeFvpX5HlI7cscLw30Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(2906002)(36756003)(54906003)(316002)(8676002)(41300700001)(5660300002)(64756008)(66446008)(66556008)(86362001)(66476007)(107886003)(76116006)(4326008)(66946007)(6486002)(478600001)(85182001)(71200400001)(110136005)(8936002)(83380400001)(2616005)(26005)(6506007)(6512007)(38070700005)(38100700002)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czRKZk92RHJjNDY3eTBPbkhSMGMxT2kzcFE0ajd6UUZtV3JsWXdVa1Y5M0ww?=
 =?utf-8?B?bjQ2VVJXNUFvNWZsUWNvaHhHOVFoVTkrYzJBN0ptS2VBQk9aWVJWajh5RE9O?=
 =?utf-8?B?UkxNMGVTUkY2YTVEelIwQmZueEw1VS9nU0xtekVPYWw4UWhTWTdWaG5PL0E4?=
 =?utf-8?B?d0NJOHUvTUZsUEtPTE5BeTg3N1FUeEdRVnozdVVYZUVLRE1BTEhmZGdhRUg0?=
 =?utf-8?B?a0ZOWFJsN0FrQ21YUHRmUVFSWm1zWnhOUGppZWFoQVRNakVRWmJYTTVSSFpy?=
 =?utf-8?B?ZjVycmZ6WTdQQnlQTCtWUEh5bDd4QVpVNnVvNWtEcjNLV01zeFEyU2UyVkJh?=
 =?utf-8?B?Y2JTa1FMQzRVK29zTXZSQ0FmTSt1amJ2b2xhYzhSbVdpMm1WdnhidkhtMnZ3?=
 =?utf-8?B?NUNLdU1OdVY3UFQ5WWpVc1VlL1RmSmFZclRTdW1keUxydDhsZ0RISk4rekRO?=
 =?utf-8?B?K1VWMFphbjJERTlRSjJjcnRhSzgrN3kyc3RTUlh2TXJmRmN3L1RoenJRZklM?=
 =?utf-8?B?VEpwT3gwWHBEYWlPRXJmRGwwSkhFaU1wTXVOaERnTWVIaXMwZGhTZGsvYmgr?=
 =?utf-8?B?RVBlS05HRlFDdThRanpwcWRPSENqcjUwSC9KdEU2QzVDZWVKRTNDTjFFWU9H?=
 =?utf-8?B?M0lJbHlJVGVRVTlEZXpmM3RhOVNtVUVpL2ZDbG5Qd3VRbkhDTzBkZFpUQ2t0?=
 =?utf-8?B?Y2FPWkpNTGVKMGo5cjIzRTAwc2RiSkY4WUtpSDQ5TlFDaUpPN0NBTHUwNUZa?=
 =?utf-8?B?bnJwam1BQWRsTlVOSUZsbzlvVTI5eXdtRUErY0laWUxRTW9MV1lrbmpPa0k3?=
 =?utf-8?B?WVU0bDEraFBTTlFHKzh1V3BnREpTc0lic1p0QUFCcTFwREVNYzd5dkVLU2px?=
 =?utf-8?B?K3ZyZ2s1ejQ1QWFhMjZIZEovK2VDanJzME9HWW5LWXhVUXA2ajlUOE50Z0tJ?=
 =?utf-8?B?YTdDMW95VE1qc3g3ZlNnMVl1WFVQVExuaXhLMGZjWkgxU3VhakZRMnNxamZU?=
 =?utf-8?B?QWRrTmxJN1pSOTdQK0MzQXpjbGZDVVdkZWNqYjkyV3drWUloSkxBblBhY0Fr?=
 =?utf-8?B?QnpTMFNOVFBtV1RzaGlkbmZEZ05iVmU2UE4vRjZKL2VFN3Y1alJRM3VlclFh?=
 =?utf-8?B?RGE2bGRJbzhzWjl1bUp2aWlWM2NNL2NGQjNrSTBHQVFSWkRKenY5N0Z2eS9H?=
 =?utf-8?B?U0gxeUo3ZzNhT05FN0hwRnlXSVBLRzlhYm95RndYV09tSFArMThmUldGSloy?=
 =?utf-8?B?dG1ZbytmZXhqbUNUYmlKVXlKTW9wYjdza05NclZISkVPRWpncXhjMnc3bnJJ?=
 =?utf-8?B?dDlFRGJBYUVPZTRML0t0YlFkdEdyVlVUZnB3KzJOclNEYVBFMXZLZE4wYlFH?=
 =?utf-8?B?NlNqZms0Mk5ObnVka0NRMG1wa014UHg3RmppY3FLdUV2QXBvaWU2akI5elg5?=
 =?utf-8?B?S2RaQUNaZVVvcWJ1THlwSE1KTkV0YUdmdjRFVEg5QTBIYXBOblNlR0tINzJ2?=
 =?utf-8?B?aVUrc3MrK3ZxUTdndWptQnJQS24wbFc0c1BqNEZjazBmbjQ2TDBzUkxiVWFP?=
 =?utf-8?B?c3hDSnlzN3V2bGhLVEMwRm4yZC92SGhyYXVmQ3VhT1k5VDYyanR5SjZPQXJN?=
 =?utf-8?B?V2kwWFBaRVl6MmJqMUVQaFhlMzQrbFd5L2RPVlFKVVJpTUltdWt4dTY0VEFa?=
 =?utf-8?B?emIrWHV5WVJOMmJGVGp2bmJmdUJNSHRVZi8wclp2Z2Q4OC9nUS9GZ0pqemEx?=
 =?utf-8?B?dTVQZEdKNUNEbEN4dE4vbzRoU3pMcnRmMlhFU2YzOFJpQ1FOTzY4U1d3N2xY?=
 =?utf-8?B?MDdrY2NoMUIwV21FaEZZRXRMSis2TVJCQWQzTFhQREhRRGdJYlJLZGVraUhT?=
 =?utf-8?B?NGZoTVZBMm1EZmowS0grcXc2QlkwWTJqblpMSFR2UVJxZjQ1U2hrNzlIQjRz?=
 =?utf-8?B?VGJ1dkszcXpFSlFYWkg2OFlOZXdyN3BHVkNPQWx4NUwydXFrYW9HUW9RUmFU?=
 =?utf-8?B?ZjRxNEhGaE5Ua1N4QXNoMWVKRjNiaHhpWUoyL1lMeExMN3VpYVpnc1Z2M2M5?=
 =?utf-8?B?cWNuaDRaQUN6Qzd2Ui9iRkJvYmwrbTc0QnVQNHNYNXNmVFhGNnVIOGVEMTQr?=
 =?utf-8?B?V1N4N3NVcUljRkswV25uY0kwR2FseklHSzVJNkhRYnoyT3QrMFZwOGtUWlJH?=
 =?utf-8?Q?7MLedrQ/rXjxfsJUcRuwfow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1E3589EB85F9846AE1A5E2310784A73@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bea769-bea4-40ca-98cf-08daa5fe219e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:46:53.0352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHzb383fhsE3ucHF5nSZE+HxlxOeFXE1k5XIKTQECv1VnMB4wSZxxjU7FGq1+qd0ZwHrdM8D13hRoCS1arfKM/MG20rSIkzg+z96afHbZ6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6878
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTW91ZHksDQoNCk9uIFR1ZSwgMjAyMi0xMC0wNCBhdCAxNzozMyArMDgwMCwgTW91ZHkgSG8g
d3JvdGU6DQo+IEZyb206ICJSb3ktQ1cuWWVoIiA8cm95LWN3LnllaEBtZWRpYXRlay5jb20+DQo+
IA0KPiBDb21wYXRpYmxlIG5hbWVzIG9mIFZQUFNZUzAgYW5kIFZQUFNZUzEgc2hvdWxkIGJlIHJl
bmFtZWQgdG8NCj4gIm1lZGlhdGVrLG10ODE5NS1tbXN5cyIgdG8gbWF0Y2ggdGhlIGRlc2NyaXB0
aW9uIG9mIHRoZSBiaW5kaW5nIGZpbGUuDQo+IEFsc28sIGFkZCB0d28gbm9kZXMgZm9yIE1UODE5
NSBWUFBTWVMwLzEgTVVURVguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb3ktQ1cuWWVoIDxyb3kt
Y3cueWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE5NS5kdHNpIHwgMjIgKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gaW5kZXggOTA1ZDFhOTBiNDA2Li43
ZjU0ZmE3ZDAxODUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTk1LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUu
ZHRzaQ0KPiBAQCAtMTQ3NywxMSArMTQ3NywyMCBAQA0KPiAgCQl9Ow0KPiAgDQo+ICAJCXZwcHN5
czA6IGNsb2NrLWNvbnRyb2xsZXJAMTQwMDAwMDAgew0KPiAtCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTUtdnBwc3lzMCI7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
NS1tbXN5cyI7DQo+ICAJCQlyZWcgPSA8MCAweDE0MDAwMDAwIDAgMHgxMDAwPjsNCj4gKwkJCW1l
ZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UxDQo+IFNVQlNZU18xNDAwWFhYWCAwIDB4MTAw
MD47DQo+ICAJCQkjY2xvY2stY2VsbHMgPSA8MT47DQo+ICAJCX07DQo+ICANCg0KSSBydW4gIkFS
Q0g9YXJtNjQgbWFrZSBkdGJzIGNoZWNrIiBhbmQgc29tZSBvZiB0aGUgdGVzdHMgZmFpbGVkLg0K
DQpUaGUgbm9kZSBuYW1lIHNob3VsZCBiZSAnc3lzY29uJyBmcm9tIG1lZGlhdGVrL21lZGlhdGVr
LG1tc3lzLnlhbWwuDQoNCg0KPiArCQl2cHAwLW11dGV4QDE0MDBmMDAwIHsNCj4gKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZwcC1tdXRleCI7DQo+ICsJCQlyZWcgPSA8MCAweDE0
MDBmMDAwIDAgMHgxMDAwPjsNCj4gKwkJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2Ux
DQo+IFNVQlNZU18xNDAwWFhYWCAweGYwMDAgMHgxMDAwPjsNCj4gKwkJCWNsb2NrcyA9IDwmdnBw
c3lzMCBDTEtfVlBQMF9NVVRFWD47DQo+ICsJCQlwb3dlci1kb21haW5zID0gPCZzcG0NCj4gTVQ4
MTk1X1BPV0VSX0RPTUFJTl9WUFBTWVMwPjsNCj4gKwkJfTsNCj4gKw0KDQonaW50ZXJydXB0cycg
aXMgYSByZXF1aXJlZCBwcm9wZXJ0eSBmcm9tIG1lZGlhdGVrL21lZGlhdGVrLG11dGV4LnlhbWwN
Cg0KDQo+ICAJCXNtaV9zdWJfY29tbW9uX3ZwcDBfdnBwMV8yeDE6IHNtaUAxNDAxMDAwMCB7DQo+
ICAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWktc3ViLWNvbW1vbiI7DQo+ICAJ
CQlyZWcgPSA8MCAweDE0MDEwMDAwIDAgMHgxMDAwPjsNCj4gQEAgLTE1ODIsMTEgKzE1OTEsMjAg
QEANCj4gIAkJfTsNCj4gIA0KPiAgCQl2cHBzeXMxOiBjbG9jay1jb250cm9sbGVyQDE0ZjAwMDAw
IHsNCj4gLQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZwcHN5czEiOw0KPiArCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtbW1zeXMiOw0KPiAgCQkJcmVnID0gPDAgMHgx
NGYwMDAwMCAwIDB4MTAwMD47DQo+ICsJCQltZWRpYXRlayxnY2UtY2xpZW50LXJlZyA9IDwmZ2Nl
MQ0KPiBTVUJTWVNfMTRmMFhYWFggMCAweDEwMDA+Ow0KDQpOb2RlIG5hbWU6IHN5c2Nvbi4NCg0K
PiAgCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiAgCQl9Ow0KPiAgDQo+ICsJCXZwcDEtbXV0ZXhA
MTRmMDEwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdnBwLW11dGV4
IjsNCj4gKwkJCXJlZyA9IDwwIDB4MTRmMDEwMDAgMCAweDEwMDA+Ow0KPiArCQkJbWVkaWF0ZWss
Z2NlLWNsaWVudC1yZWcgPSA8JmdjZTENCj4gU1VCU1lTXzE0ZjBYWFhYIDB4MTAwMCAweDEwMDA+
Ow0KPiArCQkJY2xvY2tzID0gPCZ2cHBzeXMxIENMS19WUFAxX0RJU1BfTVVURVg+Ow0KPiArCQkJ
cG93ZXItZG9tYWlucyA9IDwmc3BtDQo+IE1UODE5NV9QT1dFUl9ET01BSU5fVlBQU1lTMT47DQo+
ICsJCX07DQo+ICsNCg0KJ2ludGVycnVwdHMnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCg0KVGhh
bmtzLA0KQWxsZW4NCg0KPiAgCQlsYXJiNTogbGFyYkAxNGYwMjAwMCB7DQo+ICAJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWktbGFyYiI7DQo+ICAJCQlyZWcgPSA8MCAweDE0ZjAy
MDAwIDAgMHgxMDAwPjsNCg0KDQoNCg==
