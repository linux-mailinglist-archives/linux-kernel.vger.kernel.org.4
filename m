Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41E649803
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiLLCoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLLCoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:44:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9355BA;
        Sun, 11 Dec 2022 18:43:56 -0800 (PST)
X-UUID: c19c96b388d942529d115f875739be49-20221212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IkL0Ra+hN8co6Lf8OMhJMluVw6kUCQnKbgmtyaakWNk=;
        b=cbUKFlKWP5JO9udyXR7sTAh8eHa19kgIeDR7Vfg5K9haurcHoozRrJHQpekAfG+xAl9SCdgmvOrmyR9nfJ7OgxbtTwqPSXTMd1KsGd9WIMuHIqxG5EObCVZWHakXSwoKRfytr1LbNuyd/jFgmy2/XgnR51szc/JONPLNmPSRIis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:67c60ba9-7e89-472a-b5fc-22daa5611977,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.14,REQID:67c60ba9-7e89-472a-b5fc-22daa5611977,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:dcaaed0,CLOUDID:c10e3417-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:2212091815455HC55ZNW,BulkQuantity:27,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: c19c96b388d942529d115f875739be49-20221212
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1072557485; Mon, 12 Dec 2022 10:43:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 12 Dec 2022 10:43:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 12 Dec 2022 10:43:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE1RTIT02F1lLwHedw5ogE40OHKuBjMY1L9rvoqO341F45kiaOzJSOAlPz9VvMQ0c/t6VGkq+pCM/JHJ279wlnUQzL0FT2dVO3vqWI9+8j8NEZ0FUROPnLEE5+a+l4BauF4x4QxrdtY1hvadZ4rRHpZNn7DLXyTVsVufcO32FMgBckOf5rOG4ctJmtHPpDx+FrLtwDu9s3g+qCIKToTp3naL+50axYhuDNGuLd8pFFNwjG4ljLqi/lirFBwGf0aWDNiKPaXVv1G9kG0rWdsAdR3Jrc69fPNzTxXPCz1KH+HvfaR5CRPxiPMvqscg507U2HEDXB4HPZNhaFNhUa9FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkL0Ra+hN8co6Lf8OMhJMluVw6kUCQnKbgmtyaakWNk=;
 b=LOv3kIGoth44wbpmqeSTT8f6RXz5YqBTNiEL5qyfs3uv1SQCt191mjQHyoYs/AlaGXzOVhAfwBEyd7+DQ3hBoGK5Tzdu/Cf+ajKwLgTzsRdvX1mdG6wQt3x82mLfRGCnimGYedvvLtuM/VI0CrBMA2Kx3+QGE+HC25oHH59eitPJouJCht1oV+wLnjYBjkrsI9CpoKKfUCW7PwyjP27bBQC1fOLGUxK62xtwSuIj2DlH5WfmL4xXgxkrjamegW0X4NaWYScS1b1nexyl3VDBl5lCXlu1PSKa0wXQ4wv1lFnYT0glgJiwSjuXYBE3Tqc9Mb8jBJQZHPbpXEYbIrMc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkL0Ra+hN8co6Lf8OMhJMluVw6kUCQnKbgmtyaakWNk=;
 b=m5yKMz3KoMcqRCvXa5VX3NXgcl7uf5g7X8Gc5oWTOb/QHnKYAMvo2vrMuUBlB6ftsrZ3Cw4PRdmsEkmlpK3wiehNUAkyX3RHupWUOLzfejK5R36RMEP9OG6YYlxmnrTzvxbP0qTTa0/a+v3+Vy9ETGEi7MePxVCZGQfXixqKuxE=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB6490.apcprd03.prod.outlook.com (2603:1096:101:46::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 02:43:47 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 02:43:47 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHZCrW9BCZh9S7ETU2R3v1AiYWaeq5lWPGAgAALRgCAAEMtAIAD6koA
Date:   Mon, 12 Dec 2022 02:43:47 +0000
Message-ID: <e08fab2a694313abc12e0f8303de3e2e704b388c.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-11-trevor.wu@mediatek.com>
         <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
         <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
         <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
In-Reply-To: <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB6490:EE_
x-ms-office365-filtering-correlation-id: b790e314-bc4d-4176-3aef-08dadbeab194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acu3awplLh+QPUjBOh0lRKzQlB22o6KB7IjHc2v7vsq3//TJWQ7DlGXgU1dPRsGXHXrcgdSLElpHUTmRM6b796xDCeqhx0w8ykdKiwKnOyA6NswJdZbxBQr2S9pLm0/8IGw22DbB2dJ16+t6wVrAjCwthm5dac4Kj3UIi6B2mZdS6B/ZvTMQZlYq/+7zRFmzi9s759rqzvisHhOeZM+cSkukCHSjYauHe4kyQPHmMduTKllj9sOHMmM5lWI/ETzh8A4hRVMEGvVBNUja/0B99zSXEQMMQV7lWk37yu2xzpQfy+7caSQbcoJGIIUkISc/lj4oFBbWj7mShovl9jrE6Ge93Rf89x6yflfPQXpqp6ReKvQn74Ln/5ZumtbjY/cBCBk51RYRmNlN4sI10nnOa+pm9uczQYDjsd5oCmf+hcAW8+I4CM8DcQFMlKK8ucMYj/KAs/vETlgl9F45B6HdJqAU2HeR7DvQ8VfeQPJSijj5asMGKa0PZiGKriM2LAsWST47T4LcBYaJBz3kdOeXhIonXSJ3TmyQiSxN8qXeLZ5MtH+I4b0WYF9O3g+niJz/pm0kcALju3oO8Ab25fXbTfUBxIl4ssPgs+ZOVD7GNTrac4l7l20EL4k1fSAvGivG3h27A0ezcmXphs5+Rg729PoEXa8XDLrCeUl80L/vclpUwW9TXxzlj/ioGwu/darUi6TooCAhUSqeYdY7kJnzDYHnvBQlop+WfrEV3UWZsfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(36756003)(85182001)(86362001)(110136005)(4326008)(316002)(8676002)(76116006)(91956017)(122000001)(38070700005)(38100700002)(54906003)(186003)(6486002)(26005)(6512007)(83380400001)(6506007)(53546011)(2906002)(5660300002)(7416002)(66946007)(71200400001)(478600001)(66556008)(2616005)(66476007)(64756008)(66446008)(41300700001)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFZ1dzZLc0ZYRkdINzB2blY5bnZVcHhpRGxUeDRFV05xMTVhcEVOdGxnc0hD?=
 =?utf-8?B?M3pSN1ZQM3RVMzVKT1JORVBaVzdQRGdpbTR5cHlkb2VzK3U4WDlaeDRta09C?=
 =?utf-8?B?c2RNWXNTNWdKZWtYMWpjZGh2NEo4M1BYK0NRRWd4WHRZaEZlTmZRMDl5VTF4?=
 =?utf-8?B?NkswQm5HRFBzQTlIelhEcVBWczVBZFlIb3JCNlpQbXJTK2N0cDFxZ1JzWk5m?=
 =?utf-8?B?VkZYeEIyeGFKaXVIcTZ3SCtRTytzZnk2ai9uZlhMcWFCc3VlbHdTSnZRQ1cz?=
 =?utf-8?B?bVhlMXFYTFZpVjdicHF1Y3ZNbHc5c2RyYUVId0phU3JGeksweXVjQ0xFMmtQ?=
 =?utf-8?B?MDg2a3R5bkRwaEF1eUxvcTE4cnFYb0M3U2JkZEFSQ0orcjVCMmd1UTRQV1lI?=
 =?utf-8?B?RUFvZlNKWHdNUWRuQ2w2ekpkTU9FbDNQYktvMk5PcWJuUndUVmVndlV6MXUy?=
 =?utf-8?B?S2YweVdGNE1CNTNFaisva1JJV1ZxTGJRNjNraFZpWTdQOFJEU09Yei9DQm1C?=
 =?utf-8?B?NXM1dDN1SFVTNnZLL25kSkdTTkI4bFpFK0Y4QnJYY0tCUnhhb1RxYWRjcmtX?=
 =?utf-8?B?dDVnWFZBaUY1d1h3SkdJMUpHRkhaR1hhbDR3YU9ZNHZnUWNieUU1MkxKK0gv?=
 =?utf-8?B?eVNYOXc1cGhDTEx3VWhEcnFSeVJlYUdNTDFKZnc0ZUpQNE1IcURYU2cvZGRV?=
 =?utf-8?B?UzhzSzVzK1B5eXVZamhFUEgyS0I3R3IxcTl4TkFxeHY0Zk5UejBjNmNkdXA2?=
 =?utf-8?B?aDZadUY1R2ZUTVQ5bzEyT1Q2Z3JPWXlseWFKU3U3Zk1OWFNBRDMzQlhkUXha?=
 =?utf-8?B?UXovZVlDY0JEOU9jVVo1cGNkNHZ1ejd1MktZczdGanZMNFBaTHN4azc3TnpP?=
 =?utf-8?B?ZEY4OGxVS0JxMTF6ODZoakxWY2pTS1hydUtkd25zNDBCVzVaWThXLzFVQ2hw?=
 =?utf-8?B?bExpMm4rNnVKbEFyWUVKNEV1NUhUdWoyTnViTU9VaURiUDIra20rNFp2VUdQ?=
 =?utf-8?B?YlBlN3hFRzdZRnZFWm9QOXNXSlJodHltQzZXcUQ0UkFLZXhIK0VvcHlDTEsz?=
 =?utf-8?B?NDFYcVZKRGFoTXY2RUVHTlBVdWprUExwQllUelNzb1NIV3VHV3dKT0xTVlFw?=
 =?utf-8?B?NVI0VmxsWWJITDljTWtCMnYrN0F0ZUZGOUFoQ212WjZtT0dPWm4wSHNISHo5?=
 =?utf-8?B?Z3Bpc3NiU0Q5R1VITUgzdFBKMWoyZ3BtTy9jc25ROVpwcmx1T1FYL2ZhOGVP?=
 =?utf-8?B?QXhQVXFCVXAyWVJEUEdGRW1lQWxRenlvT2p6MUR1eXowOTRDZ3FieFA0cEFs?=
 =?utf-8?B?bEg5TERKa0d3bFBkV2VsK1ZqVmZ3L01oclVHL0I3K1BZb3B4N2RJbCtldzk5?=
 =?utf-8?B?bHRQQ1djR0NQeFhrekJOOFZjNHBuODYrcGdCNHV6cU4xTlltRkplQTZkK1Z6?=
 =?utf-8?B?Uk5VYS9XVU5QSDFNZWEvVHB0NWZBQi9FL3B0UDBOeHI1K0JxVmdac1VySXdK?=
 =?utf-8?B?MVpvUDBVaXptVEsxem1IK25GNmgxbExGWlY1STBKSGpTYUVqclZKVzNpSWR0?=
 =?utf-8?B?aDd6VlhkVm13QU52UW1uYVhhdEJpS2lFejZsNWpOaU11QzZGQzhZREtuUGtJ?=
 =?utf-8?B?Nk5DN2J5Tk8wbFRvdHRaQU5zUDJGVll3Ky9FNjVFUWVMTnBqRGUrczI5eCt6?=
 =?utf-8?B?emNlOFh0YnNYZ0RkMTIrRXc2VUtpNFJ2MUkwUUFCM0NwNHN4Tm1RMTZ4YWN4?=
 =?utf-8?B?ZjFQL0hIQW5KaSthY3hKRllDTlNNc1VycjlUNUJzay9sZElHTnoxT1ZEM0ZH?=
 =?utf-8?B?QzRROXhEaHFQdmFQT2tSOFFwbDJvRkwvS0cwZ0lWVXNFRCtkYmRxUytoSW5Z?=
 =?utf-8?B?MVNYRmhHRmpoS1pOSU01a3R6WUFzbloreXFTVjUyQW5Td3VoSHkwZzNKODA4?=
 =?utf-8?B?d0YreVdnWCtGUE1iTW9TQTNxNUpXODBBVVE1VFlySEF3T01sTk5aYk1zVEdW?=
 =?utf-8?B?VXh0MENZMjlCS3E0Ukt2N3FZa2FpMERQNzFaVngrZ2RrLzVRZGY5aE1vb2RG?=
 =?utf-8?B?YnJXY0FiS1c3SGhlT2lMTDBzanI4RWVZV08zL1RIVk1kY1ZyOG5qYmlWajJM?=
 =?utf-8?B?Z2QrbUZQRC9kUHJ4b2dBazc3Y1R6SnNpUFVjWWw3amxOQkRKUDZCaTMva3VS?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7383980C033D6428C26CEDB7049CFF8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b790e314-bc4d-4176-3aef-08dadbeab194
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 02:43:47.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThddBcnJ/tMnFAF9uGFuREGWPuv7KKobHB7lyJgfo/sVF2108pjgYYWcPMpt5X9eUrQ6PZTRPBuUP4LerI8CpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6490
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDE1OjU2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwOS8xMi8yMDIyIDExOjU2LCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgd3JvdGU6
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ID4gPiArICAiXm1l
ZGlhdGVrLGV0ZG0taW5bMS0yXS1jaG4tZGlzYWJsZWQkIjoNCj4gPiA+ID4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50OC1hcnJheQ0KPiA+ID4gPiArICAg
IG1pbkl0ZW1zOiAxDQo+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDE2DQo+ID4gPiA+ICsgICAgZGVz
Y3JpcHRpb246DQo+ID4gPiA+ICsgICAgICBCeSBkZWZhdWx0LCBhbGwgZGF0YSByZWNlaXZlZCBm
cm9tIEVURE0gcGlucyB3aWxsIGJlDQo+ID4gPiA+IG91dHB1dGVkIHRvDQo+ID4gPiA+ICsgICAg
ICBtZW1vcnkuIGV0ZG0gaW4gc3VwcG9ydHMgZGlzYWJsZV9vdXQgaW4gZGlyZWN0IG1vZGUody9v
DQo+ID4gPiA+IGludGVyY29ubikuDQo+ID4gPiA+ICsgICAgICBVc2VyIGNhbiBzcGVjaWZ5IHRo
ZSBjaGFubmVsIElEIHdoaWNoIHRoZXkgaG9wZSBkcm9wcGluZw0KPiA+ID4gPiBhbmQNCj4gPiA+
ID4gdGhlbg0KPiA+ID4gPiArICAgICAgdGhlIHNwZWNpZmllZCBjaGFubmVsIHdvbid0IGJlIHNl
ZW4gb24gbWVtb3J5Lg0KPiA+ID4gDQo+ID4gPiBTbyB3ZSBrbm93IHdoYXQgYXJlIHRoZSBJRHMg
YnV0IGl0J3MgYSBteXN0ZXJ5IHdoYXQgYXJlIHRoZQ0KPiA+ID4gdmFsdWVzLg0KPiA+ID4gRXNw
ZWNpYWxseSB3aXRoIHVuaXF1ZSB2YWx1ZXMgLSBob3cgYW55IG9mIHRoZXNlIHNob3VsZCBjYXNl
IHRoYXQNCj4gPiA+IGNoYW5uZWwgIndvbid0IGJlIHNlZW4gaW4gbWVtb3J5Ij8NCj4gPiA+IA0K
PiA+IA0KPiA+IEZvciBleGFtcGxlLA0KPiA+IEZFIGNhbiBzdXBwb3J0IDE0Y2gsIGJ1dCBCRShl
dGRtKSBjYW4ndCBzdXBwb3J0IDE0Y2goaXQgY2FuIHN1cHBvcnQNCj4gPiAxNmNoKS4NCj4gPiBJ
biB0aGUgY2FzZSwgd2UgY2FuIGNvbmZpZ3VyZSAxNmNoIHRvIGV0ZG0gYW5kIG1ha2UgdXNlIG9m
IHRoZQ0KPiA+IHByb3BlcnR5DQo+ID4gdG8gZGlzYWJsZSB0aGUgbGFzdCB0d28gY2hhbm5lbHMu
DQo+ID4gDQo+ID4gbWVkaWF0ZWssZXRkbS1pbjEtY2huLWRpc2FibGVkID0gL2JpdHMvIDggPDB4
RSAweEY+Ow0KPiANCj4gWW91ciBkZXNjcmlwdGlvbiBzaG91bGQgZXhwbGFpbiB0aGF0IHRoaXMg
aXMgYSBsaXN0IG9mIGNoYW5uZWwgSURzDQo+IHdoaWNoDQo+IHNob3VsZCBiZSBkaXNhYmxlZC4N
Cj4gDQpIaSBLcnp5c3p0b2YsDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KSSdsbCBw
dXQgaXQgaW50byB0aGUgZGVzY3JpcHRpb24uDQoNCj4gPiANCj4gPiANCj4gPiA+ID4gKyAgICB1
bmlxdWVJdGVtczogdHJ1ZQ0KPiA+ID4gPiArICAgIGl0ZW1zOg0KPiA+ID4gPiArICAgICAgbWlu
aW11bTogMA0KPiA+ID4gPiArICAgICAgbWF4aW11bTogMTUNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAiXm1lZGlhdGVrLGV0ZG0taW5bMS0yXS1tY2xrLWFsd2F5cy1vbi1yYXRlLWh6JCI6DQo+ID4g
PiA+ICsgICAgZGVzY3JpcHRpb246IFNwZWNpZnkgZXRkbSBpbiBtY2xrIG91dHB1dCByYXRlIGZv
ciBhbHdheXMNCj4gPiA+ID4gb24NCj4gPiA+ID4gY2FzZS4NCj4gPiA+IA0KPiA+ID4gSG93IGlz
IGl0IGRpZmZlcmVudCB0aGFuIGFzc2lnbmVkLWNsb2NrLXJhdGVzPw0KPiA+ID4gDQo+ID4gDQo+
ID4gVGhpcyBpbmNsdWRlcyBjbG9jayBlbmFibGluZyBhdCBpbml0IHN0YWdlLg0KPiANCj4gYXNz
aWduZWQtY2xvY2stcmF0ZXMgYXJlIGFsc28gYXQgaW5pdCBzdGFnZS4gSSBhc2tlZCB3aGF0IGlz
DQo+IGRpZmZlcmVudC4NCj4gDQoNCklmIHRoZSBwcm9wZXJ0eSBpcyB1c2VkLCB0aGVyZSBhcmUg
dGhyZWUgcGFydHMgaW5jbHVkZWQgaW4gZGFpIGRyaXZlcg0KcHJvYmUgZnVuY3Rpb24uDQoNCjEu
IHNldCBjbG9jayBwYXJlbnQgKHdoaWNoIEFQTEwpDQoyLiBzZXQgY2xvY2sgcmF0ZSAoTUNMSyBy
YXRlKQ0KMy4gZW5hYmxlIGNsb2NrIChNQ0xLIE9uKQ0KDQpUaGUgZmlyc3QgdHdvIHBhcnRzIGNh
biBiZSBkb25lIGJ5IGV4aXN0aW5nIGR0cyBjbG9jayBwcm9wZXJ0aWVzLCBidXQNCnRoZSBsYXN0
IG9uZSBjYW4ndC4NCldoZW4gTUNMSyBzaG91bGQgYmUgZW5hYmxlZCBhdCBib290IHRpbWUgYW5k
IGtlcHQgb24sIHRoaXMgcHJvcGVydHkgaXMgdXNlZC4gVGhhdCdzIHdoeSBJIHNheSB0aGUgcHJv
cGVydHkgaXMgZGVzaWduZWQgZm9yIGFsd2F5cy1vbiBjYXNlLg0KDQpUaGFua3MsDQpUcmV2b3Iu
DQo+ID4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgIl5tZWRpYXRlayxldGRtLW91dFsxLTNdLW1j
bGstYWx3YXlzLW9uLXJhdGUtaHokIjoNCj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogU3BlY2lm
eSBldGRtIG91dCBtY2xrIG91dHB1dCByYXRlIGZvciBhbHdheXMNCj4gPiA+ID4gb24NCj4gPiA+
ID4gY2FzZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAiXm1lZGlhdGVrLGV0ZG0taW5bMS0yXS1t
dWx0aS1waW4tbW9kZSQiOg0KPiA+ID4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gKyAg
ICBkZXNjcmlwdGlvbjogaWYgcHJlc2VudCwgdGhlIGV0ZG0gZGF0YSBtb2RlIGlzIEkyUy4NCj4g
PiA+ID4gKw0KPiA+ID4gPiArICAiXm1lZGlhdGVrLGV0ZG0tb3V0WzEtM10tbXVsdGktcGluLW1v
ZGUkIjoNCj4gPiA+ID4gKyAgICB0eXBlOiBib29sZWFuDQo+ID4gPiA+ICsgICAgZGVzY3JpcHRp
b246IGlmIHByZXNlbnQsIHRoZSBldGRtIGRhdGEgbW9kZSBpcyBJMlMuDQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEtMl0tY293b3JrLXNvdXJjZSQiOg0KPiA+ID4g
PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+
ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgZXRkbSBtb2R1bGVzIGNhbiBz
aGFyZSB0aGUgc2FtZSBleHRlcm5hbCBjbG9jayBwaW4uDQo+ID4gPiA+IFNwZWNpZnkNCj4gPiA+
ID4gKyAgICAgIHdoaWNoIGV0ZG0gY2xvY2sgc291cmNlIGlzIHJlcXVpcmVkIGJ5IHRoaXMgZXRk
bSBpbg0KPiA+ID4gPiBtb3VkdWxlLg0KPiA+ID4gDQo+ID4gPiB0eXBvOiBtb2R1bGUNCj4gPiA+
IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
