Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998365732B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiL1GXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL1GXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:23:19 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FEBE0D;
        Tue, 27 Dec 2022 22:23:18 -0800 (PST)
X-UUID: ab5d8b1fade24b098ad59042b102c900-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Uewp3Atuwr8dCyVijKRqsgT54Obv/rRnEX1SJ6yN98c=;
        b=chf0/xI8pvda//5w/huJHRrwIdgCcvo/k1aSJ+VNCXeZ4vxV7REjcta/F410M+fCb37xK3d5L2wIRxDBOG0n0blTqNOqUODehxSUNjye8cMQu8h4ww9gNaM1h1yLbfEX4f/xeArw76C2BRpMWkw7uT7GwCyjPOIDlnHixs8KT+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:99bbfb66-79a0-4e27-8b38-e9442dfd07c8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.14,REQID:99bbfb66-79a0-4e27-8b38-e9442dfd07c8,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:dcaaed0,CLOUDID:fa419b8a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2212281423123IWFT4GI,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ab5d8b1fade24b098ad59042b102c900-20221228
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 478611870; Wed, 28 Dec 2022 14:23:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Dec 2022 14:23:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Dec 2022 14:23:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3xWPJv2w8qPSaJfp2oxOJqvhe1y7xlASqv/1XI+xTHoMehCZhO2yPSVKbsMof1bfhw9swy0Pf+DxsmIt0xLjM6uyAt0vmVuSyUNIw2IhRCPTvAqjJD/8bsVbcwLZGIyG1IX73dIC7LoVmXFzj0UHD9IOtXOxf0qkq9bTK7tnxuHjh2NC+lfd+36zxfzsgX9I4E7MkCdq4OCWM8Pi6hXsnaBAjYkQJhW+/G+tPVTcFYR1PHdlkUkGHCzCpbsglCkocu918lGbO318a4KDl70mkrwF8Cv5bZAKIIXUNFiLIf7aDQ5b8l7sQB5f6/zl2fkUvXV7/K92HfLtF8cKpTwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uewp3Atuwr8dCyVijKRqsgT54Obv/rRnEX1SJ6yN98c=;
 b=gmImPX0havs8W1Y6RVSOuFQf37xY5q9D/4i42NfT+lSWnoDK4RaEhVJJQBZf4/Mtxevc9BDi5ipJP7EPT7fjXiYSBfWfjxbtTzgAKkcsQjhYrSV4baHOwaqTq85sUnh2NzND2FA/U5nTUp7NPvN7sZa3t7MYKjNv7mxwEK6CfKqNQp/zdejwAdBsYUA5QXS7NLczooOUXA4bl8cLJVdfzAO4AnxKzbV8MacA4VQbJ3Sncg0eqnwhaeKX5RYUgHJZ2ZgR7C6P4zWWwI5MmHHTqrBNULGWv+Obm0uQytshaT7nZ/Nwgy9ij+2jKVKgeSSL38tdeJSxXPlFayu3LQuLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uewp3Atuwr8dCyVijKRqsgT54Obv/rRnEX1SJ6yN98c=;
 b=Tvs3n1WR6UhBNKC0+kz2KlbYabBKGlQUMqOWgt45Ri1/GTzkxunyKQZfdt0SpCxG6y+LEfaJFTkQacitBbuNRJfP7tAyG20/wfCHZtjs6v3AYO3iZEfrahKYomWZFkzlabeA6gT334O37BFBwf1aWMugF4cU5ZHm+OB0mtJXxf0=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by KL1PR03MB6921.apcprd03.prod.outlook.com (2603:1096:820:bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 06:23:06 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 06:23:05 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v5 2/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Topic: [PATCH v5 2/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Index: AQHZFnEj0/EaWOPbYkOR3i4YitclJq57M++AgAeo3IA=
Date:   Wed, 28 Dec 2022 06:23:05 +0000
Message-ID: <be254cc7a21c2ccd91230c085e9180cd0684ef94.camel@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
         <20221223015029.24978-3-biao.huang@mediatek.com>
         <d7c50228-5d4e-8c73-28b3-4950917708a0@collabora.com>
In-Reply-To: <d7c50228-5d4e-8c73-28b3-4950917708a0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|KL1PR03MB6921:EE_
x-ms-office365-filtering-correlation-id: 31547b73-5976-406f-8e90-08dae89bfaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZJCILFTl8PK7lSZI7KLHDiqY15lbkOdzh7mKSBKXQetzVX/FZgmtuANjQUgs8UDmvRt18WATYD8sYIIgUkkmIi9/bQEcGvb9otn2q5IHEsjFonaXyhTrvgowsH7AE64lzfOhbEvzMHaBrq4aDG6g4ctYvviuwD8RwEb+9ihExw7APs+YYdiHhPeU5BY7cA9P6gBzD06aDkFsoCElauC/OAxyQcl78RdlDyoNQMx8Rcx96MidloPOjoy9m6G367NS/okxNcGgb77VIm0Eh7zFLcgmKXi7f3sWieWbhL3gtKBBgl7r75Pa1DdFGp0mKcsiz0AJrsaMuC1dS/5pWcnwV9eWNyBkTKBJ71XPmAp+p4/awIk2bejP1Ld5iPIZ09TB4S8GaMdeCGXpG3/Ik6UXkyR0F2t2oGWTYVe0QMWrfZ8fLCa4+9eZ25Gn0ozI9SpI2XCRUYJLeRIykqoYTTAiITcH2IyukAUiUorgOh3k2XDoHC1ewciVvDpF7G9ANnGVqT+ou8YMGer51LV/RgEAsCH/1FgplUDew0M4pI3sJWSzulA3sdVChN8D4HpbQ6dDRhMqqmLO583V4p3KebS0j0p6LyhMmQ/fxTE5Qm4PxSaw93AhWcB8xFH80kNmvlV4QlXvoUaboTjG+RvoFF/ScZtkn6+QSlPzJh9Cws3zLhdg7x8UdEYzFYQb49GmsHVhrMjek95x/t/e2sW+m+6avD/2ZV+FOlTtf63oRVmtnoNXqwI6Wk3Qw/CL9dMaDDv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(6506007)(122000001)(38070700005)(91956017)(5660300002)(186003)(26005)(6512007)(38100700002)(2906002)(316002)(7416002)(558084003)(4001150100001)(110136005)(54906003)(478600001)(85182001)(36756003)(6486002)(86362001)(71200400001)(41300700001)(8676002)(64756008)(4326008)(8936002)(2616005)(66446008)(66946007)(66476007)(66556008)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3BLL3JRbHR4UnBRTmRjSG9pTXNzN1hYbjhHZlAxREJqeWtXTWx1MzRXaTND?=
 =?utf-8?B?RkE5L1hza1ZOYk1Oczh0dVIyVXhNS0RseUpQT3RNWEVwbVNyMFp6R24waXB6?=
 =?utf-8?B?WTNuUEI0YzhPTG1zejgwS1dnRFlSNk5iRnZsVEZ5eXRwbkphU3NWQXFia0dM?=
 =?utf-8?B?SVJra242Uk1PRklDK1hRYnVyOXRlZ3h5R29hL1Y1OWtLdFVXTXlZRGlNN0tz?=
 =?utf-8?B?YW92czY1Y1djdXVQaWJaemNjdEQ1L05OVStpdVpBLzNHT1orWStZR3BRa05O?=
 =?utf-8?B?QlllVUxkdk5SUUlTZ2s1ZHUyUjBYem1UK0ZPanl2MVdBbEEyNURJaVNGcGN3?=
 =?utf-8?B?WjZaMjRhN0I5alhCVVIxcmxISXc1dkYraHZCbnBMYVN6MzdtWURRbXRQd2kx?=
 =?utf-8?B?TUtzZ2ZIak5FeGIxd3EvS29sSWN5VEViUnhGc0VMNFltTUs4R1pWOEhOR1ph?=
 =?utf-8?B?TUE2blgzMDlONEdvemNJWGVqWnFhbXAzR3lVaHRJT3VKQzFsRkd6YUNiMjYx?=
 =?utf-8?B?RVJUTDdSL3pYYkVrd0lDdjVYWmE4T2p5YWhHK3VZUzlXZHc1Ynl6TDJzZmdJ?=
 =?utf-8?B?VWdCS0xPZGRQeFVIOEhMWThSbEtRWFdjbTVJZk1yQk40WGJ0Qk1iY3p2b0Yw?=
 =?utf-8?B?a255cS9ORVF2TnZLOWhjMkY1N01HWjlWQVhUUVphM2xLM0R4TStMdFh2Ynho?=
 =?utf-8?B?eWg1UTdzSlIrb2NvYUNYQW16V1pzRnlSTGZPb0FOS3YzU1p3bXEvZ1JUeWdM?=
 =?utf-8?B?amZBZmJBTld1V1hQY2Y4K0JxN0VBdGp0b3VLTkRvWW9XcXI3NENSNEVYeEJQ?=
 =?utf-8?B?TXpVeDJQTk12YnFrcjdwQlBOTFllS0hERCt6QlIrd2x0ZkM2Q3I4Z2ZjUWo1?=
 =?utf-8?B?bkpVdW5xMDNlRGJ5QVN3Z3lIZHd5ZkpTSE5oMW5ZYmFDRXFqaGZlQUtlaGZr?=
 =?utf-8?B?ME5Hc3NDRmFpZnVveUZkN1ErcjFvU3MwdDFWQkMrSEhqVjZEOEZON0FWNVE5?=
 =?utf-8?B?NW5wWWNYVTIwcnZlcXJJTENlVDh4Z2xqY0U5NmRhQkZja1IzYWNSLytVd0pj?=
 =?utf-8?B?UnZpbmdadnBiYkNtSE16eU1HalE5K2IxQTNTaDllNjZFbGVCTTArOVQ1bTd1?=
 =?utf-8?B?V3Y1Z2Via2k5cW1NdVJiYXdaai9Ja1hhWTlFU2kwRDlneFNnY2pqZXlPMmV6?=
 =?utf-8?B?b21HelczRXZDU09tQUJPRWVFSHk2TUZQTnJ2eWpqaE1JSm03aFNHSXVoTU54?=
 =?utf-8?B?L3lDTnAzWnhZV2JIUWN5eTBjZWpKTDRXd1hQWUpPMTdQVVJENyt3eDlKdFg1?=
 =?utf-8?B?N0dOWjl0QVZKT2o1WlNKMyt0UzJZTDJuU2hZWU1iazN4VSsxUFBLVTVnV3Ra?=
 =?utf-8?B?U1pNdEM4K3ZySkJQOFhrOUcyUG5GWTRqU29NYTltMW1hdGpGcDlvVUF6bTBX?=
 =?utf-8?B?Szkxc1prYThQYnRLMThYUzhWOGhMMnZUUysxc1NmbDJscG95UG9lUmh1bkRh?=
 =?utf-8?B?ZzZoUDd1QXBaOWE3UjlxN0hPSGF5VG5BSFFsbk1ZekdTaldCZlZiUlhBUU5z?=
 =?utf-8?B?Q3F5by9PL3lZb2pBYlFEV3hmVnpuMGw1VDlVL2w1bXBJNWQ0bEVsQVpWY0wx?=
 =?utf-8?B?aE5jSXcxRlFKZ2VRQ1lDamUrNEhlZHBncnZBbzlGWU4zQyt6enBjZDR2cFhD?=
 =?utf-8?B?RmFZN1RuOVU2b2lsSkV4YzJPL1Z6L1ZiV3Q2dWZ1Q0pselhLaXhld21EaU9M?=
 =?utf-8?B?VXhDM2tmMzBSLzlwazd2RURsTXB0SDd6cmZDMExyZWQrak5aYWlsc1I0MjRp?=
 =?utf-8?B?cFM2cW9QR0RpNnFLRUxoemUvL2FseXBvbURGcGQwK2xUZFhxWEtlY0hjYVNQ?=
 =?utf-8?B?bVh4SngybVNINTd1NTUwYTBweFZxWXl1NFFCTlQrOGRvWFNtQzZmdlgzVm82?=
 =?utf-8?B?VnozdjkzK1M2cUVFKzhYRityNDU4UzdhS1pUaFhxei9uNDlySVE4RW1PUzhY?=
 =?utf-8?B?ajJYN1djaklHbDV4b3NQenpROUZHZHAwUEo3TjdKb2ErdkNnNzloOTBJZnZo?=
 =?utf-8?B?NURPcG93YWdXN01aRGptN0hDcER5VHYzbGFBSmtOakpWYVp0QkIxT3loNWh5?=
 =?utf-8?B?Uzg2RFYvUXlkNXNoTGZ0UDJSVTVmZDR6WUo2bE5ubXhReVU4U0UyZ3V0RDNY?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930E71C9B2792F438FF80F63A1E74863@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31547b73-5976-406f-8e90-08dae89bfaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 06:23:05.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJzqgicYCq5KgzBX4qke5onBIi0R+6pIx8OsN8poDRu47+RkPXHkoIe0cHjWXZq8lg9ru4sV4NyrLZfdofgksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG8sDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzfg0KDQpPbiBGcmksIDIwMjIt
MTItMjMgYXQgMTA6MjQgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0K
PiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQpXaWxsIGFkZCBpbiBuZXh0IHNlbmQuDQoN
CkJlc3QgUmVnYXJkcyENCkJpYW8NCg==
