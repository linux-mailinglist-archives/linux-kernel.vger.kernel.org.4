Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7A72DD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbjFMJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjFMJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:13:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4366B18E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:13:03 -0700 (PDT)
X-UUID: 7bbd31fe09ca11ee9cb5633481061a41-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iTUJZCbSQtT9hJIeygzta7TdKbQV6i6G/MRfRtuk/bg=;
        b=K5M4Mv8Dgzr3A41gJg0BXsseB7lpsy5tJi/zt9xTjRZUQP4P+n2qYQD6D3UsErkyaxbes+qGCw4xPPi0o/Op2yi9Xfim08G7YSmMBcAULW4nhk3TY19zRLwHax89DZyvI3J3DM7MM7ADlba8RAfxeCejD7uXDWlYDxPtNuvCq6E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:8af727a7-0956-4696-b86d-c4f98314a663,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.26,REQID:8af727a7-0956-4696-b86d-c4f98314a663,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:cb9a4e1,CLOUDID:2b94eb6e-2f20-4998-991c-3b78627e4938,B
        ulkID:230613003541ZJ83FOGA,BulkQuantity:15,Recheck:0,SF:29|28|17|19|48|102
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_OBB
X-UUID: 7bbd31fe09ca11ee9cb5633481061a41-20230613
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 519707376; Tue, 13 Jun 2023 17:12:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 17:12:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 17:12:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APAw9kdNQiTz8e1nY6+RqKuTO2Oli0LcYfuOtSj26tfSYU61i7AQcEmNwowYCtP61GL1833gAPmGlxGYhJ0GevGML0KlinT90vG8m9AtEkoJHDr8vhzYvIDxubneIpx25feCTdbSBY6HdBXVPFB5F4+5pqpmDRj3ixjoqRwPRI7kl9SnHYVRDvjKPHb1rpIxbqbAHriirfRoXVesPFVDaUiJMroNUxZ+/BwDR7RVF5JiSLEGqsxqys0zlri7p7/vULBdvJ3jsS+HwAZekVCxVl6erOl0A0IBgzn1w3HCzns0zCI72u2uGgzXou0TSWMYlebGaM6tH24HwPvzMnGYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTUJZCbSQtT9hJIeygzta7TdKbQV6i6G/MRfRtuk/bg=;
 b=e4wJGr5a1jfDyyFtbCiTqwTci4Bj1EBcaex3p5Gm3W4eKRNITNoKV9KFfzgtVN387NIB4pbFEMwpB+F5En1iH5k8rzLWNe9aWaXarWYR+YLF5+0l4Cz7wMHg1lqBG1a+nFxZ3k9mmwbSl+VSfVkq2Yndahl/o3aIP5uL6bGn5G8elaBcsbXSkR/GcGCwH6sAz0r+MV19T8nSsWHYPw5rRQCZ9pY6GBX5dmLV8ZHUHrddBU9Vf7S2nUvNrntJD/9O2CMQphj7aB+VuutUVX4Mfru3YHZu509T6Orf054G1T6Y7oj7Fvnv9VozRsp/ZiWj08HSIwIuYh8CslOLJl5VVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTUJZCbSQtT9hJIeygzta7TdKbQV6i6G/MRfRtuk/bg=;
 b=r3l1fiuqdpCQVcb6PH2j0zLLktL/TYHbhSLAiX9PM0dOOO1Mt9ffb155Ywfr0+lUGjaZ0HB/GS1RYqtxsqesCucUZ7A9L7kCqbMgy7GhyZ+oI7BYdD68x48o5L/8tD5dtDwJ8e8YdNTjjCYmXMcrp+dRTXV8DEOqQ/ZcjtkvRBc=
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13)
 by TY0PR03MB6403.apcprd03.prod.outlook.com (2603:1096:400:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 09:12:39 +0000
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd]) by JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 09:12:39 +0000
From:   =?utf-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWVsIExlZSAo5p2O5aWH6YyaKQ==?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] process: export symbols for fork/exit tracing
 functions
Thread-Topic: [PATCH v1 1/1] process: export symbols for fork/exit tracing
 functions
Thread-Index: AQHZnUDPZZ9a/fA2NE2OTK7wUQSscK+HXbkAgAEWKYA=
Date:   Tue, 13 Jun 2023 09:12:38 +0000
Message-ID: <8fa623a77edd2d8b6ade77903d40b4c4c5992965.camel@mediatek.com>
References: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
         <2023061226-repugnant-upstate-a2b4@gregkh>
In-Reply-To: <2023061226-repugnant-upstate-a2b4@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8100:EE_|TY0PR03MB6403:EE_
x-ms-office365-filtering-correlation-id: 04a5a1f8-40fb-448b-3db8-08db6bee55b4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJj8A/GVY/CAwiDb3gjiddWWgMhJ+Q0kqydiEqqK6ZBCjw7tLX85kQ9u77zNJS/OqILOwj70s1cNTMnUHlJYb2HtVxp2oWN2DZPahKe/hjOhr7n3lww2a1f2UA/RQ49Napj/8H2WWXy4LXQ8/S6UIlDpKdnQEsX7Qe7W5+gb2xf8Fjyxtrgf3RmU9v2tTrKHCg9waQjLxUsFI0ZK6JWHe89IDd19ZAi8p6BlZ5YszaLM7T29fNGHrcSPOoFNHmjBSm5yOaOjKBup8CtOfPf5dG+ZJWH2y9wnOe+gDrko/tBDUn4jKysP3G2NwAXOFjzKx4ufppZU0RX29MEJvNrVSghOAPuXRMvH17yYgINRq/CNdmyku+3SwXNte9+Y+y8oFSDFJErbQ9+/I1DC6nUR0o20ksa/Zthcqd+r2xyR5Q7ldXXVR3EpC0IWaCM+CSHajK2FgEnRpFT07oWvgpI0IyzoUiP80hm0pDhd++T7VIwMwCKfWkDsF7JqI8rXFHutcOvE9deMeL6hJh9bR7Rq6MIJEbHsIL/knVzd4WPuiubSQHnW4R0V/zEfQb3pHo/EKjkzZn4EtRq53iJrIZP9UO0tchxnfTEYKUzLd3s/DR4+OBNpxnKlC4y10i9LtVl8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8100.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(66446008)(91956017)(66556008)(66946007)(36756003)(85182001)(6486002)(8676002)(41300700001)(66476007)(64756008)(76116006)(4326008)(8936002)(86362001)(316002)(6916009)(4744005)(54906003)(478600001)(2906002)(5660300002)(2616005)(71200400001)(38100700002)(122000001)(186003)(38070700005)(6512007)(83380400001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNRL1pvbVRhdDVLSHQ5eE1GbVFVbU1hakhwM25BbVMwOG9oNVBqcXdHZnBm?=
 =?utf-8?B?dWZNYjU0Z1laZ0oyNmhkUy83NVVvSFRRYklJSGF6MGNKeGMzTDF1d0xRZDRx?=
 =?utf-8?B?VkpXZm5sRDZjRWpSK0lwOGY5SEkyUm1nVFVFUjdtaVRtUjdxRHRwSk1PalFy?=
 =?utf-8?B?UUg0OWE5S21hYnZNOHNQYm1VWEQ4WXRCNHpnRjlscjZSaC8vdWpIL0ZkRHg5?=
 =?utf-8?B?c3pMMXRua3E2QlQvS25uYk91dlllbGdSbEVpa2JaSzI0aEcwSTdyQlhUS0py?=
 =?utf-8?B?djBJekRUcjVjelB4TUZQVXBpQ1IyMElYMllNQ3NwTmdPTEpFS0Y2R3NNaE8z?=
 =?utf-8?B?bE1FUzBxcndRTGNKdmcvTWJKUTVSVHBpeHdYcEpBdGFOVExobmg1SHZlMlNx?=
 =?utf-8?B?dHZDdEJzbSs1elpvWGhQVDFTRDBtK0ZMRFFGTXlwdnhjUGl4ekNFUGpGOFRM?=
 =?utf-8?B?cFppS3k2a3NBcDJ3RnVOVlRjeERKbXBFVDYwUVFFWDJyV0o4c1VxaEVGSVh5?=
 =?utf-8?B?NXNvUnpoRDhaZE4yakhYTGYvd2R4dnpIa3NzYUVHb0h1aG9McWJoSFcvK3Jz?=
 =?utf-8?B?RVh4Y2hmUmZpWGt5djdNZjNyNk4rbTVMWkk0YmUyelgyVkJlcSt6Q0JNVERy?=
 =?utf-8?B?MlNPUVNCS25NVVdHVVRPT1V2UmZramp1SUcyR1VTangvcVpaa0NWczlFM3Q1?=
 =?utf-8?B?UkZRbUFWSGl2bFI2OEpFQVY1dG9TY1R5clJWSE0zam5tM1dBdWRuSy9kTzZ0?=
 =?utf-8?B?WHNSMkdZYmVVL1BjSTZ1OFpLUjJ0NWRGVkQ2SXNrQmtqMnpwQUcrZjlhVmYw?=
 =?utf-8?B?L3lGSktVaFFBbHl4U3M5bDRNYzNBR1dNRUdoWkJVT0RkWENyYzRCZVNoYXJx?=
 =?utf-8?B?dlRLdlZvdTFISHB4eWpOaisyVXc5SnNRTFpNRjFhQmNicy9NSnJ1aEhabkVo?=
 =?utf-8?B?Y01LZjN5dGVieS8xTmY1UzdTeW9BWWkrMXBuRkduOFE5ZHh1Q0UzdXVwbDhs?=
 =?utf-8?B?ck9aQzNLUzZ4N0I1dlR4S1VSVXZkcitYeVQ2czRYdU5KMmNoek5rOUFhL2FZ?=
 =?utf-8?B?S1d2cXhsRkV3eXNrSkFyazhJSVZpMXZqaWwveUxDelRHaEkrbG5hRGwvV1Fm?=
 =?utf-8?B?UVZnTExzQWNQMVptRzk4TGFYWDRSN0EzUWtOQ042MU5pUUxvbGxEMmFXS0xN?=
 =?utf-8?B?TkNBTkUrMDRJbjI2Y21KU3hyME9kdVVsSjM5WTVJOEk0TEVYaDM5SXlkQWQx?=
 =?utf-8?B?YzRWTzBkZjl5VmREendtQlZrcU1CUEFWRnJhK1k2NG1BalhBY2laVk90WXBF?=
 =?utf-8?B?djJDeW84UStMMFFhV2VUVmQvdzJPdThyS1RvNkNmUUF2aHc4VlJadFlNSmpU?=
 =?utf-8?B?ajczRmcrZzNuMTNYVzd3cjkrc21WYjJ4cmJFVDVqQlFvM1NpN1VWSFhzQlVt?=
 =?utf-8?B?UlVmakptakx5aitsa1pqZ1pTZkNBRUlDb1ZxUGIrY014bSt5Vi83dFhxL0Vu?=
 =?utf-8?B?d3VPUkFtbk9qelhYNUtnZXRWdVQybXRMc2J3QzB1RkxBR0gwTmVodGNBSXJR?=
 =?utf-8?B?alo3aWtZbGpWUWJybm9xdDB6MUs5Ri9YSG93UTZvQzUwR1pSd0thelRBS2Vy?=
 =?utf-8?B?RVRBQ0taMFU3T29ZSk5sUFlscHlRb3lEbmFhQ0liY3V3bnJkRHRYdUV0RWtI?=
 =?utf-8?B?eFord2MyWWRQRGRIaXVOaVhsU0pFcUMyajU1WUhROG1WeWNBakFsenBScFZK?=
 =?utf-8?B?dHg2cFB1bmlIRDBGYVBxNmFrcFBMVUdYM0xITExVOUdBbjlZMEZLeE92SWRS?=
 =?utf-8?B?d0JWMlo0MVg2bEo5MytGa29scEordjFNZG8wdUwzU2FHb0E0YThOTGhSRDdm?=
 =?utf-8?B?MVBZSGVCUUlpRllZdWo5MWVsZlhtN0NUM1hTQ3FDaVArYlZaZDVUSmRqeEJB?=
 =?utf-8?B?WU5uYXM0aW00eEdLU01rdHlCbUt3STUvVHNFdlQ2Rm9FV0FPdW9RdGkxZGxR?=
 =?utf-8?B?NFJYY0cxemc0Rk5FQ3MxWXlVSXdWb3lEOWpOdnlQL3drNm9VM1hjUlNvL1hs?=
 =?utf-8?B?WXduZ2U1VlJoR0Z2Y2Y0bmRMSUZkdFJVTjQrVFRWdWZhcHF0Q3p6L29YWlpS?=
 =?utf-8?B?K0QzdzZkQ3NjZHBMMEJrMHplNEdUL0xLamt3L0Q1ZHZJdk1lUDVTYUxiUXJB?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <809CDC1F2D756E478CDD7226320C05C3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8100.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a5a1f8-40fb-448b-3db8-08db6bee55b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 09:12:38.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io00LxXLY94KgMofLFT2PPNR7kSCHw2H8Csgt7PEBJvRIPRQUWJiyL7krNEfmj3pJO8ol68vPmoer1o9c3MuQC4/axxbeXQ7w2qLvFQAgOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDE4OjM3ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMTE6MTU6NDFQTSAr
MDgwMCwgamltLnRzYWkgd3JvdGU6DQo+ID4gK3N0YXRpYyB2b2lkIGNsYXNzX2NyZWF0ZV9yZWxl
YXNlKHN0cnVjdCBjbGFzcyAqY2xzKQ0KPiA+ICt7DQo+ID4gKy8qZG8gbm90aGluZyBiZWNhdXNl
IHRoZSBtYnJhaW5rIGNsYXNzIGlzIG5vdCBmcm9tIG1hbGxvYyovDQo+ID4gK30NCj4gDQo+IFRo
ZW4gdGhlIGNvZGUgaXMgdG90YWxseSBicm9rZW4gYW5kIHdyb25nIDooDQo+IA0KPiBQbGVhc2Ug
anVzdCB1c2UgdGhlIG1pc2MgZGV2aWNlIGFwaSBpbnN0ZWFkLCBpdCBpcyBtdWNoIHNpbXBsZXIg
YW5kDQo+IGRvZXNuJ3QgaGF2ZSB0aGVzZSB0eXBlcyBvZiBlcnJvcnMuDQo+IA0KPiB0aGFua3Ms
DQo+IA0KPiBncmVnIGstaA0KDQoNClNvcnJ5LCBJIGRpZCBub3QgcmVhbGx5IGdldCB0aGUgcG9p
bnQgZnJvbSBhYm92ZSBjb21tZW50cyBiZWNhdXNlIEl0DQp3b3JrcyB3ZWxsIGZvciBtZSBmb3Ig
dGhlIG1icmFpbmtfbWFpbi5jIGFuZCBubyBjb21waWxlciBlcnJvcnMgb3INCnJ1bnRpbWUgZXJy
b3JzPw0KDQp0aGFua3MuDQoNCkppbQ0K
