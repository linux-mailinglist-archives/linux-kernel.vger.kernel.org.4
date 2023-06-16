Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15197324C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjFPBnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFPBnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:43:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7D294C;
        Thu, 15 Jun 2023 18:43:10 -0700 (PDT)
X-UUID: 23d09f160be711eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NlMvQ2Qb7myJkgXkgY9lu0BVgyFnjKP0e6aWU/ZQmZM=;
        b=g0CPJY9ePJhIG2xoFUw79zQN1lMZovfBX3yfvj4ATmo7aslACgNaqNWma/AgVY95f8CmPMs8VG4a+05t4nq4nRhk7syFwq0YHGoLnNJ/1u2leGAl/yGcFVJm1CZtuwpsvTTXlh8QH6VGYWoMRNOt+ztnkC+4GdgKKVE9GmnnISU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:fb98341f-6111-4df4-b964-b997f1c52ca2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:ac543a6f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 23d09f160be711eeb20a276fd37b9834-20230616
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 780467207; Fri, 16 Jun 2023 09:43:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 09:43:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 09:43:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx4gANvb8XtttJhOFw8Eag9+l1+OQoD0FLnvSJkPh0EvndBgaJ+l3LtRBH0NHCqO43e+RHIGexxlyZ2X8jJSrHoHDzh2RkzTgi6sxD/6qq8G/yKJvCGrk6FeJXplTw5kUOWeAH6kBKc03z6X980xTE2eALaIRdE7bHf5+FFFbCnwL0VGOPJI8TVDAyXg1rl04QEsFp1QiLUJyMa/pYFuvNP7rXRnYLZZBcLvwj7e9NWYtoyzi6zX021OaaXnNC0MZq/9oiVke3N/rA/cBRFHKNMGJmLg/R906H0znhNKPHkZWx5Lwhka76qF6ihpylitfMej4m0qyImcvSRW0qWHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlMvQ2Qb7myJkgXkgY9lu0BVgyFnjKP0e6aWU/ZQmZM=;
 b=kcD16AKYMgMBRzG+l1m22YI98N4AVapt8lJbsCPsIMX8nBpcDiOsSMt/P0pFIsgXS3kgnwew+UjK5bCw0lg8ElUufjs2B6AGy+MG01gTuB0Vkp0KFpbOvXRH+8Zk9DErQ1zw48BL8WBF7xJr1jc76zdM9o4ynHu2WONnpa0ykwnd5EnGfDSEA0vImhSa53vYLXQN9Y/iqqg70QWL21FqsS5D6gXLt9zQzCTXzDphUyWbpG6Ii2J9+DwjeKJfM0hlGsDorMle/lTs4w/Z0z1nosmDSVmA0uEGL0kNGRDMB3QAsz5hepF19pfo01wMRNvRqMApnn2DgM1g3o/bju9FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlMvQ2Qb7myJkgXkgY9lu0BVgyFnjKP0e6aWU/ZQmZM=;
 b=QF4PT5qGVz/9b1c6iL/hkuK2ump/KF9zeQp2jm+EihZxSOaZAcoRl/nIzgUeWkJdBCP5eMCKz50l4d3wmHQBvHGhiXzPoA/I23oKS5Dfb5ICCfT0rm/+TPfdsSprQw+78niEk4/sc5eJ37tnyOQ2fnrPF+crupdepF1aGCb+HKk=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by TYSPR03MB7426.apcprd03.prod.outlook.com (2603:1096:400:417::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 01:43:02 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::1f80:c0e9:7d9a:9705]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::1f80:c0e9:7d9a:9705%4]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 01:43:02 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mtk-sd: Set src_clk rate/parent for accurate clock
 rate
Thread-Topic: [PATCH] mmc: mtk-sd: Set src_clk rate/parent for accurate clock
 rate
Thread-Index: AQHZn13NAWYILzWXu0Wjsl8lf8Aa66+MqQmA
Date:   Fri, 16 Jun 2023 01:43:02 +0000
Message-ID: <81f1d2bf7d3e7929a9e57572ce8197cfa6dc4582.camel@mediatek.com>
References: <20230615074701.34063-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230615074701.34063-1-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|TYSPR03MB7426:EE_
x-ms-office365-filtering-correlation-id: 21f167fa-f2f9-473a-8438-08db6e0b05f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6ViqOTKDIKci4yn+e560HYRPx9hz3NCXeBxSaCp3uD5OFM/X+QiMGXHhCU74SkJNazD1R/PKOZ36mAuBQjHjG+MG4MiQ0G14tKzvCvDAaXKRs+lx2EeXEDXgCZgxiRI81fSNKPWAuSS3rUPJEMdEHePX5PL6uDgL61EQlTJKdZ18+VA7sN4+LfbaleLNKRLBynCSHYi60H0CbSC4LKkLmXNvwsTZaB2JTPr3+CHSU98tT1Ug5AtyFTFvfvpUq7VGLysR5rYCf+Oxck0lYFj71IkeSJOsNMTof41fEe+G7njKMW0yYpExDoLbWObW4vgyILxeR8NeJ3kQfOpldA+4Hc2wi4AmTYKe9AHrvfGJJTD3X2FeRAvVVYmGFrvcf3GAscyw4DatJGHWYOxhCWve/O8vCDO6OluneRf3JfxxrUgL1R+1LGgHW7ILUMXJGyKw2PEau8PQIGB7ZsrG/14saPPAaKxz/GbsosneiDcQvs8YosyXRphAq5AQ7iwyLJeOukxGDz9MVsk/+O+Qza6ZWFZ+avMJmrH7NHBtLMXxMgF9d/5SUHYnVW46Fp8CPa1wLe9qHtOd725tUV/0aoVp/T0F7znGzH+dvJFX26QqkanGOEe8VOfDCwHgrd+mHo/MBLM0H1pX6MIruN2Ybis7oOmJM04Lf6fb6Dv9E8o/9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(38100700002)(2906002)(2616005)(85182001)(36756003)(86362001)(110136005)(54906003)(478600001)(122000001)(83380400001)(316002)(71200400001)(4326008)(6636002)(91956017)(76116006)(66556008)(66476007)(66946007)(64756008)(6486002)(5660300002)(66446008)(8936002)(8676002)(41300700001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXNOYUNIRUV6ZWcwQ09UUWZ1MVJIa05ZT0pxQm0zajJKbTQwNHN2TlFTVXY3?=
 =?utf-8?B?OGVmT1BKNEtiYmZ1UWthZXhyS0tuUW5ycG16TkpSUVB6MGE2SUh5bXUvd1Y4?=
 =?utf-8?B?MG5HaFpoYnFoZmxhMlQxUlExT29QN0RmRWZYVjJCYXpiWm52RTJ2TnhFd1B2?=
 =?utf-8?B?UXIzY1dhaWFGb1dVNko5MnpxM0s0RkFSVUJwemErcmFLT2NHN0xrS0JrTzJD?=
 =?utf-8?B?K0tlUW1JQWY4ZVByQVd4SjFSdTMvYXRLRGZwRHJ3dlVZVTkzR3g3aFRua2hj?=
 =?utf-8?B?cENRc1dvVENQTzJKV1haS3hzM0NxeVcxTTB4ZXIrNVg5MUkzTW5LYTZQSk95?=
 =?utf-8?B?NERRVkhiWXhMMkkyclBOejRTM1lFeXZoelliVGoxSUpkOEdERDlYMHk3aVd6?=
 =?utf-8?B?emtFQUZBS2xJeHI0dGEwUzVtaGZSVkpHNzdtY2RhRDJjQVMrNlZzUlZ6Z3J2?=
 =?utf-8?B?VjNvMUxXbEdXQ2dyeGgrS1RZOUFEVkVydDhQYS96ZVB0MlBTMENiY0IyWHZL?=
 =?utf-8?B?dFg2QUNBaUUva0xPUmkzbURSSW5CZzQ3T2dXc2N5eElTd0hVSzhTaHRiOU5L?=
 =?utf-8?B?K09SMVFGZi83OEI4K0p4M3NkaEIvblBUR1JHaGpNa1FJOG91MGxvamt2c3R3?=
 =?utf-8?B?ZGZkZXNhN3RrdzRybThRUmlHNnFtN2l3WnlqZld1VXVwRzY0MzFCMDk0RzNJ?=
 =?utf-8?B?UXBpOHJxNy9qbFhvZEhQcnZqS1Q0bXVFdnlveGdsS0p4TndOTk41dWRkVEpl?=
 =?utf-8?B?NlNXNm96ak1sbDNMdUluTHE2Z3RSN3M0Z1BFdDY3RzB6V0dxQ2lEMGt3Y3J0?=
 =?utf-8?B?aExaZ3EyVU5GQVpONVdqbThUeHo4d3FQQkFVUlg1ZlVsdDQ2UytBMm1CUEM4?=
 =?utf-8?B?Vm9neG1FV2pTeWJwN0MzODkwcVJGSG5LbFBTdFhxaHJLU1FSTmhPTVEzS1Jn?=
 =?utf-8?B?N3YzZEdjaFlCNy9aR0c5WmxBcXhuS0c5MXNsNmQ1SVYyNVJtczFFS2p0WVdq?=
 =?utf-8?B?YlBEV0tlUUd5TFBNdENFOXJLemxMMXBEMTQ2WFpTNDB4ZmZWMWJnSlc3M1Nm?=
 =?utf-8?B?WmRtWVdpd00yYUQ4c2p6MThGdWZBb0JQN1R3SUNjNEhNQ0FyUExOalF1bHhv?=
 =?utf-8?B?MHphWEQvbkFmYmprSU9ka2M0RkJ2bHZIVzM2TXJTeStleW5SSmsxcXFRQTcz?=
 =?utf-8?B?cEExbXp3ZmptY1UyL1d4akJMZzBXMHYvSVQwRnNacm5JcEdXYzYvRlRDV1Rz?=
 =?utf-8?B?WmtVQUExenFjVmd0YWMyMVVabWhhVnUwcDZJR0duVjZ1YVFZbGMyN0VobWJL?=
 =?utf-8?B?ZDhIN3hTNEErSW55VHhZVzJuWWJjRlNWTFhFWVluY043dTlaajVMOVZ0NlVF?=
 =?utf-8?B?OXg3TmY0YU5YWnQycE9zWldwNXVVMVJycDlXYzlPbExTNGN1V1NyY3BXajhL?=
 =?utf-8?B?QnAwcGRFU1FSOFd5Z0VPWVNHMU5NbWhDYzhXb0g2WVE5V2czWXF2bEsxcTg1?=
 =?utf-8?B?TzJmSHE3SlZjTi81bW9PYjBnMzRaVGdubG1FeElkcnhTSkR5UFhrZHM0eDQv?=
 =?utf-8?B?WEp6R2NwSU8rNkZ3ZlpFTUFBU0E4SHkyZkZDaFRMMUNQa2lGK1lQNUcwamRs?=
 =?utf-8?B?ZzhvMUF4Y2I4TTFlWWJDL1FQTjFxTmQvaFl3Z2NWVklhSDBCSFNHbUQ1U3Vn?=
 =?utf-8?B?Y2hTbEpDYlVoa3gvTXlTQzZzTmtZL0g0Wmcwc0JZeEw1a3JwczJTbW4waml1?=
 =?utf-8?B?MlM3Y2NCVUJkYjlaOXlMN0dESHpkN09RVWZCNFhVZDkxa2UwQklYbThIZ1h3?=
 =?utf-8?B?MkJFZEZ4OUpPS1ZjbDM2SkxiSkNnRC95cThtdzVmeFhhdEpjYVRUSHJNSHhU?=
 =?utf-8?B?SGxpdEpqOHJRb1NoNVlGNG9LRCsvNkJtN3pqRDlsNjNMOUI4WndpOWtZRFBl?=
 =?utf-8?B?ZVJ1cVJKTUtReXZML25vSng3ZDRXd2N3Rkkrc3dlUlpqVXVVQU4rL1JQYXoy?=
 =?utf-8?B?R2RoSVBUSzY2Rkw5enJvcE1mQ09LY3FOTVNEdzhjeGxGRkQrdkNrVEJ6YmJM?=
 =?utf-8?B?N0NpRHJ3alA2WUl4VFBLd3pKWmRqcVRpU0VMMVB2UjFqajV3MjY3Q2YvWFZy?=
 =?utf-8?B?Qktwb0pCRVZab2I4Q2gwNmlZYnVFaWppdWgrS1NKbldFUGVJSFZ3dEFiWnY2?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6455EFF433E8DD49A6F322931B34FC1A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f167fa-f2f9-473a-8438-08db6e0b05f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 01:43:02.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCk4pPMyrNDfvIPamoT6lgK5YsLnL9VSevtw5DUK2HiZNH7RlWZ6Fk403JHso5hqM4nJiJ7YH/z4SkOdbJ3PWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7426
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTE1IGF0IDA5OjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBUaGUgTWVkaWFUZWsgTVNEQyBjb250cm9sbGVy
IGhhcyBhbiBpbnRlcm5hbCBkaXZpZGVyIGZvciB0aGUgaW5wdXQNCj4gKHNvdXJjZSkgY2xvY2ss
IGJ1dCB0aGF0IG1heSBub3QgYmUgZW5vdWdoOiBhcyB0aGVyZSdzIG5vIG11bHRpcGxpZXINCj4g
aXQgaXMgaW1wb3NzaWJsZSB0byBhY2hpZXZlIGNlcnRhaW4gY2xvY2sgcmF0ZXMgZGVwZW5kaW5n
IG9uIHRoZQ0KPiBzb3VyY2UgY2xvY2sgcmF0ZS4NCj4gDQo+IFRoaXMgaXMgZXNwZWNpYWxseSBz
ZWVuIHdpdGggdGhlIFNEUjEwNCBtb2RlLCB3aGVyZSBhIGNsb2NrIHNvdXJjZQ0KPiB0eXBpY2Fs
bHkgb2YgMjAwTUh6IG9yIDQwME1IeiB3aWxsIG1ha2UgdXMgYWJsZSB0byBhY2hpZXZlIDIwME1I
eg0KPiAoZGVwZW5kaW5nIG9uIHRoZSBTb0MncyBNU0RDUExMLCB0aGlzIHdpbGwgYmUgbW9yZSBs
aWtlbHkgfjE5OU1IeikNCj4gaW5zdGVhZCBvZiB0aGUgb3B0aW1hbCAyMDhNSHouDQo+IA0KPiBJ
biBvcmRlciB0byBzb2x2ZSB0aGlzIGlzc3VlIGFuZCBhY2hpZXZlIGFuIGFjY3VyYXRlIGNsb2Nr
IHJhdGUNCj4gZm9yIGFsbCBtb2RlcywgY2FsbCBjbGtfc2V0X3JhdGUoKSBvbiB0aGUgc291cmNl
IGNsb2NrLCBzbyB0aGF0DQo+IHRoZSBjbG9jayBmcmFtZXdvcmsgd2lsbCBlaXRoZXIgY2hhbmdl
IHRoZSBQTEwncyByYXRlIG9yLCBtb3JlDQo+IGxpa2VseSwgd2lsbCBzd2l0Y2ggdGhlIGNsb2Nr
IHBhcmVudCB0byB0aGUgImJlc3QiIG9uZS4NCj4gDQo+IFNpbmNlIHNvbWUgcGxhdGZvcm1zIHNo
YXJlIG9uZSBNU0RDUExMIGZvciBtdWx0aXBsZSBNTUMvU0QgIk1TREMiDQo+IGNvbnRyb2xsZXJz
LCBtYWtpbmcgc3VyZSB0aGF0IHNoYXJlZCBQTExzIHdvbid0IGdldCB0aGVpciByYXRlDQo+IGNo
YW5nZWQgKGFuZCBkZXZpY2VzIG92ZXIvdW5kZXJjbG9ja2VkKSBpcyBvYnZpb3VzbHkgZG9uZSBp
bg0KPiB0aGUgU29DLXNwZWNpZmljIGNsb2NrIGRyaXZlcnMsIHN0YXJ0aW5nIHdpdGggY29tbWl0
DQo+IGYyMzVmNmFlNTllNSAoImNsazogbWVkaWF0ZWs6IFJlbW92ZSBDTEtfU0VUX1BBUkVOVCBm
cm9tIGFsbCBNU0RDDQo+IGNvcmUgY2xvY2tzIikuDQo+IA0KPiBBcyBhbiBleGFtcGxlLCBvbiBN
VDgxOTUsIGFuIGFjY3VyYXRlIGZyZXF1ZW5jeSB3aWxsIGJlIGFjaGlldmVkDQo+IGJ5IHJlcGFy
ZW50aW5nIG9mIHRoZSBzb3VyY2UgY2xvY2sgZnJvbSBtc2RjcGxsIGRpdjIgdG8gdW5pdnBsbA0K
PiBkaXY2LWRpdjIsIGdpdmluZyBvdXQgZXhhY3RseSAyMDgwMDAwMDBIei4NCj4gDQpIaSBBbmdl
bG9HaW9hY2NoaW5vLA0KDQpXZSBkb24ndCBjaGFuZ2UgdGhlIGNsb2NrIHBhcmVudCBpbiBrZXJu
ZWwgc3RhZ2UsIHdoaWNoIGlzIGZpeGVkIGluDQpib290bG9hZGVyIHN0YWdlLg0KQXMgd2Uga25v
dywgdGhlIGNsb2NrIGhhcyBzb21lIGppdHRlciwgc28gd2UgY2FuIG5vdCBzZXQgdGhlIGNsb2Nr
IHRvDQptYXggdmFsdWUoMjAwTSBvciAyMDhNKSwgdGhlIGN1cnJlbnQgc2V0dGluZyBpcyB3aGF0
IHdlIGV4cGVjdGVkLg0KDQpCZWdhcmRzLA0KV2VuYmluDQoNCj4gU2lnbmVkLW9mZi1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDcgKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5j
DQo+IGluZGV4IDhjZTg2NDE2OTk4Ni4uZTAyMTc3ODNkMjJkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMN
Cj4gQEAgLTg4Niw2ICs4ODYsMTMgQEAgc3RhdGljIHZvaWQgbXNkY19zZXRfbWNsayhzdHJ1Y3Qg
bXNkY19ob3N0DQo+ICpob3N0LCB1bnNpZ25lZCBjaGFyIHRpbWluZywgdTMyIGh6KQ0KPiAgCQly
ZXR1cm47DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkgKiBTZWxlY3QgdGhlIGJlc3QgY2xvY2sg
cmF0ZSBmb3Igc3JjX2NsazogdGhpcyBpcyBkb25lIGluDQo+IG9yZGVyDQo+ICsJICogdG8gc2F2
ZSBwb3dlciBhbmQvb3IgYWNoaWV2ZSBhbiBhY2N1cmF0ZSByYXRlIGZvcg0KPiBERFI1Mi9TRFIx
MDQuDQo+ICsJICovDQo+ICsJY2xrX3NldF9yYXRlKGhvc3QtPnNyY19jbGssIGh6KTsNCj4gKwlo
b3N0LT5zcmNfY2xrX2ZyZXEgPSBjbGtfZ2V0X3JhdGUoaG9zdC0+c3JjX2Nsayk7DQo+ICsNCj4g
IAlmbGFncyA9IHJlYWRsKGhvc3QtPmJhc2UgKyBNU0RDX0lOVEVOKTsNCj4gIAlzZHJfY2xyX2Jp
dHMoaG9zdC0+YmFzZSArIE1TRENfSU5URU4sIGZsYWdzKTsNCj4gIAlpZiAoaG9zdC0+ZGV2X2Nv
bXAtPmNsa19kaXZfYml0cyA9PSA4KQ0KPiAtLSANCj4gMi40MC4xDQo=
