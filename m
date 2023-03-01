Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4886C6A65FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCAC7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCAC7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:59:20 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7475BA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:59:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/aSr4V6ws7QguYEF405zJ+R4Shtvadj1yCdEZVzBAHY9HvZg4/ERae7lo3nxsGLx0204OZB/JbXhAFaAOR+mGe8ucQbG/kC8dufxVsHczd4x6USzshBR6MMFPO9FPYnK0omAAd0r8F9R263yFmrkoID6n3hF/jGE7dfM0M64Nl7KBbRqvPqLJy06UT8QA0RQKWxPmNDjKqHuKKhvw3rT2vPx0ojE7RdCD1omJqPya9exNPzApvg8ixkgtGHY/xjvhJxKDGBT+XGm09t9l3rkkZDhbdJSMICJ9kPfxeCOg0oRLEa5Zq13W8s/l55++YdZpm5sTrowNHjGgtGAMW9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgsIXbGj3rta/1ZhuKqsKIiFLrQ5l5MMLviRrJyB7co=;
 b=eoWwsIu1kZY5SRqX5lLnI+lL8i9Qti9rMLuphCFH41uTv/6KsUYEZ71n0dimCMUD8s3+boecPtOQ97QB1evFDlkuWhGyaZPBP64z12tiB1xORmmALW/RUEBb8JqKOAIdEy3NyuHnER21oM6iRiDOqCbXOp2L9S+lBoz3XIafLB9raV7/QHVtG5TQMPrYfba0YpwwXEdzHAuClSeeFO6MYnnBIJTPq4wh6bJzudJkl3IZT4fPHrHpBRcBgAY0kSR14euUtYcopkr1079ChZaU2y/XFfuy5fZFAlLKLlaTe7vGNmd0oRRnYJhvJBavWOitabrHI4UoaOcsT8z/RNrROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgsIXbGj3rta/1ZhuKqsKIiFLrQ5l5MMLviRrJyB7co=;
 b=eQWKeWsRGdbZhpl6iAiy5HRbM9+rcQQkySr6DcS1Fx2EbHShO+Ns0FXFBE+/eBdUw18FrQgSNgvdfZO4W0sPQdRZIz3ExndbWT3mx+efGO63cSW5BCtZu38/zHDSjj3C2q/VgPxYcc8+QhhyPvbuxUiC/0Cmv3bsneTtoIWA4BM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 02:59:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 02:59:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "J.D. Yue" <jindong.yue@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 2/7] soc: imx: imx8mp-blk-ctrl: Fix typo of
 imx8m_blk_ctrl_of_match
Thread-Topic: [PATCH v2 2/7] soc: imx: imx8mp-blk-ctrl: Fix typo of
 imx8m_blk_ctrl_of_match
Thread-Index: AQHZS+kdUMo0uE2KdkOR8RSSJdwglK7lO63A
Date:   Wed, 1 Mar 2023 02:59:16 +0000
Message-ID: <DU0PR04MB94173B31E85D56D9DAE674C488AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-3-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-3-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 6fedc10a-a94e-4a62-50b8-08db1a00f201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nh8IgMfRZxbJDnnn07IYb6r8/dvFQDaR8dFMpDfeNsY90PbuTcPbKEc92hgHJBXrBewuVxj2TpvGm1ddpGhy1D+AUOHUKfKXsBZhLnXemQtVgX7lcBckKxqQ01wKFxfb97Krun/8eBq574kupcyEVRcRaKFmgxoAbw+mMHWw1RtnTKQC1yiie6CYU1d2O4LsA4RRdyN/i+4W+TgYgp3+NZsPhEWcCPVRgBvdq4LtXuVGIn25OQu+0BVwOXOUKjAkyhattG8VkyF8jzlmkTRH9x+/idLifhlq4SwkmWdNfRuXNBH3z2IPfOKbzbpLFV9VvYkM1vPLvkk52HSqVe/e8ASjE/grnfXq+4P1t1+ITXfU5Rjpmc09txG5BMavDOXvyNaSaZ+DiZPlF5nQv3APmizfyAdCjJyHgRE1SRAjWfuu8dgnkmS+7tiSRt+X92XK06Blfth9TOSZxL+qLHWjfmnbuiDv+F0UXepYW6xYm05fX4vbqk9X/dkm5lMTMb229/fOAgOpKavLADEgksSIa9bKm7oa2aaqQhjkz9Isc85SoeiVUcLF3PVzcURhaNkXOaw3PpCqOI/jLMP6li3GcRBrBCNlyGe9gxRYkffFMMp3DpfiVA7X48Et8TrrRFVqDUi0h7MEmTH93UWSiF4GEUU61tRuup80imgR42uACJ4HVXCnMQb9AM+W+BxvvNXiG2p5KgWaGFWOrb0db6Ry8BDT42HzPKrVE0Sh3jLo4h8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(83380400001)(110136005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZaS01zc1paM1ZNU3Fwek9HSFdtL0VYYk9LcEVGemkzSUVjZW91S0JRam1S?=
 =?utf-8?B?V0hGckRNMzU5d2xycjBTcG1CSHl2ZktndUpzVjg1OUwrKzZ6U25Jb3cwalB0?=
 =?utf-8?B?bVNoWElXcThod21aempvK0JhTndWT29ORmt3ekIySDVaNExrRG1VV3BLZ2dj?=
 =?utf-8?B?aDdBZzFLbUNVVnZZTWZYcW5ISjllVmd3cWVycnE3cGRMWkZxKytuMEdUMkw1?=
 =?utf-8?B?TkJsZ2ZYckNidlB2ME1Qc3VrSm1iVDhaZWZtakRDYlcvY2VJWEFqR2RIZUtt?=
 =?utf-8?B?TEJsbXBRenBKU2V2NGpRTmxNaTB1LzBWT1pNVDRHU2VkeEpkSGVOQXVKQUxx?=
 =?utf-8?B?L2ZvdWI5bWlBcVhuUkgxcXhuOENXS1RVTkJtQ1hwYTh5U2FPSDB6eUZtUWNq?=
 =?utf-8?B?VW41cU5ibzJoQTdkWUVsTzRJdDhZVnVQSkRRZG9CQ2FyUzM0WUhwMnB2c3hl?=
 =?utf-8?B?QTJpTzNITnFtdndEaEcrTysxU1F0R2lPUTlqVVRXbHc1TXl0S1ppMHh3end1?=
 =?utf-8?B?Z1hNbXFTNGIxMXY3aEpTaUNnd3pHWHFqYk1oQXVlbGRXaW1mZ3Y2VHJTQjNI?=
 =?utf-8?B?YUNna1FwbnQwd2NnMnhFMjBFRWNGYUNDNGxWQm92b3daRWU4U0ZZMEN3MjUx?=
 =?utf-8?B?dDZSaGM0SmFJTzN0aEpxUUV5eHZsUmtTbStCQjl4RnVmME4vTW0rd0lod1Q5?=
 =?utf-8?B?SEREaFlaOFdHOUFsZVYxa2J4RGxrS20zbFZYVTM5L0U3S2ZwUUFuV1lIRlNF?=
 =?utf-8?B?ZkhnNHE5akJNQktRTnYxcmtTdFNXR0duODYyUWk4Y2tTQUpRblJiekc4ZVVx?=
 =?utf-8?B?cTJsWFMwUWhVRkhxOTk5VGxWQkZVNzlpbTdtMWpma2x4bXArdVYwaStneG9O?=
 =?utf-8?B?WFVrOUNBQkxWRDNQVVNYUnhuV2o2QnZWLzJzb1M4NWxDYjVDS0xCZDYvaXFw?=
 =?utf-8?B?Si8wZSswRit4SG9CZncxYmVic0tocjFyV0lSRVNyZUIvZ1BJSThxdmZ4TnFm?=
 =?utf-8?B?S0NEdEhNVnRNTXhZL2VrMytLVnhETUNtOXNpaWkxbnU3dC9icFZnVlg0Q2k3?=
 =?utf-8?B?SmtiUEhPeVNncVFGVzk5VFhYQU9OaFV3RGd1Z2RqVFNkNVBvdkFTS0Z1d2t6?=
 =?utf-8?B?YWl3eTBtSDZ4SWRzRlF6alhkVkROaS81YUxOZERTQ2krd0E5S1BOYTVKemxT?=
 =?utf-8?B?anM4SHJLOTdDUkM0aWVTdkxKUjRPTVI1WUdFUlNQZGVVRFdyODVCTnFvRCt1?=
 =?utf-8?B?UzFXSXNYZkdJSitiRWsrZEJQaVV1K2l2YTM1UjdvNkNCbWxmYjJvaVdyTDM4?=
 =?utf-8?B?YTVOOStkcjNiQmtwb0FzZC92eVRSRjUrSXFnTm4zb2RsSkg2dGpzd3dKMEVx?=
 =?utf-8?B?Q1YvQkxSVWFaL05xbG5sbklBUU9tZ0dwV2M2R3pxUUY1UUhOalNNaUJYSjZP?=
 =?utf-8?B?aS9lTjNoMlhaSXpsbi81d25hbkczTzVpSDFwYVJyNjVyaWI0c2sxZy9zdUIw?=
 =?utf-8?B?bm9DZ1ZlL0hpWVFOR0pmNkdjclBnUS9YaG8ydFljOWJ0YzJiaGYyRFBXMTNj?=
 =?utf-8?B?T3hjNHNzR1pIeXM1UlFBclpGcFAvU2NhYW5JVW40WE1lK041emlnZ0NHMTkz?=
 =?utf-8?B?MFR2SEZmV1lsZnhDd1pwVGdnUjI2dGR0WUFKa21zS0VpVnkzcXpvbkJJMTRU?=
 =?utf-8?B?R3VxZ1FBZ1RpM2tmbGZXaEtkck1CTzU1L1BJWFVQbVhtZ01FV2pYTXE2YW45?=
 =?utf-8?B?TWRjMWhJYUoyd2hZaHRseSsrUUhvb1FreFZhQng2amtJbm93clFUMUdvbEtB?=
 =?utf-8?B?UkVwWjBHdkxnYjFNRitBS1pyQmo2NGJ2SldJbzA3WWFHMGxTcFgzOVJCVmJn?=
 =?utf-8?B?SFh1aHZNOExoaDRpQ2JCWTlqb0g2c0IwQ3ZQb0VpY1pvZWZXS21EQVFlc1Np?=
 =?utf-8?B?TzI3S1lmVWRSaEJlc1NNMy94TW9NbGFXMWh0ajR5eEE3bnhLdzN3UjhxQ0Ur?=
 =?utf-8?B?T05qNDA2WlpPeUd2VVlZYkl3RjdjRVl4SlF4MmJVWlA0VDlRNGhjcGRBYyt6?=
 =?utf-8?B?M0R3c3g5RGU3U0xpZld6TlE0TlF3ZyswL2h4UkhybEcxYkxFSHRuaHlxNzhj?=
 =?utf-8?Q?M7jM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fedc10a-a94e-4a62-50b8-08db1a00f201
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:59:16.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEfcJw07/QOiMQjw18X5mtPRvIjCgG8s3HJ+0Vbw6UeddrT/Dw3uUYMYZ75oh3w6E2Wv9/nOThsZ7wpH2gvZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi83XSBzb2M6IGlteDogaW14OG1wLWJsay1jdHJsOiBGaXgg
dHlwbyBvZg0KPiBpbXg4bV9ibGtfY3RybF9vZl9tYXRjaA0KPiANCj4gT25jZSBzZXQgQ09ORklH
X1NPQ19JTVg4TSBhcyBtLCBmb2xsb3dpbmcgZXJyb3Igb2NjdXJzOg0KPiANCj4gZHJpdmVycy9z
b2MvaW14L2lteDhtcC1ibGstY3RybC5jOjc0NzoyNTogZXJyb3I6IOKAmGlteDhtX2Jsa19jdHJs
X29mX21hdGNo4oCZDQo+IHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pOyBkaWQg
eW91IG1lYW4NCj4g4oCYaW14OG1wX2Jsa19jdHJsX29mX21hdGNo4oCZPw0KPiAgIDc0NyB8IE1P
RFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteDhtX2Jsa19jdHJsX29mX21hdGNoKTsNCj4gICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4g
Rml4IHRoZSB0eXBvLg0KPiANCj4gRml4ZXM6IDU1NmY1Y2Y5NTY4YSAoInNvYzogaW14OiBhZGQg
aS5NWDhNUCBIU0lPIGJsay1jdHJsIikNCj4gU2lnbmVkLW9mZi1ieTogSmluZG9uZyBZdWUgPGpp
bmRvbmcueXVlQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9pbXgvaW14OG1wLWJsay1jdHJsLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvaW14OG1wLWJsay1jdHJsLmMgYi9kcml2ZXJz
L3NvYy9pbXgvaW14OG1wLQ0KPiBibGstY3RybC5jDQo+IGluZGV4IDE4OTJjMmM3ODgzMS4uZjEw
OWM3YmQ2NjU4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvaW14OG1wLWJsay1jdHJs
LmMNCj4gKysrIGIvZHJpdmVycy9zb2MvaW14L2lteDhtcC1ibGstY3RybC5jDQo+IEBAIC04NTIs
NyArODUyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gaW14OG1wX2Js
a19jdHJsX29mX21hdGNoW10gPSB7DQo+ICAJCS8qIFNlbnRpbmVsICovDQo+ICAJfQ0KPiAgfTsN
Cj4gLU1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteDhtX2Jsa19jdHJsX29mX21hdGNoKTsNCj4g
K01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteDhtcF9ibGtfY3RybF9vZl9tYXRjaCk7DQo+IA0K
PiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14OG1wX2Jsa19jdHJsX2RyaXZlciA9
IHsNCj4gIAkucHJvYmUgPSBpbXg4bXBfYmxrX2N0cmxfcHJvYmUsDQo+IC0tDQo+IDIuMzYuMA0K
DQo=
