Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725DA6A655F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCACR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCACRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:17:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4E3609A;
        Tue, 28 Feb 2023 18:17:44 -0800 (PST)
X-UUID: 3b21e3c8b7d711ed945fc101203acc17-20230301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UyPhrNv4eQQ5hdOqAN7TJGkkFH8CquqTkA08IL9hPkM=;
        b=ksv/4bGF6IOxylBAQdmwMVq9MUplqtxrq1Q+qo50Kw9sFRR1w5vusJkQRBFUhwfB3YlR/BUBNyrIMLYWXgov8nT85Nmo8oJedBf1Y1/QQM7h3gmX3nTG0JwRQF5+jQljr1UQLmr1M3rrOpAnAi3AauUIhWngic5dV2aRIXsUQvc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:d48ad809-6111-46c6-ac01-aa1be8675177,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:e55deb26-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 3b21e3c8b7d711ed945fc101203acc17-20230301
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1645233392; Wed, 01 Mar 2023 10:17:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 10:17:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 1 Mar 2023 10:17:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvgFHkwRgt3+5YhXGHaXsxB8Ee5fAY70Yd2LAKz+cEutRFGOBcLhQCcxUxmd+o7WKcudUb015lqQYd31E54C54ibFO5lGRD6tVxTp3V4GnVcvzKrNC4jV8JvRAAcVc9A5fw3o3BAcOe6UAg1KQegQKq0jb1MfuV1lEeMNmmopovLYM36xUpmLI4rc4feGwB0ROwfMXNJORhpPOQMwSzpBiwxK7vUrF2uFnMkGKaULUWGUHoJvwn94veShb49I7ggEff4mEyoMjVeR+DatQDakFntaPQjgrCEk9NJO4NHV5AwWgR7eObrmGdiLq5sm7Zg89tRpiXVcBpzxZIQQw2LBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyPhrNv4eQQ5hdOqAN7TJGkkFH8CquqTkA08IL9hPkM=;
 b=HECJVmEb+2TdMB5RJjNxwEGkGianu2Y9muz2DzGRUCeWi8ZaEHM909L47CGGJq400dlLCQHn2UX7E1dovWfhTKEllvuD5wnP/n8YZ8XCLnNigfBr96lYDRl6vnqLtfZ+krpPePLkvt/liMiit0l1uxky3lZ6pcc4umwl2L1YzocgM115OJVD1/LmArO+ISvXXmZkhpYhT1nTiBSWb23fTn1UnT0g4hamQ8Ec+Szp3cf0NaaqKQ9t5ehFKRI8FFRVhXjjLOr/R7XsAFpvogSJCJtnnl4WkO3abv+Z0ufrPBxTWlcVYpqTiP9LHyv44k93IgWq0ezKC7cBMkIwvpXJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyPhrNv4eQQ5hdOqAN7TJGkkFH8CquqTkA08IL9hPkM=;
 b=mu+i4ZwbDh3O3zm/1byVsy5DDgHm9X7ZlyNnQ4cDAfUUBz3W7zlunsNeQ2kc87RPQebO8ZimTivqhCEi6az7Wy0qQFc6eVBEOn57aOLDIy+Sibh3QPK60aYJRA7tt7Zq/UzJCv/iGquX2u2x3FNCMTBEemHGxTOXBJR217J8Vc4=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:17:32 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%4]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:17:32 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
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
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Thread-Topic: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Thread-Index: AQHZRmqDD+FeSB663U+0MLLNl8/aSq7cUnOAgABCwQCABZEwgIABjYKAgAGHOAA=
Date:   Wed, 1 Mar 2023 02:17:32 +0000
Message-ID: <f629f1b72e4859d79aac279ef3327715000e3210.camel@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
         <20230222030427.957-5-powen.kao@mediatek.com>
         <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
         <74bedcff32df0c93c14b004814017f3344247528.camel@mediatek.com>
         <0c17dd26-b1aa-54b0-6dc4-561cd996cead@quicinc.com>
         <76f74b86-8ff1-2346-4f5e-0048543bd8b0@quicinc.com>
In-Reply-To: <76f74b86-8ff1-2346-4f5e-0048543bd8b0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|TYZPR03MB5760:EE_
x-ms-office365-filtering-correlation-id: 1d4a2561-a79b-41fe-d5ec-08db19fb1d3d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkRSq6b6Fxtq0w2ymiBe295HiUxp8s3x3S4H9/X//I7LvpXitW2NHJryN42EuD5H4BNYhGemGjBNyz/CO37tM+qkHtXE44wt64H/VGNIYxsDsViAFYt8P0OwI8u42SrSPTNp7ok3Yx+2EHJkPkYDprFsEsAo8fzCgnspjBjO5hiIcqR4bxy0ObT0Z916Ox5IQeA6ZckRVnOrJj4YG9utKNEBunEmhkp3V5KniBINhrCNFMSNEcD+liP6QCk2R2PmHjSP6KQsndrzoXzTGG0ctCa4Mx3yVqgTkf9/XoQYUnneVxqMi1t+OAKU+qmmHclQtI42zslrA7IUSYWcL3vtsvWntL0GgOF11/o4wuCVHXNRiAQLpZwN656Id9qhb/mCqzJf8343DTvJACg9HRWNpDyayniQgS+U/bA8re3WH/JbWIMdm3FAwSg4tqY4Fz8ND4u4onvhwijy5qjFsXYpQK+2N1tghDb3fxT+g5EJZBIlQLwzCWlnP8CctUOySh0KRyD9qmkePMBl52ngdODPALiE5pmI91wD+3OwicQzVaPxHhQoFFbjHRvvRvoaMtJBalQD7R73OBuhVSZRW3VwZU0c78Cg/1vlXr22MAYDi82+Ed4lJOiNB1Rf/MKZdF6gVlc6cOXY4BZsCR9pYCDJSB206kPzexselin2FIT1sHCbOognSD2KasvaDy7VmjcPNnTldu9FxXRA430wFa9kEpGWrbWCXtEH4FCsALZiEXvxnRbJrZpSVoIplduknOf7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199018)(71200400001)(36756003)(7416002)(85182001)(478600001)(122000001)(5660300002)(186003)(26005)(6512007)(6506007)(38100700002)(921005)(53546011)(8936002)(83380400001)(6486002)(2906002)(110136005)(54906003)(86362001)(41300700001)(38070700005)(316002)(2616005)(64756008)(4326008)(66446008)(66476007)(66556008)(66946007)(8676002)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXRTK1JxQXVia0l5cHRrUC9nOGZkdDlhUXIzOGk1QzRMWEdCUEtSRmZEaC9F?=
 =?utf-8?B?V0FQNzY4VmJJelNQSEtxT2hOUWFSblJZU0NYTG5iTVZ0QXlEQW9oNWNjTFZw?=
 =?utf-8?B?VmVvNFRlNzBLTytpeVlIbmg2RWsrNWdrcVRDSkNMK0ZzRWNFK3d3V0hRN3E4?=
 =?utf-8?B?Kzh3SmpSdDFqcU5lUG42VG0rN3VUdDVHTWxBSXVma0x0enJEblJVdFVGVlJE?=
 =?utf-8?B?SnN2ZUt1YlByTHk5N0lCNjdvSWxUL043SjFuK0FSS1RENzlYZW1CdXgydnda?=
 =?utf-8?B?T2gzVWtCS0hDb0NTckl0RFY0U0RUdVlDOVhtNEZHQllVaUNaWkpTbGhPQk9Y?=
 =?utf-8?B?RVhwU3NmUHRMSXNMWllFcHZXZktObm44QXJDL0J4NHFIV3JNbFBLOXNibFJ3?=
 =?utf-8?B?NWM2TDkvM3l0bVBqRnJCdXUrNDJReCsxWURRVG8wQ0xoL2VZQ1EweDNWcG9Y?=
 =?utf-8?B?ZHp1T0xrdUNCRjMzdEFTY3RFNlJDZ2JBdjMvQ1ROYzBXdE5HZUVHZUtoWHFN?=
 =?utf-8?B?VGlXUUZCWjNnZjkyL2Y4M2REZnVoNnBrc2tYd1ZMSnY0bFVzSFJDcE1iYitx?=
 =?utf-8?B?ZkNpWVFtVk5tcnJ1U2Qwdngrbkg0cDF3MHBHVzdsNThUQm1HdElVL3lBTzI5?=
 =?utf-8?B?U0FralJWaEszZTd4U0FxYXRlbmJHeDFaTVIxbGp3eVVDWVZLczFMNWQraitV?=
 =?utf-8?B?Zi8zQjdUN1VuSVdSOVFsSnV1bWFmTUpWU1pwd0NiN29XTHhMTGdzMDJleXJI?=
 =?utf-8?B?cFZCUFZjV1VHaWdZREpvUVVRS2dpT0ZWMUs4cmRoUWIyZGQ0RjlNcGtZMUs4?=
 =?utf-8?B?enN2YythL0hTM1M1dWhzNU9GTHEzbEhuNWZTdTcxQ3V6cVd2aDdxZGFLeG1H?=
 =?utf-8?B?VnFPdEprRG9hSkIySCtmMnRDVHYwWWFZczB6TG50ZUxwOXo0cHFraytEQWNu?=
 =?utf-8?B?Q25jUU9CME84ZGtvSjNkMllTeEdXY0JZMXNuSlV5MzBueUNucDVrdWFKbEtP?=
 =?utf-8?B?Z2hYRUpXRU9zSVIwWlovdlRtZVhsdm85NGg0T0U4aUF0bTlyNzRWWTV2Uzk3?=
 =?utf-8?B?UFZid2xJYk5XZ1A0clJoNGFtMUVNbmhIRlFEU2xYYmRwTHBreVNwRmdyZkJT?=
 =?utf-8?B?SkpoaCsrbzdsMzdGTFI3SG4vK3VkdkMvL2VmWllxVkZ6TkZKRlY0RmliZERh?=
 =?utf-8?B?K3ZVK0dGZmFuRUpOTnJYeUw2ZDRqcUtCZngxL0lKaWFOUm92bHVTaWxWK2tS?=
 =?utf-8?B?WkdrTTN1SGpzaTA5S2M4WkpsN2JhY2JwblZKOFdRZUJ2bWp5L1J1Tm0zdU1F?=
 =?utf-8?B?cHpLZmJjSkRQU0I3QndLWm9VSC83cmpRQVdFbmVEL2JhYk9SSGllYXFteWsv?=
 =?utf-8?B?ZWVXbkdDNXFXRTFtRFBWaTNHcTlsRjNpWHRocWZJUkphTFN4NXAyNjlET3hK?=
 =?utf-8?B?NUVueklxQW1jTEhXcmdUdmVobEtkZ0ZkalF4SEFNRC9RUEdFcXRWakIvaW1l?=
 =?utf-8?B?RlhJdU9VZVlpRmcxaFNLVjBiK1NnekpZdlc5cGRQRCt0bnRXMHYvNVhqS3do?=
 =?utf-8?B?Z05wZ0N3U0Vqb0J3aGFxYllHckdlcmJvZkVCdDNXa2lHa0FSWFdiWG40VlF2?=
 =?utf-8?B?WkgzOEROTGpDNFcxaFpZRmgrck9pZWlMQXNkUTNCdFVlZjk0K3Z2WkErdmo5?=
 =?utf-8?B?OEZHQzN2NHpRd05nK3htTkN1ZllRK2NMRlNSV3dtMmtSYU8zWTdZYWZ5MUxp?=
 =?utf-8?B?MVZpU2NtZFoyQWJUMjhGTVZKYUFHb2JyTXlEWktZNXhMY01RZGIzc2hoOG1Y?=
 =?utf-8?B?OGtYeUJnUUp2WXJqTUxZWHA0cWJqbEU5aHVsTzJnVXBhdE9Ua2NVNW95cEIx?=
 =?utf-8?B?NXRvOHNIQTNVby9jdE5KMEZKN3hZZjFrTDczelpqcW54Ymw4dFpHRFV0Nkx5?=
 =?utf-8?B?MFZwVTcvUnNvc3NYaStwd1dIelkxNDZmeEtQcXd0UjlFRnZieXR1eG54ZEU5?=
 =?utf-8?B?emQweHhTTTNDdW1Lei8xa0JTRXNqdXJ2c3Z6QmVEcDhmNzRXa3Y5akVmckF6?=
 =?utf-8?B?Z0xVTnFpWnNmQm80Q0pXM21abk1KTnNXUElZMWpCWkpsTERRbzdKRjU0Y0lv?=
 =?utf-8?B?STgySmxwM2tPbFZVdGJNdVA4ZFhwQlU1c0M2UFF4NVpTZk1ldFBSNkoydTNi?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF80C97C5BC1044B2AFE6A5B93933B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a2561-a79b-41fe-d5ec-08db19fb1d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:17:32.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/Yla0FUxn7RTqT1CWk/CcP9JB3PpOfYacpvE7oizhclTq/gCxvFNOAqe7E5tRC8R8f12jvryaiyefSxgQWNxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5760
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvLA0KDQpTdXJlLCB3ZSBjYW4gZmlyc3QgaW50ZWdyYXRlIHVyIHBhdGNoIGFuZCBzZWUg
aWYgYW55dGhpbmcgaXMgbWlzc2luZw0KdGhhdCBuZWVkIGZ1cnRoZXIgdXBzdHJlYW0uIER1ZSB0
byBjb21hcGN0IHNjaGVkdWxlLCBJIHdvdWxkIGtpbmRseSBhc2sNCmlmIGl0IHdpbGwgYmUgcmVh
ZHkgYnkgdGhlIGVuZCBvZiB0aGlzIHdlZWs/IDopIFRoYW5rcw0KDQoNCk9uIE1vbiwgMjAyMy0w
Mi0yNyBhdCAxODo1NyAtMDgwMCwgQmFvIEQuIE5ndXllbiB3cm90ZToNCj4gT24gMi8yNi8yMDIz
IDc6MTQgU3VyZSBQTSwgWmlxaSBDaGVuIHdyb3RlOg0KPiA+IEhpIFBvd2VuLA0KPiA+IA0KPiA+
IFRoZSBCYW8uIEQgLiBOZ3V5ZW4gKHF1aWNfbmd1eWVuYkBxdWljaW5jLmNvbSkgZnJvbSBRQ09N
IGFscmVhZHkNCj4gPiBtYWRlIA0KPiA+IHBhdGNoIHRvIHN1cHBvcnQgTUNRIGFib3J0Lg0KPiA+
IA0KPiA+ICsrIEJhbyBoZXJlIHRvIGJlIGF3YXJlIG9mIGl0IGluIGNhc2UgeW91ciBlcnJvciBo
YW5kaW5nIHBhdGNoIA0KPiA+IGNvbmZsaWN0IHdpdGggaGlzIGFib3J0IGhhbmRsaW5nIHBhdGNo
Lg0KPiA+IA0KPiA+IA0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiANCj4gPiBaaXFpDQo+ID4gDQo+
ID4gDQo+ID4gT24gMi8yMy8yMDIzIDEwOjEzIFBNLCBQb3dlbiBLYW8gKOmrmOS8r+aWhykgd3Jv
dGU6DQo+ID4gPiBIaSBaaXFpLA0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHVyIGNvbW1lbnRz
Lg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBpZWNlIG9mIGNvZGUgc3VjY2Vzc2Z1bGx5IGR1bXAgcmVs
ZXZlbnQgcmVnaXN0ZXJzIG9uIG91cg0KPiA+ID4gcGxhdGZvcm0uIEFzIHlvdSBrbm93LCBtY3Eg
ZXJyb3IgaGFuZGxpbmcgZmxvdyBpcyBub3QgcmVhZHkgeWV0DQo+ID4gPiBzbyB0aGUNCj4gPiA+
IGluc2VydGlvbiBwb2ludCBtaWdodCBub3Qgc2VlbXMgdG8gYmUgcmVhc29uYWJsZS4NCj4gPiA+
IA0KPiA+ID4gTWF5YmUgZHJvcCB0aGlzIHBhdGNoIGZvciBub3csIEkgd2lsbCBzZW5kIGl0IGxh
dGVyIHdpdGggZXJyb3INCj4gPiA+IGhhbmRsaW5nDQo+ID4gPiBwYXRjaGVzLg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IE9uIFRodSwgMjAyMy0wMi0yMyBhdCAxODoxNCArMDgwMCwgWmlxaSBDaGVu
IHdyb3RlOg0KPiA+ID4gPiBIaSBQby1XZW4sDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAyLzIyLzIw
MjMgMTE6MDQgQU0sIFBvLVdlbiBLYW8gd3JvdGU6DQo+ID4gPiA+ID4gK3ZvaWQgdWZzaGNkX21j
cV9wcmludF9od3FzKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHVuc2lnbmVkDQo+ID4gPiA+ID4gbG9u
Zw0KPiA+ID4gPiA+IGJpdG1hcCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsgICAgaW50IGlk
LCBpOw0KPiA+ID4gPiA+ICsgICAgY2hhciBwcmVmaXhbMTVdOw0KPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiArICAgIGlmICghaXNfbWNxX2VuYWJsZWQoaGJhKSkNCj4gPiA+ID4gPiArICAgICAgICBy
ZXR1cm47DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgZm9yX2VhY2hfc2V0X2JpdChpZCwg
JmJpdG1hcCwgaGJhLT5ucl9od19xdWV1ZXMpIHsNCj4gPiA+ID4gPiArICAgICAgICBzbnByaW50
ZihwcmVmaXgsIHNpemVvZihwcmVmaXgpLCAicSVkIFNRQ0ZHOiAiLCBpZCk7DQo+ID4gPiA+ID4g
KyAgICAgICAgdWZzaGNkX2hleF9kdW1wKHByZWZpeCwNCj4gPiA+ID4gPiArICAgICAgICAgICAg
aGJhLT5tY3FfYmFzZSArIE1DUV9RQ0ZHX1NJWkUgKiBpZCwNCj4gPiA+ID4gPiBNQ1FfUUNGR19T
UV9TSVpFKTsNCj4gPiA+ID4gDQo+ID4gPiA+IElzIHlvdXIgcHVycG9zZSBkdW1wIHBlciBoYXJk
d2FyZSBxdWV1ZSByZWdpc3RlcnMgaGVyZT8gIElmDQo+ID4gPiA+IHllcywgd2h5DQo+ID4gPiA+
IGRvbid0IHVzZSB1ZnNtY3FfcmVhZGwoKSB0byBzYXZlIHRvIGEgYnVmZmVyIGFuZCB0aGVuIHVz
ZQ0KPiA+ID4gPiB1ZnNoY2RfaGV4X2R1bXAoKQ0KPiA+ID4gPiANCj4gPiA+ID4gdG8gZHVtcCA/
IEFyZSB5b3Ugc3VyZSB1ZnNoY2RfaGV4X2R1bXAoKSBjYW4gZHVtcCByZWdpc3Rlcg0KPiA+ID4g
PiBkaXJlY3RseT8NCj4gPiA+ID4gDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgIHNu
cHJpbnRmKHByZWZpeCwgc2l6ZW9mKHByZWZpeCksICJxJWQgQ1FDRkc6ICIsIGlkKTsNCj4gPiA+
ID4gPiArICAgICAgICB1ZnNoY2RfaGV4X2R1bXAocHJlZml4LA0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICBoYmEtPm1jcV9iYXNlICsgTUNRX1FDRkdfU0laRSAqIGlkICsNCj4gPiA+ID4gPiBNQ1Ff
UUNGR19TUV9TSVpFLCBNQ1FfUUNGR19DUV9TSVpFKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFNhbWUg
dG8gYWJvdmUgY29tbWVudC4NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgZm9yIChp
ID0gMDsgaSA8IE9QUl9NQVggOyBpKyspIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgc25wcmlu
dGYocHJlZml4LCBzaXplb2YocHJlZml4KSwgInElZCBPUFIlZDogIiwNCj4gPiA+ID4gPiBpZCwg
aSk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgIHVmc2hjZF9oZXhfZHVtcChwcmVmaXgsIG1jcV9v
cHJfYmFzZShoYmEsIGksDQo+ID4gPiA+ID4gaWQpLCBtY3Ffb3ByX3NpemVbaV0pOw0KPiA+ID4g
PiANCj4gPiA+ID4gU2FtZS4NCj4gPiA+ID4gPiArICAgICAgICB9DQo+ID4gPiA+ID4gKyAgICB9
DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAgQEAg
LTU3NCw3ICs1NjksMTYgQEAgdm9pZCB1ZnNoY2RfcHJpbnRfdHJzKHN0cnVjdCB1ZnNfaGJhDQo+
ID4gPiA+ID4gKmhiYSwNCj4gPiA+ID4gPiB1bnNpZ25lZCBsb25nIGJpdG1hcCwgYm9vbCBwcl9w
cmR0KQ0KPiA+ID4gPiA+ICAgICAgICAgICAgaWYgKHByX3ByZHQpDQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgdWZzaGNkX2hleF9kdW1wKCJVUElVIFBSRFQ6ICIsIGxyYnAtDQo+ID4gPiA+ID4g
PiB1Y2RfcHJkdF9wdHIsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
IHVmc2hjZF9zZ19lbnRyeV9zaXplKGhiYSkgKg0KPiA+ID4gPiA+IHByZHRfbGVuZ3RoKTsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgaWYgKGlzX21jcV9lbmFibGVkKGhiYSkpIHsN
Cj4gPiA+ID4gPiArICAgICAgICAgICAgY21kID0gbHJicC0+Y21kOw0KPiA+ID4gPiA+ICsgICAg
ICAgICAgICBpZiAoIWNtZCkNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgIHJldHVybjsNCj4g
PiA+ID4gPiArICAgICAgICAgICAgaHdxID0gdWZzaGNkX21jcV9yZXFfdG9faHdxKGhiYSwNCj4g
PiA+ID4gPiBzY3NpX2NtZF90b19ycShjbWQpKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgdWZz
aGNkX21jcV9wcmludF9od3FzKGhiYSwgMSA8PCBod3EtPmlkKTsNCj4gPiA+ID4gDQo+ID4gPiA+
IENhbGxpbmcgcmVnaXN0ZXJzIGR1bXAgZnVuY3Rpb24gaW4gdWZzaGNkX3ByaW50X3RycygpIGlz
IG5vdA0KPiA+ID4gPiByZWFzb25hYmxlLA0KPiA+ID4gPiBlZy4uIGZvciBlYWNoIGFib3J0ZWQg
cmVxdWVzdCwgaXQgd291bGQgcHJpbnQgb3V0IGFsbCBod3ENCj4gPiA+ID4gcmVnaXN0ZXJzLA0K
PiA+ID4gPiBpdCdzIG5vdCBtYWtlIHNlbnNlLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB3
ZSBzaG91bGQgbW92ZSBpdCBvdXQgb2YgdWZzaGNkX3ByaW50X3RycygpLg0KPiA+ID4gPiANCj4g
PiA+ID4gPiArICAgICAgICB9DQo+ID4gPiA+ID4gICAgICAgIH0NCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gICAgfQ0KPiA+ID4gPiANCj4gPiA+ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4gPiANCj4g
PiA+ID4gWmlxaQ0KPiA+ID4gPiANCj4gDQo+IEhpIFBvd2VuLA0KPiANCj4gSSBhbSBnb2luZyB0
byBwdXNoIHRoZSBtY3EgYWJvcnQgaGFuZGxpbmcgYW5kIG1jcSBlcnJvciBoYW5kbGluZw0KPiBj
b2RlIA0KPiB1cHN0cmVhbSBmb3IgcmV2aWV3IGluIGEgY291cGxlIGRheXMuIFdvdWxkIHRoYXQg
d29yayBmb3IgeW91Pw0KPiANCj4gUmVnYXJkcywNCj4gQmFvDQo+IA0K
