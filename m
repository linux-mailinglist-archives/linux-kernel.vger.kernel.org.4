Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4C6EA105
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjDUBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDUBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:33:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA8271C;
        Thu, 20 Apr 2023 18:33:20 -0700 (PDT)
X-UUID: 7ad14dc6dfe411edb6b9f13eb10bd0fe-20230421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r/zQtuSsS70u63JfRkQ2B0ycZshR1PtOyRKKngEcBuc=;
        b=p5Xuwetze/hu8DvgWONRHw46+R04Ox2+BY/jZ39+Ci6gMvnUef/BEKkcUeaWHvEQ2ymZOLXTFlq+stISSxokW97c4uReogPfwjvZsmR5NmdBQl4fUfww2laatLZ19hHbbkyYwbCFLGcV8dJn5R4UDs3HyzjywBkfNi96hjmpVk0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8157f23d-f767-4cdc-aee9-af5ed4ab9d68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:7b62a8eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 7ad14dc6dfe411edb6b9f13eb10bd0fe-20230421
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 93785294; Fri, 21 Apr 2023 09:33:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 21 Apr 2023 09:33:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 21 Apr 2023 09:33:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDo72vcbM4wLftX2Ctz5LgWONAWZv0FhYtdwpNz3B9JvCX8E6boz+gRPQxBOHm2wXIdVSOgJYWMVYINZzXwlYGXI7BAoXhBxS8pPqbSVHRvjjaxYodKgVR8C9q+9uV11cza2FJ6hYi0S5ZQ0S+rhqMyb0Cg/ieiYBVu2ZoXSNHUfQndi2o94qFJMAbJBwNVlNGMBGQCVGoeICQfrRhBsjhQzJULG2g4j2VaO062QVHjO0lF9xlFMBp+KXfocHmE0+Dzt0RV2yuEq+5j2GJzoLstoyAohnR1V0VBG/WESzxJog1THbACKG5yrCeQ5QHr7STcSAy58auH6VujulNBBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/zQtuSsS70u63JfRkQ2B0ycZshR1PtOyRKKngEcBuc=;
 b=duYlQ4kfUoGNXw/EQGTSpplJ/r/zQ6GsjtCyO8tcyxnfgN/vRMtqlxsy+FFXg6HJnp8f9OvOE/G89GowOHWMZ5t3n9jd6TRgdqFl6EXylgjTEyoXAQKt8uKp2SxkH+I6CG8a3H7U7uhDgZ0AQZDUdJN4A+6q9Rh7erWrTVk7QUO+jrNnKrTRy+j66QcQy03ipBdDkOr/+BhAHjfCLBnEC77A297a2biCWbN1z/qeo540fQNxaHmw/T9HvRepedk534iKO38II7xaFuhkvfll3O1TEpTDwLr8sMWWJCyuL3l49p9+ZYu0/Y51uztmn9tQyGNoX0NkCjkV+iSTlFax5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/zQtuSsS70u63JfRkQ2B0ycZshR1PtOyRKKngEcBuc=;
 b=BAWkT0jVZyly+GrpXz8CbFiLt2n9H/E3anBs+KGt9Cr5DVrbopm6yTFC31kscNwfN8CxM4ZRtyaW/VnblfCBZ9FuyGA8mLaehWfebX4iuJADrYAyFbtmdI4V7EkRA/wG0oRu/saDKZcccUPdRfkGlPGhlLGoK1Fl2gfAuD+l28I=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PSAPR03MB5239.apcprd03.prod.outlook.com (2603:1096:301:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 01:33:08 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 01:33:08 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: mtk-xhci: add an optional frame
 count clock
Thread-Topic: [PATCH v3 1/2] dt-bindings: usb: mtk-xhci: add an optional frame
 count clock
Thread-Index: AQHZcNY6ckyMlrtWpEOXwexiXp4JEK8z3LiAgAEkDoA=
Date:   Fri, 21 Apr 2023 01:33:08 +0000
Message-ID: <eab50b658eed60e27ad220cc4310b4d29400fcf4.camel@mediatek.com>
References: <20230417024213.17973-1-chunfeng.yun@mediatek.com>
         <ZEDy1bTsU7AsF2kR@kroah.com>
In-Reply-To: <ZEDy1bTsU7AsF2kR@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PSAPR03MB5239:EE_
x-ms-office365-filtering-correlation-id: 1880c75f-f549-4048-3af9-08db42085c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2KnEN1/iiAjIYMwOtdl4wVQRHxRbcnzMZUO9jDajmydrYtoQwiNCyD0j/q/mvg8CvoBfT9Ic04Sq0g6mXzawwvjdBCRDQNwaJ+xJSkLbDv+Ky8XJSptLr2FiwV2n9DY7zGKfPbXPnddSp+c0rvU12Eqmj1KIu8N3bt4MpAxL7Nj0prmU6/2JRxsGrz/xDYQGX2yM/BJ/jfUHSqPBehDKV0pw0y22aD0xeK1Ie009lQ3M4kO9+Jq1ZFv+4vypgkV4Y5LjBIKkP4ya6MBUz0ntLJCix2TAhJ4QvggQdrfvSMYMdnKzGeKBhUIawOXrWwGOBneSpvmZbIJVAdpGuJW3StFE8Udjy8I0rkx4T9rYEyD+eOUa2R9z3wOHtzyRRjZ88+dAvLnKxe78PPlDH7zoKNyItoZwlbCjTYZbRhZlTVbkvveA6mkrwus0qoCHie3ehvrMAc9dzsdryjCzChowTKT9TySl7VV0pomUMFW37BSkLM3ZijOPtUX98h8ADj4baORdcJt+odBwcbHXq8oGl2Sf2mNuh1+29gVPK/J/5WSY1kHeVtryPbDt20xbgIWpWpYENZaA39R57Xc/S+4s3oUbxsQM4SRpdRmmpxB45zCXGTHlSu30dcxTLT7n0coff/aGou94VGsVTWUkF5eOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(36756003)(85182001)(7416002)(4744005)(38070700005)(2906002)(38100700002)(8936002)(8676002)(5660300002)(86362001)(6486002)(71200400001)(6512007)(26005)(6506007)(54906003)(478600001)(2616005)(83380400001)(186003)(66476007)(66946007)(316002)(66556008)(66446008)(41300700001)(122000001)(91956017)(4326008)(64756008)(76116006)(6916009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R05NaGJjeEpWUitudzlmV3cvNkZiaXNHMmxTRTA4WG53THhkYzBmUXlUcnMz?=
 =?utf-8?B?a1ZXeGhsM005Y3ZGbU1UcWNhc1pSMFVVS0pRTzZ2THlWOEdHNjNTS2FCNThG?=
 =?utf-8?B?RVRyQkc0M1l6bHZkREd1NUp4Y0hlNlhKa3liOGdnRWRwZi9MTitGUmtxMW82?=
 =?utf-8?B?bVcxK085U2RPZFFCZ2YzL1FQeTNLU2VxcmwxcDBrYnl3b20xV3o3Q29PQWw1?=
 =?utf-8?B?UU95VjRCYUJiaUprajNVZ0h0VDl3MVUxR2dPMEcvZ2diaGtqNjRlcFR2YThQ?=
 =?utf-8?B?a1BBalEwTGFJRitOSUlvRHFoVnlCUnFOOEhNd0duMGNuajB1N0tBNkZHSU5G?=
 =?utf-8?B?RVFMcWRjMTdqdEU0aktRNjZNazFSelphQ1U3TW03Z255ckVOYm42M0RrK1Na?=
 =?utf-8?B?VzdvUGphRUdIVkk3NHp4Ym02K2pwcEZHSlIrdTU4YlpHMVh4Z2tueGErbmVo?=
 =?utf-8?B?WGFFOXlYN0o1dnRUMEowcHBsNEd3L2l5Ni9ZR2ROWDg0QzM3azF4aWZlMVBD?=
 =?utf-8?B?cHhyVHllU2FEME9rdFVUSjVBbVhkWURjQUV1V1Y1L3d2NEZITnd3OXN0b25C?=
 =?utf-8?B?UXBIT0NPczFhZDNKa1VMVWI3V044MUUvcjhDZzd2MUlNcGMra2ZVSEdWck5v?=
 =?utf-8?B?cVg0MC80dUdsNngzLy9vL0lubnVMUWRJODNmSmhhRkhCcjh1WTBLcnpLZnZ0?=
 =?utf-8?B?bUJuZ3hMUVhBRnZRam5KSmlEcFVTZy9IQ3phK1U5OXVPem9tS0VMUGUvTVN5?=
 =?utf-8?B?SVB3OFJSNlRkVHduemlBZklPVjJTR21jTHkyRU5oeHlSREFsN0RaUmdmVm9h?=
 =?utf-8?B?NGxLSEtISzQ5VXlLZ2F2N1Y3aDY2alVIL2x4KzRXTk02SEx1dmV5ZFN6SUlp?=
 =?utf-8?B?OW0rS1d6TUVrd1JHY25SOFJBWkZuWFVqNXp1UEpaT3VXWWY4QmhER1RjTzhI?=
 =?utf-8?B?cHVua0w3S0FQSTAra1FibWtiVFZzc1k2U29nb3Q2ZEdpdkpvbnBhMngrTGtl?=
 =?utf-8?B?WFpZVTlwS1VGODMxU1VQT3cxUCtkTDlmTzhXZHo1ZWNmeWNOYzVRcTMzV1cy?=
 =?utf-8?B?RXhQMDJYUExLSVlTcFlFakVaZEpGeS9qUU5QVThYSE9wV0Vad3pnT2VsVERa?=
 =?utf-8?B?UGJhUG84eXVzOXBkYkJZMk93a01wenQwdklFS3RDSDViUGRJN2R2VVYwL2gz?=
 =?utf-8?B?enJDUVNIWnEvQVcyUGRpb2FlTkZWRXMvZ29vakI4VWVrRDNZUFR1eTRPaFFY?=
 =?utf-8?B?SUJpZXc3WUxEYVZycW94a2NORS9jdFNaMjdRSVpHMGxCU09Da0xLWG52eVR6?=
 =?utf-8?B?VjdFaXp6MVo2RU52S2swb2x0VVNWVGk5dUdmSVhMdmwrSmpkQng4blVlOVc3?=
 =?utf-8?B?N2FXV2xOQXlpcDNEeUcwUWROS0F3V2NTWUk1SnNqcVJlWklyVmRoQ0NlU0xC?=
 =?utf-8?B?eFBnbnFkRkR2UFN4QmU0MDN0VjJ5YmphY2JwWlQrS0RBeCtQRHZCaTR4YTFX?=
 =?utf-8?B?SjR5RjhGd29uZ0ZoU1VTVDFxcU5PaHE5eXhqSVB4RG5kalNuMjhGTzlSd2lM?=
 =?utf-8?B?SUtLNW9BK280NE13YkJKTzB4bkJ2aE1xbzNLb0dha3RiWFdMdGcybnJRd210?=
 =?utf-8?B?MGZraWdvT056clo0eGNYbGFnekgzbVRmUHNDRFpXb0RQNnhxSS9TcDI4SFll?=
 =?utf-8?B?MUt4clhsajJENXZaSkp4Vmt1bm4vQk1JdnczU2RjTEZHNytTL04wQ28xbHp0?=
 =?utf-8?B?aGJJMVhoSXRQVHFPV1RSeVZjYUVqMldJK0dRVXptRnp2SmNRbHdra2ZoWUFG?=
 =?utf-8?B?eU45T2dzSlkrRHgwck9GNGNtZm5PWFg2MlNyRHE4ZkFGWkhIL0FWbVdMWTRK?=
 =?utf-8?B?czRMTGNibTJOeUJrZWxGcmVLa3pkbVdNQ29FaHlQb0NvVVZLTXEydkdVNlda?=
 =?utf-8?B?aWVlN0JuQkpYTW9uaUZNNktUbzNCUlhvYVZVbXFDS2hxSXNOcjFHVWRpMVN2?=
 =?utf-8?B?WExla25tSElzVTFSSUtxd1VPRG1xaEhmS1Z0SXFoMHFZQUk2R2xQUDlSdWM1?=
 =?utf-8?B?NWJKTzNBYXFOa0xrMHNpVndzQUtKa1cydGhCWXRyWGlLekpVMDdsMGZnRFNk?=
 =?utf-8?B?ZG90OTdIVWhLQWhLRTVsNG8zaTRlKzhISnVMZ1JCb09Pb01mOFdZcGlwS0JY?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AF48F2FC540B44A9185BE39241D73C1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1880c75f-f549-4048-3af9-08db42085c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 01:33:08.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ue5Tluoi3ehmEzwQUinhmfFRjNMNfys8g/Sdl1J5voSDCZFSC0dh5F/DHN13QWV/xTXElgxDzqtYnmGfV03N3zq4hP57uM/KiFgyGlmVk00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5239
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTIwIGF0IDEwOjA3ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTA6NDI6MTJBTSAr
MDgwMCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IEFkZCBvcHRpb25hbCBjbG9jayAnZnJtY250
X2NrJyB1c2VkIG9uIDRubSBvciBhZHZhbmNlZCBwcm9jZXNzIFNvQw0KPiA+IA0KPiA+IEFja2Vk
LWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+
DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYz
OiBhZGQgYWNrZWQtYnkgYW5kIFJldmlld2VkLWJ5IHRhZ3MNCj4gDQo+IFRoZXJlJ3MgbmV2ZXIg
YSBuZWVkIHRvIGRvIHRoaXMgYXMgb3VyIHRvb2xzIHBpY2sgdGhlbSB1cA0KPiBhdXRvbWF0aWNh
bGx5Lg0KPiBUaGlzIHJlc2VuZCBkaWQgbm90aGluZyBidXQgbW92ZSBpdCBsYXRlciBpbiB0aGUg
cXVldWUgdG8gcmV2aWV3IDooDQoNCkdvdCBpdCwgdGhhbmtzIGEgbG90DQoNCj4gDQo+IHRoYW5r
cywNCj4gDQo+IGdyZWcgay1oDQo=
