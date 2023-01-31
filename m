Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514846821AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjAaB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAaB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:57:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66532E41;
        Mon, 30 Jan 2023 17:57:23 -0800 (PST)
X-UUID: 95fe963aa10a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AyqTPuNV/KlD74ISJO3C01o9sNtSQ607h3Sa5VDWKEo=;
        b=oybRDvDUiG/oL1xiHC6/ivXzdsQNFlcn2trTvfST7wWlmwNFk6a+p3C1rI5twS9+j9x0jXOQinMpj/WQijcvz9ll1e2eUF42v8xWmdyYaHW1HQfd+53GQs5DnKCSl3qZx2yhXf0GD1POg1d6aZGX19cOfmvw9xmoLNjp/hAhBCg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:7ce86d9b-9824-4335-8a55-a04030d3d45f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:a05bf6f6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 95fe963aa10a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2077956903; Tue, 31 Jan 2023 09:57:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 09:57:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 31 Jan 2023 09:57:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZlbv1fP/iV+kEnUSjQq5clU/r3jS8IlYSx1Bt2qdlVS0IQzaQoELcoy4MB7C7NWDRM8FkNKS1OM9LDDDyQme3TYJ1aKE/tqBkGypWMv6SAhytKMkycVB4fwQuvWud3eCVRn+e+zGakffglgcG60rBh0M3YApKdtcgJN56yfAQlnFomzJZzW+C9XZT43AQZo1ExXaljktPB1V3OHjzIgl1QaafxgNndqiEn7mgoYT/5Ba4wlTIh8CdeBCWDDg6rxtQ/Lc2120MtWRv61FS/M5aosSdVo+JYwjbYU+Gm8cI43/e573suhmhvEdIPCaozg34skPy+EwLtIih2qjenhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyqTPuNV/KlD74ISJO3C01o9sNtSQ607h3Sa5VDWKEo=;
 b=lS7gVaI/A24BHh+qC5hkECrRfUK/hXOoJippeSElELcdPQUq33iqUy32C6CkEWmtr77lLc3t98JgLQpjNIOg3BEpy4cx4rHEthdE3ezCM2m9y7KxSflkt+XrdvcIkFdCU1iQmgbKUMeFWeogJnQ6k68hTvbyOEB9Iat8VzRnHnO9nX3FuK2qPAbs6S1Kg0RnfHHDnhOuzzFR3TnkVSEjJdVR8x/CHHnsBu9QO2xgp4q7sI2hhZRZnnrT6G9aQJzP2lcAxKUnTH11RV1isdx6Lx7/iu261iAymYlKUZpH/hcegeS9H2W4xceOZ7BRg4zs39ZTc5AofSL1vAecpRA47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyqTPuNV/KlD74ISJO3C01o9sNtSQ607h3Sa5VDWKEo=;
 b=wOuP0S1BlrfUO1His3lTCG0VVHA4bj0Mf6kloYRX6nqFgCc8sYDUGr9JrQLsXSyhz+YKhi+OvK2Z6TbVRThJmKj8vqWitMUdwv8BxIXb9Ool/YV9NgNDVJrjVzZH9ex8K6B1EfBBqZns2ZqjAs9++FNE6yVAyJiRIKfaWi4QZ6w=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by KL1PR0302MB5378.apcprd03.prod.outlook.com (2603:1096:820:46::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Tue, 31 Jan
 2023 01:57:08 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::4eb5:3fc7:1e3:2f27]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::4eb5:3fc7:1e3:2f27%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 01:57:08 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
Thread-Topic: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
Thread-Index: AQHZKussAIBNhMuL60+kgFdojuoEW663bl2AgABqcAA=
Date:   Tue, 31 Jan 2023 01:57:07 +0000
Message-ID: <5905e424eae324b2b75382e9d33fd22a85bdab76.camel@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
         <20230118031509.29834-4-moudy.ho@mediatek.com>
         <fe49e8b642c4c33fee37e97d957c37a3.sboyd@kernel.org>
In-Reply-To: <fe49e8b642c4c33fee37e97d957c37a3.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|KL1PR0302MB5378:EE_
x-ms-office365-filtering-correlation-id: 48629151-54c3-4267-7a61-08db032e75a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dyKtcDfkEE8yvMhAfkRzcnLat6e1lfWMahVYlSew+R1LXCcdnrNDy5C16LoA1Z8w1fHU3Wxr1UrUnwQiVsSdTtPAwbnCOl3U/ug+bUQJYniDgpFuQa4eC9WgoQdIFs2Me6GNIFL4S1F5XI6Rm9JQS3RpgNOW47YHfReNidy5X5jRWgbwqN+r10am/PTpxbDaeI0zzdyG63i9Ob0ItRNkvVq2gVREqHyQtZdNeV9SeJta+BvfbvlfA5ilhv1jFC+dVG3q3m75/kDEGV3/MoIcq6gsU1L/Jf0uxKSx9g8ysI+1CLe/bNTylJwrdSNQIW1URmBTveukZ9ZfNqnVQT2wkSLrauVDmMLgC8Xt0a1vMskCxQvYALeImqDKuvWIjt7MlCUaBwP+fl247NCH2k9EMCoy/EjodmyS8JdqzQJko40Tiw5sG057UBeFGrCUovxjBqLdfTvJzaVccuLWPdTtX+M3/T1ggma1xX6qcz1pADcU8wMwvMnplf+o29fk+qJZqWQapnsamO1dmWdLZOlcv7PzWhA0VlzNZhlP9xmt/lder2AcJ5/65PmI+p+oIb1CG67N3Jke2eQwTxy46xfv7+3RbtuawW7UTebFZpbbO/NcO/andfD/eiSi2EyiJQ2YJvsBM0BhZmh1OhfX67ofSlvaQiKPtJooDMpk06uEA9OqRZy4/MVd9SxaQcJP0drid0busWG5toijDsMjjID2GsGOnQXo7gvZi2Ex/kT6fQ34rOVfJfZncN4e/74Xzbp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(316002)(122000001)(64756008)(54906003)(41300700001)(8676002)(38100700002)(36756003)(66476007)(76116006)(85182001)(8936002)(66556008)(66946007)(38070700005)(5660300002)(2906002)(4326008)(86362001)(6506007)(66446008)(110136005)(7416002)(26005)(478600001)(6512007)(186003)(966005)(6486002)(71200400001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS83anZnaG4zRThjUUU3NzhPbURBdFRhRkV4Z1FKS1FvQXFCRllJOWNST3gy?=
 =?utf-8?B?WHlldHBIdW1NazZsdnc1OC93eTA0KzZvKzRJSWNXRWhSSWNrV0Rsb2lMdk5X?=
 =?utf-8?B?ZEp3SCttSTV5TC9vMGRDaTdId1ROUnUyRm9wQmgxSFY5bVFZSlNEbE95UUZE?=
 =?utf-8?B?Ny9YMTZKb0xSQTZpZ1ZtZ1VXRWxhZlJWaytCUVBZWFp6Nk9rQ0xXQTVEZkQ2?=
 =?utf-8?B?THBkSmhMbnNHZk9YMmVEa2tLNUlnR0Rvb2dpMkdSVk9DTXNNdmtNeDZvMWVm?=
 =?utf-8?B?ejVCNnU5dTVzQ2FCVWl4bHJGWGd0a2VnQkdENTdBNjhPaTRMU2szMWkwUm5C?=
 =?utf-8?B?Tm1MZWVaUlpwbElzNnZ6ek5uK0ZxekxaUE5rQkcvRTkvaXdFN2JTMFRTNWtl?=
 =?utf-8?B?U2drTGplaStISXpEcllwWnA3MUk4L21MbjJKUStHbUFmQ3V5NFVmbkFPNjBv?=
 =?utf-8?B?QnR1VlF0cjZOOHJOd1FRcWgvcjZ6WXc2cGJRNXdNWnJwRytKUjcweHpsc0lZ?=
 =?utf-8?B?M1pPVWR1dUVqOFQwREpLZ1RtRENWSHVKR09EZjYySHBoQWliUUZkTHA4NllD?=
 =?utf-8?B?WXpobzhaWVBZeUZzakw3eno1cWQxaHJPZTNZbFgzNjZmTUc2bUM2Rkp3RWpC?=
 =?utf-8?B?NFhhNkFhY1pwckcxd3R5WEZ0TVB3UmdsVG1uRHpRR3U2M1I5SUZCM1pNSHZI?=
 =?utf-8?B?aklxYkk5TEhTbjQ1RzNNWmVvL1N5YWFjNVE2dHNpN0RtRy9tcFFXbGUvTmFC?=
 =?utf-8?B?QUVxUHhVRzZ3a2hHcnMrTVIyRXA5YkRJVWx4SnAyb1ZvS2FJRG1JdnlTa0NS?=
 =?utf-8?B?VS9MVDFCaUdVdzNUbWF4MjlZWFVOUXRyWldDTzZwWnlWTURKSm9hajZEK0Nq?=
 =?utf-8?B?SU52ZjAvS1E1eEhBa2xpSGkvYytZODA1LzZSK0dnK2FOcXhvMVQxNU1qbWFT?=
 =?utf-8?B?YTNSRndQOHNqUjJaSmZ1bU83cU51dldOdm04bDdIa3B6Sk1NNXIrcGJ2YmM4?=
 =?utf-8?B?Tk9oSlo2SlUvODdQYzVYMzFoWGdKYVRQT0dSbEtENWE2N2tzUlhhZWN0eWNJ?=
 =?utf-8?B?OU5BVW1wUStSOTQvREsxbjFyWlg3OFpnTzJFdXJkNmdyNGNaa3FkRlVxSWNp?=
 =?utf-8?B?Z3hOQWhCZ0ZnYVZvbXQ1dzRQWVBWb1lUZzJyclZoc3J4ZUxuaitJL0ZBNU1l?=
 =?utf-8?B?amNXcFhNNWt6OEN6cW9vTktsd3VIczBFRUtLSDJDdmpqRHc0SGxvUjB2WWlG?=
 =?utf-8?B?OGVrMUFNaWxzaUVZOU5oRWpCYm1iSWUxSkJiMEg1TFNmR21KSEF5ZUJVTFVm?=
 =?utf-8?B?OG9aOXRIc2FVeHFKVkJqMTBrRElyN0RwaFZ5Z0lRb01BTThxdmJqcTNvdlI2?=
 =?utf-8?B?TXZVUWZIYlA3U1B6UXY3QWs1SXJVYlNsNzJzNGVpSjB6alc4bktrWHJZb1JX?=
 =?utf-8?B?MWc4ZHhVOTNxWCt1aEN0ak9QMVJaQ21pdGdNMFhtaWZuLzh2VFFvemVJSVV5?=
 =?utf-8?B?ZUN2QVdUZmk5Zk1BTi81OEN5YjhjT05NVlBmbkQ2eVN3MVRhOS9HUEJRUHJo?=
 =?utf-8?B?T2VHZE1wQmZ4M1g0d08xc3Y1QjE0L1ZqUytLSGM3TDBJMVljN3pDKzNZL3J3?=
 =?utf-8?B?OGY2T3ZZSVl6eUcxdjhrQkhhcUsrU2xxVTZGc2g1V1ZKZ1VHcDVvV0JmOWdR?=
 =?utf-8?B?SEplc0NIVjhRZEFqb1hUSGxjK09UbVJaMkY4ang5L2dQazBWb2tkK1ZnaDdY?=
 =?utf-8?B?Y1dpcHJSdC9jdlNmNTJ1NWluUGNoaTNVcHVhb05tR0Z2ZUJCZkIwLytTRGlY?=
 =?utf-8?B?Q1dFeEpwR3YrVnYyVVZuRmdYZ3FZOFpXSnlKUE11a0dxRUI5NmJDS1RlbjJI?=
 =?utf-8?B?MEVoc2tXZks0c2ZuUnhUWEUzNDQzWE1TUzdUNVZqd0F2T2RldUgzMmVpa1Np?=
 =?utf-8?B?bXAwWGJSb3NsalNRUVE0Wks5L3pQaUZ5a3NCTnp5WFJTazVVU0p4Ui9YcnZZ?=
 =?utf-8?B?eE9ZWGtiSTUwNHRRWmhNZ3l3KzlYRm9lenBDQU1UNytWb0hEVlg1WTBxYkNF?=
 =?utf-8?B?K3pHTkpOSmJDa0l6QmM1Sy84ZUg1NmE2YmE4Q2EwNm5YdUtwU0FiaUEzaC9q?=
 =?utf-8?B?dnNZRitQRDZQdVladitwK2FoWDBqd2hoTGV2Z2JHVFI2M1k3WGFJMGh4QXFr?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9694B1A5B7C5D468532AAB29CF41043@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48629151-54c3-4267-7a61-08db032e75a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 01:57:07.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbXSCsfPlJ+fr2MCNfkMdpmU3yIM64yDvJlsNVzgXKY25ezkz3//l4kLBiIhIolBXw5lgfN+SRidoJaR2qvFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5378
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDExOjM2IC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTW91ZHkgSG8gKDIwMjMtMDEtMTcgMTk6MTU6MDgpDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTUtdnBwMC5jDQo+ID4gYi9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQ4MTk1LXZwcDAuYw0KPiA+IGluZGV4IGJmMjkzOWMzYTAyMy4uNmQ1
ODAwZjY5ZjZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgx
OTUtdnBwMC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS12cHAw
LmMNCj4gPiBAQCAtODYsMjYgKzg2LDU0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUg
dnBwMF9jbGtzW10gPSB7DQo+ID4gICAgICAgICBHQVRFX1ZQUDBfMihDTEtfVlBQMF9XQVJQMV9N
RFBfRExfQVNZTkMsDQo+ID4gInZwcDBfd2FycDFfbWRwX2RsX2FzeW5jIiwgInRvcF93cGVfdnBw
IiwgMyksDQo+ID4gIH07DQo+ID4gIA0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG10a19jbGtf
ZGVzYyB2cHAwX2Rlc2MgPSB7DQo+ID4gLSAgICAgICAuY2xrcyA9IHZwcDBfY2xrcywNCj4gPiAt
ICAgICAgIC5udW1fY2xrcyA9IEFSUkFZX1NJWkUodnBwMF9jbGtzKSwNCj4gPiAtfTsNCj4gPiAr
c3RhdGljIGludCBjbGtfbXQ4MTk1X3ZwcDBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRl
djsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+cGFyZW50LT5v
Zl9ub2RlOw0KPiA+ICsgICAgICAgc3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0K
PiA+ICsgICAgICAgaW50IHI7DQo+ID4gIA0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTk1X3ZwcDBbXSA9IHsNCj4gPiAtICAgICAgIHsNCj4g
PiAtICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZwcHN5czAi
LA0KPiA+IC0gICAgICAgICAgICAgICAuZGF0YSA9ICZ2cHAwX2Rlc2MsDQo+ID4gLSAgICAgICB9
LCB7DQo+ID4gLSAgICAgICAgICAgICAgIC8qIHNlbnRpbmVsICovDQo+ID4gLSAgICAgICB9DQo+
ID4gLX07DQo+ID4gKyAgICAgICBjbGtfZGF0YSA9IG10a19hbGxvY19jbGtfZGF0YShDTEtfVlBQ
MF9OUl9DTEspOw0KPiA+ICsgICAgICAgaWYgKCFjbGtfZGF0YSkNCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsgICAgICAgciA9IG10a19jbGtfcmVnaXN0
ZXJfZ2F0ZXMobm9kZSwgdnBwMF9jbGtzLA0KPiA+IEFSUkFZX1NJWkUodnBwMF9jbGtzKSwgY2xr
X2RhdGEpOw0KPiANCj4gVGhpcyBBUEkgaXMgd3JlY2tlZCBieSBhIHBhdGNoIGZyb20gQW5nZWxv
R2lvYWNjaGluby4gQ2FuIHlvdSByZXNlbmQsDQo+IG9yDQo+IHRlbGwgbWUgd2hpY2ggZGV2aWNl
IHNob3VsZCBiZSB1c2VkIGhlcmU/DQoNCkhpIFN0ZXBoZW4sDQoNClRoYW5rcyBmb3IgeW91ciB0
aW1lIGFuZCBobGVwLg0KUmVmZXIgdG8gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjMwMTIwMDkyMDUzLjE4MjkyMy00LWFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbS8NCiwgYm90aCBjbGstbXQ4MTk1LXZwcDAvMSBuZWVkIHRvIGFkZCAiJnBkZXYtPmRldiIg
dG8gdGhlIDFzdCBwYXJhbS4gaW4NCnRoZSBBUEkgdG8gbWF0Y2ggdGhlIG1vZGlmaWNhdGlvbi4N
Cg0KUmVnYXJkcywNCk1vdWR5DQo=
