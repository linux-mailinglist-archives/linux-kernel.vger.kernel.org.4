Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A346567B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiL0HJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0HJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:09:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D3639C;
        Mon, 26 Dec 2022 23:09:18 -0800 (PST)
X-UUID: e1c4e1ed1bae4aaeb4ab7e76f32f9198-20221227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qpi3u5HXpbVwL6Ho6TDM38JmYMSmSMHr3+GK++j97NM=;
        b=olWRX2kd00gSyhwTRAdA1Tdj/MRSM0D/JSQDLvxkFvueLvb+2Stt/+1D30a/BLARUpWseQvPTN2KBI+4fatCALzVtyyJbm649IhltrP2sxozkus1f7iUcXDRa0+/krwwhTAZBEkrXn7Op4xXDAaetFS2bvXQDRbQD5ztOAnzfVE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:883655ea-c1f7-4bde-a742-62049693f645,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.14,REQID:883655ea-c1f7-4bde-a742-62049693f645,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:dcaaed0,CLOUDID:98b0e652-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2212231724371MX7JH63,BulkQuantity:25,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: e1c4e1ed1bae4aaeb4ab7e76f32f9198-20221227
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1937237027; Tue, 27 Dec 2022 15:09:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Dec 2022 15:09:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 27 Dec 2022 15:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXtseapa+V0jwFmTDBPBpfst4ncs2Wf1HAot9DAg+R5Ait4/KUKGsPGrCEeGKtlUQBGFSQIJ2MmoAPvJphpCv4t8Zk9ObaSJB9XsBjSOSclG2+fIVDWoh1EfwRhqZ4OIz3p0NSL+bx2/rufdK+TmuW3LM9nqvmQERcTR6zU0boOyg/cNyolOWPNZeCchW9uatSLYDd1N/17te5OTNvbmklXVGvDpFn6ZFM9JJ6eaC+rfqIgyIdmjILxP0vbePYHsKdAr6q5+G3TRhIRQQgFEBpQ2cVoPySKE9A1wGf4UNc2vJGIQs2uKb1mN0U2KESWU4qNzRDPalN4655If6ZKbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpi3u5HXpbVwL6Ho6TDM38JmYMSmSMHr3+GK++j97NM=;
 b=lmDN8t4y++Si0GTe8vkXgXK5T82HDbS6zqnevly3hTG1/BTqkl2HdbggrVzVXjCfIpK8+DHxVu1kI9PCN8srUV90wRuwSzHZ364u9vbyQ7PIcQlmpc5zxt29hI9Xvss+w7rRbK/Ovs7HCLxRJGhpjMGxT/c0/k3mwRZ4wx+pJYhk7KtKOQmI8eDxoj08GxQM7hjF3oyZ518oKmMe5sNqoC3iYoZA6cRcPthX+aTiZVUW0PuwYapU2MZh1BMzQ7d8kTEkELGdZda+7a6Q9s9xEXZvfj4UuAfcMWO9vVNw3S1/FqdU9drepiJx89GNWNJCJM8rQAz8jquyEA2dnuFHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpi3u5HXpbVwL6Ho6TDM38JmYMSmSMHr3+GK++j97NM=;
 b=fWwxQ8hjORGLHZ+vDwI9+fBqtaB9NkixCj+maRjmbAhvzm1Ad9YvbY5YIHA5ZqXx+LXNdhpMsA83LciwRbc8QxAfYrDa3RINHwwQnFsv3gAExT1dorcvp1pDlotMLwNusbqJeftbJPuD7ZyQtnK50KfbnQdlRQpl1w6cdF+ztxI=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by SG2PR03MB6827.apcprd03.prod.outlook.com (2603:1096:4:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 07:09:11 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 07:09:11 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Topic: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Index: AQHZFnD46s2/SRWVcEOB7S9zlZaYAa57hgWAgAQHhwCAAMBsAIABCWEA
Date:   Tue, 27 Dec 2022 07:09:11 +0000
Message-ID: <5baa7c88716042421b0dd1d579c6aa70d253a546.camel@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
         <20221223015029.24978-2-biao.huang@mediatek.com> <Y6W4vwJHG+6PI8fd@lunn.ch>
         <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
         <Y6m7eNdWVL3IKFj2@lunn.ch>
In-Reply-To: <Y6m7eNdWVL3IKFj2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|SG2PR03MB6827:EE_
x-ms-office365-filtering-correlation-id: 355ab166-41cb-4847-b7e6-08dae7d94164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0TJuttWFB4RCWXHOt6OlGVFfLoZiMB5Zr7JtEwQDy7twu6VAWCbVwJzqs3oT7FOiHhgyMvQD/2h6cI5M1V1THCSXxV0F1KsvWywVwoZGh7RVvXGOEQ0veQ10+MiDof4tuUWxdBRcvvtEEONdyqWfjV/d+1yeOFj2Bwdh+Bikfy5/WskVjdlIWf9Uf95z4pWv0iCF3IOR+8fe9Kect50GogBuJ6MPjoYwIiznHlA+ZZJ3HBlYtb/ZOMxdPcq3Q8f+zBIkSISxl5qiNwJAUl1oH+I+a/mZsL5bDbZa+oiNH2UXnaO2+DBkJxDokfRWllNEerXNSKhfBDxmtLoELVF7tDy4F2krioKUqisUKGV/jhaujvQsYxb4TNyRZ43IDfR7E/2PhDdFZLBqEGR0QpftipFBKNStLDqzcSZssIHC4ZNzgi/dsMKKdUquiaPP0V1thwmQ9a7V6IDiVgfR8Uzrocc3WRxUGqVeigLIrah7OVBEJf11up/UZstz88+p1yWQAeWejSUc/ZVO2qWJzq0LErgF7Cs6zFV202ArbrRcYkNL0cL7eGrFJPk+bdFp488iA+IzYit21bxqUQxMYtrL5syQceqNI9U5bQdUmWKSuZZ/oeoLLqjceuQgXEm9Sz5avUz++XqsT0N+ELWgz/pXlQd54dbznpHIKoDoAf2i1Gwup2IfpSZb4XtJ4qHzF6uo6X/gBTyDy6IsBNljde23tfbQqlTW071u+qVwYxqzgLNMq7xhqGdUVUyLc0SuuVP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(6486002)(4326008)(478600001)(4001150100001)(2906002)(6916009)(54906003)(316002)(71200400001)(85182001)(36756003)(83380400001)(38070700005)(38100700002)(122000001)(2616005)(26005)(186003)(6512007)(6506007)(86362001)(8676002)(8936002)(91956017)(66476007)(66446008)(76116006)(66556008)(66946007)(7416002)(5660300002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU1JMnJjWWJHa3BzQXJ2T2p3SXRhbnY3L0dKWVE0V3RNakZTY3dlNytJcTJT?=
 =?utf-8?B?M3h0ZVZKVzh1UVRmd3Q3dVNHSHhML2dHOWRiQjlEQmhMTkpsb0tlZGJ4elAw?=
 =?utf-8?B?T25jRGoyTS9aTWtuNnMzaXBrWUJmbnF6UTlWMzg2Y2dnRTczd0NDUnB2R00z?=
 =?utf-8?B?UktqVXRZbkl6SkM0SmFZQkc2em9rVW9ZYkRMKzRISnIxalRjS3J5UnliL2o5?=
 =?utf-8?B?ZC9qUVNYbXBQSVJzNVJ1VklUdUdjRGx2eC9iR2JZRDNQZ2pnNDlnZWlOZ1VL?=
 =?utf-8?B?RG5NUk8wdGZrRm9mSENoWWNZVG9qOUN1SWFrcWhMU1dWbW83b3h5Zjl0TFN2?=
 =?utf-8?B?SGtTWjRpTmh0akdhRTQ1RGhvTXpaS1RWZGFqUjhYaGRWVFhjRUd6QnBuT2Nn?=
 =?utf-8?B?S2VDUmdHOUdVenFxVkwrL0J0Qy9qeE1Ybk1VaUFZNCsrNlJJTE1HbDNvYmt3?=
 =?utf-8?B?bDdtemhoQkxBcUhWMTRzd1hOR3VlY2JTQ3ZiUXM3dnBJeGVrZ01RV3gzNmtn?=
 =?utf-8?B?U2s0UDh3OEM0ZFdzcFVCZWY2WEE2b2k3YnE1eUo5NVI1azNjYnJ2ditoTGEx?=
 =?utf-8?B?Ky9VSzRGc0R6T0tjZk9hUzBTdWFTTk1HeFp0R3VCL0FyQlpoV1NmNWRpOUw0?=
 =?utf-8?B?VVc1OE4weDBKWWZZZEQ4Ymg4aWV5ajc0eVdEYjhkT0RVbEZlU20rZk1hU3BJ?=
 =?utf-8?B?enhQTEdiSElXTmRBRCtKdjFWQlZuT0plbHkyU0lMaWhRbnJyaFFZZXpkTGZn?=
 =?utf-8?B?VE5UQlpqbEgxMFR5MzAyWU1iSVlyRUppSVNJblRRN2tobnkya2R1SWY2SUFD?=
 =?utf-8?B?MFhYZmFTanN1WGhrejdGaGlOS2phemJnRWRyUU1EcWFTOE9JaFNWcVIxQlY3?=
 =?utf-8?B?Z3hQbHEyMVYrU25Tazc1NTdjSWxxVmM2SG5MUVFzbGcxU3gwbEVTSUQxV2Vp?=
 =?utf-8?B?UnhldGt2MDV0Z1c3bzRSblVOZUZLTUhjVE0va2p6bFk0REE3cVFwbUViaWhl?=
 =?utf-8?B?Nno0aG8rb2svU0EvNkVwYjdVSi9ZVjRZeEs3bUpEWXRCS0VHYlE4bHdCS3lQ?=
 =?utf-8?B?OStReHJ4bldtUWR3eXFINDlHaDdZS3cydCs5V0MyemhUUUZFZEkwSEMzZFZU?=
 =?utf-8?B?NnNPOVVMOFgrNHFOUE53NWJwS0VYcGhQbjkwcGE3blk0Zkh5WGZVM0dVTW9F?=
 =?utf-8?B?ZUxZa1NvWkZwc0xPbEo5TElWMkFDN0NLV0ZEMld4Mis4dE5lbXRvMkVYT3hy?=
 =?utf-8?B?cXo0cG1XbXRVd21jZ1p0ZjlEdEkvSnFGdUpoUTV0SlY4cjRwTW1JUUUxUEVJ?=
 =?utf-8?B?bzMzcHdNeXM4S1NzTnlvWkN2Z0ZNczJqNnY2a1NHQllTakFoVUdJcnhtWEwy?=
 =?utf-8?B?djM3RHhtQW1NMHMxWVlqV2J1YXJjYjZ4eUVmU1NhYkFLK2ZTM3YxSnQxMUI5?=
 =?utf-8?B?VDlJa2VudU8ySVcxYlRETysxSVJaNGU3OEdySjlaSUkwbVZHYzY5Yit2bWls?=
 =?utf-8?B?RUtxanVvVkJXTUhPd3BIRUw2eXJ1WVZiclZ2ODlxNXVwanIrdFp2bmQ3a1g5?=
 =?utf-8?B?bldtQXpMY1hhYmI3OFozak9oRDhLT1N2VGR5NTJSeTB2cmFVUUdrcGcxa3Nu?=
 =?utf-8?B?dG15UW41VmFXMktpR05tL1JBWC9aYitEWXM0OGRyWm1JeTFqWTdNT1pjMkx6?=
 =?utf-8?B?OVdPcGlQajdpeDU2amlTUWNQajl1Z0VuVTArNWZKVFh3TFluaGNERmYzYnJi?=
 =?utf-8?B?SjZsb2FhZFE1Z0ZLVkgxdVFlQWdEdkNmQmJFY3JKb2N3V2JsemFvTmxrZ2Jk?=
 =?utf-8?B?NDJpdlRkRzIvL3NSVHlRZE5IaFVKbEJVV3JKSzR0NzBKZkd5UHRFNk53QUlp?=
 =?utf-8?B?OHpzTTlRY0oxazhCNk9WTGJmcnMwWFNzRDYyQ25GazhxZUhyZjI0cmVkZURW?=
 =?utf-8?B?VlQ5blJwSHVzalVTTlEwOVkxTTlVMlA1L2E3ZTRIOENKeEhucTVVV3dTSGx2?=
 =?utf-8?B?WVQ1WWFic3lhYkordTVSaUtnNWYweEdDbzFOelVyYUFuOFladVZjUkREVE5X?=
 =?utf-8?B?dXMxeGxsT2NIZTRMSFBCTVR6akFWNTRZWTlzck5odFNYM0JGdXJwOVdQSlZ4?=
 =?utf-8?B?V283Zno4MUZ1U2Judnp1Q2tTMHdQb3dnOEhQanlJUmdKak1sSG0xdWNOQkU2?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E739F87C1095043AD395CAB102CCB38@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355ab166-41cb-4847-b7e6-08dae7d94164
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 07:09:11.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWjovQnIGwxLj4+K25UgLqF+2JwOr6QNvbg7oPUuKDxk2I+/yEHMuriQdk2v76kPJTBt/SeOH4lisoDAwosUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmRyZXcsDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzfg0KDQpPbiBNb24sIDIwMjIt
MTItMjYgYXQgMTY6MTkgKzAxMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+IFdlIGRvbid0IHdh
bnQgdG8gcmVzdHJpY3QgcGh5LW1vZGUgdG8gcmdtaWktaWQgb25seSwgc28gSSBkb24ndA0KPiA+
IHRoaW5rDQo+ID4gd2UgbmVlZCBtYXNrIFJYSUQgYml0LCB0aGVuLCBVc2VyIGNhbiB1c2Ugcmdt
aWktcnhpZC8tdHhpZC8taWQgYXMNCj4gPiB0aGVpcg0KPiA+IHdpbGwuDQo+IA0KPiBUaGUgcGh5
LW1vZGUgaXMgYSBwcm9wZXJ0eSBvZiB0aGUgYm9hcmQuIEl0IGRlc2NyaWJlcyB3aGF0IGRlbGF5
cyBhcmUNCj4gcmVxdWlyZWQsIGluIGFkZGl0aW9uIHRvIHdoYXQgdGhlIGJvYXJkIGl0c2VsZiBw
cm92aWRlcyB2aWEgZXh0cmENCj4gbG9uZw0KPiBsaW5lcy4gQXMgc3VjaCwgdGhlcmUgaXMgbm8g
Y2hvaWNlLCBpdCBpcyBzZXQgYnkgcGh5c2ljcy4NCj4gDQo+IEhvdyB5b3UgaW1wbGVtZW50IHRo
b3NlIGRlbGF5cyBpcyB0aGVuIHVwIHRvIHRoZSBNQUMgYW5kIFBIWS4gOTUlIG9mDQo+IGFsbCBN
QUMgZHJpdmVycyBzaW1wbHkgcGFzcyBwaHktbW9kZSB0byB0aGUgUEhZIGFuZCBsZXQgdGhlIFBI
WSBhZGQNCj4gdGhlIGRlbGF5cy4gVGhlIFJlbmVzYXMgTUFDIGRyaXZlciBpcyBvbmUgb2YgdGhl
IGV4Y2VwdGlvbnMsIGl0IG9mdGVuDQo+IGFkZHMgdGhlIGRlbGF5cywgYW5kIHRoZW4gcGFzc2Vz
IGEgZGlmZmVyZW50IHBoeS1tb2RlIHRvIHRoZSBQSFkgaW4NCj4gb3JkZXIgdGhhdCB0aGVyZSBh
cmUgbm90IGRvdWJsZSBkZWxheXMuDQo+IA0KPiBTbyB5b3UgY2FuIGJlIGRpZmZlcmVudCB0byBl
dmVyeWJvZHkgZWxzZSwgaGF2ZSBNQUMgZG8gb25lIGRlbGF5LCBhbmQNCj4gdGhlIFBIWSBkbyB0
aGUgb3RoZXIuIEp1c3QgYmUgYXdhcmUgdGhhdCBub2JvZHkgZWxzZSBkb2VzIHRoaXMsIG5vIERU
DQo+IGRldmVsb3BlcnMgd2lsbCBleHBlY3QgaXQsIGV0Yy4NCj4gDQo+IE9yIHlvdSBjYW4ganVz
dCBkbyB3aGF0IGV2ZXJ5Ym9keSBlbHNlIGRvZXMgYW5kIGxldCB0aGUgUEhZIGFkZCB0aGUNCj4g
ZGVsYXlzLg0KPiANCj4gV2hhdCBzb21lIE1BQ3MgZG8gaXMgaW1wbGVtZW50IHJ4LWludGVybmFs
LWRlbGF5LXBzIGFuZA0KPiB0eC1pbnRlcm5hbC1kZWxheS1wcyBUaGVzZSBhbGxvdyBmaW5lIHR1
bmluZyBvZiB0aGUgZGVsYXlzLiBUaGVzZSBhcmUNCj4gZXhwZWN0ZWQgdG8gYmUgc21hbGwgdmFs
dWVzLCBhZGRpbmcgMTBzIG9yIDEwMHMgb2YgcGljbyBzZWNvbmRzLiBUaGV5DQo+IGFyZSBub3Qg
ZXhwZWN0ZWQgdG8gYmUgMjAwMHBzLg0KT0ssIGFzIHRvIHRoaXMgc2VyaWVzLCBJcyB0aGUgZm9s
bG93aW5nIG1vZGlmaWNhdGlvbiBlbm91Z2g/DQogICAgMS4gcGh5LW1vZGUgPSByZ21paS1pZDsg
IGluIGR0cy4NCiAgICAyLiByZW1vdmUgdGhlIGZpeF9tYWNfc3BlZWQoKSBpbiBkcml2ZXIuDQo+
IA0KPiAgICAgQW5kcmV3DQpCZXN0IFJlZ2FyZHMhDQpCaWFvDQo=
