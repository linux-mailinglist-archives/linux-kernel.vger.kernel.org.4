Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A37326B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjFPFkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFPFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:40:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7F2D40;
        Thu, 15 Jun 2023 22:40:35 -0700 (PDT)
X-UUID: 4d7578980c0811eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wGsNMGAoPg0KXWAkoLALFzzU2dqsJBHPZp3G2HH8FJk=;
        b=OYv2AsISrM50guPssL/PIdiTavT1/2AnQG9CYISdj92bQQUiJib6RVrMC9Hx7XEq4wL4BXfbu5O9LnAH/Bx7zA0HgKvv9rxw1SlWfWXD0h/MVlBciEgh50uy04kdarwTu7e2vTSLLA5bEdD4XlQPskL34zsmFgM8FZZa5aM+Ef4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:f27b0916-2502-4b41-b06b-7842336e39d4,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:023bce3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4d7578980c0811eeb20a276fd37b9834-20230616
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 30118847; Fri, 16 Jun 2023 13:40:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 13:40:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 13:40:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VinGssAFE0z3hVgv3lCWGBVkWTTtBA3nMH9fgdmoJxkrMP/sEEv/xnF3W/8dUn3j5BksZgj+x/2fK0yOEjXTBJ12EvEmhljsS1TtAUt5OeV3sPQ4zskb6eLdhO5IQqxbQx76vhNKIzo4NoLcpYC6X2TcOSU+AOMVBLtcXcRhE5UMaPDVliwV4aOM85OvMPaoPbYG+R21t/Ma/x0MY2aXL9FwszHatNBp0Smy7joynZYHxH5kmGS0LTli9fcD/9Vu1qNoFGiTp4AgaHIEN1EPuyVtbuT8YFFKqCpKBWKzHUeRB0cLp89BRXqaLns721HzdEpWvqq6e0dfNbf6UKEv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGsNMGAoPg0KXWAkoLALFzzU2dqsJBHPZp3G2HH8FJk=;
 b=d9UGn3jXLP3sNSVWlFrUuWDhfXF1Rkv6fQl2ZYcy+seU2+fhdmX2Ki/NXy0g/mH4JwPnZXGqHEgdLnBzrCZr7yrJuQI2fjJMPd39s/1vli5arRl5hsEC+128FTzYbiH0SW/f4KHCpxi+NzVl9BHigzldk0SC6kzpHMYgtxOD6LGQ7A4LNVf1E4KjpCdWCbywkNBatoFO04rP5124uGbRKZBH1Zt2LKIay/D8qsTBqGnCpd7gEI8BuSJzglqQGmf/vwxm+OJd1nySfZepPd/5lkbtlY5lq9zcTvaD4CPjsl3owXXu5+zdyOILSWlVDmBoH3QdYq5LahtrxClWd18veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGsNMGAoPg0KXWAkoLALFzzU2dqsJBHPZp3G2HH8FJk=;
 b=OUVzqjI53pI827xTeuHUsIzLHp4VuPf3DDSytzcdmnB1jOF+kFp0rzdU6K0qqzHB8L2aaQSqj7DdCMBPdMRZnnrCF93iUzCHTWN3nIMd6VHFTSaBEkv1fQw13YhdE73D07KysFK9Z5hQED0n2OmJ2EsY7AKHKPdGkGcaGa8BFGM=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB5216.apcprd03.prod.outlook.com (2603:1096:400:8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 05:40:25 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 05:40:25 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/15] dt-bindings: display: mediatek: padding: Add
 documentation for MT8188
Thread-Topic: [PATCH v2 04/15] dt-bindings: display: mediatek: padding: Add
 documentation for MT8188
Thread-Index: AQHZnpJ3wl876ePz5U6bzzoKDmqHpK+LipOAgAFiYYA=
Date:   Fri, 16 Jun 2023 05:40:25 +0000
Message-ID: <69e6f7d2bfc8082dcafedf6c6b15b00f745d80b0.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-5-shawn.sung@mediatek.com>
         <e720dd96-c77e-6914-873c-6e5b6b5c1ca7@linaro.org>
In-Reply-To: <e720dd96-c77e-6914-873c-6e5b6b5c1ca7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB5216:EE_
x-ms-office365-filtering-correlation-id: 050baf13-173a-48ed-b978-08db6e2c2f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFZquJG86qCtYRGhUqrGaMz3OrpzyYiWudMa5IXzm99OJkioajP47QKUDNE36Lp5l+l8hfXZhu2QDzkd2cMSIaEL7cEQWRNZBGMVUiA5pUK2Y4WPO5NBdtw5LDM3Eapx6YhY25YCr1fKmml7/k1aBDiENEYGsn19shWi32SyjbeCEqLmV+ktgbiU9qzhUrmjw4kuEtH6Bg03OLjDSExPeSwAZyZeAPCJcDV5YUScV7AN6wyeAl72cCb9ENmaoMS+lg8Nq5wKi1428PI+DFRzp58RQ6FxOpS7tOy5PF1ZFUxJ6mc+kBDENJ6QENXgp7WsNetW7XcxFRnFPbjRgAv81/SBFHdIfWTwwUsZktupOZI8AMrd9Za9kXgy5eehMBOAKFVUFVM9cHglTNv+0KQII1ng2KsHJwyLavUaTqKsFTShPWG10LhPH9p5S0mA82238r3z5dB1AohFlZVTz2sv0dgtY4/TL9wnOcFZuPUFrRRf/MxCG6cBVXw6gcWpAHU4OQvxkSM9rGZJE/nOaJVPgjjxmuzlPlQFRSF6AgisZaDTX5VXHOx2tkpkur1azdjB+xmMwOKtIAE1sKYHui+T5qqV+CVmtSDd6+kfQP+z4zGyjbCitZxk4W2gFBcZSBqed+Mja+5Gu/oCGbD9OaSijUKnbm2mlhJ3fNuOuMcEHy5RJ6/P8PEYfY5BSzWHU+yE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(7416002)(5660300002)(71200400001)(54906003)(2906002)(41300700001)(66899021)(8936002)(8676002)(316002)(4326008)(66446008)(66556008)(76116006)(66946007)(66476007)(64756008)(966005)(85182001)(36756003)(110136005)(478600001)(6486002)(38100700002)(53546011)(86362001)(186003)(2616005)(122000001)(83380400001)(6512007)(6506007)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTc5TC9wK2p4cllNWU1iNWtWNkNJUVVBQzhyNy92T2daK3ZyUVR0UU1BaEFD?=
 =?utf-8?B?Zi9DU0FKQjROaE1vV2xBS3hqRUZobStsM3F2Q2JUaWlkQjI1MmtpQUNpVlpX?=
 =?utf-8?B?c0U2RXVGamJjdGJubFFvUk8zSFlURUQ2TW1pbUEzNGVIZFQ4alhXZHFjQmM1?=
 =?utf-8?B?WDA0Wlh3cXVKT0ZIY3k0MHJIMXp2ZTJSTjRzMDdVM0JXdnlvWWxEOUhXbTRs?=
 =?utf-8?B?c29majlBWk13TW5IdHFnclkvN20zMEhUUWpkYmZNenJjL1E5NkNwTFp4Um0v?=
 =?utf-8?B?M2RRQkdJRVlyU29vdWhuVUtmSm1MKzBobUZKNjlqS3JMRW0weUFMNTV4QmJK?=
 =?utf-8?B?OXZuaiszWUhBNWZLNnlLR0dyb0NoYUc1bk1CTERtSkgvN3JVYVhRblEwZWRo?=
 =?utf-8?B?RzVaREplc2tLWDB0WSt6QlBsTXlobzhUVnRycFA3YnRTL1EvK3Z0RjFDSys3?=
 =?utf-8?B?WThlNnpoaXpEZXJacUJsSWdCVEpuZ0NSa0F0c1NyVWRsNnRwT1g3R2R0R2ZT?=
 =?utf-8?B?ZHU1bHYzcHBoMXk5cU9nYzlZL1d6cVB1UGcxNmtrZEtybzlaa1liWkVqeHNj?=
 =?utf-8?B?ZHB3S0FkbmdCYzVsN1RlYmsxckpqMUhSbmJtcGJFT3d4R2VKZlEyNnZpVkhO?=
 =?utf-8?B?MTQrVk5tVGUvcmtTeFdRZEE2NzF0R2IxcWUrcmZPNVNOaDFyVHJuUjBvTE1Z?=
 =?utf-8?B?dThJMlUyR1JndlRDMG42NXhaQWRSSHkyaElRelk3NzNnSy8rTjExVURndGdj?=
 =?utf-8?B?RDY1bVpUblJNcDlLcXRTdEVFaVBNN2pGZEx3MVFDL3FyaEQ0ekdobFV0R0tm?=
 =?utf-8?B?V1RlekZDVXBHQU1TcjNUMFlSKzBJL2FiTG4wUVZ4QmhkSXk2MHpDb2UyZWNI?=
 =?utf-8?B?NzJjS241aitBUHFoSG0ybTlvVEc0dUMxSGxNWW1CajJENWVDSjNMb2U3YlMr?=
 =?utf-8?B?SnRNS2VYbW1mRFBDZFVlSjNZQ0NvSDRlWWRBMFpVZzdRR3FTazlRcFdJNHRU?=
 =?utf-8?B?RE5XY05Qa0lWdGZBUkg3VTBuSXM0c0lxSXNXbklFaDhNc1JQM0dYVng5VXVM?=
 =?utf-8?B?OWsrM1c5eExQTjFCbDFCRlFHcHZZdk1LclRES0FzWFNmWFZzMDFwNmdhYTFa?=
 =?utf-8?B?NnRUUGJ4R3dOcXVhTXRwSElsd2RYRVYrdnJDMHJJK3h3ZWlqTDdDc3pCRHJ0?=
 =?utf-8?B?Q0dmSGtneHlEamFCUjRrNXIrdkF3Yjg0eWYzS3hXb1d6dnJBdlNxdjd4M1FL?=
 =?utf-8?B?dUlZVlpMWXdiNmhDVUFRN094SWRkVThBdTRUNy9PVmNINkRXNUhtYlU5dHVl?=
 =?utf-8?B?bFpXZnRCZlc5Zy9sb0o1azFYNzFrTlFhQndjK0tPRGQ5cDkzVUdWRVY1K1Nv?=
 =?utf-8?B?S1czOG1hdWdFeGR3Z09Bd05ZSFRidHZBL1BRRWZjTXp4MDJMNWhaWmVmM2My?=
 =?utf-8?B?dVN2bVN5Ym5XOXNENE1yekduK2hyTFBWc3h6SlhzRTB3R1BjcFp6a1o3NGU3?=
 =?utf-8?B?dVBtbmVCTUVpMFlnZEZ2bUMxc1MzcWhtYlhUT3ppdHpMMGw4TGlIQTFZVzBT?=
 =?utf-8?B?RThOTGgrekJHQm1TL05FR0tVZ1pKTEE3K2pOZWMrellWdVNRa2lJcVZTTE9o?=
 =?utf-8?B?Q2pxNnBiTGtYVHdQM1ZOUVJMNDBxek5jV3JJbGVIY3o2RHdKdEFRRWxEajNZ?=
 =?utf-8?B?SGhjaEdZN1lwcU44eUhxM2U1cEpsdndYYTdxeDNRYXFzUEFMRTNJTWRhZzQv?=
 =?utf-8?B?NzRoTGdrMHJlbkIycko4TWJFNzJsNCtNL0RxeFREYnEzUGZzZkpha1llNzRU?=
 =?utf-8?B?RVBJeFQ1RFRtOE12YTBMb1BEaWJ6V3ovNUt1UWE5QnI2SlFQcTRFZ0x2YW5X?=
 =?utf-8?B?OGhKVmJRMC9YQit4WUl5ZU5NN3ZVNVNkVEhWU3lYSkJLWFhYRG1nYldkL1Yz?=
 =?utf-8?B?RWc5Rk5VeThHUXVtTmx5NDluZXBDT0FTTk9kRnZWUDIxV1JxMGUxdW0rcWlZ?=
 =?utf-8?B?OHBIRnpQV21kZkVkWjVHUFBITjdnTDcwejhvY0p1dTk4YnNGMkNBTUt2eWcy?=
 =?utf-8?B?TWlEVHlZZ3NXQnVLQlh2TjQzMnlSN3NOajdOaGhGTis3RGZ6Slk2emJGVm5u?=
 =?utf-8?B?U2V3ZVA1bU1xTG4wd2ZvaFFUUWxUYmpwNjFFOW9raWhOcXQra3dUUExmU3R0?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <845B475F1DBAD043A2222AEDE9752E3B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050baf13-173a-48ed-b978-08db6e2c2f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 05:40:25.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USeP4uAMe84dqFfoQjdr27IvYbMedN4C0NsyISWjQg/5IKbjELB4WYfnVvWeVyyzadPPDWxbhjbsZR2YjOJR+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpHb3QgaXQsIHRoZSBuZXcgdGl0bGUgd2lsbCBiZSDigJxkdC1iaW5k
aW5nczogZGlzcGxheTogbWVkaWF0ZWs6IHBhZGRpbmc6DQpBZGQgTVQ4MTg44oCdLg0KDQpTaW5j
ZSDigJxQQURESU5H4oCdIGlzIG5vdCBhbiBhY3JvbnltIGJ1dCBqdXN0IHBhZGRpbmcsIGluIHRo
aXMgY2FzZSBpcw0KdXNlZCB0byBwYWQgb3Igc3R1ZmYgcGl4ZWxzIHRvIGxheWVycywgSeKAmWxs
IGNoYW5nZSBhbGwgb2YgdGhlbSB0bw0K4oCcUGFkZGluZ+KAnSBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KDQpGb3Ig4oCcTWVkaWFUZWsgRm9vIEJhciBQYWRkaW5n4oCdIHN1Z2dlc3Rpb24sIEkgY2hh
bmdlZCBpdCB0byDigJxNZWRpYVRlaw0KRGlzcGxheSBQYWRkaW5n4oCdLCBob3BlIGl0IGNvdWxk
IG1ha2UgbW9yZSBzZW5zZS4NCg0KVGhhbmtzLA0KSHNpYW8gQ2hpZW4gU3VuZw0KDQpPbiBUaHUs
IDIwMjMtMDYtMTUgYXQgMTA6MzIgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gMTQvMDYvMjAyMyAwOTozMSwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90
ZToNCj4gPiBQQURESU5HIGlzIGEgbmV3IGhhcmR3YXJlIG1vZHVsZSBvbiBNZWRpYVRlayBNVDgx
ODgsDQo+ID4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGRvY3VtZW50YXRpb24gZm9yIGl0Lg0K
PiA+IA0KPiANCj4gQSBuaXQsIHN1YmplY3Q6IGRyb3Agc2Vjb25kL2xhc3QsIHJlZHVuZGFudCAi
ZG9jdW1lbnRhdGlvbiBmb3IiLiBUaGUNCj4gImR0LWJpbmRpbmdzIiBwcmVmaXggaXMgYWxyZWFk
eSBzdGF0aW5nIHRoYXQgdGhlc2UgYXJlIGJpbmRpbmdzIGFuZA0KPiBkb2N1bWVudGF0aW9uLg0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscGFk
ZGluZy55YW1sICAgIHwgODENCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgODEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscGFk
ZGluZy55DQo+IGFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxwYWRkaW5nDQo+IC55
YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWsscGFkZGluZw0KPiAueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zOTBhNTE4ZmEyY2YNCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWsscGFkZGluZw0KPiAueWFtbA0KPiA+IEBAIC0wLDAgKzEsODEgQEANCj4g
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxwYWRkaW5nLnlhbWwj
DQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIFBBRERJTkcNCj4gDQo+IE1lZGlhVGVr
IEZvbyBCYXIgUGFkZGluZw0KPiANCj4gUGxlYXNlIGV4cGxhaW4gd2hhdCBpcyB0aGlzLiBQQURE
SU5HIGRvZXMgbm90IGxvb2sgbGlrZSBhY3JvbnltLiBJZg0KPiBpdA0KPiBpcywgZXhwYW5kIGl0
Lg0KPiANCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQ2h1bi1LdWFuZyBIdSA8
Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+ID4gKyAgLSBQaGlsaXBwIFphYmVsIDxwLnphYmVs
QHBlbmd1dHJvbml4LmRlPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgTWVkaWFU
ZWsgUEFERElORyBwcm92aWRlcyBhYmlsaXR5IHRvIFZET1NZUzEgdG8gYWRkIHBpeGVscyB0bw0K
PiB3aWR0aCBhbmQgaGVpZ2h0DQo+IA0KPiBFeHBhbmQgdGhlIGFjcm9ueW0uDQo+IA0KPiA+ICsg
IG9mIGEgbGF5ZXIgd2l0aCBhIHNwZWNpZmllZCBjb2xvci4NCj4gPiArICBTaW5jZSBNSVhFUiBp
biBWRE9TWVMxIHJlcXVpcmVzIHRoZSB3aWR0aCBvZiBhIGxheWVyIHRvIGJlIDItDQo+IHBpeGVs
LWFsaWduLCBvcg0KPiA+ICsgIDQtcGl4ZWwtYWxpZ24gd2hlbiBFVEhEUiBpcyBlbmFibGVkLCB3
ZSBuZWVkIFBBRERJTkcgdG8gZGVhbA0KPiB3aXRoIG9kZCB3aWR0aC4NCj4gPiArICBQbGVhc2Ug
bm90aWNlIHRoYXQgZXZlbiBpZiB0aGUgUEFERElORyBpcyBpbiBieXBhc3MgbW9kZSwNCj4gc2V0
dGluZ3MgaW4gdGhlDQo+ID4gKyAgcmVnaXN0ZXJzIG11c3QgYmUgY2xlYXJlZCB0byAwLCBvciB1
bmRlZmluZWQgYmVoYXZpb3JzIGNvdWxkDQo+IGhhcHBlbi4NCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODgt
cGFkZGluZw0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsN
Cj4gPiArICBwb3dlci1kb21haW5zOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4g
KyAgY2xvY2tzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFJE
TUEgQ2xvY2sNCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssZ2NlLWNsaWVudC1yZWc6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgR0NFIChHbG9iYWwgQ29tbWFuZCBFbmdpbmUpIGlz
IGEgbXVsdGktY29yZSBtaWNybyBwcm9jZXNzb3INCj4gdGhhdCBoZWxwcw0KPiA+ICsgICAgICBp
dHMgY2xpZW50cyB0byBleGVjdXRlIGNvbW1hbmRzIHdpdGhvdXQgaW50ZXJydXB0aW5nIENQVS4N
Cj4gVGhpcyBwcm9wZXJ0eQ0KPiA+ICsgICAgICBkZXNjcmliZXMgR0NFIGNsaWVudCdzIGluZm9y
bWF0aW9uIHRoYXQgaXMgY29tcG9zZWQgYnkgNA0KPiBmaWVsZHMuDQo+ID4gKyAgICAgIDEuIHBI
YW5kbGUgb2YgdGhlIEdDRSAodGhlcmUgbWF5IGJlIHNldmVyYWwgR0NFIHByb2Nlc3NvcnMpDQo+
ID4gKyAgICAgIDIuIFN1Yi1zeXN0ZW0gSUQgZGVmaW5lZCBpbiB0aGUgZHQtYmluZGluZyBsaWtl
IGEgdXNlciBJRA0KPiA+ICsgICAgICAgICAoUGxlYXNlIHJlZmVyIHRvIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvZ2NlLzxjaGlwPi1nY2UuaCkNCj4gPiArICAgICAgMy4gT2Zmc2V0IGZyb20gYmFzZSBh
ZGRyZXNzIG9mIHRoZSBzdWJzeXMgeW91IGFyZSBhdA0KPiA+ICsgICAgICA0LiBTaXplIG9mIHRo
ZSByZWdpc3RlciB0aGUgY2xpZW50IG5lZWRzDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQo+ID4gKyAgICBpdGVtczoNCj4gPiAr
ICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogcEhhbmRsZSBvZiB0aGUg
R0NFDQo+IA0KPiBQaGFuZGxlIChpZiBmaXJzdCBpbiBzZW50ZW5jZSkgb3IgcGhhbmRsZS4gSXQn
cyBub3QgYSBwSCB1bml0LiBGaXggaXQNCj4gaW4NCj4gb3RoZXIgcGxhY2VzIGFzIHdlbGwuDQo+
IA0KPiANCj4gPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBTdWJzeXMgSUQgZGVmaW5lZCBpbiB0
aGUgZHQtYmluZGluZw0KPiA+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IE9mZnNldCBmcm9tIGJh
c2UgYWRkcmVzcyBvZiB0aGUgc3Vic3lzDQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogU2l6
ZSBvZiByZWdpc3Rlcg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
