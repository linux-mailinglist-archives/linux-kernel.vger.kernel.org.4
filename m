Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A606A0C10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjBWOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjBWOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:43:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AFA5EC;
        Thu, 23 Feb 2023 06:43:31 -0800 (PST)
X-UUID: 6cf5351ab38811ed945fc101203acc17-20230223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xd+ZYS6o0T4Q3T461fg1FYQteQa8HjqPk2ZJcFtAspw=;
        b=Hb/QX24iG6/6/KUPRJTqUez1eFJWNwPYri9w/9AAlu23r0NNmE42tGY6095Yn4axKI7OodzVxUXRdhl/1t0NLqQOgoGR/HFYrDSkmK5mecH4TxmV1B60ei6j1pRfk1OqcTutzHsYRWcbRGw1d7877sEmYueQ+qx0fJIFrDtDqxM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:255e659f-3f78-4646-a0d4-4036f8098e99,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:255e659f-3f78-4646-a0d4-4036f8098e99,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:dd1c8126-564d-42d9-9875-7c868ee415ec,B
        ulkID:230223183757K6CAXNPM,BulkQuantity:1,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:1,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 6cf5351ab38811ed945fc101203acc17-20230223
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2096404307; Thu, 23 Feb 2023 22:43:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Feb 2023 22:43:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 23 Feb 2023 22:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXjZ+rBPYdiAtXJLuZV/GUvVGgpjvyzWfqX+TNiazfOAYkwfN5PJbWaiwgPVttiDLk/8QNTkd2Go0H5rAZZAXsQVnMUxYKLoUmOIh26spjMfED2vl1h/AJy3KgArSCHrTCY3zZfjMHhr8PlG945AWMOoOFOL3+umwrLiWaZVGSLqeQygF766dqOYxskEZO0dlYrnpj2ZQCG1Jjvls8sk53F5qyF6JPJYHpqTVwd19nWtY/vZ8eq13fdFfw5sEgjezhZRbxCaa63rGyJM9jyjffzGLtFQuGDmeVqx23B7MjMwprY1X3807YrLxke52KGpwQFCGTcLGTrFxM5wHQGisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd+ZYS6o0T4Q3T461fg1FYQteQa8HjqPk2ZJcFtAspw=;
 b=la34Ur4cexXj/yts/S94CxoMSIt6UDh4j5RPigiDO4wwqH5JAMcP7UVhIaeutBMe9xCEJyZNv5XeM+TGej5TjJVjfG1Hl5CAeIcgCvIOhyJm8Nb3KuYrXJpv64HAYDvo2UON7ISDqyqReVYc7C9yHIetu5tlBa+A2yHbWSTnKktGxxZgwj+xzXUkLtHBCg4JVkhSFBs/aOcjfDuwTTUzvVb43TxaPbRrmTmQ9idlIPMoihnp/jjgh3YNQXszOUBhJEaYzCysETGvh/vX87yDVHSGuczln4lJsaekvKJgf+0zSvTECNJCLV8yrKjpXO+WdgTOWMmKoeX/KsdVK7+UUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd+ZYS6o0T4Q3T461fg1FYQteQa8HjqPk2ZJcFtAspw=;
 b=qEBu54qHWkkl9+/pCmJ7ky+qqY1Pv/v42cMgrSRZaSUCexlLDKmwyzfPzDnDnA3eHudgE42dzFpb6AYgdvqQ/XkW2qzwxnbbhGWcvPZYhjPnw/eDJig1kTTnt3TK8Ij+hlQ+8MjjkRZTaKISpJsapBU7f/fj3LnO3LoqoLYcx88=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by SEYPR03MB7270.apcprd03.prod.outlook.com (2603:1096:101:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 14:43:20 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 14:43:20 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>
Subject: Re: [PATCH v2 3/7] scsi: ufs: core: Fix mcq nr_hw_queues
Thread-Topic: [PATCH v2 3/7] scsi: ufs: core: Fix mcq nr_hw_queues
Thread-Index: AQHZRmqCdv5yMEfPIU6K6n4Ox9axBa7cV4CAgABGAoA=
Date:   Thu, 23 Feb 2023 14:43:20 +0000
Message-ID: <83980495ec156da33ca8e394c193cf3cb15aa318.camel@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
         <20230222030427.957-4-powen.kao@mediatek.com>
         <58244768-33ad-21d6-d88d-93e7fdd0ba27@quicinc.com>
In-Reply-To: <58244768-33ad-21d6-d88d-93e7fdd0ba27@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|SEYPR03MB7270:EE_
x-ms-office365-filtering-correlation-id: b91af41e-1eb7-42f2-1e98-08db15ac4ea8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtQU4bUa4706lBognAx9GgAHWD2AyTiWXj7rnU+b66lYRJcSEEo6If+xQwFad/a34zPEOSdXv2ZkIsd5w7eHciXLDSDf0ZJ+gdsHWP9QgeOjEgX5Rq3BJsB7S4sDsEvgIr1KXv4veykxcEdW68r5hqhJDCWL2xGM4QeWOSc4ORvbbbVCzfC4WB94dPA/r04vhfV3WRA5sGjFYs9bO754V4hCN2PS+xN77FFsDMlq4GnDVbHJzDViX8FP72awHi4dBpTQe1Xle88p7UBYnRpsQbAgtb48ewjh9XKz17CDwngS3oU9s4Iek+I/cRLWu9NgXIgTx3C3SjmRZjY/6T/SSymaUJXEzqA17hzayb+g99E7hwIheojZ5I8f+jZKtMSA7BPVJe5O1sVI63I5rdSj4nE4NEC0gJdiYFx+fNvt6IUU1iMBpqo7o/WPrGvtN6Inqt6X1UdI5OW0eLkZa+yZ29EGgXz+MQooqWV+q9OQu+gTLR6oiXTRCUCevIQ5YkOLjqOaVBYv0rh5p18E2NEQSAEpzWrqGCE5rG8VMBk9m4b1tUJbuov3CvhVnbch2V9nai4D6SgDLYWOrnZAOiaAD6c3YxJ/qYLXEP7JEG1DBk7ufE13ePy47iJrDQ6szLDr9u0q1xhrxTRYJ82tUWQomlpnUTsO7dar9yM4TInjk/p9JkRHuNFoVq0pezZy+ZGqJiqP7c9yV20eSfE4fBi/ptrT5gAdJ8hy1CCT9MgsrwjCTL8LuT1dtSZ4kTKk5QdPo2ezeLfo/0tf76p3Yi7U6jw0hGNLLZj7E/wvBKzV2YI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(7416002)(5660300002)(8936002)(41300700001)(921005)(85182001)(36756003)(86362001)(38070700005)(2906002)(38100700002)(122000001)(2616005)(6486002)(478600001)(71200400001)(53546011)(186003)(6512007)(26005)(6506007)(76116006)(66446008)(64756008)(66556008)(66946007)(66476007)(316002)(8676002)(54906003)(110136005)(4326008)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBWMURjQnVLa2pla2RjeXBpY1JnNDZBWUEwME5XUnJRUWFDSE9NeE5JK1pi?=
 =?utf-8?B?emlKRHRQeXpPVElLKzM2S3JLNklBWEJQUjdYR0dmd0RsbTlqdUhSaHZCZVZp?=
 =?utf-8?B?YVdrY09mSTEvTUlvWlRVYk40RUFob0w3azhzNkV3M3R2VFNrcXpveGxFTWtp?=
 =?utf-8?B?WHJJUG0xTU9oWU1UR3pIamEySkt3SVZYZWhSNmxKalNtK2NlbStlMGl0SW1M?=
 =?utf-8?B?VlNjc0c1UDFrQXlneDVWSXFHSk5iRHUwREJZTitBems1S1dEOTJmZ0hCdzhx?=
 =?utf-8?B?ZDhYSGE3dXBmUCtpT1ZKMlplY0tmWVB2akFMd3VzWEljNlR0cVY0cnFhaStz?=
 =?utf-8?B?azhjUWpzRGovQ1FXSGVndFlwbGx3amNKQ3pUdEQ5SXdJeXd2dHh0a05uTEhN?=
 =?utf-8?B?VGV5TTBuOWNLbThqOFVvVGZjVlAzSkZac1hBdzFnNHdCeFhhTGtNNDE3MEwx?=
 =?utf-8?B?Z2E2NVdERmJTTENzYlQyRFpFb2pPckdIYXlsQVM4cCt4ODR5N1d1U3JFSzh4?=
 =?utf-8?B?R2JpTnlGNkZQTkVncHJMb0hSMnZDWTFMUHZETE5QME1VaTYvd1ZQek80bUtn?=
 =?utf-8?B?V1lURlhVYjdCZWIzWWdzbXhEaEQ2UVVxbENtYmFlZ0dKcVEzVnZSb1R0ZzdL?=
 =?utf-8?B?eDBRM1prb1VEY2dna0Iva29Ebm92R3VtMFYxeW5TUE5id2I1UXViNVRCYzJC?=
 =?utf-8?B?d05RL1lyb3doOHYxWHFuc1Qrd0UreUp1Y2Y4anNud1VDSmtCeFNkTVVieFg5?=
 =?utf-8?B?RUVSS0dEM1pXeGh6WDIwNGZFcG13MFpsRE90dnczejNCN1o3TGZud25UTzFJ?=
 =?utf-8?B?YWd2RVBpTFdUM2tsRnpISEpEUndqR1M0MkFseDJwYnV2ZFVxd3FTVlZ4bWdJ?=
 =?utf-8?B?WnpmQWVHM09jM1A2b1c0WU9tY211eDFDQ2JxTXdualF5RCsxSWtDNE56Qm0z?=
 =?utf-8?B?ZGxzTXVzSDFzTGRjdjRvbmdhRW5kSzBTcWw4dTVtVzRLVGg2eEtLNWczaXE3?=
 =?utf-8?B?QlFad095UGtPZEd3Qy9ScklBb0ZXVk5PY2dnZVVQN2wxN3M3YXhRbkJnUDZw?=
 =?utf-8?B?T1lMN3BvSnR3ckg5bDlOcXNZU1duVzFOaDlPbFZhN05LSUxDMDRGWGtQUHQ4?=
 =?utf-8?B?RFVTelA2OU15dHRPaGh0R290K3VTZkZtSG9aRlFNMmZ2Yzhnd05LZnl0bVpi?=
 =?utf-8?B?c0lSR2hWWkZoODZXTWJPdjE0ZjgwVVhMYldUYnhZVVovVCt5SjRqL2tFdnVl?=
 =?utf-8?B?RUpHWFpLbjZVS2dSOEk5TUdRT3FUUll3Skt6WUk2aEJTSGQ1TFRUMjEvSE5X?=
 =?utf-8?B?TXdTQ1l5ZHNOaTQ5ZDRYaWNLQ2NiNitaRjl6RERiclBpQlJuMHhoTmJ3RWhJ?=
 =?utf-8?B?MytKZk9nYm5mTjd0OHJxS3ZiUW9ncFJBUkNyb25Gbkl2LzZlSi81bUNKSDRN?=
 =?utf-8?B?QS9QNllrTnh1eXBLaVpEa1o2Ym9qVkZWbjVqdmIrZHoyN09Cbm9KMEVyV2dx?=
 =?utf-8?B?WXNUOEtkOXRXZWRNSUdqb29GZ2hKZXF5RFR5cGNNcFR6c1dDVGpHZ05ab1N0?=
 =?utf-8?B?S0F0eS9iMHR2clB3eFZlRkxpdVAyZ1pTOEdGRDdUbVE3YTdwaFlBb3VqZ1Zr?=
 =?utf-8?B?N3NGZnB5bUgvUW5OaUxlL0pJWmRqcHhOQS9hcS9pM0V3OWhtMXlraEpKdHhJ?=
 =?utf-8?B?WnlacHZ3cTN2eXFaNTBNaDdET1M2T2VvNUM1RUJ4OW1SbnZIR0NaQ3RNOXRC?=
 =?utf-8?B?MkxlZVRtRkFydFBtTGFtdHMxTXVXcEcvVXVsWms0a1BZNUFyLzBtWXhhNzJx?=
 =?utf-8?B?YkNHQisrUFJHS3g4WjdFbUpLdlpXR2R6VWF3R0dVTDVKZml4bG04cXRQQW1y?=
 =?utf-8?B?a0pLUE12eTFsU3dlZ244N1k3LzJWYUwyUjdQOVdlandjMm1kRW84cVVLYUhT?=
 =?utf-8?B?djNVK0ZSMCtXclAySjhXNitVN2lnZ0NlcStSWWRMZkg2dUJ1QkJ1ZFcxdm9R?=
 =?utf-8?B?K1BJVXV4OEZpSExoYS83NzZienZkeWVNdGs4YXZzbEhZbGo4TXM4WHNrQUdT?=
 =?utf-8?B?SUZlbGh1Z0FhdGpBVzlZYzdNWFkvVzAxaWVYV2F6SU5OcFJwKzQrNm1Qa0Vo?=
 =?utf-8?B?L3BFckFDdVRuZGNCUjh0ZGZMQllYL1lxYVRxZHFzWUVWTkx1THh1eXdFUEl2?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B02D811A3D6CE47B6DB919810922A10@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91af41e-1eb7-42f2-1e98-08db15ac4ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 14:43:20.1099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2AgwsOg05NFS9NhWx28t/bL7aBN4qcnZC6dcmcTZMSziWOLr34fmRTnG3m49c04z6eXV7CFotum9SkO1zt5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7270
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2theSwgSSB3aWxsIGFkZCBhIGNvbW1lbnQgaGVyZSBpbiBuZXh0IHVwZGF0ZS4gOikNCg0KT24g
VGh1LCAyMDIzLTAyLTIzIGF0IDE4OjMyICswODAwLCBaaXFpIENoZW4gd3JvdGU6DQo+IEhpIFBv
LVdlbiwNCj4gDQo+IE9uIDIvMjIvMjAyMyAxMTowNCBBTSwgUG8tV2VuIEthbyB3cm90ZToNCj4g
PiBOZWVkIHRvIGFkZCBvbmUgdG8gTUFYUSB0byBvYnRhaW4gbnVtYmVyIG9mIGhhcmR3YXJlIHF1
ZXVlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBvLVdlbiBLYW8gPHBvd2VuLmthb0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYyB8IDIg
Ky0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYyBiL2RyaXZl
cnMvdWZzL2NvcmUvdWZzLQ0KPiA+IG1jcS5jDQo+ID4gaW5kZXggYTM5NzQ2YjJhOGJlLi41ZDVi
YzBiYzZlODggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMNCj4g
PiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYw0KPiA+IEBAIC0xNTAsNyArMTUwLDcg
QEAgc3RhdGljIGludCB1ZnNoY2RfbWNxX2NvbmZpZ19ucl9xdWV1ZXMoc3RydWN0DQo+ID4gdWZz
X2hiYSAqaGJhKQ0KPiA+ICAgCXUzMiBoYmFfbWF4cSwgcmVtLCB0b3RfcXVldWVzOw0KPiA+ICAg
CXN0cnVjdCBTY3NpX0hvc3QgKmhvc3QgPSBoYmEtPmhvc3Q7DQo+ID4gICANCj4gPiAtCWhiYV9t
YXhxID0gRklFTERfR0VUKE1BWF9RVUVVRV9TVVAsIGhiYS0+bWNxX2NhcGFiaWxpdGllcyk7DQo+
ID4gKwloYmFfbWF4cSA9IEZJRUxEX0dFVChNQVhfUVVFVUVfU1VQLCBoYmEtPm1jcV9jYXBhYmls
aXRpZXMpICsgMQ0KPiA+IDsNCj4gDQo+IENhbiB3ZSBhZGQgb25lIGxpbmUgY29tbWVudCB3aHkg
bmVlZCB0byAgYWRkIG9uZSB0byBoYmFfbWF4cSAgaGVyZSBvcg0KPiBpbiANCj4gY29tbWl0IG1l
c3NhZ2U/DQo+ID4gICANCj4gPiAgIAl0b3RfcXVldWVzID0gVUZTX01DUV9OVU1fREVWX0NNRF9R
VUVVRVMgKyByZWFkX3F1ZXVlcyArDQo+ID4gcG9sbF9xdWV1ZXMgKw0KPiA+ICAgCQkJcndfcXVl
dWVzOw0KPiANCj4gQmVzdCBSZWdhcmRzLg0KPiANCj4gWmlxaQ0KPiANCg==
