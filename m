Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767796DC3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDJG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:58:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED81FEF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 23:58:09 -0700 (PDT)
X-UUID: 0a41a72ed76d11eda9a90f0bb45854f4-20230410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xU0HPDD6bPBlcegeZ6eHF4SFaDPacrEpzmsuq2K87YY=;
        b=fX5x24EkIGQUplEYfFVVMSf0PGjsdcv/mq/6gnFZd50LZylgk5GS3OpPMuV3YYlV7Wx0TbbCc3PBXLxJUJNiIocuFtpceoux+UhNn3z0FXTPuSa0fLYn6rTTaloTM/po3sHSHMQ+BsoYFelqjboYHAVu/m8gzmmrxy+DjjUtxdE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:4164cebd-7913-4527-abcb-925bd22641e7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-3
X-CID-INFO: VERSION:1.1.22,REQID:4164cebd-7913-4527-abcb-925bd22641e7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-3
X-CID-META: VersionHash:120426c,CLOUDID:f058d72a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230410145804VQJFQM2L,BulkQuantity:0,Recheck:0,SF:38|100|17|19|101|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 0a41a72ed76d11eda9a90f0bb45854f4-20230410
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 19971999; Mon, 10 Apr 2023 14:58:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 10 Apr 2023 14:58:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 10 Apr 2023 14:58:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8DihcdfgX5xpZc+hHRbSjVHHINVJt83cMKiq8d+G0ThN8v6NU3dN0niFCQPNTd2mluxqeUyLzx0nmTFmOlrkIJIfUDJvxD1lr5Neu6/jN6HYOH531oiCvH1ZvEN3oaw4AJ6dkqunJOPBg/eLQlXiEQ9PR9ARwiu18FATTLp22eOW6DtC1RRDzGTp8O1m+WAsCKQ0f7L1pEGN17jnjPzaNu6IAWxSc7JglrpWef9pINz9JpD83L05fLRxlabKhRveB7AtyftCMXEPisO+iLSDD2e3fRJ2Y+9+6IkP4v9XeSPkPO1TwbR+5mmGlNmURraC5xMgqlBCIQIf6TPDk2Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU0HPDD6bPBlcegeZ6eHF4SFaDPacrEpzmsuq2K87YY=;
 b=QmnSuXRDEDqnvctbJgu7iG+zZROduOTwKAC7Yd0T1UttmyaVC2lJRwGE+cdbS8zhGI9lsW6LNwwalyDlClvy+hPMvxPk11S6njVsaY2FRXqVQCAe7QPGIawxIuye9HOGhm/d/tyyTRAjLX03XMOWiFjodVrolbgR06Gb3tVfM785WnDq7YvCzdyijncHc2ZyacHDOvzQyUVZYWMRgAesFg9xCJE7OTEhFdmuETtuhcDNKXOspB5+pwMl/q/Ev+7kqb3haF6f3UZyF17ZbAi1yzzCrMdX+iSklxQzHpRJKBK4y6EC0bS0QaQGDIfu1OQWp6S/6d1uX3rr06fBRLIXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU0HPDD6bPBlcegeZ6eHF4SFaDPacrEpzmsuq2K87YY=;
 b=r4cWDzvlKG7qUsQJG7Bf55hnjRq4j+jH2LV5By0Wu8u13C40UyS+01bqiNU71gltbfS4nJD560D7qaCfzJY08e0g0KD7GS3byxgUCLJ+QEOkvpZh8qM4kb+y/AFNJytLWdcy+lBMXnllZuk7imt91zXDHD8SWx9lQtGW1A8cQiY=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TYZPR03MB5231.apcprd03.prod.outlook.com (2603:1096:400:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 06:58:01 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::3ce5:3d95:f74a:7147]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::3ce5:3d95:f74a:7147%7]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 06:58:00 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Thread-Topic: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Thread-Index: AQHZQMKjTTrX4iRFGEiishyu2dRyl67P9KSAgAAJ64CAAANcgIAAFSCAgAFIjgCAABD2AIAAA7SAgEAYA4CAEuXGgA==
Date:   Mon, 10 Apr 2023 06:58:00 +0000
Message-ID: <8fe596ac0bb77907ffdee70a52d8399eac2c474c.camel@mediatek.com>
References: <20230214105412.5856-1-walter.chang@mediatek.com>
         <20230214105412.5856-5-walter.chang@mediatek.com>
         <20230214222021.k3tsfwezhnh7tdlx@bogus>
         <996b4e61-8486-d939-7367-1240b3c5c5fa@collabora.com>
         <20230215131849.mcgz53jf24atialp@bogus>
         <53f0e612-b5cc-262e-df98-add1e8a06573@collabora.com>
         <20230215144627.ddjc7x365qdnhymi@bogus>
         <7ac030be-8b5e-d190-6676-8cea9cdc1915@collabora.com>
         <96d6f405-22bc-f112-2c88-76da280eed46@gmail.com>
         <26c100f2-bf31-7212-5d13-25b6b14b8f61@collabora.com>
         <32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com>
In-Reply-To: <32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TYZPR03MB5231:EE_
x-ms-office365-filtering-correlation-id: 98912807-b7c9-4b57-e0bb-08db3990ec4f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1lkMZrJJ4/nBzals831ndL/2svi26wlSC1oh7KaTLCMj5gMzVbafQSHdThWdUQEaZ+DXOJLQ4aYm9ZMOg3VJpkc6PzU0Pn2yGiRcRpJArXby4e5jZ25aORjg02vXOCyD+FMMCiXBLu0L3C2YvKiSqjL2obzCtNfYWXewhtUgSW9IZLgsFzXbinm1FudM+1mztYBYY4oEDlt7QakMpqf07bqTHl7hlcXOQSG9EMiOgx3pBmnYSR04U57kVrcm51GCccKarGfdzLOoiBDnKyx2EieJPQrpo2ru/PYYj2jgrq7Qvgm6/gGu3IdJiAMTBGtac79bO6V5ziZorPzzK9M2wZ/rY8Bg56SbQrtqLBvn9W9YS4RB0hyaSSz6n4AJC3bvudHTye3vcQqbA1NOBOWStSzFSKFmUpTkmEZGtyZrvMY+ULzE87GKGOH18jWwbAsaayYUGNt5N9dofVcUUcri9HMfowvR7oehrLOG1xgaJDF7FcyCP/3EP9MsOi6EuPzbhCfuHifpKMP5cePVM+saLoJTfBtl/M1pm39lZtdhOU6+jNpZp00LVEeuj+dBiMoSkLE1q00GHLQDmr9utqxAroYHErnHQ90VutCQ6wUXbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(86362001)(85182001)(36756003)(91956017)(110136005)(316002)(76116006)(41300700001)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(66946007)(966005)(6486002)(54906003)(478600001)(71200400001)(5660300002)(7416002)(8936002)(2906002)(38100700002)(186003)(122000001)(38070700005)(107886003)(6512007)(6506007)(26005)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUJvaTE1R3RlRzB4UjJabC9YeEk3Mm9Uc1ZkMXhaN3d6RkdmMHpsaS9PM0Zn?=
 =?utf-8?B?dXJwWFRScEFWTmM1QVlFWTBuYzhxSDNvTzdCU08zeHl2ZTR5RWtnKzFjN3d5?=
 =?utf-8?B?N09GR3pzTkd2ZnFjWXJvUW9rcStOcHlROFc4VVR4empqblNhT3FobC9JL3Nq?=
 =?utf-8?B?ak9UclMyMmhYeUNyMVBwQllxK0U4d0RYakNQcWF5eUN2RW5aU1VXaFpmU0lF?=
 =?utf-8?B?TWozVWxiR0pRS3AwSTNHb204NnBuSmhwOW01M3NKOFN4VG1rQUpsNGlHdGVw?=
 =?utf-8?B?aENCRHp0K3ZYeWJITDYraGhhMmIwcUhERGo4SlNkL3hiQWhJclQ4R3JmcFhW?=
 =?utf-8?B?enVpN2VpM08xZFlkMWRHRFBEVnIrTjc5T1RzSVVKdVUrTDByT3NkYUVBekpJ?=
 =?utf-8?B?QkhhckU3MDhxeFZsVVYrdllMNWVqZDdnaXp6QmFjNFRQUnBxSFBEK0Y0QW5V?=
 =?utf-8?B?dFFtZFZDZDl6bktZc21mUEdTNXBZU1AvL0pPK1lNME1LOUtEeHBCbmV5Qldv?=
 =?utf-8?B?Wnl1UHQrTDkxM1p3S01sT2VRZlExMFdTUUg4a2MzYjFNazJORmo3V0VINVk1?=
 =?utf-8?B?M21qQXRDV2I4aERPN0dBWGJoci8xekRTUE1IOTdRUkFoazJlbGk4M01SbUVU?=
 =?utf-8?B?eCttWVhsUWF2VG5ENGhsUVFtaHdoc28xYmxlV2xQMHlUS09GVm9ZWG0rTmFM?=
 =?utf-8?B?Q21JdDBEU0oyMFFkSFNPTHZHOGtWT09hUHNoeklLSFRVaUJPODF1NVgwWlhC?=
 =?utf-8?B?eTBDdXpaSW5PY0Zmei9paU5BWmp6R0MxTm5TSmF0Sy9MTnB3TFVQTzV5QkZ2?=
 =?utf-8?B?RjJiK0lkM0ljL3BIWkRjbWVzSmJ5L1ZncE42dVNxKzZ1WGVmMDlwRlZuOHBs?=
 =?utf-8?B?VUwxUUcvZ0NwaGFPejJoSFBlYTVxaUpKTEVlQ0JuSGh5YTNXcVhURkZibVdH?=
 =?utf-8?B?dERnUTBVTXpVenJWbmV5UUNsQlFoQmFEVUE0ZEg3M3QvNktTUE9yT0czVDJp?=
 =?utf-8?B?cXFQaEZ3L2FrY1ZWNkFHMDJyOEZ0T1U4dUFvcTBMOUlJeFAzM0V1R2Fmajkv?=
 =?utf-8?B?SjlBTURqZlFRMVNuWUhsVlZWL2tpNHlmdUhiRDE0dHZKZ1ZjOU9LQnl1d1I5?=
 =?utf-8?B?Uk4wTVFXbEVJTUkycGFSdlRQNkt0TGE1VUF6Z1RFN0h4Uk9BQWJwWU5aY3I3?=
 =?utf-8?B?Q0RlWFUwWnNxaXlNWjl4MjR6N29HdysxeFRvZ3NXLzFMLzVMalp2Qlg0V1ZY?=
 =?utf-8?B?VkhaZFVzbWlCdEdJMlIvUXQvQldsUHg3akFKYWlibytwLzUzaVdtaWlpR3hw?=
 =?utf-8?B?TWo2bWh6dlFRZGZSZDkyeXhkajhrRDZQQjVzZ0l0bTE4UE9QY1BnSDNJUG0z?=
 =?utf-8?B?TTFLeVJFV3l3aXRtZUt2VVJGWUFSQWN3VmRVVUNZT0pzUklhK2t3MXNaQm5l?=
 =?utf-8?B?b2Y2ZEJQdElleURKRFAxdjVFeW03T0cwT3pQQkdSVzdCMU1HYkdlMHNKanhZ?=
 =?utf-8?B?WjRYRFpDdzNxbnhlN1NiSUVNU1RRRjlwOVlXQW1Zc1M3ZWM1VGdGamZrMC9j?=
 =?utf-8?B?L0JkUUxyN0RxYzN6Nkkyb2o0eTBFQStNalJvRlBxd2ZDcTRjV0hxTDVjK01r?=
 =?utf-8?B?Wmh0R2JqOHcySFE0OUZ1Y1BHdW5yM29XY1hhTzNSVm84TGVZQlZHWElqR2lZ?=
 =?utf-8?B?UVhVaTJldVRROUs2akVpZWtUb09zQTNINHJwZ0Z6WUxtUTNiVCtKY1hNc3VL?=
 =?utf-8?B?cTJKb2pIcW1FT01ROGpOOG9PM3kyNFFsbVAzUlB5b1I4TkUzSXR2T1JHSGVM?=
 =?utf-8?B?K3diTUVtT2RjYzlUd0VpSmhScjAybnh1V3VLVWQ4YndkMjNOYm55NXNFd3lI?=
 =?utf-8?B?Ukg1VnZsbkFQMHdWNXlYQ2FWeVNPRWhTcHJjYzZFWnRUa2VLM3NxVElWQXVk?=
 =?utf-8?B?L1lFVXRudjZTeGd0cDFEZjR1aDBiei8ycnBoWjJ1bDg2UCtYWXk5OGJqWWY5?=
 =?utf-8?B?aWlTczFmTXdEQ04ydVQxSjl2cmRFM2dYOUlFLzlKOVYydC9TUjF0bzhLT3V5?=
 =?utf-8?B?L1NyekJhZWxnKzlIUVp6T2RCY0JIMU9iUm1oMzN4QStvTEVuQkc5aEpnYWsz?=
 =?utf-8?B?UzhsWFE1SWdIRENZaGwxQWdyVDFvYXJvTWNGM1ZBQ0FoMDRDemwvc1VmbEVQ?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <154A6C0DB7D175478DE54C3BEADFCF0D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98912807-b7c9-4b57-e0bb-08db3990ec4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 06:58:00.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEoICzyZaRz+XD8TtkW5VZDMo23CDqgRXIQz83BCr5Kdtmant7z+HXP8vRzSoj/i6Gin3va63Np1xfot5gYyLmgj7hNm5LFj5G1vdRIQ/uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5231
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDE0OjIyICswODAwLCBXYWx0ZXIuQ2hhbmcgd3JvdGU6DQo+
IEZpcnN0LCBJJ2QgbGlrZSB0byB0aGFuayBBbmdlbG8gZm9yIGFzc2lzdGluZyB1cyBpbiBzcGxp
dGluZyBvdXQgdGhlDQo+IENQVVggZHJpdmVyIFsxXSwgYWxsb3dpbmcgdGhpcyBkcml2ZXIgdG8g
YmVjb21lIGEgbW9kdWxlIHRoYXQgY2FuIGJlDQo+IGxvYWRlZCB3aGVuIG5lZWRlZC4NCj4gDQo+
IEluIHJlc3BvbnNlIHRvIE1hdHRoaWFzJ3MgY29uY2VybiBhYm91dCB3aGV0aGVyIFNZU1QvR1BU
IG9uIHRoZSBvbGQNCj4gTWVkaWFUZWsgcGxhdGZvcm1zIGNhbiBib290IHByb3Blcmx5IHdpdGgg
dGhlIGxvYWRhYmxlIG1vZHVsZSwgSQ0KPiByZWNlbnRseSBjb25kdWN0ZWQgYSBmZXcgdGVzdHMg
YW5kIGZvdW5kIHRoYXQgYm90aCBoYXJkd2FyZXMgYXJlDQo+IGNhcGFibGUgb2YgYm9vdGluZyBu
b3JtYWxseSB3aXRoIHRoaXMgbG9hZGFibGUgbW9kdWxlLg0KPiANCj4gRm9yIG15IGV4cGVyaW1l
bnRzLCBJIHVzZWQgTVQ2NzY4IHdpdGggdGhpcyBwYXRjaDoNCj4gDQo+IDEuIFdoZW4gdGhlIG1v
ZHVsZSB3YXMgbm90IGxvYWRlZCBvciBsb2FkIHRoZSBtb2R1bGUgYnV0IHRoZQ0KPiBjb3JyZXNw
b25kaW5nIGNvbXBhdGlibGUgcHJvcGVydHkgd2FzIG5vdCBzcGVjaWZpZWQgaW4gdGhlIGR0cywg
dGhlDQo+IGZvbGxvd2luZyByZXN1bHRzIHdlcmUgb2J0YWluZWQ6DQo+IA0KPiAjIGNhdCAvcHJv
Yy90aW1lcl9saXN0IHwgZ3JlcCAiQnJvYWRjYXN0IGRldmljZSIgLUEgMTUNCj4gQnJvYWRjYXN0
IGRldmljZQ0KPiBDbG9jayBFdmVudCBEZXZpY2U6IGJjX2hydGltZXINCj4gIG1heF9kZWx0YV9u
czogICA5MjIzMzcyMDM2ODU0Nzc1ODA3DQo+ICBtaW5fZGVsdGFfbnM6ICAgMQ0KPiAgbXVsdDog
ICAgICAgICAgIDENCj4gIHNoaWZ0OiAgICAgICAgICAwDQo+ICBtb2RlOiAgICAgICAgICAgMw0K
PiAgbmV4dF9ldmVudDogICAgIDQ5MDIwNDAwMDAwMCBuc2Vjcw0KPiAgc2V0X25leHRfZXZlbnQ6
IDwwMDAwMDAwMDAwMDAwMDAwPg0KPiAgc2h1dGRvd246IGJjX3NodXRkb3duLmNmaV9qdA0KPiAg
ZXZlbnRfaGFuZGxlcjogIHRpY2tfaGFuZGxlX29uZXNob3RfYnJvYWRjYXN0LmNmaV9qdA0KPiAg
cmV0cmllczogICAgICAgIDANCj4gDQo+IHRpY2tfYnJvYWRjYXN0X21hc2s6IGZmDQo+IHRpY2tf
YnJvYWRjYXN0X29uZXNob3RfbWFzazogN2UNCj4gDQo+IFRoZSBidWlsdC1pbiBgYmNfaHJ0aW1l
cmAgd2FzIHVzZWQgYXMgdGhlIGJyb2FkY2FzdCBkZXZpY2UsIHdoZXJlYnkNCj4gb25lDQo+IENQ
VSB3YXMga2VwdCBhd2FrZSB0byB3YWtlIHVwIHRoZSBvdGhlciBDUFVzLiBBcyBhIHJlc3VsdCwg
b25lIENQVQ0KPiBjb3VsZCBub3QgZW50ZXIgdGhlIGlkbGUgc3RhdGUuDQo+IA0KPiAyLiBXaGVu
IHRoZSBtb2R1bGUgd2FzIGxvYWRlZCBhbmQgdGhlIEdQVCBjb21wYXRpYmxlIHByb3BlcnR5IHdh
cw0KPiBzcGVjaWZpZWQgaW4gdGhlIGR0czoNCj4gDQo+ICMgY2F0IC9wcm9jL3RpbWVyX2xpc3Qg
fCBncmVwICJCcm9hZGNhc3QgZGV2aWNlIiAtQSAxNw0KPiBCcm9hZGNhc3QgZGV2aWNlDQo+IENs
b2NrIEV2ZW50IERldmljZTogbXRrLWNsa2V2dA0KPiAgbWF4X2RlbHRhX25zOiAgIDMzMDM4MjEw
NDYzNA0KPiAgbWluX2RlbHRhX25zOiAgIDEwMDANCj4gIG11bHQ6ICAgICAgICAgICAyNzkxNzI4
Nw0KPiAgc2hpZnQ6ICAgICAgICAgIDMxDQo+ICBtb2RlOiAgICAgICAgICAgMw0KPiAgbmV4dF9l
dmVudDogICAgIDE0ODMyMjEwMTY0NjIgbnNlY3MNCj4gIHNldF9uZXh0X2V2ZW50OiBtdGtfZ3B0
X2Nsa2V2dF9uZXh0X2V2ZW50LmNmaV9qdA0KPiAgc2h1dGRvd246IG10a19ncHRfY2xrZXZ0X3No
dXRkb3duLmNmaV9qdA0KPiAgcGVyaW9kaWM6IG10a19ncHRfY2xrZXZ0X3NldF9wZXJpb2RpYy5j
ZmlfanQNCj4gIG9uZXNob3Q6ICBtdGtfZ3B0X2Nsa2V2dF9zaHV0ZG93bi5jZmlfanQNCj4gIHJl
c3VtZTogICBtdGtfZ3B0X2Nsa2V2dF9zaHV0ZG93bi5jZmlfanQNCj4gIGV2ZW50X2hhbmRsZXI6
ICB0aWNrX2hhbmRsZV9vbmVzaG90X2Jyb2FkY2FzdC5jZmlfanQNCj4gIHJldHJpZXM6ICAgICAg
ICAxNw0KPiANCj4gdGlja19icm9hZGNhc3RfbWFzazogZmYNCj4gdGlja19icm9hZGNhc3Rfb25l
c2hvdF9tYXNrOiBiZg0KPiANCj4gMy4gV2hlbiB0aGUgbW9kdWxlIHdhcyBsb2FkZWQgYW5kIHRo
ZSBTWVNUIGNvbXBhdGlibGUgcHJvcGVydHkgd2FzDQo+IHNwZWNpZmllZCBpbiB0aGUgZHRzOg0K
PiANCj4gIyBjYXQgL3Byb2MvdGltZXJfbGlzdCB8IGdyZXAgIkJyb2FkY2FzdCBkZXZpY2UiIC1B
IDE3DQo+IEJyb2FkY2FzdCBkZXZpY2UNCj4gQ2xvY2sgRXZlbnQgRGV2aWNlOiBtdGstY2xrZXZ0
DQo+ICBtYXhfZGVsdGFfbnM6ICAgMzMwMzgyMTA0NjM0DQo+ICBtaW5fZGVsdGFfbnM6ICAgMTAw
MA0KPiAgbXVsdDogICAgICAgICAgIDI3OTE3Mjg3DQo+ICBzaGlmdDogICAgICAgICAgMzENCj4g
IG1vZGU6ICAgICAgICAgICAzDQo+ICBuZXh0X2V2ZW50OiAgICAgMTMyMjUyMDAwMDAwIG5zZWNz
DQo+ICBzZXRfbmV4dF9ldmVudDogbXRrX3N5c3RfY2xrZXZ0X25leHRfZXZlbnQuY2ZpX2p0DQo+
ICBzaHV0ZG93bjogbXRrX3N5c3RfY2xrZXZ0X3NodXRkb3duLmNmaV9qdA0KPiAgb25lc2hvdDog
IG10a19zeXN0X2Nsa2V2dF9vbmVzaG90LmNmaV9qdA0KPiAgcmVzdW1lOiAgIG10a19zeXN0X2Ns
a2V2dF9yZXN1bWUuY2ZpX2p0DQo+ICBldmVudF9oYW5kbGVyOiAgdGlja19oYW5kbGVfb25lc2hv
dF9icm9hZGNhc3QuY2ZpX2p0DQo+ICByZXRyaWVzOiAgICAgICAgOA0KPiANCj4gdGlja19icm9h
ZGNhc3RfbWFzazogZmYNCj4gdGlja19icm9hZGNhc3Rfb25lc2hvdF9tYXNrOiAzZg0KPiANCj4g
VGhlc2UgdHdvIGV4cGVyaW1lbnRzIHNob3cgdGhhdCBTWVNUL0dQVCBvbiB0aGUgb2xkIE1lZGlh
VGVrDQo+IHBsYXRmb3Jtcw0KPiBjYW4gYWxzbyB3b3JrIHByb3Blcmx5IHdpdGggdGhlIGxvYWRh
YmxlIG1vZHVsZSwgYW5kIHdpbGwgbm90IGNhdXNlDQo+IGFueQ0KPiBib290aW5nIGlzc3Vlcy4g
VGhlcmVmb3JlLCBtYWtpbmcgdGltZXItbWVkaWF0ZWsuYyBkcml2ZXIgaW50byBhDQo+IGxvYWRh
YmxlIG1vZHVsZSBpcyBmZWFzaWJsZS4NCj4gDQo+IFRoYW5rcywNCj4gV2FsdGVyIENoYW5nDQo+
IA0KPiBbMV0gDQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDMwOTEwMzkx
My4xMTY3NzUtMS1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20vDQoNCkdl
bnRsZSBwaW5nLg0KDQpUaGFua3MsDQpXYWx0ZXIgQ2hhbmcNCg0K
