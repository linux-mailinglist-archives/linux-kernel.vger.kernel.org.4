Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC10972DA77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbjFMHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbjFMHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:08:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942312A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:07:57 -0700 (PDT)
X-UUID: fe730b9409b811eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ijfzis6RtsqHYRaBnYsMKaCwia1o7Xb0KzlXPLxYLaw=;
        b=kSiCdkOoxk/tlpppH0FtM81AolqIE0R0ruBOFlFS81znu0Mwyi67NV1B+pp4y9eU4B168ctVQLovoIhB7G2jzgMwW40n9E/WNGTq+Xp9pP8TI8A0tfe2ikQoYcoEn0muINaiGnvRzwEmIlrfjLe6hLet0R5R1eR9s3YZz85fmvo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:1587cf0b-846a-4cad-a1f4-7feffe08d503,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:0c42e76e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe730b9409b811eeb20a276fd37b9834-20230613
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 456651688; Tue, 13 Jun 2023 15:07:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 15:07:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 15:07:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8ZB165i26yuZqHj9a4dTCyooqXO+Po5pwoGT/FXkcPsVOx3cxBEK/210QXcMxcybWT/bHIXWy7UnwNSFQ/WdHpuAGSinxvOtWRa2hML3sUgPKy6KIxkWEey+XcXdYVk1oQ2lO1evMnEcC92MfsLgbDE08Uzc6aMHJsArJfWA54QK3adFeWZ4QZ3Fky8jEXESrdcWrJFOAo1pItjdwNGRD659yHKeHvKiFD6o4ARVmytV40urAbJRqaGxnqjcPTlwopWoHcOxXnToNc51L2AFASb1F3Z6dsY6WcNFG89Gda+pX9aZ7iiOIJ5oqNvD/o6kJWAqD/p2NpTigPbj1wlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijfzis6RtsqHYRaBnYsMKaCwia1o7Xb0KzlXPLxYLaw=;
 b=FQBYoS30D/Uy07JWOnIkZBiWD5ZhX1P59Yl+wFIW2tx0poGZflvRrhWTqFESNO2k+y+QkZEis8klAkJhFt7ZCQhP0A4RJiPzt4oGt+Ctbq/7iQ+pAuGmiPTnNIZQOQTDzp6E0hV8/PU6fD9RiuIfxZt5fmvRwWbhmdGmDV61FYKdqzt7TjITX8NpvZN24bcr2eSDhkszisE21gIA8ZLYn40vYBWwf6khxTSuqPbETK2R2jY21rWmoogy0LaRtK6DYDqByVe9smAxO0VNCILsr2tCDltQSJbo35JCD25vNvYUl2IkZcDpPahmqVNtGoMuG5C7hbEJP2sD8Rg+f5g4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijfzis6RtsqHYRaBnYsMKaCwia1o7Xb0KzlXPLxYLaw=;
 b=Jdw+WOL/+pZJ2MJBzdJVgJbarza3H/R2FB2HI4zbyh5l78dJcbYirfz/C2s9n+dQjaOBp1ApmsUGJ+/ZcgTcVBIBrvy+2LQVGVzOtwE8W6n0efwuXmIaHIaylkHu69G1lfBt89CqXjIyVH/e4CyLgY8FGNr9WpCFaHxoHM4QOcQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR0302MB5267.apcprd03.prod.outlook.com (2603:1096:820:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:07:38 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 07:07:38 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 2/5] drm/mediatek: Add cnt checking for coverity issue
Thread-Topic: [PATCH 2/5] drm/mediatek: Add cnt checking for coverity issue
Thread-Index: AQHZaRzRjg8QgMLkZkudVFVZskTAq6+HO4eAgAF9t4A=
Date:   Tue, 13 Jun 2023 07:07:38 +0000
Message-ID: <1e4a70709ad588feb85c9cd0d1bbc0a2f78e525d.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-3-jason-jh.lin@mediatek.com>
         <04d7db4fe0b8965da63f3f240289639941b7298d.camel@mediatek.com>
In-Reply-To: <04d7db4fe0b8965da63f3f240289639941b7298d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR0302MB5267:EE_
x-ms-office365-filtering-correlation-id: 87ea82d2-ed1e-4b00-9dc3-08db6bdcdf07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMVCVRF69Lmmtq9QPS20VtSntmNixf9pjZz+UWE2aqBnId8gcvLZJ0mdlgQTe2qs8iHdzeMicja5DF86J6zjZYBAD6G+IlXjzsnPsHbwn1L5fgVhbrj0c7fhLyPVUsJP6ZMgn+EytGqFE5M+mz3/wFLf4hq106SQ/GLEB3o2QXZAol1qInIsryTxYNjwn97WAvX1VtMjRPdmZ4lTuyuf2IOYKAPNuI5v/aGtE6hIZmv+bwHok5AYSuKYSBJp45dJOhprG4dHhBh47AtQKzZjhRQ7LAues+9+DYLxkX1PQvT8pAFhv94vLgTCpmC12iwIvJ2BYeVMCyRDOYIWC1MC42nIq8l2sCYUEl0GmVRMSzK+BZ6rqK3jvBrlpAeDR+YwWsJxpDOFKSaNFqfYimcHdRGZ/AF2/6dodITnr4KlaQHvlYB2m9dN63xWiN85NIo6EYv9kKR6sD7mSxIKde1ifX0N0dMOCy2IeHYqsLeRuR4ViPiV+UO6GfoFZm/57a7y8d90ipmOjxhWl6GcFLI2E6papqRGNLfpFDOX14d042TR7lFJxB2BLH6RHJCC3fGCPm+eL1H3qGd43AULoKRmWuhdvDKUTfk5ugWgpcEwJXdgsDaE050h75TzbaaCtnc/OwmEdLeW9jjoIkJEajVHf/mm6Q0tnebwmoW5iegQ9ns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(316002)(6486002)(41300700001)(2616005)(83380400001)(86362001)(6506007)(6512007)(186003)(26005)(107886003)(38070700005)(2906002)(122000001)(38100700002)(5660300002)(85182001)(8676002)(8936002)(66446008)(91956017)(71200400001)(64756008)(66556008)(66476007)(66946007)(54906003)(36756003)(110136005)(478600001)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29SL1N2TVVSbHdxS2F1aHhFK2FCQkpBellRTlpFN2tteUtDUTBCUUtkWGY0?=
 =?utf-8?B?dmswMjdjZlQ1a013c2FkVTBCU2RLZjFvSE9NRm9tRmpBaDdyZEFHbFBidWFX?=
 =?utf-8?B?TEYramxFaGFXTzUveGtoOEdpbVVmdWFhTERERk1mUzNpWFhDWUt6eWc4TkNm?=
 =?utf-8?B?dGRWdGxwaU93QTEwR01sdTdMS3pGN0x3cVYwUFd0WmpjelVqQXpLTTQ2Um1l?=
 =?utf-8?B?Q20wQVdZekRsNnVhU3JSbEw3ZWx0c1VzV0NGT29EbldhaUptTnROMWpCdHNa?=
 =?utf-8?B?NFhhSXZOVUdBakRuQnY0bmM5VHh1SU1XK1VYVFpTdFMxWVkxS0lkQ1BFYzIy?=
 =?utf-8?B?T3BmV2pOVEFpWi81ZnFuWktWSThIcVlraFdUM1kyTTI3MW5Mc3BYbVQwMWQy?=
 =?utf-8?B?RjY4SWQ2Wi8zMTJmZ0VUOG1tNy9RQlhMS0ltOCt5YjFNa0Z1U1JiUHdHb2xr?=
 =?utf-8?B?MmJROXVUU1B5TGkzUXM1eWFrdE1iVEhNd0hpaC8rTmtCa2p6MVRZakR6NFZP?=
 =?utf-8?B?d3orREZFSWIrMTdpbldZZFU0cXZYNVlhMzRRdWRxWFVmYlRMVmxLaDZiVVpG?=
 =?utf-8?B?ZmptZy9GQ2lROThwWTRWQ2dweS8yUHRtbDB3YTdIcVpSM0xsUnBGSG5Ud0xP?=
 =?utf-8?B?YzlEWmpPWWNjcHc4NkpkbmdmVDcxbnhkaUYxdDdFNlFmbWxPdDkzOUNrbzNk?=
 =?utf-8?B?TlA2a0VlWnlXdDFpNGh4R0R2em12bHpmbXJJeTFEcXlENERuSXBpTzVyR1A2?=
 =?utf-8?B?TkhlQzV3dDRsdXNMMW16QkVndUJBZ2VGTG5BbFFTOCtFZGhhYXdXc0wzc091?=
 =?utf-8?B?dEdKR3NkWVhFaW5ab2cvVlRTK1l1YlVYODdjNGd1WGtya29zZmRhdGM3Uyts?=
 =?utf-8?B?QUZ5UXRLc1pKY2xWL3V0NzF1Sm9rZFkwYmJhWGNESUlqSVhiRVcrRUlNU0g2?=
 =?utf-8?B?dmdkazlDRURNR1dKUEF6aUxWc1ZXaXJzS01NUkRRTER6OUF4Sm1sdm52T1px?=
 =?utf-8?B?eHVVTW1XS2o3R3kxYllpbUJDdDhxdTlIcXJlSDU0TzI3R3Y5SGovMHZPenkz?=
 =?utf-8?B?VHNWTUk1SzJWdGVJS3dPUWM2MXNpZWFpUEZWVWpnYmdtNlo4UTltUUlJTHVw?=
 =?utf-8?B?b2E5QXd3TmNuZStrMEMzS3RPeUFOdngyblhKOEU1MWVoRFN3NFAzTmYzb2hw?=
 =?utf-8?B?WjRoWmZGMDlNdVhOd1NQV2kzdTJBaEJ2czYvLy8wSmM2NVJjZC8ya3pMZkpv?=
 =?utf-8?B?Z1JTVWFtcktaTFBKTjZzeG9CSWc3S040b0ZaemRMNHE0YnRyNzBFWHhTZzBm?=
 =?utf-8?B?SXFRNjhUN1BubDFsaXBKeUdnY0ExUnUyeFN5QnY2ZW42djB4M1FNaE9OV3Bp?=
 =?utf-8?B?NnZGZXdTWE9tUVVNNXFoRC9vck1pTEhQRWZXMXJ5MFhPeXZkNk54c0NhZUcx?=
 =?utf-8?B?N3RvRjlhTjkyVElZS2lnajRINys4WXJOUUM0b2J5SVdQNmdmYjk1NXF1bWxJ?=
 =?utf-8?B?VWtXRFl1eHNsMmtrRUlLKzJQSGxFTWZvUUplY21yMnBzUE9SV1o3a252QnZw?=
 =?utf-8?B?NlJtdGU4ZHVnQjVRcEJsZk5xMUtPZFJJVVdaTUlweHJNeGJZbGhlRE1kRk5Y?=
 =?utf-8?B?TnB2ZnR6SDZCZnhZUzZITkRJQVMzWUU0ZVU2VWpTdHFlYnpYb05lNEJHNmc3?=
 =?utf-8?B?VU5GMDNhOFJKQWtYV1ZEY3RpY2RQMERIMDVUekRjMS9kNlk0eXVPSVRTQkl1?=
 =?utf-8?B?dFBKZWg1SnprRlc4UGZ1Mjd3dGhMd0pjMFJLQWN5YjYzWTVKQ1hQdDVJdUVt?=
 =?utf-8?B?WUg1dVhXM3NlRER5M09Rc1B0RG5YOG1mZGRMWmJhd3RHa3dZaEsrYVFPZlRC?=
 =?utf-8?B?TmovMVFLaTlYWS9xQkpSMThqTWo3b0ozc0h3NG8ybXRvdXdUWm5iKzMzWE4r?=
 =?utf-8?B?dGFQU3FQcXFQS241dzlhNlJXR2ZnK2lmYUpYWEFPYUxQYnV0SFVqSmpmZWpW?=
 =?utf-8?B?M3FGNlV1dVFaTVd6dUt3MmpVNnNhREd2K05lY0tRSzF4cnlSVkYyWlBsN1N1?=
 =?utf-8?B?OWt4RXJiNjVmbERZODZtUnErZE5nV3ZNZHF6RnBMZitwWHNIaVc4M0lCSjlP?=
 =?utf-8?B?NGNpb1dCYUQ3WERLOFJPNHlHbWpxNXlkaGh3Mms0VGZ3dzBqWGZLZmlsNjZq?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B7F8FED459AD64CAF7DDB00C16B4637@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ea82d2-ed1e-4b00-9dc3-08db6bdcdf07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:07:38.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poo3PH4D7gbu/IlstEjGpN5k1073HbYhJ6bTjdNwBZNS0OnVyJ4FpNk+lbk1ozJ6WGoQCz9I1La6+R2a3fBJ9jufXkFWTdrVqLJXcjxgwDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBh
dCAwODoyMSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNC0wNyBhdCAxNDo0NiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IENFUlQtQyBDaGFyYWN0ZXJzIGFuZCBTdHJpbmdzIChDRVJUIFNUUjMxLUMpDQo+ID4g
YWxsX2RybV9wcml2W2NudF0gZXZhbHVhdGVzIHRvIGFuIGFkZHJlc3MgdGhhdCBjb3VsZCBiZSBh
dCBuZWdhdGl2ZQ0KPiA+IG9mZnNldCBvZiBhbiBhcnJheS4NCj4gPiANCj4gPiBJbiBtdGtfZHJt
X2dldF9hbGxfZHJtX3ByaXYoKToNCj4gPiBHdWFyYW50ZWUgdGhhdCBzdG9yYWdlIGZvciBzdHJp
bmdzIGhhcyBzdWZmaWNpZW50IHNwYWNlIGZvcg0KPiA+IGNoYXJhY3Rlcg0KPiA+IGRhdGEgYW5k
IHRoZSBudWxsIHRlcm1pbmF0b3IuDQo+ID4gDQo+ID4gU28gY2hhbmdlIGNudCB0byB1bnNpZ25l
ZCBpbnQgYW5kIGNoZWNrIGl0cyBtYXggdmFsdWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IEZpeGVzOiAxZWY3
ZWQ0ODM1NmMgKCJkcm0vbWVkaWF0ZWs6IE1vZGlmeSBtZWRpYXRlay1kcm0gZm9yIG10ODE5NQ0K
PiA+IG11bHRpIG1tc3lzIHN1cHBvcnQiKQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBpbmRleCA4NjI1NWEwNjZmYWYuLmZjZmExMDMz
MjE2NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+
ID4gQEAgLTM3OCw3ICszNzgsNyBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2dldF9hbGxfZHJtX3By
aXYoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYpDQo+ID4gIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkICpvZl9pZDsNCj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gPiAgCXN0cnVj
dCBkZXZpY2UgKmRybV9kZXY7DQo+ID4gLQlpbnQgY250ID0gMDsNCj4gPiArCXVuc2lnbmVkIGlu
dCBjbnQgPSAwOw0KPiA+ICAJaW50IGksIGo7DQo+ID4gIA0KPiA+ICAJZm9yX2VhY2hfY2hpbGRf
b2Zfbm9kZShwaGFuZGxlLT5wYXJlbnQsIG5vZGUpIHsNCj4gPiBAQCAtMzk3LDcgKzM5Nyw3IEBA
IHN0YXRpYyBib29sIG10a19kcm1fZ2V0X2FsbF9kcm1fcHJpdihzdHJ1Y3QNCj4gPiBkZXZpY2Ug
KmRldikNCj4gPiAgCQkJY29udGludWU7DQo+ID4gIA0KPiA+ICAJCWFsbF9kcm1fcHJpdltjbnRd
ID0gZGV2X2dldF9kcnZkYXRhKGRybV9kZXYpOw0KPiA+IC0JCWlmIChhbGxfZHJtX3ByaXZbY250
XSAmJiBhbGxfZHJtX3ByaXZbY250XS0NCj4gPiA+IG10a19kcm1fYm91bmQpDQo+ID4gDQo+ID4g
KwkJaWYgKGNudCA8IE1BWF9DUlRDICYmIGFsbF9kcm1fcHJpdltjbnRdICYmDQo+ID4gYWxsX2Ry
bV9wcml2W2NudF0tPm10a19kcm1fYm91bmQpDQo+ID4gIAkJCWNudCsrOw0KPiANCj4gDQo+IEkg
d291bGQgbGlrZSB0byBhZGQgYmVsb3cgc3RhdGVtZW50IGhlcmU6DQo+IA0KPiAJCWlmIChjbnQg
PT0gTUFYX0NSVEMpDQo+IAkJCWJyZWFrOw0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCg0KT0ssIEkn
bGwgY2hhbmdlIHRvIHRoaXMgc3RhdGVtZW50Lg0KDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4N
Cj4gDQo+ID4gIAl9DQo+ID4gIA0K
