Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01615645664
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLGJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:24:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6E1A38E;
        Wed,  7 Dec 2022 01:24:31 -0800 (PST)
X-UUID: c0c925d32b7d43c5b6391cbb4bdc01ed-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2p61UMh/SbjMcq1OEp4FgMt7FSlXQQDCdbRB66yksWc=;
        b=eV/502OCXNsVjYk2jUC+uMJOOCDsjSuh1/1FD529ICQ+eGAQ25J0b/UoLAYtkZq/xRzvuXv3wDAREXV3DMVeCsmZ9LHfMiRyYSR2V8yhE1aSPbDu+mn3MMfuf/JybC1TyKDTz++w5tmLs1coRDH7PL2aiwcXSj/wG+UuOw5oy/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d086bbab-d3a2-4e32-b49c-41d15e0138ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:d086bbab-d3a2-4e32-b49c-41d15e0138ac,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:204c9224-4387-4253-a41d-4f6f2296b154,B
        ulkID:221207172427WS0P2UHG,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c0c925d32b7d43c5b6391cbb4bdc01ed-20221207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266604630; Wed, 07 Dec 2022 17:24:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 17:24:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 7 Dec 2022 17:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKeGELITH4VLhborFZbnIauWbpA8g6Ur3+1X774ssAPRukPablrze1FwJZ4HCPIbgQTRJ21ga3CMD0Zkl7uzs8Xyyr04VCjUxN8RFTNNcy4ErQ2jT28fibMzxWwQ1DCH5uQvRBw956CdZkJm5aJMCCjlEeGNjoU7mMSRPywEnOok1z4EaDl018PMVrJIasSTsuuLHLh9g/KBSquVU9Fu5C9IrV5wnXLNOYjzWQumUPC1lBw7Cj/x+IN2i8zAUShPXUbjX6hlLsh8O71AdkMWhVQlejupn//DrBKGcHzTwx8soktkR1tGi3yGZYStKX4nFixcQSELUzLZt4omLZ29Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p61UMh/SbjMcq1OEp4FgMt7FSlXQQDCdbRB66yksWc=;
 b=TCqsD406MZTm3wL5PT8RjNkTn15Qwz7SLBVbSNwN4hlZLdyVdQYS9Vb89zoKos1qTTJyYwTh3iK4qKyk3MHCaxXZ2KFEJnei9iQ2IrQ8d0gBGO+Jd520x0/++j+jOe6dge60eB4F4ZrkNEb8L6+wdnaQ4P+w1RpQ7L/ADGUh9X4npGMXYI8hg+e03p5llLidQOECxvd9kBWt2zU017DYWJxO3qkq1GfeqLSJ8c0YYvlPXcUbuVfy8T0QOXOO7x2FLuCHYDnm2qFTHw/GmBexsU/GeQP8qgujkCLpYpXrHttLxwyCgXgCNkzPLm/jUOyKLND+v+Jx8XEWqKgVVcq8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p61UMh/SbjMcq1OEp4FgMt7FSlXQQDCdbRB66yksWc=;
 b=nBBapxRGEWw/a4/HKnahBBpjRGScDaP338VATyHO90g57rhdSqx8PGR/VrQx3JPZ/91rBnyMoo2thNgYy/n7Hl0wn5728tTJUlOiRLylXQm+55gaTe9qceQu1pp9P06hGqmLwUw7N6R0yKhcvgs2+rLSbehFACyxkXGCplM3Kww=
Received: from PSAPR03MB5494.apcprd03.prod.outlook.com (2603:1096:301:77::13)
 by SI2PR03MB6784.apcprd03.prod.outlook.com (2603:1096:4:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 09:24:20 +0000
Received: from PSAPR03MB5494.apcprd03.prod.outlook.com
 ([fe80::f5bf:e3ab:e51c:c276]) by PSAPR03MB5494.apcprd03.prod.outlook.com
 ([fe80::f5bf:e3ab:e51c:c276%5]) with mapi id 15.20.5880.013; Wed, 7 Dec 2022
 09:24:20 +0000
From:   =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>
To:     "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        =?utf-8?B?UGVuZyBaaG91ICjlkajpuY8p?= <Peng.Zhou@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: fix device management cmd timeout
 flow
Thread-Topic: [PATCH v2 1/1] scsi: ufs: core: fix device management cmd
 timeout flow
Thread-Index: AQHZCExEKkLI5oxz602f0jL0nxwQEK5ftScAgAJysgA=
Date:   Wed, 7 Dec 2022 09:24:19 +0000
Message-ID: <5be85d35baab205d236652b4edae6cacf658a669.camel@mediatek.com>
References: <20221205014202.2672-1-mason.zhang@mediatek.com>
         <20221205195050.GA15334@asutoshd-linux1.qualcomm.com>
In-Reply-To: <20221205195050.GA15334@asutoshd-linux1.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5494:EE_|SI2PR03MB6784:EE_
x-ms-office365-filtering-correlation-id: 4082e078-66f7-4578-c59f-08dad834d219
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvmBRtltRxyNDcJ0Zhf5EctQ+28Vvc6g6tZUYUIqb+KCLdUG1JgG1CghuVBI0vdYPcYOuo9S5LXAI2GgrX9kqJ0MKbJ4CzomD/7mCdPUWZbB/I9GJOO5sLBD+9gpc5gI/F47zEiSa2SgwO94NtuhQuYnX5btm6XXZVP71MFNoX6qGAaKCZYm8e5jt38QJThZU3oXiXktDHuiPDFLlEslWHGUTYxHZleBA7SJN3Ecj4lcSYEgU68fkZ5g1d8N/52OcTaJEKuEQkO/yBvGyKQYjoBgou9kxojoeyp42YPEMisfXdigxgElkPK1MfO6GAaW2HXusmeAqJwoGOoQF1y52E0M3dGhENMMfuhP1VHF+pnuv2clR7xRpwnrWL96JBzVmYvfTLCk6i5NlqxDzC5YOMpNSAbHwqFcq8K+iL+L/qQJMG+jJKHyqO0sIC7t2dYU5VCBFNWb6hfaw4YuJJ+snShYVWTxcMkoPqY1xLIKIo6nBnzoTDyJ8PKiVgQHt7a0iwsX4y9wuI8ITbW+kCCXGz2M3wFY3hGa16rg9in+3dqG35INC2SJWP3pdJDM07/h9/kh6XnIPysBimdp75mVPPZta5TTDqjeYbJXTVXjFXsTj4IyS9RYcjSqYhgoPakKCR6w4B7ghw2ixY1tCGlMB+vnG5Qz73VS9M3H2SwKs1SE5OgyCS0tIZcQL/CDIrr14eYYeWzc3pP8ul78GW9mzERP2Gu1wQqx+mYZ9zKunZA09nbN3kUA6D8NiRr+YpBF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5494.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(85182001)(38070700005)(6486002)(36756003)(86362001)(38100700002)(54906003)(6916009)(316002)(478600001)(5660300002)(71200400001)(7416002)(2906002)(91956017)(66446008)(64756008)(66476007)(4326008)(8676002)(66556008)(41300700001)(76116006)(8936002)(66946007)(83380400001)(122000001)(186003)(6506007)(6512007)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNVTDE2NmlJZjdaelRUNHptNklhUFpCYVpoRHFrVzFtN1pkY1pEWGVIKzY2?=
 =?utf-8?B?WHFQcnBBYVRydWlqeWlCemxvNWNCc0hVSkptS1RaaW5Ga1lGR1c0dGhzZ3Vq?=
 =?utf-8?B?bDg0dXNiM01TME5TY3dBUDFIYlEzODhwWnl0c3NDN25kTEpCYmg1bHZFemFr?=
 =?utf-8?B?c1pYOHltWkZrakVYdkRBVm9oeFV0YmxWRCtBYkZKRWdUVGpDc1Fhd3hELzlW?=
 =?utf-8?B?cFhCOXp3VjF5QXl4akNNelpsbFJsU0Y1TWZ4aEMxdmJYYmxzdDlMOXlHVlBQ?=
 =?utf-8?B?aEZIb2w4RUNNMEdoQndUOUJpV2x4dnErSG4yZVJoZGEvWnNOd3VMR0Rub09y?=
 =?utf-8?B?eWpzc3hPMWxZMHlVc3BYYVNwZ2JvbEl1V281VE5SMG9mVTRCcC9xeVI0RUtH?=
 =?utf-8?B?d3NHMzVVZXhxS0Fab0UrODVRS0U4Yk9NaUh4RG5sdTY4NlBiQkdYSU1wRVFp?=
 =?utf-8?B?WFp2cFpJNk92YzNieHNsRWswN3NkYjkyVThocHRnQnZObGFMeEhzWVV6Mnpj?=
 =?utf-8?B?MWxURERMQ0tZMTF3MjVNNi96dmdFQUtMY3R0dFJQcjExdDBqbi9DOW1KamFn?=
 =?utf-8?B?VitMekY4OHhSSWh3bE9WcWYycHJ5d25OSFcyUnFPZnRDQVFuOUU4RnY4STFQ?=
 =?utf-8?B?MHR5L3Mxdyt4Z1ZwUVY1Tml5N2dUSTNrNU1DUkFjNmF0ZS9oamIrU0ZQRDQx?=
 =?utf-8?B?NXUrQUJNMTFpQWU2SE5vR29KeEhlV0plWGpCc2xhaElvdWhueW5EckU0cGhK?=
 =?utf-8?B?c00rS29CRWVRcFpxUWpBRWhqVWRFMGw1M256UFVxUjBUQU82VnRKSDdRdWtM?=
 =?utf-8?B?N3Fwbzl2VjlSZk03MG4vclB5ODRaSUY5OVFxMy9uVkZ2eVg5NFRuU3p5cUpv?=
 =?utf-8?B?Qml6Tk0yVngyVkU5em5LNm80clhoR1dZQ0dUSE15QmI5R2tZM2x4WEJCMzAx?=
 =?utf-8?B?UUJQOTlBWHRTU2wxV25LTzZibE9vaU9xU2ltR09Qd0N0a3ZHdnlIenNCV0JH?=
 =?utf-8?B?aHpOSWxRcTVxRVBLREJaTnhhOEQzTmNub255WktYc1phUUtOZ0Z4QW5HbVVN?=
 =?utf-8?B?MXlUTWxwdzZlOUhRNSt1MVlsOTQ0VTdIaVNkUkk5S3VQNmRuMnFyYnBQNnVn?=
 =?utf-8?B?bjdRK2pUVDAzVmVjT1ByZlBBYmRVZkV4KzljVWVGaDQ3N0xmOTI0RlplR284?=
 =?utf-8?B?eStjSG1XODB1OEp4OVNmQ2JGamVCWWgzcDRqV0ZoMDFCeWdKTjlaVms1cnJw?=
 =?utf-8?B?U1dCOEc1d1MvRFd1aU5KSGhyRnd3enZPc2NHZmpxZ2JucmRPYW1tMk4xNEhV?=
 =?utf-8?B?bkczZ0wwNStHcVZLTStsSC90b29IUmpqc3NEVzcxdzhqQ1doeGpHYUg3Q2tN?=
 =?utf-8?B?ZzQvRUZKWDFOTmcwbHRhNFE2YWQ1YncwaVNrN2ppT21VM01qbkVMandSd1N2?=
 =?utf-8?B?WGZqNWh5SlU4QklFZlpLclhycEJwcUxyOFBEaURGMld6Mi9QdXNkVTZXQnd6?=
 =?utf-8?B?RVZhMVpJT3JKL242bmZ0eU80RzZUR2Y0K0xTSjZYanFzelhBcWYydHcyVlFq?=
 =?utf-8?B?Nnc1MXRJaEQrSWpiUTBSbnVSTkloZzY4bXJMYklVNU5VaWJzYnA0UlA2SkJ1?=
 =?utf-8?B?K0FNYjlybkg0R1ZSTXhuRVRZSy8yZmhrb1JTS2dweUFIemNBa292V0gzVGZw?=
 =?utf-8?B?dVdIaHY4RHBNR0o3UUs5NUl6dC9xeFROZUd1MXM0N3llR2lVU1l0Yk1zRCt5?=
 =?utf-8?B?RGo2czVuaHBldTB1dXhaYnM4ZDRVQSs1UU1wR2Ywa1d4MkQ4b1hVMkErd29B?=
 =?utf-8?B?OVF1akFlZW5raXlzNU1ZdlVKZFp4dXJIUnVBV05JL2NJRThTVEFmRnZ2Q3Rw?=
 =?utf-8?B?NFJXZ2JNdVd1WGZrNVljYXJqS1JJazJLNk1ldGJiUHVKUm9XenNOOW9GVElV?=
 =?utf-8?B?SW9uUDZJVUV4UUlKWGhVS3RjSVJYRHIraTRnc0d5YnNubGo1ZTYzcTBwTVd2?=
 =?utf-8?B?MWxEaEt6ZSs2dDRpWmxHUm4xZkFOMC92TXVjV3RlQll2eEFyS0g4VEFSbXZZ?=
 =?utf-8?B?SHEvaWhiTzVvZmJXTVFWSDF1ZUwvQndCMUNLZ3AydDcwZDF3S2Z3eFZidXk0?=
 =?utf-8?B?VFEwYWg0bEJ3MGQ5RVJ4Vm1tV2QrVW13YXpnOEtwWW5FR0tKdURnRFZhMkxx?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F92DCA18A865384DA86D0D380757FC40@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5494.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4082e078-66f7-4578-c59f-08dad834d219
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 09:24:20.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWLspxPdajWvqVFKTO3oPefB27R/qvFggRSuBzNoZXSX0kvS6o6CVVd7apLWoUBdi/qHXCXxzM2aw1nH0c/RKJeL0Q4s0kdEOvXEveouxL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTA1IGF0IDExOjUwIC0wODAwLCBBc3V0b3NoIERhcyB3cm90ZToNCj4g
T24gTW9uLCBEZWMgMDUgMjAyMiBhdCAxNzo1MyAtMDgwMCwgTWFzb24gWmhhbmcgd3JvdGU6DQo+
ID4gRnJvbTogTWFzb24gWmhhbmcgPE1hc29uLlpoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBJbiB1ZnMgZXJyb3IgaGFuZGxlciBmbG93LCBob3N0IHdpbGwgc2VuZCBkZXZpY2UgbWFuYWdl
bWVudCBjbWQoTk9QDQo+ID4gT1VUKQ0KPiA+IHRvIGRldmljZSBmb3IgcmVjb3ZlcnkgbGluay4g
SWYgY21kIHJlc3BvbnNlIHRpbWVvdXQsIGFuZCBjbGVhcg0KPiA+IGRvb3JiZWxsDQo+ID4gZmFp
bCwgdWZzaGNkX3dhaXRfZm9yX2Rldl9jbWQgd2lsbCBkbyBub3RoaW5nIGFuZCByZXR1cm4sDQo+
ID4gaGJhLT5kZXZfY21kLmNvbXBsZXRlIHN0cnVjdCBub3Qgc2V0IHRvIG51bGwuDQo+ID4gDQo+
ID4gSW4gdGhpcyB0aW1lLCBpZiBjbWQgaGFzIGJlZW4gcmVzcG9uc2VkIGJ5IGRldmljZSwgdGhl
biBpdCB3aWxsDQo+ID4gY2FsbCBjb21wbGV0ZSgpIGluIF9fdWZzaGNkX3RyYW5zZmVyX3JlcV9j
b21wbCwgYmVjYXVzZSBvZiBjb21wbGV0ZQ0KPiA+IHN0cnVjdCBpcyBhbGxvY2VkIGluIHN0YWNr
LCB0aGVuIHRoZSBLRSB3aWxsIG9jY3VyLg0KPiA+IA0KPiANCj4gV2hhdCBpcyBLRT8NCj4gDQo+
ID4gRml4IHRoZSBmb2xsb3dpbmcgY3Jhc2g6DQo+ID4gIGlwYW5pY19kaWUrMHgyNC8weDM4IFtt
cmR1bXBdDQo+ID4gIGRpZSsweDM0NC8weDc0OA0KPiA+ICBhcm02NF9ub3RpZnlfZGllKzB4NDQv
MHgxMDQNCj4gPiAgZG9fZGVidWdfZXhjZXB0aW9uKzB4MTA0LzB4MWUwDQo+ID4gIGVsMV9kYmcr
MHgzOC8weDU0DQo+ID4gIGVsMV9zeW5jX2hhbmRsZXIrMHg0MC8weDg4DQo+ID4gIGVsMV9zeW5j
KzB4OGMvMHgxNDANCj4gPiAgcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDJlNC8weDNjMA0K
PiA+ICBfX3Vmc2hjZF90cmFuc2Zlcl9yZXFfY29tcGwrMHgzYjAvMHgxMTY0DQo+ID4gIHVmc2hj
ZF90cmNfaGFuZGxlcisweDE1Yy8weDMwOA0KPiA+ICB1ZnNoY2RfaG9zdF9yZXNldF9hbmRfcmVz
dG9yZSsweDU0LzB4MjYwDQo+ID4gIHVmc2hjZF9yZXNldF9hbmRfcmVzdG9yZSsweDI4Yy8weDU3
Yw0KPiA+ICB1ZnNoY2RfZXJyX2hhbmRsZXIrMHhlYjgvMHgxYjZjDQo+ID4gIHByb2Nlc3Nfb25l
X3dvcmsrMHgyODgvMHg5NjQNCj4gPiAgd29ya2VyX3RocmVhZCsweDRiYy8weGM3Yw0KPiA+ICBr
dGhyZWFkKzB4MTVjLzB4MjY0DQo+ID4gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDMwDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFzb24gWmhhbmcgPE1hc29uLlpoYW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiBkcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIHwgNDYgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tLS0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiA+
IGluZGV4IGIxZjU5YTVmZTYzMi4uMmI0OTM0YTU2MmE2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5j
DQo+ID4gQEAgLTI5NzksMzUgKzI5NzksMzEgQEAgc3RhdGljIGludCB1ZnNoY2Rfd2FpdF9mb3Jf
ZGV2X2NtZChzdHJ1Y3QNCj4gPiB1ZnNfaGJhICpoYmEsDQo+ID4gCQllcnIgPSAtRVRJTUVET1VU
Ow0KPiA+IAkJZGV2X2RiZyhoYmEtPmRldiwgIiVzOiBkZXZfY21kIHJlcXVlc3QgdGltZWRvdXQs
IHRhZw0KPiA+ICVkXG4iLA0KPiA+IAkJCV9fZnVuY19fLCBscmJwLT50YXNrX3RhZyk7DQo+ID4g
LQkJaWYgKHVmc2hjZF9jbGVhcl9jbWRzKGhiYSwgMVUgPDwgbHJicC0+dGFza190YWcpID09IDAp
DQo+ID4gew0KPiA+ICsJCWlmICh1ZnNoY2RfY2xlYXJfY21kcyhoYmEsIDFVIDw8IGxyYnAtPnRh
c2tfdGFnKSA9PSAwKQ0KPiA+IAkJCS8qIHN1Y2Nlc3NmdWxseSBjbGVhcmVkIHRoZSBjb21tYW5k
LCByZXRyeSBpZg0KPiA+IG5lZWRlZCAqLw0KPiA+IAkJCWVyciA9IC1FQUdBSU47DQo+ID4gKwkJ
LyoNCj4gPiArCQkgKiBTaW5jZSBjbGVhcmluZyB0aGUgY29tbWFuZCBzdWNjZWVkZWQgd2UgYWxz
byBuZWVkIHRvDQo+ID4gKwkJICogY2xlYXIgdGhlIHRhc2sgdGFnIGJpdCBmcm9tIHRoZSBvdXRz
dGFuZGluZ19yZXFzDQo+ID4gKwkJICogdmFyaWFibGUuDQo+ID4gKwkJICovDQo+IA0KPiBEb2Vz
IHRoaXMgY29tbWVudCBzdGlsbCBob2xkIHRydWU/IFBlcmhhcHMgdGhpcyBuZWVkcyB0byBiZSB1
cGRhdGVkPw0KPiBBbHNvLCBwZXJoYXBzIHlvdSBtaXNzZWQgQmFydCdzIGNvbW1lbnRzIGluIHYx
Lg0KPiBBbHNvLCBwbGVhc2UgY2FuIHlvdSBhZGQgYSBzZWN0aW9uIGZvciBjaGFuZ2VzIGZyb20g
djEgLT4gdjI/DQo+IA0KPiAtYXNkDQo+IA0KPiA+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZoYmEt
Pm91dHN0YW5kaW5nX2xvY2ssIGZsYWdzKTsNCj4gPiArCQlwZW5kaW5nID0gdGVzdF9iaXQobHJi
cC0+dGFza190YWcsDQo+ID4gKwkJCQkgICAmaGJhLT5vdXRzdGFuZGluZ19yZXFzKTsNCj4gPiAr
CQlpZiAocGVuZGluZykgew0KPiA+ICsJCQloYmEtPmRldl9jbWQuY29tcGxldGUgPSBOVUxMOw0K
PiA+ICsJCQlfX2NsZWFyX2JpdChscmJwLT50YXNrX3RhZywNCj4gPiArCQkJCSAgICAmaGJhLT5v
dXRzdGFuZGluZ19yZXFzKTsNCj4gPiArCQl9DQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmaGJhLT5vdXRzdGFuZGluZ19sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJCWlmICghcGVu
ZGluZykgew0KPiA+IAkJCS8qDQo+ID4gLQkJCSAqIFNpbmNlIGNsZWFyaW5nIHRoZSBjb21tYW5k
IHN1Y2NlZWRlZCB3ZSBhbHNvDQo+ID4gbmVlZCB0bw0KPiA+IC0JCQkgKiBjbGVhciB0aGUgdGFz
ayB0YWcgYml0IGZyb20gdGhlDQo+ID4gb3V0c3RhbmRpbmdfcmVxcw0KPiA+IC0JCQkgKiB2YXJp
YWJsZS4NCj4gPiArCQkJICogVGhlIGNvbXBsZXRpb24gaGFuZGxlciByYW4gd2hpbGUgd2UgdHJp
ZWQgdG8NCj4gPiArCQkJICogY2xlYXIgdGhlIGNvbW1hbmQuDQo+ID4gCQkJICovDQo+ID4gLQkJ
CXNwaW5fbG9ja19pcnFzYXZlKCZoYmEtPm91dHN0YW5kaW5nX2xvY2ssDQo+ID4gZmxhZ3MpOw0K
PiA+IC0JCQlwZW5kaW5nID0gdGVzdF9iaXQobHJicC0+dGFza190YWcsDQo+ID4gLQkJCQkJICAg
JmhiYS0+b3V0c3RhbmRpbmdfcmVxcyk7DQo+ID4gLQkJCWlmIChwZW5kaW5nKSB7DQo+ID4gLQkJ
CQloYmEtPmRldl9jbWQuY29tcGxldGUgPSBOVUxMOw0KPiA+IC0JCQkJX19jbGVhcl9iaXQobHJi
cC0+dGFza190YWcsDQo+ID4gLQkJCQkJICAgICZoYmEtPm91dHN0YW5kaW5nX3JlcXMpOw0KPiA+
IC0JCQl9DQo+ID4gLQkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhiYS0+b3V0c3RhbmRpbmdf
bG9jaywNCj4gPiBmbGFncyk7DQo+ID4gLQ0KPiA+IC0JCQlpZiAoIXBlbmRpbmcpIHsNCj4gPiAt
CQkJCS8qDQo+ID4gLQkJCQkgKiBUaGUgY29tcGxldGlvbiBoYW5kbGVyIHJhbiB3aGlsZSB3ZQ0K
PiA+IHRyaWVkIHRvDQo+ID4gLQkJCQkgKiBjbGVhciB0aGUgY29tbWFuZC4NCj4gPiAtCQkJCSAq
Lw0KPiA+IC0JCQkJdGltZV9sZWZ0ID0gMTsNCj4gPiAtCQkJCWdvdG8gcmV0cnk7DQo+ID4gLQkJ
CX0NCj4gPiAtCQl9IGVsc2Ugew0KPiA+IC0JCQlkZXZfZXJyKGhiYS0+ZGV2LCAiJXM6IGZhaWxl
ZCB0byBjbGVhciB0YWcNCj4gPiAlZFxuIiwNCj4gPiAtCQkJCV9fZnVuY19fLCBscmJwLT50YXNr
X3RhZyk7DQo+ID4gKwkJCXRpbWVfbGVmdCA9IDE7DQo+ID4gKwkJCWdvdG8gcmV0cnk7DQo+ID4g
CQl9DQo+ID4gCX0NCj4gPiANCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCkRlYXIgQXN1dG9z
aCBhbmQgQmFydDoNCgkNCglUaGFua3MgZm9yIHlvdXJzIGNvbW1lbnRzfg0KDQoJSSB0aGluayBp
ZiBjbGVhciBkYiBmYWlsIGFuZCB0aGVuIGNsZWFyIG91dHN0YW5kaW5nX3JlcXMgaXMgbm90DQph
IHByb2JsZW0sIGJlY2F1c2UgaXQgbWVhbnMgY21kIGlzIHNlbmQgdG8gZGV2aWNlIGJ1dCBkZXZp
Y2Ugbm90DQpyZXNwb25lZCwgc28gaG9zdCBzaG91bGQgZG8gZGV2aWNlIHJlc2V0IGFuZCBjbGVh
ciBhbGwgb3V0c3RhbmRpbmdfcmVxcw0Kb3IgcmV0dXJuIGVycm9yIGFuZCByZXRyeSwgaXQgYWxz
byB3aWxsIGNsZWFyIHRoaXMgb3V0c3RhbmRpbmdfcmVxcy4NCglBbmQgYmVjYXVzZSBvZiB3ZSBo
YXZlIGRvIHRlc3RfYml0IG91dHN0YW5kaW5nX3JlcXMgZmlyc3QgaW4NCnNwaW5fbG9jaywgc28g
aXQgYWxzbyB3aWxsIG5vdCBoYXZlIHJhY2UgY29uZGl0aW9uIGJldHdlZW4gY21kIGNvbXBsZXRl
DQpmbG93Lg0KDQoJQW5kIGFib3V0IEtFLCBLRSBtZWFucyAna2VybmVsIGV4Y2VwdGlvbicsIGJl
Y2F1c2Ugb2YgY29tcGxldGUNCnN0dWN0IGhhcyBiZWVuIHJlbGVhc2VkIGluIHN0YWNrLiANCglB
bmQgSSB3aWwgcmVtb3ZlIHRoaXMgY29tbWVudCBpbiBwYXRjaHYzLg0KDQoJVGhhbmsgeW91IGFn
YWlufg0KDQpUaGFua3MNCk1hc29uDQoNCg==
