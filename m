Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD226E8793
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDTBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDTBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:46:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807230EA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:46:50 -0700 (PDT)
X-UUID: 33a89cb4df1d11eda9a90f0bb45854f4-20230420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IAkJQOg1g1FgevimIlSoGvBODyfGf+E5Kw6i9r5jsVY=;
        b=W1KRsSV50Ta0+12U6G4Gg9eL/eKFPQi1ZUXmKjyXeJaHZXN280yszp9VOmV4X8iWnW21vmVKLJOa158ikWyMeufU2yQZYF8J8Q9l5hpyWnA0BV16YKczQyfkfIP8ouCJIPjU/Baa53gWLLMpavZ8AhWTWs3J7nn0XwoiiOxmLeU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:641e0805-e170-4c3b-a1d3-b0a2ab001b6c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:7d96e8a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 33a89cb4df1d11eda9a90f0bb45854f4-20230420
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 858909778; Thu, 20 Apr 2023 09:46:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 20 Apr 2023 09:46:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 20 Apr 2023 09:46:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkMXbyviTmdOqJBsyF9VFWsWXslMmDBh6DBYXEzeuZC8Ws2lU0OTeYOLfU0tONBJqKEGMoIcLZOXsl50CDT4vaPInyYpDDWm8lU7qniDvQEefTHRh5RPlqFPooV8n3LxFdJz3fN9ZCocz7f1N5GJjW8WiNkfKjSMKG6TCR3zUDI35irFvRWh9w05qFuMRhuKvLHHFcQcdjaVeFrUrL1ZFNkNy+8rSlFLrV+Dait58JGPtIDnNc97YwO3x2J8/WO5xo4HxudbUHLw5u0/IiB+UWDFzYMe/oo2dczFZ00TuCwQyfKVMaHfOQJOlI1PkgsteT9a4WYjAJtnWJ3jNTFObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAkJQOg1g1FgevimIlSoGvBODyfGf+E5Kw6i9r5jsVY=;
 b=n33w1D0rlWi3w0anGPHikAuNfB9yYIdthacZGtw1DMO/XnY+ywaq2k3e0Jby1mZwaKpC/rnIHfGoDHmIh+FYa7fpQDsQ1CL2VTNvQaMOiMTjBi9WeWjzSuV/sMOx6aglTuSwOpDvL2Vf/U+qYp2ekSbOLocKVna8DL2l0B7H3armvx35bjiFH7uLX9asx6mL/tpeNM5BGYitFWaRaHcCJacx5EW1FYAXkPq6NW02xXBV9EDvk5MhJkpzpkYfnbG4akypi/TlI98iAOjsXgk/cXtG1yjv8SxPdBP6zC9FMWVvZGPlHm4OqxO/M4NamIGs9Tc1HTtzcz5BsDDMxbDsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAkJQOg1g1FgevimIlSoGvBODyfGf+E5Kw6i9r5jsVY=;
 b=UPbJ2FuoiPDOQJ+n+hbnDDqtcriLxwJkJ7rUNHOhyVI6uoZhc2vvIUW2QGVecOOEVSvT93zfgzB0oQCQQyjBbjVdX8Y2E5QpJaj98cwJUUQNepsh7YItF5Knht05Ba4lzRYIcsApUPFzMrCe1BESp3wnjw3AHrcSsRQb0HBsN9s=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TY0PR03MB6425.apcprd03.prod.outlook.com (2603:1096:400:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 01:46:39 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::b97c:7cc1:bd9e:ac18]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::b97c:7cc1:bd9e:ac18%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 01:46:39 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH linux-next v3 4/4] clocksource/drivers/timer-mediatek:
 Make timer-mediatek become loadable module
Thread-Topic: [PATCH linux-next v3 4/4] clocksource/drivers/timer-mediatek:
 Make timer-mediatek become loadable module
Thread-Index: AQHZcpOipD3xPe2aZUKyaNd+EzYpxq8yR8oAgAEm8wA=
Date:   Thu, 20 Apr 2023 01:46:39 +0000
Message-ID: <785234397f8943cc1f2125027b7b61835d301da3.camel@mediatek.com>
References: <20230419074910.10809-1-walter.chang@mediatek.com>
         <20230419074910.10809-5-walter.chang@mediatek.com>
         <3dac0be8-6a49-43db-da65-e99d2e9719e6@collabora.com>
In-Reply-To: <3dac0be8-6a49-43db-da65-e99d2e9719e6@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TY0PR03MB6425:EE_
x-ms-office365-filtering-correlation-id: f8345bdd-3d3b-4c7b-9783-08db41411591
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbaLSdpZHKVVO/08L4KGcILJbI4xRfLQXGssj93hwL+T3dbCATsXihWg5bWRuqlfpow6Zqta3U9AjOYO/NccRqKosk3L3z15Yn+TVo28h9N4kvDB9r7FKfLncei/9Tno4Uqbhtgs0k8D2VCHMZdrFgYyI507HV93MdukXyNncGOPXZnmQVPkawplBieS/CgJG7iB3ftvcy2rzlpvlnF+aN/0wOPawdqfB6hgiYidvWz5PTveHHe5ttPRoIa2tacgUGKKdeZoD9N1+UHCCGEoOK3e0cySTkzzdTz2Pn9CXAMAoULGMc71WxF3AqCghKTi/NnCZ1ILUNjhKo+CMnyRfSjZCfOUPJ2fC7kqLdVfwRzZx74/nctGagqYKlcrmgmb67qQb/zhMGUW8w08rJJhZJK/Aj6SjNB47NJJ+lIeluGnzkP8wH40u8v3EJrGYulySLD8EMF7Xnvg0HU4Tv8xgd1mtPAWcQOGt4CA2xsDKC2kVSGNoloGdPL8uRfgD8mUFz1JVLcYyQDaCKNkqssGGp9ibvz4AIMXS138O58t9nvXoV4LI5CSsYoANm88cgkmA4tizNEeqyrIX1XurzVeuc+ELlY58DNikW0su4X8vqk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(85182001)(36756003)(2906002)(38070700005)(8936002)(38100700002)(8676002)(5660300002)(86362001)(6486002)(71200400001)(966005)(107886003)(6512007)(6506007)(26005)(110136005)(54906003)(478600001)(2616005)(83380400001)(186003)(76116006)(91956017)(316002)(66556008)(64756008)(66476007)(66446008)(4326008)(66946007)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MStJSnJkS2VtSVIxekVoWXNGWHZ1YVBYRmMrUSt1UFRLbGJKNnlsblpvdjdV?=
 =?utf-8?B?TjAzdmlSYnFaYy9HMXkrdDZoOTM2aEdLZy9ocStKK2ZnOEVPcjhiNkkxUjRs?=
 =?utf-8?B?YnZkalBPMmVJek1NMk1xRDRZeEYvOHlZNUVSNFo5OUJWK01IeEJ2NWZ6NVY4?=
 =?utf-8?B?RWV4d2txd3NvbjkrbTVqc2M4SjloVFgzT0lob3VhalVkRWlKYngvM1UvU2xp?=
 =?utf-8?B?VlpNS1ViUUw1Wmo4aHhHSVlhblV4bXVOWjZ0RmF2emUrVVJXZVVjOG5IRzVP?=
 =?utf-8?B?eHl1SGZMUFl4RVNVaUdYNDczVVJNdXlOMWdrOEoxeUlJNWRhQ3FtQzlsQmpM?=
 =?utf-8?B?bFZzV1pTS1BzM1FlRWZYL2hoUTRjQTVzZ2RmTWpNeG1YM0RzUHpZaHJqUjRl?=
 =?utf-8?B?N1M0M0EzWWkwN0JZK2tXVWdDN01Gam5XMXBvS3ZRT0xyTnloY2pUU0pELzZE?=
 =?utf-8?B?a1FLbUxlWXh5aTFRWUQrcWtydnF0RjJLdGpuQjltcVhtMGR4QmNCU2hYTTJJ?=
 =?utf-8?B?NEFXWFNlSXRyTEd6ODJ1N1UycWw1Q29rOWFEYUQ2MWZlTUJzbndyK0dRNEVP?=
 =?utf-8?B?T3pBc0s2Q0E4MnJQdm5heVpuUk9BbzRVakJkYWF2Z1N2LzZ2L2szNzVoMHEx?=
 =?utf-8?B?emZabzRsSmlJODdiNTY2cGlkTHNkVVVtQlpzRkpnY0dZODllcm9FWTg2SlRZ?=
 =?utf-8?B?ZkFUbkNPR3BMSEdDQWgya2lqTXZ5QU1aankyUXpEdDBxUnN6UnByQ25KdTVj?=
 =?utf-8?B?RFJ5TjRYQkdGKzFVWmlDMDc3TE5rMkhvT3pjRm56ZDdPcGV0WG1zbHlXbnhU?=
 =?utf-8?B?MDNqdkJPRzBZUWM5RnVYYi9rSGM5TlJYVk1obFRKWjU4bmRQbys3cGdwWC9m?=
 =?utf-8?B?U2gvUHZleW95dXQ2RUZhZXl0dVZTdGhWU3RoZE4wc2k5dkZSMkEvRlh1ZWp6?=
 =?utf-8?B?Tk04R0xvL2hBRndpMElzS0tLbzQyMmdtc1RnZzZTeEZHdEZXL2N0UitWaVI5?=
 =?utf-8?B?aHp2YTlxTEsxSFRkdytMQXUwVUNBZmRwNVROdkpzM2hjdk1EZGlrME9jVGha?=
 =?utf-8?B?bjJsbW8wWm9yZ3pNTkc5MGZsN09RRTVEYUFnUVVkSVF0Vm5zZ1lScUpVa3lO?=
 =?utf-8?B?RkVUbXhOUDcxYjNpd2NicndWSHVTb0wxeFV5NC9pNDhlM3NTSUZNWWI1dVZj?=
 =?utf-8?B?U2Y5NHhHeW9TZjZITC91c1Z0eGdBNEJxWmVZYWdpaDA4VFdMajVtQy9mQ1Iw?=
 =?utf-8?B?WEt0Y25heElMODZ5eTBYZS9YdFRLaTduVFl3NUNLZkRGeGpJb01UamV2TUdZ?=
 =?utf-8?B?bXhRWWlMdE4xVFNMQ1Job01lcU1yYzBpRVAzNWk5dEZJc0kvUTZock5Fa1Ji?=
 =?utf-8?B?ZWRhTi9NK2ZLWDE2R2VmZjN1ZmpqSjFrN0tGaCtIK2FwZXVXSElWbHE4aUJi?=
 =?utf-8?B?aU5UeXpWWDlJTkdTL2FBdW1sSWVTSDNYN1VYaGw4Slo3Z2dVNUhSRzdWdEFC?=
 =?utf-8?B?QlZXcmsxdk1aQjc3dDNaNlNXUUtBUFliSVJ3elViMGJSYzRRMy9TeFhpN0ov?=
 =?utf-8?B?WTY1bEtQUTEzYVNYWDFPYTIrbm5RKzRYTkVIVVZKRk5VemlIaU14VWtVRzNI?=
 =?utf-8?B?azRHRlZHdXQwZDhyaFAyVlZpUW9oRCtlYUp3aE10TWMzemFwaFhvMXc4bktS?=
 =?utf-8?B?dHdCc3VpZkRmVC9MNWJLOW5wMG5yYmpqaDh4SUlnaFNkcmc5QTB2WkhCcDVS?=
 =?utf-8?B?Q0pZdGYwOXVxUzNPUWMwaXZQK3huMytTbjRDZ0hjbHVkdVlsSVJmZ1YvNStr?=
 =?utf-8?B?YjV5Z1JEcXdMcE5YUjVFMTZNS2JXT0ZxbzA5Ry9haDJBbGpIQ0U5ZkU4cGxI?=
 =?utf-8?B?dVJoNDA0SmhjSDgzSmJ4OWpZdld3OFNLUG5yTEcwRnFCYURPTXlvVUtmMDQ0?=
 =?utf-8?B?VUdXNXVXUm8wVVVKSFZEcHRRQzArRlhRWkRWWVdFT3VZUHNxOEtxcE9qMVR2?=
 =?utf-8?B?NkFNbFEwL214YmVocGFySVZyWE40RzJaL0F6YnRPdmhTOEhWdE5lSURnSmRw?=
 =?utf-8?B?WUY1Yk1ETlNoQllISVhvTHBhK3Q4aXdGWndJeHFOTWEwcitXQjFhYWZQSWx6?=
 =?utf-8?B?MStWRlBLMnNodXkvZWR1dWJhZ1RaOUJ3cGdYc3lUS2I4WVhOY2VURWc5YWVW?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A948208407EE54E92DC3616F1AD10E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8345bdd-3d3b-4c7b-9783-08db41411591
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 01:46:39.3507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgdpKzgXlffhMVl+g09X9WU5d/57J2W7OKV+aUx6xGVKtIeDtNndqx4lx9ymEPFAp1Q8vAYzUmvqTggm4D6grLTZL6g6ogrEQ0E7qPyC1OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTE5IGF0IDEwOjEwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxOS8wNC8yMyAwOTo0OSwgd2FsdGVyLmNo
YW5nQG1lZGlhdGVrLmNvbSBoYSBzY3JpdHRvOg0KPiA+IEZyb206IENodW4tSHVuZyBXdSA8Y2h1
bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBNYWtlIHRoZSB0aW1lci1tZWRpYXRl
ayBkcml2ZXIgd2hpY2ggY2FuIHJlZ2lzdGVyDQo+ID4gYW4gYWx3YXlzLW9uIHRpbWVyIGFzIHRp
Y2tfYnJvYWRjYXN0X2RldmljZSBvbg0KPiA+IE1lZGlhVGVrIFNvQ3MgYmVjb21lIGxvYWRhYmxl
IG1vZHVsZSBpbiBHS0kuDQo+ID4gDQo+ID4gVGVzdGVkLWJ5OiBXYWx0ZXIgQ2hhbmcgPHdhbHRl
ci5jaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1IdW5nIFd1IDxj
aHVuLWh1bmcud3VAbWVkaWF0ZWsuY29tPg0KPiANCj4gSSB0aGluayBJIHR5cG9lZCB5b3VyIGVt
YWlsIHdoZW4gc2VuZGluZyB0aGUgZXhhbXBsZSBwYXRjaCBmb3IgdGhlDQo+IGNvbnZlcnNpb24g
dG8gcGxhdGZvcm1fZGV2aWNlLiBDaGVjayBbMV0sIGl0IG1heSBiZSBiZXR0ZXIgdG8ganVzdA0K
PiBpdGVyYXRlIHRocm91Z2ggdGhhdD8gKHBsZWFzZSBpZ25vcmUgdGhlIHB1cmVfaW5pdGNhbGwo
KSBwYXJ0LCB0aGF0J3MNCj4gYSBtaXN0YWtlLCBpdCdzIG5ldmVyIGdvbm5hIGhhcHBlbiBhcyBp
dCBhdXRvbWF0aWNhbGx5IGJlY29tZXMgYQ0KPiBtb2R1bGVfaW5pdCgpIGNhbGwpLg0KPiANCj4g
SXQgZGVwZW5kcyBvbiB3aGF0IG1haW50YWluZXJzIHRoaW5rIGFib3V0IHRoYXQgY2xvY2tzb3Vy
Y2UuaA0KPiBhZGRpdGlvbiwNCj4gdGhlIHBhdGNoIGdvdCB6ZXJvIGNvbW1lbnRzLCBzbyBpZiB5
b3UncmUgaW50ZXJlc3RlZCBpbiB0aGF0IHBlcmhhcHMNCj4gd2UNCj4gY2FuIGV4cGxpY2l0bHkg
YXNrIHdoYXQgd291bGQgYmUgdGhlIGJlc3Qgb3B0aW9uIGJldHdlZW4geW91cnMgYW5kDQo+IG1p
bmU7DQo+IHRoYXQgYWRkaXRpb24gaXMgZG9uZSBvbmx5IHRvIGF2b2lkIHRoZSBiaWcgaWZkZWYg
cGFydHkgdGhhdCB0aGlzDQo+IHBhdGNoDQo+IHByb3Bvc2VzIGFuZCBtYWtlcyB0aGluZ3MgYSBi
aXQgc2hvcnRlciBpZiB0aGlzIHRpbWVyIG1vZHVsYXJpemF0aW9uDQo+IGdvZXMgb24gd2l0aCBt
b3JlIGRyaXZlcnMsIGJ1dCBJIGRvbid0IGhhdmUgc3Ryb25nIG9waW5pb25zIGFueXdheS4NCj4g
DQo+IEluIHRoZSBtZWFud2hpbGUsIGp1c3QgdG8gZXZlbnR1YWxseSBzcGVlZCB1cCBpbnRlZ3Jh
dGluZyB0aGlzLCBvcg0KPiB0aGUNCj4gb3RoZXIgcGF0Y2ggLSBJJ2xsIHN0aWxsIGdpdmUgeW91
IGEgcmV2aWV3IG9mIHRoaXMgb25lLg0KPiANCj4gWzFdOg0KPiANCmh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVk
aWF0ZWsvcGF0Y2gvMjAyMzAzMDkxMzIxMTkuMTc1NjUwLTEtYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWtlbGxJUDlxV1F3WkNVc2JL
OS1zOVdGb3JEYnpfNS1DQUdkTUl6WWJHU1hndlhqVkdueUdtbG1HSGVLRWJYcl9VUlFlS1ZIbmI2
ZUZBaC1mQnNoR0QxS1RFUmgtbXpTQWxRJA0KDQpUaGFuayB5b3UgZm9yIHByb3ZpZGluZyBhbiBh
bHRlcm5hdGl2ZSBpbXBsZW1lbnRhdGlvbiB0byBtYWtlIHRoZSB0aW1lcg0KZHJpdmVyIGxvYWRh
YmxlLiBXZSB3aWxsIHN0dWR5IHdoZXRoZXIgdGhpcyBzb2x1dGlvbiBpcyBmZWFzaWJsZS4NCg0K
PiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyAgICAgICAgICB8
ICAyICstDQo+ID4gICBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMgfCAzOQ0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcNCj4gPiBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2Nv
bmZpZw0KPiA+IGluZGV4IDUyNjM4MmRjNzQ4Mi4uYTc0MTNhZDdiNmFkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tz
b3VyY2UvS2NvbmZpZw0KPiA+IEBAIC00NzIsNyArNDcyLDcgQEAgY29uZmlnIFNZU19TVVBQT1JU
U19TSF9DTVQNCj4gPiAgICAgICBib29sDQo+ID4gDQo+ID4gICBjb25maWcgTVRLX1RJTUVSDQo+
ID4gLSAgICAgYm9vbCAiTWVkaWF0ZWsgdGltZXIgZHJpdmVyIiBpZiBDT01QSUxFX1RFU1QNCj4g
PiArICAgICB0cmlzdGF0ZSAiTWVkaWF0ZWsgdGltZXIgZHJpdmVyIg0KPiANCj4gV2hpbGUgYXQg
aXQsIHlvdSBjb3VsZCBhbHNvIGZpeCB0aGUgdGV4dCwgTWVkaWF0ZWsgLT4gTWVkaWFUZWsNCj4g
DQo+ID4gICAgICAgZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4gPiAgICAgICBzZWxlY3QgVElNRVJf
T0YNCj4gPiAgICAgICBzZWxlY3QgQ0xLU1JDX01NSU8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jDQo+ID4gYi9kcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLW1lZGlhdGVrLmMNCj4gPiBpbmRleCA3YmNiNGEzZjI2ZmIuLjM0NDg4NDg2ODJjMCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMNCj4g
PiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMNCj4gPiBAQCAtMTMs
NiArMTMsOSBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Nsb2Nrc291cmNlLmg+DQo+ID4gICAj
aW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaXJxcmV0
dXJuLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
DQo+ID4gICAjaW5jbHVkZSA8bGludXgvc2NoZWRfY2xvY2suaD4NCj4gPiAgICNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQo+ID4gICAjaW5jbHVkZSAidGltZXItb2YuaCINCj4gPiBAQCAtMzM3LDUg
KzM0MCw0MSBAQCBzdGF0aWMgaW50IF9faW5pdCBtdGtfZ3B0X2luaXQoc3RydWN0DQo+ID4gZGV2
aWNlX25vZGUgKm5vZGUpDQo+ID4gDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4g
Kw0KPiA+ICsjaWZkZWYgTU9EVUxFDQo+IA0KPiAjaWZuZGVmIE1PRFVMRQ0KPiAuLi4gdHdvIGxp
bmVzLi4uDQo+ICNlbHNlDQo+IC4uLiBhIGJ1bmNoIG9mIGxpbmVzIC4uLg0KPiAjZW5kaWYNCj4g
DQo+IGxvb2tzIG1vcmUgcmVhZGFibGUuIEknZCBnbyB3aXRoIHRoYXQuDQo+IA0KPiA+ICtzdGF0
aWMgaW50IG10a190aW1lcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICt7DQo+ID4gKyAgICAgaW50ICgqdGltZXJfaW5pdCkoc3RydWN0IGRldmljZV9ub2RlICpub2Rl
KTsNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7
DQo+ID4gKw0KPiA+ICsgICAgIHRpbWVyX2luaXQgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEo
JnBkZXYtPmRldik7DQo+ID4gKyAgICAgcmV0dXJuIHRpbWVyX2luaXQobnApOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfdGltZXJfbWF0
Y2hfdGFibGVbXSA9IHsNCj4gPiArICAgICB7DQo+ID4gKyAgICAgICAgICAgICAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDY1NzctdGltZXIiLA0KPiA+ICsgICAgICAgICAgICAgLmRhdGEgPSBt
dGtfZ3B0X2luaXQsDQo+IA0KPiBGaXRzIGluIG9uZSBsaW5lIQ0KPiANCj4gPiArICAgICB9LA0K
PiA+ICsgICAgIHsNCj4gPiArICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
Njc2NS10aW1lciIsDQo+ID4gKyAgICAgICAgICAgICAuZGF0YSA9IG10a19zeXN0X2luaXQsDQo+
IA0KPiBkaXR0by4NCj4gDQo+ID4gKyAgICAgfSwNCj4gPiArICAgICB7fQ0KPiANCj4gQWx3YXlz
IGVuZCB3aXRoIHsgLyogc2VudGluZWwgKi8gfQ0KPiANCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a190aW1lcl9kcml2ZXIgPSB7DQo+ID4gKyAg
ICAgLnByb2JlID0gbXRrX3RpbWVyX3Byb2JlLA0KPiA+ICsgICAgIC5kcml2ZXIgPSB7DQo+ID4g
KyAgICAgICAgICAgICAubmFtZSA9ICJtdGstdGltZXIiLA0KPiANCj4gIm1lZGlhdGVrLXRpbWVy
IiBsb29rcyBuaWNlciA6LSkNCj4gDQo+ID4gKyAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUg
PSBtdGtfdGltZXJfbWF0Y2hfdGFibGUsDQo+ID4gKyAgICAgfSwNCj4gPiArfTsNCj4gPiArbW9k
dWxlX3BsYXRmb3JtX2RyaXZlcihtdGtfdGltZXJfZHJpdmVyKTsNCj4gPiArDQo+ID4gK01PRFVM
RV9ERVNDUklQVElPTigiTWVkaWFUZWsgTW9kdWxlIFRpbWVyIGRyaXZlciIpOw0KPiANCj4gIk1l
ZGlhVGVrIFRpbWVyIGRyaXZlciIgaXMgZW5vdWdoLCAiTW9kdWxlIiBnZXRzIG1pc2xlYWRpbmcg
aWYgdGhpcw0KPiBnZXRzIGNvbXBpbGVkDQo+IGFzIGJ1aWx0IGluIHBsYXRmb3JtIGRyaXZlciAo
aW5zdGVhZCBvZiBidWlsdCBpbiB0aW1lcl9vZikuDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2
aWV3LCBJIHdpbGwgZml4IHRoZXNlIGluIG5leHQgcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCldh
bHRlciBDaGFuZw0KDQo=
