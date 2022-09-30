Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29D5F0468
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiI3F77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3F7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:59:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAACB34702;
        Thu, 29 Sep 2022 22:59:48 -0700 (PDT)
X-UUID: 49f014e786214af89d62af2c207997aa-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bGOvmDTjd+25eO2aFN/9mbGsZeMoOnFx9Nay1a0O5Jw=;
        b=bLZMNvWB7/hlCRS1H90vtuxRJehI1Kopd1ZX0ykd9A/3EyY/Aww6xXhpj/Y+gZwnLUvkomGO4fAbtnQd/HAbSVAPEtkhJYS3vJ7brjY5EFS2MlVv7e/LG39Spt6u/GNHFk2Nak02DvOEWv/ZA5x1bR1n6ECG8VqnDpo1IoMt4Zs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4496214c-f13a-43fd-bea3-67cc78721286,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.11,REQID:4496214c-f13a-43fd-bea3-67cc78721286,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:39a5ff1,CLOUDID:9174bee4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220930135946NLB32I3T,BulkQuantity:0,Recheck:0,SF:38|17|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0
X-UUID: 49f014e786214af89d62af2c207997aa-20220930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mandyjh.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 325600704; Fri, 30 Sep 2022 13:59:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 13:59:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 30 Sep 2022 13:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXjivqlgnrovjwt2rS8oWZFPMHfEwsEKpVLxJm6DNWJ3Bnqo/bUBx+xFtAfRl9IQtq8peTFcF9es9wOhlUXPej6gZ+jzzrcJM7rp41XarP41cMMdm0/oqLqpD0O4Yt3bmPPfCwwMU2j+DBjTEwyH3e6gaL0v80Z6soBRqPJSmTZww715cSTWgoFaa9qwEXpt+ntGHK7xaoZX8RrIDxAYRbl46H32FZIwnKIfVPUgggODeNJsKM2tHVlgu83bOHoPr2I5GOJ3T9Zb0fNxZ+MZlbOStfz21d67BwJPvyaAyFQrasWiwgmYYIIlG6cbvIoSGKLrr28aAepYapKpJ3sDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGOvmDTjd+25eO2aFN/9mbGsZeMoOnFx9Nay1a0O5Jw=;
 b=npOkEnUnLuSJ7FmRUIvZw/AbsQp3goXNTwHgKf+O9iuNPuOHjKWUSVsYsLbG7cIPDhYl5gZIGH7FwPuZg+/PffHI+YYf8+uhbL5gxwSsybvj2hq5uWppOsof3IlXwRg/5X1bn4U2n2KOnEDOAg6cgWAjU8do2dypupjEH3O7FZhsMNAQXjm8KFKhu56kOqm7TYA1cYdYP/Ize9tSfvTrb/P0asA4hxOccV6gGbWXOEtT9345Ku9vbdW/ujR/XckLV6VUZao5tDZ6whg5E+L2gHn+ApRymLaPoFWk/OlBktNXSa58KVdVJgKfXGZWv1gkMndrHPvwqppeydNWDWOhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOvmDTjd+25eO2aFN/9mbGsZeMoOnFx9Nay1a0O5Jw=;
 b=LVVCMIaLVzl/OR824gw7nLbUe4VZR03UJYa6Cbjsn+qeOgSXDzhUVU7eq97F5N2gcrKUFY3w1l2HfN99ngOzJtU7c4PQJhCLygiI5RaFfjKZHG3hdNpGVLZu1iTC1/jCi4vLrbUO3hHdABtCLd0fhIglWrJFCNjOxXRHDc28hXo=
Received: from KL1PR03MB5490.apcprd03.prod.outlook.com (2603:1096:820:5f::8)
 by PSAPR03MB6396.apcprd03.prod.outlook.com (2603:1096:301:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22; Fri, 30 Sep
 2022 05:59:41 +0000
Received: from KL1PR03MB5490.apcprd03.prod.outlook.com
 ([fe80::4898:466f:f080:b0a7]) by KL1PR03MB5490.apcprd03.prod.outlook.com
 ([fe80::4898:466f:f080:b0a7%6]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 05:59:41 +0000
From:   =?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= 
        <MandyJH.Liu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?utf-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v3 08/10] clk: mediatek: clk-mt8195-topckgen: Drop
 univplls from mfg mux parents
Thread-Topic: [PATCH v3 08/10] clk: mediatek: clk-mt8195-topckgen: Drop
 univplls from mfg mux parents
Thread-Index: AQHY1I2h3qWAWG11TEaHloAmP1qwza33eowA
Date:   Fri, 30 Sep 2022 05:59:41 +0000
Message-ID: <79490e834466628a1b92e51f65aeb9e9ce82ddce.camel@mediatek.com>
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
         <20220927101128.44758-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927101128.44758-9-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5490:EE_|PSAPR03MB6396:EE_
x-ms-office365-filtering-correlation-id: 2d2f60c9-4b0c-48f3-1d06-08daa2a8f76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26kzsq8Za95U4dK7w+HtcbMRijQEMvMCOEEJDsEntqMRgb+NUjweyjNC2GWdKeBQTB5P7aDLMfVRFgZG7QbwXO9ozZiVVHNlpbNeZYxaqVavSOVXsEhi2vX2xlKVHksWLf8CDPU2JUM/joXudYQyS7NlXhS3zSzSUGtOIPjF5aOcwrB9oWYEfzL70dLOA237Yl66DrIh9tsErho8JiK6Ob/qEaKC1CFF/3+L7ctjFHY4CloRrHpPDUzJdGi6pxG1BPrrZqUx9rihurhQPGTpbznWarsfYOoqFNEC8eB+hWa8HS7rzFSH8R/LuWZvDuUMcq9K59ZCGjmslTqFlG6kO/SGSNQr7OIitbhIzfsXbGxfcXOy3aCHE7O0yEBOsXZ25zQGEbLADizpT/6n1Iej705gllV8pP9GUFNVtqK80NOhhDOCL5glID6gUvZkI/ymDc+nsqxBKTurs685LT7awLQv/kPnfpfSBNZOi0W6WBSYlUX54o3I9tFNoXaE4kHFAlDue9R1KE5mCZYW7LY6m4sgze0UC8de2j1RLQPNJWRy83dc/PS8Bs9iGlyTXCN+qXnZCxG+AqXM5Xd72ENFp7RUQNFJi7bMKlACyR/aMcG4t0uwJ3+cawzhXhTSvLiBzRSLdGjpScEu85s/coAKe/N2K8geFr+mkCMCZDZipc9T6sXGWFW2lJmcR1j/x8WIc2Qw4V3zkzo8A9wbcwzdvlHq8uSW5HVmQNtzw13ojWxP//0B/8Y9DB2PplDVoWSdo4ZlZdWzbB79B+oqUGWPeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5490.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(2616005)(186003)(38100700002)(86362001)(85182001)(36756003)(38070700005)(122000001)(83380400001)(5660300002)(110136005)(54906003)(316002)(41300700001)(7416002)(8936002)(91956017)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(8676002)(478600001)(26005)(2906002)(71200400001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MklPQWlQT2g3cWhESUZhQnUvQU54ZTdTSUk1WWhUV0VpdnBqeTVHSTZIbVRF?=
 =?utf-8?B?eEk0VlMwNThWeEFzTy9LaUNBanRaYWZXTUpIaTVVaC9qaDJtMSt1bEMzZmky?=
 =?utf-8?B?azVMKzd6SUFxQU0rUzl2Uy9uN3BMcjdsK015dWhqME5CS0pWMktUZGxaODBO?=
 =?utf-8?B?b0IweFNBTVNsWkdoRldic3V4bGRIK01vN0JLR0pEcEZ0Q1FOZkN4MXdKVHQr?=
 =?utf-8?B?OWZtNTB2Ui91bmRjM2M4a0xRZStoZUxTMXpqQmNVS2pnN2oxdEk3enF0NWlI?=
 =?utf-8?B?T0JmcEdxVEJBYUEyVHMvTkI1NHp3Z2xBRXliTnAvV1ptMGVSb2RIRHJKeVRy?=
 =?utf-8?B?cFVnUUJyVFZhOWwwaXdJU2VFRGMzSElOaUErZFQ5REtQSlVvWVJIV3g4Q3Y5?=
 =?utf-8?B?SkQ5M0MxYlY1dWtsOTdZUVFGYTduaXE0bE8yc3NjaFp0TjNPR2NYUEtiRXJF?=
 =?utf-8?B?MEc3UCtvRitlT0N3Y1QxelFscnRHanMzQ09wSlRxcXJSbmNmRk5md3hTVm1p?=
 =?utf-8?B?M2RldGtCdC9mQkJvNC9Cb1JyNWU1Tkg1dUlMNnIyNnduUTVWa2Fjc3dUUlQz?=
 =?utf-8?B?Nm9kZXNCQWh3cDNUQzFPcVNBYmpWVnBITkFaRDAvYnRpMUlBZk1wUEE2ckVH?=
 =?utf-8?B?TGtmVHUxNk1uR3JneUhhaVY2VmFKZFZsellKTDJrZDlQZzNLbjhZTzl6RUMz?=
 =?utf-8?B?emdGYTBob0xQQ3hJU0dCRGZJNEhDekdpRVdQNWtnWnVQOHA0bmhUK2IxSjFP?=
 =?utf-8?B?VVBlZjk1YUUxdzVleGhwN1dQY2JJZDFkcVZacWYvRlhZcUFWeVRpRjR2Z0kr?=
 =?utf-8?B?eE5YRDM1SGovZzNYQUlJLzdmWnpWT2d6YncxTjhsdndwWGV1czYvTFJDMUE3?=
 =?utf-8?B?VjdEM283K2pUOHBERXRFTS90bUlqNThDK1U0Z1hSUWxNOGM3Q0lwTDdPbUxw?=
 =?utf-8?B?WGFORDRCUTFCT2NjTXZwWExvcDduTkJIcDN0MzBsVHhRWW1Bd05JZkxZMWJX?=
 =?utf-8?B?N3dGTXdLMW9ZY0lzSloxRWxGeDJxa1ZpQVVaSXZKNXV3UE1xRmtNdlJvS2o0?=
 =?utf-8?B?UVB1bGNrNjNIOTZSMC84R3FSMmQ4em9uRWkxNFg0dmRMWnlleHgwL01oZkFO?=
 =?utf-8?B?bkk1MHVNbHlaRFJUb3B1MGNNMmZWc2tqNm5LQlZSTTBSMjc5eUpRRXVIbk5w?=
 =?utf-8?B?b3JUY0t4cnVNTXhmeFEySVNITE1YcEdwcjJvQ3Q5WW9pSjlCM2JJcEtwcXJn?=
 =?utf-8?B?Uzh4VEVSZTFBVVFVODVISndFdGVsdFNKR3hnZEJ1dDJ0STVRZmpjZXlNZmZm?=
 =?utf-8?B?QTdzUzBweUxxOHJIUzIycGVPK2ZyT1FtMiszZ1hsNUd5cmRPdHRvditYTkRL?=
 =?utf-8?B?Ymc2K04vUVFSREhmdnJQdDY1VkVnSVBIUlR5cnhvOGt2d25obVZyTnA2UWFi?=
 =?utf-8?B?YVE5M01pc1NsWXlMd3pGYkV6VEZjZm1VQW1EUjdsTU9IYXViT1o1Ry9SZWMr?=
 =?utf-8?B?aUpRb2tqTnBzOE82SkNzNDRvRm1LWWRNMCtweElrZmFncEE2VCtXaS94V3U1?=
 =?utf-8?B?YWZabkZnTHcxVmZmRXFjUU5wYkRFYStnSXNaTHVoOTFXbjY2SWF3anUzbEYr?=
 =?utf-8?B?dnhaWVVMOGE5SkNsdWxydDRYS2hYRm45K2kyNE1KRER2MkZyc3ZnVk82RDNu?=
 =?utf-8?B?K0w2bnp6dzZTUGQyVkdPUXA4ZjJWNFdkVytybFBTSlJXY09hMVV5U3J3MElC?=
 =?utf-8?B?TlQ5S0tVYVNpL0FBMEdhQ0lGZ0hSNGRRUU5yL0Q0SUxSbE9FOHJxb3pHMjNV?=
 =?utf-8?B?TThTYnFrYXF0ZCt3dHZ4L0hhays2M3pnMUQrU3Z6a0ZRcSttRzdwRGpRZnA5?=
 =?utf-8?B?a2JGK2pRSjJldVcwZUVOUXRiOS9wamw0c0d6S1J3aTFDRDJWYkNIclhRZ1JE?=
 =?utf-8?B?NVg2U2JyajRZMHUyOXZKVXFDa0ROZkRvQWtwa0RULzlPMS9mM0o4NC9OTm9i?=
 =?utf-8?B?WW1XZ3VWV3d0Nm5DVG5LcFFmT1R1ZkN6dUxPUFBDU2tsQ054N1RDWGdLamI0?=
 =?utf-8?B?YmdmNExvRDJOb0pNMXphMFpFeENGSWVPamZ1RndqQys1ZmpQbzBHYTJzT3hX?=
 =?utf-8?B?cEh0RXlHbHVNOE9keVR6RXU2eFRncUk3N1MxVkJ6cEgxaW12cmM3Zkl5RmhF?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683980CF32817140A4DD98173218CCAC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5490.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2f60c9-4b0c-48f3-1d06-08daa2a8f76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 05:59:41.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lClhaP4Wm8QGBRF5+bVw4SowWRZ0uI91/K+5PuQJOJASJJNQxx9Zt2rtKQq8pAk7DFbew/uJHK6gMBMl8XMIKHzctcsgjYogjz9GmGv1wxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6396
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDEyOjExICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlc2UgUExMcyBhcmUgY29uZmxpY3Rpbmcgd2l0aCBHUFUgcmF0ZXMg
dGhhdCBjYW4gYmUgZ2VuZXJhdGVkIGJ5DQo+IHRoZSBHUFUtZGVkaWNhdGVkIE1GR1BMTCBhbmQg
d291bGQgcmVxdWlyZSBhIHNwZWNpYWwgY2xvY2sgaGFuZGxlcg0KPiB0byBiZSB1c2VkLCBmb3Ig
dmVyeSBsaXR0bGUgYW5kIGlnbm9yYWJsZSBwb3dlciBjb25zdW1wdGlvbiBiZW5lZml0cy4NCj4g
QWxzbywgd2UncmUgaW4gYW55IGNhc2UgdW5hYmxlIHRvIHNldCB0aGUgcmF0ZSBvZiB0aGVzZSBQ
TExzIHRvDQo+IHNvbWV0aGluZyBlbHNlIHRoYXQgaXMgc2Vuc2libGUgZm9yIHRoaXMgdGFzaywg
c28gc2ltcGx5IGRyb3AgdGhlbToNCj4gdGhpcyB3aWxsIG1ha2UgdGhlIEdQVSB0byBiZSBjbG9j
a2VkIGV4Y2x1c2l2ZWx5IGZyb20gTUZHUExMIGZvcg0KPiAiZmFzdCIgcmF0ZXMsIHdoaWxlIHN0
aWxsIGFjaGlldmluZyB0aGUgcmlnaHQgInNhZmUiIHJhdGUgZHVyaW5nDQo+IFBMTCBmcmVxdWVu
Y3kgbG9ja2luZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBSZXZp
ZXdlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAgZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS10b3Bja2dlbi5jIHwgOSArKysrKystLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS10b3Bja2dlbi5jDQo+
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS10b3Bja2dlbi5jDQo+IGluZGV4IDRk
ZGUyM2JlY2U2Ni4uOGNiYWI1Y2EyZTU4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXQ4MTk1LXRvcGNrZ2VuLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
Y2xrLW10ODE5NS10b3Bja2dlbi5jDQo+IEBAIC0yOTgsMTEgKzI5OCwxNCBAQCBzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IGlwdV9pZl9wYXJlbnRzW10gPSB7DQo+ICAJIm1tcGxsX2Q0Ig0KPiAg
fTsNCj4gIA0KPiArLyoNCj4gKyAqIE1GRyBjYW4gYmUgYWxzbyBwYXJlbnRlZCB0byAidW5pdnBs
bF9kNiIgYW5kICJ1bml2cGxsX2Q3IjoNCj4gKyAqIHRoZXNlIGhhdmUgYmVlbiByZW1vdmVkIGZy
b20gdGhlIHBhcmVudHMgbGlzdCB0byBsZXQgdXMNCj4gKyAqIGFjaGlldmUgR1BVIERWRlMgd2l0
aG91dCBhbnkgc3BlY2lhbCBjbG9jayBoYW5kbGVycy4NCj4gKyAqLw0KPiAgc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdCBtZmdfcGFyZW50c1tdID0gew0KPiAgCSJjbGsyNm0iLA0KPiAtCSJtYWlu
cGxsX2Q1X2QyIiwNCj4gLQkidW5pdnBsbF9kNiIsDQo+IC0JInVuaXZwbGxfZDciDQo+ICsJIm1h
aW5wbGxfZDVfZDIiDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGNh
bXRnX3BhcmVudHNbXSA9IHsNClRoZXJlIG1pZ2h0IGJlIGEgcHJvYmxlbSBoZXJlLiBTaW5jZSB0
aGUgdW5pdnBsbF9kNiBhbmQgdW5pdnBsbF9kNyBhcmUNCmF2YWlsYWJsZSBwYXJlbnRzIGluIGhh
cmR3YXJlIGRlc2lnbiBhbmQgdGhleSBjYW4gYmUgc2VsZWN0ZWQgb3RoZXINCnRoYW4ga2VybmVs
IHN0YWdlLCBsaWtlIGJvb3Rsb2FkZXIsIHRoZSBjbGsgdHJlZSBsaXN0ZWQgaW4gY2xrX3N1bW1h
cnkNCmNhbm5vdCBzaG93IHRoZSByZWFsIHBhcmVudC1jaGlsZCByZWxhdGlvbnNoaXAgaW4gc3Vj
aCBjYXNlLg0K
