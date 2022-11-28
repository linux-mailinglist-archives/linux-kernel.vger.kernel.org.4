Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9563A22E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiK1HkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiK1Hjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:39:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9415822;
        Sun, 27 Nov 2022 23:39:11 -0800 (PST)
X-UUID: 3de40bfea7b94d8c8a6d2a3d08be7cbd-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jm85E4OaFRifWOBFKPavP1mFqKLucSZWEpUEhYvVdX4=;
        b=qyv8W8YR2p5838lOBBkAl/vCZ8eFeTM/yhTwGYjPPXvdxDExO1ATCRXzm/d2tHGIgmZyRBKT7EEdNOrBPwdBw9qK+MLHQNF4VY8b7Ce8t3BecRLuD/RwZReK4uP+P2eZctY1Klhr1WWK/F8M4+4CtcMpfri1Tm+iOqdiUX+t1gc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:76e61186-2446-4d7c-ba17-e986765b528c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:d0c76bdc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3de40bfea7b94d8c8a6d2a3d08be7cbd-20221128
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1312898220; Mon, 28 Nov 2022 15:39:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 15:39:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 28 Nov 2022 15:39:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk5K64olw/m2QL0ysimy/An7kbpxFeA/+HBMwtIoQAQCWJRjld4HsRKrgiTtjApm0I9AVt52bj6PhBBlAncVNl5CJuxeYo5Wgg7QY0pFRq/ekLcYwG3J9a10lsHxW/RhjVnGHxg5HTQ3DYm+5Kb3Srb0E7r3IAdVcXsCHgHxzldbobI+pwbRdlnBUeWV2ZK98XrtWi2JtKjT8zplASpJJKRAxwMvXPQmKhQXjSbK88Tc7/95NmWoBCsWc6IdY8S2LJv3oOZ/dF0txDRbxcC5Wf1tcf32N8xLuB5Nwt15RxPS2Ylx2cC452e71kyjCeF5GvhF/ijjIhaMKnozx0vZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm85E4OaFRifWOBFKPavP1mFqKLucSZWEpUEhYvVdX4=;
 b=g5wq7vcqKipfEOY35n+CoeItOtrRuykiFJkPgVBFXTKgWOhUigKd/j6kOHR2gqVPN25EvCCK0Dq7h0YGp6MvX5tw6DO+9+AZSnoU3A8tmRTELyjS+8cHsT7DvPQB+hxZiVF/ObNuswyDbefksGmCIkF6VRNXm32nfg5c+u/7VFriKY/RrORebSYuzUB1/ElsC/M0gV8bPp4+9WzLRgXj03OxSVVhoauKv6nk6fFibmhdnp5l6+8waIkos0C9/anf4qjQDSoIoOBzgLdWXqI4zSQSCWJ4UaVDn6ivL2N/iKEbHKwBlp6Z71ZQqyb93P/xU9RcVYkBcfW7T/fXY0u5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm85E4OaFRifWOBFKPavP1mFqKLucSZWEpUEhYvVdX4=;
 b=atmIIom9aTHtenHmCkH+gMWo5MbJzAPZptaUB8+DVh0nfQzVWg5XYCssw/3rQmmKQI1b8bYrk5eAE/SOPvaqLhwe/hqjAEEfmz/P2XYStBWMpbC7es2vxGEmsqwsyifxKGvNp3tn+wP7VDmA0+g4h3d2JTmEURD7QdNAHXGk4SU=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by TY0PR03MB6678.apcprd03.prod.outlook.com (2603:1096:400:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 07:38:57 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b%5]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 07:38:57 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v28 06/11] soc: mediatek: add mtk-mmsys config API for
 mt8195 vdosys1
Thread-Topic: [PATCH v28 06/11] soc: mediatek: add mtk-mmsys config API for
 mt8195 vdosys1
Thread-Index: AQHY8nnTMx76rqWXzU2yc1/01XZpHq41TzaAgB7Ew4A=
Date:   Mon, 28 Nov 2022 07:38:56 +0000
Message-ID: <63ec66315caf3f7581b125eda8c858c332e13cce.camel@mediatek.com>
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
         <20221107072243.15748-7-nancy.lin@mediatek.com>
         <32ae4104-673b-1b34-5efb-dc1317e80530@gmail.com>
In-Reply-To: <32ae4104-673b-1b34-5efb-dc1317e80530@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|TY0PR03MB6678:EE_
x-ms-office365-filtering-correlation-id: 7105a7ba-2585-40fa-435a-08dad1139b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/vsk2kuMJxXPcCS6n4K4Z8U6BKTBLsEY3lwUXiAZSF16tNacFDzzsc+ZloFjEnRhJvlWUAbwbeku2EVcd3/snTAoMlkIpLlBc6SwrWHPvATcoBn6Bj23WwzLDUC45s/4wCw3Gbammy1Q2902o98osUKTnEX3ORv67/sp7lBJwbDkBarqDEwbyLflq1ZotqzjQCM2RKwpFvCzrzcNIMK679/SP010bMU6fAftBSqqBJysD7EXSFzImUZmrUxysi1XZbFovXjmdsBrq7iWAKm9ZP6TYPa1v8TnKxIhj3wpaxoIA8c5Fo2jw1ixgCMsZ86f1Rwwjyl8rSukaJmtonYvNIeOjFBbfHcEVtFdAF5fsraRuSS/3GOIT/xtPkPiuA2ckDxkQ12iXzetuaaAGM3s+6DO7Txy4ahuj81MEFMzKIWbHhTEdEwQ2vkJ7ETod+vs1zSkDzBhIHYzp/svI2GEB5gA0GnSNtwHv4hh4Wd4+5upGyYevKyTYEmJwv5oQhWIKaGpyclzVIKzXhGfEk6Q3q0k5A3gmDsIayVRY/rXvA1GWba3Czp/W6qi0JKWHSihe7tixbt6PyOtRdm+u80bUihv6oWmsMTQ96ZSjmbidiCmzY43924Ub3PfitHEfavWY/8So9KDFUuvBpV1NiGhcXYB5VWv/Hc/1ygepaFdqP/W+9z3BMmV2aygPVnvqsZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(7416002)(8936002)(5660300002)(2906002)(122000001)(86362001)(6512007)(71200400001)(6506007)(26005)(53546011)(2616005)(83380400001)(186003)(316002)(478600001)(110136005)(54906003)(8676002)(66476007)(91956017)(4326008)(41300700001)(66556008)(66946007)(66446008)(64756008)(76116006)(38100700002)(38070700005)(6486002)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUoxSUovVWZWaXdjazYxaGEzSjNYZkNmOXJEZGp1dnM3ckh3bkdFdWI0Zm1O?=
 =?utf-8?B?eHNyMnUwYlRIeTd3bEYyU3RlTXBRWkNiR1p3Qng4eWU2WUpVNkswTHY4TG1R?=
 =?utf-8?B?TlRseDUvczVGVVRPN3V1cjJlR2V0SlhXbitveFFCMVlkdkVWOE43eHFyYk1M?=
 =?utf-8?B?cnBFdS9odFNWeU91QzZwUjBBa1FIMFZNNm1lMXJHaWh1eTg4RTBBbVhIZFpG?=
 =?utf-8?B?QUZRTXFabkpkSXA3elg2KzZXc0w3Z044YXprV1Yranh5Yk9nZXZ5aDlnajVw?=
 =?utf-8?B?ekI1UkRodjBNVzBleDF5S3lRSXh3SHRtRnhwc0RvTjB6b25xT2MvbEFJSVJ5?=
 =?utf-8?B?TnVzV3JXUWpObXRmV0QxWmh6bWtEYlpIUWtidGU0eEZ6ai8zZURlR1diNkdh?=
 =?utf-8?B?YU1JWEZibXhwOTNVZHllMUZ1NzRhcUNGbzNnNTNva1l2cU9vQisxbWQ4MEt4?=
 =?utf-8?B?TXduMDdySlR4UmFGdW00aEV6SXhXbUVvSHRjREVORDZHTm81dXhpaFl0dU9s?=
 =?utf-8?B?Q2VDZ3VaM0tSZXRrSFBEZTF6cnJVMUFpbkplQUdaRHpXQmhzN1FyMmc5UE5a?=
 =?utf-8?B?L2UybWIvcjFsd1c3RXdlWDcrOURVbDlQbjBjQTJ3M1orVWYrVDlQMmtManoz?=
 =?utf-8?B?SThPVmRjRlVUak0wanV3ZnMxMGs0M3R2SzBSVGdtdkNkMWQvbGN6MDRrYnVj?=
 =?utf-8?B?TytuUExTVUdxYVN4Y1VJcWZRVUtCMy92d1pxSUZtS1orUmE1WHFyZ1BFUHVZ?=
 =?utf-8?B?M3ZCOXNiZUdSSGpLSkYvaHV6WkVtaXdmN2xaSGlSYjFPQkgzbVZoUmt4S002?=
 =?utf-8?B?RWh4V3hLbkhWcWh6S3lSY3lhSlFOMXBRcVplYlZvS09KS1BObE9xOWE3MkFy?=
 =?utf-8?B?RTd0SjFRSGJlWHV1SGE1eWdDMURXTTM5a3pzSFg3cDc5QlhYZVBneXk5MTh3?=
 =?utf-8?B?QmlPeVZoUjZPSTMwSjFSYkZTMUhVNGpoSHhzUW1XNWdlcUpqUnQ4d1c4TVN6?=
 =?utf-8?B?NENGWFM2RFEwMWtEOGRtMCswWWtNai9CMmd3M3U5MzQ0TWNIWjB0L0xCVGhZ?=
 =?utf-8?B?WThJMzZaRVJwbUgybktueWFyL3RJUlM3OTZoMUFCZVpDL2I0dWlwVjZlSjcy?=
 =?utf-8?B?SUFkZzdVc3NrT2lTWTBIS00wMVBCa0xJN1JxU0JqbWRqblFQWTltQXlKb2tO?=
 =?utf-8?B?K3VDaDlJZzVBd29OYWZGNWMvMFBNVzFvcTZmbzE4c3dva3A4R3BzeThNM3Ju?=
 =?utf-8?B?WXhndFpjNXNTWlJKanF6c1VMK3Z3bUdPbU4vTy9ZMG9GRGttOW05QTRlNzdJ?=
 =?utf-8?B?WWZFVzEvUURqa2QxbFZtam1MeXhJclplcTNGVlN0dWxpMUFpSCs1cXhZcitM?=
 =?utf-8?B?bHVrU3o5eTNSRTdmbnBjczFHbkF3L05qK3U1K011Wk55a3NmWHZzMzJ0M1Ro?=
 =?utf-8?B?a0g5NEtpOU4vOFl2TTZweklWSHh2L29Hak9IVUVQVE9PaDNNekRjZGQ2Qjh4?=
 =?utf-8?B?akloRmpEMm1xQjFGRjNMcURkL2U0K3RteGFrSzVBZkdQOUR3SHpRSlZsWmlz?=
 =?utf-8?B?ZlZGLy9TUk1KQ0tXak1LSFhkcEJJVFZDM291a3hJNVZMczFNNVhhdXhWY0dn?=
 =?utf-8?B?KzgvdmZRQ3lpc1o0UUFQZTVqSnR0NDYyZENUa1g1YWdwNXZIV0RGeTYrMDVa?=
 =?utf-8?B?Vmowd01FWGQ3eDY2U2I3OFpHVjVoeEVUamYzRFFSTHlNMTh5NTg2dlo2T0VG?=
 =?utf-8?B?NktndXBpNU1UMkgyTHNOZEFCWnU3aXlsRFNJM1pSTW54TVQyaWozdFRmdVFt?=
 =?utf-8?B?YU1vMmQ4TUU3cGxPTm9GNFR3SVh2YlBsOEVrZTQ3RU5XVk1OOWpGWSt1bUdi?=
 =?utf-8?B?dkpOendxVmg4amp2NzNsY2NZWUxvaklGSkE1NXZuT1lwMktHTEZiQXc1TUdn?=
 =?utf-8?B?UFBjUVhXcDhjdnpxa0xIWkVrKzNMOTNxdENVdnh4eG90bVRqMG5Kb0U5VWZG?=
 =?utf-8?B?K0EzdkUwL2VzcmlQUFNpeEdyK2Q3aUJheWlDbGtxOXNxVkgvSFAvcFZyNWl4?=
 =?utf-8?B?T3VVa0V1TFhNRklPV3lrSjRRc045ZEwwOGR6NGRhclUzQ3UzR1A1R2pZM3FM?=
 =?utf-8?B?bXlBdk4vZ3ZLQzFzSCtoMGtxblJ0NEpid25Vb3Z1QXdmWDAwSWlOUlNiekdR?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D5A758A2133D34EAB0B687B38060A59@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7105a7ba-2585-40fa-435a-08dad1139b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 07:38:56.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJ5dzDQU4Ck0lJ9L7xXSlZGjzn7TXpNTDELv9jlLu09yTeYJzswxEdtePZoCnufp14kANXkVHgnpyGQhXf81jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6678
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYXR0aGlhcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQoNCk9uIFR1ZSwgMjAy
Mi0xMS0wOCBhdCAxODo0NiArMDEwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9u
IDA3LzExLzIwMjIgMDg6MjIsIE5hbmN5LkxpbiB3cm90ZToNCj4gPiBBZGQgZm91ciBtbXN5cyBj
b25maWcgQVBJcy4gVGhlIGNvbmZpZyBBUElzIGFyZSB1c2VkIGZvciBjb25maWcNCj4gPiBtbXN5
cyByZWcuIFNvbWUgbW1zeXMgcmVncyBuZWVkIHRvIGJlIHNldCBhY2NvcmRpbmcgdG8gdGhlDQo+
ID4gSFcgZW5naW5lIGJpbmRpbmcgdG8gdGhlIG1tc3lzIHNpbXVsdGFuZW91c2x5Lg0KPiA+IA0K
PiA+IDEuIG10a19tbXN5c19tZXJnZV9hc3luY19jb25maWc6IGNvbmZpZyBtZXJnZSBhc3luYyB3
aWR0aC9oZWlnaHQuDQo+ID4gICAgIGFzeW5jIGlzIHVzZWQgZm9yIGNyb3NzLWNsb2NrIGRvbWFp
biBzeW5jaHJvbml6YXRpb24uDQo+ID4gMi4gbXRrX21tc3lzX2hkcl9jb25maW5nOiBjb25maWcg
aGRyIGJhY2tlbmQgYXN5bmMgd2lkdGgvaGVpZ2h0Lg0KPiA+IDMuIG10a19tbXN5c19taXhlcl9p
bl9jb25maWcgYW5kIG10a19tbXN5c19taXhlcl9pbl9jb25maWc6DQo+ID4gICAgIGNvbmZpZyBt
aXhlciByZWxhdGVkIHNldHRpbmdzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hbmN5Lkxp
biA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiBU
ZXN0ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gVGVzdGVkLWJ5OiBCby1DaGVuIENoZW4g
PHJleC1iYy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IE5vdCBzb21ldGhpbmcgd2UgbmVlZCB0
byBmaXggaW4gdGhpcyBzZXJpZXMsIGJ1dCBpdCB3b3VsZCBtYWtlIHNlbnNlDQo+IGluc3RlYWQg
b2YgDQo+IGFkZGluZyBhbGwgdGhlIEVYUE9SVFMgdG8gcGFzcyB0aGUgZnVuY3Rpb25zIGFzIGNh
bGxiYWNrcyBpbiB0aGUgDQo+IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhLiBCdXQgSSBy
ZWFsaXplIHlvdSBkb24ndCBwYXNzIHRoZQ0KPiBWRE9TWVMgbnVtYmVyIHRvIA0KPiB0aGUgRFJN
IGRyaXZlciB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSBkaWZmZXJlbnQgTU1TWVMgZGV2aWNl
cw0KPiB0aGF0IGNyZWF0ZWQgDQo+IHRoZSBwbGF0Zm9ybSBkZXZpY2UuIEkgaGFkbid0IGhhZCBh
IGRlZXAgbG9vayBvbiB0aGUgRFJNDQo+IGltcGxlbWVudGF0aW9uIGJ1dCBJIA0KPiBzdXBwb3Nl
IGl0IHdpbGwgYmUgY2hhbGxlbmdlLi4uDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiAN
Cg0KRG8geW91IG1lYW4gdG8gbW92ZSBhbGwgdGhlIG1tc3lzIGNvbmZpZyBBUElzIGFzIGNhbGxi
YWNrIGluIG1tc3lzDQpkcml2ZXIgZGF0YT8NCklmIHNvLCBub3Qgb25seSB0aGUgZm91ciBtbXN5
cyBjb25maWcgQVBJcyBpbiB0aGlzIHBhdGNoIGJ1dCBhbHNvIHRoZQ0KZm9sbG93aW5nIG9yaWdp
bmFsIHRocmVlIEFQSXMuDQpJdCB3b3VsZCB0YWtlIHNvbWUgcmVmYWN0b3JpbmcgZWZmb3J0LiBJ
IHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0bw0KY2hhbmdlIHRoaXMgYWZ0ZXIgdGhpcyBzZXJp
ZXMgZm9yIHZkb3N5czEgaWYgbmVlZGVkLg0KDQoxLiBtdGtfbW1zeXNfZGRwX2Nvbm5lY3QNCjIu
IG10a19tbXN5c19kZHBfZGlzY29ubmVjdA0KMy4gbXRrX21tc3lzX2RkcF9kcGlfZm10X2NvbmZp
Zw0KDQpSZWdhcmRzLA0KTmFuY3kNCg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXQ4MTk1LW1tc3lzLmggICAgfCAgNiArKysrKw0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLW1tc3lzLmMgICAgICAgfCAzNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCB8ICA5ICsrKysr
KysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxOTUtbW1zeXMuaA0KPiA+IGIvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTk1LW1tc3lzLmgNCj4gPiBpbmRleCBmZDdiNDU1YmQ2NzUu
LjQ1NDk0NGE5NDA5YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgx
OTUtbW1zeXMuaA0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE5NS1tbXN5cy5o
DQo+ID4gQEAgLTc1LDYgKzc1LDEyIEBADQo+ID4gICAjZGVmaW5lIE1UODE5NV9TT1VUX0RTQ19X
UkFQMV9PVVRfVE9fU0lOQV9WSVJUVUFMMAkJDQo+ID4gKDIgPDwgMTYpDQo+ID4gICAjZGVmaW5l
IE1UODE5NV9TT1VUX0RTQ19XUkFQMV9PVVRfVE9fVlBQX01FUkdFCQkJDQo+ID4gKDMgPDwgMTYp
DQo+ID4gICANCj4gPiArI2RlZmluZSBNVDgxOTVfVkRPMV9NRVJHRTBfQVNZTkNfQ0ZHX1dECQkJ
CQ0KPiA+IDB4ZTMwDQo+ID4gKyNkZWZpbmUgTVQ4MTk1X1ZETzFfSERSQkVfQVNZTkNfQ0ZHX1dE
CQkJCQ0KPiA+IDB4ZTcwDQo+ID4gKyNkZWZpbmUgTVQ4MTk1X1ZETzFfSERSX1RPUF9DRkcJCQkJ
CQ0KPiA+IDB4ZDAwDQo+ID4gKyNkZWZpbmUgTVQ4MTk1X1ZETzFfTUlYRVJfSU4xX0FMUEhBCQkJ
CQ0KPiA+IDB4ZDMwDQo+ID4gKyNkZWZpbmUgTVQ4MTk1X1ZETzFfTUlYRVJfSU4xX1BBRAkJCQkw
eGQ0MA0KPiA+ICsNCj4gPiAgICNkZWZpbmUgTVQ4MTk1X1ZETzFfVlBQX01FUkdFMF9QMF9TRUxf
SU4JCQkweGYwNA0KPiA+ICAgI2RlZmluZSBNVDgxOTVfVlBQX01FUkdFMF9QMF9TRUxfSU5fRlJP
TV9NRFBfUkRNQTAJCQ0KPiA+IAkxDQo+ID4gICANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4gPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1t
bXN5cy5jDQo+ID4gaW5kZXggNzNjOGJkMjdlNmFlLi42MDQwYTNjZmY2ZjggMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4gPiArKysgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYw0KPiA+IEBAIC0xMzcsNiArMTM3LDQxIEBAIHZvaWQg
bXRrX21tc3lzX2RkcF9kaXNjb25uZWN0KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2LA0KPiA+ICAg
fQ0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwobXRrX21tc3lzX2RkcF9kaXNjb25uZWN0KTsNCj4g
PiAgIA0KPiA+ICt2b2lkIG10a19tbXN5c19tZXJnZV9hc3luY19jb25maWcoc3RydWN0IGRldmlj
ZSAqZGV2LCBpbnQgaWR4LCBpbnQNCj4gPiB3aWR0aCwgaW50IGhlaWdodCkNCj4gPiArew0KPiA+
ICsJbXRrX21tc3lzX3VwZGF0ZV9iaXRzKGRldl9nZXRfZHJ2ZGF0YShkZXYpLA0KPiA+IE1UODE5
NV9WRE8xX01FUkdFMF9BU1lOQ19DRkdfV0QgKyAweDEwICogaWR4LA0KPiA+ICsJCQkgICAgICB+
MCwgaGVpZ2h0IDw8IDE2IHwgd2lkdGgpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BM
KG10a19tbXN5c19tZXJnZV9hc3luY19jb25maWcpOw0KPiA+ICsNCj4gPiArdm9pZCBtdGtfbW1z
eXNfaGRyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBiZV93aWR0aCwgaW50DQo+ID4g
YmVfaGVpZ2h0KQ0KPiA+ICt7DQo+ID4gKwltdGtfbW1zeXNfdXBkYXRlX2JpdHMoZGV2X2dldF9k
cnZkYXRhKGRldiksDQo+ID4gTVQ4MTk1X1ZETzFfSERSQkVfQVNZTkNfQ0ZHX1dELCB+MCwNCj4g
PiArCQkJICAgICAgYmVfaGVpZ2h0IDw8IDE2IHwgYmVfd2lkdGgpOw0KPiA+ICt9DQo+ID4gK0VY
UE9SVF9TWU1CT0xfR1BMKG10a19tbXN5c19oZHJfY29uZmlnKTsNCj4gPiArDQo+ID4gK3ZvaWQg
bXRrX21tc3lzX21peGVyX2luX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsIGJv
b2wNCj4gPiBhbHBoYV9zZWwsIHUxNiBhbHBoYSwNCj4gPiArCQkJICAgICAgIHU4IG1vZGUsIHUz
MiBiaXdpZHRoKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX21tc3lzICptbXN5cyA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArCW10a19tbXN5c191cGRhdGVfYml0cyhtbXN5
cywgTVQ4MTk1X1ZETzFfTUlYRVJfSU4xX0FMUEhBICsgKGlkeA0KPiA+IC0gMSkgKiA0LCB+MCwN
Cj4gPiArCQkJICAgICAgYWxwaGEgPDwgMTYgfCBhbHBoYSk7DQo+ID4gKwltdGtfbW1zeXNfdXBk
YXRlX2JpdHMobW1zeXMsIE1UODE5NV9WRE8xX0hEUl9UT1BfQ0ZHLCBCSVQoMTkgKw0KPiA+IGlk
eCksDQo+ID4gKwkJCSAgICAgIGFscGhhX3NlbCA8PCAoMTkgKyBpZHgpKTsNCj4gPiArCW10a19t
bXN5c191cGRhdGVfYml0cyhtbXN5cywgTVQ4MTk1X1ZETzFfTUlYRVJfSU4xX1BBRCArIChpZHgg
LQ0KPiA+IDEpICogNCwNCj4gPiArCQkJICAgICAgR0VOTUFTSygzMSwgMTYpIHwgR0VOTUFTSygx
LCAwKSwgYml3aWR0aA0KPiA+IDw8IDE2IHwgbW9kZSk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZ
TUJPTF9HUEwobXRrX21tc3lzX21peGVyX2luX2NvbmZpZyk7DQo+ID4gKw0KPiA+ICt2b2lkIG10
a19tbXN5c19taXhlcl9pbl9jaGFubmVsX3N3YXAoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWR4
LA0KPiA+IGJvb2wgY2hhbm5lbF9zd2FwKQ0KPiA+ICt7DQo+ID4gKwltdGtfbW1zeXNfdXBkYXRl
X2JpdHMoZGV2X2dldF9kcnZkYXRhKGRldiksDQo+ID4gTVQ4MTk1X1ZETzFfTUlYRVJfSU4xX1BB
RCArIChpZHggLSAxKSAqIDQsDQo+ID4gKwkJCSAgICAgIEJJVCg0KSwgY2hhbm5lbF9zd2FwIDw8
IDQpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKG10a19tbXN5c19taXhlcl9pbl9j
aGFubmVsX3N3YXApOw0KPiA+ICsNCj4gPiAgIHZvaWQgbXRrX21tc3lzX2RkcF9kcGlfZm10X2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiB2YWwpDQo+ID4gICB7DQo+ID4gICAJaWYgKHZh
bCkNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
LmgNCj4gPiBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oDQo+ID4gaW5k
ZXggMTI3ZjFiODg4YWNlLi5hNDcwODg1OWMxODggMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiA+IEBAIC03NSw0ICs3NSwxMyBAQCB2b2lkIG10a19t
bXN5c19kZHBfZGlzY29ubmVjdChzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwNCj4gPiAgIA0KPiA+
ICAgdm9pZCBtdGtfbW1zeXNfZGRwX2RwaV9mbXRfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwg
dTMyIHZhbCk7DQo+ID4gICANCj4gPiArdm9pZCBtdGtfbW1zeXNfbWVyZ2VfYXN5bmNfY29uZmln
KHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGlkeCwgaW50DQo+ID4gd2lkdGgsIGludCBoZWlnaHQp
Ow0KPiA+ICsNCj4gPiArdm9pZCBtdGtfbW1zeXNfaGRyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIGludCBiZV93aWR0aCwgaW50DQo+ID4gYmVfaGVpZ2h0KTsNCj4gPiArDQo+ID4gK3ZvaWQg
bXRrX21tc3lzX21peGVyX2luX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsIGJv
b2wNCj4gPiBhbHBoYV9zZWwsIHUxNiBhbHBoYSwNCj4gPiArCQkJICAgICAgIHU4IG1vZGUsIHUz
MiBiaXdpZHRoKTsNCj4gPiArDQo+ID4gK3ZvaWQgbXRrX21tc3lzX21peGVyX2luX2NoYW5uZWxf
c3dhcChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsDQo+ID4gYm9vbCBjaGFubmVsX3N3YXAp
Ow0KPiA+ICsNCj4gPiAgICNlbmRpZiAvKiBfX01US19NTVNZU19IICovDQo=
