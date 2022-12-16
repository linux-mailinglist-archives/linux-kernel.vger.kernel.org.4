Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAACD64E614
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLPDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPDBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:01:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448005E092;
        Thu, 15 Dec 2022 19:01:15 -0800 (PST)
X-UUID: c85e0e349a2144d1895e21f6d81d41a7-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6OotgizEZLjvtRBBH5xizEdXYZ3SVYtf6X2M5ZQKVFg=;
        b=VwgZLjtSzexCBofIjxN5PYlD+wRiUTwEZrYuZp/Wh147l5P70FmrOe4OKS6xqCKLew/BUucNhA0dClYHLGFr6lIwDfFOsShmpdnNbk1Ah1H5WjQc/WM/uAPlraAUxedbjEzuvxA7DTyOzkLzrVRJisnXDSMAbHLRXTQj2l6dxbI=;
X-CID-CACHE: Type:Local,Time:202212161059+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:12ff274c-18ce-44d0-870d-21576ea94575,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:1c366535-a6a3-44f7-8aad-08fee1939a08,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c85e0e349a2144d1895e21f6d81d41a7-20221216
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 779969668; Fri, 16 Dec 2022 11:01:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 11:01:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 11:01:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0I90P0gySpBKrDTyHvhPmz5mD6jSrUAsvHbjB/mVw/ZwHaAaX008P5rWBbbzPyjYoJHt+5NOrzGC1/WsYV76twrg7vPPfLAlIct09CbwHlQODKCIaW1ehZ6keSWYBuqwrlD3CXSJBevRtBXW8U94J5C8+nQBILVN5StrzgNCEM1PDTfX8PHu4u2aJgs+XbTskPa6Xe9G6FOCdVJ4yrk57WPMlsfjtb1HWGVanHzDHZfijdn1WmnTlcufMAiA0V2kWAdMbZmwaz+cytVvPruUh7oP9gTRcKq+Adi4xmcTP86IlmK5z3tcSZIb7XPvGH9Ipz7/gKpPtT6QvCYlDSUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OotgizEZLjvtRBBH5xizEdXYZ3SVYtf6X2M5ZQKVFg=;
 b=H0VpP2nuS9wZvV+/Umtur0HQ4g0lK55VOHPY7+YH7UMVlrkXdpNkHkt98b/NV0oDlTKgHftXqszPD1zXr519adsNKNG5obx5I8tlMI/zZlSex4hRCB68t9lIfRqQyrEfWI9HgNAlI98+hx0vNPgbuXx5+TScUn53s6pYEQZgaGBNXETJSNIPcp4+Z5njBR/QWxWjYJQK3e2AoVARfDqN5X5Hn9wjFxzOvRYL3nR4zPrJQUsmc77kFWOfjErWF4ZVPWhIjdAaOGrATF0CuUtsNi4X3ykRhGY5JGdn2O9xeYewgSqk/Y8jhWKa42HF8kp1zS3OAgzfkdh4ecRHc7Nt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OotgizEZLjvtRBBH5xizEdXYZ3SVYtf6X2M5ZQKVFg=;
 b=hPEswPWjLPXQnlk6BV78+cEWCBFWc5bGtcB2TqHFQKSBgCTqReuMGggr3x1+adQdPF2pdkaep0wwGV6F5pS25EcaWHuntdmG31AfTFmDn0x1V6ewCyVGJ4e54OxVQAlHKe6/w+Y8ssF6AC69SPTxs4r/Dm2c75c+lZEh8+u+k3g=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by SI2PR03MB5857.apcprd03.prod.outlook.com (2603:1096:4:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 03:01:07 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::1034:e90c:9e7f:2b5f]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::1034:e90c:9e7f:2b5f%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 03:01:07 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Topic: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Index: AQHZEGfw5aBxnSQoE0mwMolHiJ6SI65uxT8AgAAFcwCAAQnGgA==
Date:   Fri, 16 Dec 2022 03:01:07 +0000
Message-ID: <84660dde69fcf0293abacb922521c26329fc63f7.camel@mediatek.com>
References: <20221215093026.12322-1-irui.wang@mediatek.com>
         <1895ff3f71fe7fe6c228d76dd046ea4f43b3dbf5.camel@mediatek.com>
         <9a7434ba-2d42-cf15-334b-637b5f1b01a3@collabora.com>
In-Reply-To: <9a7434ba-2d42-cf15-334b-637b5f1b01a3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|SI2PR03MB5857:EE_
x-ms-office365-filtering-correlation-id: c97ac2d0-d7fd-4382-0d94-08dadf11c74f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikAsZTrzlOsIJMzZM2wbleVw45nxFCLzk+e4GQ4TQbdhwWpLv8a2ZEDgdNoTH3twQdb+NmUvWG8gC2YNZZoYtU/pJgGN0cpYLQpcaa1BHXn0vmy8JPYuleerltaTrut2UL7hjzMI17N6wnpVQxxFMktSG7ZeCKLBls1N+Nv86sWS1zgo5fMMyolhnQhOmcIi5Ree4q1mEx/yXOW1HGp1mg6mqOoIHV9PSC3/Eo6q7gWFSPo7ylgYvOp2oMKbwtxerOvL5z9ccXGZs7wK9sioOQq1BblWug3OhNsqMddWO9c49xdogiiwtovr5I9sfU8KpVhDdFmTejGi0Jn1YxBEpXL8CHYmVA3dveUZA14ir3Vso0FybNdYsshcoj8MLS6H0FVAXfjN/Iev2tohUgfbaH3eB9yuDOx+4ycXdDarPPLCiDHLyRpGzmfdEwSPyInrI57FjN5x4+QTV1xSAb3LeKugpxoxwv3wrw7dZFD/lLfaTP7n4IPwXE6NGyVmWUsnq3rTvk+7lmuP/nYa+Ql9M+TYVxywWVW1JhGhLqi2lm8zu7wv7EleloXDpcGitvTg2JHZVjgwUGDMgXfq12hORlBolVHMstgKcGCS8ZCuwHaKC/Xzye0tuSRzNJo7REOpXSPYugsbbZHoC8mZceGtuZDtQKmmTYVhkpFVS1u777X9XPzGV8AlGLi1hcHD/Kg+OGWNiy+Cu09owTYDtWx/7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(66476007)(66556008)(71200400001)(6512007)(5660300002)(86362001)(41300700001)(76116006)(26005)(91956017)(4326008)(64756008)(8676002)(66946007)(186003)(2616005)(66446008)(478600001)(6486002)(54906003)(107886003)(110136005)(316002)(122000001)(38100700002)(38070700005)(6506007)(83380400001)(7416002)(8936002)(4744005)(4001150100001)(2906002)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGozMnV3NEZ5amY3Sm14REhZd3pMVXg1aVYyaUFSdFBnajlZc0gvQnBwVDFB?=
 =?utf-8?B?Ykg2L3BQK3I1TlF0ODZFbENMWVpJMUI1MUJDZkdpd2I2a1VyQUc3ZTlkQkxn?=
 =?utf-8?B?TGxjWTVQRmdVZklBV0ViRWpGRThUdEx1N1BpMncyLzAzbkh0N1lpRnNacVky?=
 =?utf-8?B?ektXOHd1TFloaGpwL1lIT2VlQytVYlVqdk11M0tSV0tIdWM4bjd6MGtIVUR0?=
 =?utf-8?B?eU40eWNvaGI5QktYczBDZ2c1Mjh1ZDZGdzJrQitTQUhBc0thZkRUUFpVUzNE?=
 =?utf-8?B?S1pCZVdFdnlOSlc4UzZ1M21SWXRORkRFK3N2UjJzM3lqZzBQelptUXpmRTc3?=
 =?utf-8?B?RmNkNE1xeFFsVTRDMkMwL2ViZ2FKSVpoQXdxc3dSWjc5TzZ3OU5HYWJWR0Iw?=
 =?utf-8?B?QXBkZmtPa3Ezd1Qyblp2R3o3dFdqaUp6aDFqMEJoL0N3VHd2SWpFOTdjaGRZ?=
 =?utf-8?B?cXYxY21mOE5RUk9CYWhmZktkQW9WZ0hpMkZpSDFwS2ttTzdlMDhwRm1nbkhz?=
 =?utf-8?B?QXcyL014amUyNXI3bk12cUUzeEhaUUFzS3lKRHphS2NRdnlEMlM1TmZ1dkNm?=
 =?utf-8?B?d3JMUnJHeEUybXdubWt6L1ZtRGZjQWNadXZrdkR4WU1mc2xDUmsraHI5L0V1?=
 =?utf-8?B?MWtSM0JUbnhkQkc3M1FuWDdPRFpic09TWmNQKzJCTjFNM3B4OXpDRytzTGNO?=
 =?utf-8?B?ZHRqbjRxc2F5cGFESTBlSkxjdWVyTUtsRkpwckhGc04yU3NFM0w5dlE2Tysr?=
 =?utf-8?B?S244TTRFMS9UUEFJUnVtakgxUmYyQ3dSUVlHVkJCSm05MkN0L2huWkZycUlo?=
 =?utf-8?B?TTdENUo3T1Zvd29MbHpWRDRPYmI1ZU16aHBLVDJTMnJDZVF0Nkc2cDNHTUt6?=
 =?utf-8?B?MlNpMmdsbHRtQnQyUnNJQUdweG9wOTh3WHJ4My94bGNvd21xMG41Q3pBTXVI?=
 =?utf-8?B?blYrYmM3ZFBGVFhJSVFyMldoaFM3aGxBQTd1Zy9heFJIQmhYdEQvWWlVOVRY?=
 =?utf-8?B?dlo4ckNJaU4vVmM0U01sKzIvRUsvb01DdkRLYjlXdU9pV0o0WkpETm5aQzFL?=
 =?utf-8?B?TWJ1Z3F2Q21EL1NCNzFnQ3BnMWRIeVhiS0dzaS9ROFVBalRLY0VxTU5nZVJq?=
 =?utf-8?B?UkxxQ29LejJhelZ1b3ViTHg0Y2tnSHBtTGlzZFpQSG1BWEdzVEoyWUU3dHgx?=
 =?utf-8?B?MU5FQlNjVzFUUzdJU3dGejV4UUlkRjlYWjE0Z3M1bEJxSzVvTE84NEtOUWVS?=
 =?utf-8?B?TEl0NkhXQUttN0owZkpyUUlMUjV1MC9sVHk2K21jUzRSbTlzSm5nTjBuK1JT?=
 =?utf-8?B?NWVyamsyOFBNSmk1WDE4VWlvcG1qMHJCQzlQVDM3bWlkWnBBakJRRUJtUWx5?=
 =?utf-8?B?S251OWY5V1NZWmpiNUpVUG0rMWVBRUNSVm9LanNOVkd4eTNtbjZrcXpUTWlN?=
 =?utf-8?B?blVkY2VBQ0JxZE9oOXpHc0VwaEM3S1hLOHJWVEFUdEhobDhSbEo4a2JCZnpz?=
 =?utf-8?B?dllWYzN2cmpFNmswRG94bmZKYUNEbE5lNUczTVBYR29ZamV4MkFzVVpSOHNW?=
 =?utf-8?B?ZE40YUN1dDR0UFh5YktMUnpyc2ZMQlJxRmRta3YzNFNHNlA2eThxaFhvbTBS?=
 =?utf-8?B?Y0ZSWnBwQ0phUFBVTXRxWHBad0c1dFdTZ253MXdaaXhXampCdUtpSlFqL3kv?=
 =?utf-8?B?WmNpSEcxL0VMOER6Qi9OQ2JSYUlhdURJVDg1bnRwQjhZN0pGV2lQdzlncFF6?=
 =?utf-8?B?N3Z4ajZQamZSRlo5blhONER3aGZnWkZnTXZNWmlRbThHaHJ3Y3p0MXVnYXc1?=
 =?utf-8?B?dnlRZ3k1emxMREMrblI4aDI1MUUxQzRnMDdFblUzMU9YS3hwV01wRXY4ZVRN?=
 =?utf-8?B?ODFKMzYzVmdobkExWXdVdVdDQmxENUVZbTVjM3VPWkF2OXd4TEZPRkdua0lQ?=
 =?utf-8?B?RnZaZXJqVHdVU3hqWUtweWFmdG5aNHZibWxYUnErOWFUcWV0UCtxK1hvcXdF?=
 =?utf-8?B?OVhsbXQ4QkMrY1JTWUNUWkJOV0V1RFpqKytyQ2VEVVk0aklsak9zOHJkaDJn?=
 =?utf-8?B?bmRMUUlsWUhMWm8xSVNmbkJIN3hzaGtIZkJEZnRzTU9IUTVBTnB5ck1KUDVk?=
 =?utf-8?B?OGhxUjJHeEFLU01pb0hUb1NjSkpqZGFJQXZlOTBGMU1CMmdLQmw4aW5EYTIv?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82A0881C3C23414B92839A1CE485C9BB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ac2d0-d7fd-4382-0d94-08dadf11c74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 03:01:07.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vlrxMEvYS3rFIEBePhuDOkm9nsQa/FiTzln75tIIAw66a6LqB8TX4MHYU1jgHsZohmycphqTjXyq/bvpiexwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTE1IGF0IDEyOjA5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTUvMTIvMjIgMTE6NTAsIEpvaG5zb24gV2FuZyAo546L6IGW6ZGr
KSBoYSBzY3JpdHRvOg0KPiA+IE9uIFRodSwgMjAyMi0xMi0xNSBhdCAxNzozMCArMDgwMCwgSXJ1
aSBXYW5nIHdyb3RlOg0KPiA+ID4gRnJvbToga3lyaWUgd3UgPGt5cmllLnd1QG1lZGlhdGVrLmNv
bT4NCj4gPiA+IA0KPiA+ID4gc29tZSBjaGlwcyBoYXZlIG11bHRpLWh3LCBidXQgb3RoZXJzIGhh
dmUgb25seSBvbmUsDQo+ID4gPiBtb2RpZnkgdGhlIGNvbmRpdGlvbiBvZiBtdWx0aS1odyBqdWRn
ZW1lbnQNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieToga3lyaWUgd3UgPGt5cmllLnd1QG1l
ZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IGlydWkgd2FuZyA8aXJ1aS53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay1qcGVnL210a19qcGVnX2NvcmUuYyB8ICA1ICsrKy0tDQo+ID4gPiAgIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oIHwgMTINCj4gPiA+ICsrKysrKysrKysr
Kw0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPiANCj4gPiANCj4gPiBUaGlzIG1heSBjb25mbGljdCB3aXRoIGtlcm5lbCBtYWlu
bGluZSBzaW5jZSBtdGstanBlZyBmb2xkZXINCj4gPiBkb2Vzbid0DQo+ID4gZXhpc3QuDQo+ID4g
UGxlYXNlIGZpeCBpdC4NCj4gPiANCj4gPiBCUnMsDQo+ID4gSm9obnNvbiBXYW5nDQo+IA0KPiBP
dWNoLiBJIGp1c3Qgbm90aWNlZCB0aGF0IHRoZSBmb2xkZXIgaXMgbWlzbWF0Y2hpbmc7IHRoaXMg
ZGlkbid0DQo+IGRlc2VydmUNCj4gYSBSLWIgdGFnLiBJJ2xsIGJlIG1vcmUgY2FyZWZ1bCBuZXh0
IHRpbWUuDQoNCkknbSB0ZXJyaWFibGUgc29ycnkgZm9yIHRoaXMgbWlzdGFrZSwgYW5kIGl0IHdv
dWxkIGJlIGZpeGVkIGluIHRoZQ0KY29taW5nIHZlcnNpb24uDQoNClRoYW5rcy4NCj4gDQo=
