Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26CF66D9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjAQJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjAQJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:23:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90E32E78
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:17:57 -0800 (PST)
X-UUID: d1ac73dc964711eda06fc9ecc4dadd91-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EWunvZN7zCgBmYzeiBRAwM8WDfLUhyXbf3vU4WKxA0A=;
        b=cNq50ALg6wci3KB7rovdD55UuiBGPaO2Ar43lvTnRTovu+RuxGLPTvJQTjNZ3X7/qE2IZwv54zKeZrSA+680ncNwqZuofoN+tKxFaTHHVwpWTitDzNOSKK6zXYDygtre7QKPVI7G2m3vpDI6wHothFWvAdGG0vXDlq/J06ev9oQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:c7bf4624-4aff-4f2f-b923-60eb2a7650a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.18,REQID:c7bf4624-4aff-4f2f-b923-60eb2a7650a5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:fb927e8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230116152742P6ZX7WML,BulkQuantity:8,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0,NGT
X-UUID: d1ac73dc964711eda06fc9ecc4dadd91-20230117
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 271836510; Tue, 17 Jan 2023 17:17:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 17 Jan 2023 17:17:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 17 Jan 2023 17:17:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJYbY2Mv5TEjbqVqEc+3Od8mWwBggmvopa5thh6Y3FcL5HACLid09IhKF24LaNCLNCp5CNwYBsn71EJbAdKb5qrfqQDq+DGM/2N/HsMgw0UeLCaqRkSHQazSTCWp7aHKjYdytSJWreKhIc0bgTpmkFk3byH4xd+jrAYNpHH+Kc/BbIfAE8iDKtDEaWIO49aLkmCxVlY9GhuSWXvQspbdb33bLF13vDTAphP8nlyO9kxGABVO97VmpCrj+Di3oBljn1uQLSKzXPqwSL+ju00pjhukLFPTzv3wEwFcNjTQ/EpSnl8FV/BB/0IYHKGPjE8kRZgdQkcPqCmycDGm5Hv56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWunvZN7zCgBmYzeiBRAwM8WDfLUhyXbf3vU4WKxA0A=;
 b=SrqTZtBZZoo/GoZ/p6673Jd4W5eN3EQnxZjjCgB313EYYfLmsAh/2WE5CB50JleI2KuRuQ3z8pwyh9/Ty8Y0d+7IgBdR+uzd0T1ws4GxRRGbsXlg78yGwvHtzaNfZ8MpPm9xOknp7uzRVJbFHMhPEQnVVsvHVirsPZByHm2tyQdNzrd/Dq8+K7ACzdInU3amjw7QunQ18PMMjcudOiLh0W+fULfgpXZpb/K9c+WOdDdy8FEFhy6+mhRXWHc10UbJo/+XRzgmInduUIZ9zhs2G66zlUy+G2Xyj9xcnZ2BPEuyet0GrEsz9hjX5GFbvBAiidHxmHey0FtYC5M/VllZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWunvZN7zCgBmYzeiBRAwM8WDfLUhyXbf3vU4WKxA0A=;
 b=Hu3b0B4m+pToVQs4VwGUv12sivf5Cl9aOyXPAZXCspHXXKmVEiKNZ+aW99c6w3/COX+ciUcvRHZanMtN/em1xRVAgdyfnIB9fMPk3vTw5Ktec3waw8GLSJfRMspB/Y+o8ZkLYQ6ap4FTeyt6SgP8WSdgyEmZJEw554b5c7QaGw4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PSAPR03MB5414.apcprd03.prod.outlook.com (2603:1096:301:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 09:17:48 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 09:17:47 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHZIEA44YFL/mrrbEuqD9Ku1qRfkq6ctaeAgAWy8YA=
Date:   Tue, 17 Jan 2023 09:17:42 +0000
Message-ID: <68b343d25e3b297f78209c48097d7093ce1d88ff.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <20230104132646.7100-3-chunfeng.yun@mediatek.com> <Y8Gf2xxq7iaV/+ax@matsya>
In-Reply-To: <Y8Gf2xxq7iaV/+ax@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PSAPR03MB5414:EE_
x-ms-office365-filtering-correlation-id: 0ad84add-9b06-4704-424d-08daf86bafd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sbpRu+e/tNyvTvivmuQgAVZhsJrir3kgZft94gP/sxIkg/9WIX2AaCgMd9gEV61nKSh3p9C/p477RKl8VNv/mq6dOzVw3R4+9MXJDIh4KNT1BxbKfkQD+Sa3mB+dz8+r8x3m/w4P5w+oShf1NzJzJuN2XsrxWd+pFs5QoVdfGOvVPojSyIV1qSRIkwSdKrn/nA6Hv7WVzlL5C8ypq8SZ1XE6rnWhHwbbg5qL0cmtIf9acKNJz2P9gs2ZSq5/tufeSf6EZxPCwK/gD9Xi28HmH02cjNYQfxcSgtuAyT/dL2xPv3KcWpnHTLW2ftfVKkStl3PZF/xMdUbrOf5FQvvkrQBYeCoTV10+9VGHIL4W919XIlRD4M7ojPM3Hv66MycV1so89i/yofj/4RxzcCCGlVQ4oaQcjE10sj2yc31X1NWYu2529Sddf1ZLXymtDPU6c+M20fgk2ZRgFNhot6SIrR/skPEojG2Lar424CinwPc2DNTldqNKCzsuhu/f5ZaJGu/bM9HIb7fYo09whwE1Ja+QPgF98m/NsBUNGX1JpyvIg9xUbpSuf0DetCSRKGpYQP2z3+cln4PWo16GT38QFIcSNJP/C1fUmQzmyPJucO6j7sRItyJNjfnrvR7hCivjy7/otcJqQT9Sg3MDImmtTaicYrJ1UQMud5xFUZ+txcYWa9wvyUwlLD+fpYsI/xVUSU9N8JJuHTHIr2IrCIWTbjKJalRyvgwD77RjWztQCAX2n9wlAav+iN27MhszKHX7zmd6Q9J3jpCQk0FY7giCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(38070700005)(85182001)(36756003)(86362001)(6486002)(66446008)(6512007)(76116006)(26005)(64756008)(66476007)(8676002)(6916009)(4326008)(186003)(66556008)(478600001)(66946007)(71200400001)(91956017)(2616005)(54906003)(53546011)(316002)(6506007)(122000001)(41300700001)(8936002)(2906002)(7416002)(5660300002)(6666004)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXQvMXl2aTFFSzRmcUEvb09vY0dreFVrUTlaR3JHVnRkZC9zOXd5QldpNHkv?=
 =?utf-8?B?SmIzbTh6cU1WMEZQb0hQTDRkMUc0UmtuWUltKzF4dXgrZm90ZVNVVm1TalEw?=
 =?utf-8?B?dnJ6MXU4aDd4Njc4L2NPbDlibmkxaHphK3Y2NXkvTTVpMHJVQ3ZSa1A0eTB5?=
 =?utf-8?B?OFZ6OUR4TU51YW5FYkNCalBiR21NdytLNXV0UmlyWVFoMlJ3NU9vUzdkODBP?=
 =?utf-8?B?T2FReWZCQTNaMktZaFR5UWp0VkhVYlZDQlZvWER1TkROY1V5R1RrR3lTSEEy?=
 =?utf-8?B?UENxazhUNGRHem5NbExkYmhTYm9zUis5b0Y4VGVuUUpTOUZvMWJNT3RjZzRp?=
 =?utf-8?B?d0YvY0NDNVBabnoybVNidlFVNE56NHNiWjRjdnlhYmlEelRpVFIweUtiek4w?=
 =?utf-8?B?bGh0UElwWW13bkNPcjhJeDZZdlVpL2p3emxTTTM1ZlFMT2hPV0NCMitmekFy?=
 =?utf-8?B?Nmw1aG5JL1MvdVovZG04MzZMZ1VKT244S0pjeEhrekZnWHB5UUhEVUVNSlFK?=
 =?utf-8?B?bGFUQ21TdFo1QlgzcU9JSTJnakRLRlFTZEZwNG43aXdrOFg5cncrRlY5Si9s?=
 =?utf-8?B?MWtleXgwUk9HQ1JGR0VVUUFDc0tiWk9WekVTMkZmT2ZVbzVRd2RxRG1vaUt5?=
 =?utf-8?B?RHZxL3N0bkVWQk9IN09UQkorbGtMOXpiSE5FUWhrZTk1Y0xRcFBPMGppTGFn?=
 =?utf-8?B?Q0ZyWGZCVjQ1MCtKUExlc1BsaWdlT285T2NMeDladGo4UlBNNlIwM1lvYzVI?=
 =?utf-8?B?T3A3cFpKQVlvL2Z5ZUdaNDdsR21vVlFhTzZ5aHo4RW8yc2ljeHRUdkYxQzRB?=
 =?utf-8?B?c2MrdkdvU3VMUWg1ZmVDSVBXdUVvYko0Q2d5YmJZZG9CNWYvZGdVV3kxU3lN?=
 =?utf-8?B?UkhwZkhIcVlFakd1WWc2aXQ1TDhuNDQ3Ym42d0NVWUgzeFR1SFk4THgrbFN1?=
 =?utf-8?B?ZkZQYjlubGU1NnVDZ1BrZXZ1YVQxaEo0ZEwxUHlESTFYYVp0V1o5WU5SaStP?=
 =?utf-8?B?eUVmL0lWbVVtRnc5bDlTUEc2enNrSU1jSlZDZ1ByZEM0em5pcVhBSzJHOXJZ?=
 =?utf-8?B?OTcxMld5a1VPMnRrN05jNzlNcVJDc1lpNkNRc054VVJaek90UFRhTWdhOGNS?=
 =?utf-8?B?WlJvWW9vV1NWQWNCLzEwdk91SGkyTEZkbjZvRW9NejRJalNKRjM2MjFIdEZO?=
 =?utf-8?B?TVFDWTZOR1JNeTR5TDZHTGIyNjhjWTNSNys1Nm1ONHFYdGhxdGdPeGVZTGg5?=
 =?utf-8?B?SUxzbWRqS2RSL2J5cHIvMENOVmZBWDZtOXhycUNLNndxdWRKekxwSEk1NnRT?=
 =?utf-8?B?OVlPdTV1YjR5MlRSMmt5VEVhbGFQMlE0Y1ZheE8xTU54bXQveDl6azRPNHNT?=
 =?utf-8?B?aUpFeFh4T0JvZWZlWWlsZ0U1TmU2a1c0aU9pbDVXVFI3eThqZ0RiMURkOHRk?=
 =?utf-8?B?V2o4MmdYL1BjOUtwTy9WTDFSaDgrbS9KckJ1Mmp6VWxOV2dDbFhJdDBLRThQ?=
 =?utf-8?B?d2pHUmRWZ3FpblhBOXYzeDF2UWRwNWNjS3BVR2ErRG16aEdoU0FFTTA4bElY?=
 =?utf-8?B?OFR4NGR0WHNMYlR5TGZUTlB6cjRWUkFtS2kzUytDUHNEaHNuSlBGSjlUdzdE?=
 =?utf-8?B?WXcyeHZVUE1HTFRGSjlZR2dadElyUW5iRjRoL0hYUWJ0TVcwc211UzJva3hQ?=
 =?utf-8?B?LzZDTnpKcTBaSDNiN09yaWQzMGNNbjgvLyt6VWVMZ3JRZUNvTjAvSzRvYVJx?=
 =?utf-8?B?cFI2Nnp3QXV4SExKTUVmTXdBb1RFY0EwRmlyS284RmVVTWg0TWpqbEhUT3la?=
 =?utf-8?B?all4OGJvdGNoNzl2cFlrdVhITTF1VEVWOTBlMjZROE5TazI0eUFxaUFKQlNt?=
 =?utf-8?B?K3U3NzBid2hVY0k2R0FUZk5ud0wvRVB3dE5ITFhicy9ZTHJPMlczSU5xZDVi?=
 =?utf-8?B?TTcyQ3NsNW41cHlnM0I0eHBMTjlzWlVySVBXQ3ZLNkJVM0FxSmdDaDNqWm55?=
 =?utf-8?B?a1B1RHBpRGlOL1JSU1E1NTJzdjdSUHpJZ1dPeTM0dVplWEpEeHJrUlg4Q0hl?=
 =?utf-8?B?N3o3d0JUUjN1eERQWER1Y1d4M3R6YVVqdWsvSHd1NkdJZHZqSXFsSGVYUHlK?=
 =?utf-8?B?dWRvM1NOOVRDaXcyTS8wOHdhVU5HT3l4WGVROFVtTFB6am9KUnVPajBMcFI1?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5CBC10B2B823447BB8440B6C9014572@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad84add-9b06-4704-424d-08daf86bafd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 09:17:42.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6PvnLJ726g31QZ/6duzHSiLarFB2mQajTgi0m4gKWnhlaYiFazLt32OmwrR4C5HOe/smxEa9V8VRZMOfAEnVSkY4lPfLggT904+H8mjmUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5414
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDIzOjQ1ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAwNC0wMS0yMywgMjE6MjYsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBUaGVzZSBkZWJ1Z2Zz
IGZpbGVzIGFyZSBtYWlubHkgdXNlZCB0byBtYWtlIGV5ZSBkaWFncmFtIHRlc3QNCj4gPiBlYXNp
ZXIsDQo+ID4gZXNwZWNpYWxseSBoZWxwZnVsIHRvIGRvIEhRQSB0ZXN0IGZvciBhIG5ldyBJQyB3
aXRob3V0IGVmdXNlDQo+ID4gZW5hYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjY6IG5v
IGNoYW5nZXMNCj4gPiANCj4gPiB2NTogdXNpbmcgY29tbW9uIGRlYnVnZnMgY29uZmlnIENPTkZJ
R19ERUJVR19GUw0KPiA+IA0KPiA+IHY0OiBmaXggYnVpbGQgd2FybmluZyBvZiBzb21ldGltZXMg
dW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiA+IA0KPiA+IHYzOiBmaXggdHlwbyBvZiAiZGVidWdm
cyIgc3VnZ2VzdGVkIGJ5IEFuZ2Vsb0dpb2FjY2hpbm8NCj4gPiANCj4gPiB2MjogYWRkIENPTkZJ
R19QSFlfTVRLX1RQSFlfREVCVUdGUyBzdWdnZXN0ZWQgYnkgQW5nZWxvR2lvYWNjaGlubw0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyB8IDQwNQ0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQwNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRl
ay9waHktbXRrLXRwaHkuYw0KPiA+IGluZGV4IGU5MDZhODI3OTFiZC4uOTIzZTVlZTExOWYzIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4g
KysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiBAQCAtNyw2ICs3
LDcgQEANCj4gPiAgPHNraXA+DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB0cGh5X2RlYnVnZnNf
aW5pdChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksIHN0cnVjdA0KPiA+IG10a19waHlfaW5zdGFuY2Ug
Kmluc3QpDQo+ID4gK3sNCj4gPiArCWNoYXIgbmFtZVsxNl07DQo+ID4gKw0KPiA+ICsJc25wcmlu
dGYobmFtZSwgc2l6ZW9mKG5hbWUpIC0gMSwgInBoeS4lZCIsIGluc3QtPmluZGV4KTsNCj4gDQo+
IEkgd291b2xkIHN1Z2dlc3QgZHJpdmVyIG5hbWUvIGRldmljZSBuYW1lIHJhdGhlciB0aGFuIHBo
eS5mb28uLi4NCj4gYWdhaW4NCj4gZm9sa3MgbmVlZHMgdG8gc2VlIHdoYXQgaXMgZm9vDQo+IA0K
VGhlIGRyaXZlciBjcmVhdGVzIGEgcm9vdCBmb2xkZXIgYnkgaXRzIGRldmljZSBuYW1lLCBlLmcu
IA0KdC1waHlAMTEyOTAwMDAsIGl0IGhhcyB0d28gc3VicGh5LCB3aGVuIHVzZSBkZXZfbmFtZSgm
cGh5LT5kZXYpIHRvDQpjcmVhdGUgZm9sZGVyIGZvciBlYWNoIHBoeSwgaXQgd2lsbCBiZToNCg0K
IyBscyAvc3lzL2tlcm5lbC9kZWJ1Zy9waHkvdC1waHlAMTEyOTAwMDAvDQpwaHktdC1waHlAMTEy
OTAwMDAuMCAgcGh5LXQtcGh5QDExMjkwMDAwLjENCg0KdGhlIHBoeSdzIGRldmljZSBuYW1lIGlz
IGNyZWF0ZWQgYnkNCiJkZXZfc2V0X25hbWUoJnBoeS0+ZGV2LCAicGh5LSVzLiVkIiwgZGV2X25h
bWUoZGV2KSwgaWQpIg0KDQpkZXZfbmFtZShkZXYpIGlzIHRoZSBwYXJlbnQgbmFtZSwgaXQncyB0
LXBoeUAxMTI5MDAwMCBpbiBleGFtcGxlLA0KaWQgaXMgdGhlIHBoeS0+aWQuDQoNCmR1ZSB0byB0
aGUgcm9vdCBmb2xkZXIgYWxyZWFkeSBwcm92aWRlIGl0cyBwYXJlbnQgZGV2aWNlIG5hbWUsIHNl
ZW1zIG5vDQpuZWVkIHByb3ZpZGUgaXQgYWdhaW4gaW4gZWFjaCBwaHkncyBmb2xkZXIuDQoNCkhv
dyBhYm91dCBjcmVhdGUgdGhlIHBoeSdzIGZvbGRlciBieSA6ICJzbnByaW50ZihuYW1lLCBzaXpl
b2YobmFtZSkgLQ0KMSwgInBoeS0lZCIsIGluc3QtPnBoeS0+aWQpOyINCg0KdGhlbiBpdCBiZWNv
bWVzIGFzIGJlbG93LCBzZWVtcyBicmllZjoNCiMgbHMgL3N5cy9rZXJuZWwvZGVidWcvcGh5L3Qt
cGh5QDExMjkwMDAwLw0KcGh5LTAgIHBoeS0xDQoNClRoYW5rcyBhIGxvdA0KDQo+IA0KPiA+ICsJ
aW5zdC0+ZGJnZnMgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIobmFtZSwgdHBoeS0+ZGJnZnNfcm9vdCk7
DQo+ID4gKw0KPiA+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgidHlwZSIsIDA0NDQsIGluc3QtPmRi
Z2ZzLCBpbnN0LA0KPiA+ICZ0cGh5X3R5cGVfZm9wcyk7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChp
bnN0LT50eXBlKSB7DQo+ID4gKwljYXNlIFBIWV9UWVBFX1VTQjI6DQo+ID4gKwkJdTJfcGh5X2Ri
Z2ZzX2ZpbGVzX2NyZWF0ZShpbnN0KTsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgUEhZX1RZ
UEVfVVNCMzoNCj4gPiArCWNhc2UgUEhZX1RZUEVfUENJRToNCj4gPiArCQl1M19waHlfZGJnZnNf
ZmlsZXNfY3JlYXRlKGluc3QpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiAr
CQlicmVhazsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCjxza2lwPg0K
