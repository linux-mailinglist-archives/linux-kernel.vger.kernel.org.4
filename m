Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF84607302
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJUIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJUIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6449748FE;
        Fri, 21 Oct 2022 01:54:29 -0700 (PDT)
X-UUID: d5b5cfee04f845ffb85c84871d57acb8-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jlKiy33C4tj5c5tD/Or+tfkcZWel3i7n9hrVhkq8etc=;
        b=VCQcz8ucrcfcgY2l1yDg54DgtB4Eu3xXtrkQT6G5bDTSvooaG6o8g2mTHT0pF4RxXj/s8y8oAK00mmq24A3ultTdsDG4wVrf74Y2NLvMNOlpvmFbc92YLA1C5ViSHjFFz4wEkmVpmnpBcqsZj8pAbLyh/t/CC5GBFobkO/h6N18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:659c9366-2fc6-4f4c-82d4-33064750b4de,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:fa74ad6c-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d5b5cfee04f845ffb85c84871d57acb8-20221021
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 76478563; Fri, 21 Oct 2022 16:54:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 16:54:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 21 Oct 2022 16:54:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPz7hKCpSZJjo/JuyMgmwt0cey5QSDUHTJ0WUmENTSn/kwwdZfrUOnRsq8AYyfTwHmtJrvGuCVYB0nlZC++yELGfQSMthYLiT9urAA+ChFAjUDfgbv/rrzv/g3+DCRqJsAVVq/00/dzEwg0zqakpSPdOiyorP0ANeUaNpVjXHTzxplKx3aK974sM/Uptv/NUxfkBdP1Uqk7Eu8Sv8Ff9nqTnlQjW4xrNLTpIq0n2zTivfCkaHep9yVgz3t+6JMEgKqR+3W9NGS279xvs7Cok6NDxUrLZjVjkW1t22pXYncbGY+44y/hhIoEoe/C9b48jDtRa5j6qE1myIeqhuW0aTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlKiy33C4tj5c5tD/Or+tfkcZWel3i7n9hrVhkq8etc=;
 b=U9k4x92zi04ZTI6iZSQmG7T7Ca2M9THXBy8XYr11rfOzJeKbMdpWlgCaI9P2xWHmDtrbHrbFYiAv50ZtaOCxFuJSeGF2GWrD1QgP7+GH/GVGd29u2jPPFxJro3XOX0QAF7JMdZ4W98awpU7QnAgcgDpgd4bs72+wR35qLQG0WDNWPwlV1ebcX4Gk0W3z51TTHCtCmK2b/o11X/Vbqhe+wWNobXtNMab23p84zO7UiOTfLo5Mfz/pZe3H0pCKkAFcRLY88ywPsQSZ4HnhcbtI5UewYkwFwx5cEfPG5kUSim/lMFbZlO1kKRAAJNObdLQ+fVmc0OD1v29CBFvuqpeDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlKiy33C4tj5c5tD/Or+tfkcZWel3i7n9hrVhkq8etc=;
 b=G2HqUcPATDP+WLRqgLPBcwY1cQLPCpLrSnGPz9tmk4UxNkaWVhtP4agxCK3Ai7b1DpMj51iVDCGu/hXfjRHRE8EvusTFsL6gpl+QsOTfBLvMWv/ynbfR2asmOl7x4Up6bRwzV/qqKokzgvNCxOzGarY9LXiNOT05nV7/bkNOTN0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5695.apcprd03.prod.outlook.com (2603:1096:400:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.18; Fri, 21 Oct
 2022 08:54:09 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45%5]) with mapi id 15.20.5746.017; Fri, 21 Oct 2022
 08:54:08 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Index: AQHY1Nz5OA9S/sIRuESL8yXlzp3JUa3844KAgAPMLoCAF/vyAA==
Date:   Fri, 21 Oct 2022 08:54:08 +0000
Message-ID: <cf5195154f44fba92f829fc68fbb7c5a6daf6d7a.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-13-trevor.wu@mediatek.com>
         <20221003163851.GA2414624-robh@kernel.org>
         <e96ef77f007f66f883f8dca86d1206cd1b5a767a.camel@mediatek.com>
In-Reply-To: <e96ef77f007f66f883f8dca86d1206cd1b5a767a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5695:EE_
x-ms-office365-filtering-correlation-id: a85fb963-d3bb-447a-de8c-08dab341d10d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ycFUzfeSFuuKKUtPXnPBeYx5GfRyg7hAe5GiA3y2D0ZP9CFQatrdbXtUXLmNmbTr+nI+kxg1HtPRx8EQ6agnPAF6LRSn/2gsjnb2Qi7o9LTxgXpa5FGh87F2HJCIxupSQzVSLFYvmwEHBZtKD2ultgdSeJJS2dhgOHC3v/iLZgYyrDQFx1JaMwx+F7GuPsfdQwhfsuHxsW5kVw8w2dhzrP0lp1zAT3s771KkSlnlOl1NMO8us0G16HpcEifJDyjrDFnE0OKHlZKj71xxult0n4ZgxsdB0xpmC1VdQUAOGCYhGtZ8SnFNrzZZLeNOdzZ3uTdw9nmBwC2UYKm0pl6J6vONt2HgYEX7NyJRZZw1EXFTv3vc8FDF2YiP+jAe+9GFtzLSkfGG8uveyq/tm39GIMWGfGx5W6mqJKm2/lKh5HaE3BUKGNhnPmhL/Z+kWJTRdxuOF8ukzqZauSym4EOqjbOGxRGbPS4bD7uo8jStVMRVdrKPGvUMVh30Lxxx3zpYJ7Q1CeSFpQiOjWdhUS4lB/qEJ9p02gLd+LVcjO/u106t2114yT0BrdTGBE3j1WFJvrkAc9bxxM9F/lLFj8QEM8f0ELUJY+FPBjp02IJbXtG0f+TKsGdM3C/NSzeRt71tAlr+t8y3/lRgYGRK1wBRd0zVZR/pA2o+4nL91ZU6QieN69fLOm6UezvVhY/l/XW4hRtPsGlOngVQgBkBKp3r4cVEWJe0pyoSVuocrbykkFv371PxwrfTv7sSS8n1Xm+Eq+MnEAfbbkslB6HekG6CmXLb/vUfEBci3T9ay1xulmG86zyO8BHgpHj5MlC7oti96EO/2Iqgjy8Kbd8df6jNe3dMVjQXFsMkY5LH9IyebFmvIOShDmhYwTR8Jkf+v/yRtbaAmlLSBi3Yp0pcWGo1Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(316002)(54906003)(6916009)(8936002)(76116006)(26005)(64756008)(2616005)(186003)(2906002)(66946007)(5660300002)(7416002)(66476007)(66556008)(6512007)(4326008)(8676002)(66446008)(86362001)(85182001)(91956017)(41300700001)(6506007)(478600001)(36756003)(966005)(71200400001)(6486002)(122000001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk4rVjMvN1U5RngrRVI1VGZ5cUErMFAxUlZwS2tJS2d1anBnVFJmaVg2YXJC?=
 =?utf-8?B?VjJNbjNiNjBIREVDT0ZZNm9XTHJ2MWx1cnBuU1EyL3JNQTg3Qk8zSVk5MnpR?=
 =?utf-8?B?S0pPY2xQOWtRZjg1eUlydWFSN0docGZKUGpQdDR3TmsrV09BaDFTMGlqWmNh?=
 =?utf-8?B?Yk1INC9qY3l2UHdNRkhPYnlndkprSDNobjNtTE1UY0FIeVVzQ0NLNm9Vczdt?=
 =?utf-8?B?dlV3b2krSXkzSXlpVFFlU0dUS0V1MS9DYlZkUVF0Q2ZyeWpaQzJsUC9RV0Fz?=
 =?utf-8?B?NGlHbFNiUjR4aG1jdUt0b2hwWit3L1RjRlc5UWt2NitEODlQVytvbmR2VmtW?=
 =?utf-8?B?VFVTUm5MSmVGb3ROUENVZ3lvS3FmOE9YdGhlaXpFVkJYcVRGbmRlZk9acUVh?=
 =?utf-8?B?a1U5am9TcFJEZFFEN1l6aTNKOE4rSmcrN0xoZmxhSkx6dHQwSHhMUElhQ251?=
 =?utf-8?B?a0YwaC9IVDh0QTRIbEZWcjNyWGl3aDdYLy9wOWY1T2ZvVzdqUkhzRnRHQlVT?=
 =?utf-8?B?UDJNTzRiemcxOWNDVC9XRDNicWtsa2hLeHk5TEUraU1zQitBK01ia2NqRGRx?=
 =?utf-8?B?Qmxkd3U0eU9kRjRzRWNDRlpaMVVzNksxK0s3RXUvWVNvVld0WkJ6VmlhTGJw?=
 =?utf-8?B?eEJJYWU2STVuem9EV3ZQdkJ0cWdzL2k1aGdFdGdHNThuZ09Zc1Y5WTFzQS9p?=
 =?utf-8?B?dEZ4ek1VZTViWFNJd1JMbWcrbmtJdkZVK1JHWWI4NWFRZ1YyZ2txeDV4MTFH?=
 =?utf-8?B?N05YQkJjaTRORjZ6THU2aFNTVSthN3BQMXZRZDhiY3RMQzF6YnJsaXd4RzdV?=
 =?utf-8?B?NzBacTJTK2pqdDRiSysrSVM2eXo5eUlGM0FTRlIxSkY3WHE1RGZkM2o4WFRK?=
 =?utf-8?B?UGVWS28zbTh3SFpLRWxOdTRPbHdPQXRzME5hUk1kcHQ0ZHB2Si9Kby8wVjJS?=
 =?utf-8?B?dUtGOGJkR0c5Qnl5UkVNZGt3cDEyeGtCNjBsdGdQVXJoRllOZEI5SlRIVk1I?=
 =?utf-8?B?UER3OHRwaUVzaFhZZ25nZktWY0dacC9HemxES2tJcFVUeVpsRFVUTlpHZ2ZD?=
 =?utf-8?B?blZUdVJwdUNpQ1pZMTlDNmVrV0tQeE5tTEZ3MnJCMUptUnYvRG9FWUFZbnlH?=
 =?utf-8?B?ako3Q1krSDhOOVZYM2c2ckU4Rk5YSWVYOWU0dHJWRWFhcThJakR3L1Q5MU5I?=
 =?utf-8?B?S3owM0JXNGpSTTdJVzErMzFYTUZpajM0RlNCb0xva0JNaVNQd0QyM1FaUmEr?=
 =?utf-8?B?QUpxajM0dUFHN3ZKZWtsWkhDeUllM0VNazlQV1R0T09zWGt2aDF4QjFwcjRZ?=
 =?utf-8?B?M1RwR0FxK25acklTSjdrdkFlc0JXajlzZVZkUEtwdUNTR0FYV0IrYTNQQnBC?=
 =?utf-8?B?MGJWNFg2VHBnTEN0d0tsL0l2d1BFSDlOd1V3UWVSK0drbTl1VHNhblYzT3Ns?=
 =?utf-8?B?WWk0eHo4SWxldkpjbnRtZWFnSXM5K3hFUE1BUlNWNENIbDA2eUlnVVYxM3NL?=
 =?utf-8?B?QnNvbDNqWVNNb3ZHeVRORWhqcWRPU0gyVmtXTng3aXc0bjlYanFTbEpRV1pY?=
 =?utf-8?B?MnpJUlBvN09WSjhPMGhFSWxZb0JEdDRkTXNkTkRZbzd3N1YvbkZSRUFxQTQy?=
 =?utf-8?B?L1hlN0lWRmRHZEpJczZmQVJjTlVHRDR4ZGVNenJNajVWL2hkdEZFNVdNWnA3?=
 =?utf-8?B?RzNEZlNydlZieElVbWNwWDNKamtjQUc5dDZnKzdicUxJR2p2NGZUQWhuci92?=
 =?utf-8?B?YmFkdWsvaEIyaUh5UlZQaVBQelMvaVIzTkg0ZGkyclhqaXh6NStnM2hHOGIr?=
 =?utf-8?B?eTZBdkw1T3o5eE5Od0tMZlE2UFJFSGgyUlJGWmkzelB5RkNxRkZqekpWYkMz?=
 =?utf-8?B?RGpRUTFnUEhwWUZpOUtjQ0RLL3B6UmpReHNUUDVyTXY0WnMvQW1ETW02MjFx?=
 =?utf-8?B?OTV5aklvdXl1TmVvNGJlOWtoQ3JsdG1KSDQrNFc5ZFYxMU9zWmlJWlZyZnlC?=
 =?utf-8?B?dmdvREVvQm5Ma2RtL3R0VG5jKzl4UUVtMHNYVlZKS0NjNEpUbkpBYUI1TENq?=
 =?utf-8?B?NktTZkxMRXVvSVh2bFhjNUl0L21CeENVZFcvQkZ0bmwxS0N4cHAvZG0vT0U5?=
 =?utf-8?B?V0FsZWQ3TDNJQWpQU09jdXc4QURLMlFtd0RGOFoxa2p6V3ZHaWN6VlgvT0Uw?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D63F977699A097488180E0560C004CCA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85fb963-d3bb-447a-de8c-08dab341d10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:54:08.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcRR/0VDhd2Xp/RsW/gNoLnjWkIOIEwGvmzssLFSQX5qoFMgKVQsbAXhkW2DSlala464MKQTdZfRTbhDZ4gECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5695
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTA2IGF0IDEwOjM4ICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6DQo+IE9u
IE1vbiwgMjAyMi0xMC0wMyBhdCAxMTozOCAtMDUwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4g
T24gRnJpLCBTZXAgMzAsIDIwMjIgYXQgMTA6NTc6MDFQTSArMDgwMCwgVHJldm9yIFd1IHdyb3Rl
Og0KPiA+ID4gQWRkIGRvY3VtZW50IGZvciBtdDgxODggYm9hcmQgd2l0aCBtdDYzNTkuDQo+ID4g
PiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9zb3VuZC9tdDgxODgtbXQ2MzU5Lnlh
bWwgICAgICAgICB8IDcwDQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtDQo+ID4g
PiBtdDYzNTkueWFtbA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC0NCj4gPiA+IG10NjM1OS55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC0NCj4gPiA+IG10NjM1
OS55YW1sDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi41N2M3YzVjZWVmOGENCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtbXQ2MzU5LnlhbWwNCj4g
PiA+IEBAIC0wLDAgKzEsNzAgQEANCj4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ICslWUFNTCAxLjINCj4gPiA+ICst
LS0NCj4gPiA+ICskaWQ6IA0KPiA+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbXQ4MTg4LW10NjM1OS55YW1sKl9fO0l3
ISFDVFJOS0E5d01nMEFSYnchd01jNkkyYVhSekk0NVVQUVRFQXpVNFp1alY2VmFpRkdraUtCeTE4
QV81RGxRZWhUeFUwMHUxUVNwaU96Z0FnS3RBJA0KPiA+ID4gIA0KPiA+ID4gKyRzY2hlbWE6IA0K
PiA+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyF3TWM2STJhWFJ6
STQ1VVBRVEVBelU0WnVqVjZWYWlGR2tpS0J5MThBXzVEbFFlaFR4VTAwdTFRU3BpTVNLUFdidFEk
DQo+ID4gPiAgDQo+ID4gPiArDQo+ID4gPiArdGl0bGU6IE1lZGlhVGVrIE1UODE4OCBBU29DIHNv
dW5kIGNhcmQgZHJpdmVyDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAt
IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtkZXNj
cmlwdGlvbjoNCj4gPiA+ICsgIFRoaXMgYmluZGluZyBkZXNjcmliZXMgdGhlIE1UODE4OCBzb3Vu
ZCBjYXJkLg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxl
Og0KPiA+ID4gKyAgICBlbnVtOg0KPiA+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNvdW5k
DQo+ID4gPiArDQo+ID4gPiArICBtb2RlbDoNCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nDQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBVc2Vy
IHNwZWNpZmllZCBhdWRpbyBzb3VuZCBjYXJkIG5hbWUNCj4gPiA+ICsNCj4gPiA+ICsgIGF1ZGlv
LXJvdXRpbmc6DQo+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL25vbi11bmlxdWUtc3RyaW5nLQ0KPiA+ID4gYXJyYXkNCj4gPiA+ICsgICAgZGVzY3JpcHRp
b246DQo+ID4gPiArICAgICAgQSBsaXN0IG9mIHRoZSBjb25uZWN0aW9ucyBiZXR3ZWVuIGF1ZGlv
IGNvbXBvbmVudHMuIEVhY2gNCj4gPiA+IGVudHJ5IGlzIGENCj4gPiA+ICsgICAgICBzaW5rL3Nv
dXJjZSBwYWlyIG9mIHN0cmluZ3MuIFZhbGlkIG5hbWVzIGNvdWxkIGJlIHRoZQ0KPiA+ID4gaW5w
dXQNCj4gPiA+IG9yIG91dHB1dA0KPiA+ID4gKyAgICAgIHdpZGdldHMgb2YgYXVkaW8gY29tcG9u
ZW50cywgcG93ZXIgc3VwcGxpZXMsIE1pY0JpYXMgb2YNCj4gPiA+IGNvZGVjIGFuZCB0aGUNCj4g
PiA+ICsgICAgICBzb2Z0d2FyZSBzd2l0Y2guDQo+ID4gPiArDQo+ID4gPiArICBtZWRpYXRlayxw
bGF0Zm9ybToNCj4gPiA+ICsgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3BoYW5kbGUiDQo+ID4gDQo+ID4gRG9uJ3QgbmVlZCBxdW90ZXMuDQo+IA0KPiBIaSBSb2Is
DQo+IA0KPiBXaGljaCBvbmUgYXJlIHlvdSBleHBlY3RlZD8NCj4gMS4gcmVtb3ZlIHRoZSBsaW5l
DQo+IDIuICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4g
DQo+ID4gDQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgxODggQVNv
QyBwbGF0Zm9ybS4NCj4gPiA+ICsNCj4gPiA+ICsgIG1lZGlhdGVrLGRwdHgtY29kZWM6DQo+ID4g
PiArICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlIg0K
PiA+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgTVQ4MTg4IERpc3BsYXkgUG9y
dCBUeCBjb2RlYw0KPiA+ID4gbm9kZS4NCj4gPiA+ICsNCj4gPiA+ICsgIG1lZGlhdGVrLGhkbWkt
Y29kZWM6DQo+ID4gPiArICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlIg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgTVQ4MTg4
IEhETUkgY29kZWMgbm9kZS4NCj4gPiA+ICsNCj4gPiA+ICsgIG1lZGlhdGVrLGRhaS1saW5rOg0K
PiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9zdHJpbmct
YXJyYXkNCj4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgQSBsaXN0IG9mIHRo
ZSBkZXNpcmVkIGRhaS1saW5rcyBpbiB0aGUgc291bmQgY2FyZC4gRWFjaA0KPiA+ID4gZW50cnkg
aXMgYQ0KPiA+ID4gKyAgICAgIG5hbWUgZGVmaW5lZCBpbiB0aGUgbWFjaGluZSBkcml2ZXIuDQo+
ID4gDQo+ID4gTmFtZXMgaGF2ZSB0byBiZSBkZWZpbmVkIGhlcmUuDQo+ID4gDQo+IA0KPiBPSywg
SSB3aWxsIGFkZCBlbnVtIGhlcmUgZm9yIGxpc3RpbmcgYWxsIGF2YWlsYWJsZSBkYWktbGlua3Mu
DQo+IA0KPiBUaGFua3MsDQo+IFRyZXZvcg0KPiANCj4gPiA+ICsNCj4gPiA+ICthZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCj4gPiA+ICsNCj4gPiA+ICtyZXF1aXJlZDoNCj4gPiA+ICsgIC0g
Y29tcGF0aWJsZQ0KPiA+ID4gKyAgLSBtZWRpYXRlayxwbGF0Zm9ybQ0KPiA+ID4gKw0KPiA+ID4g
K2V4YW1wbGVzOg0KPiA+ID4gKyAgLSB8DQo+ID4gPiArDQo+ID4gPiArICAgIHNvdW5kOiBtdDgx
ODgtc291bmQgew0KPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgt
c291bmQiOw0KPiA+ID4gKyAgICAgICAgbWVkaWF0ZWsscGxhdGZvcm0gPSA8JmFmZT46DQo+ID4g
PiArICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gKyAgICAgICAgcGlu
Y3RybC0wID0gPCZhdWRfcGluc19kZWZhdWx0PjsNCj4gPiA+ICsgICAgICAgIGF1ZGlvLXJvdXRp
bmcgPQ0KPiA+ID4gKyAgICAgICAgICAgICJIZWFkcGhvbmUiLCAiSGVhZHBob25lIEwiLA0KPiA+
ID4gKyAgICAgICAgICAgICJIZWFkcGhvbmUiLCAiSGVhZHBob25lIFIiLA0KPiA+ID4gKyAgICAg
ICAgICAgICJBSU4xIiwgIkhlYWRzZXQgTWljIjsNCj4gPiA+ICsgICAgfTsNCj4gPiA+ICsNCj4g
PiA+ICsuLi4NCj4gPiA+IC0tIA0KPiA+ID4gMi4xOC4wDQo+ID4gPiANCj4gPiA+IA0K
