Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AB5F5419
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJEL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJEL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:58:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C58221265;
        Wed,  5 Oct 2022 04:58:23 -0700 (PDT)
X-UUID: 2b759d172b704b439e557491e5bf6c4a-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=InaVGA8sgofq6SeKFVDIzV+FMnzxXj/2bEa5L3ZRzGc=;
        b=HleUpq4vVEexhI+KfB9MYUtgQ8TaslrYE4U8drnSaxAQOu4MSTAT513KazKsx61MH5WXo25MKl5i+9M7ILLPlPptci9MAzIEsbY8vDL9kdWTayGjOLxLXo14lhgdnKCEYeyJ87F9QC694wzOFJGVpktBz2X7AZderu46WZPyY+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9c8e8b01-d1aa-470b-a9cc-3b8176dd24bc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:9c8e8b01-d1aa-470b-a9cc-3b8176dd24bc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:58ae52fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221005152139C6UODKSS,BulkQuantity:142,Recheck:0,SF:38|17|19|823|824|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0
X-UUID: 2b759d172b704b439e557491e5bf6c4a-20221005
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 810477441; Wed, 05 Oct 2022 19:58:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 5 Oct 2022 19:58:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 5 Oct 2022 19:58:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyH18aIK/0xtu8IvsiA0zRv74YNTYt3H6+HcMJkqi+1i70fD9cXeHXfGHExZtDovEzTg9DUK+jUIPGM6PK3qCtg6Vpi35EX6RDnO152RBHLrPWtnE/TtmyvsqivdiUpByPNl0zKjgxjlOXYdB+ucDbbX2vm+f85xQCRS2hUC9rBq2YphJVop4uG9QXstrSLGNS7udZCzGNc8zPMRE1ClWugFGaqOAB+3KWBgQBHEG+YccC2/oFIcEovzfQryslfjoIijDFrubUdxGxrb8mOlOvuqinnBMOTWvCboWY/b2uc0Pi9tK6Y25hnaEHo5BEJCpntQp2p5jJfFLNVxWP3tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InaVGA8sgofq6SeKFVDIzV+FMnzxXj/2bEa5L3ZRzGc=;
 b=Xvn4vDYmifUtOsjxRNp+GS9mfXaG6xv+J849YBeps+oW4FKSDtNXmcS99Gum1akrXkJ+WORlBoFBqvdbFCDcGeotcPX/GovpAu2YR+TftRK23mAkpIFPU1HJ04hngXa0K3NXR+etFLh2YVsKPXbUUJFBZedExDjWBtRxmnd+kydwA8FcBxBal3Sf3FCC3kZY/fpumkmlLlQjOEc3DtIvBwYmlNp/GK/SKi1bvv9RjF+DZqCM+py3GDhH92GYu40G/NFrhS48FcomvSrJRiIAQiY0Q5YJXwyD8JGmtESYh0jCc0p1/C4vmS3HCZPDyu+nkDg5aTjTMebiQLedP0N87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InaVGA8sgofq6SeKFVDIzV+FMnzxXj/2bEa5L3ZRzGc=;
 b=NPcROemi0SBDPBy4oOVKJ9ksM8Ow/i13ASAT3Ct3UV17mjtmhd7M1ytZm9tz1qmSiJS3B52u+fn1wU+KKJ2jz2U4TMFv2woXUqwmDhIvJq3VZ8/m0gwW7TJpwsbI6YJ3c6Hn8gZ30i8DmiKyybv39/5hA6abq+InI21uXa77Gj0=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB6055.apcprd03.prod.outlook.com (2603:1096:4:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.3; Wed, 5 Oct
 2022 11:58:17 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Wed, 5 Oct 2022
 11:58:17 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Topic: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Index: AQHY1L8dCAPwNN1uhkOBnORLrQwrlq34hoeAgAbmGICAAAK1AIAASq8A
Date:   Wed, 5 Oct 2022 11:58:17 +0000
Message-ID: <722194a3d413ca15069554ebab1f34dec25057eb.camel@mediatek.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
         <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
         <20220930220011.GA1107972-robh@kernel.org>
         <ffc56eb60a3ef74c815c8d3c170a0df51958e20d.camel@mediatek.com>
         <24361bea-ecfe-b6e1-e755-5151220767f2@linaro.org>
In-Reply-To: <24361bea-ecfe-b6e1-e755-5151220767f2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB6055:EE_
x-ms-office365-filtering-correlation-id: e8dadf6d-6a65-454b-01bb-08daa6c8e3f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HXDJayKrnV8paNG5U4q/bbGpn4MrtZGYH4De9/clWrEhC8pDU3+6KqmyWlkC/4U+Ror/l+t1I5NqygE7nVapYdaSbq45Qsl7agmXHOaAf3X8BCuBYsSPvsBbCkjitDyVjeodGkPaXgB/pw30LyZ+U++wcIkbnSa8RYqwjF+l5pH1z+w5SkueSfD2VaqD5TPYjQJX4p8EHyaLevqCnLFPZg9yczMTjHUwiggbdVD44oYi8isq5s4eGUpewTjuJaqDhZiU6zuacsxt2XlQxDzG+Bjic+Njx2PiQDfbwVpCnV4zR/PvWZhVZcsXKLR6h3Qf8nSKpAySK92kpd+yiwojCtqMyu4JDX+37c3xr/yicyqx5p9KiqzV+PAVQWlf7xRnbZtRWRaJKER3fB3wLnaTRijKPTqU0Gk8lGsyfWtXrJGP2gGhtXYBKQgbbWdxBRmF2JA9pXtIORN5VsuJFEvQEw0ggLV4ceR6T1YsoKnr+WD4wlKkyKjtQKS96a6Z+YR6DA0/Mf3JYTPHEDJO01MmZYaOkSof8CmOMSUyYrEHokVevNyhCdh9fkcKaAMGxHG7qVqz8mr8GEl51ci3+9f9SSXC2u+DTBvM2Pcp/PGjAlY/PCHRBC0a65NCPPQUQgQ6v+Amp3ed5rkTI1rPzpFyvJlvyLb7sZCEkk2LDkFCVzyiZloqGRoap2AUTXZvqsQ5zP/rYB4rO62iKgrzFPWO7VzdbQTOrAFzjvpM3rv5iRZXEdo4/YKHL211RHBTf94kUjDoM3lE/xmDI/ueNpn+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(8936002)(316002)(110136005)(54906003)(186003)(71200400001)(26005)(41300700001)(6512007)(2906002)(86362001)(122000001)(2616005)(38070700005)(6506007)(6486002)(38100700002)(83380400001)(53546011)(66446008)(478600001)(66556008)(66476007)(64756008)(5660300002)(91956017)(36756003)(85182001)(66946007)(76116006)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ltVU1KeGR6YnN5amFOaEMySTlUWE0zVzRuYjZUZGc4ZFJXR2QzQ1YrMC9q?=
 =?utf-8?B?YzNYeGxFN3QxcStkNEtGVU5URHZHU2RoVFJTbWdJVno1UEV6MkRKR21zR1cr?=
 =?utf-8?B?VFFTS09wVE55czFRY2lQUnlyeDQwencvTVg1eWNpRmROYzArVFluRjFVTktw?=
 =?utf-8?B?T0U5bHpyZndsSHhNektra3dnQ3g2ZkxmblVNa1Jhb3RwbS9IYW44bHgzeGkx?=
 =?utf-8?B?N3Ixdzl0YmFmM1QrSzk4cWZoMGpxREFBMlFlbFhTNENlNjBkaXU0a2JaWmNM?=
 =?utf-8?B?aE1PUGZxTklybDd6KzBOK1lURHV1K2gvZ0FZQm8yWXg2RzdwVlFnT3krK1Ba?=
 =?utf-8?B?SkRtdko3WTE1emVjUitvb25Dei9zWG1UTmQ5MVMxZzA5U3JXcU9GNW1OSmJs?=
 =?utf-8?B?UVN5cVY1SUNwaFRraVFvdEFUV2dnU1VlSVdmWC9FWGlMYmZSdjJ1QU5lSzly?=
 =?utf-8?B?a1hSN0R4Z0dIbTBFRHNXREZUbnRYRHdhMDlweS8rR0svUmVRaGxyYlRyOUly?=
 =?utf-8?B?TisyR0I4cTZJUWFXUmJVTW4wcE13VDZJUFRtL2ZjNjNXdHh2cTJHVlpPcDRE?=
 =?utf-8?B?U0l6VGQ2R3pDVUpzQkJjaSt3cE1HTVU2YU10WHhkcHd1Y3htcG9QRVA3TnFG?=
 =?utf-8?B?Qm16M3B1Z09FalI0NUhDb0x5SW54Z1ByYjJreDRLMVVEZ3Zsa1dBVkdtMjNR?=
 =?utf-8?B?NGFkTHNCYncwZDlpY1lWdEExbksyR0RtdGFldUNjREpvd3ZITFFCS3k1Rlhj?=
 =?utf-8?B?N2JvVml0QTBkNVk4MFpYVGxsT2Jpak9KVXQ0Q1VqOEtRdHV2WkU5YTdscElX?=
 =?utf-8?B?UTFDcmhBOWVMdDFScTh0ajRZVTJjdlNZSXJhaFcwNzhSL2VYbmF1QzBSaStn?=
 =?utf-8?B?Z2ZwRklWM3JUNG1FTElla0x1VVMzcUNPaGRkL04vdDQxQVlLb3BqTEh3T01Q?=
 =?utf-8?B?WDJONERBL3A0YUJQMVZDZ3NIM3RJYzA3cmJoaUtRUGVwSFFnb0sxZmRHSnYy?=
 =?utf-8?B?QkRVWEMwWWE3SGFHSXRBVXI0VkRNMHJCWTZFdWtzellTSktIY3Z1UXhNOHo0?=
 =?utf-8?B?R2xySm1RM0JjY00yWE42aDdFLzdHSnZyWmUxM1FiNWpLYmIvakMxS0hUUkox?=
 =?utf-8?B?V09EejBNRWpxY2ZEd3ZPemRRekV4eDRoK0xqTFN3d3lvWTZwQ0QraHF4YXdK?=
 =?utf-8?B?cnRDWGk5TzRsaU1lNklkSmo2VS9SeWZ4aU1Cc1hJSmpsbkVSUFNsU002YlBR?=
 =?utf-8?B?bXhCZWpzc1ZSRk5PVllWM0taM2w3Q1pPQ1pZSzZnUTB5ZTRlbnJhdXBuOTFp?=
 =?utf-8?B?VXBUN21sR2ZyVmVPY3ZXRmFjOVU3dVEzMmcwdE5CYUdSejFmeUdldnlON2c2?=
 =?utf-8?B?Y0IycW1LTlpmK04yUE1XdjZFNVBLVGR1bHNUc1hGNFBJbitFaGVhTndRazZV?=
 =?utf-8?B?ckJFeVF2b2FUS3MvK0dMNU5RNTQ0a2RjWHJVVGN3cy9hR0wvQTN2bVA0MTV3?=
 =?utf-8?B?YmtGWk50elBZK2NoVU5rTG1xODVlN0t1Y3UrT2lid1plRWJ4M25jRGtBeVJn?=
 =?utf-8?B?UldLb1A4L3dLK2ZjR1Q1VTdtS093MXJWamdsM0UwUlpMcXZZTHprZzZJM1hj?=
 =?utf-8?B?bVZESTQ0Nnl0UndTeVJyNGRFR0d5U2VUeXBpaUwrblE2OFpsQXlPMzFlSW9u?=
 =?utf-8?B?eWNqN3ZHcWtxV290MDArUzdTZDZnVG1WZkdMS0pLcnBmQkoyMkwvMmRUTW55?=
 =?utf-8?B?Y0JDQk5CT3NmZ2IyeXlwSmNVWEpIRE5QRzBjN2lzNVFqZjBlcWFJQjVOVEJ0?=
 =?utf-8?B?TUREOEJzMWZHb1MvWFZPaVdETjJYNFNpdDM0SnJyQmZQUGxQOFhUOWpQT3gv?=
 =?utf-8?B?aTBJKzQ4ZkUyMkpjelVYS0xWTS9JanRYV2VXemd0TENXaWdKOUQxTG95Y1Rq?=
 =?utf-8?B?ZUdsZFZhZXBTeTN0a3BHRitzMncyVlVHN05PeDlpVWNRUmZVbW10RnhLQ3Jm?=
 =?utf-8?B?dmh0aVVKL0RKTTIxejdpQUNYSEJVVXUyakFmdlZxdWxrQVRiQ2duWW00WEtr?=
 =?utf-8?B?UXdyOFdvNzd6VVdkSlg1NnkzaWFSS0dObnJXbTRnUVY3ekplMVpISkR6OUUz?=
 =?utf-8?B?bzcrZVNXdVFKYjIzcncxWDF3b0tuWVhPR3oraFZ0MldPT3VZNkptQ3djaUNS?=
 =?utf-8?Q?weTA9imU2DbuAn0Mvm8hdt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD63451184D93F47B54B2621E5C33BFB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dadf6d-6a65-454b-01bb-08daa6c8e3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 11:58:17.4229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiRLLcI9LWQIc2xwp0RqfDxE7ZvzDGQgWNYwiJ+RbIhHdSNkOfpJO9pup6kMY2UJVkals3aj4yxtjdZWPvNXha2tDcELVpHRBycj4A3wFyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6055
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBXZWQsIDIwMjItMTAtMDUgYXQgMDk6MzAgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA1LzEwLzIwMjIgMDk6MjEsIEFsbGVuLUtIIENo
ZW5nICjnqIvlhqDli7MpIHdyb3RlOg0KPiA+IEhpIFJvYiwNCj4gPiANCj4gPiBPbiBGcmksIDIw
MjItMDktMzAgYXQgMTc6MDAgLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gT24gRnJp
LCBTZXAgMzAsIDIwMjIgYXQgMDc6MjI6MzZQTSArMDgwMCwgQWxsZW4tS0ggQ2hlbmcgd3JvdGU6
DQo+ID4gPiA+IEluIG9yZGVyIHRvIG1ha2UgdGhlIG5hbWVzIG9mIHRoZSBjaGlsZCBub2RlcyBt
b3JlIGdlbmVyaWMsIHdlDQo+ID4gPiA+IHJlbmFtZQ0KPiA+ID4gPiAidmNvZGVjIiB0byAidmlk
ZW8tY29kZWMiIGZvciBkZWNvZGVyIGluIHBhdHRlcm5Qcm9wZXJ0aWVzIGFuZA0KPiA+ID4gPiBl
eGFtcGxlLg0KPiA+ID4gDQo+ID4gPiBUaGV5IGFyZSBlaXRoZXIgZ2VuZXJpYyBvciB0aGV5IGFy
ZW4ndC4gVW50aWwgc29tZXRoaW5nIGdlbmVyaWMNCj4gPiA+IGlzIA0KPiA+ID4gZGVmaW5lZCwg
SSBkb24ndCB0aGluayBpdCdzIHdvcnRoIHRoZSBjaHVybiB0byBjaGFuZ2UuDQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hl
bmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPA0KPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZj
b2RlYy1zdWJkZXYtZGVjb2Rlci55YW1sICAgIHwgOA0KPiA+ID4gPiArKysrLS0tLQ0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLQ0KPiA+ID4gPiBzdWJkZXYtDQo+ID4g
PiA+IGRlY29kZXIueWFtbA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gPiA+IHN1YmRldi0NCj4gPiA+ID4gZGVj
b2Rlci55YW1sDQo+ID4gPiA+IGluZGV4IGM0ZjIwYWNkYzFmOC4uNjdmZGU0OGY5OTFjIDEwMDY0
NA0KPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEv
bWVkaWF0ZWssdmNvZGVjLQ0KPiA+ID4gPiBzdWJkZXYtZGVjb2Rlci55YW1sDQo+ID4gPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29k
ZWMtDQo+ID4gPiA+IHN1YmRldi1kZWNvZGVyLnlhbWwNCj4gPiA+ID4gQEAgLTkxLDcgKzkxLDcg
QEAgcHJvcGVydGllczoNCj4gPiA+ID4gIA0KPiA+ID4gPiAgIyBSZXF1aXJlZCBjaGlsZCBub2Rl
Og0KPiA+ID4gPiAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiA+IC0gICdedmNvZGVjLWxhdEBb
MC05YS1mXSskJzoNCj4gPiA+ID4gKyAgJ152aWRlby1jb2RlYy1sYXRAWzAtOWEtZl0rJCc6DQo+
ID4gPiANCj4gPiA+IEp1c3QgJ3ZpZGVvLWNvZGVjJyBkb2Vzbid0IHdvcms/DQo+ID4gPiANCj4g
PiANCj4gPiBUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQo+ID4gDQo+ID4gaG1tLCBJIHRoaW5rICd2
aWRvZS1jb2RlYycgZG9lcyB3cm9rLg0KPiA+IA0KPiA+IFRoZXJlIGFyZSB0d28gc2VwZXJhdGUg
aGFyZHdhcmVzIGZvciB0aGUgTVRLIHZpZGVvIGNvZGVjLg0KPiA+IGNvZGVjLWxhdCBhbmQgY29k
ZWMtY29yZS4NCj4gPiANCj4gPiBJcyBpdCBvayB0byBrZWVwIHR3byBjaGlsZCBub2RlIG5hbWVz
IGZvciB2YXJpb3VzIGhhcmR3YXJlcz8NCj4gPiANCj4gDQo+IEFyZW4ndCB0aGV5IHN0aWxsIGNv
ZGVjcz8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClllcywgVGhleSBhcmUg
Ym90aCBoYXJkd2FyZSBkZW9jZGVycy4gTGF0IGlzIHJlc3BvbnNpYmxlIGZvciB0aGUNCmJpdHN0
cmVhbSBhbmQgd3JpdGUgdGhlIG91dGNvbWUgdG8gdGhlIGxhdCBidWZmZXIuIENvcmUgd2lsbCBk
ZWNvZGUgdGhlDQpsYXQgYnVmZmVyIGFuZCB3cml0ZSB0aGUgb3V0Y29tZSB0byB0aGUgb3V0cHV0
IGJ1ZmZlci4gRWFjaCBmcmFtZSB3aWxsDQpiZSBkZWNvZGVkIGN5Y2xpY2FsbHkgYnkgdGhlc2Ug
dHdvIGhhcmR3YXJlIGRlb2NkZXJzLg0KDQoNClRoYW5rcywNCkFsbGVuDQoNCg0KPiANCg==
