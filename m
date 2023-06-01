Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60F7197B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjFAJwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjFAJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:52:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B893107;
        Thu,  1 Jun 2023 02:52:12 -0700 (PDT)
X-UUID: f7d23180006111eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dHnsNhtCxAeBjkULfhWvCfMz+qu6Uat1Lw6+nrKi4/Y=;
        b=U9vPqj6OdZHtf3U72GE4mW1XmWjp111e4ajPl60/4ieF2/X8G4036p/BQLFz/BZm5TWVM7ugmroCfypGiviFP2ZRc5NF3qU65ymSl28lCbSAXfecSJ5vhHIFONREu2CwLpqNB2BapDXag4/hw4BDjsKA9978Clq3CQ47VJ5KlHA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c8c773f4-138c-4b78-ac27-407a54a07813,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4955413d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: f7d23180006111eeb20a276fd37b9834-20230601
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1829996693; Thu, 01 Jun 2023 17:52:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 17:52:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 17:52:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPyZd4rEye/mzeX5or+Aaqy2HRHZFKGwzs8DeWuEWjwAQ/c+t+jdkm0ttYtsRidVr1erPALj/zCarcm0pD87Z32uAzlfA09+adVuVbA/I70Tdv4AJchjbQ/4F3O0AGzDe1TAmVXyBfKDLnJ3DlydrtTz0kKiygtQCQcd9DH3qc18f+1x8TVm2uFYFalFAjY//deHvA9kdnZGBgqOuFSavJFIgifHM8Gpr2pbYW7BMJTeapX0DYtmkybC1ECDmKfiQEMi/dPLcMreo8YX/Law+3I6Fx5c/Sg5S135Sw74SFJSK6nRhlGfZMXc4ylDHSfx3ADkuAbtyfZPtbb2Kg880Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHnsNhtCxAeBjkULfhWvCfMz+qu6Uat1Lw6+nrKi4/Y=;
 b=afAKW5xK7iy0T022TCKmk/lQrTfvWtg2pocr07VwFx5h/t3STg+0nkA5tGIvoaxqBgKuIk/CEE7RN1nXrBWeQABPnqmwtlScTeEBb36QjrsozsR8btjnfEPojA7hU4JWHOGWp41V5+VNwBSFi5Rn5zDPKPuZncHK9F7TMeQYX7v9iTk/Xp0vSH49DuMsU2fQxSUY2ykHTm8m0miZSoj4v/upabRgKodQEKFFGuFmgYoFNOJfqjjIqotkiAHf9M7wt7ikFcMIGeeoL/C7AIK5i7lwyYGWQe1DzApXE2KuMsui0YKRVJc5fkVQj9QfbcKDvUOjbj6kP9O/gLGIB/HnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHnsNhtCxAeBjkULfhWvCfMz+qu6Uat1Lw6+nrKi4/Y=;
 b=YWbe9at5ySiAh0NzYf60OMTTgnRmB3eGbYS4YBk00sJYaO5eww4pK1xv0IkiNShCDP43WpMF4h8lVKIKbzyKOhR/UpdVhRwQ2R0dQXcqvpwCfuvawuG7Uhx2eCwudN87S91SwyKDQYnxOrXnQCtSXJRjPJAtQmPmg3I/h5cDjNI=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB8087.apcprd03.prod.outlook.com (2603:1096:820:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 09:52:02 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:52:02 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/8] mediatek: vcodec: remove the dependency of debug log
Thread-Topic: [PATCH 4/8] mediatek: vcodec: remove the dependency of debug log
Thread-Index: AQHZlGulm9/yGmXLtEmLmIdPdLDaJq91tJWA
Date:   Thu, 1 Jun 2023 09:52:02 +0000
Message-ID: <1f0509fea9f3326a90e04ee7a0a0ffad0aeb4b9f.camel@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
         <20230601030256.29875-5-yunfei.dong@mediatek.com>
         <ef3aaee1-e6ca-a89d-e002-42bf918736f4@collabora.com>
In-Reply-To: <ef3aaee1-e6ca-a89d-e002-42bf918736f4@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB8087:EE_
x-ms-office365-filtering-correlation-id: 78312bff-b4b4-402b-2d31-08db6285d9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsHHKNAT8/x6jE2KznQ5+I4aE3vZNuH2ZR9d3p/81DOOMPTqVZY8k9V8j/6XqwIWOz/VU6qZYKgtM+lzwv8gHEMJG0vJP3hdkVwtWtLPcaq2DdrUVBSUn+l3SrDMT10p2tIdJ9DTfM8PaQhzoNihziaHiLHf1b+FAYjtp9Jh9aK8MqOAwtxUGrIDgImeuw4niDBc7f0iyLXsZU4vhpqQj/uxvR0KUzc6+Wcv50StJGeM9tBEmaglk31pAVW62CxzSrXovsGk09EVhdV2D3AznjZa7lk5CBech/KEeATClaGLb+50wYloJ6Fk9mE6ihJ4itLL30bhaeZ5kBoKW0quyZI7k27KS3CURmPVxWNf+r/7FCynf5ZCVKg5N9gpHqu4gurpW5y7IVNOHleV0xq6VF/5jRcEF4Ve0br9MtJ3VQqO4DsexkzYAGXBZ27ZzWLaDIGoUHh4owAT7xgT7Prrq5KWwyB7tvnn4wTeQvmB1iqFA4FZBwwaBhCrSYUtvI7c04TIAywIB9yuVrLn5Jry8XAO9YgZe7u41DvQ3stk1LB8TgxzRyUhnN56iazGppKLcHg8jPLaeWHdjOzLZotJPdpa5/iRw5mYSR+7CRVN8iAlTJcc05K94zrybGrY0OVIIF1OO6KSuYDfZ5DjlGepSq6KCE+wgR+elAWW8LFwXmGrY/r/xRFgANxcJ8RrmYW/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(76116006)(91956017)(86362001)(26005)(478600001)(6506007)(6512007)(36756003)(85182001)(8936002)(8676002)(38100700002)(41300700001)(186003)(6486002)(2906002)(71200400001)(38070700005)(5660300002)(7416002)(122000001)(66946007)(2616005)(64756008)(66446008)(4326008)(66556008)(66476007)(316002)(83380400001)(110136005)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRZNExUblBHdEh1cHd1elpPWDJuays0eC8vYUZsVE82c2hNdVJEbGdGODA5?=
 =?utf-8?B?UElKTXgyekJyanhTaWRNZnlyNVoxUkhKRkRiRDQwdWM5SnBTY2tocUVqOXQ5?=
 =?utf-8?B?YUlzQXVSVUIzTVAxZnFLcWhYbE9YaVIvcXYvOGk3S2E5QW0yMzA3YTJMVXI2?=
 =?utf-8?B?anZNVUFqVm0yemkxOFRBWGlSL2s4NEJUVHhDclNFN1R3a0xOOXVibVRzTjVt?=
 =?utf-8?B?ZTJKaURUZUd6YjcvNXpqRUhjcHRvSEQ2dHY3aDFCVmVVWWxNSlhMYXc0Z1ha?=
 =?utf-8?B?aE9VdEMzQzU2cVNSVVRuNk1TaGtxQUpFdjFLSUhTZ0tRT0lNNXprVExxWFNI?=
 =?utf-8?B?SUw5cUV6WXpQODMxbjgzVTBkaVRmc1VBMGtGZ1FlT01OcFp3c1hjQTZla3pD?=
 =?utf-8?B?elo2SlJaanpab1JQaWFYYUI5WHQraXVkTFFMK05FQU5qRnBFZkZBa2cxVGVz?=
 =?utf-8?B?dDkzZDEwbXp5VGVIaHZtazVYa3hkbndmczQwa0FCcFhhODJ0aEJSQ09sQTRV?=
 =?utf-8?B?MldzM0VHeGpFa2svZFVRSE4wOTZmc2pCbXlPc1BuRUFlN2NqcHRyNVI3TDkw?=
 =?utf-8?B?Z2xucVpoVlNETE1EZ1l5Mk1memNld2lLUnBjZUJqM2h4QjlPWDVMclV2Rklx?=
 =?utf-8?B?ZUE5WFZma2w4WkpYVXdzQXFORnR2NUt5OXJsVE1wd0dwSkdCQnNkdWI0MVlQ?=
 =?utf-8?B?VTVuV0VKQXg4c3M1bFRHbFRzR1lWWTFwZm5lV2NOUDRHbGFmdjhUc1E4VkNs?=
 =?utf-8?B?OVdDSGNNUzZkQjBTMGU4QTJYaXhyZnIwQXUwSE9SVGtGZEhuYkk4cWdlb1ov?=
 =?utf-8?B?ZUprd2NHYXhwOW8xZ3Uyb1J6UVNuUDBEVTlZM0ZHaDkxb1VUSXZvL043RVFN?=
 =?utf-8?B?K0ZWV284dXRmblNPUTk5Z3JNNDV1ZG9FVDhndDZkejlOclA1RXFRRHZoSXU2?=
 =?utf-8?B?TGNGVUtUT2g1WG1SVytQQlNSQk1RTkFyekUrV05xRzBtWEJncGlUWWl4VkY3?=
 =?utf-8?B?REk5aGVJSVdLQ0JpclhDaUt3K1Jxb1A0VmN3SE9XRm8rYlExZDVHNFR0YlBE?=
 =?utf-8?B?NzNuazBXcmdnMitUMHlPbXgya0VYSlJ5NUVoU3MrS1M5VGhKbklFYTNpMzBC?=
 =?utf-8?B?YTlKNk5MVjhDT3A2dUFodGs5MnVFWkxYdGVCRFNJdUhDTWZsbmZuN3ArZGJZ?=
 =?utf-8?B?STR6eHhyUjMrMWxUUnBkRUJWYjZuRjRZR2RNWUVyaVpUNHBYSktqcGFsdElB?=
 =?utf-8?B?Vm1pT2F6VGs2aktyejYvZkdHNFhpdUtPZkZnR0tuaHJ0V2NXT25FcXFRUlpr?=
 =?utf-8?B?VWFyRE93SExEczdOR0o5d3RjZmtBQnROMFo0Z0h2MEphZXd6SFo0eDdRLzU3?=
 =?utf-8?B?R3JIb3ozVHk2Y2pKUnliSG52MzRsTFA3dCtVUnlCMGZIbWMrWG9UL3B4NVd0?=
 =?utf-8?B?S2VpYWxBWXZsNlZxdWo2OHp0QmlZUjF4TmF5SWRZSXJpZjJHNW1CZm1JVzNK?=
 =?utf-8?B?MEJ0NzloSVNlZGxRcTVXdnRQVE4xeS9LaTdUaG1ydFFQclEycEZGcTBZN3Fa?=
 =?utf-8?B?VkhOaWJEUTdPa2tWZTJaYXlrRVNGWFBaaGJjN2g0TkZoVkdBbDhETG9YRC8z?=
 =?utf-8?B?aWxFVXhqeVNOK3dZUVRBVVhBUUcvaU1aZFZvc1hsNEg0QWNuTy96WTVyZGVN?=
 =?utf-8?B?YmhxaEpUWXFGMngvR3ZJMjlJS0dYbUJmS1RLdHcrNHlWRDUwRWdqZVQ1SGd2?=
 =?utf-8?B?a3kveTNoY09jWTJoZnoraDR2VzgzUkNLdEN3NWZPMHBWS0VSVkhCRWFYNlpm?=
 =?utf-8?B?ZS9YVDR1anZXSncra1NreDZoemxwUHJ0NEtwazJDOHpjZ2FmeGlDckpaSEhT?=
 =?utf-8?B?Y01DNk1uYnl2dVQ1QUF5U3dVMnozWG8vcEJZM0tuV2dEYVRSVXc0czkyY25p?=
 =?utf-8?B?eTRCUDdzZFFrUE1lRW94STJBZlp4Nnp2Q2Y3bitOYUQ5V3lZWW5nK2pZRnlH?=
 =?utf-8?B?RXQ4NUxha0lCSTNXbnpwaFpTdjRMYVprbGJnYVFxc2psNDBpZldWa3p5OGx4?=
 =?utf-8?B?ZHkzNlEvMmxocUk4clU0ZFRKVVU5YUFqcy9MM3B0ZDJIQngrZnlySU1tZjFS?=
 =?utf-8?B?VXpxQVdaNVI0eVhFdnc5QzV3TVJqdkE1WFlqSkdOTWhZYk85bmEyTGhUeEtR?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0946BA6452E3474BAECF11193FF6B91E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78312bff-b4b4-402b-2d31-08db6285d9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:52:02.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8aS37zYHG9QKGPYqCvFjfn00qCI3S0WNWhOR7iH7iWbvsKobAvAJixXOJ+IjJzrFL3FlDkMBaYvuDgsqEuvJmoeAjnhFOXC4APmlQXPrP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8087
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBU
aHUsIDIwMjMtMDYtMDEgYXQgMTE6MjkgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gIElsIDAxLzA2LzIzIDA1OjAyLCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+ICdtdGtfdmNvZGVjX2RlYnVnJyBhbmQgJ210a192Y29kZWNfZXJyJyBk
ZXBlbmRzIG9uICdtdGtfdmNvZGVjX2N0eCcNCj4gPiB0byBnZXQgdGhlIGluZGV4IG9mIGVhY2gg
aW5zdGFuY2UsIHVzaW5nIHRoZSBpbmRleCBkaXJlY3RseSBpbnN0ZWFkDQo+ID4gb2Ygd2l0aCAn
bXRrX3Zjb2RlY19jdHgnLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5
dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vbWVkaWF0ZWsvdmNv
ZGVjL210a192Y29kZWNfdXRpbC5oICAgICAgICAgfCAgMzYgKysrLS0NCj4gPiAgIC4uLi92Y29k
ZWMvdmRlYy92ZGVjX2F2MV9yZXFfbGF0X2lmLmMgICAgICAgICB8ICA3OCArKysrKy0tLS0tLQ0K
PiA+ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2NF9pZi5jICAgICAgIHwgIDQ2
ICsrKy0tLS0NCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gyNjRfcmVxX2lm
LmMgICB8ICAzMiArKy0tLQ0KPiA+ICAgLi4uL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2NF9yZXFfbXVs
dGlfaWYuYyAgICAgIHwgIDYyICsrKystLS0tLQ0KPiA+ICAgLi4uL3Zjb2RlYy92ZGVjL3ZkZWNf
aGV2Y19yZXFfbXVsdGlfaWYuYyAgICAgIHwgIDU0ICsrKystLS0tDQo+ID4gICAuLi4vbWVkaWF0
ZWsvdmNvZGVjL3ZkZWMvdmRlY192cDhfaWYuYyAgICAgICAgfCAgMzggKysrLS0tDQo+ID4gICAu
Li4vbWVkaWF0ZWsvdmNvZGVjL3ZkZWMvdmRlY192cDhfcmVxX2lmLmMgICAgfCAgMzYgKystLS0N
Cj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3ZwOV9pZi5jICAgICAgICB8IDEy
OCArKysrKysrKystLQ0KPiAtLS0tLS0tDQo+ID4gICAuLi4vdmNvZGVjL3ZkZWMvdmRlY192cDlf
cmVxX2xhdF9pZi5jICAgICAgICAgfCAgNjcgKysrKy0tLS0tDQo+ID4gICAuLi4vcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL3ZkZWNfdnB1X2lmLmMgICAgfCAgNDggKysrLS0tLQ0KPiA+ICAgLi4u
L21lZGlhdGVrL3Zjb2RlYy92ZW5jL3ZlbmNfaDI2NF9pZi5jICAgICAgIHwgIDc0ICsrKysrLS0t
LS0NCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmVuYy92ZW5jX3ZwOF9pZi5jICAgICAgICB8
ICA0NCArKystLS0NCj4gPiAgIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmVuY192cHVf
aWYuYyAgICB8ICA1NCArKysrLS0tLQ0KPiA+ICAgMTQgZmlsZXMgY2hhbmdlZCwgMzk5IGluc2Vy
dGlvbnMoKyksIDM5OCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY191dGlsLmgNCj4g
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwu
aA0KPiA+IGluZGV4IGVjYjBiZGYzYTRmNC4uZjAxOGFmMzhiMzlkIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5o
DQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zj
b2RlY191dGlsLmgNCj4gPiBAQCAtMzEsNDIgKzMxLDM4IEBAIHN0cnVjdCBtdGtfdmNvZGVjX2Rl
djsNCj4gPiAgICNkZWZpbmUgbXRrX3Y0bDJfZXJyKGZtdCwgYXJncy4uLikgICAgICAgICAgICAg
ICAgXA0KPiA+ICAgcHJfZXJyKCJbTVRLX1Y0TDJdW0VSUk9SXSAiIGZtdCAiXG4iLCAjI2FyZ3Mp
DQo+ID4gICANCj4gPiAtI2RlZmluZSBtdGtfdmNvZGVjX2VycihoLCBmbXQsIGFyZ3MuLi4pXA0K
PiA+IC1wcl9lcnIoIltNVEtfVkNPREVDXVtFUlJPUl1bJWRdOiAiIGZtdCAiXG4iLFwNCj4gPiAt
ICAgICAgICgoc3RydWN0IG10a192Y29kZWNfY3R4ICopKGgpLT5jdHgpLT5pZCwgIyNhcmdzKQ0K
PiA+ICsjZGVmaW5lIG10a192Y29kZWNfZXJyKGluc3RfaWQsIGZtdCwNCj4gYXJncy4uLikgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArcHJfZXJyKCJbTVRLX1ZDT0RFQ11bRVJST1Jd
WyVkXTogIiBmbXQgIlxuIiwgaW5zdF9pZCwgIyNhcmdzKQ0KPiA+ICAgDQo+IA0KPiBUaGlzICpo
dWdlKiBjbGVhbnVwIChjb25ncmF0cyBidHchKSB3b3VsZCBiZSBhIGdyZWF0IG9jY2FzaW9uIHRv
DQo+IGNoYW5nZSB0aG9zZQ0KPiBwcl9lcnIoKSB0byBkZXZfZXJyKCkuIENhbiB3ZSBkbyB0aGF0
Pw0KPiANCg0KQ2FuIGNoYW5nZSBwcl9lcnIgdG8gZGV2X2VyciwgYnV0IG5lZWQgdG8gYWRkIG9u
ZSBleHRyYSBwYXJhbWV0ZXIgImRldiINCmluIG10a192Y29kZWNfZXJyLiBXaGV0aGVyIG5lZWQg
dG8gY2hhbmdlIG10a192Y29kZWNfZGVidWc/DQoNCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
QmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg==
