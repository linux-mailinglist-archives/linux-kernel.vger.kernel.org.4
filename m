Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4426A0B98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjBWON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjBWON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:13:57 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC62332E;
        Thu, 23 Feb 2023 06:13:50 -0800 (PST)
X-UUID: 463aff08b38411ed945fc101203acc17-20230223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X9qvTthxuNqusWEiFfkgZsHBxyc0kG68JJVPSeaQmS0=;
        b=j6k6mjodtWYN3c05sQnvXGvuRaQ+OBSQtZyAd6p0+SeHVL95k3HdJJpe6Zg16oWM7ReZQDawRgSpMR/xlOpOJfHQWcqDh4AE+KR/tOb57n/LryD3d9JDMQ8zFTQY3pe/64YQyasdvreM8eoeF96nunqKL7Mo1YiSBBiFkWp8lkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:42a1f997-42c2-4c79-bc19-7e770a8380ce,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:3,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-2
X-CID-META: VersionHash:25b5999,CLOUDID:4db98026-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 463aff08b38411ed945fc101203acc17-20230223
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1411355689; Thu, 23 Feb 2023 22:13:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Feb 2023 22:13:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 23 Feb 2023 22:13:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au0C1vX8ttRTiTXlj55cwHmSw+gB5SIzBlKQq2lOS/Wz9pswCneRB99YT8WoPa9Kinr8nfpy9NqgJFnYjufETeKVAYmisf1E4goyyfgXbtxbsElq8MEiJrXxL+OMzJFUybgLd0QJ+atDZVto2F5FpCjzAtv+5iZRNrKfn/w6iHsSZ22p1dCcBjR8c74HFtA5CBCnTAoTZVtqVNIoaKvatvrfe+X8+n5f28594AhSdJWW/yfSbhS27pEWPFkaiEODhSLYztWzvdAaQ79SPRREK9/zlZvtUZhsegPRbfsab7XKY+3VYvvcc6B3F39DN/uIXV/DWUmAZxjapQiDuF16iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9qvTthxuNqusWEiFfkgZsHBxyc0kG68JJVPSeaQmS0=;
 b=clAE0qohFRpUWcIQfuOzrbTU4SOoumlTjZtDjiJU9zkjkiPSUZX3gKn5hoJs6UEpptOCuKKdl/gt5mX/xXw9KOH+gjVAIG6oNDFN+2rAN60lc7dQOsjccjZBJLU0bttW63eq9k+Zs/IZWTKXPXxR7X3A3uEJkqoShHYmgtcJ0UFhRPtj11VhY69JEt6+cc6bbUd/b1a99my3Tc6pBFg2ttKDo9Nd+cOOb9ckZG1waphM91ZFNP1AnLhtALnzEQNr1RqoYU6qCVt2ysqnjY4t23s+IGDYNhHFepnE/PvFpr6OIYP3d/qXFn1+N+C2hDBguHMQgKoWBG71Wm0UOj2mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9qvTthxuNqusWEiFfkgZsHBxyc0kG68JJVPSeaQmS0=;
 b=VWaGFDZ6nh96TP9Eq4wZ9q/YAP/ER2apn5dJooyAnlkeIxwWHduBfND8gdnAqNbEKJ36xZU707aOPlXSYngSFJdp83ep9WJYREGufpNv774GZNrAef4ciUJF+Jbk0pvsJjXWFxv/x7QAcaE+wZNUDYsQjiSRdTYFzvVAiADZ28E=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by TY0PR03MB6776.apcprd03.prod.outlook.com (2603:1096:400:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 23 Feb
 2023 14:13:38 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 14:13:38 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Thread-Topic: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Thread-Index: AQHZRmqDD+FeSB663U+0MLLNl8/aSq7cUnOAgABCwQA=
Date:   Thu, 23 Feb 2023 14:13:38 +0000
Message-ID: <74bedcff32df0c93c14b004814017f3344247528.camel@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
         <20230222030427.957-5-powen.kao@mediatek.com>
         <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
In-Reply-To: <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|TY0PR03MB6776:EE_
x-ms-office365-filtering-correlation-id: 8b14c65a-d32d-4994-c69b-08db15a8287a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKk1fAVo+KPCYrYoDhIpIb5QHGoCIsxNlAqjnDyk691oQkjUMwZ1locEB5oRPlZQDqg7iRwDBlUekN8h58U/4s3kmIUkSbk0fppdTR7yjqFbIrxRWvRWki7f5PXEt6+q4EMtqk6DspupG4dWieq4ppfeHoutEYNBV9IIoPWCPN058FkZZjveKpFqR+BtzZpJiXUwGPKktZaNE2R3aTtr/6/VkfMplayYi0BJOBiqpnPALMyKRD+qkQag+HasSbzkNbekNoxqsjdP2wd/9H2W/ld/bQDoJV8VzQMQuEfFvtqFiQUDQLMWTUvAxbDXY0w2tyGPVFKLoIbVDmrlGwdV9ShNRdhKIPwh494S851GQuvBSUR4lIbT/jPiVFsGxtqqv/wkLEUeKAJ0rJ7J0L2SLxLLMRQQCbddnYSXKYIQiyMzxAX8HBdw5gKbEt5IK/VTVjsttgiYAZvI9+MiWtp4wbbbZ16vf9FE2hnAXbrxTZ/HFg/0bP3VGjxIjbfh6vvWXztJMhShtDQjzrGhZAacJcbegCi39eQr8dt2z+FJe+JBP+FjOww1X+ZTTy/1AFnQ8YoQIlKPn3NWsmPve5YLk79aBp2hTe4ubl15m1nuI2KrWFT68Smm5CalZc4SLOdYtQBFKoQut7Cmh6OPJ4mp+y4Euzkul45nG4Rp4iZtWANnqq0UBbvYPjCp746WphDCVKs03yL+2F+Zf25vOJHTVEG3IyQK1TddyiZfHBSIYHjUJgCkFpDLFf8eG4JFXM3D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(91956017)(76116006)(4326008)(64756008)(66476007)(66556008)(66946007)(8676002)(66446008)(83380400001)(86362001)(2616005)(38100700002)(38070700005)(921005)(6512007)(122000001)(36756003)(54906003)(110136005)(85182001)(316002)(107886003)(53546011)(26005)(186003)(6506007)(71200400001)(478600001)(6486002)(2906002)(8936002)(5660300002)(7416002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGQyU0tGT1IwWTFzalA5NmRIdjcxOU15UVMrZmtSNmRUWjkrUmhqZi9Pd25U?=
 =?utf-8?B?RHlhdWVzVUNKaGFkUkxtTHBvYzZkamRpazJBK29NbTBhQ2dOL2xqS1o4QlBN?=
 =?utf-8?B?MktLeC9JaTZoL1BTbm9xWkhPdDhhRFAxcGsrQzNFZUhSUHhBRFV3b2U0RGJh?=
 =?utf-8?B?Vm4wbisyQ2tqdk1kQUVhM1BMNTV1UjB0UEo2VTFLdUhJckFCbXV0bVl0MzBR?=
 =?utf-8?B?ZkFwVXZpaWpGNDlQZVZudGpOUFd1U2l4ZGJrY1FMZmtqOEJ6THdtZDZwQXZW?=
 =?utf-8?B?WVhTT1Frck05SlhxOVpiTkhjdDd5Y0JjSUpBMFhnU256aTJjajdBSXFFRXB1?=
 =?utf-8?B?ODF1d1VHa1owRXJCS2RWM3gwZHQ3c0dKNUhqZ3VYdWFmQzd0YXM1bGE1dHZm?=
 =?utf-8?B?YWZjbVlpdUxLU2RZbExxT1BEUnZ3cFExb09nNGlncklqZjY1VWRCQ2xVWUdD?=
 =?utf-8?B?cndhYlBKcWswZTRnZHdzTjY0SDY5Y1NITHQwdW9hMVlvaWoyNTYzVUlibFFZ?=
 =?utf-8?B?Z0FLbWpoMUIxMUUwRGh1dzF4SEtVNWxXOGZWV3FtMFJPS3BrY2h0NzArckFH?=
 =?utf-8?B?OVhPYnBOTVVKdkduQTVVK2h2OFliRGZNVm9aMU9Ca0wvb0QxT0lzM1lqVWt1?=
 =?utf-8?B?NFVMOEFxSUpTb2dEQURzL1VZZlpzU0k3ZVhrMk9yRzRZRkJnSFBIMWxXSDlI?=
 =?utf-8?B?UjBXWG90by9sQzkrdk9peTh0TnF5SlRYckZkdjF0QTVqSitZUU9NZ1Vpc2xk?=
 =?utf-8?B?YnNGcXg5bTlPZ0hWTTcyM1plTVdVTWU2TE54dmNGQm50MktsVW01eU00ZWQw?=
 =?utf-8?B?djNJUlJFUWtHeHdYTUJ2cnU4dEdvclN6Q0w3K3g3ajhQckpnYlMxRk5Kamll?=
 =?utf-8?B?Rno2a1dyRmdmVVhIc1JuSTdrYjBXZXl4WTQ3RWFrZWRvZFlDcUFxQ1FGWW53?=
 =?utf-8?B?TnFtT01lenEyUjR1WjZtcnVjaW4yWFVTOUxTWnZGSVBCYVpKWmYxeEVwQU1t?=
 =?utf-8?B?ckVoOGkwR0lwT2hrb2RjbUthRE5qWkRacUc0Z3k0cS9LMVdFc1hZa2FUaFgr?=
 =?utf-8?B?MWxrdHk0NEZiUC9zVzQ1MGM0bm9DQllicHg5TDhNbHR1cG1Ici9DK0JSNHk0?=
 =?utf-8?B?RHRJWURJb3ZHTGJ4cmRibmFHb0FkVzBEZTFabFNjdUl5QWpBNGt4T09aZ3VI?=
 =?utf-8?B?aEMvejBjdFY5MWowUnBGb3FaZytTdVMzMjJFd05BRnJyeVZJUEZNK3dQRGJ3?=
 =?utf-8?B?UWJvRExZb1B1cVVQZnNIK25vSmJEa0FZMWdLbVN3STdtbDBXdVZQeEdBdHdk?=
 =?utf-8?B?eDQ0dmp6L05KMFJnNkw3dDhBeXA0Zi81b3hLMFhIbzd0QURzYWh4T3o2dVg1?=
 =?utf-8?B?VlhIN2h1YUZ2dUpRMnNmVnBjSUY5RzdkZWdVV0NpMjdEQVk2UnlsM2xiVXFp?=
 =?utf-8?B?bUdIVnloanVINTE0QzRhc2JETG1wdjVPelFWT3JyYTJaMVpZZ0tyOTlld3N3?=
 =?utf-8?B?ZXRiQk8vNlNreExDSEd4clhYNFhnYnhzMUp5Z1hsZENHMWhXNHFHQnYyRHJx?=
 =?utf-8?B?TjRHM2VhNWZoU3IvODhGYXNoaFNDazZzTXd2WG1TdFVCV21aeG1GK1I3Ymsx?=
 =?utf-8?B?ZnNoM2lnT3hENnNiK01YQkNMV3ozdnJob25sMTZjSjdWc2VCTGxsUWtTaDJp?=
 =?utf-8?B?NWQ1aUREOFpvUXBXWnpQeWNqTm1aZmROS2NISDFRZFhxeVZ4QVg0OHBkakZG?=
 =?utf-8?B?ak1RVDFrWmVPMHpIcmV5b3d5OGhTMXRRN3cwUEhucGhISDMxemhQRkFDeHp1?=
 =?utf-8?B?NkNibVY4VThUNFQ1bEFFVTg3blZoUTFMbWhPTXo1aXhoUGxwWTN1eFdHNSs4?=
 =?utf-8?B?K3JJWTFOQjR3cURVWFJ6dzNBbC9sbndIYVAyRDNhSDlya2RvbHZHTzdsU3c4?=
 =?utf-8?B?WkcxN01abmU0TlZ3dWd5a1Q5MGpCdWxkYkxEVGRmWmwxL2R1V0xzdUxhQ0w4?=
 =?utf-8?B?VlBhMzhmdmpFYk9Nb2huTGNheTBvMEpPYUdqNWRMNGdZV25wRzhwa1JMeS9u?=
 =?utf-8?B?STY1RWsvbDdFMFd1elBCMVZ2SmRaTHF5K1dpTWpHSGhKT0NwRCt0dEZRNU9v?=
 =?utf-8?B?SFlvUE81cERqY2xVWnIxbGwrWml4L2Y2YW1NTENMT1JLS1dVQmlSNmhKV3dK?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A8AD11CEEC7E848AF8F0C7CC617B115@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b14c65a-d32d-4994-c69b-08db15a8287a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 14:13:38.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1E8dSG/E28xd2E9VC+JZnz77AnF4VQAm7UI/leLK5sgppVRih5XHeO4CA/HH0sFrkSkvw/ywiEzt6ORfacIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6776
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWmlxaSwNCg0KVGhhbmtzIGZvciB1ciBjb21tZW50cy4NCg0KVGhpcyBwaWVjZSBvZiBjb2Rl
IHN1Y2Nlc3NmdWxseSBkdW1wIHJlbGV2ZW50IHJlZ2lzdGVycyBvbiBvdXINCnBsYXRmb3JtLiBB
cyB5b3Uga25vdywgbWNxIGVycm9yIGhhbmRsaW5nIGZsb3cgaXMgbm90IHJlYWR5IHlldCBzbyB0
aGUNCmluc2VydGlvbiBwb2ludCBtaWdodCBub3Qgc2VlbXMgdG8gYmUgcmVhc29uYWJsZS4gDQoN
Ck1heWJlIGRyb3AgdGhpcyBwYXRjaCBmb3Igbm93LCBJIHdpbGwgc2VuZCBpdCBsYXRlciB3aXRo
IGVycm9yIGhhbmRsaW5nDQpwYXRjaGVzLg0KDQoNCk9uIFRodSwgMjAyMy0wMi0yMyBhdCAxODox
NCArMDgwMCwgWmlxaSBDaGVuIHdyb3RlOg0KPiBIaSBQby1XZW4sDQo+IA0KPiBPbiAyLzIyLzIw
MjMgMTE6MDQgQU0sIFBvLVdlbiBLYW8gd3JvdGU6DQo+ID4gK3ZvaWQgdWZzaGNkX21jcV9wcmlu
dF9od3FzKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHVuc2lnbmVkIGxvbmcNCj4gPiBiaXRtYXApDQo+
ID4gK3sNCj4gPiArCWludCBpZCwgaTsNCj4gPiArCWNoYXIgcHJlZml4WzE1XTsNCj4gPiArDQo+
ID4gKwlpZiAoIWlzX21jcV9lbmFibGVkKGhiYSkpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4g
PiArCWZvcl9lYWNoX3NldF9iaXQoaWQsICZiaXRtYXAsIGhiYS0+bnJfaHdfcXVldWVzKSB7DQo+
ID4gKwkJc25wcmludGYocHJlZml4LCBzaXplb2YocHJlZml4KSwgInElZCBTUUNGRzogIiwgaWQp
Ow0KPiA+ICsJCXVmc2hjZF9oZXhfZHVtcChwcmVmaXgsDQo+ID4gKwkJCWhiYS0+bWNxX2Jhc2Ug
KyBNQ1FfUUNGR19TSVpFICogaWQsDQo+ID4gTUNRX1FDRkdfU1FfU0laRSk7DQo+IA0KPiBJcyB5
b3VyIHB1cnBvc2UgZHVtcCBwZXIgaGFyZHdhcmUgcXVldWUgcmVnaXN0ZXJzIGhlcmU/ICBJZiB5
ZXMsIHdoeSANCj4gZG9uJ3QgdXNlIHVmc21jcV9yZWFkbCgpIHRvIHNhdmUgdG8gYSBidWZmZXIg
YW5kIHRoZW4gdXNlDQo+IHVmc2hjZF9oZXhfZHVtcCgpDQo+IA0KPiB0byBkdW1wID8gQXJlIHlv
dSBzdXJlIHVmc2hjZF9oZXhfZHVtcCgpIGNhbiBkdW1wIHJlZ2lzdGVyIGRpcmVjdGx5Pw0KPiAN
Cj4gPiArDQo+ID4gKwkJc25wcmludGYocHJlZml4LCBzaXplb2YocHJlZml4KSwgInElZCBDUUNG
RzogIiwgaWQpOw0KPiA+ICsJCXVmc2hjZF9oZXhfZHVtcChwcmVmaXgsDQo+ID4gKwkJCWhiYS0+
bWNxX2Jhc2UgKyBNQ1FfUUNGR19TSVpFICogaWQgKw0KPiA+IE1DUV9RQ0ZHX1NRX1NJWkUsIE1D
UV9RQ0ZHX0NRX1NJWkUpOw0KPiANCj4gU2FtZSB0byBhYm92ZSBjb21tZW50Lg0KPiA+ICsNCj4g
PiArCQlmb3IgKGkgPSAwOyBpIDwgT1BSX01BWCA7IGkrKykgew0KPiA+ICsJCQlzbnByaW50Zihw
cmVmaXgsIHNpemVvZihwcmVmaXgpLCAicSVkIE9QUiVkOiAiLA0KPiA+IGlkLCBpKTsNCj4gPiAr
CQkJdWZzaGNkX2hleF9kdW1wKHByZWZpeCwgbWNxX29wcl9iYXNlKGhiYSwgaSwNCj4gPiBpZCks
IG1jcV9vcHJfc2l6ZVtpXSk7DQo+IA0KPiBTYW1lLg0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiAr
fQ0KPiA+ICsNCj4gPiANCj4gPiAgIA0KPiA+IEBAIC01NzQsNyArNTY5LDE2IEBAIHZvaWQgdWZz
aGNkX3ByaW50X3RycyhzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KPiA+IHVuc2lnbmVkIGxvbmcgYml0
bWFwLCBib29sIHByX3ByZHQpDQo+ID4gICAJCWlmIChwcl9wcmR0KQ0KPiA+ICAgCQkJdWZzaGNk
X2hleF9kdW1wKCJVUElVIFBSRFQ6ICIsIGxyYnAtDQo+ID4gPnVjZF9wcmR0X3B0ciwNCj4gPiAg
IAkJCQl1ZnNoY2Rfc2dfZW50cnlfc2l6ZShoYmEpICoNCj4gPiBwcmR0X2xlbmd0aCk7DQo+ID4g
Kw0KPiA+ICsJCWlmIChpc19tY3FfZW5hYmxlZChoYmEpKSB7DQo+ID4gKwkJCWNtZCA9IGxyYnAt
PmNtZDsNCj4gPiArCQkJaWYgKCFjbWQpDQo+ID4gKwkJCQlyZXR1cm47DQo+ID4gKwkJCWh3cSA9
IHVmc2hjZF9tY3FfcmVxX3RvX2h3cShoYmEsDQo+ID4gc2NzaV9jbWRfdG9fcnEoY21kKSk7DQo+
ID4gKwkJCXVmc2hjZF9tY3FfcHJpbnRfaHdxcyhoYmEsIDEgPDwgaHdxLT5pZCk7DQo+IA0KPiBD
YWxsaW5nIHJlZ2lzdGVycyBkdW1wIGZ1bmN0aW9uIGluIHVmc2hjZF9wcmludF90cnMoKSBpcyBu
b3QNCj4gcmVhc29uYWJsZSwgDQo+IGVnLi4gZm9yIGVhY2ggYWJvcnRlZCByZXF1ZXN0LCBpdCB3
b3VsZCBwcmludCBvdXQgYWxsIGh3cSByZWdpc3RlcnMsIA0KPiBpdCdzIG5vdCBtYWtlIHNlbnNl
Lg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQgbW92ZSBpdCBvdXQgb2YgdWZzaGNkX3ByaW50X3Ry
cygpLg0KPiANCj4gPiArCQl9DQo+ID4gICAJfQ0KPiA+ICsNCj4gPiAgIH0NCj4gDQo+IA0KPiBC
ZXN0IFJlZ2FyZHMsDQo+IA0KPiBaaXFpDQo+IA0K
