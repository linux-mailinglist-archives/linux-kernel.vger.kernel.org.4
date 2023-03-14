Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD36B88FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCND3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCND3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:29:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96F10EF;
        Mon, 13 Mar 2023 20:29:14 -0700 (PDT)
X-UUID: 6152d0a2c21811eda06fc9ecc4dadd91-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YB3yxUOsQmhtjVAdLcEVGQ6CFjaKhKCpaCeu6BBWLso=;
        b=Jww+WMSsyTaTfw+H/Yr3XjiAFSyjsOfs7mjeuZhv2/tLtC50KGDuld/zuvWaMHge/i6CvtVPKQ0tjvgHOQivUQpRO68u7ZY2J1z+X/CBkXO/OLC04nWp/9Nrt1Pe2wtikWjUBZstQL+WVrWRuQG7HkVSR6hUniJ2gBBXsIguQo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:bc4f029e-8dda-4c9c-b4a1-910770f18cb5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:8733b5f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 6152d0a2c21811eda06fc9ecc4dadd91-20230314
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1523126268; Tue, 14 Mar 2023 11:29:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 11:29:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 11:29:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ7pR3zfift5BGgtmLAT68Xppmy9vvFiwCwC67rVF1F99IXqdZcYUWc9F56blv9qVlh6dYJmg8N72S38d10ztyBCQFKbUm89Ls231ihEP8ux/146ak4vjmxCk0myxgzZ8FWooCBFnZRrPl/WpDtBldNdUV5DSAEYxAjstGF4GpkkCSQhS8rDIeQDkeXNSxpaNRBuxlNPx/8rhpyRuVXbEQEo7SrFfiHZK7mX1eh6JCCbRxSZz4uMJwTazdm7xOS5PvUG0Fpx1NPZ60dTLgdvSQXzi/UUIGzLSrWItaakx0syMsH1yrGNs0X98hY5fJsfjCAEemT/vJlGoqC3lZlVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB3yxUOsQmhtjVAdLcEVGQ6CFjaKhKCpaCeu6BBWLso=;
 b=TiLeFQUtrePGqJ06ibrDMhZSuaMx6XDgHKw/zIWHjm3+bzAGEwbdfOq+K8OVOg8Ne8RC2SVWSojSYVm8HRInm5xfAbtN5tXJl6m2dNmeD4I9sGQ0jxsswc0goFzL/GrdRBLCZjcGKsHEk6q8LG8PqhjbSAZJsAghriLsG0bfnBhgC3XgVcllAEP1FrUhn2sy8KxBv6/I4Ao/YcQtnhOZ/f8DRBlsl+IRn4UJRNVaz6RrTjQdc7njQdS9AKD0MTUrpJcy/IYCbFvQ9ryMWnxA8EyAu61jbRrqkVJsLc71UigjeYXQakTYmeUZVkWyE1ktSQ/Ic/AKoHs8oPnJ6d4kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB3yxUOsQmhtjVAdLcEVGQ6CFjaKhKCpaCeu6BBWLso=;
 b=i9C1NuPcypRmkTZyt0GhwgPBV1I+xQb3vZmCBaC6mteZ1Qkmwre0H32Bj6cRrcvUH18KttkXv2OfoRyJkwrYTnIVUejdRC3gjSuxlnBL3tuJzAhdj2pIhNfbpKJ3srEt+A1TuD1bYFmrctxc+zzpSfgY2pS1uUO1UwmCdewFciQ=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by TYUPR03MB7031.apcprd03.prod.outlook.com (2603:1096:400:35a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:29:04 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:29:04 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
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
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>
Subject: Re: [PATCH v4 5/5] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Thread-Topic: [PATCH v4 5/5] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Thread-Index: AQHZUMHeiTtckt+rnE64S7y815hYyK75RjeAgABigwA=
Date:   Tue, 14 Mar 2023 03:29:04 +0000
Message-ID: <15ad91681f8f7981ff0be9702a3026ec6c0239e7.camel@mediatek.com>
References: <20230307065448.15279-1-powen.kao@mediatek.com>
         <20230307065448.15279-6-powen.kao@mediatek.com>
         <5d317f56-b1ba-e35a-a558-e462a70a4717@acm.org>
In-Reply-To: <5d317f56-b1ba-e35a-a558-e462a70a4717@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|TYUPR03MB7031:EE_
x-ms-office365-filtering-correlation-id: 82c5edc5-4f35-42f7-77ca-08db243c4310
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUnrCuGczc7LDWyc9nJ22y1e4ER9EJHOnQ8v9ss5XDUtWvt1KbmgkT67WDvJvfGqWM/9qb9QYUuftFWVN/yaD7tY9AdbwFRqXf//iTt0tDmyti8oDdfaZjNNxCwIWpyFpkmwzIKqPPi2v8jWKLCJmr8wBGU/DKsoE4/XnPb93mxFNn3S9w6WKkRvlha9BCXeN0c5oqqYtriGEZbIjjZoZ+GUVDDxYwGRwWPckiavwCqajbyHKJ1HBrpSipUTl77GG4nmF/0vVGFcWG4fFJRg2xXuQJ6yQ1JSoEsN2FjbCNeq31GrXG/MV0n57plwkiSW2uOUsZrlfvXLWvr23Q1tG64CtzFQCI291S5r1/GzMXdq8+CDSiPqKxMt1avBIHdgP4dP0/J0UyJOj2V/VnXw8Q/IL9wmGEOU6H2VE8X304yDlOlkRrD2rl7x7KsxSSt/zMjJ6mEEYGA4s9kEm33uBfOSaVkAXYSBLk2CedVf2yNOPqst4Zql10biZqwjQfm8CRA1+z53u55UF7dRbf41RdmZ3CHMIA/li5AHQAVUL6Nc0PTRU21jwawdMssjNjY5YTEWRwY+eVop/nx+pQ56+AY7oszqzZk0MzjZ9mbMNyq5TsUZeco04vJEfGW5P7zEp5V1ZK+nrZAFDRQA+C4qXExQTv15RAaYQb4F1x6mDcMPzQITRtvWGyEnBcR7n7FtSeZh4YBmvVmnKq6JTaz5oBfUwVVGNi0CiGLSZHQGyTBth9qLfE0Y4i67O6C28qDmCnRQS0OWPLE6w1Fh5ws6Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(71200400001)(2906002)(41300700001)(8676002)(76116006)(66446008)(4326008)(64756008)(66556008)(85182001)(36756003)(66476007)(316002)(478600001)(54906003)(86362001)(66946007)(110136005)(122000001)(38100700002)(6486002)(38070700005)(5660300002)(53546011)(6512007)(26005)(6506007)(2616005)(186003)(107886003)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1Qdi82bkRQT0RMb01CamZ4VEdxSEtVbHZXK2V2c0hBRXNPeDhZZ2YxY1F1?=
 =?utf-8?B?NS9aWC9Sa1M3VWNlREIzQ0ZLQVBYYlZCWjNDQjNFZXlmVVBaZENVbWRZcHpz?=
 =?utf-8?B?Mk95TkxORzhsUGlDdW8ycGlyNis3RFkrV3ArcFJrLzhzNHErVmhSQi95ellM?=
 =?utf-8?B?Q0ozSllIakF0VEt1SDNLeUROd3pnMzV0QkM2dlRncCsweVgySGY5RWlkOXI1?=
 =?utf-8?B?TjBZczhIWnR1eUFYWWVsSUU4S3lsa0lzOG1mRUJsVExkbjJMLzFKYldHNkxB?=
 =?utf-8?B?aklaQ0VDdzdDYkRjVDBQMGZ1ZUJDeTZUemhWbmtHbXg2c25IalFRT2xYVE9j?=
 =?utf-8?B?UklOdDJwbktLQnBaQWtnTzdnNnNpbVVSd2lUYzJIU1ZrUmdlNUFlclE5aFpw?=
 =?utf-8?B?SEN4YWt2SjhCTzROTHRZV2RZL3dkc043REhoYWEvWnI0NkRlSG9qV09ZQ3hn?=
 =?utf-8?B?Q0RnRlp2dW90WDNxWll5ZVFVbERTR09SRjcwNlRTeEJwQ21DQWJvYS8xOVJD?=
 =?utf-8?B?MGkxVVg1Ky9JL0hQdW44Ly9kV3FVMUg2aUttcDBoeTdQc1BjWnBQaEwxOHBn?=
 =?utf-8?B?VTZKaEk3d0Vocll1VGNOQ3JvRVRYbW51bnJkZmZLUkRWNEhJWkN5ZXpDbExR?=
 =?utf-8?B?VzM2SmpiMlNoNXBya3lpWmgrM3hGNEI3QTlid1VOWnE3My9VYkdtUzF0b09w?=
 =?utf-8?B?cklIYk80RURtRlpETDR5N2g0ZEgzVTJTWXltdy94aWM5bHdxRFNyMUZDQTl1?=
 =?utf-8?B?Zml5dXNrdy9mbFM4R1o5UHd1VVhZM2JscTE2ZUY1cHVZOEFPNGJpYnozL2R5?=
 =?utf-8?B?OG5QL1NWYUZnU1Jsd01NdDFjQXVMTlMyVi9TOTRzVUQwU1lJbDlxd1pFb3Jv?=
 =?utf-8?B?NnpQMTViVFZFUExPM2pMYnFsMDhad1FSc0NKeU5rUi9LOFh3TFpmMytaVjdJ?=
 =?utf-8?B?REtJenlNWElISXE0azB5RXV4djFBQW9RVWhkM0JRT2FWS3hIaXRsbUJkaERC?=
 =?utf-8?B?ci9BR0liRVR0Umw5UXRIVlhjWFFBL29LbWtCQzVaWlczRjNzL0UrcHVoTnEr?=
 =?utf-8?B?NnFBQjlBQ2MrSDFEZkRmRllxbE5hSWtRcWNWdityTGloMVZwRGZJcjUxQWky?=
 =?utf-8?B?Yy9lZTZTWEZwZ3U3TmthYnRMR1V2NFRQaGRpUENJSzQzb2VLcENoQ0xxblky?=
 =?utf-8?B?aGxwdXJpVER6cm8zdkVGajl6SlFFUkIxRng1dmQ3T1FYVmxpMG9aWVJEbHd1?=
 =?utf-8?B?L0RJc2xFaWUxUlQ3Z3JkbkpuYlNrb21hcjRQTXdnak5OaE9BSFRYQ0FqTmRN?=
 =?utf-8?B?TVlENlUxbWFSbTlmVTduTkV0anU4K1RHVFUyN0RoNkJNNXNrbFNHNk5US1Y2?=
 =?utf-8?B?L2lVNVRKeHkwNjVkbVdHMmhtS1lubFBrTW84ZVBuNi9ZNE1JTHlOUVZpQndr?=
 =?utf-8?B?NUxBbEpPV292UzBkRTVGWWJDQWlvZnBkZE9vVzlFQkZ6cTRIRm9EYUZEc3FR?=
 =?utf-8?B?U3I2Vk9UUjVCRFJ4aUVXeWF0QSs2OWR6YitaKzIvWnZKMjJPa09hVVQ4RE1C?=
 =?utf-8?B?SGViN0NsdVQ0LzRSNnZpMW04YzZmdHZTbWwwR2ZnRXpuLzFKRU83RUp0MW9u?=
 =?utf-8?B?TXVqWFdJN2w5cjRGelVEUjVpQTJqY0Q0aTd2a04yblZzc1dHZzBnOThpd0dq?=
 =?utf-8?B?dGxBblprWEhUWnAwWFdtQ0dsNG10S2FYTWYyTjZGZnRSNnZrZDdzV1R3clVX?=
 =?utf-8?B?MVpzYlZmL2lqandZQ2NoMFBEZTU0UERPR283UmVTV2RkVW5WSGp3dHdwaUVQ?=
 =?utf-8?B?eGdJNEk3Ykp6Mm5UM29XMkF0ZGU3N2xLbmhmSWV6dXdUejlwdHUvSzRyNU9k?=
 =?utf-8?B?SDFjUzIvVDlvTk5MOFZEdW9zUXlhZ1RPYzVpN2c2Q3JRaVZxWi9CazQ0Y2VI?=
 =?utf-8?B?ejVyNG83ZU1NUnNad0dUU3NFZytSYzh0MkN0L2s0VUxtZ0lxS2xMR1ZzSFdQ?=
 =?utf-8?B?NzVybzA1N1g5R2d3NW5SR1lIdDczWWhCa29TbTM3ZVBxTXRUSytlN1VFOEJQ?=
 =?utf-8?B?YmZkb2M5RUZDVkRuMjB0MitYazF2UEV2KzVzU3ZiQmJzUklqN2c2Nk9KR3oy?=
 =?utf-8?B?S1dSazVvSlcwZFQ3blJ2a1MwdU9TN3V6OWJSMEtoZU5PRmN2cUk0SGhzTXRl?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1C65DD2291CC74BB3EE8597137594CD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c5edc5-4f35-42f7-77ca-08db243c4310
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 03:29:04.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSbG0HAfIVI/SrZqqN8oqTM5CDgF+Jg7F+VMK6mElfar3TMCk9bmygjn4I4X50UcZ1neyPBw68Hcou19k0XBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7031
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE0OjM2IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIDMvNi8yMyAyMjo1NCwgUG8tV2VuIEthbyB3cm90ZToNCj4gPiArc3RhdGljIHVuc2ln
bmVkIGludCBtdGtfbWNxX2lycVtVRlNIQ0RfTUFYX1FfTlJdOw0KPiANCj4gU2hvdWxkbid0IHRo
ZXJlIGJlIG9uZSBpbnN0YW5jZSBvZiB0aGlzIGFycmF5IHBlciBjb250cm9sbGVyIHN1Y2gNCj4g
dGhhdCANCj4gdGhpcyBkcml2ZXIgY2FuIHN1cHBvcnQgbXVsdGlwbGUgaG9zdCBjb250cm9sbGVy
cyBpbnN0ZWFkIG9mIG9ubHkNCj4gb25lPw0KPiANCg0KVHJ1ZSwgSSB3aWxsIGZpeCB0aGUgZmxv
dyB0byBnZXQgaXJxIGFmdGVyIGBzdHJ1Y3QgdWZzX2hiYWAgaXMNCmFsbG9jYXRlZCBzbyB0aGF0
IHRoZXNlIGluZm9tYXRpb24gY2FuIGJlIHN0b3JlZCBhcyBwZXIgaG9zdCBpbnN0YW5jZS4gDQoN
Cj4gPiAtCWVyciA9IHVmc2hjZF9tYWtlX2hiYV9vcGVyYXRpb25hbChoYmEpOw0KPiA+ICsJaWYg
KCFoYmEtPm1jcV9lbmFibGVkKSB7DQo+ID4gKwkJZXJyID0gdWZzaGNkX21ha2VfaGJhX29wZXJh
dGlvbmFsKGhiYSk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXVmc19tdGtfY29uZmlnX21jcSho
YmEsIGZhbHNlKTsNCj4gPiArCQl1ZnNoY2RfbWNxX21ha2VfcXVldWVzX29wZXJhdGlvbmFsKGhi
YSk7DQo+ID4gKwkJdWZzaGNkX21jcV9jb25maWdfbWFjKGhiYSwgaGJhLT5udXRycyk7DQo+ID4g
KwkJdWZzaGNkX3dyaXRlbChoYmEsIHVmc2hjZF9yZWFkbChoYmEsIFJFR19VRlNfTUVNX0NGRykg
fA0KPiA+IDB4MSwNCj4gPiArCQkJICAgICAgUkVHX1VGU19NRU1fQ0ZHKTsNCj4gPiArCX0NCj4g
DQo+IHVmc2hjZF9jb25maWdfbWNxKCkgaW4gdGhlIFVGU0hDRCBjb3JlIGFscmVhZHkgY2FsbHMg
DQo+IHVmc2hjZF9tY3FfY29uZmlnX21hYygpLiBXaHkgaXMgdGhlcmUgYW5vdGhlciBjYWxsIHRv
IA0KPiB1ZnNoY2RfbWNxX2NvbmZpZ19tYWMoKSBpbiB0aGUgTWVkaWFUZWsgZHJpdmVyPw0KDQpN
Q1EgY29uZmlndXJhdGlvbiB3aWxsIGJlIHJlc2V0IHRocm91Z2ggSENFIGN5Y2xlIG9uIG91ciBo
b3N0DQpjb250cm9sbGVyLCBoZW5jZSB3ZSBuZWVkIHRvIHJlY29uZmlndXJlIHRob3NlIHJlZ2lz
dGVycy4gDQoNCj4gDQo+ID4gKwkvKg0KPiA+ICsJICogRGlzYWJsZSBNQ1FfQ1FfRVZFTlQgaW50
ZXJydXB0Lg0KPiA+ICsJICogVXNlIENRIFRhaWwgRW50cnkgUHVzaCBTdGF0dXMgaW5zdGVhZC4N
Cj4gPiArCSAqLw0KPiA+ICsJdWZzaGNkX2Rpc2FibGVfaW50cihoYmEsIE1DUV9DUV9FVkVOVF9T
VEFUVVMpOw0KPiANCj4gVUZTIGhvc3QgY29udHJvbGxlciBkcml2ZXJzIHNob3VsZCBub3QgY2Fs
bCB1ZnNoY2RfZGlzYWJsZV9pbnRyKCkuDQo+IA0KPiAgRnJvbSB0aGUgVUZTSENJIDQuMCBzcGVj
aWZpY2F0aW9uOiAiTUNRIENRIEV2ZW50IFN0YXR1cyAoQ1FFUyk6DQo+IFRoaXMgDQo+IGJpdCBp
cyB0cmFuc3BhcmVudCBhbmQgYmVjb21lcyDigJgx4oCZIHdoZW4gYWxsIG9mIHRoZSBmb2xsb3dp
bmcNCj4gY29uZGl0aW9ucyANCj4gYXJlIG1ldDoNCj4g4oCiIENvbnRyb2xsZXIgaXMgb3BlcmF0
aW5nIGluIE1DUSBtb2RlIChDb25maWcuUVQ9MSkNCj4g4oCiIEVTSSBpcyBub3QgZW5hYmxlZCAo
Q29uZmlnLkVTSUU9MCkNCj4g4oCiIENRRVMgc2V0IG9ubHkgZm9yIEV2ZW50cyBpbiBRdWV1ZXMg
dGhhdCBkbyBub3QgaGF2ZSBpbnRlcnJ1cHQgDQo+IGFnZ3JlZ2F0aW9uIGVuYWJsZWQgb3IgdGhl
IEV2ZW50cyB0aGF0IGRvIG5vdCBiZWxvbmcgdG8NCj4gTUNRSUFDUnkuSUFDVEggDQo+IGNvdW50
ZXIgb3BlcmF0aW9uIGNyaXRlcmlhLg0KPiDigKIgQXQgbGVhc3Qgb25lIGJpdCBpbiBDUUlTeSBp
cyBzZXQgYW5kIGFzc29jaWF0ZWQgYml0IGluIENRSUV5IGlzDQo+IHNldC4gDQo+IHk9MC4uMzEi
DQo+IA0KPiBJcyB0aGVyZSBwZXJoYXBzIGEgYnVnIGluIHRoZSBNZWRpYVRlayBjb250cm9sbGVy
IHRoYXQgY2F1c2VzIHRoZSBNQ1ENCj4gQ1EgDQo+IEV2ZW50IFN0YXR1cyB0byBiZSBzZXQgaW4g
RVNJIG1vZGU/IElmIG5vdCwgY2FuIHRoZSBhYm92ZSANCj4gdWZzaGNkX2Rpc2FibGVfaW50cigp
IGNhbGwgYmUgbGVmdCBvdXQ/DQoNCldlIGRpZCBub3QgaW1wbGVtZW50IEVTSSBhdCBoYXJkd2Fy
ZSBsZXZlbCBidXQgcGVyIHF1ZXVlIGh3IGludGVycnVwdC4NCldpdGhvdXQgZGlzYWJsaW5nIE1D
UV9DUV9FVkVOVF9TVEFUVVMsIHRoZXJlIHdpbGwgYmUgdHdvIGludGVycnVwdHMsDQpDUUVTICh0
cmFkaXRpb25hbCBpbnRlcnJ1cHQpIGFuZCBDUSBUYWlsIEVudHJ5IFB1c2ggSW50ZXJydXB0IChw
ZXINCnF1ZXVlIGh3IGludGVycnVwdCksIHJhaXNlZCBvbiBhIHNpZ25sZSBjb21tYW5kIGFycml2
YWwuDQoNCkkgd291bGRuJ3QgY29uc2lkZXIgaXQgYXMgYSBidWcsIGJ1dCBkaWZmZXJlbnQgaW50
ZXJydXB0IGRlc2lnbi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQo+IA0KDQpUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3DQoNClBvd2VuDQo=
