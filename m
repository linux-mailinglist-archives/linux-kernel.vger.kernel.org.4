Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3371908F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFAChq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFACho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:37:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDC132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:37:37 -0700 (PDT)
X-UUID: be6e28a2002211ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wUBFENXue76+R28SKSarGQavua5y6pv0HcWL5TvQxOI=;
        b=QKDaVzNrslEfYj0LOZsapteTAo/rDmgstFXu4etITslHHKs83eJuY6snUJ+kp4AIqf2SUMVhBmhL4+e/9aM/iVveTHc5Hv4o0dX/ssPVKXvl7D9TpVvLAoD6ev588+GS0w2b73FCEnEBUAji2R/h++hr/fHEu6pI3I9HOGXqH3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e42500e7-34cc-445a-a3bb-ebb81b198010,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:e42500e7-34cc-445a-a3bb-ebb81b198010,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:25c2313d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230601074814UO7581IP,BulkQuantity:17,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: be6e28a2002211ee9cb5633481061a41-20230601
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1498670243; Thu, 01 Jun 2023 10:19:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 10:19:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 10:19:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+0XvaCmZ835jCXnr6siFc9EvpooXNNYvBSFmdagfuaqg7DTpwGUl36cKUg1XRfUsV/c8M73eGAkR4uvp0UKJe/Lrykawi5Xmr367FWx9UX5kJEKCMB6L10K9itVA7j96OuGh7+awBnyBt95IpnC+vsd6uD2AZkEECRv/YaA21cLWT4ozGOvWFEIpuJHH7nmJLNoHDjKupd9UyT/gl4bkFTk6rjfj3RDuu23elA4vRkiQMexW3JxpLrm0nQcmkjjYDAMqZN7yPXrTz8hpEwLlIhyaXbm4frzaBgws102CtT0mZOtfuGMIU5UF6aPBmMcGMyGPuBFE0f9birKbUsttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUBFENXue76+R28SKSarGQavua5y6pv0HcWL5TvQxOI=;
 b=PMfK//XnRIQz4JjMcsH75nOKYFVP/gfOcH83Sqp9/7fipSycqSoi2jb1IxXjoovp0lfukGXXFN9vu7FCOgjUiGvxbeWyxJ5kAKsrUm9h9t0oj3ABGsr2nquG/91me8GBqM9CtGOLIaerB3jlwjNkhH2qit5gMhRbRfaEhbO6SlMH76wI/9Q0Pl+IHw1KFNnnUA0Yps41AXmAr74cQ9vf/qQqhAxre8fXujf+Km8ce78jAA0lXru4irPNgiZS78LMeK23jaZLsIKcJDZZljo7nhTmyJ3wPramLBV2R35sscB6Hwo5Dn0KYIr8QYsE6Xg6Kmok3vSpdFLkKhk7fDB7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUBFENXue76+R28SKSarGQavua5y6pv0HcWL5TvQxOI=;
 b=Ckj+5l4oDp9/ndteqYg7I9ncHfF6uHWWd6JHyN6+jUc3bKdRsESI4WM0pMkTXXSBtTFEVeJacb8FnQCp2J10ZqSYNvVQiN2bV6fJ8Rt6nG5CCfZbNichZZ2fVjpwN8FR0+6R3+IjpPPGRnyYySbTyyjJKe11pjITh/LtEgWe0Jo=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB7953.apcprd03.prod.outlook.com (2603:1096:400:458::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:19:28 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:19:28 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "dianders@chromium.org" <dianders@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: fix use-after-free in driver
 remove path
Thread-Topic: [PATCH 1/2] ASoC: mediatek: mt8188: fix use-after-free in driver
 remove path
Thread-Index: AQHZksfjUJdapyLur0O0FSAIuzeWFq91DxUAgAAqVYA=
Date:   Thu, 1 Jun 2023 02:19:27 +0000
Message-ID: <25fd196a998746a36351b36c1b42242be792ccd6.camel@mediatek.com>
References: <20230530072514.22001-1-trevor.wu@mediatek.com>
         <20230530072514.22001-2-trevor.wu@mediatek.com>
         <CAD=FV=X1JURLwZHraNwSMT7vwLNRNw7h0MmpbeWnr1yht6-3VA@mail.gmail.com>
In-Reply-To: <CAD=FV=X1JURLwZHraNwSMT7vwLNRNw7h0MmpbeWnr1yht6-3VA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB7953:EE_
x-ms-office365-filtering-correlation-id: dcde6808-e403-435f-211a-08db6246a05c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKKT5K4tkNdBkO7MQSVMndxWFNoW7eNCQqnbqasGdu+ozriXk0JvU+s8RspSwob9kBrVHmbeWv960RV3zSzAz3+dzEP7SV1jT6EXTNtyxTuBrtrhHzaKLCQS/n2FP38Os+raKh/wEiyCA01SVi8OojGXl5YdAqL2wenjjyoF3gjyFxH5d5HWsATma0rl1CJCLKZOgAW8XFNAS/LpPHzqkirvqtLWjQT/csGPs09WXlQEaBVf2Ar7czZ4YKxk3xakMUN0vToLNjJHAHqdk/K9rAvEh9/HFplyPdA7xZEKmqzgEC+UR80B3FPnuB9hXiNuEz96I6dtFDkkiddh0x34tXwcgHDf5ojmAKj4PYp8N9TyAdKezpcap1lU+moFHCcCgjPA1r5SC/VKjpo6NXyxjE/S2MzBCL9xlmgu7B44vupaXmL4FLgLr2Y3yeh+55Xwqr3dzpOD+ju8Fz29T5UovtH0l7jpZKRzjStW0BlnWY+vXw54rz2h7JXKmOUA9cRxJqkIw8Ct4GiUkwUparmslrua//ijbl6Oqvar43b2FkSZ1u0n6rHS7OVYaoYdmAFfe/nvi9ze83fqJ+q0amzhK9P7vYfSzPr1S+3WDu6ceWlfmxKHyAcQt89W96o8NcDt17cGzWDsTpSQXRiLdJXpcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(83380400001)(122000001)(4326008)(85182001)(36756003)(41300700001)(38070700005)(38100700002)(316002)(6486002)(53546011)(71200400001)(26005)(6916009)(64756008)(66446008)(66476007)(66946007)(66556008)(6512007)(6506007)(76116006)(91956017)(7416002)(2906002)(8676002)(8936002)(5660300002)(54906003)(2616005)(478600001)(86362001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUpFeDM4YVMreEtrYUZXMHpvbFo2Y2Fsd3k1RWprNjJrb2F1NXlhVWZrMm0w?=
 =?utf-8?B?M3A0bzBXcW5LMWJXUDFHcmxxZmY5NjhNekprUjhzWFFQRzRnUVhkei95YWor?=
 =?utf-8?B?UElSVyt2RWFMR2hGQ2RtY0lYUnV3U05oanBvZ3E5dk4xK3dKVjJacGg2dDhC?=
 =?utf-8?B?bXZRbjA5K0p1aWhzM0tjeFFPcmdmVEFidG1xMUtwemc1NnBJQ3RDS05tL0sw?=
 =?utf-8?B?S0pVRFlQdzhoRGlqdUhPWWJOU2VKekFRWThTNEdRYXc2WEZTd1BkOVNnUitV?=
 =?utf-8?B?T0xxZHUweW9OWjc3VFREYktCbndIT3AwUnhaQWo3QU9vWWpGMXBLUHhUbnQy?=
 =?utf-8?B?WXNVSUxjQlp1NVIwSVAwTVZuekIrZnpnbUdrTzNzVTVNd2o4MVAycU1NVTky?=
 =?utf-8?B?c09ObXlzbXh3MWhXMjE0TVNQOHc4YkcrWDdONG1nRHljQUYwWmIwekZPQkFp?=
 =?utf-8?B?NzM3dmpTL2RtQjlYMWorMEZOeGg5dWtITS9yWEVqdTM2L2M3cEV6Ykx2amtZ?=
 =?utf-8?B?MmpXNVBDWUlPaW5mSWVYblZINzN5R2dTVit4SE1lQjdSMklxNU5zNHdkYU9h?=
 =?utf-8?B?eVM3S2VwR0VDK0FwYlhVd3FramJsZkpzbFQrYjRnMnpZWGhXZmV5K0RaVmVD?=
 =?utf-8?B?ZjZZTTBiN0Q2Vzl2L3N3Qkk2VGJ4RDI1VlRjQXR6MmExU2w1dmVFU2xWY241?=
 =?utf-8?B?VlpGdmRybzZ5ZS9RNnc1R05LZ3hQUnFWSkluNkM3dVVSR0lrc1ZLdDM4QjMw?=
 =?utf-8?B?NnNINTNEY0RrNlJjelVmVC9iM2pPbk42TTdJTVdlYVNOOEU0ZXZYRTRma2g4?=
 =?utf-8?B?K1NNL3BBbHZzNE9EMm5TZjYyMEhyRVdsaGY2Y2U0YTQ5NVhvN29yRnVxTHhZ?=
 =?utf-8?B?LzZZYVhtR3BSYTNmWklMaGZ6a0N5eTJHRktVOXZJeW9vdmlwbEM2dWN4cGdu?=
 =?utf-8?B?OWQyOTVTelZYbmo2bnJ4REdWVm1kRjZxK3orcDhLcDlaMlZPVlgxSndjbUVD?=
 =?utf-8?B?Ti9MaDljT3dTMy9CaVhCL0kyT0RqVFIweXhYVWFDYncvM21QYi84ZkNhSzJp?=
 =?utf-8?B?STZLR1hqMTFOUTVkUGswLzBXWkZTcUFZVGJQRWgvOUM1djdQZEVnbEpVNTRj?=
 =?utf-8?B?cTBPNHZxT1kxR3JiSXFuczJuZnpwV2poaEJGVlBEWU9PVWhhN05hUGlXS2ZN?=
 =?utf-8?B?ODhTMGdERk1tSzN0UjdtVEprd1FoTDhFUDYxT240SUxsOTc0dTQ3YTlabDdI?=
 =?utf-8?B?Y2J1R1ZOT0ZJaXpxWmRhcWJBenhlRmY5SnZWZkdqNmxqRGJMRS9TZXNPdFI3?=
 =?utf-8?B?cUMwaFkyK2tlN09lUU5ydW9OOEJNdlVRdTExbjBWYTNtaDNHeENxZmJFcEtK?=
 =?utf-8?B?TWFEWEZZWEI2b0sySzl5bnhEbWh4Qzgzdm1lWXZsWC9teEdKZmwxZmg5OC82?=
 =?utf-8?B?SmpuUS8xNkkwVS9lSTZvT2MzZ0lKQWN4bGprdnMvd0pteFYvVXZxaTkwWUxq?=
 =?utf-8?B?V2pSL1UzdG4zME1yOTlyWCt4SUVpZWZYSTVDVXBPVkhobUNLNDNxUEpRZmdO?=
 =?utf-8?B?bmxPODEvSFhaaG9NOVdqUnZtRUk3MzY0emVBRE1odTdMVDMzYk00SkR5blNn?=
 =?utf-8?B?Ulh1L2tLbEpMMVBEK2hpZDZyYVBVcjVmUjhQdkZiVWVaSG5iaHFLd2hDZ0NI?=
 =?utf-8?B?VEQrTUlzMitUZzV2Q1NtNVpuU3dQT0NzdFgwTEtTaGl5TE1lTG5PdUgvbVpB?=
 =?utf-8?B?ZmdEWW9OeFk1ZTEweVFVSTZNeURxc3lLRE9EcURqeWJRRDR3ai9wWWdLUUF4?=
 =?utf-8?B?TElpSkV3YzRSRGpSZUI3MWxKaFYwLy9kWExBSWdCamxRZXpIWUZ3VmllY2pP?=
 =?utf-8?B?WmhsWW5hcktTMG5VVVkzdVI0NzhPRW5leEc5ZGFhbnUzaGo2NUEwd0szUDJX?=
 =?utf-8?B?bExkbEp0OGVvZVVneWV3VWxWdDRENXdudm81eGtlQU5heFhITFhzeTRtdSs0?=
 =?utf-8?B?ZXcraUtKYmpla0pkWXdLTE5PejlEWmNxalJBTWE1dzJicHcySmpmT0dsTERr?=
 =?utf-8?B?VmNOR3lHUnRlczRqYWdRTVVoRjRiRDd3a2JpdEw3Y3JVdm9qeU8rTjhMYllV?=
 =?utf-8?B?M2dnNThSWmNqMm5HcnYrYXVpS3psRDN5K1dDZTlPV1dJcTlQc083ZWt4cEJv?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12503A31475109489B630DDBEA05A9B9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde6808-e403-435f-211a-08db6246a05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 02:19:28.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxpgI3nwyD8t3qoAd1UeMcw/Qy4e1rXslOcqvvxvxUgNeqiW5oNRt84O0ElVRJIXaq6s5uCKZCYrxiMYDN3w+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7953
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

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDE2OjQ3IC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiANCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhp
LA0KPiANCj4gT24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgMTI6MjXigK9BTSBUcmV2b3IgV3UgPHRy
ZXZvci53dUBtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsuYw0KPiBiL3NvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsuYw0KPiA+IGluZGV4IGJlMWM1M2Jm
NDcyOS4uMDVkNmY5ZDc4ZTEwIDEwMDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9t
dDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsuYw0KPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9t
dDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsuYw0KPiA+IEBAIC0xMzgsNiArMTM4LDI5IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYWZlX2dhdGUNCj4gYXVkX2Nsa3NbQ0xLX0FVRF9OUl9DTEtdID0gew0K
PiA+ICAgICAgICAgR0FURV9BVUQ2KENMS19BVURfR0FTUkMxMSwgImF1ZF9nYXNyYzExIiwgInRv
cF9hc21faCIsIDExKSwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBtdDgxODhfYXVk
c3lzX2Nsa191bnJlZ2lzdGVyKHZvaWQgKmRhdGEpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVj
dCBtdGtfYmFzZV9hZmUgKmFmZSA9IChzdHJ1Y3QgbXRrX2Jhc2VfYWZlICopZGF0YTsNCj4gDQo+
IFRoZSBhYm92ZSBjYXN0IGlzIHVubmVjZXNzYXJ5IHNpbmNlIHRoZSBjb21waWxlciBsZXRzIHlv
dSBhc3NpZ24gZnJvbQ0KPiBhICJ2b2lkICoiIHRvIGFub3RoZXIgcG9pbnRlciB3aXRob3V0IGEg
Y2FzdC4gVW5uZWNlc3NhcnkgY2FzdHMgYXJlDQo+IGNvbnNpZGVyZWQgaGFybWZ1bCBiZWNhdXNl
IHRoZXkgc3VzcGVuZCB0aGUgY29tcGlsZXIncyBhYmlsaXR5IHRvIGRvDQo+IHR5cGUgY2hlY2tp
bmcuIE90aGVyIHRoYW4gdGhhdCwgdGhpcyBsb29rcyBnb29kLiBTb3JyeSBmb3Igbm90DQo+IG5v
dGljaW5nIHRoYXQgdGhlIHNhbWUgcHJvYmxlbSBhZmZlY3RlZCBtb3JlIHRoYW4ganVzdCB0aGUg
ZHJpdmVyIEkNCj4gZml4ZWQgcHJldmlvdXNseS4NCj4gDQo+IFJldmlld2VkLWJ5OiBEb3VnbGFz
IEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQoNCg0KR290IGl0LiBJIHdpbGwgcmVt
b3ZlIHRoZSB1bm5lY2Vzc2FyeSBjYXN0IGluIFYyLiBNb3N0IGltcG9ydGFudGx5LA0KdGhhbmsg
eW91IGZvciBicmluZ2luZyB0aGlzIGlzc3VlIHRvIG91ciBhdHRlbnRpb24uDQoNCg0KVGhhbmtz
LA0KVHJldm9yDQo=
