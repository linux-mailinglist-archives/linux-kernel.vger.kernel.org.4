Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C66715A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjE3Jm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjE3Jmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:42:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22393;
        Tue, 30 May 2023 02:42:35 -0700 (PDT)
X-UUID: 4af5e734fece11ed9cb5633481061a41-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tOuCDVw0uWoizQ0JXM6gVOnkFyYCEbL3V4ENkxMhjlE=;
        b=AcA4abqDwP4LYO7SQ9G0I0vCGj5mWiu2OkRDUQYoSZ2OmvK3nsfSe2GsBDKAKfXZT5/zhGtMJ3NdpevZpu41gYDxAraitIzdzdremkYaW4z7O0t2I/WYSQAuFo/lu16YPgxigmzrKILTfR2GwJHTgPJhZE0VP+AXzTJfKH7anRA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:adb64760-07b8-4464-9c93-29c5edbe09d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:79e7fe3c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 4af5e734fece11ed9cb5633481061a41-20230530
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2008146632; Tue, 30 May 2023 17:42:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 17:42:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 17:42:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVtr81kT6jSF9E40foYZc+GoFsimN397uNVIYwsaCYcvXPN7tjhctHHjShtIGsyXZG9p9EWcIVYwNEe58LsZT43DpNtjnDjABF2RyBwTY7WJBe7WWUtwbt9NHyXufB18e1ukwqmrV2TsVbO6cs268iZ+eTyawKbJ2AzS9281Zd9KTjjabePWFrta3TJckipReGCEdxfjoN0C4qwOlo6EzNKya32YHi3r7IPyvTOtpegZs18GPLiH40VzSx4QvJRcwifpwyiRQzb4PkYgJRiqf2CSJbWTst3V3N/vwwth36dB47FLckWPXE0QuPvRwJxdhr5LNORAa2gxiU4LX0xAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOuCDVw0uWoizQ0JXM6gVOnkFyYCEbL3V4ENkxMhjlE=;
 b=e6C8G4pPStfCuKEopXlVwSxCUHQIJtUvOEqiHvjdP1I71BMbjKbiyIBe/M0VMgRj7dA+wx8qDhs/3yghmSFhjKCHrzxMGkBm4fOWmzw8QJ2qSeOCSnmzjtgYCowwDHKKO0H8dMqyZjbKEKkTO9x4HhELTj3D14lb0nUpYHYsoSAuoU7j88bRxS9/7hLq/1d5sf1vDtu9tcfbOvk6Ef6NBGts38gpimtYDSB3MnHDRYnQR590+d1dI8je5e34ooC4JbrBevoUowsq8F7mxekZBTLvafUYNZzwicjZx74QpfW0YPzLFyf/zEJW/lZa9olzBB/gDIgQYwP22ZPYaO00bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOuCDVw0uWoizQ0JXM6gVOnkFyYCEbL3V4ENkxMhjlE=;
 b=eFINybebmenwn1W+LcC74lmSOm/fr7XOGE+jnuvemZcR1P6nNOS7v0BTWZD36y/8tW7q6eYSOcNhJdw43hZljr3jDpyt6fvF65zXQDwbCngHUmn5tjwQaFFX7FhxjKOyN61TS0QhCamsrj771aXUi5XkeNwVNMdYAAXxBdVaD+0=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 09:42:25 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:42:25 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Thread-Topic: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Thread-Index: AQHZkp8O+KfkX8LDKkiWd0UHlYtLm69yaUGAgAAnlYA=
Date:   Tue, 30 May 2023 09:42:25 +0000
Message-ID: <edce8351ff4ada0cb0e2085e3467c0a7512496b2.camel@mediatek.com>
References: <20230530023227.16653-1-powen.kao@mediatek.com>
         <20230530023227.16653-2-powen.kao@mediatek.com>
         <14a23717-b517-3d7d-bd5b-17e265dffe82@collabora.com>
In-Reply-To: <14a23717-b517-3d7d-bd5b-17e265dffe82@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|TYSPR03MB7705:EE_
x-ms-office365-filtering-correlation-id: 742a324e-1e44-4025-6471-08db60f22cf2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SqBb/Hj5mZDV5xmIe/a/UsdDb1tpy2tU3Y6DE0CsjYAF9Bexgc+TfhL3azyHdh4nDKEa86lj5DCJsxk0oCuKxgBNUHlSHzM2KaL3PDoUMj5Im/TT80eHo3jmjSIeIbEzM06YSWQ7o3P/dLtIEXm7YxyewCBxF6hQbhRfO74QPa1uXZCkrHYeBoLuwpzk7llc3clEMhh08K7fRYsBGhoxoJ71WA+TCQ5yFkQH9WSteQizIvmN5zEf+8hqmJHTTa6NeRw6f4HcxSzqNGJqY99i3YYeI76L/O8Q7HDyqfssh5rDXI27xZM4nRNoK1Ry5N6FPBO99j6kbs+ue249gkrtrD7ftXOALFpDD3TvwOnuSbDYbUEdw4TwNyo58yN2yqeX0T6nmRwu23vlK3XZPS1jUv/skVBGXjstlCmVRadZxk3kMIO+aPfZbbHLbJHUUP+mj2VEZ4iMxqMAS8WbQ8m0JnGGR1bRgCcO7670jALT09Pt8O93WiH8AGx74MiNc5DIdkQtMmZsNp6VHGcROUe/4hJhRLR6WhkBzMA1iyfa4dfJQekTm0u45/pfAOrV2QA66fJlHAXwzirHvTzpjrAaN82txE66IYpTNWyOl739cg8L15DPLwMkidUM8hTP2m75y8OAbFDvcP0jnSFBp6FW0BoG3FqeY6VnrtdWMGBjSa4+EkM+7LCIDSRjJPS3B7Z2fQLycutP2sXND+JcIlqHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(2906002)(4744005)(186003)(6512007)(6506007)(2616005)(5660300002)(478600001)(54906003)(8676002)(122000001)(921005)(110136005)(8936002)(26005)(83380400001)(38100700002)(107886003)(6486002)(86362001)(41300700001)(38070700005)(71200400001)(316002)(76116006)(66946007)(7416002)(85182001)(36756003)(66556008)(66476007)(66446008)(64756008)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHpBVzduTkFXZmsvRSt3b1RCOUF2ais3cnM0azR5TXVaRmF4U2ttZW1kM1Vn?=
 =?utf-8?B?K1BTZ1hNcS9JYlUwdXVjRXJwT3JHS0kvcXN6d2tKdGRzMFA2TWltVmxUdnJv?=
 =?utf-8?B?cjJ0b0F6WnNpMXpSMGNNZURNbzg3Y3FnMExOcmZaUmdVcmpmZDVqMGZ6Mzdw?=
 =?utf-8?B?RzBXV0xwMHlPVDNVVjMwOVlrb2ZLL0R3c3Z3VHJ0NUdjbmQ3alJnVi9UNmhP?=
 =?utf-8?B?c0pHQ0lvNER4NzdDRzN2b0hjZ0x1bTdiOXN3RHdtejBBWlMzM1FIbHFKSnpk?=
 =?utf-8?B?d2o5ZEFIZ1NibXovenJBSFdlQXhZcnp1S0x3blUvTGNobHpVR0JROXpUZk1t?=
 =?utf-8?B?dHdQZ2NrVXVlTEZEWVlOY3o1eFBMdmlBOUVpLzA4Y0RUWkhsZHduM1ZzeURF?=
 =?utf-8?B?amlKNDd4T1lZenpHUXpZeXVWb0lLMWE3aTZOWEFBMHE1elkvUUtyQUFiRUcv?=
 =?utf-8?B?Z0l1ZFdPVUsrVW1tQjFZMWZ6NnFnQnJEUGQ5YjZGeitOZUN1SVpvTWFTUktw?=
 =?utf-8?B?eEo1TzhmUTdUc1lKeWFneFh4VUpBZDUyMjFrZ1RrV1ZvWE9QVDN1cTdMVXg4?=
 =?utf-8?B?QkZwNGlVWnZLWkFPWmtHTG9iMFoyTXUybkFOV0ljRFBZT09mWE1BZk9IV0Ev?=
 =?utf-8?B?b2RXY29JTEhGUFM1aTVjWVBJSDczc1ZFSFVDQno5NThYMWJKTWE3Zzg0bGtq?=
 =?utf-8?B?bmdRUWwxbWhicDFtMkZvSmtsdFEzQmJBNW55cFRPTVoySEo0SGtEMXBMMmNJ?=
 =?utf-8?B?SDVKajEzYU9td0JJQnRaUXhzOGQ5ZzIzMytyME5sYnZTb0tRSVFKZ3lwazJw?=
 =?utf-8?B?R3pWVTN3V2RCMjhYZG15Ky9WbVJva0Q2bVJUcnU1MnZWWERPQzAzYjI4dWRn?=
 =?utf-8?B?MmdWRms3WkhSZGtTVGV3ZmhqMVF4dzVvRGR5Z3RManYvbG9wN2RiWHE3ejNJ?=
 =?utf-8?B?ZDFGMU4zMTBEeUJjbXliMlptT1hEbmp3UUlYQVBEU3R3ZjhKM3dsWXh5SHdi?=
 =?utf-8?B?MVp4V1pUeWs3bGZaUVBmZ09XMXRtRi93MUpQZjVlSUU3VVlOdmhnNTRscXky?=
 =?utf-8?B?Z2ZXVnQ3d3U4YVZkSldEaFA1azNoQ2lyRHBianQ3OVdqMFlIdXBhTHBCNVJy?=
 =?utf-8?B?RCtzbldjbEowSURycnFVdDFpV2hwbmk4VkcxaGMySFJWck5iR1VUekIrdlB0?=
 =?utf-8?B?L0t6blZJRG9icmZXTjJ2NEZFS3Q3Y0ZtWUtkYmRjNGErYk4wZlRkN3hETTYx?=
 =?utf-8?B?c01Wd0pyTXVCMjhSOVNnNVUwQUJkb3FFUEpHZUkxZ3NCejR0N0Z4WERPRkx0?=
 =?utf-8?B?NFdUeWRGa1l3eTV4MGlLcWVxdi96aWEzMld3RVB4V3RBZm12U0pDbDNLNVJz?=
 =?utf-8?B?SWdHdDQ1dkxRQUViRU9McjNtR0M2cEg2NGxLd0NMRFVyWlhvdTcxd3ZUVUdu?=
 =?utf-8?B?MTl1K0toNUlDQnJtTDUyeUhSdHFvdHVYQ2VKdHgzMWNkOHFYd2NlK29TS2Rr?=
 =?utf-8?B?MnZick9ieWIzS2ZLVkVKbURHUEN2L0wzNDhQZjFTZDJjMk56L0xNM1lTaGh5?=
 =?utf-8?B?REE2WW5DcFgvdkplOC8yRFNZZDJoTkxxVFBKdFIrSWRFMTAyOW55WnNlZGVy?=
 =?utf-8?B?VG9yYUt1b0xRaEJKUzU1MFFHZzFSaU90b3pEZnhaRmI3TnhyMXBPaFB4eG9M?=
 =?utf-8?B?M1UrcVNPa2VVeUJFMGtHaGx0dC9ISG5vSjdySUhCcm96bHRQRitDd0c3TWpB?=
 =?utf-8?B?ZFJ1bkdxRnZxdy9DcVRWUXBwOUwxMEtndDUrWUtvL3JhYjFlWUNZUW9TeGdk?=
 =?utf-8?B?RTdiMEdpem9jTGFhRGxtMUdMaUtnYTBBSEhvaHhGVVBVK2NzUFI1Y0xNK1Zn?=
 =?utf-8?B?aS9zTVhvQk5UUEFKMjNidkcwY0M0L3lKNTZEbU5kTC9oemhlaGZZS3REb1dN?=
 =?utf-8?B?MGp3UjBtd25SSkdQYXJ1ZG9lMjBhU0RLRTBENzBldmZWNldERVVWa2NOTGtz?=
 =?utf-8?B?ZG44MWY4S3pFQlV2NmRaemhGVkZTaWQrcVJMeWdDYVZsd3FjS2ZLRTl2bFUv?=
 =?utf-8?B?SmZQV1JxWDJBTXZEaXUxQmFyRHA2MW1kdlZEWDRjcTlFQ0ZZclgvMUxRU3lm?=
 =?utf-8?B?aFMyMXg5aVVUNURKWjRBSVM1d0liZytiMWM0WENFaEpKRFdmcVkzWWJLMk5k?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <523F6181BB0632438354D77A43DABC12@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742a324e-1e44-4025-6471-08db60f22cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 09:42:25.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjVX83X1kKQ30NBWN6dKRp6YPTg6dnuXUWdc7VU9Thka9IuT2Gbn+NJMyqLm5yaYUD3riShIpgIytrsQP+RpSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDA5OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IElmIHlvdXIgcmV0dXJuIHZhbHVlIGhlcmUgaXMgbm90IC1FT1BO
T1RTVVBQIHlvdSBtYXkgd2FudCB0byBwZXJmb3JtDQo+IHNvbWUNCj4gZGlmZmVyZW50IGFjdGlv
bi4uLiBhbmQgcGVyaGFwcyB1ZnNoY2RfY29uZmlnX21jcSgpIHNob3VsZCBiZSBjaGFuZ2VkDQo+
IHRvDQo+IHJldHVybiBhIGZhaWx1cmUuDQo+IFNob3VsZCBhbHNvIGJlIHRyaXZpYWwgdG8gZG8g
c28sIHNpbmNlIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIDMNCj4gdGltZXMgaW4NCj4gdG90YWws
IGFuZCBvbmx5IGluIHVmc2hjZF9kZXZpY2VfaW5pdCgpLCB3aGljaCBpcyBhbHJlYWR5IHJldHVy
bmluZw0KPiBpbnQuDQo+IA0KPiBTbywgSSB3b3VsZCBzYXkuLi4uDQo+IA0KPiBzdGF0aWMgaW50
IHVmc2hjZF9jb25maWdfbWNxKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+IHsNCj4gDQo+IC4uLi4u
IGNvZGUgLi4uLi4NCj4gDQo+IHJldCA9IHVmc2hjZF9tY3Ffdm9wc19jb25maWdfY3FpZChoYmEp
Ow0KPiBpZiAocmV0KSB7DQo+IGlmIChyZXQgIT0gLUVPUE5PVFNVUFApDQo+IHJldHVybiByZXQ7
DQo+IA0KPiAvKiBObyBzcGVjaWFsIGNvbmZpZ3VyYXRpb24sIGdvIGZvciAxOjEgbWFwcGluZyAq
Lw0KPiBmb3IgKGkgPSAwOyAuLi4uKQ0KPiAuLi4uDQo+IH0NCj4gDQo+IFJlZ2FyZHMsDQo+IEFu
Z2Vsbw0KPiANCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhhdCdzIGEgZ29vZCBwb2ludC4gDQpDYW4g
d2UgdXBkYXRlIHRoaXMgbGF0ZXIgaW4gYW5vdGhlciBwYXRjaCB0byB0YWtlIGNhcmUgb2YNCnVm
c2hjZF9jb25maWdfbWNxKCkncyByZXR1cm4gdmFsdWUgc2luY2UgdGhpcyBwYXRjaCBmb2N1cyBv
bg0KaW50cm9kdWNpbmcgbmV3IHZvcHM/DQoNCkJlc3QsDQpQby1XZW4NCg0K
