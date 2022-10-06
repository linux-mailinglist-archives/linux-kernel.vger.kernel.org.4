Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F55F5F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJFDOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFDOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:14:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172B83F37;
        Wed,  5 Oct 2022 20:14:00 -0700 (PDT)
X-UUID: 759b85f6a1eb47a78b520b8856ee78d0-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JdqvzQhCN85GaEshFeazk29kmlOu67vxZ3xYT58NUMY=;
        b=IwygvSSpfwHnxE3sj1YKRnSrjHhxfkqMw/DGavsOv/2Mr0aQoMcEBvr7Y2yZrrjroFcxgbgyydA6SOBZ0fLTcXLdNqG2uV2T/g3hs4zb6CLx2wx/NifAbTxjdUr+Ef/Q9pK4Jld3UYKkWzcLcsLrxfKAGTsmgGQITuD8qJWhGg4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:dbad4c47-f005-4cca-b475-e3780687369c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:930da985-5312-4339-9a65-dc27c4b243b8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 759b85f6a1eb47a78b520b8856ee78d0-20221006
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1804677427; Thu, 06 Oct 2022 11:13:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 11:13:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 6 Oct 2022 11:13:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU/JuOaxpHFKcyb+6Ebc+5vAFyvzK+gmsaTlU+t7EIPYpx2WnQWHhORaXlX99N3hXg79WN48HceW0EBq3ebNHO/oCEgNta7XDlFoZDdgJ0noOrODty4ZFftBHiJocYmoA/JzMD0zw/wHyVyqXBSqZMea1a7wWOz5S5XLY4fTAcxOpewQsyRl/T8Fci4e19W+GJGwvwj7zCFAlk9vTUVVQhDeTE4dmWVb7ioMO74P+7BWc7v6Mh2JhkhxP7BG5SykcuzpBBPFyMSRuY9oagSg4edWmcKf7Z4eI5ZdvRm5BYeNdRBnFpwlvl7E4oQ6/1pXXkMxTZjwBgdGpF+Z2ZsjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdqvzQhCN85GaEshFeazk29kmlOu67vxZ3xYT58NUMY=;
 b=YHorCr68JnKF+txxaY8kzEmmSFZxAhzvvWw/KV0Q+zikxngg4GhyBNbE98tKO7rHDN5vt+8Btihvs9Ck3T/FTInisOamVRhatEewKdSzkw6eB4TjtwEcayRajax8kXf/4hk5ruqU/JZQFPRssSPgdLPCe5Y3gnMUaciZK7l3OZ+dtJkkgCnpNpC1Vs+s96WnOG/YgtyKfjn5VmAQlNWDMw/rWa/lQi2vlzJGPwaW4pKj0L7xHJjfgVn5gp6GLsgj06EUSLUYSHNo6MYoVwtmSETCYJlSwxHKLk2V13zSfV8/u0tvB68dkVk327u1wWs690ShxtORqb8V6v1MTDyLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdqvzQhCN85GaEshFeazk29kmlOu67vxZ3xYT58NUMY=;
 b=tzx6oGwQnhTPrPHVeV8eYMcc0S+Ji4IP0Y6G6ZYFAHqiEp5aUdrMc4zFIlxzCkWzwf4AgSkyB+qS0V0PMrYMwQ2/af0hcNKCGZW2opwfU9jDWbu/4Rc3BXj4+d19NfgoJodjcX5JYviuV7U/A9eFZHDAJjiTdv3rdLUDwAIUNIQ=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5613.apcprd03.prod.outlook.com (2603:1096:400:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Thu, 6 Oct
 2022 03:13:53 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff%3]) with mapi id 15.20.5676.014; Thu, 6 Oct 2022
 03:13:53 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Topic: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Index: AQHY1N0E4TAVmPuXsEGI3cvUVfYPj635Q4yAgAYgWACAAEWFgIABEC8A
Date:   Thu, 6 Oct 2022 03:13:52 +0000
Message-ID: <e4783b3d1eab3776aa7b2b36783e020783f3ccbb.camel@mediatek.com>
References: <20220930145701.18790-9-trevor.wu@mediatek.com>
         <202210011740.ZdLtxKq1-lkp@intel.com>
         <de20b79da18bde2bbe56784cf4e209894f8235bf.camel@mediatek.com>
         <Yz1jnb03bsI06rQB@sirena.org.uk>
In-Reply-To: <Yz1jnb03bsI06rQB@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5613:EE_
x-ms-office365-filtering-correlation-id: 93c0a4d1-9fdd-40d5-53a8-08daa748cc14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOSepwnO5rdwr1GhUY2G7KP2IEpZZNpd2u3dmu+3761jcGgBQhvZho4reJYDFJ1gOn4OpkIlF7nNtmtyXy2PAVq9SajigJYAWy+0BgOP2JtPftmXRL3j+/GrML80JYg08chNfmWzFUcAp40oz81tmy+x+APN27kiONntFjLhr9b9fQgw5J8cxcBpAYW+w11Wma+WSndrRtPAL7RyBE3LppWre5PMYTwBUxNskeDZwr+DCu2zmPrs9tW/6ijU6orbfZ+SSLIq0yrkBj/eY6IDuju8Kh6uyYaacS445CVJcitCGLCh0yiQO48+pGigJq56OezSIhqOZoR96/KO1oUgEldKX4YS+QUkbdzgYkEC0WLW0SRtc6LzmCZEdSf0xhxNkR470tBi3gmrYQp7bWTJ9vsp/zNU/iiUQGF3ewO8CC1oE5V+0g/Q8H6RThqUPY7YNrLVPEuB7CqCD5B4I0FtJCUA5BpmEV2DTfUnHk04idZZl+h7Ju5fjPxxLcWp0wMw338SE87xCx2ax0oXtq1nA1sStymW9N6ECP4DM0kauyi3J7NjuOhO7Ebl/mZmJAnFwVbQyQ0ypwTWRC10BIYucRQ46j9Espy9AaivhYmkAb57+p0rdO7TMdS6XkCgHUIF/wLwWzsa5P+6XqMOmh6EUgNsXAaiGQftElR6fRwuoOCtLsCb9tYTGx+wWuwn2uTmehBqIrOdM94EFFSuEDBMWQCSUBnKRRkKhLuIyXbUbfVpzEOuwXdLeEoy+B0o3FTk01HsI5JbFiXPnW1rQ7IP2Cyq23+hmabSo8UGtVWLBk8uZJVzKNRNk6EESy2WR650kYRsLRhKPwIeXRJQ/IU8Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(5660300002)(26005)(6512007)(66946007)(478600001)(6506007)(64756008)(76116006)(66556008)(6916009)(86362001)(54906003)(8676002)(66476007)(66446008)(316002)(6486002)(4326008)(8936002)(38100700002)(122000001)(186003)(2616005)(7416002)(2906002)(4744005)(41300700001)(38070700005)(36756003)(71200400001)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnpjcEd3Uk80cC9SNjNvNlFoNllkZFZ2cXpLMm8rRlpQMTRybFJXOUswVldE?=
 =?utf-8?B?ZkxNdytNQ1ppTi92eCtabzN1KzZydmZveFZ6TGRCZkI4cUxZSnlpT0o1NkhY?=
 =?utf-8?B?ampTZm9QWm9OOTl3dmRZOC9RdlRGWmpKK21DeXNyaVVjTDRsdUI2ZklCTyt0?=
 =?utf-8?B?N3hmck1BbzhBNTVUY2ViaUxCME5RTUQ2RGdja2lUVmowbDQvZ2pCaWIyZlFG?=
 =?utf-8?B?NEduc3FyakFURGhwMVRvamw3M2loemFCWGFPMVNBUWxoZDRjbGJ5bG83UXBB?=
 =?utf-8?B?b0UrL3VRWkhPRnpsRkxYMjNLRStuY1FoSHFrMHdmWjRKRCs0QkpSMEwrcDRV?=
 =?utf-8?B?ZktyS2ZMcysvVTJDaGdpR01lTmwwR1BKWDVaSmRzTWkvcWVMRDlIRXZDRThF?=
 =?utf-8?B?eVp3V3R1b2pZM2RIaXBRQkl4aldCSDVkaEVxWlVwcjBLRXc3aVBhcXNGdDRG?=
 =?utf-8?B?TFY1MXBpeGpSWDE0ZGNLVEQwaVpmRVVBenloR3hoSGFtbGdER2tIdTJpdTFS?=
 =?utf-8?B?c2xtclpCMnNKMmxPc1lOTlExWS9GWEk4bDVKUHE2UWRjTktMSkN0bEpMaEg5?=
 =?utf-8?B?UnpVbjUvVHVvV0g1eEV5NEFJZnQ1cWJ2bVo0S0Vxei8xVHgvZmlQdWpyeTNx?=
 =?utf-8?B?cFo0TnlCajdYakNFNmpqZTV4MTBMK1JpR24zN3I3QU42SklrWUtvRW1aVUpz?=
 =?utf-8?B?RmRuN3U5dll4OWxFVUFlU2Nrd1k2MnpYTmswUzU3L0V4N1pjSTBiODBXODRX?=
 =?utf-8?B?T1ZGenNjNHhvYnR2Zk9qSmF0anZ3SmpXbFBGdERQSVY1ZWIwZXdsb2lGZFo1?=
 =?utf-8?B?VGRJVW1NcEdYekVlQU93U0J6d2d3aHJrTHhLVnhDVnRWSVgxei83TncySDVm?=
 =?utf-8?B?cFFzb3ZRc3RvL1phNDdCeWg3N1pjdmdFaXBIL0JQWjFLWlRuU2t5M2xBRkNM?=
 =?utf-8?B?ZXJ4YTB1MUlEbjUxWEcyei9KcFhOWUZNNW03TElNRTZEV1Q5RjE2MHh6MkQ1?=
 =?utf-8?B?aDduNEMxNkNvNjAxSTJCMW9UR3VlaE9FL3RZbXphajRYR0FXaUpsWHB5SndT?=
 =?utf-8?B?dXp6UWRYRWgrT1pWUUFiOSs5YVpmQWtuZlFGQVNrSWp0NGc5N1h5endlUGdi?=
 =?utf-8?B?ZWFmNkc5QUVXdy9uZVczc3VBcHFRNUtRR2RMdWRNQkEvYXVEcTVZNnpZMTkx?=
 =?utf-8?B?L09RSGlmVXdCYVVBODEvZEthR0t0enYwSU92amMveUE4M2UyT3JYK3VCdW1M?=
 =?utf-8?B?L215QjVVaE1xTm5MNjVwVm02TVBrbG5EYWJnMzdUSzRsRnlEN1FlZ09JSlNy?=
 =?utf-8?B?Yk1CTkdQRjhmM01CS0RrN2VxNnZVd0NBa2VoVVMrcll3ZHRKOE9aMjA0R3Fq?=
 =?utf-8?B?SDFmK2RXOUFqREUwbFRsWGUzR291RVFXOVNhVjlsNTJ2cjlDRUV5elJ4czdV?=
 =?utf-8?B?SlZXZS9SSDFTYWs5RXZTT1NBb25tUzRGNXZSQUFzaFE5VUFPTmhhc1ZubzNU?=
 =?utf-8?B?aDVoSS9VVTc4M3UweVc5SG9VUXZEaHJPSDZvaDRzZmRLWGVuOW1td0l0dHVJ?=
 =?utf-8?B?Z0dPOEh4aW1nd2NmQW94VTBXWUFwWmZZRnFxdzFHTTYxQS90VEllM2J6RmNN?=
 =?utf-8?B?QTdST1J3blA3UjhzWFR5Q0haUFIxVVAwL0hMb2V1bHlsT0hDMmRGUS9SU1FH?=
 =?utf-8?B?YWJlVGphNm1hRTNReVVOVlNSM2NXa2NYcG92ay9FZmcwZTZ2WWZGcFROMXpm?=
 =?utf-8?B?UExuSDlFQ0VjN0JocVdpcmowUG5ucVFLVmd3VTdUT1dxeUcwYzRyQkRFU1Z0?=
 =?utf-8?B?ZjlHTDRXelpwaUdDQnNLWkxSMFRsUE43aC9Cdk9VdG1nY2VlREV3OXBRazZT?=
 =?utf-8?B?TkJUemJsT0ZtamtMUUFOWDMxblRoQi9qZ2tjNk1TVVdMNzFkL2F1SHNoR2Zh?=
 =?utf-8?B?VFZoZHBPMmU3cVE5VXdWZ0dMc0NtOFZGRTQzeE9uN3dvUGRrV0Y2aTUrZjBw?=
 =?utf-8?B?YVB2RGVCMVUxV1hYRE43RkVjY3dGQnpHTTJkTyt0c3kvdGptQU1Pa1B6SjRn?=
 =?utf-8?B?YjFvZk9BYWI4QzY3K3JTdGtxaUhUem13OXJlNEdtNGJLcGVJbWpIbC9aaTBJ?=
 =?utf-8?B?RU5LNzdwbjVlNFNvbnkva011b2hNcWh3NWo1TWVsVkN3amRXOTN5NCtsMEVH?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0C386C7F18014490C44C451D0918AD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c0a4d1-9fdd-40d5-53a8-08daa748cc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 03:13:52.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0e8AU+F68ZZm7USDQ+7duePiHhVUfOyxfLV4YJY5Hgo7oHPYU77cSGU0PqqMZTKc+28YV9mu5k3WO/qnZ/tNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5613
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDExOjU5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIE9jdCAwNSwgMjAyMiBhdCAwNjo1MDo1M0FNICswMDAwLCBUcmV2b3IgV3UgKOWQs+aW
h+iJrykgd3JvdGU6DQo+ID4gSGkgbWFpbnRhaW5lcnMsDQo+ID4gDQo+ID4gQXMgSSBtZW50aW9u
ZWQgaW4gdGhlIGNvbW1lbnQsIHRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBhIHJldmlld2luZw0KPiA+
IHNlcmllcy4NCj4gPiBTaG91bGQgSSByZW1vdmUgdGhlIHJlbGF0ZWQgY29kZSBmcm9tIHRoaXMg
cGF0Y2ggaW4gY2FzZSBvZiB0aGUNCj4gPiBidWlsZA0KPiA+IGVycm9yPw0KPiANCj4gSXQncyBi
aXQgZWFzaWVyIHRvIGRvIHRoYXQsIHRob3VnaCBpdCBzaG91bGQgYmUgZmluZSB0byBqdXN0IG5v
dGUgaW4NCj4gdGhlDQo+IGNvdmVyIGxpa2UgeW91J3ZlIGRvbmUuDQoNCkdvdCBpdCwgSSB3aWxs
IHJlbW92ZSB0aGUgY29kZSBpZiB0aGUgcGF0Y2ggaXMgbm90IG1lcmdlZCBiZWZvcmUgVjIuDQoN
ClRoYW5rcywNClRyZXZvcg0K
