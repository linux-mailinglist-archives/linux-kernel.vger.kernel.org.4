Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAF746D42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGDJYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGDJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:24:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F9B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:24:19 -0700 (PDT)
X-UUID: 8c043b9c1a4c11ee9cb5633481061a41-20230704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m31hcpxbIxkWYzvi/m6546dW24HdSiIg4NjBJKNF8pU=;
        b=FmR1FFEZfyoh+IfL0GanzWSuLfDd5uG4IqRO8/8Qqn0/6lt4Q3ypmSwIsH19xgUxKNhKvRhARYnvZxR/OJ1K3gJ7NXemSIoyCMkek8ufUWKOXvBWLUQMklqKPBo7tBDfk0mnPxJng+CYoa84dB7UNBMNuCVqnLnQnbKdvMeWLJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:33267aa0-1b51-4a75-925f-726a3fb45d2b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:33267aa0-1b51-4a75-925f-726a3fb45d2b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:bc889bda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:2307041428453QSY49EO,BulkQuantity:5,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 8c043b9c1a4c11ee9cb5633481061a41-20230704
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1909234020; Tue, 04 Jul 2023 17:24:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jul 2023 17:24:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jul 2023 17:24:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbRr1wZ+wpf306bM1wTaUulcpNormP9HgXbpL1B0Ax1Npuc83AfIRDAFOYEWPdCGnks0x+408++Vo8ySL1xCUXB23eNyI23OA+1L3wxCCkYB7YuWcIGzM3hdoDVREcHziVTj4MqGBmw8r7xoC82i9RF4e8YfC7YDfvNMu4/U/dAy65e1wPnSAWNZbCNwyTJtdJ3n2YYqIjVXN8d9Q3XXE61Fw7Og3fk7hGJU5WnGX8j24IG5MfrDwxV8gh5w90jTATqVO7KWxU7cb3m0Eo9g9scrXba8auvho0xfCERUaZ3lQmPcSYFiqOsCbKCqrexOfQjvnMGXptEOqvYT+pTDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m31hcpxbIxkWYzvi/m6546dW24HdSiIg4NjBJKNF8pU=;
 b=chis1X2IAYZCTi4nQg+4QQp+0JtDNO77jxi1XHaM9eculKsZRkM7rfDyOP4HzTuUbbg6VBlUZEWLNFcSAouJdaSdcpxry0uL5ciBq7n5J4GsEKb+00HZyZJdEcZxbvZxP5ZgmnsNujg+zGnPH4/0QYPCEhIOySvPug3+IylIpnWlD+Fnc3HuM1q8KNAQn5Bnx90tnYuXmOe979DAI76QfNlfPMdjMivPNQo7I1EhzJqPoYSrK9Lote7EVoPS+SKD7xHeOXX7ugdMGkcY242ECovta/u8iPu/hzk6eYloyIg3Pf7ckHVs8C2uFDTFnoAbncvmUcMgDhYqh+Rw8DkSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m31hcpxbIxkWYzvi/m6546dW24HdSiIg4NjBJKNF8pU=;
 b=Y/f+cUE7HVSqXhWZnJfTui1bZ/8NGEHdWS5n84JnmYxJ3MdAo41m5u5/kT+rbjuAxnEzcGNrOVe/GCEGsiiuorMmSvQxtVHSbd465jtUD+I6lLjcVyhwkLXqyXYU0k0L3vBpeGiqLiq5CwiuG5DD9+3VS3xVbQN3wJ6GZu4dkn8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7844.apcprd03.prod.outlook.com (2603:1096:101:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 4 Jul
 2023 09:24:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:24:11 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 3/3] drm/mediatek: Use devm variant for
 pm_runtime_enable() when possible
Thread-Topic: [PATCH 3/3] drm/mediatek: Use devm variant for
 pm_runtime_enable() when possible
Thread-Index: AQHZmfHBQVobz+eZWEqKJ/8yrFaYDq+pfrAA
Date:   Tue, 4 Jul 2023 09:24:11 +0000
Message-ID: <bb1f63502aef836b4fa4e7f49cf8b51445e3edea.camel@mediatek.com>
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
         <20230608101209.126499-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230608101209.126499-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7844:EE_
x-ms-office365-filtering-correlation-id: a4ad9782-e7d0-4c5a-0c01-08db7c706d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J76WpLazYUNknV+rqoQ3H7ZDdNhdPruIowOZJ1SNeKmmB+p9nrHMRwYJJ13STOERDhP+pRP4PCJRAVqIfBpXiDcyt398hrVRMKk+UrlXIYC9j5njrb9N/cQMBqFClbYBmTL72LKiP7E5DnncWlcZlugYuPgKmLflgmKchjVoO6kKhX2iXxtM40ZNz41eQdGZAIPpCla6yQsU/NNr0OqjHz/0TxBYaQuBJWQgQj9Egc0Bcc1tuMVDY4waN1ChZiwkQKuZbtEoIdTajK5D9Vuzmj6Fg9HaHtOixlRDnDa1R84Qa0w7UC2o+amoBfraO89m/uLhaIRL6zRr9eVLTW+Zm0eA4mvk0AJQ5VfxvJ4r8IBeChykn006WVsXncR3KLFtA0tBYLr4EgGbzf3D6EEadyv5v1P9r/ERHozYBTNq7MCxfAfJK1Q+KhyHIfHmuDmoz21vx/akrme1Cs7N+8nJZ3P8xmqRwsv9px8EIIMgGVl/rewvu/Z7Hc10C1Ohie2UZM5bZxS25Uaz089QevD5SRy0QEqzHwAmy/m6kb6i+dnj3ZYQRUPM4yrs7u/iPjo6WaBaHigXwTV7hpHQCa/rYLOozKlrSpJajlrJOYJUMlMKr1dndN1BLoSpqASH64hancQHAQzJUr5wI1QTYdJclfqEDMGOCL9/4ni0k9O8waA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(26005)(6512007)(2906002)(71200400001)(6486002)(122000001)(86362001)(2616005)(38100700002)(83380400001)(6506007)(110136005)(41300700001)(54906003)(38070700005)(186003)(316002)(36756003)(4326008)(66946007)(66556008)(64756008)(85182001)(66476007)(76116006)(66446008)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzBkL2VwdFIwTU1NVkk4OVZzbEw2RnBFMlBzamtIbFhCZFJoWWNORk5lU1hQ?=
 =?utf-8?B?Y1ZxdnhtaWJCWXNEU2g0eHhOQk1SQW54eDZ2b3RUd0x5MTNIWFJ1aFFBaXBF?=
 =?utf-8?B?SE0relRMVENZT05rc2dwZFJUa1hQUWZ1cHg5R0JPVVZOWCtMRHUvQkIwejJN?=
 =?utf-8?B?Y1dPZEFsUk5zYWhIUXJwUHBkR1JVYUlmaTZKeWJSaHhRTHhXMjVKcFVTVkdr?=
 =?utf-8?B?ZWFtLzNyWXYvdGk1eXF2enQ4OUVZMzExejE0OHlHa3h6eGpMS2g0S2loT211?=
 =?utf-8?B?NTJtd3dpblllelZxc3VncjM0ZGVOQkdQSHF1bkM4OU1HTG1nSzd2UjZrQ0Vy?=
 =?utf-8?B?MlVTcFRIOE9jS0JidDg3TjRZU3E1RllHNXAwNi94eFp6cXAySGs5ZncvU3Jo?=
 =?utf-8?B?bkgzMDBXMHZ4dFQwUzFsaTdhdlZpUGhEZXpwbXJoTjJobk91T1ZFVks5MGpF?=
 =?utf-8?B?RlJ5ak5CM1Jjc0NIdkM5bTFRbjZVYkh1VzlFMXY0Q2c1WUhxZlZxR0N0NWJW?=
 =?utf-8?B?T1cybDR4WHJqN1orK2J1UXl6K2dHYmM2ZnFqdFhDWG04QW1nZGVlMWluSTlk?=
 =?utf-8?B?U245LzI2SmxrbnJZeHpJckNOZ1N0WDdJTGltTWxwcGxtY09FSkNMeW5vZllh?=
 =?utf-8?B?eG5lUkRaTENOM0ozb2VtRnowSXVEQ1RXRzRMKzNsWGo2Qm5qd2lMVmdOVW0w?=
 =?utf-8?B?R054cWswa256d1ZobjgzY05hMjhWclNJRndlbmlqRE8rQXg1QVlicUxPSnhy?=
 =?utf-8?B?elFwek56by9qeDB5cmxpMm5CTXBJK2w2UTdGczFOc3hRZlJuNVZuUmVTQVl0?=
 =?utf-8?B?R205WkFTUUl6VHV3QlplaUNFTFVyZ2JuSWVpREZoMjlJUVZlclNsNFV1NlI5?=
 =?utf-8?B?SjkrM2xPUFFtQUhha1dRUS92R1Y1RmpIL3MrNEZhMVI0dXc5ZXhQekhiNHo1?=
 =?utf-8?B?RnpEUSs2aEpHQTErZjJIZWhBdjNudlY3dGU3ZzVBYUpMbUhjWDVPRnJhci8z?=
 =?utf-8?B?SytsamdCUDl6N1p2N1RyekE4OThBS1JwZVlqVG9ZNEdzS1BRbGw4cUl4bHJJ?=
 =?utf-8?B?bXE5cXhPZUxvWlhaY3RmeVJEa3BGVjFmd1dsQXJZV0RFZmFUbVBMV1JoNnEy?=
 =?utf-8?B?UlFRUXB1WFl2VUhQR0FKaVpiNWVuYUhtOGxJaXdBQ3pWMEQrbFBmQWZlaHdO?=
 =?utf-8?B?UkJpU0tiTVh0ZkpCRUhXdENTQ3h5VEp4RWxlaW1EKzNOd1NlaVY5MzlZc1BN?=
 =?utf-8?B?blRjUWk5Vld3V2tvVGRvaFJyUHM0RURaY0lmMzc2VkZMVnhqSG4yWVpJWW1L?=
 =?utf-8?B?ck9GNXVlUzBDVkxvd2kvOTBlN2lMSW0zUXZmKzBxR1dreUh0Z2tPRmxQbDJ1?=
 =?utf-8?B?dDJjbno0clBRaW4yVkw5OG42YzVmRC8xNUl4WnNxcjR5K1BXSlUrc2JXWGZP?=
 =?utf-8?B?STFqbGd0M2V4T1pmVGc0Um8rVHFkZEpYVVE1TCtuTEFQeGxZQnoyUVFzb2Jq?=
 =?utf-8?B?UVJ2dUo4eDVKWWx0alc4dWpMNjQ1RkVRcGgyWUhKMUpxamdQd2dFd2NiYzZq?=
 =?utf-8?B?UlB4SHdBcjB6SEhEazlsRVFJL1d5dE91c1FpUnlSemQ2VDBBM2QzQ01EdEZx?=
 =?utf-8?B?OTVOblFaaWxyZDRnUW9CRG1LblBUWXV0MW9NcGU4NktLSVhZLzZRcitsaS9W?=
 =?utf-8?B?ZGNwcEhVZFk4RVlFZkJlY0VHK3FhZGFaYjM4SWpPQ090MktaMlVmaitYSjRB?=
 =?utf-8?B?OG90N09Nc1pYWm9JRXJDbUd1alJFVlNOMmQrQXNVaENLc2lFSTVKNEc0d05C?=
 =?utf-8?B?SUxwRG90U1N2Y2orUFB3QTVyZlh2b2pJcXExcmRoYlU1U2lpdlI5Rm1rYkNn?=
 =?utf-8?B?c2FjWVVoWVRpYkd5ZmJGTzVXclhKMGhvME8yTnZWeDlkTHI3NnFXZ3dsakdK?=
 =?utf-8?B?Tkx1c1lpcC9GSGVIRWtXWUhEbmZTdVNwYXhjSHlPeUdPYXRYRDk5N0NuZW5I?=
 =?utf-8?B?blNEbUNTdk9EOUxuNXRDQ3p0Q2lPRUREL21xeno0VEo2SzNpa2ZvRUxlcUdx?=
 =?utf-8?B?OHdZSGhNQmNWUXlDam1hbEM1d254aFF1cVFBY1hwNkl3MWxxclVRSTZob1Nt?=
 =?utf-8?Q?0w2zAw81ULKLurgTWsqLgQfdt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <223262DE898830419FF8DF859E6716A8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ad9782-e7d0-4c5a-0c01-08db7c706d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:24:11.0328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZcQ4jpIKiq8hpxTc4tEuaYWmhxpLM9roFBpEipuSS5SRBCtndBMvWCwZHPeLkJRPhSVnLd+/+D4o8cjqIiEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA2LTA4IGF0IDEyOjEyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBTaW1wbGlmeSB0aGUg
ZXJyb3IgcGF0aCBvZiByZXR1cm4gZnVuY3Rpb25zIGFuZCBkcm9wIHRoZSBjYWxsIHRvDQo+IHBt
X3J1bnRpbWVfZGlzYWJsZSgpIGluIHJlbW92ZSBmdW5jdGlvbnMgYnkgc3dpdGNoaW5nIHRvDQo+
IGRldm1fcG1fcnVudGltZV9lbmFibGUoKSB3aGVyZSBwb3NzaWJsZS4NCg0KUmV2aWV3ZWQtYnk6
IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmxfYWRhcHRvci5jIHwgIDkgKysrKy0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfcmRtYS5jICAgICAgICB8IDExICsrKystLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMgICAgICAgICB8IDEwICsrKysrLS0tLS0NCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9y
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0K
PiBpbmRleCAxOTkzYjY4OGJlZmEuLjE0ZThhZDZjNzhjMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTUxOSwxMyAr
NTE5LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3Bfb3ZsX2FkYXB0b3JfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCWNvbXBvbmVudF9tYXN0ZXJfYWRkX3dp
dGhfbWF0Y2goZGV2LA0KPiAmbXRrX2Rpc3Bfb3ZsX2FkYXB0b3JfbWFzdGVyX29wcywgbWF0Y2gp
Ow0KPiAgDQo+IC0JcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gKwlyZXQgPSBkZXZtX3BtX3J1
bnRpbWVfZW5hYmxlKGRldik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0K
PiAgCXJldCA9IGNvbXBvbmVudF9hZGQoZGV2LCAmbXRrX2Rpc3Bfb3ZsX2FkYXB0b3JfY29tcF9v
cHMpOw0KPiAtCWlmIChyZXQpIHsNCj4gLQkJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICsJ
aWYgKHJldCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8g
YWRkDQo+IGNvbXBvbmVudFxuIik7DQo+IC0JfQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+
IEBAIC01MzMsNyArNTMzLDYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9vdmxfYWRhcHRvcl9wcm9i
ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgc3RhdGljIGludCBtdGtfZGlz
cF9vdmxfYWRhcHRvcl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsN
Cj4gIAljb21wb25lbnRfbWFzdGVyX2RlbCgmcGRldi0+ZGV2LA0KPiAmbXRrX2Rpc3Bfb3ZsX2Fk
YXB0b3JfbWFzdGVyX29wcyk7DQo+IC0JcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX3JkbWEuYw0KPiBpbmRleCAzMDdiZTM1YjU5ZmMuLjVlOTBiNmQ1OTNmNSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+IEBAIC0zNjEsMTMg
KzM2MSwxMyBAQCBzdGF0aWMgaW50IG10a19kaXNwX3JkbWFfcHJvYmUoc3RydWN0DQo+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHBy
aXYpOw0KPiAgDQo+IC0JcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gKwlyZXQgPSBkZXZtX3Bt
X3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4g
IA0KPiAgCXJldCA9IGNvbXBvbmVudF9hZGQoZGV2LCAmbXRrX2Rpc3BfcmRtYV9jb21wb25lbnRf
b3BzKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiAr
CWlmIChyZXQpDQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRv
IGFkZA0KPiBjb21wb25lbnRcbiIpOw0KPiAtCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiBAQCAtMzc1LDkgKzM3NSw2IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcmRtYV9wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgc3RhdGljIGludCBtdGtfZGlzcF9yZG1h
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCWNvbXBvbmVu
dF9kZWwoJnBkZXYtPmRldiwgJm10a19kaXNwX3JkbWFfY29tcG9uZW50X29wcyk7DQo+IC0NCj4g
LQlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+IC0NCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBf
cmRtYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+IGlu
ZGV4IGVkNTE5YjVhMzI3My4uOTNlZjA1ZWM5NzIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tZHBfcmRtYS5jDQo+IEBAIC0zMDAsMjAgKzMwMCwyMCBAQCBzdGF0aWMgaW50
IG10a19tZHBfcmRtYV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
I2VuZGlmDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+ICANCj4gLQlw
bV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiArCXJldCA9IGRldm1fcG1fcnVudGltZV9lbmFibGUo
ZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJcmV0ID0gY29t
cG9uZW50X2FkZChkZXYsICZtdGtfbWRwX3JkbWFfY29tcG9uZW50X29wcyk7DQo+IC0JaWYgKHJl
dCkgew0KPiAtCQlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiAgCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBhZGQNCj4gY29tcG9uZW50
XG4iKTsNCj4gLQl9DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlu
dCBtdGtfbWRwX3JkbWFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7
DQo+ICAJY29tcG9uZW50X2RlbCgmcGRldi0+ZGV2LCAmbXRrX21kcF9yZG1hX2NvbXBvbmVudF9v
cHMpOw0KPiAtCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gIA0KPiAtLSANCj4gMi40MC4xDQo=
