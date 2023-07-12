Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377DB74FCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGLBku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGLBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:40:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFCE6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:40:42 -0700 (PDT)
X-UUID: 191cb2e4205511eeb20a276fd37b9834-20230712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=0Uwz8pxugFewTQLBdw0y3a8okcxolt4qAImOcwZaLwI=;
        b=AuhKlJNsjbb1tUTaiLaRHafmSoopw0kLEc4kOMwLS69/eV+T55sv/ABwMXPhulhyI4O2Z2N3A6sld9+KFW3jLPMRvcdKu9CIkpLjewEmoCBkBrsK3+pb4e2HpFt2tw1OLEzPvvjPIATByqf2BbPc4S0US9sJpo6+I7iGCDDhKk4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:a45df458-918b-4b3b-882b-9899252aee49,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.28,REQID:a45df458-918b-4b3b-882b-9899252aee49,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:176cd25,CLOUDID:1cf91f68-314d-4083-81b6-6a74159151eb,B
        ulkID:230712094038LXHO1AIN,BulkQuantity:0,Recheck:0,SF:33|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ERI,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 191cb2e4205511eeb20a276fd37b9834-20230712
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 413660158; Wed, 12 Jul 2023 09:40:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jul 2023 09:40:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jul 2023 09:40:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvcus0U9pRa1IXqAIOv1JMyANmvNMEJR8Z+X6QQfUskUHCGjIGcgiVPtZ4CUb1XOE8/eolg+2E8RZPgbbAgY86BBJa7zjnTnMHa2qVn3lHNKBzT6QyZN4grxOu7ZLHpf1IFNMQTWzCriZxKb0XEp5As9gpP7BY0sy2kX12dSTIRQpLcaaVlWMh0UHviBrdWu/fOCI+97ICYhkmqepsCT9Rse80W/6iA7Sftlt4R9XcYAXuhCG7WsGTAszMDn9PgOrdVLLRQGjy2i1enrEly8jo5SQ881CzVJL9z7C0l5PkCfVUXibjcrL3kXnHlkWsIs5SUCKySn33VJe2FC7cH+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Uwz8pxugFewTQLBdw0y3a8okcxolt4qAImOcwZaLwI=;
 b=UTiVfCTpLeR9UU7u6Hor+7dGwUiU4WXuf68cbWBbpsgqlgJZRRQsG+IR/JMv0LaMTMRd1MFJakZT8Pnh0x7qp9YsGlsvlpgl7gz9AJI290FiugMdCuorWi6Qka1uI8kAUdo0AmkXbhK7liKS7RmUhLSZgPyK+doTts0R9HQiXz0pr5fZqFKxpKrYU5UseOs1qnLrohn4zVaA0ZQN55jxove0mrwsLOGd1ruw/8ifpuuPBqvQ0kVPViQVfnyHYuWJijG/SCQR/jjBqn9TV8zeUYy243AhC57THt1oRK9bHsQeKEf/ke5MFTbZjNFwf8tZzoJEM4CEEy5/wJKKaWjx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Uwz8pxugFewTQLBdw0y3a8okcxolt4qAImOcwZaLwI=;
 b=NoI+JvgevKYoz58HS/KytqXWQJoam7NMFeC2VeHsd5NlVvhf9h0QR60UsT09R10v8wvaCXmAz9cTIZA4xow8t/FZRzTXERclPsMfbIcMnRHpUOEuTjxOtiaxj3rSwib8KK8TRyJT1TXDeKGW1yMD7wo4wT1bCcwYvMnLZ4gzLEI=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by TYZPR03MB5993.apcprd03.prod.outlook.com (2603:1096:400:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:40:31 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 01:40:31 +0000
From:   =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SGFua3MgQ2hlbiAo6Zmz5b2l5bu3KQ==?= 
        <Hanks.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        =?utf-8?B?Q2hlbmctWXVoIFd1ICjlkLPmlL/oq60p?= 
        <Cheng-Yuh.Wu@mediatek.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Topic: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Index: AQHZtGHYNPlnD3rYGUeKZi/54Lohag==
Date:   Wed, 12 Jul 2023 01:40:31 +0000
Message-ID: <17c629f00dee2bbcd09b99a6ed1bd2a411322084.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|TYZPR03MB5993:EE_
x-ms-office365-filtering-correlation-id: 37d457f2-2494-4423-928e-08db8278faca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vERwHZrrmwFr2Ze1n+fRkycJAB/k//LbBwhOenJ7CY0T6f+chL1le+i50nezObELquBKd8HHCwbdWtNaW3vsGWfllAy0c5t0IUM+zEpRVF5b+BTjc/UlDtcEt1VEFEBJBtjvVC8opj0MAzztYz1u5QWN6i/99xUan+YPM40sHTtKjV57d5TrOa+C+LP9gbAQk0fcgdiHqnyri3l4GSHRrjDdwxk2mOjge6Un8381Ca5dH/TDUfWtEmKJf1gY53qO3dS/y28HdTF3FCTMq1AGf39BYvzCB4R7ih+CTUS/7MqqQPTs6Ag4f+klk63Yd2aCb8ukjaQHqWkvAYjo+22/PnypdhMEEtoE17tVqxqd3ijo5JpQn/0BnHE3tqZqa8mnFVwhvr5i5QwFI2903DqcOux+zJmemL2ojrMbBQYTWlpHHu9UEv/60cL4MYbCzgpOGxKTJTg27RALVuV6yb22G+OKesGgkwoD1zr6qtHBkZFzKeqkTb4H9Mt/gyvuEOZUCai89W+IkdU0N/IMpqPF8jYX8K1c0mGugS4DTpd9uY4yO4hm8gnLOi5LY8P7XCVvZOWyx+pmgol1Qab27xb0YJt3pLhtCpEacCSmGA3O1THOCsfLhk/CNNpbdHDCPPYzSeRBxb5vl3otyUPBXWetRzTpIUuMRhdTpfNfwiXE0x4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(122000001)(6512007)(38100700002)(83380400001)(2616005)(186003)(107886003)(26005)(86362001)(6506007)(558084003)(5660300002)(38070700005)(8936002)(8676002)(36756003)(85182001)(54906003)(6486002)(71200400001)(478600001)(41300700001)(66556008)(66946007)(66446008)(66476007)(91956017)(76116006)(64756008)(316002)(4326008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTUzNFRXSmdGT0xvWDBQZEI0cVZJaVBuME1yc01GQVJoTENWNHhoUXl3c0l3?=
 =?utf-8?B?QWRMY0g0SGxHMUNrTG45SVQ0YWlyMFN2MHVuZ1IzS00raGdMcFJCTUdTTUNM?=
 =?utf-8?B?UEoybVNrTGF0VGhPTkpNUC9pbXlVQ2lMRzhlK25iT1RnaUR6T1UxM01xYUtx?=
 =?utf-8?B?NDlMR0krNldkZkd5T25BQVVXQ3JIa1V4R0krdnFINHlzc2RxQVQxL2tjeGNh?=
 =?utf-8?B?V0lJV3VqVkUvcTJJcndhb2U0TE45UFdnd2FTYk5WMFJSL2ZEZE9HWGFmM0dq?=
 =?utf-8?B?SEp3UjgyOVlTNnN5RE8zeWFVVEk2TGNhSlVZcGJaSW9sZlJlSXFvVWV3Y05D?=
 =?utf-8?B?bG9EakZaOWF4WnE5YWdIeVdpTG5Ic3JoUmRIa1NEQ0ZQM3k0anJJM1JneEhK?=
 =?utf-8?B?UHYwMktMeGhSVXZkZnJkMkxRWUI3cnluR0NKTEhyME8velFpMENXcHgyUUVq?=
 =?utf-8?B?REpxRnpxNDhHQlRYb1o3NUFad0VaeW0weUNtNldML0kzZDNCM1p5Z1ZFRFVj?=
 =?utf-8?B?Rnl3YWp3VmtwU29tbGQ4bHpQUmlXT0NWWVlqb0Z2bGtXb2pjWmY4K29iY3lp?=
 =?utf-8?B?S2J6WUJ4YmNCWjQyQW4yVGlrYk5MV0ZlMXVxUVBybjcxa2J4TjBDbGIzSDdt?=
 =?utf-8?B?azhWSU5tRzdDZnM1TDhteGt0NkZqMENKMm9wdGw5SmdidktnR2h6UEc0eHlT?=
 =?utf-8?B?Wk0vUnRDNERudTJkUHdZQkF3aDc1TDhBcG5QTHgvdkpQTFdPdlhzSXlEelRo?=
 =?utf-8?B?NjR6SHhVWVcvbi9PcnVQRXhFdmhXOTZVT2czTFhpK3FDdjRVRVhvVUhvSDR1?=
 =?utf-8?B?U3FNYmF4ZVRuZTNWN09HVWVnTjV1Y1ZCVmxNd2NvM2o3eEdRVE9FQXpTSDcy?=
 =?utf-8?B?VE1rVkZFTDJzVGhydG1jSWhKdnd1UmZxQmM1SzltL0tORDBMTHRrRUtzS2sz?=
 =?utf-8?B?c3VVR0FCbWhXWjdOWjhha3VwcTNnRDhXamdDREZKWWhTdlBpd1FRMXBHbklC?=
 =?utf-8?B?UWhTWWRGOVI0Uk5pY0tiaFdxbDNGc1JqK2ROVGdFN2QvK2lTc0FNSWJDOUdK?=
 =?utf-8?B?VDk0T2pLZGwydHpuT0ROenNRdVZXMC9nK3kvb3M0NURmcjNaektkL3EvS3RS?=
 =?utf-8?B?MUFwWVFLNkpBWjFoQ05Kb3d4Rml4WXNBYnBMc3ZGbXVpWC9XcEtHQnJ5RUdU?=
 =?utf-8?B?M28rUkhXZ2h2VS8xVTRYY2lFVUtwcWJmQUtDN1h6c2IxUzlXbVd0a0ZHNWE0?=
 =?utf-8?B?S2U1SHExVGtnbzdwdWtTMFNCaU1EUXJ0Zi9rZEFJeHpSdUVTc1p2alhoU3Js?=
 =?utf-8?B?M2Y3K1A3N3k5NTlVdHppRzR1S0dEKzRETnllbEg0TFlILzlOVnphMjBSb1Ur?=
 =?utf-8?B?cEthbTZoQWlQeno2SnI1NGl4Tm51ZCtnTVVLOW5PM1N2bTFtdGZWTFBwNEgw?=
 =?utf-8?B?QjB4WkVvajhmSzJiZTJWUTFERjNLK29KZm1EZkR4bEdwY3NPNTJNc1k2d0do?=
 =?utf-8?B?TlVyQm9Da25VUEhpQ2tqbU1OK05KbktuajN6K0VkUG45U3NicDEyR3ozNTIy?=
 =?utf-8?B?S3pWTFNwN3FRRExld0ludFRkRWlORllYa3pKSUI0Qk5uNjM5VkhZWWMveEVK?=
 =?utf-8?B?YmF0cmRNbDUxUUdhZUF0SWx1UGF0KzY0NElsbmRCRnNnKzV1VjhvUUtXN3ll?=
 =?utf-8?B?T05RZWFmZFlmSDhvSGlFdFAxRDBlUlFtemJ3ZnNwZ0llclhkT25Sa2JRbHhS?=
 =?utf-8?B?NVpQelN6bVNGK1Z0K296cjlqeE03bEVVekh0Q1MwcDVSK2pJdkdYVXhiNEMv?=
 =?utf-8?B?U2RXUlU1NmNya1ovYzd3WlNjbWU5bXlENk8xOXJhbExFdFRCdXRpWkEyQXgz?=
 =?utf-8?B?bGdrT0dsczNFN3ZPd2QyN3E1K3BHdjQzVndVT013ZGhpYis1Tk44Q0VkWHdI?=
 =?utf-8?B?anBOQVFkVGxOY1RCQkpNMnNPck1KQ3BYMndldlB2QmVUZmQ4d25zUUdGY0s1?=
 =?utf-8?B?Z1pVQVFEb3hkN3JLdmoxZmk2bVRlMmNGSU5TUFVIUkxmM3hNVkN0YS9PcEJn?=
 =?utf-8?B?U2p3SmhDWU51U0VqL0dNQm1waTF6UDRpVU5VWVgvVnEyaVJBY1JUZHVndXRs?=
 =?utf-8?B?SWdFMzhjMW5iZXd3S1krQ0JpV0FNM2lsL05Id3BBODBoS2tDYnJJcmdIR0FI?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5931F443655C449405FD27BD604756@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d457f2-2494-4423-928e-08db8278faca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 01:40:31.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNzr7bOAIHv9YTz7JM12tRMhdzMF3xxfLe3PicaN0jymaDjiTQbikYOwtZXML/CRt+xdKmW4pioNsqUlRUzv+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KV2UgaGF2ZSB0ZXN0ZWQgdGhlIFBBVENIIHYyIHdpdGggTVRLIHBsYXRmb3Jt
IGJhc2Ugb24ga2VybmVsLTYuMSBhbmQNCmNhbiBjb25maXJtIHRoYXQgaXQgd29ya3MgYXMgZXhw
ZWN0ZWQuDQoNCklzIHRoZSBQQVRDSCB2MiBmaW5hbCB2ZXJzaW9uPyANCklmIHllcywgbWF5YmUg
d2UgY2FuIHJlcXVlc3QgZ29vZ2xlIHN5bmMgdGhlIFBBVENIIHYyIHRvIGFuZHJvaWQxNC02LjEN
CmZpcnN0Lg0KDQpUaGFua3MNCkNodW5odWkNCg==
