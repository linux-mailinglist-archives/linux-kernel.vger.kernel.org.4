Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C76292D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiKOH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKOH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:58:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63063E2;
        Mon, 14 Nov 2022 23:58:30 -0800 (PST)
X-UUID: d145a33e68804dceb04e56a1599cf5fb-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mi7kRP7e/pMJko+7AwaHAFRGeU3/25u1cj40pCt9RUA=;
        b=rIo22jSAEelpIBFlaYUe0ksGQ4VJTfr0ej8jRLO+Le5/6c5LccpY9YjOJMm6GR54QZJ9FpkMbVsZDi78BHxDWAsWcxQviB1wR6txC0sDNDpC33DmflRXYdv3RXIziYjcYkdX1rme/3i68oTywSqh5cfAIHg0ZgtW/ow/cLPgPXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:2997e188-5286-4d59-a102-38597a9edbf5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:8b41ccdd-c087-4fa8-aefb-7a0acf417f59,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d145a33e68804dceb04e56a1599cf5fb-20221115
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 749284217; Tue, 15 Nov 2022 15:58:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 15 Nov 2022 15:58:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 15 Nov 2022 15:58:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbigpdCwacls6QhCpicMXH5VBh/FaiE9QbheEBeexdhE7oqFQSI8gEYyisWLVaLfpS69NTgFvf20YMZ3AsNSpMAy936yGTEMDIBnAArzmToau4viUM1D/MVVS9yeh37EOAIG4Jt39tIQlexua+Qr3+LnY2od27r7IEnn4jTJbsC3C54eg7s0r8J3ABDUUBOl7/o4b3omcEUBZYRG3vYLt8/Fhcnt6l1mJDAcD1aaOjR8AFnxPUk+nEfVrHwkajywOlhaaTtI99AOvYVj7JpOeXrmNKZT2aw87lBIL35HutOaYrEtCk6eOX9A1yTbfQjgoc6dvELAXu6nJR8lzjKHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi7kRP7e/pMJko+7AwaHAFRGeU3/25u1cj40pCt9RUA=;
 b=HubCrJZ6jvH1GaHepyzuJtgTC2TA3/AZYLUZjx4eQk0HHCIceCZL6X+O11D+iTEWfN3+FRTNZqaVUJkFrmnBKbiCC2xg1LyJmA35gYs4FLKosOZY+vXEOUgO0JqTSe2QB6Tpaq6WLue784dXiffO6EgpuXDDpiy5wqeRbvJmrPvkQFDUoLPY7O2aRxr8cOJI0RvzkeB76ONECWWr987rkgbA3xKxpajLmNQ564eykWpSdvqWUgLOfiHCNUtKYFkO5Tpt5cM6ZfzJgRb5f5Bht+Qrl4rd9cSn96TAZvegeHgTBmvhHH5utGayWnwMRenV525soUtz3MhaasLUPMLyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi7kRP7e/pMJko+7AwaHAFRGeU3/25u1cj40pCt9RUA=;
 b=sPpqHEkWp244QP+xc079cDmDmbPqU75I5/90y/2R1jqZU799Kj9CJqU0IPS0pwdN3ftPwiyLtipXLkoOhfb8hxWPLd9vk5VLoOeUso0cdz1ZBf4HTe11dmLoWK4ihiRPPrFkuTlw1XNrvs/W4z1lU0yUfCXSunoq0qlyey7RLd8=
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com (2603:1096:4:1d4::13)
 by SI2PR03MB5308.apcprd03.prod.outlook.com (2603:1096:4:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 07:58:19 +0000
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::5b17:2855:267d:a6bf]) by SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::5b17:2855:267d:a6bf%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 07:58:19 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Thread-Topic: [PATCH v4 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Thread-Index: AQHY9M70xtWhKvGkvU2VMWADQSjVBa45psiAgAX/owA=
Date:   Tue, 15 Nov 2022 07:58:19 +0000
Message-ID: <bb53d1d7e3cfa75af578412d56d2c6e8fc0d1be7.camel@mediatek.com>
References: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
         <20221110063716.25677-3-rex-bc.chen@mediatek.com>
         <73e5491a-9720-ea52-48ff-cc506c6dc582@gmail.com>
In-Reply-To: <73e5491a-9720-ea52-48ff-cc506c6dc582@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6540:EE_|SI2PR03MB5308:EE_
x-ms-office365-filtering-correlation-id: c89aa05c-c96c-4d71-45e4-08dac6df28e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mJGqhQYOllfP+0brN8lM+LBrzgfYL3PC4B0e/gLfYKkGGg/3ZyfFy9n7bp+ppd2iqrVclTUmX8c63yod6QmSUzSXSPmqdYaR6FtCw0Itk+Bhl6EwenldpvHrT4BKs+KsJbz0YEkumKbPXpk4WVFuvCqJXi0DhKGE1yOl3T9Gt4WvsNetyz3acfV62a+H00FdIRS9An67+ZbjVCHsbEivvJGYWoVplL0ojWRRdFjbqNdPxkZCG33tqRVyVZ2el7dmKAW/MT1RgpPApWSi6hDTKOz3EYyFFDxjl8k/RMWr+Va4SgGqnOKjRAniLf70tznfcyzL9hqK8/jBo4Ql8XP3F90uQZWb5ljRdE66zTYOtuIFV51cS/XOXSYS0QahGZ7/0oRE3BVdfxg/kiJuLL2RAXMUJm4SKQpKiCLAALTdj/qskaQWcjVhDGooR8mfGnlVczfnaHVi/csT6cgax7DG8iFdaAhBjM2RQn7hZGFPhv10/8Y3VUf831Z2pgI2Y/11xmLYNMHI6nEKAv4xksUzvLVmnSTc416yacVezwgbJNuq4ndQDT6NXea7UQFL4qPXOm8EKhDAvdYfdEjZoeOGjkdG68ImZVoM4PEUUeW34Aeodt+Kh5nlbVUup1QR0p/D9tvcXnAlQ17NTUjofR5CCWax3J0OxjLHB9QAHAVebTdRw1ozeGr2DI0RpqB5ExRi1QsFQE594+JThPyGM/+V1M/k7oLlro0K3NinJgVV64/feQxka2/BtMHaDTSNp7ZIma/DTUiVZNsU3KVw/g/YQrjlJKJD3HOsx+DmiLbxVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6540.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(6506007)(6512007)(53546011)(26005)(6486002)(110136005)(122000001)(966005)(316002)(38070700005)(38100700002)(478600001)(85182001)(36756003)(71200400001)(86362001)(186003)(2906002)(2616005)(107886003)(83380400001)(8936002)(54906003)(66946007)(66476007)(66446008)(76116006)(41300700001)(8676002)(66556008)(4326008)(64756008)(4001150100001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVFjTWJHdXNieGpVeW00dzc3VUJUM2dnRTZkT2xqeTIrL0Z6clNyL01XY2tW?=
 =?utf-8?B?cVk5K09mRDRpOTYzNkZSK2REdTNYTXB2MktwRDgvT0NGWThRR3ovaU1Pakhr?=
 =?utf-8?B?clRxdFcwVzhZTnpvcTc0Nm9MRnlWVDZCeEdHcFFmalZtUTljOTRnZ2xVTm5M?=
 =?utf-8?B?TnBzVFZud3dTd1FTMWNxNG9od3dXYTBud2l1L08rMmlNVFp5V2VJYlM5ZkNC?=
 =?utf-8?B?S2kyaXdoeEYwb2tMVHQ3UWxWUXZHSEVzdWQ3NHJ0M01QNU9SR2JIVnJ6SWp2?=
 =?utf-8?B?ZTE2Z2s0TEIvR2N1NXU2cWhWZHhVa3VxNjcrTUVHdDR3Y1ZVYi9KdVdYQzJW?=
 =?utf-8?B?cEZiNGZFcWFYNHRibXV6azgySmtxT1B4Mk9rUkF1djNTK0tuYit5dGgzaExP?=
 =?utf-8?B?OUxwelhrejdSYWlMZHBlQ21KOU9rZVJJaGpiNm1XRTZ4VUFBSEhnNWRGNDNn?=
 =?utf-8?B?ZTM4blRRd01ZTDVGZHlYYVI5MENmV0RnOXB3b0ZiSFJQM3h5M21wTXBTcldh?=
 =?utf-8?B?Y2x1WUJkRVlvTlJrY29ERnI1clE0VWp2SmtuWCtBdExtVUpBbmI1UGFqNTgw?=
 =?utf-8?B?eUtKRUFqYWU3amhPb3VjMC82M2RyUlVyMlJCb0VNZjQxeHhWcHU2dWQvZjRv?=
 =?utf-8?B?ZzZpWnNDVDVMMGVZcGxQdE05aklnYVYvRytnZGdQTnh3dUwvNE1GNVFJdENi?=
 =?utf-8?B?UGZqMUpGNGNUb3hSeTdSalZzdWg0TnNmVksrYmVoYmpwQXpKVVFZdzJvTFha?=
 =?utf-8?B?NkpWbUFpSGRSd0J5THVSSnVUeHBqNFhpWVRJQk5TYjkrTEcxL2FEWjdzRnBn?=
 =?utf-8?B?ZFUzK1hxMVR5Nk0ySDR1M1ZpalNXSEpvS3kyODNCT05JN043RkFONHNoNkxQ?=
 =?utf-8?B?U3VVT0lSNTk0UTZOUHZXb0ZEb3VTTU1SQ0hxdEMyN0V5dlNnSUVTUGpaMnpT?=
 =?utf-8?B?dmVvS1NkOEw3Ukh2RTNHY2JLM0V0anpoUS9HSTZrTXNpMDluMEI0cXdxZXVN?=
 =?utf-8?B?WTJrTWMreHVNSkxUZndhay9DUjhGY2lXamxTYzRzY2pHMUh1MzRuRmF5MEZH?=
 =?utf-8?B?Y3F0aUhudW9TS0ZjWXBQSUlVSk50TWc1T2ZGRC9udU9JdUxXeENMMFFGVnJG?=
 =?utf-8?B?Lyttb3c1RDhkckFPdkRvREtnTDJaQS9wMlNtZ1BPYWJvK1pQRWNGRk9oSjk3?=
 =?utf-8?B?UWQycy9oajIrYUV5bHZjZmxaN1MyQWtNbWRaT0pCRDVJSU80Tyt1M2J1SEJJ?=
 =?utf-8?B?WUJ4eHhhMEdMdTFSNUhXbHdDZmdyUnlXaGZ4QnBXYVpYZm1WaWd5cG5ReThJ?=
 =?utf-8?B?bXh1cERQQVpUNXZIRHZmR1laVlhycE8vWlM1NFhwZm5PNGI2YXFOckhCVjZW?=
 =?utf-8?B?WXVKZEd1N2tQenFUWndhck1TRXN6ZEpOZWhiTDdTYVRYUVJqbWVZNEhOeHlz?=
 =?utf-8?B?Wkp1cXY0YmVMZGVuUU1CQVFLdGdUK3JGVUtJYWpuS2JISWlnbzFyZlJRU2RD?=
 =?utf-8?B?UXJFVmQ2bmN1amJhc1V6Nk1DQTlIUEVza0d0OE44QnpmTzdXdVhnKy9IbEUz?=
 =?utf-8?B?ajloaklXQkFHK0xVME44eUJxbG11UzNlbEJnZmwvb2NtSjByTHg4d1gyaHND?=
 =?utf-8?B?Q01rUER6VWFPdzRMY3RZbVhpNG9xRGFuZkp4WEw4SHJXeTBoUVpUUlB2U0sr?=
 =?utf-8?B?Z3V1WWtqNVpPdFk2QzFMTUh3VURaTTNsRlEwMWpac1dlWVhPeVdpd3UvTFNt?=
 =?utf-8?B?MVhXLzE4TVRPNk9tQkRkWEJGWXcwSWdHS3ZnMFBmQXAxVzdWeng3bWR5OFN6?=
 =?utf-8?B?R2ZTVzNkeXVKZHVwd1N1TVBZN1YybXZkMEN3eGo1OXUzem8yV1p4L2VUczI5?=
 =?utf-8?B?V1I5ZzZlejk1MlprU1o2LzdVaytpSGVoVlZGcytBNXlzUkJpTmgwYVNlWXZL?=
 =?utf-8?B?ZndoTnRZNGYxUDFOTVRDUW01ZUpEeXE2dStMbldha0ZwYU5RUXA2SGd5OVpv?=
 =?utf-8?B?a3dxTnNkZEdtZGJjQ0FGcUxySXJ2aVJhbG01RmdsclNUUEVpUWpSckNMUUFa?=
 =?utf-8?B?Um43NEhGYVpQRmVNZlZ1dEF4RGoyOXhwT1BUb012M0tub0FXREkxbFZTMFM4?=
 =?utf-8?B?MUhiOWJkdnRhYXluNkJwQjNLUitnOHBRa2M3VHcxbmtNWFlweENqTmNmWWFj?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D5B2570A46F3E43AFB0354566566566@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6540.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89aa05c-c96c-4d71-45e4-08dac6df28e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 07:58:19.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUc59sE3RgdGBN6K2aN7nteDEy/1NS+ZSoNHQ2yz6YEE7pRo2Z9Ho1PFzT7XuS0BTF+LQNgjPrIOijrI9mC6qK9kKyfjzRGI0wOMf4XxiGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDEzOjIyICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTAvMTEvMjAyMiAwNzozNywgQm8tQ2hlbiBDaGVuIHdyb3RlOg0KPiA+IElu
IE1UODE5NSwgd2UgdXNlIGVkcHR4IGFzIHRoZSBpbnRlcm5hbCBkaXNwbGF5IGludGVyZmFjZSBh
bmQgdXNlDQo+ID4gZHB0eCBhcyB0aGUgZXh0ZXJuYWwgZGlzcGxheSBpbnRlcmZhY2UuIFRoZXJl
Zm9yZSwgd2UgbmVlZCB0byBhZGQNCj4gPiB0aGVzZSBub2RlcyB0byBzdXBwb3J0IHRoZSBpbnRl
cm5hbCBkaXNwbGF5IGFuZCB0aGUgZXh0ZXJuYWwNCj4gPiBkaXNwbGF5Lg0KPiA+IA0KPiA+IC0g
QWRkIGRwIGNhbGlicmF0aW9uIGRhdGEgaW4gdGhlIGVmdXNlIG5vZGUuDQo+ID4gLSBBZGQgZWRw
dHggYW5kIGRwdHggbm9kZXMgZm9yIE1UODE5NS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
by1DaGVuIENoZW4gPHJleC1iYy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kgfCAyNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiA+IGIvYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiA+IGluZGV4IGMzODA3MzhkMTBj
Yi4uN2FjYmVmNWE0NTE3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5NS5kdHNpDQo+ID4gQEAgLTEyNDQsNiArMTI0NCw5IEBADQo+ID4gICAJCQkJcmVnID0g
PDB4MTg5IDB4Mj47DQo+ID4gICAJCQkJYml0cyA9IDw3IDU+Ow0KPiA+ICAgCQkJfTsNCj4gPiAr
CQkJZHBfY2FsaWJyYXRpb246IGRwLWRhdGFAMWFjIHsNCj4gPiArCQkJCXJlZyA9IDwweDFhYyAw
eDEwPjsNCj4gPiArCQkJfTsNCj4gPiAgIAkJfTsNCj4gPiAgIA0KPiA+ICAgCQl1M3BoeTI6IHQt
cGh5QDExYzQwMDAwIHsNCj4gPiBAQCAtMjIwNSw1ICsyMjA4LDI3IEBADQo+ID4gICAJCQljbG9j
ay1uYW1lcyA9ICJlbmdpbmUiLCAicGl4ZWwiLCAicGxsIjsNCj4gPiAgIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ID4gICAJCX07DQo+ID4gKw0KPiA+ICsJCWVkcF90eDogZWRwLXR4QDFjNTAw
MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZWRwLXR4IjsNCj4g
PiArCQkJcmVnID0gPDAgMHgxYzUwMDAwMCAwIDB4ODAwMD47DQo+ID4gKwkJCW52bWVtLWNlbGxz
ID0gPCZkcF9jYWxpYnJhdGlvbj47DQo+ID4gKwkJCW52bWVtLWNlbGwtbmFtZXMgPSAiZHBfY2Fs
aWJyYXRpb25fZGF0YSI7DQo+ID4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5
NV9QT1dFUl9ET01BSU5fRVBEX1RYPjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDY3
NiBJUlFfVFlQRV9MRVZFTF9ISUdIDQo+ID4gMD47DQo+ID4gKwkJCW1heC1saW5rcmF0ZS1taHog
PSA8ODEwMD47DQo+ID4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiAr
DQo+ID4gKwkJZHBfdHg6IGRwLXR4QDFjNjAwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTUtZHAtdHgiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDFjNjAwMDAwIDAgMHg4
MDAwPjsNCj4gPiArCQkJbnZtZW0tY2VsbHMgPSA8JmRwX2NhbGlicmF0aW9uPjsNCj4gPiArCQkJ
bnZtZW0tY2VsbC1uYW1lcyA9ICJkcF9jYWxpYnJhdGlvbl9kYXRhIjsNCj4gPiArCQkJcG93ZXIt
ZG9tYWlucyA9IDwmc3BtDQo+ID4gTVQ4MTk1X1BPV0VSX0RPTUFJTl9EUF9UWD47DQo+ID4gKwkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSA0NTggSVJRX1RZUEVfTEVWRUxfSElHSA0KPiA+IDA+Ow0K
PiA+ICsJCQltYXgtbGlua3JhdGUtbWh6ID0gPDgxMDA+Ow0KPiA+ICsJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPiA+ICsJCX07DQo+IA0KPiBGb3Igc29tZSBub3QgcmVhbGx5IG9idmlvdXMgcmVh
c29ucyB3ZSBnZXQgdGhlIGZvbGxvd2luZyBlcnJvcnMgd2l0aA0KPiBtYWtlIENIRUNLX0RUQlM9
MSBtZWRpYXRlay9tdDgxOTUtY2hlcnJ5LXRvbWF0by1yMi5kdGINCj4gDQo+IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LWNoZXJyeS10b21hdG8tcjIuZHRiOjA6MDogDQo+IC9z
b2MvZWRwLXR4QDFjNTAwMDAwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBh
dGlibGU6IA0KPiBbJ21lZGlhdGVrLG10ODE5NS1lZHAtdHgnXQ0KPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210ODE5NS1jaGVycnktdG9tYXRvLXIyLmR0YjowOjA6IA0KPiAvc29jL2Rw
LXR4QDFjNjAwMDAwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6
IA0KPiBbJ21lZGlhdGVrLG10ODE5NS1kcC10eCddDQo+IA0KPiBDYW4geW91IHBsZWFzZSBzZWUg
aG93IHRvIGZpeCB0aGlzLiBUZXN0ZWQgd2l0aCBuZXh0LTIwMjIxMTExLg0KPiANCj4gUmVnYXJk
cywNCj4gTWF0dGhpYXMNCj4gDQoNCkhlbGxvIE1hdHRoaWFzLA0KDQpJIGNhbiBub3QgcmVwcm9k
dWNlIHRoaXMgaXNzdWUgaW4gbXkgbG9jYWwgZW52aXJvbm1lbnQsIGJ1dCBJIGFtIHN1cmUNCnRo
ZSBiaW5kaW5nIGlzIGluIGtlcm5lbCBtYXN0ZXIgYnJhbmNoICh2Ni4xLXJjNSk6DQoNCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRwLnlhbWw/aD12Ni4xLXJjNQ0KDQpJdCdzIHN0cmFuZ2UgdGhhdCB0aGUg
bWVzc2FnZSB5b3UgcHJvdmlkZWQgc2FpZCBpdCBjYW4gbm90IGZpbmQgYW55DQpzY2hlbWEgd2l0
aCBbJ21lZGlhdGVrLG10ODE5NS1lZHAtdHgnXSBhbmQgWydtZWRpYXRlayxtdDgxOTUtZHAtdHgn
XS4NCg0KQlJzLA0KQm8tQ2hlbg0KDQo+ID4gICAJfTsNCj4gPiAgIH07DQo=
